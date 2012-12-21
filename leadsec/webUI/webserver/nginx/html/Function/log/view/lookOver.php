<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    $deviceArr = array('Firewall', 'IDS', 'VPN', 'NetGap'); 
    $priArr    = array('all', 'emergency' , 'critical', 'error', 'warning', 'notice', 'information', 'debug');

    $test = 'asdasd devid=' . LOG_DEVID . ' date="2012/12/12 10:00:00" dname=themis logtype=9 pri=5 mod=ada sss=xxx';

    function getRegexBySearchParams() {

        if (!empty($_POST['startTime_log'])) {
            $searchArr['sTime'] = $_POST['startTime_log'];
        }
        if (!empty($_POST['endTime_log'])) {
            $searchArr['eTime'] = $_POST['endTime_log'];
        }
        if ('on' === $_POST['userTrace']) {
            $searchArr['userTrace'] = $_POST['userTrace'];
        }

        $regexArr   = array();
        $regexArr[] = 'devid=' . LOG_DEVID;

        if ('all' !== $_POST['logType']) {
            $regexArr[] = "logType={$_POST['logType']}";
        }
        if ('all' !== $_POST['type']) {
            $regexArr[] = "pri={$_POST['type']}";
        }

        if (!empty($_POST['sAddr'])) {
            $regexArr[] = "sa={$_POST['sAddr']}";
        }
        if (!empty($_POST['dAddr'])) {
            $regexArr[] = "da={$_POST['dAddr']}";
        }
        if (!empty($_POST['sport'])) {
            $regexArr[] = "sport={$_POST['sport']}";
        }
        if (!empty($_POST['dport'])) {
            $regexArr[] = "dport={$_POST['dport']}";
        }
        return '[' . join('|', $regexArr) . ']';
    }
    /*
     * Get an array that represents lines of file
     * @param regex $include. Include paths that matches this regex
     */
    function fileLinesToArr($path, $include = NULL) {
        $result = array();
        $fp     = @fopen($path, 'r');
        if ($fp) {
            while (false !== ($buffer = fgets($fp, 4096))) {
                if ($include === null || preg_match($include, $buffer)) {
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
        $logFileLines = fileLinesToArr(LOG_PATH, '/(devid=3)(mod=ssh)/');
        $result    = '';

        echo json_encode(array('msg' => $logFileLines[0]));
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
