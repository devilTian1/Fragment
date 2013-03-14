<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getMem() {
    	$cli = new cli();
    	$result = $cli->run('/usr/local/webserver/nginx/html/Script/memUsed.sh');
    	return $result[0];
    }
    function getDev() {
        $cli = new cli();
    	$result = $cli->run('df /dev/ram1 -h');
    	
        return $result[1];
    }
    function getCpu() {
    	$cli = new cli();
    	$result = $cli->run('/usr/local/webserver/nginx/html/Script/cpuUsed.sh');   	 
    	return $result[0];
    }
    function getStatus(){
    	$cli = new cli();
    	$result = $cli->run('monitor show');
    	if(preg_match('/^sysmon([\s]*)([\S]+)([\s]*)/', $result[2] , $active))
    	    return $active[2];
    	else 
    		return "off";
    }
    if (!empty($_POST['resActive'])) {
    	$active = $_POST['resActive'];
    	$cmd = "monitor set module sysmon active $active";  
    	$cli = new cli();
    	$cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if (!empty($_POST['clearData'])){
    	$cmd = 'interfacemon -c';
    	$cli = new cli();
    	$cli->run($cmd);
    	echo json_encode(array('msg' => '修改成功.'));
    }else if (!empty($_POST['info'])){
    	if($_POST['info'] === 'mem'){
    		$cli = new cli();
    		$MemTotal = array();
    		$memdata = array();
    		$meminfo = $cli->run('cat /proc/meminfo');
    		foreach ($meminfo as $k => $v){
    			if(preg_match('/^MemTotal:([\s]*)([\d]+[\s]*[\S]+)/', $v ,$MemTotal))
    			{
    				$memdata['MemTotal'] = $MemTotal[2];
    			}
    			else if(preg_match('/^MemFree:([\s]*)([\d]+[\s]*[\S]+)/', $v ,$MemFree))
    			{
    				$memdata['MemFree'] = $MemFree[2];
    			}
    			else if(preg_match('/^Buffers:([\s]*)([\d]+[\s]*[\S]+)/', $v ,$Buffers))
    			{
    				$memdata['Buffers'] = $Buffers[2];
    			}
    			else if(preg_match('/^Cached:([\s]*)([\d]+[\s]*[\S]+)/', $v ,$Cached))
    			{
    				$memdata['Cached'] = $Cached[2];
    			}
    			else if(preg_match('/^SwapCached:([\s]*)([\d]+[\s]*[\S]+)/', $v ,$SwapCached))
    			{
    				$memdata['SwapCached'] = $SwapCached[2];
    			}
    			else if(preg_match('/^DirectMap4k:([\s]*)([\d]+[\s]*[\S]+)/', $v ,$DirectMap4k))
    			{
    				$memdata['DirectMap4k'] = $DirectMap4k[2];
    			}
    			else if(preg_match('/^DirectMap4M:([\s]*)([\d]+[\s]*[\S]+)/', $v ,$DirectMap4M))
    			{
    				$memdata['DirectMap4M'] = $DirectMap4M[2];
    			}
    		}
    		$result = V::getInstance()->assign('meminfo', $memdata)
    		->fetch('statMonitor/res/meminfo.tpl');
    	}else{
    		$devused = preg_split('/[\s]+/',getDev());
    		$result = V::getInstance()->assign('v', $devused)
    		->fetch('statMonitor/res/devinfo.tpl');
    	}
    	echo json_encode(array('msg' => $result));
    }else{

    	$memused = getMem();
    	$devused = preg_split('/[\s]+/',getDev());
    	$cpuused = getCpu();
    	$active = getStatus();
    	V::getInstance()->assign('cpuused', $cpuused)
    	                ->assign('memused', $memused)
    	                ->assign('devused', $devused[4])
    	                ->assign('active', $active);
    }
    	
?>
