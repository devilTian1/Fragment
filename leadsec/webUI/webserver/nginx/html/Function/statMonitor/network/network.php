<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshNetworkTable($where) {
        //$cli = new cli();
        //$cmd = "getics";
        //$cli->run($cmd);
        $tpl =  'statMonitor/network/networkTable.tpl';
        $result = getNetworkFromInterfaceDb($where);   
        $data = array();
             
        $path = '/proc/net/dev';
        $cli = new cli();
        $preg_str = '/^\s+eth\d+:\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+' .
                            '(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+' . 
                            '(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$/';
        foreach ($result as $arr) {
            $file = $cli->run("cat ".$path . "|grep -a '" . $arr['internal_name'] . ":'");
            if(!empty($file[0]) && preg_match($preg_str,$file[0], $match)) {
                if ($match[1]==='0' && $match[9]==='0') {
                    $deviceOn ='off';
                } else {
                    $deviceOn ='on';
                }
                $data[] = array(
                                            'external_name' => $arr['external_name'],
                                            'deviceOn' => $deviceOn,
                                            'receiveByte' => $match[1],
                                            'transmitByte' =>$match[9]
                                            );
            } else {
                $data[] = array(
                                            'external_name' => $arr['external_name'],
                                            'deviceOn' => 'off',
                                            'receiveByte' => '0',
                                            'transmitByte' =>'0'
                                            );
            }
        }
        echo V::getInstance()->assign('network', $data)
            ->fetch($tpl);
    }
    
    function getNetworkFromInterfaceDb($where) {
        $sql = "SELECT * FROM interface WHERE device_type = 1 $where";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        return $result;
    }
    
    function getInterfacemonStatus() {
        $sql = "SELECT active FROM monitor WHERE name = 'interfacemon'";
        $db  = new dbsqlite(DB_PATH . '/option.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['active'];
    }
    
    function getInternalNameFrDB($exName) {
        $sql = "SELECT internal_name FROM interface WHERE device_type=1 AND external_name='" . $exName . "'";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['internal_name'];
    }

    if ($_POST['freshTable']) {
        $cli = new cli();
        $cmd = "getics";
        $cli->run($cmd);
        echo json_encode(array('msg' => "已刷新."));
    } else if ($_POST['cleanUp']) {
        $cli = new cli();
        $cmd = "interfacemon -c";
        $cli->run($cmd);
        echo json_encode(array('msg' => "已清空."));
    } else if (isset($_POST['interfacemonActive'])) {
        $status = 0;
        if ($_POST['interfacemonActive'] === '1') {
            $cmd = "monitor set module interfacemon active off";
            $msg =  "已停止.";
        } else if ($_POST['interfacemonActive'] === '0') {
            $cmd = "monitor set module interfacemon active on";
            $msg =  "已启动.";
        } else {
            $status = -1;
            $msg = '执行动作错误.';
            echo json_encode(array('msg' => $msg, 'status' => $status));
            return;
        }
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => $msg, 'status' => $status));
    } else if ($_POST['openNetworkDialog']) {
        $tpl =  'statMonitor/network/editNetworkDialog.tpl';
        $externalName = $_POST['externalName'];
        $internalName = getInternalNameFrDB($externalName);
        $path = '/proc/net/dev';
        $cli = new cli();
        $preg_str = '/^\s+eth\d+:\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+' .
                            '(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+' . 
                            '(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$/';
        $file = $cli->run("cat ".$path . "|grep -a '" . $internalName . ":'");
        if(!empty($file[0]) && preg_match($preg_str,$file[0], $match)) {
            $data = array(
                                        'external_name' => $externalName,     'recvBytes' => $match[1],
                                        'recvPackets' => $match[2],                  'recvErrs' => $match[3],
                                        'recvDrop' => $match[4],                      'recvFifo' => $match[5],
                                        'recvFrame' => $match[6],                    'recvCompressed' => $match[7],
                                        'recvMulticast' => $match[8],               'transBytes' =>$match[9],
                                        'transPackets' => $match[10],              'transErrs' => $match[11],
                                        'transDrop' => $match[12],                  'transFifo' => $match[13],
                                        'transColls' => $match[14],                  'transCarrier' => $match[15],
                                        'transCompressed' => $match[16]
                                        );
        }
        $result = V::getInstance()->assign('net', $data)
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($orderStatement = $_POST['orderStatement']) {
        freshNetworkTable($orderStatement);
    } else {
        // init page data 
        $interfacemon = getInterfacemonStatus();
        //$cli = new cli();
        //$cmd = "getics";
        //$cli->run($cmd);
        V::getInstance()->assign('interfacemon', $interfacemon)
	        ->assign('cardStatus', 1);
    }
?>
