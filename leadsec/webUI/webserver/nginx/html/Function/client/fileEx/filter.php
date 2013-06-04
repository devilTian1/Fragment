<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendFilterData($where) {
        $tpl = 'client/fileEx/filterTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = 'SELECT id, name, filename, blacklist, whitelist FROM ' .
            "filter";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('filter', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' WHERE (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }

    function getDataCount() {
        $sql = 'SELECT id FROM filter';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getCmd() {
        $name = $_POST['FEfilterName'];
        $act  = $_POST['action'] === 'A' ? 'allow' : 'forbid';
        $fn   = $_POST['allowedFile'];
        if (empty($fn)) {
            $fn = 'novalue';
        }
        $bl = $_POST['blacklist'];
        if (empty($bl)) {
            $bl = 'novalue';
        }
        $wl = $_POST['whitelist'];
        if (empty($wl)) {
            $wl = 'novalue';
        }
        if (empty($_POST['fileType'])) {
            $type = 'null';
        } else {
            $type = join(',', $_POST['fileType']);
        }
        $smax = $_POST['sizemax'];
        if (empty($smax)) {
            $smax = 0;
        }
        $smin = $_POST['sizemin'];
        if (empty($smin)) {
            $smin = 0;
        }
        $tmax = $_POST['timemax'];
        if (empty($tmax)) {
            $tmax = '1900/01/00-00:00:00';
        } else {
            $tmax = str_replace(' ', '-', $tmax);
        }
        $tmin = $_POST['timemin'];
        if (empty($tmin)) {
            $tmin = '1900/01/00-00:00:00';
        } else {
            $tmin = str_replace(' ', '-', $tmin);
        }
        $cmd = array();
        $cmd['cmd'] = "fsctl add filter name $name filename $fn blacklist $bl" .
            " whitelist $wl action $act type $type timemin $tmin timemax " .
            "$tmax sizemin $smin sizemax $smax";
        $cmd['log'] = '添加客户端的文件交换的文件属性控制'.$name;       
        return $cmd;
    }

    function getFilterOptions($option) {
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $result = array('' => '无');
        if ($option === 'allowedFile') {
            $sql  = 'SELECT name FROM allowedfile';
        } else if ($option === 'whitelist') {
            $sql  = 'SELECT name FROM context WHERE allow = 1';
        } else if ($option === 'blacklist') {
            $sql  = 'SELECT name FROM context WHERE allow = 0';
        } else {
            throw new Exception("Incorrect filter option: $option.");
        }
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $v) {
            $name = $v['name'];
            $result[$name] = $name;
        }
        return $result;
    }
    
    function checkFilter(){
    	$db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = "SELECT * FROM dir_info WHERE mode = 'C' and filter = '".$_POST['delName']."'";
    	return $db->query($sql)->getCount();
    }

    if ($id = $_POST['editId']) {
        // Display dialog of specified filter conf data
        $tpl  = 'client/fileEx/editFilterDialog.tpl';
        if(!empty($_POST['plug'])){
        	$sql = "SELECT * FROM filter WHERE name = '$id'";
        }else{
        	$sql = "SELECT * FROM filter WHERE id = $id";
        }
        $db   = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $data['timemax'] = str_replace('-', ' ', $data['timemax']);
        $data['timemin'] = str_replace('-', ' ', $data['timemin']);
        if($data['timemax'] == $data['timemin']){
        	$data['timemax'] = '';
        	$data['timemin'] = '';
        }
        if($data['sizemax'] == $data['sizemin']){
        	$data['sizemax'] = '';
        	$data['sizemin'] = '';
        }
        $data['fileType'] = explode(',', $data['ftype']);
        $result = V::getInstance()->assign('data', $data)
            ->assign('allowedFile', getFilterOptions('allowedFile'))
            ->assign('blacklist', getFilterOptions('blacklist'))
            ->assign('whitelist', getFilterOptions('whitelist'))
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit specified filter conf data
        $id  = $_POST['id'];
        $cli = new cli();
        $cli->setLog('删除客户端的文件交换的文件属性控制,id号为'.$id)->run("fsctl del filter id $id");
        $cmd = getCmd();
        $cli->setLog($cmd['log'])->run($cmd['cmd']);
        echo json_encode(array('msg' => '修改成功。'));
    } else if ('add' === $_POST['type']) {
        // add a new filter conf data
        $cli = new cli();
        $cmd = getCmd();
        $cli->setLog($cmd['log'])->run($cmd['cmd']);
        echo json_encode(array('msg' => '添加成功。'));
    } else if ($id = $_POST['delId']) {
        // delete specified filter conf data
        $cmd = "fsctl del filter id $id";
        $rc = checkFilter();
        if($rc != 0){
        	echo json_encode(array('msg' => "此文件属性控制策略被引用，不能被删除。"));
        }else{
            $cli = new cli();
            $cli->setLog('删除客户端的文件交换的文件属性控制,id号为'.$id)->run($cmd);
            echo json_encode(array('msg' => '删除成功。'));
        }
    } else if (!empty($_POST['openAddDialog'])) {
        // Display dialog to add filter data
        $tpl =  'client/fileEx/editFilterDialog.tpl';
        $result = V::getInstance()
            ->assign('allowedFile', getFilterOptions('allowedFile'))
            ->assign('blacklist', getFilterOptions('blacklist'))
            ->assign('whitelist', getFilterOptions('whitelist'))
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_GET['checkExistName'])) {
        // Check the same filter conf name exist or not
        $sql = 'SELECT id FROM filter WHERE name = "' .
            $_GET['FEfilterName'] . '"';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if (!empty($_POST['selectList'])) {
        // fresh ftp select list
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
	    $sql = 'SELECT name FROM filter';
        $d   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	$result = array();
    	foreach ($d as $v) {
    		$result[] = $v['name'];
    	}
	    echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort filter conf data list
        appendFilterData($orderStatement);
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
