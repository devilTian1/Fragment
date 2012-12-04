<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    function freshStaticRoute($where) {
    	global $propertyArr,$ipaddrArr;
        $tpl =  'networkMangement/basic/staticRouteTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT * FROM route_static $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('list', $result)
        	->assign('propertyArr',$propertyArr)
        	->assign('ipaddrArr',$ipaddrArr)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }
    function getDataCount() {
        $sql = "SELECT id FROM route_static";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        return $db->query($sql)->getCount();
    }
    $addrTypeArr = array('', 'default', 'range', 'reverse');
	if ('showAdd'===$_POST['type']) {
        // Get specified interface data
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT external_name FROM interface";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $arr=array();
        foreach($result as $value){
        	$arr[]=$value['external_name'];
        }
        $result = V::getInstance()->assign('interface', $arr)
           			->fetch($tpl);
        echo json_encode(array('msg' => $result));
    }elseif ('add'===$_POST['type']) {
        // add route_static
        $destip    = $_POST['destip'];
        $destmask=$_POST['destmask'];
        $nexthopip=$_POST['nexthopip'];
        $interface=$_POST['interface'];
        $cmd = "route add static dip \"$destip/$destmask\" gateway \"$nexthopip\" interface \"$interface\"";
        $cli    = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "添加成功."));
    }elseif (!empty($_POST['sid'])) {
        // Get specified data
        $id  = $_POST['sid'];
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT * FROM route_static WHERE id = $id";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        
    	$sql2 = "SELECT external_name FROM interface";
        $result2 = $db->query($sql2)->getAllData(PDO::FETCH_ASSOC);
        $arr=array();
        foreach($result2 as $value){
        	$arr[]=$value['external_name'];
        }
        $result = V::getInstance()->assign('res', $result)->assign('interface', $arr)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    }elseif ('edit'===$_POST['type']) {
        // Edit the specified
        $id  = $_POST['id'];
        $destip    = $_POST['destip'];
        $destmask=$_POST['destmask'];
        $nexthopip=$_POST['nexthopip'];
        $interface=$_POST['interface'];
        $cmd = "route set static id \"$id\" dip \"$destip\/$destmask\" gateway \"$nexthopip\" interface \"$interface\"";
        $cli    = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "修改成功."));
    }elseif (isset($_POST['delid'])) {
        // del static_static
        $id  = $_POST['delid'];       
        $cmd = "route del static id \"$id\"";
        $cli    = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "删除成功."));
    }elseif (isset($_POST['changeid'])) {
        // del static_static
        $id  = $_POST['changeid'];
        $argu= $_POST['argu']; 
        $cmd = "route set static id \"$id\" active $argu";
        $cli    = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "状态改变成功."));
    }elseif ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort static Table
        freshStaticRoute($orderStatement);
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
