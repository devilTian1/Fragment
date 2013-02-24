<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
	function getHostname(){//get hostname
		$db = new dbsqlite(DB_PATH . '/configs.db');
        $result = $db->query("SELECT hostname FROM hostname")
                     ->getFirstData(PDO::FETCH_ASSOC);
        return $result['hostname'];
	}
	//get dev info
	function getDevInfo(){
		$devinfo=array();
		$devinfo['hostname']=getHostname();
		$devinfo['serialnum']="d6757df2b05c23cb";
		$devinfo['devnum']="SIS-3000-Z6101";
		$devinfo['softnum']="1.0.200.31";
		return $devinfo;
	}
	//get license info
    function getLicenseInfo(){
    	$liceinfo=array();
    	$liceinfo[0]['name']="文件交换";
    	$liceinfo[0]['status']=1;
    	$liceinfo[0]['remark']="提示信息";
    	
    	$liceinfo[1]['name']="数据库同步";
    	$liceinfo[1]['status']=0;
    	$liceinfo[1]['remark']="相关信息";
    	
    	$liceinfo[2]['name']="安全浏览";
    	$liceinfo[2]['status']=1;
    	$liceinfo[2]['remark']="相关信息";
    	
    	$liceinfo[3]['name']="文件交换";
    	$liceinfo[3]['status']=0;
    	$liceinfo[3]['remark']="相关信息";
    	return $liceinfo;
    }
	
	if ('edit' === $_POST['type']) {
        // Edit a specified addr group data
        list($name, $comment, $addmbr) = getAddOrEditData();
        $cmd1 = "addrgrp set name \"$name\" comment \"$comment\"";
        $cmd2 = "addrgrp set name \"$name\" delallmbr";
        $cmd3 = "addrgrp set name \"$name\" addmbr \"$addmbr\"";
        $cli  = new cli();
        $cli->run($cmd1);
        $cli->run($cmd2);
        $cli->run($cmd3);
        echo json_encode(array('msg' => "[$name]修改成功."));
    } else if ('add' === $_POST['type']) {
        // Add a new addr group data
        list($name, $comment, $addmbr) = getAddOrEditData();
        $cmd1 = "addrgrp add name \"$name\" comment \"$comment\"";
        $cmd2 = "addrgrp set name \"$name\" addmbr \"$addmbr\"";
        $cli  = new cli();
        $cli->run($cmd1);
        $cli->run($cmd2);
        echo json_encode(array('msg' => "[$name]添加成功."));
    } elseif('getImgData' === $_POST['type']){
    	$eth=$_POST['eth'];//根据不同的网关来查找相关的数据
    	$pe=array();
    	$time=time();
    	
    	$pe[0]['x']=$pe[1]['x']=$pe[2]['x']=intval($time)*1000;
    	$pe[0]['y']=rand(1,20);
    	$pe[1]['y']=rand(1,20);
    	$pe[2]['y']=rand(1,20);
    	echo json_encode($pe);
    }
    else {
        // init page data
        $devinfo=getDevInfo();
        $liceinfo=getLicenseInfo();
        V::getInstance()->assign('devinfo', $devinfo)
        	->assign('liceinfo', $liceinfo)
	        ->assign('next', 2);
    }
?>
