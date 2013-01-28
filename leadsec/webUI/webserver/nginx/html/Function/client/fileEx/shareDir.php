<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function appendShareDirData($where) {
        $tpl =  'client/fileEx/shareDirTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $sql = "SELECT task_id, mode, ip, share_name, fs FROM dir_info $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('shareDir', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $sql = 'SELECT task_id FROM dir_info';
        $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
        return $db->query($sql)->getCount();
    }

    function directoryToFileTree($dir) {
        if (@$handle = opendir($dir)) {
            $result = array();
            while (false !== ($file = readdir($handle))) {
                if ($file === '.' || $file ==='..') {
                    continue;
                }
                $path = $dir . DIRECTORY_SEPARATOR . $file;
                if (is_dir($path)) {
                    $children = directoryToFileTree($path);
                    $result[] = "{name: \"$file\", t: \"$path\", " .
                        "children: [$children]}";
                } else {
                    $result[] = "{name: \"$file\", t: \"$path\"}";
                }
            }
            closedir($handle);
            return join(',', $result);
        } else {
            throw new Exception("ERROR: 无法打开指定目录[$dir].");
        }
    }
    
    function getPathSize($path) {
        if (is_dir($path)) {
            $dir = $path;
            if ($handle = opendir($dir)) {
                $result = 0;
                while (false !== ($file = readdir($handle))) {
                    if ($file === '.' || $file ==='..') {
                        continue;
                    }
                    $path = $dir . DIRECTORY_SEPARATOR . $file;
                    if (is_dir($path)) {
                        $result += getPathSize($path);
                    } else {
                        $result += filesize($path);
                    }
                }
            }
            closedir($handle);
            return $result;
        } else {
            return filesize($path);
        }
    }

    function returnFileSize($fileSize) {
        if ($fileSize < 1024) {
                return $fileSize . '<b>Bit</b>';
        } else if ($fileSize > 1024 && $fileSize < 1048576) {
            return round($fileSize/1024, 1) . '<b>Kb</b>';
        } else if ($fileSize > 1048576 && $fileSize < 1073741824) {
            return round($fileSize/1048576, 1) . '<b>Mb</b>';
        } else if ($fileSize > 1073741824 && $fileSize < 1099511627776) {
            return round($fileSize/1099511627776, 1) . '<b>Gb</b>';
        } else if ($fileSize > 1099511627776 && $fileSize < 11258999906842624) {
            return round($fileSize/1099511627776, 1) . '<b>TB</b>';
        } else if ($fileSize > 11258999906842624) {
            return round($fileSize/11258999906842624, 1) . '<b>PB</b>';
        } else {
            return $fileSize;
        }
    }

    if ($taskId = $_POST['taskId']) {
        // Display dialog to show detail share dir list
        $sql = 'SELECT task_id, mode, ip, share_name, fs FROM dir_info WHERE ' .
            "task_id = $taskId";
        $db   = new dbsqlite(DB_PATH . '/netgap_fs.db');
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $dir  = "/tmp/sync_file/task$taskId";

        $tpl    = 'client/fileEx/shareDirDialog.tpl';
        $zNodes = directoryToFileTree($dir);
        $result = V::getInstance()->assign('zNodes', $zNodes)
            ->assign('r', $data)->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($path = $_POST['path']) {
        // get dir/file size
        clearstatcache();
        echo json_encode(array('msg' => returnFileSize(getPathSize($path))));
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
