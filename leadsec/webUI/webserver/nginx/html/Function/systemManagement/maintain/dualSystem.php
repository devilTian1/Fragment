<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (isset($_POST['defaultStart'])) {
        // Set Default System Start
        $status = 0;
        $msg = '设置成功.';
        if ($_POST['defaultStart'] === '') {
        	    	$status = -1;
	    	$msg = '执行动作错误.';
	    	echo json_encode(array('status' => $status, 'msg' => $msg));
	    	return;
	    }
        $cmd = "vsp set default_os " . $_POST['defaultStart'];
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('status' => $status,'msg' => $msg));
    } else if (isset($_GET['b'])) {
        // Baseup system
        $cli = new cli();
        $cli->run('vsp backup system');
        $path = '/usr/local/vsp';
        $db = new dbsqlite($path . '/vsp.db');
        $result = $db->query('SELECT version_name FROM partition_table WHERE os_name=\'backup_os\'')
                                        ->getFirstData(PDO::FETCH_ASSOC);
        echo json_encode(array('status' => $result['version_name'], 'msg' => '备份成功'));
    } else if (isset($_POST['recoverSystem'])) {
    // recover system
        $recoverSystem = $_POST['recoverSystem'];
        $cli = new cli();
        $cli->run("vsp recover ". $recoverSystem);
        $path = '/usr/local/vsp';
        $db = new dbsqlite($path . '/vsp.db');
        $sql = 'SELECT version_name FROM partition_table WHERE os_name="' . $recoverSystem . '"';
        $result = $db->query($sql)
                                        ->getFirstData(PDO::FETCH_ASSOC);
        echo json_encode(array('status' => $result['version_name'], 'msg' => '恢复成功'));
    } else {
        // init page data
        $path = '/usr/local/vsp';
        $db = new dbsqlite($path . '/vsp.db');
        $result = $db->query('SELECT * FROM partition_table')
                                        ->getAllData(PDO::FETCH_ASSOC);
        foreach ($result as $arr) {
            if ($arr['os_name'] ===  'systemA') {
                $versionA = $arr['version_name'];
            } else if ($arr['os_name'] ===  'systemB') {
                $versionB = $arr['version_name'];
            } else {
                $backupOs = $arr['version_name'];
            }
            if ($arr['default_os'] === '1') {
                $default_os = $arr['os_name'];
                $default_version = $arr['version_name'];
            }
        }
        $cli = new cli();
        $curOs = $cli->run("vsp get current_os");
        $curVersion = $db->query('SELECT version_name FROM partition_table WHERE os_name="' . $curOs[0] . '"')
                                        ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('versionA', $versionA)
                                    ->assign('curOs',$curOs[0])
                                    ->assign('curVersion',$curVersion['version_name'])
        				->assign('versionB', $versionB)
        				->assign('backupOs', $backupOs)
        				->assign('default_os', $default_os)
        				->assign('default_version', $default_version);
    }
?>
