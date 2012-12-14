<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getConnectRule() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT rule_name FROM connect_rule";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['rule_name'];
        }
        return $result;
    }

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
            "user_role_map.Role_id = role.role_id AND user.user_name = '$name'";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['role_name'];
        }
        return $result;
    }

    function getUserDataByName($name) {
        $db     = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql    = "SELECT * FROM user WHERE user_name = '$name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
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

    function getAddOrEditCmd($action) {
        $ip     = $_POST['bindIp'];
        $mac    = $_POST['bindMac'];
        $active = $_POST['active'] === 'on' ? 'on' : 'off';
        if ('twofa' === $_POST['authType']) {
            $authType = $_POST['twofaType'];
        } else {
            $authType = $_POST['authType'];
        }
        $firstChangePwd = $_POST['firstChangePwd'] === 'on' ? 'on' : 'off';
        $modifyPwdAllow = $_POST['modifyPwdAllow'] === 'on' ? 'on' : 'off';
        $pwd      = $_POST['passwd_user'];
        $realName = $_POST['realName'];
        $name     = $_POST['userListName'];
        $ap       = $_POST['validTime'];
        $pap      = $_POST['validTime_pwd'];
        $cRule     = $_POST['connectRule'];
        $comment  = $_POST['comment'];

        $result = "user $action username \"$name\" ".
            "auth-type $authType";
        if ($authType === 'local-pwd' || $authType === 'dyn-pwd') {
            $result .= " pwd '$pwd'";
            if ($authType === 'dyn-pwd') {
                $result .= " sn {$_FILES['sn']['name']}"
            }
        }
        if (!empty($_POST['rolesMember'])) {
            $roles   = join(',', $_POST['rolesMember']);
            $result .= " role \"$roles\"";
        }
        if ($realName !== '') {
            $result .= " true-name \"$realName\"";
        }
        if ($ip !== '') {
            $result .= " bind-ip4 \"$ip\"";
        }
        if ($mac !== '') {
            $result .= " bind-mac \"$mac\"";
        }
        if ($active !== '') {
            $result .= " active $active";
        }
        if (!empty($modifyPwdAllow)) {
            $result .= " modify-pwd-allow $modifyPwdAllow";
        }
        if (!empty($firstChangePwd)) {
            $result .= " first-change-pwd $firstChangePwd";
        }
        if (!empty($ap)) {
            $result .= " available-period $ap";
        }
        if (!empty($pap)) {
            $result .= " pwd-available-period $pap";
        }
        if (!empty($cRule)) {
            $result .= " connect-rule $cRule";
        }
        if ($comment !== '')
            $result .= " comment '$comment'";
        return $result;
    }

    if ($_POST['addNewUser'] === 'true') {
        // Open add new user dialog
        $tpl = 'resConf/user/editUserListDialog.tpl';
        $result = V::getInstance()->assign('allRolesArr', getAllRoles())
            ->assign('mpa_on',    'checked="checked"')
            ->assign('fcp_off',   'checked="checked"')
            ->assign('active_on', 'checked="checked"')
            ->assign('connectRuleArr', getConnectRule())
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Open new user dialog
        $cmd = getAddOrEditCmd('add');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($specUser=$_POST['editUser']) {
        // Open user dialog of specified user
        $userList = getUserDataByName($specUser);
        $mpa = $userList['modify_pwd_allow'] === '1' ? 'mpa_on' : 'mpa_off';
        $fcp = $userList['first_change_pwd'] === '1' ? 'fcp_on' : 'fcp_off';
        $active = $userList['active'] === '1' ? 'active_on' : 'active_off';
        switch ($userList['auth_type']) {
            case '0':
                $at = 'vip';
                break;
            case '1':
                $at = 'localPwd';
                break;
            case '2':
                $at = 'localCert';
                break;
            case '4':
                $at = 'certPwd';
                break;
            case '5':
                $at = 'dynPwd';
                break;
            default: 
                throw New Exception('error: Auth Type.'. $userList['auth_type']);
        }
        $rolesMemberArr = getSpecRolesByUserName($specUser);
        $result = V::getInstance()
            ->assign('userList', $userList)
            ->assign('allRolsArr', array_diff(getAllRoles(), $rolesMemberArr))
            ->assign('rolesMemberArr', $rolesMemberArr)
            ->assign($mpa, 'checked="checked"')
            ->assign($fcp, 'checked="checked"')
            ->assign($active, 'checked="checked"')
            ->assign($at, 'checked="checked"')
            ->assign('connectRuleArr', getConnectRule())
            ->assign('type', 'edit')
            ->fetch('resConf/user/editUserListDialog.tpl');
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified user data
        $cmd = getAddOrEditCmd('set');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
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
