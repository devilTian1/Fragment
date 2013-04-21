<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshSchedulrTable($where) {
        $tpl =  'networkManagement/lvs/scheduleTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $sql = "SELECT virtual_ip,virtual_port FROM service WHERE id=1 $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $schedule = array();
        foreach ($result as $arr) {
            $sql = "SELECT * FROM service WHERE virtual_ip='" . $arr['virtual_ip'] . "' AND virtual_port='" . $arr['virtual_port'] . "'";
            $result_e = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            $schedule[] = array(
                                            'virtual_ip' => $result_e[0]['virtual_ip'],
                                            'virtual_port' => $result_e[0]['virtual_port'],
                                            'real_ip1' => $result_e[0]['real_ip'],
                                            'real_port1' =>$result_e[0]['real_port'],
                                            'real_ip2' => $result_e[1]['real_ip'],
                                            'real_port2' =>$result_e[1]['real_port']
                                            );
        }
        echo V::getInstance()->assign('schedule', $schedule)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
    function getFrDbByIp($ip,$port) {
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $sql = "SELECT * FROM service WHERE virtual_ip='" . $ip . "' AND virtual_port='" . $port . "'";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        return $result;
    }
    
    function getScheduleByIp($ip,$port) {
        $result = getFrDbByIp($ip,$port);
        $realAddr = array();
        $realPort = array();
        foreach ($result as $key => $arr) {
            $realAddr[] = $arr['real_ip'];
            $realPort[] = $arr['real_port'];
        }
        $data = array(
                                'virtual_ip'=>$result[0]['virtual_ip'],
                                'virtual_port'=>$result[0]['virtual_port'],
                                'rAddrBuf'=>$realAddr,
                                'rPortBuf'=>$realPort);
        return $data;
    }

    function getVirtualAddrList() {
        $result = array('' => '无');
        $sql = 'SELECT ifname FROM haif';
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $d) {
            $db  = new dbsqlite(DB_PATH . '/configs.db');
            $sql = 'SELECT ip FROM interface ' .
                "WHERE external_name = '{$d['ifname']}' AND enable = 1";
            $ifData = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $ip = $ifData['ip'];
            $result[$ip] = $ip;
        }
        return $result;
    }

    function getDataCount() {
        $sql = 'SELECT id FROM service WHERE id=1';
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        return $db->query($sql)->getCount();
    }
    
    function getAddCmd() {
        $cmdBuf = array(array());
        if ($_POST['type']=== 'edit') {
            $virtualAddr = $_POST['delVirtualIp'];
            $virtualPort = $_POST['delVirtualPort'];
        } else {
            $virtualAddr = $_POST['virtualAddr'];
            $virtualPort = $_POST['virtualPort'];
        }
        for ($i=1 ; $i<17 ; $i++) {
            $realip = $_POST['realAddr' . $i];
            $realport = $_POST['realPort' . $i];
            if(!empty($realip) && !empty($realport)) {
                $cmdBuf[]['cmd'] = 'lvsctl add service vip ' . $virtualAddr . ' vport ' . $virtualPort . ' rip ' . $realip . ' rport ' . $realport;
                $cmdBuf[]['log'] = '添加网络管理的调度配置:'.$virtualAddr;               
            }
        }
        return $cmdBuf;
    }

    if ($_POST['type'] === 'add') {
        // add a new realaddr
        $cmdBuf = getAddCmd();
        $cli = new cli();
        foreach($cmdBuf as $cmd) {
            $cli->setLog($cmd['log'])->run($cmd['cmd']);
        }
        $cli->setLog('网络管理的调度配置:reconfigure')->run('lvsctl reconfigure');
        //$cli->setLog('网络管理的调度配置停止')->run('lvsctl stop');
        //$cli->setLog('网络管理的调度配置启用')->run('lvsctl start');
        echo json_encode(array('msg' => '添加成功.'));
    } else if ($_POST['type'] === 'edit') {
        $ip = $_POST['delVirtualIp'];
        $port = $_POST['delVirtualPort'];
        $result = getFrDbByIp($ip,$port);        
        $cli = new cli();
        foreach ($result as $arr) {
            $cmd = 'lvsctl del service vip ' . $arr['virtual_ip'] . ' vport ' . $arr['virtual_port'] . ' rip ' . $arr['real_ip'] . ' rport ' . $arr['real_port'];
            $cli->setLog('删除网络管理的调度配置:'.$arr['virtual_ip'])->run($cmd);
        }
        $cmdBuf = getAddCmd();
        foreach($cmdBuf as $cmd) {
            $cli->setLog($cmd['log'])->run($cmd['cmd']);
        }
        $cli->setLog('网络管理的调度配置:reconfigure')->run('lvsctl reconfigure');
        //$cli->setLog('网络管理的调度配置停止')->run('lvsctl stop');
        //$cli->setLog('网络管理的调度配置启用')->run('lvsctl start');
        echo json_encode(array('msg' => '修改成功.'));
    } else if ($_POST['openNewRealAddrDialog']) {
        // open add-new-real-addr dialog
        $tpl    = 'networkManagement/lvs/editScheduleDialog.tpl';
        $virtualAddrList = getVirtualAddrList();
        $result = V::getInstance()->assign('virtualAddrList', $virtualAddrList)            
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_POST['openEditRealAddrDialog']) {
        // edit exist-real-addr dialog
        $ip = $_POST['rip'];
        $port = $_POST['rport'];
        $result = getScheduleByIp($ip,$port);
        $tpl    = 'networkManagement/lvs/editScheduleDialog.tpl';
        $virtualAddrList = getVirtualAddrList();        
        $result = V::getInstance()->assign('virtualAddrList', $virtualAddrList)   
            ->assign('result',$result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_POST['delRealAddr']) {
        $ip = $_POST['delIp'];
        $port = $_POST['delPort'];        
        $result = getFrDbByIp($ip,$port);
        $cli = new cli();
        foreach ($result as $arr) {
            $cmd = 'lvsctl del service vip ' . $arr['virtual_ip'] . ' vport ' . $arr['virtual_port'] . ' rip ' . $arr['real_ip'] . ' rport ' . $arr['real_port'];
            $cli->setLog('删除网络管理的调度配置:'.$arr['virtual_ip'])->run($cmd);
        }
        $cli->setLog('网络管理的调度配置:reconfigure')->run('lvsctl reconfigure');
        //$cli->setLog('网络管理的调度配置停止')->run('lvsctl stop');
        //$cli->setLog('网络管理的调度配置启用')->run('lvsctl start');
        echo json_encode(array('msg' => '删除成功.'));
    } else if ($_GET['checkExistVirtualAddr']) {
        $check = array('virtualAddr' => $_GET['virtualAddr'],'virtualPort' => $_GET['virtualPort']);        
        echo netGapRes::getInstance()->checkExistTaskId('schedule',$check);
    } else if ($orderStatement = $_POST['orderStatement']) {
        freshSchedulrTable($orderStatement);
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
