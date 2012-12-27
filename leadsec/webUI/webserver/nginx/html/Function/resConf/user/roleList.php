<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshRoleList($where) {
        $tpl  = 'resConf/user/roleListTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT role_id, role_name, create_by, create_time, time
            FROM role $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('roleList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
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
    } else if ('add' === $_POST['type']) {
        // Add new role
        $_POST['createBy'];
        $_POST['createTime'];

        $_POST['roleName'];
        $_POST['allocatedTime'];
        $_POST['alwaysOnline'] === 'on' ? 'on' : 'off';
        $_POST['comment'];
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } elseif ($_POST['addProcess'] === 'true'){
        $tpl = 'resConf/user/editProcessListDialog.tpl';
        $result = V::getInstance()->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($order = $_POST['orderStatement']) { 
        // Fresh and resort role list Table
        freshRoleList($order);
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
