<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

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

    if ($_POST['addNewUser'] === 'true') {
        // Open add new user dialog
        $tpl = $_POST['tpl'];
        echo json_encode(array('msg' => V::getInstance()->fetch($tpl)));
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
