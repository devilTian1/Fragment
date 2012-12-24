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
        $logTypeRegexStr = 
            $_POST['logType'] === 'all' ? '\d+' : $_POST['logType'];
        $priRegexStr     = $_POST['type'] === 'all' ? '\d+' : $_POST['type'];
        $regexpArr[] = 'devid=' . LOG_DEVID . ' date="(.*)" dname=(\S+) '.
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
        return '/^.*' . join('[,|\s|,\s].*?', $regexpArr) . '(?:[,|\s|,\s].*)?$/';
    }

    function includeFunc($buffer) {
        if (preg_match(getRegexBySearchParams(), $buffer, $match) && 
            checkTime($match[1])) {
            return $match;
        } else {
            return false;
        }
    }

    /*
     * Get an array that represents lines of file
     * @param regex $include. Include paths that matches this regex
     */
    function fileLinesToArr($path, $includeFunc = NULL) {
        $result = array();
        $fp     = @fopen($path, 'r');
        if ($fp) {
            while (false !== ($buffer = fgets($fp, 4096))) {
                if ($includeFunc === null || $match = $includeFunc($buffer)) {
                    var_dump($match);
                    $result[] = $buffer;
                }
            }
            if (!feof($fp)) {
                throw new Exception("Error: unexpected fgets() fail.");
            }
            fclose($fp);
        }
        return $result;
    }

    if ('1' === $_GET['search']) {
        // Search specified log info
        $logFileLines = fileLinesToArr(LOG_PATH, 'includeFunc');
        $result    = '';

        echo json_encode(array('msg' => $logFileLines[0]. getRegexBySearchParams()));
    } else {
        // init page
        $logTypeArr = array('所有',       '入侵检测', '集中管理', '设备管理',
                            '文件交换',   '安全浏览', 'FTP访问',  '邮件访问',
                            '数据库访问', '定制访问', 'HA',       '系统管理',
                            '数据库同步', '消息模块', '安全通道');
        $logTypeVal = array('all', '3',   '8',   '9',   '301', '302', '303',
                            '304', '305', '306', '308', '309', '311', '312',
                            '330');
        V::getInstance()->assign('logTypeArr', $logTypeArr)
            ->assign('logTypeVal', $logTypeVal);
    }
?>
