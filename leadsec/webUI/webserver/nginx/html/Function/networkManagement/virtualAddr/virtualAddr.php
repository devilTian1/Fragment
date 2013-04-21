<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshVirtualListAddr($where) {
        $result = array();
        $tpl =  'networkManagement/virtualAddr/virtualAddrTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $sql = 'SELECT ifname FROM haif';
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $d) {
            $db  = new dbsqlite(DB_PATH . '/configs.db');
            $sql = 'SELECT phy_device, ip, mask FROM interface ' .
                "WHERE external_name = '{$d['ifname']}' AND enable = 1";
            $aliasData = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $result[] = array(
                'ifname'    => $d['ifname'],
                'phyDevice' => $aliasData['phy_device'],
                'ip'        => $aliasData['ip'],
                'mask'      => $aliasData['mask']
            );
        }
        echo V::getInstance()->assign('list', $result)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getIfNameList() {
        $result = array('' => '无');
        $sql = 'SELECT external_name, phy_device, ip, mask FROM interface ' .
            'WHERE device_type = 5 AND enable = 1';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $d) {
            $devName = $d['phy_device'];
            $result[$devName] = $devName;
        }
        return $result;
    }

    function getAliasAddrList() {
        $result = array('' => '无');
        $sql = 'SELECT external_name, ip, mask FROM interface ' .
            'WHERE device_type = 5 AND enable = 1';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $d) {
            $addr      = $d['ip'] . '/' . $d['mask'];
            $aliasName = $d['external_name'];
            $result[$aliasName] = $addr;
        }
        return $result;
    }
    
    function getSpecVirtualAddr($aliasName) {
        $sql = 'SELECT phy_device FROM interface ' .
            "WHERE external_name = '$aliasName'";
        $db     = new dbsqlite(DB_PATH . '/configs.db');
        $data   = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = array();
        $result['ifname'] = $data['phy_device'];
        $result['addr']   = $aliasName;
        return $result;
    }

    function getEditVirtualAddrCmd() {
        $ifname = $_POST['editAddr'];
        $addr   = $_POST['addr'];
        return array("hactl del haif $ifname", "hactl add haif $addr ipv4");
    }

    function getAddVirtualAddrCmd() {
        $ifname = $_POST['ifname'];
        $addr   = $_POST['addr'];
        return "hactl add haif $addr ipv4";
    }

    function isAllowedEditOrDel($ifname) {
        $sql  = "SELECT ip FROM interface WHERE external_name = '$ifname'";
        $db   = new dbsqlite(DB_PATH . '/configs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $ip   = $data['ip'];
        $sql = "SELECT id FROM service WHERE virtual_ip = '$ip'";
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        return ($db->query($sql)->getCount() === 0);
    }
    
    function getDataCount() {
        $sql = 'SELECT ifname FROM haif';
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        return $db->query($sql)->getCount();
    }    

	$path = "/usr/local/bin/";

    if ('edit' === $_POST['type']) {
        // edit new virtual address data
        if (!isAllowedEditOrDel($_POST['editIfName'])) {
            echo json_encode(array('msg' => '无法删除,该虚拟地址正在使用中！请先从负载均衡中删除正在使用该虚拟地址的配置项.'));
        } else {
            $cmd = getEditVirtualAddrCmd();
            $cli = new cli();
            $cli->run($path.$cmd[0]);
            $cli->setLog("修改虚拟地址".$_POST['addr'])->run($path.$cmd[1]);
            $cli->setIsRec(false)->run($path.'hactl reconfigure');
			$cli->setIsRec(false)->run($path.'hactl stop');
			$cli->setIsRec(false)->run($path.'hactl start');
            echo json_encode(array('msg' => '修改成功.'));
        }
    } else if (!empty($_POST['editIfName'])) {
        // show dialog for editing specified virtual address data
        $tpl    = 'networkManagement/virtualAddr/editVirtualAddrDialog.tpl';
        $result = V::getInstance()->assign('ifNameList', getIfNameList())
            ->assign('aliasAddrList', getAliasAddrList())
            ->assign('res', getSpecVirtualAddr($_POST['editIfName']))
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // add new virtual address data
        $cmd = getAddVirtualAddrCmd();
        $cli = new cli();
        $cli->setLog("添加一条虚拟地址".$_POST['addr'])->run($path.$cmd);
        $cli->setIsRec(false)->run($path.'hactl reconfigure');
		$cli->setIsRec(false)->run($path.'hactl stop');
		$cli->setIsRec(false)->run($path.'hactl start');
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($_POST['openNewVirtualAddrDialog']) {
        // show dialog to add new virtual address data
        $tpl    = 'networkManagement/virtualAddr/editVirtualAddrDialog.tpl';
        $result = V::getInstance()->assign('ifNameList', getIfNameList())
            ->assign('aliasAddrList', getAliasAddrList())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['delName'])) {
        // Delete specified Virtual Addrress data
        $name = $_POST['delName'];
        if (!isAllowedEditOrDel($_POST['editIfName'])) {
            echo json_encode(array('msg' => '无法删除,该虚拟地址正在使用中！请先从负载均衡中删除正在使用该虚拟地址的配置项.'));
        } else {
            $cli  = new cli();
            $cli->setLog("删除虚拟地址".$name)->run($path."hactl del haif $name");
            $cli->setIsRec(false)->run($path.'hactl reconfigure');
			$cli->setIsRec(false)->run($path.'hactl stop');
			$cli->setIsRec(false)->run($path.'hactl start');
            echo json_encode(array('msg' => "删除虚拟地址成功."));
        }
    } else if ($_GET['checkExistVirtualAddr']) {
        // check whether virtualAddr data which is submitted by user is existed
        $sql = "SELECT ifname FROM haif WHERE ifname = '{$_GET['addr']}'";
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort virtual address Table
        freshVirtualListAddr($orderStatement);
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
