<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

	function getCmd($type) {
		$db = new dbsqlite(DB_PATH . '/netgap_http.db');
		if($type === 'application') {
			$result = $db->query('SELECT * FROM mime WHERE type=\'A\'')
                     ->getAllData(PDO::FETCH_ASSOC);
		} else if ($type === 'video') {
			$result = $db->query('SELECT * FROM mime WHERE type=\'V\'')
                     ->getAllData(PDO::FETCH_ASSOC);
		} else if ($type === 'audio') {
			$result = $db->query('SELECT * FROM mime WHERE type=\'U\'')
                     ->getAllData(PDO::FETCH_ASSOC);
		} else if ($type === 'image') {
			$result = $db->query('SELECT * FROM mime WHERE type=\'I\'')
                     ->getAllData(PDO::FETCH_ASSOC);
		} else if ($type === 'text') {
			$result = $db->query('SELECT * FROM mime WHERE type=\'T\'')
                     ->getAllData(PDO::FETCH_ASSOC);
		} else {
		}
		$cmd = array();
		foreach ($result as $arr) {
			$name = str_replace('.','_',$arr['name']);
			$opt = $_POST[$name] === "on" ? "on" : "off";		
			$cmd[] = "httpctl set mime type $type name \"" . $arr['name'] . "\" opt $opt";			
		}
		return $cmd;
	}

    if (isset($_GET['filterGl'])) {
        // modify dns ip
        $activex  = $_POST['filterActivex'] === 'on' ? 'on' : 'off';
        $cookie  = $_POST['filterCookie']   === 'on' ? 'on' : 'off';
        $script  = $_POST['filterScript']   === 'on' ? 'on' : 'off';
        $java  = $_POST['disableJava']      === 'on' ? 'on' : 'off';
        $cmd = "httpctl set cf activex $activex cookie $cookie javascript $script javaapplet $java";
        $cli = new cli();
        $cli->run($cmd);
        $cli->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功.'));
    } else if (isset($_GET['mime'])) {    	
		if ($_POST['application'] === 'F') {
			$app = 'on';
		} else if ($_POST['application'] === 'P') {
			$app = 'partial';
		} else {
			$app = 'off';
		}
		if ($_POST['video'] === 'F') {
			$video = 'on';
		} else if ($_POST['video'] === 'P') {
			$video = 'partial';
		} else {
			$video = 'off';
		}
		if ($_POST['audio'] === 'F') {
			$audio = 'on';
		} else if ($_POST['audio'] === 'P') {
			$audio = 'partial';
		} else {
			$audio = 'off';
		}
		if ($_POST['image'] === 'F') {
			$image = 'on';
		} else if ($_POST['image'] === 'P') {
			$image = 'partial';
		} else {
			$image = 'off';
		}
		if ($_POST['text'] === 'F') {
			$text = 'on';
		} else if ($_POST['text'] === 'P') {
			$text = 'partial';
		} else {
			$text = 'off';
		}
    	$cmd = "httpctl set cf application $app video $video audio $audio image $image text $text";
    	
    	$cli = new cli();
        $cli->run($cmd);
        if ($app === 'partial') {
	        $appCmd = getCmd('application');
	        foreach ($appCmd as $cmd) {
	        	$cli->run($cmd);
	        }
    	}
    	if ($video === 'partial') {
	        $videoCmd = getCmd('video');
	        foreach ($videoCmd as $cmd) {
	        	$cli->run($cmd);
	        }
    	}
    	if ($audio === 'partial') {
	        $audioCmd = getCmd('audio');
	        foreach ($audioCmd as $cmd) {
	        	$cli->run($cmd);
	        }
    	}
    	if ($image === 'partial') {
	        $imageCmd = getCmd('image');
	        foreach ($imageCmd as $cmd) {
	        	$cli->run($cmd);
	        }
    	}
    	if ($text === 'partial') {
	        $textCmd = getCmd('text');
	        foreach ($textCmd as $cmd) {
	        	$cli->run($cmd);
	        }
    	}
        $cli->run("httpctl	reconfigure");
        echo json_encode(array('msg' => '修改成功.'));
   } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/netgap_http.db');
        $result = $db->query('SELECT * FROM cf_info')
                     ->getFirstData(PDO::FETCH_ASSOC);
        $appList = $db->query('SELECT * FROM mime WHERE type=\'A\'')
                     ->getAllData(PDO::FETCH_ASSOC);
        $videoList = $db->query('SELECT * FROM mime WHERE type=\'V\'')
                     ->getAllData(PDO::FETCH_ASSOC);
        $audioList = $db->query('SELECT * FROM mime WHERE type=\'U\'')
                     ->getAllData(PDO::FETCH_ASSOC);
        $imageList = $db->query('SELECT * FROM mime WHERE type=\'I\'')
                     ->getAllData(PDO::FETCH_ASSOC);
        $textList = $db->query('SELECT * FROM mime WHERE type=\'T\'')
                     ->getAllData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('filter', $result)
        				->assign('appList', $appList)
        				->assign('videoList', $videoList)
        				->assign('audioList', $audioList)
        				->assign('imageList', $imageList)
        				->assign('textList', $textList);
    }
?>