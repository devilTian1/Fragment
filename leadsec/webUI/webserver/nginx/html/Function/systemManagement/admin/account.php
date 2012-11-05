<?php
    if (!empty($_POST['expTime'])) {
	@$expTime = $_POST['expTime'];
	$file = $_SERVER['DOCUMENT_ROOT'] . '/Conf/global.php';

	$contents = file_get_contents($file);
	$contents = preg_replace("@\('EXPIRED_TIME',\s?(.*)\)@",
	"('EXPIRED_TIME',$expTime)", $contents);
	file_put_contents($file, $contents);
	echo json_encode(array('msg' => '修改成功', 'status' => 0));
    } else { // init page data
	$db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query('SELECT * FROM accounts')->getAllData(PDO::FETCH_ASSOC);
	V::getInstance()->assign('accounts', $result);
    }
?>
