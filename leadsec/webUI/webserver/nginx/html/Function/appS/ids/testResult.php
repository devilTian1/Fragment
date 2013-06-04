<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getTestResultInfo($limit, $offset) {
        $result = array(); 
        $data   = fileLinesToArr('/var/log/auth.log', '', 1, 'filterLines');
        if ($limit === 'all') {
            $limit = 4096;
        }
        for ($i = 0; !empty($data[$i+$offset]) && $i < $limit; $i++) {
            $num  = $i + $offset;
            $line = $data[$num];
            if ($r = filterParams($line)) {
                $result[$i] = $r;
                $result[$i]['rowsNum'] = $num + 1;
            }
        }
        return $result;
    } 

    function freshTestResult($limit, $offset) {
        $tpl = 'appS/ids/testResultTable.tpl';
        echo V::getInstance()
            ->assign('result', getTestResultInfo($limit, $offset))
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function filterParams($line) {
        $keyword_simple       = '[^\]]+';
        $keyword_portScanStat = '.*';
        $keyword_portScanFrom = '[\d\.]+';
        $keyword_portScanEnd  = '.+';
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $keyword = $_GET['keyword'];
            $keyword_simple = ".*$keyword.*[^\]]+";
            $keyword_portScanStat = ".*$keyword.*";
            $keyword_portScanFrom = ".*$keyword.*";
            $keyword_portScanEnd  = ".*$keyword.*";
        }
        $regex = array(
            'portScanFrom' => '/^([0-9\-:\.\+A-Z]+)' .
                              '\sLX\-NIDS: LXNIDS_portscan:' .
                              ' PORTSCAN DETECTED from\s' .
                              "($keyword_portScanFrom)\s/",
            'portScanStat' => '/^([0-9\-:\.\+A-Z]+)\s' .
                              'LX-NIDS: LXNIDS_portscan: ' .
                              "portscan status from ($keyword_portScanStat): " .
                              '(\d+) connections across (\d+) ' .
                              'hosts: TCP\((\d+)\), UDP\((\d+)\)$/',
            'portScanEnd'  => '/^([0-9\-:\.\+A-Z]+)\sLX\-NIDS: ' .
                              'LXNIDS_portscan: End of portscan from ' .
                              "($keyword_portScanEnd): TOTAL time" .
                              '\((\d+)s\) hosts\((\d+)\) TCP\((\d+)\) ' .
                              'UDP\((\d+)\)$/',
            'simple'       => '/^([0-9\-:\.\+A-Z]+).*' .
                              "\[Classification: ($keyword_simple)\]\s" .
                              '\[Priority: (.+)\]\s\{(.*)\} (.*) -> (.*)$/'
        );
        if (preg_match($regex['simple'], $line, $match)) {
            $level    = '';
            $priority = (int)$match[3];
            if ($priority > 4 && $priority < 8) {
                $level = '中';
            } else if ($priority > 8) {
                $level = '<span class="red">高</span>';
            } else {
                $level = '低';
            }
            $event = $match[2];
            
            return array('date'  => $match[1], 'sa'       => $match[5],
                         'da'    => $match[6], 'protocol' => $match[4],
                         'level' => $level,    'event'    => $event);
        } else if (preg_match($regex['portScanFrom'], $line, $match)) {
            $event = "端口扫描报告：发现来自<span class='red'>{$match[2]}" .
                     "</span>的扫描行为！";
        } else if (preg_match($regex['portScanStat'], $line, $match)) {
            $event = "端口扫描报告：<span class='red'>{$match[2]}" .
                     "</span>正在进行扫描, 对{$match[4]}".
                     "台主机进行了{$match[3]}次扫描, 其中TCP连接{$match[5]}次" .
                     "，UDP连接{$match[6]}次。";
        } else if (preg_match($regex['portScanEnd'], $line, $match)) {
            $event = "<span class='red'>{$match[2]}</span>结束本次扫描行为，" .
                     "总扫描时间{$match[3]}秒，扫描{$match[4]}台主机，" .
                     "其中TCP连接{$match[5]}次，UDP连接{$match[6]}次。";
        } else {
            return false;
        }
        return array('date'  => $match[1], 'sa'       => $match[2] . ':--',
                     'da'    => '--',      'protocol' => '--',
                     'level' => '中',      'event'    => $event);
    }

    function filterLines($line) {
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $keyword = $_GET['keyword'];
            preg_match("/^[0-9\-:\.\+A-Z]+\s.*$keyword.*$/", $line, $match);
        } else {
            preg_match("/^[0-9\-:\.\+A-Z]+\s[^\s]+\s[^:]+:.+$/", $line, $match);
        }
        return $match[0];
    }
    
    function getDataCount() {
        $result = fileLinesToArr('/var/log/auth.log', '', 1, 'filterLines');
        return count($result);
    }

    if (isset($_POST['orderStatement'])) {
        // fresh log table
        $where = $_POST['orderStatement'];
        if ($where !== '') {
            preg_match('/LIMIT (\d+) OFFSET (\d+)/', $where, $match);
            $limit  = $match[1];
            $offset = $match[2];
        } else {
            $limit  = 'all';
            $offset = 0;
        }
        freshTestResult($limit, $offset);
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
