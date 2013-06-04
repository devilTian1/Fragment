<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    $priArr = array('紧急', '警报', '临界', '出错',
                    '预警', '提示', '通知', '调试');
    //$priArr = array('all', 'emergency', 'critical', 'error', 'warning', 'notice', 'information', 'debug');

    $searchRegexp = "/devid=" . LOG_DEVID . " date=\"([^\"]+)\" dname=[^\s]+ " .
        "logtype=9 pri=(\d+) mod=webui event=\"(.*)\" from=\"(.*)\" " .
        "admin=\"(.*)\" act=\"(.*)\"/";

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

    function includeFunc($buffer) {
        global $searchRegexp;
        //if (preg_match(getRegexBySearchParams(), $buffer, $match) && 
        if (preg_match($searchRegexp, $buffer, $match) && 
            checkTime($match[1])) {
            return $match;
        } else {
            return false;
        }
    }

    function formatFunc($match) {
        $result = array();
        $result['date']  = $match[1];
        $result['pri']   = $match[2];
        $result['event'] = $match[3];
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
            $act     = $_GET['act'] === 'all'  ? '.*' : $_GET['act'];
            $prior   = $_GET['pri'] === 'all'  ? '.*' : $_GET['pri'];
            $from    = empty($_GET['sAddr'])   ? '.*' : $_GET['sAddr'];
            $keyword = empty($_GET['keyword']) ? '.*' : 
                '.*' . $_POST['keyword'] . '.*';
            $searchRegexp = "/devid=" . LOG_DEVID . " date=\"([^\"]+)\" " .
                "dname=[^\s]+ logtype=9 pri=($prior) mod=webui " .
                "event=\"($keyword)\" from=\"($from)\" admin=\"(.*)\" " .
                "act=\"($act)\"/";
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
    
        $tpl = 'log/view/admLogTable.tpl';
        $result = fileLinesToArr(LOG_PATH, '', 1, 'includeFunc', 'formatFunc');
        $count  = count($result);
        if ($time === 'DESC') {
            $result = array_reverse($result);
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
            ->assign('priArr', $priArr)->assign('keyword', $_GET['keyword'])
            ->fetch($tpl);
        echo json_encode(array('msg' => array('html'  => $html,
                                              'count' => $count)));
    } else if ('1' === $_GET['search']) {
        // Search specified log info
        $tpl     = 'log/view/admLogTable.tpl';
        $act     = $_POST['act'] === 'all' ? '.*' : $_POST['act'];
        $pri     = $_POST['pri'] === 'all' ? '.*' : $_POST['pri'];
        $from    = empty($_POST['sAddr']) ? '.*' : $_POST['sAddr'];
        $keyword = empty($_POST['keyword']) ? '.*' : 
            '.*' . $_POST['keyword'] . '.*';
        $searchRegexp = "/devid=" . LOG_DEVID . " date=\"([^\"]+)\" " .
            "dname=[^\s]+ logtype=9 pri=($pri) mod=webui " .
            "event=\"($keyword)\" from=\"($from)\" admin=\"(.*)\" " .
            "act=\"($act)\"/";
        $result = fileLinesToArr(LOG_PATH, '', 1, 'includeFunc', 'formatFunc');
        $count  = count($result);
        $result = array_reverse($result);
        $result = array_slice($result, 0, 10);
        $html   = V::getInstance()->assign('result', $result)
            ->assign('priArr', $priArr)->assign('keyword', $_POST['keyword'])
            ->fetch($tpl);
        echo json_encode(array('msg' => array('html'  => $html,
                                              'count' => $count)));
    } else if ('exportFwlog' === $_POST['action']) {
        //export fw.log
		$filename = LOG_PATH;
		$file = fopen($filename,"r");
		header("Content-Type: application/octet-stream; charset=utf-8;");
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
    } else if ('cleanFwlog' === $_POST['action']) {
        if (file_exists(LOG_PATH) &&
            false === file_put_contents(LOG_PATH, '')) {
            throw new Exception('Can`t clean log data.');
        }
        // record log
        $account = $_SESSION['account'];
        $msg = getRoleName($_SESSION['roles']) . "管理员{$account}" .
                "执行命令，清空日志文件。";
        $set = array(
            'time' => time(), 'account' => $account,
            'pri'  => 6,      'act'     => 'set',
            'cmd'  => '',     'msg'     => $msg
        );
        $admLog = new admLog($set);
        echo json_encode(array('msg' => '清空成功。'));
	} else {
        // init page
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
