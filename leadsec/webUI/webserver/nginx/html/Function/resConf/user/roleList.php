<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshRoleList($where) {
        $tpl = 'resConf/user/roleListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT role_id, role_name, create_by, create_time, time
            FROM role $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('roleList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getOnlineUserInfo() {
        $result = array();
        //fileLinesToArr($_SERVER['DOCUMENT_ROOT'] . '/Logs/onlineUsers', 65535);
        return $result;
    }

    function freshUserList($where) {
        $tpl = 'resConf/user/editUserListByRoleIdTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT user.user_id AS id, user.user_name AS name, ' .
            'user.true_name AS realname, user.auth_type AS authType ' .
            'FROM user, user_role_map, role ' .
            'WHERE user.user_id = user_role_map.User_id AND ' .
            'user_role_map.Role_id = role.role_id AND role.role_id = ' . $_GET['id'];
        $data = array();
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);

        $authType = array('VIP', 'local pwd',     'local cert',
                          '',    '2-fa/ cert+pw', '2-fa / dyn + pw');

        $olUser = getOnlineUserInfo();

        $result   = array();
        foreach ($data as $d) {
            $userId = $d['id'];
            $roles = getRolesByUserId($userId);
            $result[] = array('user_id'   => $userId,
                              'user_name' => $d['name'],
                              'true_name' => $d['realname'],
                              'auth_type' => $authType[$d['authType']],
                              'roles'     => join('<br/>', $roles)
            );
        }
        echo V::getInstance()->assign('userData', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmdStr($action) {
        $_POST['createBy'];
        $_POST['createTime'];

        $name     = $_POST['roleName'];
        $time     = $_POST['allocatedTime'];
        $isOnline = $_POST['alwaysOnline'] === 'on' ? 'on' : 'off';
        $comment  = $_POST['comment'];

        $cmd = "role $action rolename \"$name\" normal time \"$time\" " .
            "always_online $isOnline comment \"$comment\"";
        return $cmd;
    }

    function getRolesByUserId($userId) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT role.role_name AS name FROM user_role_map, role ' .
            'WHERE user_role_map.Role_id = role.role_id AND ' .
            'user_role_map.User_id = ' . $userId;
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['name'];
        }
        return $result;
    }

    function getSpecRoleDataById($roleId) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT * FROM role where role_id = $roleId";
        return $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    }

    function getUserCountByRoleId($id) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT count(User_id) AS sum FROM user_role_map ' .
            "WHERE Role_id = $id";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }

    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT count(role_id) as sum FROM role";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }

    if (!empty($_POST['addNewRole'])) {
        // Open add new role dialog
        $result = V::getInstance()
            ->fetch('resConf/user/editRoleListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ($id = $_POST['editRoleId']) {
        // Open edit spec role dialog
        $roleData =  getSpecRoleDataById($id);
        $roleData['userCount'] = getUserCountByRoleId($id);
        $roleData['always_online'] =
            $roleData['always_online'] === '1' ? 'checked="checked"' : '';
        $result = V::getInstance()->assign('roleData', $roleData)
            ->assign('type', 'edit')
            ->fetch('resConf/user/editRoleListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit spec role
        $cli = new cli();
        $cli->run(getCmdStr('set'));
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add new role
        $cli = new cli();
        $cli->run(getCmdStr('add'));
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($name = $_POST['delRoleName']) {
        // Delete specified role
        $cli = new cli();
        $cli->run("role del rolename \"$name\"");
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['delAllRoles'])) {
        // Delete All roles
         $cli = new cli();
        $cli->run('role del all');
        echo json_encode(array('msg' => '已清空角色列表.'));
    } else if ($roles = $_POST['delSpecRoles']) {
        // Batch Delete spec roles
        $cli = new cli();
        foreach ($roles as $role) {
            $cli->run("user del rolename \"$role\"");
        }
        echo json_encode(array('msg' => '批量删除成功.'));
    } else if ($id = $_POST['showUsersByRoleId']) {
        // show dialog of users data for spec role
        $result = V::getInstance()->assign('roleId', $id)
            ->fetch('resConf/user/editUserListByRoleIdDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ($order = $_POST['orderStatement']) { 
        if (false !== strpos($order, 'user_id')) {
            // Fresh and resort user list Table for spec role
            freshUserList($order);
        } else {
            // Fresh and resort role list Table
            freshRoleList($order);
        }
    } else {
        // init page
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    } 
?>
