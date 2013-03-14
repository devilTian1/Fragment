<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFtpFliterOptionsData($where) {
        $tpl =  'client/ftp/ftpTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
	    $sql = 'SELECT id, name, user_info, user_act, cmd_info, cmd_act, ' .
            "virus, comment FROM options $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('ftpFilterOptions', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getCmd() {
        $id         = getNewId();
        $name       = $_POST['ftpFilterOptName'];
        $banner     = $_POST['banner'];
        $cmdAct     = $_POST['cmdAct'] === '0' ? 'allow' : 'forbid';
        $comment    = $_POST['comment'];
        $downAct    = $_POST['downAct'] === '0' ? 'chk_down_allow' :
            'chk_down_forbid';
        $userAct    = $_POST['userAct'] === '0' ? 'chk_allow' : 'chk_forbid';
        $uploadAct  = $_POST['uploadAct'] === '0' ? 'chk_up_allow' :
            'chk_up_forbid';
        if (!empty($_POST['fileSize'])) {
            $fileSize = $_POST['fileSize'];
        } else {
            $fileSize = '""';
        }
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
        $virus      = $_POST['virus'] === 'N' ? 'off' : 'on';
        $cmd = "cftpctl add option id $id name $name user_info $userInfo " .
            "user_act $userAct up_info $uploadInfo up_act $uploadAct " .
            "down_info $downInfo down_act $downAct file_size $fileSize " .
            " file_act forbid cmd_info $cmdInfo cmd_act $cmdAct virus $virus ";
        if (!empty($banner)) {
            $cmd .= "banner \"$banner\" ";
        }
        if (!empty($comment)) {
            $cmd .= "comment \"$comment\"";
        }
        return $cmd;
    }

    function checkExistName($name) {
    	$sql = 'SELECT id FROM options WHERE name = "' . $name . '"';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    }

    function getDataCount() {
    	$sql = 'SELECT id FROM options';
        $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
        return $db->query($sql)->getCount();
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
        $result = V::getInstance()
            ->assign('data', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit a specified ftp filter options data
        $id = $_POST['id'];
        $cli = new cli();
        $cli->run("cftpctl del option id $id");
        $cli->run(getCmd());
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add a new ftp filter options
        $cli = new cli();
        $cli->run(getCmd());
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($id = $_POST['delId']) {
        // Delete the specified ftp filter options data
        $cli = new cli();
        $cli->run("cftpctl del option id $id");
        echo json_encode(array('msg' => '删除成功.'));
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add new ftp filter options
        $tpl    = 'client/ftp/editFtpDialog.tpl';
        $result = V::getInstance()
            ->assign('type', 'add')->fetch($tpl);
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
        
