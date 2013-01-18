<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendBannedContentData($where) {
        $tpl =  'client/fileSync/bannedContentTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $sql = "SELECT * FROM context WHERE allow = 0 $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('bannedContent', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM context';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Display dialog of specified banned content data
        $tpl  = 'client/fileSync/editBannedContentDialog.tpl';
        $sql  = "SELECT * FROM context WHERE id = $id AND allow = 0";
        $db   = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified banned content data
        $id       = $_POST['id'];
        $context  = $_POST['context'];
        $comment  = $_POST['comment'];
        $cmd = "fs2ctl add unallowedcontext \"$context\" comment \"$comment\"";
        $cli = new cli();
        $cli->run("fs2ctl del unallowedcontext id \"$id\"");    
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // add a new banned content data
        $context  = $_POST['context'];
        $comment  = $_POST['comment'];
        $cmd = "fs2ctl add unallowedcontext \"$context\" comment \"$comment\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // delete specified banned content data
        $cmd = "fs2ctl del unallowedcontext id \"$id\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add banned content data
        $tpl =  'client/fileSync/editBannedContentDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistContext'])) {
        // Check the same file name  exist or not
        $allow = $_GET['allow'];
        $sql = "SELECT id FROM context WHERE allow = $allow AND context = \"" .
            $_GET['context'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendBannedContentData($orderStatement);
    } else if (!empty($_POST['ctl'])) {
        // switch control service
        $bl = 'off';
        if ('on' === $_POST['banlist']) {
            $bl = 'on';
        }
        $cli = new cli();
        $cli->run("fs2ctl set basic blacklist $bl");
        echo json_encode(array('msg' => '成功.'));
    } else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
