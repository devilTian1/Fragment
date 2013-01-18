<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendAllowedFileData($where) {
        $tpl =  'client/fileSync/allowedFileTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $sql = "SELECT * FROM allowedfile $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('allowedFile', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM allowedfile';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Display dialog of specified allowed file name data
        $tpl  = 'client/fileSync/editAllowedFileDialog.tpl';
        $sql  = "SELECT * FROM allowedfile WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified allowed file data
        $id       = $_POST['id'];
        $filename = $_POST['filename'];
        $comment  = $_POST['comment'];
        $cli = new cli();
        $cli->run("fs2ctl del allowedfile id \"$id\"");
        $cli->run("fs2ctl add allowedfile \"$filename\" comment \"$comment\"");
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // add a new allowed file data
        $filename = $_POST['filename'];
        $comment  = $_POST['comment'];
        $cmd = "fs2ctl add allowedfile \"$filename\" comment \"$comment\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // delete specified allowed file data
        $cmd = "fs2ctl del allowedfile id \"$id\"";
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add allowed file
        $tpl =  'client/fileSync/editAllowedFileDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistFileName'])) {
        // Check the same file name  exist or not
        $sql = 'SELECT id FROM allowedfile WHERE filename = "' .
            $_GET['filename'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendAllowedFileData($orderStatement);
    } else if (!empty($_POST['ctl'])) {
        // switch control service
        $bf = 'forbid';
        $nf = 'off';
        if ('on' === $_POST['binfile']) {
            $bf = 'allow';
        }
        if ('on' === $_POST['namefilter']) {
            $nf = 'on';
        }
        $cli = new cli();
        $cli->run("fs2ctl set basic binfile $bf namefilter $nf");
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
