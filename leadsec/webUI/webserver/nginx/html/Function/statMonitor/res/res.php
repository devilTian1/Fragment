<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getMem() {
    	$cli = new cli();
    	$result = $cli->setLog('状态监控的资源状态运行计算内存利用率的脚本')->setGetResult(true)->run('/usr/local/webserver/nginx/html/Script/memUsed.sh');       	
    	return $result[0];
    }
    function getDev() {
        $cli = new cli();
        $result = $cli->setLog('状态监控的资源状态运行计算磁盘利用率的命令行')->setGetResult(true)->run('df /dev/ram1 -h'); 	
        return $result[1];
    }
    function getCpu() {
    	$cli = new cli();
    	$result = $cli->setLog('状态监控的资源状态运行计算cpu利用率的脚本')->setGetResult(true)->run('/usr/local/webserver/nginx/html/Script/cpuUsed.sh');  	 
    	return $result[0];
    }
    function getStatus(){
    	$cli = new cli();
    	$result = $cli->setLog('状态监控的资源状态查看服务状态')->setGetResult(true)->run('monitor show');
    	foreach($result as $k => $v){
    		if(preg_match('/^sysmon([\s]*)([\S]+)([\s]*)/', $v , $active)){
    			return $active[2];
    		}    			
    	}
        return "error";
    }
    
    function getLastNLinesOfFile($path,$rowsNum){
        $lines = fileLinesToArr($path,'',1);
        $data = array_reverse($lines);
        $data = array_slice($data,0,$rowsNum);
        $preg_str = '/.*\s+([\d\.]+)$/';        
        $arr = array();
        $unixTime = time()*1000;
        foreach($data as $cnt => $line) {
            if(preg_match($preg_str,$line,$match)) {
                $tmpX = $unixTime-10*$cnt*1000;
                $arr[] = floatval($match[1]);
            }
        } 
        
        for ( $i=count($arr) ; $i<$rowsNum ; $i++) {
            $tmpX = $unixTime-10*$i*1000;
            $arr[] = 0;
        }
        $arr = array_reverse($arr);
        $result = array();
        $result = array('starttime'=>$tmpX, 'inline' =>$arr);
        return $result;
    }
    
    if (!empty($_POST['resActive'])) {
    	$active = $_POST['resActive'];
    	$cmd = "monitor set module sysmon active $active";  
    	$cli = new cli();
    	$type = $active === 'on' ? '启用' : '停止';
    	$cli->setLog('状态监控的资源状态服务'.$type)->run($cmd);
        echo json_encode(array('msg' => '修改成功。'));
    } else if (!empty($_POST['clearData'])){
    	$cmd = 'sysmon -c';
    	$cli = new cli();
    	$cli->setLog('状态监控的资源状态清除')->run($cmd);
    	echo json_encode(array('msg' => '修改成功。'));
    }else if (!empty($_POST['info'])){
    	if($_POST['info'] === 'mem'){
    		$cli = new cli();
    		$MemTotal = array();
    		$memdata = array();
    		$meminfo = $cli->setLog('状态监控的资源状态查看内存信息')->setGetResult(true)->run('cat /proc/meminfo');
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
    } else if ($_POST['openCPUChartDialog']) {
        // open CPU Chart Dialog
        $tpl =  'statMonitor/res/editCPUChartsDialog.tpl';
        $path = '/etc/.cpu_new';
        $rowsNum = 30;
        $match = getLastNLinesOfFile($path,$rowsNum);
        $result = V::getInstance()->assign('curve', $match)
                                                    ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_GET['cpu']) {
        $path = '/etc/.cpu_new';
        $rowsNum = $_POST['timeList']*6;
        $match = getLastNLinesOfFile($path,$rowsNum);
        echo json_encode(array('inline'=>$match['inline'],'starttime'=>$match['starttime'],'msg' => '刷新成功。'));
    } else if ($_POST['openMemChartDialog']) {
        // open Memory Chart Dialog
        $tpl =  'statMonitor/res/editMemChartsDialog.tpl';
        $path = '/etc/.mem_new';
        $rowsNum = 30;
        $match = getLastNLinesOfFile($path,$rowsNum);
        $result = V::getInstance()->assign('curve', $match)
                                                    ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    }  else if ($_GET['mem']) {
        $path = '/etc/.mem_new';
        $rowsNum = $_POST['timeList']*6;
        $match = getLastNLinesOfFile($path,$rowsNum);
        echo json_encode(array('inline'=>$match['inline'],'starttime'=>$match['starttime'],'msg' => '刷新成功。'));
    }else{

    	$memused = getMem();
    	$devused = preg_split('/[\s]+/',getDev());
		$deveused_rate = round(((float)$devused[4]/100)*100,2).'.00';
    	$cpuused = getCpu();
    	$active = getStatus();
    	V::getInstance()->assign('cpuused', $cpuused)
    	                ->assign('memused', $memused)
    	                ->assign('devused', $deveused_rate.'%')
    	                ->assign('active', $active);
    }
    	
?>
