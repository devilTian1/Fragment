<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    $propertyArr = array('未指定', 'HA接口', '管理接口', '网络接口','网络扩展口');
    $ipaddrArr=array('未指定','静态制定','无效','DHCP获取');
    function freshRedundance($where) {
    	global $propertyArr,$ipaddrArr;
        $tpl =  'networkMangement/interface/aliasTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT * FROM interface where alias_id!=-1 $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('list', $result)
        	->assign('propertyArr',$propertyArr)
        	->assign('ipaddrArr',$ipaddrArr)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }
    function getDataCount() {
        $sql = "SELECT external_name FROM interface where alias_id!=-1";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        return $db->query($sql)->getCount();
    }
    $addrTypeArr = array('', 'default', 'range', 'reverse');

    if (!empty($_POST['external_name'])) {
        // Get specified Physical data
        $external_name  = $_POST['external_name'];
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT * FROM interface WHERE external_name = '$external_name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        $result = V::getInstance()
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified 
        $external_name    = $_POST['external_name'];
        $ip=$_POST['ip'];
        $netmask=$_POST['netmask'];
        
        $cmd = "interface set phy if \"$external_name\" ip \"$ip\" netmask \"$netmask\"";
        
        $cli    = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$ip]修改成功."));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort phycial Table
        freshRedundance($orderStatement);
    }else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
