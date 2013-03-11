<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function includeFunc($buffer) {
        preg_match('/^[^\s\/]+/', $buffer, $match);
        return $match;
    }

    function getFeStat($str) {
        $result = array();
        list($enable, $active) = str_split($str, 1);
        $result['enable'] = $enable;
        $result['active'] = $active;
        return $result;
    }

    function getIfStat($v) {
        $result  = array();
        $numox   = substr($v, 0, 1);
        $statox  = substr($v, 1);
        $numdec  = hexdec($numox);
        $statbin = base_convert($statox, 16, 2);

        for($i = 1; $i <= $numdec; $i++) {
            $feName    = "fe$i";
            $feStatStr = substr($statbin, ($i - 1) * 2, 2);
            $result[$feName] = getFeStat($feStatStr);
        }
        return $result;
    }

    function freshStatus() {
        $result = array();
        $curDevName = '';
        //$line = fileLinesToArr('/etc/ha.d/all_status', '', 1, 'includeFunc');
		$line = fileLinesToArr(WEB_PATH.'/all_status', 100, 'includeFunc');
		
        foreach ($line as $l) {
            if (preg_match('/^\[(.+)\]$/', $l[0], $match)) {
                $curDevName = $match[1];
                $result[$curDevName] = array();
            } else {
                // key:value
                list($key, $val) = explode(':', $l[0]);
                if ($key === 'ifstatus') {
                    $val = getIfStat($val);
                } else if ($key == 'status') {
                    if ($val === '1') {
                        $val = '正常';
                    } else if ($val === '2') {
                        $val = '异常';
                    }
                } else if ($key == 'hastatus') {
                    if ($val === '1') {
                        $val = '主闸';
                    } else if ($val === '2') {
                        $val = '从闸';
                    }
                } else if ($key === 'cpu' || $key === 'mem') {
                    $val .= '%';
                }
                $result[$curDevName][$key] = $val;
            }
        }
       return $result;
    }
    if (@$_GET['act']=='getstatus') {
    	$id=$_GET['id'];//根据唯一ID来判断
    	$allstatus=freshStatus();
    	$arr=explode("__",$id);
    	$flag=$arr[0];
    	$fe=$arr[1];
    	$enable=$allstatus[$flag]["ifstatus"][$fe]["enable"];
    	$active=$allstatus[$flag]["ifstatus"][$fe]["active"];
    	//1正常0未启动-1异常
    	if($enable==0){
    		echo 0;
    		exit();
    	}elseif($active==1){
    		echo 1;
    		exit();
    	}else{
    		echo -1;
    		exit(-1);
    	}
        
    }else {
    	$allstatus=freshStatus();
        // init page data
        V::getInstance()->assign('master_in', $allstatus['master_in'])
            ->assign('master_out', $allstatus['master_out'])
            ->assign('slave_in', $allstatus['slave_in'])
	        ->assign('slave_out', $allstatus['slave_out'])
	        ->assign('linkstatus', $allstatus['linkstatus']);
    }
?>
