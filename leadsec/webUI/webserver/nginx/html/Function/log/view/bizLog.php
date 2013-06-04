<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    $priArr = array('紧急', '警报', '临界', '出错',
                    '预警', '提示', '通知', '调试');

    $modArr = array('sync'      => '文件交换',
                    'File-swap' => '文件同步',
                    'DB-swap'   => '数据库同步',
                    'http'      => '安全浏览',
                    'ftp'       => 'FTP访问',
                    'smtp'      => '邮件访问',
                    'pop3'      => '邮件访问',
                    'oracle'    => '数据库访问<oracle>',
                    'sqlserver' => '数据库访问<sqlserver>',
                    'mysql'     => '数据库访问<mysql>',
                    'db2'       => '数据库访问<db2>',
                    'sysbase'   => '数据库访问<sysbase>',
                    'access'    => '数据库访问<access>',
                    'ctcp'      => '定制访问<ctcp>',
                    'cudp'      => '定制访问<cudp>',
                    'ha'        => '双机热备',
                    'ids'       => '入侵检测',
                    'snmp'      => '集中管理',
                    'lvs'       => '负载均衡'
    );

    $searchRegexp = "/devid=" . LOG_DEVID . " date=\"([^\"]+)\" dname=[^\s]+ " .
        'logtype=([0-8]|\d{2,3}) pri=\d+ mod=\S+\s' .
        "event=\"(?:.*\\\".*)|[^\"]+\"/";

    function checkTime($date) {
        $ct = strtotime($date);
        if (($sts = $_POST['startTime_log']) || ($sts = $_GET['startTime_log'])) {
            $st = strtotime($sts);
            if ($st > $ct) {
                return false;
            }
        }
        if (($ets = $_POST['endTime_log']) || ($ets = $_GET['endTime_log'])) {
            $et = strtotime($ets);
            if ($ct > $et) {
                return false;
            }
        }
        return true;
    }

    function getAddrRegexp() {
        $addrArr = array('sAddr' => '', 'sport' => '',
                         'dAddr' => '', 'dport' => '');
        if ($_GET['search'] === '1') {
            $addrArr['sAddr'] = $_POST['sAddr'];
            $addrArr['dAddr'] = $_POST['dAddr'];
            $addrArr['sport'] = $_POST['sport'];
            $addrArr['dport'] = $_POST['dport'];
        } else {
            $addrArr['sAddr'] = $_GET['sAddr'];
            $addrArr['dAddr'] = $_GET['dAddr'];
            $addrArr['sport'] = $_GET['sport'];
            $addrArr['dport'] = $_GET['dport'];
        }
        
        $regexp  = '/';
        if (!empty($addrArr['sAddr'])) {
            $regexp .= "sa={$addrArr['sAddr']}.*";
        }
        if (!empty($addrArr['sport'])) {
            $regexp .= "sport={$addrArr['sport']}.*";
        }
        if (!empty($addrArr['dAddr'])) {
            $regexp .= "da={$addrArr['dAddr']}.*";
        }
        if (!empty($addrArr['dport'])) {
            $regexp .= "dport={$addrArr['dport']}.*";
        }
        $regexp .= '/';
        return $regexp;
    }

    function includeFunc($buffer) {
        global $searchRegexp;
        //if (preg_match(getRegexBySearchParams(), $buffer, $match) && 
        if (preg_match($searchRegexp, $buffer, $match) && 
            checkTime($match[1])) {
            $regexp = getAddrRegexp();
            if (($regexp == '//') || 
                ($regexp != '//' && preg_match($regexp, $buffer))) {
                return $match;
            }
        }
        return false;
    }

    function formatFunc($match) {
        $result = array();
        $result['date']  = $match[1];
        $result['pri']   = $match[2];
        $result['mod']   = $match[3];
        $result['event'] = $match[4];
        return $result;
    }

    function priAscSort($a, $b) {
        $x = intval($a['pri']);
        $y = intval($b['pri']);
        return $x > $y ? 1 : -1;
    }
    function priDescSort($a, $b) {
        $x = intval($a['pri']);
        $y = intval($b['pri']);
        return $x > $y ? -1 : 1;
    }

    function getDataCount() {
        if ($_POST['flag'] === 'freshPage') {
            return $_POST['dataCount'];
        } else {
            $arr = fileLinesToArr(LOG_PATH, '', 1, 'includeFunc');
            return count($arr);
        }
    }

    if ($order = $_POST['orderStatement']) {
        // load log file
        //ORDER BY time DESC LIMIT 10 OFFSET 140
        $regexp = '/^ORDER BY (\w+\s\w+)(?:,\s(\w+\s\w+))?' .
            '(?: LIMIT (\d+) OFFSET (\d+))?$/';
        if (!preg_match($regexp, $order, $match)) {
            throw new Exception("Error: Order Statment is [$order]");
        }
        
        if (!empty($_GET)) {
            $prior   = $_GET['pri'] === 'all'  ? '\d+' : $_GET['pri'];
            $logType = $_GET['logType'] === 'all' ? '(?:[0-8]|\d{2,3})' :
                $_GET['logType'];
            $keyword = empty($_GET['keyword']) ? '(?:.*\\".*)|[^"]+' : 
                '.*' . $_POST['keyword'] . '.*';
            $searchRegexp = "/devid=" . LOG_DEVID . " date=\"([^\"]+)\" " .
                "dname=[^\s]+ logtype=$logType pri=($prior) mod=(\S+)\s" .
                "event=\"($keyword)\"/";
        }
        $p1     = $match[1];
        $p2     = $match[2];
        $limit  = $match[3];
        $offset = $match[4];

        if (!empty($p2)) {
            list($n, $time) = explode(' ', $p1);
            list($n, $pri)  = explode(' ', $p2);
        } else {
            list($k, $v) = explode(' ', $p1);
            $$k =  $v;
        }
    
        $tpl = 'log/view/bizLogTable.tpl';
        $result = fileLinesToArr(LOG_PATH, '', 1, 'includeFunc', 'formatFunc');
        $count  = count($result);
        if ($time === 'DESC') {
            $half = floor($count/2);
            for ($i = 0; $i < $half; $i++) {
                $t = $result[$i];
                $result[$i] = $result[$count-$i-1];
                $result[$count-$i-1] = $t;
            }
        }
        if (!empty($pri)) {
            if ($pri === 'ASC') {
                usort($result, 'priAscSort');
            } else { // DESC
                usort($result, 'priDescSort');
            }
        }
        if (isset($limit, $offset)) {
            $result = array_slice($result, $offset, $limit);
        }
        $html = V::getInstance()->assign('result', $result)
            ->assign('priArr', $priArr)->assign('modArr', $modArr)
            ->assign('keyword', $_GET['keyword'])->fetch($tpl);
        echo json_encode(array('msg' => array('html'  => $html,
                                              'count' => $count)));
    } else if ('1' === $_GET['search']) {
        // Search specified log info
        $tpl = 'log/view/bizLogTable.tpl';
        $prior   = $_POST['pri'] === 'all'  ? '\d+' : $_POST['pri'];
        $logType = $_POST['logType'] === 'all' ? '(?:[0-8]|\d{2,3})' :
            $_POST['logType'];
        $keyword = empty($_POST['keyword']) ? '(?:[\w\d\s\\\"\']*|[^\"]+)' : 
            '(?:[\w\d\s\\\"\']*|[^\"]+)' .
            $_POST['keyword'] . '(?:[\w\d\s\\\"\']*|[^\"]+)';

        $searchRegexp = "/devid=" . LOG_DEVID . " date=\"([^\"]+)\" " .
            "dname=[^\s]+ logtype=$logType pri=($prior) mod=(\S+).*" .
            "event=\"($keyword)\"\s?/";

        $result = fileLinesToArr(LOG_PATH, '', 1, 'includeFunc', 'formatFunc');
        $count  = count($result);
        $result = array_reverse($result);
        $result = array_slice($result, 0, 10);
        $html   = V::getInstance()->assign('result', $result)
            ->assign('priArr', $priArr)->assign('modArr', $modArr)
            ->assign('keyword', $_POST['keyword'])->fetch($tpl);
        echo json_encode(array('msg' => array('html'  => $html,
                                              'count' => $count)));
    } else if ('exportFwlog' === $_POST['action']) {
		//export fw.log
		$filename = LOG_PATH;
		$file = fopen($filename,"r");
		//$filename_s=iconv("utf-8","gb2312",$filename);
		header("Content-Type: application/octet-stream; charset=utf-8;");
		//header("Content-Disposition: attachment; filename=\"$filename_s\";");
		//header("Content-Disposition: attachment; filename=\"$filename\";");
		header("Content-Disposition: attachment; filename=\"fw.log\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
		$buffer=1024;
		$file_count=0;
		//向浏览器返回数据
		while(!feof($file) && $file_count<filesize($filename)){
			$file_con = fread($file,$buffer);
			$file_count+=$buffer;
			echo $file_con;
		}
		fclose($file);
	} else {
        // init page
        $logTypeVal = array('all', '3',   '8',   '301', '302', '303', '304',
                            '305', '306', '308', '311', '312', '313', '314',
                            '330');
        $logTypeArr = array('所有',     '入侵检测', '集中管理',   '文件交换',
                            '安全浏览', 'FTP访问',  '邮件访问',   '数据库访问',
                            '定制访问', '双机热备', '数据库同步', '消息模块',
                            '文件同步', '负载均衡', '安全通道');
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('logTypeArr', $logTypeArr)
            ->assign('logTypeVal', $logTypeVal)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
