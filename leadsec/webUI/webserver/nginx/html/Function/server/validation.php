<?php
    require_once('../common.php');
    $errMsg = array();
    $res    = netGapRes::getInstance();
    
    // receiveTask Client
    if (($id = $_GET['receiveGeneralId']) &&
    		('false' === $res->checkExistTaskId('fileEx', $id))) {
    	$errMsg[] = '任务号已存在';
    }
	// server sfileSyncTaskId
	if (($id = $_GET['sfileSyncGeneralId']) &&
    		('false' === $res->checkExistTaskId('fileSync', $id))) {
    	$errMsg[] = '任务号已存在';
    }
	//server serverDbSyncTaskId
	if (($id = $_GET['serverDbSyncGeneralId']) &&
    		('false' === $res->checkExistTaskId('dbSync', $id))) {
    	$errMsg[] = '任务号已存在';
    }
    echo json_encode(array('msg' => $errMsg));
    return true;
?>
