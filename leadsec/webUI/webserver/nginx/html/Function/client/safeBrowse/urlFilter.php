<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendUrlData($where) {
        $tpl =  'client/safeBrowse/urlFilterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
	    $sql = "SELECT * FROM url WHERE type='U'";
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
        echo V::getInstance()->assign('urlFilter', $result)
            ->assign('offset', $offset)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
        $value  = $keyword ;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

    function getDataCount() {
    	$sql = "SELECT list FROM url WHERE type='U'";
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

    if (!empty($_POST['editList'])) {
        // Open a specified safepass data
        $tpl = $_POST['tpl'];
        $list  = $_POST['editList'];
        $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
        $sql = "SELECT * FROM url WHERE type='U' AND list='$list'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);       
        $result = V::getInstance()
        	->assign('editUrl', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
     } else if (isset($_POST['openAddDialog'])) {
        // Open a new safepass dialog
        $tpl = $_POST['tpl'];
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified safepass data
        $delList = $_POST['hid_list'];
        $addLisr = $_POST['url_list'];
        $comment = $_POST['comment'];
        $cmd = "httpctl del url \"$delList\"";
        $cmd1 = "httpctl add url \"$addLisr\" comment \"$comment\"";
        $cli = new cli();
        $cli->setLog("删除一条URL为{$delList}的过滤配置")->run($cmd);
        $cli->setLog("添加一条URL为{$addLisr}的过滤配置")->run($cmd1);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('status' => 0,'msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // Add a new safepass data
        $addLisr = $_POST['url_list'];
        $comment = $_POST['comment'];
        $cmd = "httpctl add url \"$addLisr\" comment \"$comment\"";
        $cli = new cli();
        $cli->setLog("添加一条URL为{$addLisr}的过滤配置")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('status' => 0,'msg' => '添加成功。'));
    } else if (!empty($_POST['delList'])) {
        // Delete the specified safepass data 
        $delList = $_POST['delList'];  
        $cmd = "httpctl del url \"$delList\"";     
        $cli = new cli();
        $cli->setLog("删除一条URL为{$delList}的过滤配置")->run($cmd);
        $cli->setLog("修改安全浏览配置")->run("httpctl reconfigure ");
        echo json_encode(array('msg' => "删除成功。"));
   } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort safepass list
        appendUrlData($orderStatement);
    } else if (!empty($_GET['checkExistList'])) {
    	if ($_GET['edit'] === 'edit' && ($_GET['hi_list'] === $_GET['url_list'])) {
    		echo 'true';
    		return;
    	}
    	echo netGapRes::getInstance()->checkExistTaskId('filterList',$_GET['url_list']);
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
