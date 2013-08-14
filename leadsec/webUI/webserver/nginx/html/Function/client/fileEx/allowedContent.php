<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendAllowedContentData($where) {
        $tpl =  'client/fileEx/allowedContentTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = "SELECT * FROM context WHERE allow = 1";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('allowedContent', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' AND (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM context WHERE allow = 1';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }
    
    function checkAllowedContent($name){
    	$db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
    	$sql = "SELECT * FROM filter WHERE whitelist = '".$name."'";
    	return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Display dialog of specified allowed content name data
        $tpl  = 'client/fileEx/editAllowedContentDialog.tpl';
        $sql  = "SELECT * FROM context WHERE id = $id";
        $db   = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $data['aflist'] = explode(',', $data['context']); 
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified allowed content data
        $id      = $_POST['id'];
        $name    = $_POST['FECCname'];
        $afArr   = join(',', $_POST['FEaflist']);
        $comment = $_POST['comment'];
        $rc = checkAllowedContent($name);
        if($rc != 0){
        	echo json_encode(array('msg' => "此内容白名单策略被引用，不能被修改。"));
        }else{
        	$cmd     = "fsctl add allowedcontext name \"$name\" " .
        	"\"$afArr\" comment \"$comment\"";
        	$cli = new cli();
        	$cli->setLog('删除客户端的文件交换的内容白名单,id号为'.$id)->run("fsctl del allowedcontext  id \"$id\"");
        	$cli->setLog('添加客户端的文件交换的内容白名单,名称为'.$name)->run($cmd);
        	echo json_encode(array('msg' => '修改成功。'));
        }                
    } else if ('add' === $_POST['type']) {
        // add a new allowed content data
        $name    = $_POST['FECCname'];
        $afArr   = join(',', $_POST['FEaflist']);
        $comment = $_POST['comment'];
        $cmd     = "fsctl add allowedcontext name \"$name\" " .
            "\"$afArr\" comment \"$comment\"";
        $cli = new cli();
        $cli->setLog('添加客户端的文件交换的内容白名单,名称为'.$name)->run($cmd);
        echo json_encode(array('msg' => '添加成功。'));
    } else if ($id = $_POST['delId']) {
        // delete specified allowed content data
        $cmd = "fsctl del allowedcontext id \"$id\"";
        $rc = checkAllowedContent($_POST['delName']);
        if($rc != 0){
        	echo json_encode(array('msg' => "此内容白名单策略被引用，不能被删除。"));
        }else{
        	$cli = new cli();
        	$cli->setLog('删除客户端的文件交换的内容白名单,id号为'.$id)->run($cmd);
        	echo json_encode(array('msg' => '删除成功。'));
        }
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add allowed content data
        $tpl =  'client/fileEx/editAllowedContentDialog.tpl';
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
        appendAllowedContentData($orderStatement);
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
