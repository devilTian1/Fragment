<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    function freshRedundance($where) {
        $tpl =  'networkManagement/interface/redundanceTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT external_name, ip, mask, interface_list, enable ' .
            'FROM interface WHERE device_type = 6';
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('list', $result)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getBindDev() {
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT external_name FROM interface ' .
            'WHERE workmode == 3 AND alias_id == -1';
        $d   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($d as $v) {
            $result[] = $v['external_name'];
        }
        $sql = 'SELECT interface_list FROM interface ' .
            'WHERE device_type=6';
        $d = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $reduceArray = array();
        foreach ($d as $v) {
            $tmp = explode(",",$v['interface_list']);
            foreach($tmp as $arr) {
                $reduceArray[] = $arr;
            }
        }        
        return array_diff($result,$reduceArray);
    }

    function getCmd($action) {
        $name = $_POST['external_name'];
        $ipStr = "";
        $ipAddrTypeParam = 'ipaddr_type static';
        $ip = $_POST['redundanceIpv4'];
        $ipv4Mask  = $_POST['redundanceMask'];
        if (!empty($ipv4Mask)) {
            $ipv4Mask = convertToIpv4Mask($ipv4Mask);
        }
        $ipStr = "ip $ip netmask $ipv4Mask";

        
        $ipC           = $_POST['ipmac_check'] === 'on' ? 'on' : 'off';
        $ipCP          = $_POST['ipmac_check_policy'] === 'on' ? 'on' : 'off';
        $as            = $_POST['antispoof'] === 'on' ? 'on' : 'off';
        $addrMember    = $_POST['addrMember'];
        $addrListStr   = count($addrMember) > 0 ? join(',', $addrMember) : '';
        $addrListParam = '';
        if ($addrListStr != '') {
            $addrListParam = "interface_list $addrListStr";
        }
        $ping       = $_POST['ping'] === 'on' ? 'on' : 'off';
        $traceroute = $_POST['traceroute'] === 'on' ? 'on' : 'off';
        $enable     = $_POST['enable'] === 'on' ? 'on' : 'off';

        return "interface $action rd if $name active $enable $ipStr " .
            "workmode route $addrListParam " .
            "$ipAddrTypeParam ping $ping traceroute $traceroute " .
            "ipmac_check $ipC ipmac_check_policy $ipCP antispoof $as";
    }

    function getDisablePhyDevByRdName($name) {
        $sql    = 'SELECT interface_list FROM interface WHERE external_name' .
            " = '$name'";
        $db     = new dbsqlite(DB_PATH . '/configs.db');
        $data   = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = array();
        foreach (explode(',', $data['interface_list']) as $if) {
            $sql  = "SELECT enable FROM interface WHERE external_name = '$if'";
            $d    = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            if ($d['enable'] === '0') {
                $result[] = $if;
            }
        }
        return $result;
    }
    
    function getWhereStatement($db, $cols, $keyword) {
        $value  = $keyword ;
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $db->getFilterParams($params));
    }

    function getDataCount() {
        $sql = 'SELECT external_name FROM interface where device_type = 6';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $params = array();
		$keyword='/'.$_GET['keyword'];
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $keyword);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getExistRdNameArr() {
        $sql    = 'SELECT external_name FROM interface WHERE device_type=6'; 
        $db     = new dbsqlite(DB_PATH . '/configs.db');
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['external_name'];
        }
        return $result;
    }
    
	function isInUseCheck($name) {
        $sql = "SELECT phy_device FROM interface where phy_device='$name'";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $num = $db->query($sql)->getCount();
        if(intval($num) > 0) {
            return true;
        } else {
            return false;
        }
    }

    $rdNameArr = array('rd1', 'rd2', 'rd3', 'rd4');
    if (!empty($_POST['name'])) {
        // Get specified Physical data and show Edit Dialog
        $name = $_POST['name'];
        $tpl  = $_POST['tpl'];
        $db   = new dbsqlite(DB_PATH . '/configs.db');
        $sql  = "SELECT * FROM interface WHERE device_type = 6 AND " .
            "external_name = '$name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        if (empty($result['interface_list'])) {
            $ifArr = array();
        } else {
            $ifArr = explode(',', $result['interface_list']);
        }
        $result = V::getInstance()
            ->assign('rdNameArr', $rdNameArr)
            ->assign('addrListArr', array_diff(getBindDev(), $ifArr))
            ->assign('addrMemberArr', $ifArr)
            ->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add the specified Redundance Device
        $cmd = getCmd('add');
        $cli = new cli();
        $cli->setLog("添加冗余设备".$_POST['external_name'])->run($cmd);
        echo json_encode(array('msg' => '添加成功。'));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified Redundance Device
        $cmd  = getCmd('set');
        $cli  = new cli();
        $cli->setLog("修改冗余设备".$_POST['external_name'])->run($cmd);

        $msg  = '';
        if ($nameArr = getDisablePhyDevByRdName($_POST['external_name'])) {
            $msg = "提醒: 绑定设备[" . join(', ', $nameArr) .
                "]未开启。<br/>";
        }
        echo json_encode(array('msg' => $msg . '修改成功。'));
    } else if (!empty($_POST['openNewRedundanceDevDialog'])) {
        // Open New Redundance Dev Dialog
        $tpl    = $_POST['tpl'];
        $result = V::getInstance()->assign('addrListArr', getBindDev())
            ->assign('rdNameArr', array_diff($rdNameArr, getExistRdNameArr()))
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($name = $_POST['delName']) {
        // Delete specified Redundance Device
        $cli  = new cli();
		$msg_log = "删除冗余设备{$name}";
		list($status,$result) = $cli->setLog($msg_log)
				->execCmdGetStatus("interface del if $name");
		if ($status > 0) {
			echo json_encode(array('status'=>$status,'msg' => '冗余设备['.$name.']被引用。'));
		} else {
			echo json_encode(array('status'=>$status,'msg' => '删除成功。'));
		}
    } else if ($action = $_POST['action']) {
        // Switch specified redundance device
        $name = $_POST['switch_name'];
        $cli = new cli();
        if ($action === 'disable') {
            $cmd = "interface set rd if $name active off";
            $cli->setLog("关闭冗余设备{$name}")->run($cmd);
            echo json_encode(array('msg' => "[$name]已关闭。"));
        } else if ($action === 'enable') {
            $cmd = "interface set rd if $name active on";
            $cli->setLog("开启冗余设备{$name}")->run($cmd);

            $msg  = '';
            $name = $_POST['switch_name']; 
            if ($nameArr = getDisablePhyDevByRdName($name)) {
                $msg = "提醒: 绑定设备[" . join(', ', $nameArr) .
                    "]未开启。<br/>";
            }
            echo json_encode(array('msg' => "{$msg}[$name]已启动。"));
        } else {
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误。'));
        }
    } else if (!empty($_POST['openNewWorkModeDialog'])) {
        // open dialog to set work mode
        $tpl    = 'networkManagement/interface/editWorkModeDialog.tpl';

        $sql = 'SELECT work_mode FROM redevice_option';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $d   = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $curWorkMode = $d['work_mode'];
        if ($curWorkMode === '0') {
            $workMode = 'balance-rr';
        } else if ($curWorkMode === '1') {
            $workMode = 'backup';
        } else if ($curWorkMode === '4') {
            $workMode = '802.3ad';
        } else {
            throw new Exception("Incorrect work mode param: [$curWorkMode].");
        }
        $result = V::getInstance()->assign('workMode', $workMode)->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['setWorkMode'])) {
        // set work mode
        $workMode = $_POST['workMode'];
        $cli = new cli();
        $cli->setLog("修改冗余设备高级设置, 将冗余设备工作模式设置为$workMode。")
            ->run("interface set rdoption workmode $workMode");
        echo json_encode(array('msg' => '修改成功。'));
    } else if ($ipType = $_GET['checkIpExist']) {
        // check if the ip address exists
        $db     = new dbsqlite(DB_PATH . '/configs.db');
        if ($ipType === 'ipv4') {
            $sql  = "SELECT external_name FROM interface " .
                "WHERE ip = '{$_GET['redundanceIpv4']}' AND external_name!='{$_GET['exName']}'";
            echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        } else {
            throw new Exception("Can`t valid the ip type:  $ipvType.");
        }
    } else if ($_GET['isInUseCheck']) {
		$name = $_GET['checkName'];
        if(isInUseCheck($name)) {
            echo "true";
        } else {
            echo "false";
        }
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
