<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshNetworkTable($where) {
        $tpl =  'statMonitor/network/networkTable.tpl';
        $result = getNetworkFromInterfaceDb($where);   
        $data = array();
             
        $path = '/proc/net/dev';
        //$cli = new cli();
        $preg_str = '/^\s+eth\d+:\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+' .
                            '(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+' . 
                            '(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$/';
        foreach ($result as $arr) {
            //$file = $cli->run("cat ".$path . "|grep -a '" . $arr['internal_name'] . ":'");
            $file = fileLinesToArr($path,'',1,'filterAllDev',NULL,$arr['internal_name']);
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
    
    function filterAllDev ($line,$keyword=NULL) {
        preg_match('/^\s+' . $keyword . ':.*/', $line, $match);        
        return $match[0];
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
    
    function getDeviceList() {
        $sql = "SELECT external_name FROM interface WHERE device_type = 1 ORDER BY external_name ASC";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $name = $d['external_name'];
            $result[$name] = $name;
        }
        return $result;
    }
    
    function freshCurrentTable($exName,$selectDevice) {
        $internalName = getInternalNameFrDB($exName);
        $path = '/proc/net/dev';
        //$cli = new cli();
        $preg_str = '/^\s+eth\d+:\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+' .
                            '(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+' . 
                            '(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s*$/';
        //$file = $cli->run("cat ".$path . "|grep -a '" . $internalName . ":'");
        if ($selectDevice == 1) {
            $file = fileLinesToArr($path,'',1,'filterSelectDev');
        } else {
            $file = fileLinesToArr($path,'',1,'filterCurrentDev');
        }
        if(!empty($file[0]) && preg_match($preg_str,$file[0], $match)) {
            $data = array(
                                        'external_name' => $exName,     'recvBytes' => $match[1],
                                        'recvPackets' => $match[2],                  'recvErrs' => $match[3],
                                        'recvDrop' => $match[4],                      'recvFifo' => $match[5],
                                        'recvFrame' => $match[6],                    'recvCompressed' => $match[7],
                                        'recvMulticast' => $match[8],               'transBytes' =>$match[9],
                                        'transPackets' => $match[10],              'transErrs' => $match[11],
                                        'transDrop' => $match[12],                  'transFifo' => $match[13],
                                        'transColls' => $match[14],                  'transCarrier' => $match[15],
                                        'transCompressed' => $match[16]
                                        );
             return $data;
        }
    }
    
    function getLastNLinesOfFile($path,$rowsNum) {
        $lines = fileLinesToArr($path,'',1,'filterFlowData');
        //print_r($lines);
        $data = array_reverse($lines);
        $data = array_slice($data,0,$rowsNum);
       /* if ($rowsNum > 150) {
            $data = sampleData($data);
        }*/
        $externalName = $_POST['externalName'];
        $internalName = getInternalNameFrDB($externalName);
        $preg_str = '/.*' . $internalName . '\s+(\d+)\s+(\d+)\s*/';
        $result = array();
        $unixTime = time()*1000;
        foreach($data as $cnt => $line) {
            if(preg_match($preg_str,$line,$match)) {
                $tmpX = $unixTime-10*$cnt*1000;
                $result[] = array('inline' => array('x'=>strval($tmpX),'y'=>$match[1]),
                                             'outline' => array('x'=>strval($tmpX),'y'=>$match[2])
                                             );
            }
        }
        
        for ( $i=count($result) ; $i<$rowsNum ; $i++) {
            $tmpX = $unixTime-10*$i*1000;
            $result[] = array('inline' => array('x'=>strval($tmpX),'y'=>'0'),
                                             'outline' => array('x'=>strval($tmpX),'y'=>'0')
                                             );
        }
        return array_reverse($result);
    }
    
     function filterFlowData ($line) {
        // /tmp/.dmu_new
        $externalName = $_POST['externalName'];
        $internalName = getInternalNameFrDB($externalName);
        preg_match('/.*' . $internalName . '.*/', $line, $match);        
        return $match[0];
    }
    
    function filterCurrentDev ($line) {
        // /proc/net/dev
        $externalName = $_POST['externalName'];
        $internalName = getInternalNameFrDB($externalName);
        preg_match('/^\s+' . $internalName . ':.*/', $line, $match);        
        return $match[0];
    }
    
    function filterSelectDev ($line) {
        // /proc/net/dev
        $externalName = $_POST['deviceList'];
        $internalName = getInternalNameFrDB($externalName);
        preg_match('/^\s+' . $internalName . ':.*/', $line, $match);        
        return $match[0];
    }
    
    function sampleData($data) {
        $result = array();
        while (count($data) > 150) {
            unset($result);
            foreach ($data as $n => $val) {
                if ($n%2 === 0) {
                    $result[] = $val;
                }
            }
            $data = $result;
        }
        return $result;
    }

    if ($_POST['freshTable']) {
    // fresh all device table
        $cli = new cli();
        $cmd = "getics";
        $cli->setLog("刷新网络状态页面")->run($cmd);
        echo json_encode(array('msg' => "已刷新。"));
    } else if (isset($_POST['interfacemonActive'])) {
    // enable/disable interfacemon
        $status = 0;
        if ($_POST['interfacemonActive'] === '1') {
            $cmd = "monitor set module interfacemon active off";
            $msg =  "已停止。";
            $activeLog =  "停止";
        } else if ($_POST['interfacemonActive'] === '0') {
            $cmd = "monitor set module interfacemon active on";
            $msg =  "已启动。";
            $activeLog =  "启动";
        } else {
            $status = -1;
            $msg = '执行动作错误。';
            echo json_encode(array('msg' => $msg, 'status' => $status));
            return;
        }
        $cli = new cli();
        $cli->setLog("设备监控服务".$activeLog)->run($cmd);
        echo json_encode(array('msg' => $msg, 'status' => $status));
    } else if ($_POST['openNetworkDialog']) {
        // open CurrentStatus Dialog        
        $deviceList = getDeviceList();
        $tpl =  'statMonitor/network/editNetworkDialog.tpl';
        $externalName = $_POST['externalName'];
        $data = freshCurrentTable($externalName,0);
        $result = V::getInstance()->assign('net', $data)
                                                    ->assign('deviceOptions',$deviceList)
                                                    ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_POST['deviceList']) {
    // fresh Current Status
        $externalName = $_POST['deviceList'];
        $tpl =  'statMonitor/network/editNetworkDialogTable.tpl';
        $data = freshCurrentTable($externalName,1);
        $result_fresh = V::getInstance()->assign('net', $data)->fetch($tpl);
        echo json_encode(array('msg' =>'刷新成功。','msg_result'=>$result_fresh));
    } else if ($_POST['openNetworkChartDialog']) {
    // open network Chart Dialog
        $tpl =  'statMonitor/network/editNetworkCharts.tpl';
        $externalName = $_POST['externalName'];
        $path = '/tmp/.dmu_new';
        $rowsNum = 30;
        $match = getLastNLinesOfFile($path,$rowsNum);
        $result = V::getInstance()->assign('curve', $match)
                                                    ->assign('externalName',$externalName)
                                                    ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_GET['chart']) {
    // fresh Charts
        $path = '/tmp/.dmu_new';
        $rowsNum = $_POST['timeList']*6;
        $match = getLastNLinesOfFile($path,$rowsNum);
        $in = array();
        $out = array();        
        foreach ($match as $data) {
            $in[] = $data['inline'];
            $out[] = $data['outline'];
        }
        echo json_encode(array('msg'=> '刷新成功。','name' => $_POST['externalName'],'inline' => $in,'outline' => $out));
    } else if ($orderStatement = $_POST['orderStatement']) {
        freshNetworkTable($orderStatement);
    } else {
        $cli = new cli();
		list($status,$result) = $cli->setLog("刷新网络状态")->execCmdGetStatus("getics");
		if ($status>0) {
			$cardStatus = '0';
		} else {
			$cardStatus = '1';
		}
        $interfacemon = getInterfacemonStatus();
        V::getInstance()->assign('interfacemon', $interfacemon)
	        ->assign('cardStatus', $cardStatus);
    }
?>
