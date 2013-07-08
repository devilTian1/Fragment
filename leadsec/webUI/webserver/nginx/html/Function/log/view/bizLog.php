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
                    'pop'       => '邮件访问',
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

    function getShellArgs($order=null) {
        $shellArgs = array();
        if ($_GET['search'] !== '1') {
            $regexp = '/^ORDER BY (\w+\s\w+)(?:,\s(\w+\s\w+))?' .
                '(?: LIMIT (\d+) OFFSET (\d+))?$/';
            if (!preg_match($regexp, $order, $match)) {
                throw new Exception("Error: Order Statment is [$order]");
            }
            if ($_GET['pri'] !== 'all') {
                $shellArgs[] = '-pri ' . $_GET['pri'];
            }
            if ($_GET['logType'] !== 'all') {
                $shellArgs[] = '-logtype ' . $_GET['logType'];
            }
            if (!empty($_GET['keyword'])) {
                $shellArgs[] = '-keyword ' . $_GET['keyword'];
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
            if ($_POST['pri'] !== 'all') {
                $shellArgs[] = '-pri ' . $_POST['pri'];
            }
            if ($_POST['logType'] !== 'all') {
                $shellArgs[] = '-logtype ' . $_POST['logType'];
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

        if ($_GET['search'] === '1') {
            $sa    = $_POST['sAddr'];
            $da    = $_POST['dAddr'];
            $sport = $_POST['sport'];
            $dport = $_POST['dport'];
        } else {
            $sa    = $_GET['sAddr'];
            $da    = $_GET['dAddr'];
            $sport = $_GET['sport'];
            $dport = $_GET['dport'];
        }
        if (!empty($sa)) {
            $shellArgs[] = "-sa $sa";
        }
        if (!empty($da)) {
            $shellArgs[] = "-da $da";
        }
        if (!empty($sport)) {
            $shellArgs[] = "-sport $sport";
        }
        if (!empty($dport)) {
            $shellArgs[] = "-dport $dport";
        }
        return $shellArgs;
    }

    function formatFunc($data) {
        $result = array();
        $searchRegexp = "/devid=" . LOG_DEVID .
            " date=\"([^\"]+)\" dname=[^\s]+ " .
            'logtype=(?:[0-9]|\d{2,3}) pri=(\d+) mod=(\S+)\s'.
            'event="((?:.*\\\\".*)|[^"]+)"/';
        foreach ($data as $d) {
            if (preg_match($searchRegexp, $d, $match)) {
                $r = array();
                $r['date']  = $match[1];
                $r['pri']   = $match[2];
                $r['mod']   = $match[3];
                $r['event'] = str_replace('\\', '', $match[4]);
                $result[] = $r;
            } else {
                throw new Exception("Error: illegal log format: [$d].");
            }
        }
        return $result;
    }

    function filterLogData($shellArgs) {
        $argStr = join(' ', $shellArgs);
        $cli    = new cli();
        $cmd    = $_SERVER['DOCUMENT_ROOT'] . '/Script/filterLogData.sh ' .
            '-biz 1 ' . $argStr;
        return $cli->setIsRec(false)->setGetResult(true)->run($cmd);
    }

    function getDataCount() {
        return $_POST['dataCount'];
    }

    if ($order = $_POST['orderStatement']) {
        $tpl    = 'log/view/bizLogTable.tpl';

        $shellArgs = getShellArgs($order);          
        $data      = filterLogData($shellArgs);
        $count     = array_pop($data);
        $result    = formatFunc($data);
        $html = V::getInstance()->assign('result', $result)
            ->assign('priArr', $priArr)->assign('modArr', $modArr)
            ->assign('keyword', $_GET['keyword'])->fetch($tpl);
        echo json_encode(array('msg'   => '查询完成。',
                               'html'  => $html,
                               'count' => intval($count)));
    } else if ('1' === $_GET['search']) {
        // Search specified log info
        $tpl = 'log/view/bizLogTable.tpl';

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
        $cmd = 'sed -i "/logtype=9/!d" ' . LOG_PATH;
        $cli = new cli();
        $cli->setLog("执行命令，清空业务日志文件。")->run($cmd);
        echo json_encode(array('msg' => '清空成功。'));
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
