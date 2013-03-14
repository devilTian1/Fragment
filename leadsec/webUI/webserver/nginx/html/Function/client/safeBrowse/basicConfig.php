<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (isset($_POST['httpPort']) && isset($_POST['httpsPort'])) {
        // modify basic config
        $nativeIp  = $_POST['nativeIp'];
        $nativePort  = $_POST['nativePort'];
        $httpGet  = $_POST['httpGet']   === 'on' ? 'GET' : '';
        $httpPost  = $_POST['httpPost'] === 'on' ? 'POST' : '';
        $httpConnect = $_POST['httpConnect']   === 'on' ? 'CONNECT' : '';
        $httpHead  = $_POST['httpHead'] === 'on' ? 'HEAD' : '';
        $httpPort = $_POST['httpPort'];
        $httpsPort = $_POST['httpsPort'];
        
        $cmd = Array();        
        $cmd[] = "httpctl set service ip $nativeIp port $nativePort";
        $cmd[] = "httpctl set allowmethod $httpPost $httpGet $httpConnect $httpHead";
        $cmd[] = "httpctl set httpport $httpPort";
        $cmd[] = "httpctl set httpsport $httpsPort";
        $cli = new cli();
        foreach ($cmd as $arr) {
        	$cli->run($arr);
        }
        $cli->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功.'));
   } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_http.db');
        $result = $db->query('SELECT * FROM basic_configure')
                     ->getFirstData(PDO::FETCH_ASSOC);
        $httpMethod = $db->query('SELECT * FROM http_method')
                     ->getAllData(PDO::FETCH_ASSOC);
        foreach ($httpMethod as $arr) {
        	switch ($arr['method']) {
        		case 'GET':
        			$httpGet = $arr['allow'];
        			break;
        		case 'POST':
        			$httpPost = $arr['allow'];
        			break;
        		case 'CONNECT':
        			$httpConnect = $arr['allow'];
        			break;
        		case 'HEAD':
        			$httpHead = $arr['allow'];
        			break;
        		default:
        			break;
        	}
        }
        $Port = $db->query('SELECT * FROM http_port')
                     ->getAllData(PDO::FETCH_ASSOC);
        $httpPort = Array();
        $httpsPort = Array();
		foreach ($Port as $arr) {
			if ($arr['https'] === '0') {
				$httpPort[] = $arr['port'];
			} else {
				$httpsPort[] = $arr['port'];
			}
		}
		$httpPortStr = join(',',$httpPort);
		$httpsPortStr = join(',',$httpsPort);
        V::getInstance()->assign('editBasicConfig', $result)
        				->assign('httpGet', $httpGet)
        				->assign('httpPost', $httpPost)
        				->assign('httpConnect', $httpConnect)
        				->assign('httpHead', $httpHead)
        				->assign('httpPort', $httpPortStr)
        				->assign('httpsPort', $httpsPortStr)
        				->assign('interfaceList', netGapRes::getInstance()->getInterface());
    }
?>
