<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    function checkIfDefaultRoute($gatewayIp) {  	        
        $gatewayIpFrag = explode('.', trim($gatewayIp));
        $db      = new dbsqlite(DB_PATH . '/configs.db');
        $sql     =
            "SELECT distinct(ip),mask FROM interface where ip != ''";
        $result  = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        if (count($result) > 0) {
        	foreach ($result as $value) {
                $ip          = $value['ip'];
                $mask        = convertToIpv4Mask($value['mask']);
                $ipFrag      = explode('.', trim($ip));
                $maskFrag    = explode('.', trim($mask));
                $domainFrag  = array();
                $cDomainFrag = array();
                for ($i = 0; $i < 4; $i++) {
                    $domainFrag[]  =
                        intval($ipFrag[$i]) & intval($maskFrag[$i]);
                    $cDomainFrag[] =
                        intval($gatewayIpFrag[$i]) & intval($maskFrag[$i]);
                }
                if (join('.', $domainFrag) === join('.', $cDomainFrag)) {
                    return true;
                }                                
            }            
        }else {
        	 return false;
        } 
    }
    function checkAddAndEditNexthopip($nexthopIp,$interface) {  	        
        $nexthopIpFrag = explode('.', trim($nexthopIp));     
        $db      = new dbsqlite(DB_PATH . '/configs.db');
        $sql     =
            "SELECT ip FROM interface where external_name = '$interface'";
        $result  = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $k => $v) {
        	$ip = $v['ip'];        	
        }           
        $mask        = convertToIpv4Mask(24);
        $ipFrag      = explode('.', trim($ip));
        $maskFrag    = explode('.', trim($mask));
        $domainFrag  = array();
        $cDomainFrag = array();
        for ($i = 0; $i < 4; $i++) {
            $domainFrag[]  =
                intval($ipFrag[$i]) & intval($maskFrag[$i]);
            $cDomainFrag[] =
                intval($nexthopIpFrag[$i]) & intval($maskFrag[$i]);
        }
        if (join('.', $domainFrag) === join('.', $cDomainFrag)) {
            return true;
        }else {
        	return false;
        }                                                            
    }
    
    function freshStaticRoute($where) {
    	global $propertyArr,$ipaddrArr;
        $tpl =  'networkManagement/basic/staticRouteTable.tpl';
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
    }else if ('add'===$_POST['type']) {
        // add route_static
        $destip     = $_POST['ip'];
        $destmask = $_POST['netmask'];
        $regexp = '/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/';
        if (validateIpv4Format($destip)){
        	$destmask = !empty($destmask) ? convertToIpv4Mask($destmask) : '';
        }
        $nexthopip=$_POST['nexthopip'];
        $interface=$_POST['interface'];
        $nexthopIpFrag = explode('.', trim($nexthopIp)); 
        if($nexthopIpFrag === 4) {
        	//ipv4
        	if (checkAddAndEditNexthopip($nexthopip,$interface)) {
        		$cmdArr   = array();
				$cmdArr[] = "/usr/local/bin/route add static dip ".
        		"$destip/$destmask gateway $nexthopip ".
        		"interface $interface";
        		$cmdArr[] = "hactl reconfigure";
        		$cli    = new cli();
        		// $cli->setLog("添加目的地址为".$_POST['ip']."的静态路由")->run($cmdArr[0]);
				list($status,$result) = $cli->setLog("添加目的地址为".$_POST['ip']."的静态路由")
					->execCmdGetStatus($cmdArr[0]);
				if ($status>0) {
					echo json_encode(array('msg' => "添加失败,请检查配置。"));	
				} else {
        			$cli->setLog("修改高可用性配置")->run($cmdArr[1]);
        			echo json_encode(array('msg' => "添加成功。"));
				}
        	}else {       	
        		$msg = "下一跳地址 \"$nexthopip\"不能生效，请配置与接口\"$interface\"".
        			"的IP同一地址段的地址 。";
        		echo json_encode(array('msg' => $msg));
        	}             	
        } else {
        	//ipv6
        	$cmdArr   = array();
			$cmdArr[] = "/usr/local/bin/route add static dip ".
        		"$destip/$destmask gateway $nexthopip ".
        		"interface $interface";
        	$cmdArr[] = "hactl reconfigure";
        	$cli = new cli();
        	list($status,$result) = $cli->setLog("添加目的地址为".$_POST['ip']."的静态路由")
					->execCmdGetStatus($cmdArr[0]);
			if ($status>0) {
				echo json_encode(array('msg' => "添加失败,请检查配置。"));	
			} else {
        		$cli->setLog("修改高可用性配置")->run($cmdArr[1]);
        		echo json_encode(array('msg' => "添加成功。"));
			}
        }                                       
    }else if (!empty($_POST['sid'])) {
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
    }else if ( isset($_POST['ipv4']) ) {
        // Add defaultgateway ipv4 data
        $gateway  = $_POST['ipv4'];
        if($gateway===""){
        	$cli    = new cli();
        	$cmdArr[]="/usr/local/bin/route set default ip none";
        	$cmdArr[] = "hactl reconfigure";
        	$cli->setLog("设置IPv4默认网关为空")->run($cmdArr[0]);
        	$cli->setLog("修改高可用性配置")->run($cmdArr[1]);
        	echo json_encode(array('msg' => "IPv4默认网关为空。"));	
        }else{
        	if(checkIfDefaultRoute($gateway)) {
	        	$cmdArr   = array();
	        	$cmdArr[] = "/usr/local/bin/route set default ip \"$gateway\"";
	        	$cmdArr[] = "hactl reconfigure";
	        	$cli    = new cli();
	        	$cli->setLog("设置IPv4默认网关为".$gateway)->run($cmdArr[0]);
        		$cli->setLog("修改高可用性配置")->run($cmdArr[1]);
	        	echo json_encode(array('msg' => "IPv4默认网关添加成功。"));        		
        	}else {       	
        		$msg ="IPv4默认网关 \"$gateway\"不能生效，请检查网关地址是否有效 。";
        		echo json_encode(array('msg' => $msg));
        	}
        }               
    }else if ( isset($_POST['ipv6']) ) {
        // Add defaultgateway ipv6 data
        $gateway6  = $_POST['ipv6'];
        if($gateway6===""){
        	$cli    = new cli();
        	$cmdArr[]="/usr/local/bin/route set default ip none6";
        	$cmdArr[] = "hactl reconfigure";
        	$cli->setLog("设置IPv6默认网关为空")->run($cmdArr[0]);
        	$cli->setLog("修改高可用性配置")->run($cmdArr[1]);
        	echo json_encode(array('msg' => "IPv6默认网关为空。"));	
        }else{
	        	$cmdArr   = array();
	        	$cmdArr[] = "/usr/local/bin/route set default ip \"$gateway6\"";
	        	$cmdArr[] = "hactl reconfigure";
	        	$cli    = new cli();
	        	list($status,$result) = $cli->setLog("设置IPv6默认网关为".$gateway6)
					->execCmdGetStatus($cmdArr[0]);
				if ($status>0) {
					echo json_encode(array('msg' => "设置IPv6默认网关失败,请重新配置。"));	
				} else {
        			$cli->setLog("修改高可用性配置")->run($cmdArr[1]);
        			echo json_encode(array('msg' => "IPv6默认网关添加成功。"));
				}	
        }               
    }else if ('edit'===$_POST['type']) {
        // Edit the specified
        $id  = $_POST['id'];
        $destip     = $_POST['ip'];
        $destmask = $_POST['netmask'];
        $regexp = '/^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)(\.|$)){4}/';
        if (validateIpv4Format($destip)){
        	$destmask = !empty($destmask) ? convertToIpv4Mask($destmask) : '';
        }
        $nexthopip=$_POST['nexthopip'];
        $interface=$_POST['interface'];
        $nexthopIpFrag = explode('.', trim($nexthopIp)); 
        if($nexthopIpFrag === 4) {
        	//ipv4
        	if (checkAddAndEditNexthopip($nexthopip,$interface)) {
        		$cmdArr   = array();
        		$cmdArr[] = "/usr/local/bin/route set static id \"$id\" dip " .
        			"\"$destip/$destmask\" gateway \"$nexthopip\" interface " .
        			"\"$interface\"";        	           	    
        		$cmdArr[] = "hactl reconfigure";
        		$cli    = new cli();
        		list($status,$result) = $cli->setLog("添加目的地址为".$_POST['ip']."的静态路由")
					->execCmdGetStatus($cmdArr[0]);
				if ($status>0) {
					echo json_encode(array('msg' => "修改失败,请检查配置。"));	
				} else {
        			$cli->setLog("修改高可用性配置")->run($cmdArr[1]);
        			echo json_encode(array('msg' => "修改成功。"));
				}
        	}else {
        		$msg = "下一跳地址 \"$nexthopip\"不能生效，请配置与接口\"$interface\"".
        			"的IP同一地址段的地址。";
        		echo json_encode(array('msg' => $msg));
        	}
        }else {
        	//ipv6
        	$cmdArr   = array();
        	$cmdArr[] = "/usr/local/bin/route set static id \"$id\" dip " .
        		"\"$destip/$destmask\" gateway \"$nexthopip\" interface " .
        		"\"$interface\"";        	           	    
        	$cmdArr[] = "hactl reconfigure";
        	$cli    = new cli();
        	list($status,$result) = $cli->setLog("添加目的地址为".$_POST['ip']."的静态路由")
				->execCmdGetStatus($cmdArr[0]);
			if ($status>0) {
				echo json_encode(array('msg' => "修改失败,请检查配置。"));	
			} else {
        		$cli->setLog("修改高可用性配置")->run($cmdArr[1]);
        		echo json_encode(array('msg' => "修改成功。"));
			}
        }                
    }else if (isset($_POST['delid'])) {
        // del static_static
        $id  = $_POST['delid'];              
        $cmdArr   = array("route del static id \"$id\"", "hactl reconfigure");
        $cli    = new cli();
        $cli->setLog("删除ID号为".$_POST['delid']."的静态路由")->run($cmdArr[0]);
        $cli->setLog("修改高可用性配置")->run($cmdArr[1]);      
        echo json_encode(array('msg' => "删除成功。"));
    }else if (isset($_POST['changeid'])) {
        // del static_static
        $id  = $_POST['changeid'];
        $argu = $_POST['argu'];
        if($argu==='on'){
        	$act="启用";
        } else{
        	$act="关闭";
        }
        $cmdArr   = array();
        $cmdArr[] = "route set static id \"$id\" active $argu";
        $cmdArr[] = "hactl reconfigure";
        $cli    = new cli();
        //$cli->setLog("$act id为".$_POST['changeid']."的静态路由")->run($cmdArr[0]);
		list($status,$result) = $cli->setLog("$act id为".$_POST['changeid']."的静态路由")
				->execCmdGetStatus($cmdArr[0]);	
		if ($status > 0) {
			echo json_encode(array('msg' => "下一跳地址不正确。"));
		} else {
			$cli->setLog("修改高可用性配置")->run($cmdArr[1]);     
			echo json_encode(array('msg' => "状态改变成功。"));
		}
    }elseif ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort static Table
        freshStaticRoute($orderStatement);
    }else {
        // init page data
        $sql = "SELECT defaultroute,defaultroute6 FROM defaultroute";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $gateway = $db->query($sql)
                     ->getFirstData(PDO::FETCH_ASSOC);
        $result = getDataCount();
        V::getInstance()->assign('route', $gateway)
            ->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
