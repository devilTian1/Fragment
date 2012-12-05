<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    function freshRedundance($where) {
        $workmodeArr = array('未指定',   '路由模式',
                             '透明模式', '冗余设备模式');
        $ipaddrArr   = array('未指定', '静态制定',
                             '无效',   'DHCP获取');
        $tpl =  'networkMangement/interface/redundanceTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT external_name, ip, mask, workmode, ipaddr_type, ' .
            "interface_list FROM interface WHERE device_type = 6 $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('list', $result)
        	->assign('workmodeArr', $workmodeArr)
        	->assign('ipaddrArr',   $ipaddrArr)
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
        return $result;
    }

    function getCmd($action) {
        $name     = $_POST['external_name'];
        if ($_POST['ipaddr_type'] === '1') {
            $ipAddrTypeParam = 'ipaddr_type static';
        } else if ($_POST['ipaddr_type'] === '2') {
            $ipAddrTypeParam = 'ipaddr_type invalid';
        } else if ($_POST['ipaddr_type'] === '3') {
            $ipAddrTypeParam = 'ipaddr_type dhcp';
        } else { // 0
            $ipAddrTypeParam = '';
        }
        $ip   = $_POST['ip'];
        $mask = $_POST['mask'];
        $ipC  = $_POST['ipmac_check'] === 'on' ? 'on' : 'off';
        $ipCP = $_POST['ipmac_check_policy'] === 'on' ? 'on' : 'off';
        $as   = $_POST['antispoof'] === 'on' ? 'on' : 'off';
        $addrListStr   = join(',', $_POST['addrMember']);
        $addrListParam = '';
        if ($addrListStr != '') {
            $addrListParam = "interface_list $addrListStr";
        }
        $ping       = $_POST['ping'] === 'on' ? 'on' : 'off';
        $traceroute = $_POST['traceroute'] === 'on' ? 'on' : 'off';
        $enable     = $_POST['enable'] === 'on' ? 'on' : 'off';

        return "interface $action rd if $name active $enable ip $ip " .
            "netmask $mask workmode route $addrListParam " .
            "$ipAddrTypeParam ping $ping traceroute $routeroute" .
            "ipmac_check $ipC ipmac_check_policy $ipCP antispoof $as";
    }

    function getDataCount() {
        $sql = "SELECT external_name FROM interface where device_type = 6";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        return $db->query($sql)->getCount();
    }

    if (!empty($_POST['name'])) {
        // Get specified Physical data
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
            ->assign('addrListArr', array_diff(getBindDev(), $ifArr))
            ->assign('addrMemberArr', $ifArr)
            ->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add the specified Redundance Device
        $cmd = getCmd('add');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified Redundance Device
        $cmd = getCmd('set');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if (!empty($_POST['openNewRedundanceDevDialog'])) {
        // Open New Redundance Dev Dialog
        $tpl    = $_POST['tpl'];
        $result = V::getInstance()->assign('addrListArr', getBindDev())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($name = $_POST['delName']) {
        // Delete specified Redundance Device
        $cli  = new cli();
        $cli->run("interface del if $name");
        echo json_encode(array('msg' => "删除冗余设备[$name]成功."));
    } else if ($action = $_POST['action']) {
        // Switch specified redundance device
        $name = $_POST['switch_name'];
        $cli = new cli();
        if ($action === 'disable') {
            $cmd = "interface set rd if $name active off";
            $cli->run($cmd);
            echo json_encode(array('msg' => "[$name]已关闭."));
        } else if ($action === 'enable') {
            $cmd = "interface set rd if $name active on";
            $cli->run($cmd);
            echo json_encode(array('msg' => "[$name]已启动."));
        } else {
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
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
