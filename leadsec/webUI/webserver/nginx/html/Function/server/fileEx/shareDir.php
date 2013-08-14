<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendShareDirData($where) {
        $tpl =  'server/fileEx/shareDirTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = 'SELECT task_id, mode, ip, share_name, fs FROM dir_info '. 
            'where mode ="S"';
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
        	$sql   .= $data['sql'];
        	$params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('shareDir', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
    function getWhereStatement($db, $cols, $keyword) {
    	$value = '%' . $keyword . '%';
    	$params = array_fill(0, count(explode(',', $cols)), $value);
    	return array('sql'    => ' AND (' .
    			$db->getWhereStatement($cols, 'OR', 'like') . ')',
    			'params' => $params);
    }

    function isdir($path) {
        $path = str_replace(array('(', ')', ' '), array('\(', '\)', '\ '), $path);
        $cmd  = "test -d $path && echo '1' || echo '0'";
		$cli  = new cli();
		list($status, $result) = $cli->setIsRec(false)->execCmdGetStatus($cmd);
        if ($status != 0) {
            throw new Exception("Error: incorrect cmd. [$cmd]");
        } else {
            if ($result[0] === '1') {
                return true;
            } else if ($result[0] === '0') {
                return false;
            } else {
                $result = join(', ', $result);
                throw new Exception("Error: return status[$result]");
            }
        }
    }

    function getDataCount() {
        $sql = 'SELECT task_id FROM dir_info where mode = "S"';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function getPathCount($path) {
        $cmd = "ls -f $path | egrep -ve '^[\.]{1,2}$' | wc -l";
		$cli = new cli();
        list($status, $result) = $cli->setIsRec(false)
            ->execCmdGetStatus($cmd);
        if ($status != 0) {
            throw new Exception("ERROR：无法打开指定目录[$path], cmd:[$cmd].");
        } else {
            return intval($result[0]);
        }
    }

    function directoryToFileTree($dir, $offset = 0, $limit = 20) {
        $result = array();
        $from   = $offset+1;
        $to     = $offset+$limit;
        $cmd    = "ls -f $dir | egrep -ve '^[\.]{1,2}$' | " .
            "sed -n '$from,{$to}p'";
        $cli = new cli();
        list($status, $list) = $cli->setIsRec(false)
            ->execCmdGetStatus($cmd);
        if ($status != 0) {
            throw new Exception("ERROR：无法打开指定目录[$dir], cmd:[$cmd].");
        } else {
            if (empty($list)) {
                return array();
            } else {
                foreach ($list as $file) {
                    $path = $dir . DIRECTORY_SEPARATOR . $file;
                    if (isdir($path)) {
                        $children =
                            directoryToFileTree($path, $offset, $limit);
                        $children = join(',', $children);
                        $result[] = "{name: \"$file\", t: \"$path\", " .
                            "children: [$children], " .
                            "click: \"getFileSize('$path')\"}";
                    } else {
                        $result[] = "{name: \"$file\", t: \"$path\", " .
                        "click: \"getFileSize('$path')\"}";
                    }
                }
                if (getPathCount($dir) > $to) {
                    $result[] = '{name: "更多", t: "_more", ' .
                        "click: \"update($(this), '$dir', '$to')\"}";
                }
            }
        }
        return $result;
    }
 
    function returnFileSize($fileSize) {
        if ($fileSize < 1024) {
            return $fileSize . '<b>KB</b>';
        } else if ($fileSize > 1024 && $fileSize < 1048576) {
            return round($fileSize/1024, 1) . '<b>MB</b>';
        } else if ($fileSize > 1048576 && $fileSize < 1073741824) {
            return round($fileSize/1048576, 1) . '<b>GB</b>';
        } else if ($fileSize > 1073741824 && $fileSize < 1099511627776) {
            return round($fileSize/1099511627776, 1) . '<b>TB</b>';
        } else if ($fileSize > 1099511627776 && $fileSize < 11258999906842624) {
            return round($fileSize/1099511627776, 1) . '<b>PB</b>';
        } else {
            return $fileSize;
        }
    }
  
    function getPathSize($path) {
        $path = str_replace(array('(', ')', ' '), array('\(', '\)', '\ '), $path);
        $cmd = "du -sk $path";
        $cli = new cli();
        list($status, $result) =
            $cli->setIsRec(false)->execCmdGetStatus($cmd);
        if ($status != 0) {
            throw new Exception("Error: incorrect cmd[$cmd].");
        } else {
            list($size, $n) = explode(' ', $result[0]);
            return returnFileSize(intval(trim($size))); //KB
        }
    }

    if ($taskId = $_POST['taskId']) {
        // Display dialog to show detail share dir list
        $sql = 'SELECT task_id, mode, ip, share_name, fs FROM dir_info WHERE ' .
            "task_id = $taskId";
        $db   = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $dir  = "/tmp/sync_file/task$taskId";

        $tpl    = 'server/fileEx/shareDirDialog.tpl';
        $zNodes = directoryToFileTree($dir);
        $zNodes = join(', ', $zNodes);
        $result = V::getInstance()->assign('zNodes', $zNodes)
            ->assign('r', $data)->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($_GET['update'] === '1') {
        $dir    = $_GET['dir'];
        $offset = $_GET['offset'];
        $zNodes = directoryToFileTree($dir, $offset);
        echo json_encode(array('msg' => $zNodes));
    } else if ($path = $_POST['path']) {
		echo json_encode(array('msg' => getPathSize($path)));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort share dir list table
        appendShareDirData($orderStatement);
    } else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
