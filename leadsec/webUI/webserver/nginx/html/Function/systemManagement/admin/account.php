<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function setExpiredTime($expTime) {
        $file = $_SERVER['DOCUMENT_ROOT'] . '/Conf/global.php';
        $contents = file_get_contents($file);
        $contents = preg_replace("@\('EXPIRED_TIME',\s?(.*)\)@",
            "('EXPIRED_TIME',$expTime)", $contents);
        file_put_contents($file, $contents);
    }

    function delSpecifiedUser($username) {
        $cmd    = "admacct del name \"$username\"";
        $cli    = new cli();
        return $cli->run($cmd);
    }

    function getUserData() {
        return array(
            $_POST['account'],
            $_POST['passwd'],
            $_POST['confAdmin'] === 'on' ? 'on' : 'off',
            $_POST['policyAdmin'] === 'on' ? 'on' : 'off',
            $_POST['logAdmin'] === 'on' ? 'on' : 'off'
        );
    }

    if (!empty($_POST['expTime'])) {
        // modify expired time
        @$expTime = $_POST['expTime'];
        setExpiredTime($expTime);
        echo json_encode(array('msg' => '修改成功', 'status' => 0));
    } else if (!empty($_POST['editUser'])) {
        // get specified account data
        $tpl  = $_POST['tpl'];
        $name = $_POST['editUser'];
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT * FROM accounts WHERE account = '$name'")
                     ->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()->assign('account',  $result['account'])
            ->assign('passwd',   $result['passwd'])
            ->assign('isConf',  $result['manager'] === '1' ? 'checked="checked"' : '')
            ->assign('isPolicyer', $result['policyer'] === '1' ? 'checked="checked"' : '')
            ->assign('isLoger',  $result['auditor'] === '1' ? 'checked="checked"' : '')
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_POST['type'] === 'add') {
        // add a new account
        list($account, $passwd, $isManager, $isPolicyer, $isAuditor) =
            getUserData();
        $cmd        = "admacct add name \"$account\" password \"$passwd\"".
            " manager $isManager policyer $isPolicyer auditor $isAuditor";
        $cli        = new cli();
        $result     = $cli->run($cmd);
        echo json_encode(array('msg' => $result));
    } else if ($_POST['type'] === 'edit')  {
        // edit account
        list($account, $passwd, $isManager, $isPolicyer, $isAuditor) =
            getUserData();
        delSpecifiedUser($name);
        $cmd = "admacct add name \"$account\" password \"$passwd\"".
            " manager $isManager policyer $isPolicyer auditor $isAuditor";
        $cli        = new cli();
        $result     = $cli->run($cmd);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['delUser'])) {
        // delete specified account
        $name   = $_POST['delUser'];
        $result = delSpecifiedUser($name);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['multiAdm'])) { 
        $s = $_POST['multiAdm'];
        $cmd    = "admacct set multiadm $s";
        $cli    = new cli();
        $result = $cli->run($cmd);
        echo json_encode(array('msg' => $result));
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM accounts')->getAllData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('accounts', $result);
    }
?>
