<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    $priArr = array('紧急', '警报', '临界', '出错',
                    '预警', '提示', '通知', '调试');

    function formatFunc($data) {
        $result = array();
        $searchRegexp = "/devid=" . LOG_DEVID .
            " date=\"([^\"]+)\" dname=[^\s]+ " .
            'logtype=(?:[0-9]|\d{2,3}) pri=(\d+) mod=\S+\s'.
            'event="((?:.*\\\\".*)|[^"]+)"/';
        foreach ($data as $d) {
            if (preg_match($searchRegexp, $d, $match)) {
                $r = array();
                $r['date']  = $match[1];
                $r['pri']   = $match[2];
                $r['event'] = str_replace('\\', '', $match[3]);
                $result[] = $r;
            } else {
                throw new Exception("Error: illegal log format: [$d].");
            }
        }
        return $result;
    }

    function getShellArgs($order=null) { 
        $shellArgs = array();
        if ($_GET['search'] !== '1') {
            $regexp = '/^ORDER BY (\w+\s\w+)(?:,\s(\w+\s\w+))?' .
                '(?: LIMIT (\d+) OFFSET (\d+))?$/';
            if (!preg_match($regexp, $order, $match)) {
                throw new Exception("Error: Order Statment is [$order]");
            }
            if ($_GET['act'] !== 'all') {
                $shellArgs[] = "-act {$_GET['act']}";
            }
            if ($_GET['pri'] !== 'all') {
                $shellArgs[] = "-pri {$_GET['pri']}";
            }
            if (!empty($_GET['sAddr'])) {
                $shellArgs[] = "-sa {$_GET['sAddr']}";
            }
            if (!empty($_GET['keyword'])) {
                $shellArgs[] = "-keyword {$_GET['keyword']}";
            }
            if (!empty($_GET['startTime_log'])) {
                $st = str_replace('/', '-', $_GET['startTime_log']);
                $shellArgs[] = "-fd \"$st\"";
            }
            if (!empty($_GET['endTime_log'])) {
                $et = str_replace('/', '-', $_GET['endTime_log']);
                $shellArgs[] = "-td \"$et\"";
            }
            list($n, $time) = explode(' ', $match[1]);
            list($n, $pri)  = explode(' ', $match[2]);
            if (!empty($p2)) {
                $shellArgs[] = '-dateSort ' . strtoupper($time);
                $shellArgs[] = '-priSort ' . strtoupper($pri);
            } else {
                list($k, $v) = explode(' ', $match[1]);
                if ($k === 'time') {
                    $shellArgs[] = '-dateSort ' . strtoupper($v);
                } else if ($k === 'pri') {
                    $shellArgs[] = '-priSort ' . strtoupper($v);
                } else {
                    throw new Exception("Error: illegal order name [$k].");
                }
            }
            $shellArgs[] = "-limit {$match[3]}";
            $shellArgs[] = "-offset {$match[4]}";
        } else {
            $shellArgs[] = '-dateSort DESC' ;
            $shellArgs[] = '-limit 10';
            $shellArgs[] = '-offset 0';
            if ($_POST['act'] !== 'all') {
                $shellArgs[] = "-act {$_POST['act']}";
            }
            if ($_POST['pri'] !== 'all') {
                $shellArgs[] = '-pri ' . $_POST['pri'];
            }
            if (!empty($_POST['sAddr'])) {
                $shellArgs[] = "-sa {$_POST['sAddr']}";
            }
            if (!empty($_POST['keyword'])) {
                $shellArgs[] = '-keyword ' . $_POST['keyword'];
            }
            if (!empty($_POST['startTime_log'])) {
                $st = str_replace('/', '-', $_POST['startTime_log']);
                $shellArgs[] = "-fd \"$st\"";
            }
            if (!empty($_POST['endTime_log'])) {
                $et = str_replace('/', '-', $_POST['endTime_log']);
                $shellArgs[] = "-td \"$et\"";
            }
        }
        return $shellArgs;
    }

    function filterLogData($shellArgs) {
        $argStr = join(' ', $shellArgs);
        $cli    = new cli();
        $cmd    = $_SERVER['DOCUMENT_ROOT'] . '/Script/filterLogData.sh ' .
            '-adm 1 ' . $argStr;
        error_log($cmd, 3, '/tmp/error.log');
        return $cli->setIsRec(false)->setGetResult(true)->run($cmd);
    }

    function getDataCount() {
        return $_POST['dataCount'];
    }

    if ($order = $_POST['orderStatement']) {
        $tpl = 'log/view/admLogTable.tpl';

        $shellArgs = getShellArgs($order);
        $data      = filterLogData($shellArgs);
        $count     = array_pop($data);
        $result    = formatFunc($data);
        
        $html = V::getInstance()->assign('result', $result)
            ->assign('priArr', $priArr)->assign('keyword', $_GET['keyword'])
            ->fetch($tpl);
        echo json_encode(array('msg'   => '查询完成。',
                               'html'  => $html,
                               'count' => intval($count)));
    } else if ('1' === $_GET['search']) {
        // Search specified log info
        $tpl = 'log/view/admLogTable.tpl';

        $shellArgs = getShellArgs();
        $data      = filterLogData($shellArgs);
        $count     = array_pop($data);
        $result    = formatFunc($data);

        $html = V::getInstance()->assign('result', $result)
            ->assign('priArr', $priArr)->assign('modArr', $modArr)
            ->assign('keyword', $_POST['keyword'])->fetch($tpl);
        echo json_encode(array('msg'   => '查询完成。',
                               'html'  => $html,
                               'count' => intval($count)));
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
