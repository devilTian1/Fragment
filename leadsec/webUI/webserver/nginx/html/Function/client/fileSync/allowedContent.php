<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendAllowedContentData($where) {
        $tpl =  'client/fileSync/allowedContentTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $sql = "SELECT * FROM context WHERE allow = 1 $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('allowedContent', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM context';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Display dialog of specified allowed content data
        $tpl  = 'client/fileSync/editAllowedContentDialog.tpl';
        $sql  = "SELECT * FROM context WHERE id = $id AND allow = 1";
        $db   = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified allowed content data
        $id       = $_POST['id'];
        $context  = $_POST['context'];
        $comment  = $_POST['comment'];
        $cmd = "fs2ctl add allowedcontext \"$context\" comment \"$comment\"";
        $cli = new cli();
        $cli->run("fs2ctl del allowedcontext id \"$id\"");    
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // add a new allowed content data
        $context  = $_POST['context'];
        $comment  = $_POST['comment'];
        $cmd = "fs2ctl add allowedcontext \"$context\" comment \"$comment\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // delete specified allowed content data
        $cmd = "fs2ctl del allowedcontext id \"$id\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add allowed content data
        $tpl =  'client/fileSync/editAllowedContentDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendAllowedContentData($orderStatement);
    } else if (!empty($_POST['ctl'])) {
        // switch control service
        $al = 'off';
        if ('on' === $_POST['allowlist']) {
            $al = 'on';
        }
        $cli = new cli();
        $cli->run("fs2ctl set basic whitelist $al");
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
