<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
	$str = 'hello!hello!hello!';


	if ('getStr' === $_POST['action']) {
		echo json_encode(array('status' => true, 'msg' => $str));
	} else {
	
	}
	
?>