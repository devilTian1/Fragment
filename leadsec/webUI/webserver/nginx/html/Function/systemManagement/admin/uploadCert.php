<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if ($_FILES['CAcert2']['error'] === 4) { // no cacert2 file
	unset($_FILES['CAcert2']);
    }
    // upload cert file
    $fs = new fileUpload($_FILES);
    list($status, $msg) = $fs->upload();
    if ($status !== 0) {
        echo json_encode(array('status' => $status,
	    'msg' => $msg));
	return false;
    }

    $cmd = "admcert add cacert \"{$_FILES['CAcert']['name']}\" " .
        "ngcert \"{$_FILES['SIScert']['name']}\" " .
        "ngkey \"{$_FILES['SISkey']['name']}\"";
    try {
        $cli = new cli();
        $cli->run($cmd);
    } catch (Exception $e) {
        echo json_encode(array('status' => -1, 'msg' => $e->getMessage()));
	return false;
    }
    echo json_encode(array('status' => $status, 'msg' => '导入成功'));
?>
