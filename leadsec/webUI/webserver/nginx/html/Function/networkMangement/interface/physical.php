<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    function freshPhysical($where) {
        $propertyArr = array('未指定',  'HA接口', '管理接口',
                             '网络接口','网络扩展口');
        $ipaddrArr = array('未指定', '静态制定',
                           '无效',   'DHCP获取');
        $tpl =  'networkMangement/interface/physicalTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT * FROM interface WHERE alias_id == -1 $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('list', $result)
        	->assign('propertyArr',$propertyArr)
        	->assign('ipaddrArr',$ipaddrArr)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getSetPhysicalDevCmd() {
        $if     = $_POST['external_name'];
        $active = $_POST['active'] === '1' ? 'on' : 'off';
        $mac    = $_POST['mac_address'];
        if ($_POST['linkmode'] === '0') {
            $linkmode = 'auto';
        } else if ($_POST['linkmode'] === '1') {
            $linkmode = 'full';
        } else { //2
            $linkmode = 'half';
        }
        $speed = $_POST['speed'];
        if ($_POST['workmode'] === '1') {
            $mtu = $_POST['mtu'];
            $workmode = "mtu $mtu workmode route";
        } else if ($_POST['workmode'] === '2') {
            $workmode = 'workmode trans';
        } else if ($_POST['workmode'] === '3') {
            $mtu = $_POST['mtu'];
            $workmode = "mtu $mtu workmode rd";
        } else { //0
            $workmode = '';
        }
        if ($_POST['ipaddr_type'] === '1') {
            $ip     = $_POST['ip'];
            $mask   = strtoupper($_POST['netmask']);
            $ipType = "ipaddr_type static ip $ip netmask $mask";
        } else if ($_POST['ipaddr_type'] === '2') {
            $ipType = 'ipaddr_type invalid';//TODO
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
        $qos_enable         = $_POST['enable'] === 'on' ? 'on' : 'off';

        $result = "interface set phy if $if active $active mac $mac linkmode " .
            "$linkmode speed $speed $workmode $ipType " .
            "ipmac_check $ipmac_check ipmac_check_policy $ipmac_check_policy ".
            "antispoof $antispoof ping $ping traceroute $traceroute ".
            "qos_enable $qos_enable";
        return $result;
    }

    function getDataCount() {
        $sql = "SELECT external_name FROM interface WHERE alias_id == -1";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        return $db->query($sql)->getCount();
    }

    if (!empty($_POST['name'])) {
        // Get specified Physical data
        $external_name  = $_POST['name'];
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT * FROM interface WHERE alias_id == -1 AND external_name = '$external_name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = V::getInstance()->assign('res', $result)->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($action = $_POST['action']) {
        // Switch specified physical device
        $name = $_POST['switch_name'];
        $cli = new cli();
        if ($action === 'disable') {
            $cmd = "interface set phy if $name active off";
            $cli->run($cmd);
            echo json_encode(array('msg' => "[$name]已关闭."));
        } else if ($action === 'enable') {
            $cmd = "interface set phy if $name active on";
            $cli->run($cmd);
            echo json_encode(array('msg' => "[$name]已启动."));
        } else {
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    } else if ('edit' === $_POST['type']) {
        // Edit the specified physical dev
        $cmd = getSetPhysicalDevCmd();
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort phycial Table
        freshPhysical($orderStatement);
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
