<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getAllRoles() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT role_name FROM role";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['role_name'];
        }
        return $result;
    }

    function getSpecRolesByUserName($name) {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = 'SELECT role_name FROM user, user_role_map, role WHERE'.
            ' user.user_id = user_role_map.User_id AND '.
            "user_role_map.Role_id = role.role_id AND user.user_name = $name";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['role_name'];
        }
        return $result;
    }

    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT count(user_id) as sum FROM user";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['sum'];
    }

    function freshUserList($where) {
        $tpl  = 'resConf/user/userListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_id, user_name, true_name, active, validtime, dyn_sn FROM user $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('userList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getAddOrEditCmd() {
        $active = $_POST['active'] === 'on' ? 'on' : 'off';
        if ('twofa' === $_POST['authType']) {
            $authType = $_POST['twofaType'];
        } else {
            $authType = $_POST['authType'];
        }
        $_POST['bindIp'];
        $_POST['comment'];
        $firstChangePwd = $_POST['firstChangePwd'] === 'on' ? 'on' : 'off';
        $modifyPwdAlliw = $_POST['modifyPwdAllow'] === 'on' ? 'on' : 'off';
        $pwd = $_POST['passwd_user'];
        $_POST['realName'];
        $_POST['rolesMember'];
        $name = $_POST['userListName'];
        $_POST['validTime'];
        $_POST['validTime_pwd'];
        $result = "user add username \"$name\" ".
            "auth-type $authType pwd '$pwd' role ";
    }

    if ($_POST['addNewUser'] === 'true') {
        // Open add new user dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()->assign('allRolesArr', getAllRoles())
            ->assign('mpa_on',    'checked="checked"')
            ->assign('fcp_off',   'checked="checked"')
            ->assign('active_on', 'checked="checked"')
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        $cmd = getAddOrEditCmd();
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($order = $_POST['orderStatement']) { 
        // Fresh and resort user list Table
        freshUserList($order);
    } else {
        // Init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
