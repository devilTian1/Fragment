<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    $deviceArr = array('Firewall', 'IDS', 'VPN', 'NetGap'); 
    $priArr    = array('all', 'emergency' , 'critical', 'error', 'warning', 'notice', 'information', 'debug');

    $actArr    =
        array('set'     => '设置', 'add'    => '增加', 'del'    => '删除',
              'show'    => '显示', 'start'  => '启动', 'stop'   => '停止',
              'restart' => '重启', 'off'    => '关闭', 'on'     => '激活',
              'auth'    => '认证', 'ignore' => '忽略', 'block'  => '阻断',
              'login'   => '登录', 'logout' => '退出', 'log'    => '日志',
              'auth'    => '认证', 'audit'  => '审计', 'permit' => '允许',
              'deny'    => '禁止', 'import' => '导入', 'export' => '导出');

    function checkTime($date) {
        $cts = strtotime($date);
        if (!empty($_POST['startTime_log'])) {
            $sts = strtotime($_POST['startTime_log']);
            if ($sts > $cts) {
                return false;
            }
        }
        if (!empty($_POST['endTime_log'])) {
            $ets = strtotime($_POST['endTime_log']);
            if ($cts > $ets) {
                return false;
            }
        }
        return true;
    }

    function getRegexBySearchParams() {
        /*
        if ('on' === $_POST['userTrace']) {
            $searchArr['userTrace'] = $_POST['userTrace'];
        }
        */
        $regexpArr = array();
        if (!empty($_POST['orderStatement'])) {
            $regexpArr[] = 'devid=' . LOG_DEVID . ' date="(.*)" dname=(\S+) ' .
                'logtype=(\d+) pri=(\d+)';
        } else {
            $logTypeRegexStr = 
                $_POST['logType'] === 'all' ? '\d+' : $_POST['logType'];
            $priRegexStr = $_POST['type'] === 'all' ? '\d+' : $_POST['type'];
            $regexpArr[] = 'devid=' . LOG_DEVID . ' date="(.*)" dname=(\S+) ' .
                'logtype=(' . $logTypeRegexStr . ') pri=(' . $priRegexStr. ')';

            if (!empty($_POST['sAddr'])) {
                $regexpArr[] = "sa={$_POST['sAddr']}";
            }
            if (!empty($_POST['sport'])) {
                $regexpArr[] = "sport={$_POST['sport']}";
            }
            if (!empty($_POST['dAddr'])) {
                $regexpArr[] = "da={$_POST['dAddr']}";
            }
            if (!empty($_POST['dport'])) {
                $regexpArr[] = "dport={$_POST['dport']}";
            }
        }
        return '/^.*' . join('[,|\s|,\s].*?', $regexpArr) . '[,|\s|,\s](.*)$/';
    }

    function includeFunc($buffer) {
        if (preg_match(getRegexBySearchParams(), $buffer, $match) && 
            checkTime($match[1])) {
            return $match;
        } else {
            return false;
        }
    }

    function formatFunc($match) {
        $result = array();
        $logtypearr = array('所有',       '入侵检测', '集中管理', '设备管理',
                            '文件交换',   '安全浏览', 'ftp访问',  '邮件访问',
                            '数据库访问', '定制访问', 'ha',       '系统管理',
                            '数据库同步', '消息模块', '安全通道');
        $logtypeval = array('all', '3',   '8',   '9',   '301', '302', '303',
                            '304', '305', '306', '308', '309', '311', '312',
                            '330');
        $logtypeKey = array_search($match[3], $logtypeval);
        $result['date']        = $match[1];
        $result['dname']       = $match[2];
        $result['logtype']     = $logtypearr[$logtypeKey];
        $result['pri']         = $match[4];
    $actArr_en  =
        array('set', 'add', 'del', 'show', 'start', 'stop', 'restart', 'off', 'on', 'auth', 'ignore', 'block', 'login', 'logout', 'log', 'audit', 'permit', 'deny', 'import', 'export');    
    $actArr_zh =
        array('设置', '增加', '删除',
              '显示', '启动', '停止',
              '重启', '关闭', '激活',
              '认证', '忽略', '阻断',
              '登录', '退出', '日志',
              '审计', '允许',
              '禁止', '导入', '导出');
$privateArea = str_replace($actArr_en, $actArr_zh, $match[5]);
$privateArea = str_replace('mod=', '模块名称为[', $privateArea);
$privateArea = str_replace(' act=', '], 动作为', $privateArea);
$privateArea = str_replace(' name=', '], 名称为', $privateArea);
$privateArea = str_replace(' policy=', '], 策略为', $privateArea);
$privateArea = str_replace('result=0', '结果正确', $privateArea);


        $result['privateArea'] = $privateArea;
        
        return $result;
    }

    /*
     * Get an array that represents lines of file.
     * @param $path String. file path.
     * @param $rowsCount Integer. The number of file line to be displayed.
     * @param $includeFunc String. function name which used to validate
     *   this line.
     * @param $formatFunc String. function name which used to format return
     *   result of $includeFunc()
     */
    function fileLinesToArr($path = LOG_PATH, $rowsNum = 10, $includeFunc = NULL,
        $formatFunc = NULL) {
        $result = array();
        $fp     = @fopen($path, 'r');
        $count  = 0;
        if ($fp) {
            while (false !== ($buffer = fgets($fp, 4096))) {
                if ($count < $rowsNum &&
                    ($includeFunc === NULL || $match = $includeFunc($buffer)) &&
                    ($formatFunc === NULL || $r = $formatFunc($match))) {
                    $result[] = $r;
                    $count++;
                }
            }
            if (!feof($fp)) {
                throw new Exception("Error: unexpected fgets() fail.");
            }
            fclose($fp);
        }
        return $result;
    }

    if (!empty($_POST['orderStatement'])) {
        $tpl = 'log/view/lookOverTable.tpl';
        $result = fileLinesToArr(LOG_PATH, 10, 'includeFunc',
            'formatFunc');
        echo V::getInstance()->assign('result', $result)
            ->fetch($tpl);
    } else if ('1' === $_GET['search']) {
        // Search specified log info
        $tpl = 'log/view/lookOverTable.tpl';
        $result = fileLinesToArr(LOG_PATH, 10, 'includeFunc',
            'formatFunc');
        $html = V::getInstance()->assign('result', $result)
            ->fetch($tpl);
        echo json_encode(array('msg' => $html));
    } else {
        // init page
        $logTypeArr = array('所有',       '入侵检测', '集中管理', '设备管理',
                            '文件交换',   '安全浏览', 'ftp访问',  '邮件访问',
                            '数据库访问', '定制访问', 'ha',       '系统管理',
                            '数据库同步', '消息模块', '安全通道');
        $logTypeVal = array('all', '3',   '8',   '9',   '301', '302', '303',
                            '304', '305', '306', '308', '309', '311', '312',
                            '330');
        V::getInstance()->assign('logTypeArr', $logTypeArr)
            ->assign('logTypeVal', $logTypeVal)
            ->assign('dataCount', 10)
            ->assign('pageCount', 1)
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
