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
        $line = fileLinesToArr('/etc/ha.d/all_status', '', 1, 'includeFunc');
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
       // var_dump($result);
    }
    
    if (@$_GET['act']=='getstatus') {
    	$id=$_GET['id'];//根据唯一ID来判断
       	//echo 1;//正常
       //echo 0;//为启动
       	echo -1;//异常
        
    }else {
        // init page data
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
