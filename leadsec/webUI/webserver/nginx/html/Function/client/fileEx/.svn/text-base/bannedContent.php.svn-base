<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendBannedContentData($where) {
        $tpl =  'client/fileEx/bannedContentTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = "SELECT * FROM context WHERE allow = 0 $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('bannedContent', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM context WHERE allow = 0';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        return $db->query($sql)->getCount();
    }
    
    function checkBannedContent(){
    	$db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
    	$sql = "SELECT * FROM filter WHERE blacklist = '".$_POST['delName']."'";
    	return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Display dialog of specified banned content name data
        $tpl  = 'client/fileEx/editBannedContentDialog.tpl';
        $sql  = "SELECT * FROM context WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $data['bflist'] = explode(',', $data['context']); 
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified banned content data
        $id      = $_POST['id'];
        $name    = $_POST['FECCname'];
        $bfArr   = join(',', $_POST['FEbflist']);
        $comment = $_POST['comment'];
        $cmd     = "fsctl add unallowedcontext name \"$name\" " .
            "\"$bfArr\" comment \"$comment\"";
        $cli = new cli();
        $cli->setLog('删除客户端的文件交换的内容黑名单,id号为'.$id)->run("fsctl del unallowedcontext  id \"$id\"");
        $cli->setLog('添加客户端的文件交换的内容黑名单,名称为'.$name)->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // add a new banned content data
        $name    = $_POST['FECCname'];
        $bfArr   = join(',', $_POST['FEbflist']);
        $comment = $_POST['comment'];
        $cmd     = "fsctl add unallowedcontext name \"$name\" " .
            "\"$bfArr\" comment \"$comment\"";
        $cli = new cli();
        $cli->setLog('添加客户端的文件交换的内容黑名单,名称为'.$name)->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // delete specified banned content data
        $cmd = "fsctl del unallowedcontext id \"$id\"";
        $rc = checkBannedContent();
        if($rc != 0){
        	echo json_encode(array('msg' => "此内容黑名单策略被引用,不能被删除."));
        }else{
        	$cli = new cli();
        	$cli->setLog('删除客户端的文件交换的内容黑名单,id号为'.$id)->run($cmd);
        	echo json_encode(array('msg' => '删除成功.'));
        }
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add banned content data
        $tpl =  'client/fileEx/editBannedContentDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistName'])) {
        // Check the same content control name exist or not
        $sql = 'SELECT id FROM context WHERE name = "' .
            $_GET['FECCname'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort file sync client table data
        appendBannedContentData($orderStatement);
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
