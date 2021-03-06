<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshRoleList($where) {
        $tpl = 'resConf/user/roleListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT role_id, role_name, create_by, create_time, time
            FROM role";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatementRole($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('roleList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function freshUserList($where) {
        $tpl = 'resConf/user/editUserListByRoleIdTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT user.user_id AS userId, user.user_name AS name, ' .
            'user.true_name AS realname, user.auth_type AS authType ' .
            'FROM user, user_role_map, role ' .
            'WHERE user.user_id = user_role_map.User_id AND ' .
            'user_role_map.Role_id = role.role_id AND role.role_id = ' .
            $_GET['roleId'] .' ' .$where;
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);

        $authType = array('免认证', '本地密码认证',     '本地证书认证',
                          '',    '2-fa/ cert+pw', '双因子认证');

        $result   = array();
        foreach ($data as $d) {
            $userId = $d['userId'];
            $sql = 'SELECT ip FROM user_online WHERE user_id=' . $userId;
            $res_online = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            if (empty($res_online['ip'])) {
            	$isOnline = 0;
            	$onlineIp = "";
            } else {
            	$isOnline = 1;
            	$onlineIp = $res_online['ip'];
            }
            $roles = getRolesByUserId($userId);
            $result[] = array('user_id'   => $userId,
                              'user_name' => $d['name'],
                              'true_name' => $d['realname'],
                              'auth_type' => $authType[$d['authType']],
                              'roles'     => join('<br/>', $roles),
                              'isOnline' => $isOnline,
                              'onlineIp' => $onlineIp
            );
        }
        echo V::getInstance()->assign('userData', $result)
            ->assign('roleId', $_GET['id'])
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

    function getSpecRoleDataByName($roleName) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT * FROM role where role_name = '$roleName'";
        return $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
    }

    function getUserCountByRoleId($id) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT count(User_id) AS sum FROM user_role_map ' .
            "WHERE Role_id = $id";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }
    
    function isInUseCheck($name) {
        $sql = "SELECT usergrp FROM acl where usergrp='$name'";
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $num = $db->query($sql)->getCount();
        if(intval($num) > 0) {
            return true;
        } else {
            return false;
        }
    }
    
    function getWhereStatementRole($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }
    
    function getWhereStatementUser($db, $cols, $keyword) {
        $value  =$keyword ;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

    function getDataCount() {
        $db = new dbsqlite(DB_PATH . '/uma_auth.db');
        $params = array();
        if (strpos($_POST['dataCountFunc'], '?') !== false) {
            $getStr = substr($_POST['dataCountFunc'],
                strpos($_POST['dataCountFunc'], '?') + 1);
            list(, $roleId) = explode('=', $getStr, 2);
            $sql = 'SELECT count(User_id) as sum FROM user_role_map ' .
                "WHERE Role_id = $roleId";
        } else {
            $sql = "SELECT count(role_id) as sum FROM role";
            if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
				$keyword='/'.$_GET['keyword'];
                $data   =
                    getWhereStatementRole($db, $_GET['cols'], $keyword);
                $sql   .= $data['sql'];
                $params = $data['params'];
            }
        }
        $result = $db->query($sql, $params)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }

    if (!empty($_POST['addNewRole'])) {
        // Open add new role dialog
        $result = V::getInstance()
            ->fetch('resConf/user/editRoleListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ($name = $_POST['editRoleName']) {
        // Open edit spec role dialog
        $roleData =  getSpecRoleDataByName($name);
        $roleData['userCount'] = getUserCountByRoleId($roleData['role_id']);
        $roleData['always_online'] =
            $roleData['always_online'] === '1' ? 'checked="checked"' : '';
        $result = V::getInstance()->assign('roleData', $roleData)
            ->assign('type', 'edit')
            ->fetch('resConf/user/editRoleListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit spec role
        $cli = new cli();
        $cli->setLog("修改角色".$_POST['roleName'])->run(getCmdStr('set'));
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add new role
        if (getDataCount() >= RESCONF_LIMIT) {
            $msg = '资源数达到上限[' . RESCONF_LIMIT . ']。';
        	echo json_encode(array('msg' => $msg));
        	return;
        }
        $cli = new cli();
        $cli->setLog("添加角色".$_POST['roleName'])->run(getCmdStr('add'));
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "UPDATE role SET create_by=? WHERE role_name=?";
        $params = array($_POST['createBy'], $_POST['roleName']);
        $db->exec($sql, $params);
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        echo json_encode(array('msg' => '添加成功。'));
    } else if ($name = $_POST['delRoleName']) {
        // Delete specified role
        $cli = new cli();
		list($status,$result) = $cli->setLog("删除角色{$name}")
				->execCmdGetStatus("role del rolename \"$name\"");
        //$cli->setLog("删除角色{$name}")->run("role del rolename \"$name\"");
		if ($status>0) {
			echo json_encode(array('msg' => '此角色名称被用户引用，不能删除。<br>要先将此角色下的用户删除，或改为其他角色，才能删除此角色。'));
		} else {
			echo json_encode(array('msg' => '删除成功。'));
		}
    } else if (!empty($_POST['delAllRoles'])) {
        // Delete All roles
         $cli = new cli();
        $cli->setLog("删除全部角色")->run('role del all');
        echo json_encode(array('msg' => '已清空角色列表。'));
    } else if ($roles = $_POST['delSpecRoles']) {
        // Batch Delete spec roles
        $cli = new cli();
        foreach ($roles as $role) {
            $cli->setLog("删除角色{$role}")->run("role del rolename \"$role\"");
        }
        echo json_encode(array('msg' => '批量删除成功。'));
    } else if ($id = $_POST['showUsersByRoleId']) {
        // show dialog of users data for spec role
        $count  = getUserCountByRoleId($id);
        $result = V::getInstance()->assign('roleId', $id)
            ->assign('dataCount', $count)
            ->assign('pageCount', ceil($count/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2)
            ->fetch('resConf/user/editUserListByRoleIdDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ($_GET['isInUseCheck']) {
    // check whether the spec role is in using
        $name = $_GET['checkName'];
        $result = netGapRes::getInstance()->checkRoleUsed($name); 
        if (count($result) > 0) {
            echo json_encode(array('msg' => $result));
        } else {
            echo json_encode(array('msg' => 'false'));
        }
    } else if ($_GET['checkAll']) {
        // check ether role is in using
        $result = array();
        $sql = 'SELECT role_name FROM role';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $nameBuf = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($nameBuf as $name) {
            $checkResult = netGapRes::getInstance()->checkRoleUsed($name['role_name']);
            if (count($checkResult) > 0) {
                $result[] = array('name'=>$name['role_name'],'content'=>$checkResult); 
            }
        }
        if (count($result) > 0) {
            echo json_encode(array('msg' => $result));
        } else {
            echo json_encode(array('msg' => 'false'));
        }
    } else if ($_GET['checkSpecRoles']) {
    // check delete roles is in using
        $roles = $_GET['rolesArray'];
        foreach ($roles as $name) {
            $checkResult = netGapRes::getInstance()->checkRoleUsed($name);
            if (count($checkResult) > 0) {
                $result[] = array('name'=>$name,'content'=>$checkResult); 
            }
        }
        if (count($result) > 0) {
            echo json_encode(array('msg' => $result));
        } else {
            echo json_encode(array('msg' => 'false'));
        }
    } else if ($_GET['checkExistRoleName']) {
         $roles = $_GET['roleName'];
         $sql = "SELECT role_id FROM role WHERE role_name='$roles'";
         $db = new dbsqlite(DB_PATH . '/uma_auth.db');
          echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($order = $_POST['orderStatement']) { 
        if (!empty($_GET['roleId'])) {
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
