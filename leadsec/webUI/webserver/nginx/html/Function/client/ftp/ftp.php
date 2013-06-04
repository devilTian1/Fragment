<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    $s = array('LIST', 'DELE', 'NLST', 'CWD', 'RETR', 'STOR',
               'PWD',  'MKD',  'RNFR', 'RMD', 'APPE');
    $r = array('dir', 'delete', 'ls',     'cd',    'get',   'put',
               'pwd', 'mkdir',  'rename', 'rmdir', 'append');
    
    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }
    
    function appendFtpFliterOptionsData($where) {
        global $s, $r;
        $tpl =  'client/ftp/ftpTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
	    $sql = 'SELECT id, name, user_info, user_act, cmd_info, cmd_act, ' .
            "virus, comment FROM options ";
	    $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$dataSearch   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $dataSearch['sql'];
        	$params = $dataSearch['params'];
        }
        $where = $db->replaceAlp($where, 'name');
        $sql .=  ' ' . $where;     	    
        $data = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as &$d) {
            $d['cmd_info'] = str_replace($s, $r, $d['cmd_info']);
        }
        unset($d);
        echo V::getInstance()->assign('ftpFilterOptions', $data)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmd() {
        $id         = getNewId();
        $name       = $_POST['ftpFilterOptName'];
        $banner     = $_POST['banner'];
        $cmdAct     = $_POST['cmdAct'] === '1' ? 'allow' : 'forbid';
        $comment    = $_POST['comment'];
        $downAct    = $_POST['downAct'] === '1' ? 'chk_down_allow' :
            'chk_down_forbid';
        $userAct    = $_POST['userAct'] === '1' ? 'chk_allow' : 'chk_forbid';
        $uploadAct  = $_POST['uploadAct'] === '1' ? 'chk_up_allow' :
            'chk_up_forbid';       
        if (!empty($_POST['cmdInfo'])) {
            $cmdInfo = join(',', $_POST['cmdInfo']);
        } else {
            $cmdInfo = '""';
        }       
        if (!empty($_POST['downInfo'])) {
            $downInfo = $_POST['downInfo'];
        } else {
            $downInfo = '""';
        }
        if (!empty($_POST['uploadInfo'])) {
            $uploadInfo = $_POST['uploadInfo'];
        } else {
            $uploadInfo = '""';
        }
        if (!empty($_POST['userInfo'])) {
            $userInfo = $_POST['userInfo'];
        } else {
            $userInfo = '""';
        }       
        $cmdAct_upload = $_POST['cmdAct_upload'] === '1' ? 'chk_up_allow' :
            'chk_up_forbid';        
        if (!empty($_POST['cmdInfo_upload'])) {
            $cmdInfo_upload = join(',', $_POST['cmdInfo_upload']);
        } else {
            $cmdInfo_upload = '""';
        }           
        $cmdAct_download = $_POST['cmdAct_download'] === '1' ?
            'chk_down_allow' : 'chk_down_forbid';        
        if (!empty($_POST['cmdInfo_download'])) {
            $cmdInfo_download = join(',', $_POST['cmdInfo_download']);
        } else {
            $cmdInfo_download = '""';
        }           
        
        $cmd = "cftpctl add option id $id name $name user_info $userInfo " .
            "user_act $userAct up_info $uploadInfo up_act $uploadAct " .
            "down_info $downInfo down_act $downAct " .
            " file_act forbid cmd_info $cmdInfo cmd_act $cmdAct ".
            "upload_str $cmdInfo_upload upload_str_act $cmdAct_upload ".
            "download_str $cmdInfo_download download_str_act $cmdAct_download ";
        if (!empty($banner)) {
            $cmd .= "banner \"$banner\" ";
        }
        if (!empty($comment)) {
            $cmd .= "comment \"$comment\"";
        }
        return $cmd;
    }

    function checkExistName($name) {
    	$sql = 'SELECT name FROM options WHERE name = "' . $name . '"';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    }
    
    function getDataCount() {
    	$sql = 'SELECT id FROM options';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }        
        return $db->query($sql, $params)->getCount();
    }

    function checkFilterUsed($id) {
    	$sql = 'SELECT id FROM ftp_comm_client_acl ' .
            "WHERE filter = (SELECT name FROM options WHERE id = $id)";
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        if ($db->query($sql)->getCount() > 0) {
            return true;
        } else {
    	    $sql = 'SELECT id FROM ftp_trans_client_acl ' .
                "WHERE filter = (SELECT name FROM options WHERE id = $id)";
            return $db->query($sql)->getCount() > 0 ? true : false;
        }
    }

    function getNewId() {
        if ('edit' === $_POST['type']) {
            return $_POST['id'];
        }
        $sql  = 'SELECT MAX(id) AS id FROM options';
        $db   = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $data =  $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return intval($data['id']) + 1;
    }
    if ($id = $_POST['editId']) {
        // Open Edit dialog for show specified ftp filter conf.
        $tpl =  'client/ftp/editFtpDialog.tpl';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
	    if(!empty($_POST['plug'])){
	    	$sql = "SELECT * FROM options WHERE name = '$id'";
	    }else{
	    	$sql = "SELECT * FROM options WHERE id = '$id'";
	    }        
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $data['cmd_info'] = explode(',', $data['cmd_info']);
        $data['cmd_info_upload'] = explode(',', $data['upload_str']);
        $data['cmd_info_download'] = explode(',', $data['down_str']);
        $result = V::getInstance()
            ->assign('cmdInfoOut', $r)
            ->assign('cmdInfoVal', $s)
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        $id = $_POST['id'];       
    	if(checkFilterUsed($id))
        {
        	 echo json_encode(array('msg' => '无法编辑,该过滤配置正在使用中！'));
        }
        else
        {    	
    	// Edit a specified ftp filter options data
        $cli = new cli();
        $cli->setIsRec(false)->run("cftpctl del option id $id");
        $cli->setIsRec(true)->setLog("修改一条FTP过滤配置,名称为".$_POST['ftpFilterOptName'])->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
        }
    } else if ('add' === $_POST['type']) {
        // Add a new ftp filter options        
    	$sql    = 'SELECT name FROM options';
        $db     = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        $result = $db->query($sql)->getCount();
        if($result>999)
        {
        	 echo json_encode(array('msg' => '无法添加，配置已经达到上限1000条！'));
        }
    	else 
    	{    	
	        $cli = new cli();        
	        $cli->setLog("添加一条新的FTP过滤配置,名称为".$_POST['ftpFilterOptName'])->run(getCmd());
	        echo json_encode(array('msg' => '添加成功.'));
    	}
    } else if ($id = $_POST['delId']) {
        // Delete the specified ftp filter options data
        if (checkFilterUsed($id)) {
            echo json_encode(array('msg' => '此过滤配置正在被使用.'));
            return false;
        }
        $cli = new cli();
        $cli->setLog("删除一条FTP过滤配置")->run("cftpctl del option id $id");
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add new ftp filter options
        $tpl    = 'client/ftp/editFtpDialog.tpl';
        $result = V::getInstance()->assign('cmdInfoOut', $r)
            ->assign('cmdInfoVal', $s)->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistName'])) {
        // check the new name existed or not
        checkExistName($_GET['ftpFilterOptName']);
    } else if (!empty($_POST['selectList'])) {
        // fresh ftp select list
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
	    $sql = 'SELECT name FROM options';
        $d   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	$result = array();
    	foreach ($d as $v) {
    		$result[] = $v['name'];
    	}
	    echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort ftp filtering options list data
        appendFtpFliterOptionsData($orderStatement);
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
        
