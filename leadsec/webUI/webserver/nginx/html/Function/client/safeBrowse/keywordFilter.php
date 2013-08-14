<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendKeywordData($where) {
        $tpl =  'client/safeBrowse/keywordFilterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
	    $sql = "SELECT * FROM context";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        // get offset
        $pos = stripos($where,"offset ");
        if ($pos) {
            $offset = substr($where,$pos+7);
        } else {
            $offset = 0;
        }
        echo V::getInstance()->assign('keywordFilter', $result)
            ->assign('offset', $offset)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
        $value  = $keyword ;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

    function getDataCount() {
    	$sql = "SELECT id FROM context";
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $params = array();
		$keyword='/'.$_GET['keyword'];
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $keyword);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    if (!empty($_POST['editId'])) {
        // Open a specified keywordFilter data
        $tpl = $_POST['tpl'];
        $id  = $_POST['editId'];
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT * FROM context WHERE id='$id'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $contextList = split(',',$result['context']);
        $result = V::getInstance()
        	->assign('editKey', $result)
        	->assign('contextList', $contextList)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new keywordFilter dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified keywordFilter data
        $id = $_POST['id'];
        $name = $_POST['keyName'];
        $contextArr = $_POST['contextList'];
        $context = join(',',$contextArr);
        $comment = $_POST['comment'];        
        $cmd = "http_blacklistctl del unallowedcontext id \"$id\"";
        $cmd1 = "http_blacklistctl add unallowedcontext name \"$name\" \"$context\" comment \"$comment\"";
        $cli = new cli();
        $cli->setLog("删除一条名称为{$name}的关键字过滤配置")->run($cmd);
        $cli->setLog("添加一条名称为{$name}的关键字过滤配置")->run($cmd1);
        $cli->setLog("修改关键字过滤配置")->run("http_blacklistctl reconfigure ");
        echo json_encode(array('status' => 0,'msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new keywordFilter data
        $name = $_POST['keyName'];
        $contextArr = $_POST['contextList'];
        $context = join(',',$contextArr);
        $comment = $_POST['comment'];
        $cmd = "http_blacklistctl add unallowedcontext name \"$name\" \"$context\" comment \"$comment\" ";
        $cli = new cli();
        $cli->setLog("添加一条名称为{$name}的关键字过滤配置")->run($cmd);
        $cli->setLog("修改关键字过滤配置")->run("http_blacklistctl reconfigure ");
        echo json_encode(array('status' => 0,'msg' => '添加成功。'));
    } else if (!empty($_POST['delId'])) {
        // Delete the specified keywordFilter data 
        $id = $_POST['delId'];  
        $cmd = "http_blacklistctl del unallowedcontext id \"$id\"";     
        $cli = new cli();
        $cli->setLog("删除一条id为{$id}的关键字过滤配置")->run($cmd);
        $cli->setLog("修改关键字过滤配置")->run("http_blacklistctl reconfigure ");
        echo json_encode(array('msg' => "删除成功。"));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort keywordFilter list
        appendKeywordData($orderStatement);
    } else if (!empty($_GET['checkExistName'])) {
    	echo netGapRes::getInstance()->checkExistTaskId('filterKeyword',$_GET['keyName']);
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
