<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    if (!empty($_POST['expTime'])) {
	@$expTime = $_POST['expTime'];
	$file = $_SERVER['DOCUMENT_ROOT'] . '/Conf/global.php';

	$contents = file_get_contents($file);
	$contents = preg_replace("@\('EXPIRED_TIME',\s?(.*)\)@",
	    "('EXPIRED_TIME',$expTime)", $contents);
	file_put_contents($file, $contents);
	echo json_encode(array('msg' => '修改成功', 'status' => 0));

    } else if (!empty($_POST['delUser'])) {
        $name   = $_POST['delUser'];
        $cmd    = "echo $name"; // TODO
        $cli    = new cli();
        $result = $cli->run($cmd);
        echo json_encode(array('msg' => $result));

    } else { // init page data
	$db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM accounts')->getAllData(PDO::FETCH_ASSOC);
	V::getInstance()->assign('accounts', $result);
    }
?>
