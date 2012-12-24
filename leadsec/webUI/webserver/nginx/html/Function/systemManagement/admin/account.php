<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function setConf($name, $val) {
        $file = $_SERVER['DOCUMENT_ROOT'] . '/Conf/global.php';
        $contents = file_get_contents($file);
        $contents = preg_replace("@\('$name',\s?(.*)\)@",
            "('$name',$val)", $contents);
        file_put_contents($file, $contents);
    }

    function delSpecifiedUser($username) {
        $cmd = "admacct del name \"$username\"";
        $cli = new cli();
        $cli->run($cmd);
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
        setConf('EXPIRED_TIME', $_POST['expTime']);
        echo json_encode(array('msg' => '修改成功'));
    } else if (!empty($_POST['limitErrNum']) || !empty($_POST['limitErrTime'])){
        // modify limit error login num and time
        setConf('LIMITERR_NUM',  $_POST['limitErrNum']);
        setConf('LIMITERR_TIME', $_POST['limitErrTime']);
        echo json_encode(array('msg' => '修改成功'));
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
        $cmd = "admacct add name \"$account\" password \"$passwd\"".
            " manager $isManager policyer $isPolicyer auditor $isAuditor";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功'));
    } else if ($_POST['type'] === 'edit')  {
        // edit account
        list($account, $passwd, $isManager, $isPolicyer, $isAuditor) =
            getUserData();
        delSpecifiedUser($_POST['oldAccount']);
        $cmd = "admacct add name \"$account\" password \"$passwd\"".
            " manager $isManager policyer $isPolicyer auditor $isAuditor";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功'));
    } else if (!empty($_POST['delUser'])) {
        // delete specified account
        $name   = $_POST['delUser'];
        delSpecifiedUser($name);
        echo json_encode(array('msg' => '删除成功'));
    } else if (!empty($_POST['multiAdm'])) { 
        $s = $_POST['multiAdm'];
        $cmd = "admacct set multiadm $s";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功'));
    } else if (!empty($_POST['freshAccountList'])) {
        $tpl = 'systemManagement/admin/accountTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM accounts')
            ->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('accounts', $result)->fetch($tpl);
    } else {
        // init page data
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $multiAdm = $db->query('SELECT allow FROM allow_multiple')
            ->getFirstData(PDO::FETCH_ASSOC);
        $isMultiAdm = $multiAdm['allow'] === '0' ? '' : 'checked="checked"';
        V::getInstance()->assign('isMultiAdm', $isMultiAdm);
    }
?>
