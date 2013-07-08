<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    function freshPhysical($where) {
        $workmodeArr = array('未指定',   '路由模式',
                             '透明模式', '冗余模式');
        $propertyArr = array('未指定',  'HA接口', '管理接口',
                            '网络接口', '网络扩展口');
        $ipaddrArr = array('未指定', '静态指定',
                           '无效',   'DHCP获取');
        $tpl = 'networkManagement/interface/physicalTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT external_name, ip, mask, ipv6, ipv6_mask, if_property,
            ipaddr_type, enable, workmode FROM interface WHERE device_type = 1";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $key => $arr) {
            if($arr['workmode'] === "3") {
                $sql = "SELECT ipaddr_type FROM interface WHERE device_type=6 AND interface_list LIKE '%" . $arr['external_name'] . "%'";
                $num = $db->query($sql)->getCount();
                if(intval($num) > 0) {
                    $result_rd = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
                    $result[$key]['ipaddr_type'] = $result_rd['ipaddr_type'];
                } else {
                    $result[$key]['ipaddr_type'] = 0;
                }
            }
        }
        echo V::getInstance()->assign('list', $result)
        	->assign('propertyArr', $propertyArr)
        	->assign('ipaddrArr', $ipaddrArr)
        	->assign('workmodeArr', $workmodeArr)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getSetPhysicalDevCmd() {
        $if     = $_POST['external_name'];
        $enable = $_POST['enable'] === 'on' ? 'on' : 'off';
        if (empty($_POST['mac_address'])) {
            $macCli = ' ';
        } else {
            $macCli = " mac {$_POST['mac_address']} ";
        }
        if ($_POST['linkmode'] === '0') {
            $linkmode = 'auto';
        } else if ($_POST['linkmode'] === '1') {
            $linkmode = 'full';
        } else { //2
            $linkmode = 'half';
        }
		if ($linkmode ==='auto') {
			$speed = '100';	
		} else {
			$speed = $_POST['speed'];
		}
        if ($_POST['workmode'] === '1') {
            $mtu = $_POST['mtu'];
            $workmode = "mtu $mtu workmode route";
        } else if ($_POST['workmode'] === '3') {
            $mtu = $_POST['mtu'];
            $workmode = "mtu $mtu workmode rd";
        } else { //0
            $workmode = '';
        }
        if ($_POST['ipaddr_type'] === '1' && $_POST['workmode'] !== '3') {
            $ipv4     = $_POST['devIpv4'];
            $ipv4Mask = $_POST['devIpv4Netmask'];
            $ipv4Mask = !empty($ipv4Mask) ? convertToIpv4Mask($ipv4Mask) : '';
            $ipv6     = $_POST['devIpv6'];
            $ipv6Mask = $_POST['devIpv6Netmask'];
            $ipType   = 'ipaddr_type static ';
            if (!empty($ipv4)) {
                $ipType .= "ip $ipv4 netmask $ipv4Mask";
            }
            if (!empty($ipv4) && !empty($ipv6)) {
                $ipType .= ' ';
            }
            if (!empty($ipv6)) {
                $ipType .= "ipv6 $ipv6 ipv6_mask $ipv6Mask";
            }
        //} else if ($_POST['ipaddr_type'] === '2') {
        //    $ipType = 'ipaddr_type invalid';//TODO
        } else if ($_POST['ipaddr_type'] === '3') {
            $ipType = 'ipaddr_type dhcp';
        } else {//0
            $ipType = '';
        }
        $ipmac_check        = $_POST['ipmac_check'] === 'on' ? 'on' : 'off';
        $ipmac_check_policy =
            $_POST['ipmac_check_policy'] === 'on' ? 'on' : 'off';
        $antispoof          = $_POST['antispoof'] === 'on' ? 'on' : 'off';
        $ping               = $_POST['ping'] === 'on' ? 'on' : 'off';
        $traceroute         = $_POST['traceroute'] === 'on' ? 'on' : 'off';

        $result = "interface set phy if $if active $enable{$macCli}linkmode " .
            "$linkmode speed $speed $workmode $ipType " .
            "ipmac_check $ipmac_check ipmac_check_policy $ipmac_check_policy ".
            "antispoof $antispoof ping $ping traceroute $traceroute ".
            "qos_enable off";
        return $result;
    }

    function getEnableRdDevNameByBindName($name) {
        $db     = new dbsqlite(DB_PATH . '/configs.db');
        $sql    = 'SELECT external_name, interface_list FROM interface ' .
            'WHERE interface_list != ""';
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $v) {
            $interfaceList = explode(',', $v['interface_list']);
            if (false !== array_search($name, $interfaceList)) {
                return $v['external_name'];
            }
        }
        return false;
    }

    function getEnableAliasDevNamesByPhyName($name) {
        $db     = new dbsqlite(DB_PATH . '/configs.db');
        $sql    = 'SELECT external_name FROM interface ' .
            "WHERE phy_device='$name' AND enable=1";
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        if (count($data) === 0) {
            return false;
        } else {
            $result = array();
            foreach ($data as $v) {
                $result[] = $v['external_name'];
            }
            return $result;
        }
    }

    function getWhereStatement($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT external_name FROM interface WHERE device_type = 1";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    if (!empty($_POST['name'])) {
        // Get specified Physical data
        $external_name  = $_POST['name'];
        $tpl = 'networkManagement/interface/editPhysicalDialog.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT * FROM interface WHERE device_type = 1 AND external_name'.
            " = '$external_name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()->assign('res', $result)->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // Switch specified physical device
        $name = $_POST['switch_name'];
        $cli = new cli();
        if ($action === 'disable') {
            if ($rdName = getEnableRdDevNameByBindName($name)) {
                $msg = "请先关闭冗余设备[$rdName]后, 再关闭[$name]设备。";
                echo json_encode(array('msg' => $msg));
                return false;
            }
            if ($nameArr = getEnableAliasDevNamesByPhyName($name)) {
                $msg = '请先将别名设备[' . join(', ', $nameArr) .
                    ']关闭后, 再关闭[' . $name . ']设备。';
                echo json_encode(array('msg' => $msg));
                return false;
            }
            $cmd = "interface set phy if $name active off";
            $cli->setLog("关闭物理名称为{$name}的设备")->run($cmd);
            echo json_encode(array('msg' => "[$name]已关闭。"));
        } else if ($action === 'enable') {
            $cmd = "interface set phy if $name active on";
            $cli->setLog("启动物理名称为{$name}的设备")->run($cmd);
            echo json_encode(array('msg' => "[$name]已启动。"));
        } else {
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误。'));
        }
    } else if ('edit' === $_POST['type']) {
        // Edit the specified physical dev
        $name = $_POST['external_name'];
        if (('on' !== $_POST['enable'] || '3' !== $_POST['workmode']) &&
            $rdName = getEnableRdDevNameByBindName($name)) {
            if ('on' !== $_POST['enable']) {
                $msg = "请先关闭冗余设备[$rdName]后, 再关闭[$name]设备。";
            }
            if ('3' !== $_POST['workmode']) {
                $msg = "此设备被冗余设备[$rdName]绑定。";
            }
            echo json_encode(array('msg' => $msg));
            return false;
        }
        if (('on' !== $_POST['enable'] || '3' === $_POST['workmode']) &&
            $nameArr = getEnableAliasDevNamesByPhyName($name)) {
            $msg = '请先将别名设备[' . join(', ', $nameArr) .
                ']关闭后, 再将[' . $name . ']设备设置成冗余设备。';
            echo json_encode(array('msg' => $msg));
            return false;
        }
        $cmd = getSetPhysicalDevCmd();
        $cli = new cli();
        $cli->setLog("修改物理设备{$name}")->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort phycial Table
        freshPhysical($orderStatement);
    } else if ($ipType = $_GET['checkIpExist']) {
        // check if the ip address exists
        $db     = new dbsqlite(DB_PATH . '/configs.db');
        if ($ipType === 'ipv4') {
            $sql  = "SELECT external_name FROM interface " .
                "WHERE ip = '{$_GET['devIpv4']}' AND external_name!='{$_GET['exName']}'";
            echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        } else if ($ipType === 'ipv6') {
            $sql  = "SELECT external_name FROM interface " .
                "WHERE ipv6 = '{$_GET['devIpv6']}' AND external_name!='{$_GET['exName']}'";
            echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        } else {
            throw new Exception("Can`t valid the ip type:  $ipvType.");
        }
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
