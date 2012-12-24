<?php
    require_once($_SERVER['DOCUMENT_ROOT'].'/Function/common.php');

    /*
     * Get suffix of filename
     * @param $fileName.
     * @param $length. length of suffix of fileName
     */
    function getSuffixOfFileName($fileName, $length = 3) {   
        $result = '';
        $p      = strrpos($fileName, '.'); 
        if (false !== $p) {
            $result = substr($fileName, $p+1, $length); 
        }
        return $result;
    } 
    
    /*
     * Get Db Name
     * param $path. absolute path. eg: /usr/local/conf/private.db
     * return. String. db name. eg: private
     */
    function getDbName($path) {
        return substr($path, strrpos($path, '/') + 1, strrpos($path, '.'));
    }

    /*
        判断要下载的文件属于外网与内网
    */
    function ExportFile() {
        $db   = new dbsqlite(DB_PATH . '/netgap_system.db');
        $host = $db->query('SELECT host FROM system')
            ->getFirstData(PDO::FETCH_ASSOC);
        if ($host['host'] === 'O'){
            $configfile = 'ngconfig_out.txt';
        } else {
            $configfile = 'ngconfig_in.txt';
        }
        return $configfile ;
    }


    function getEncryptStr($result) {
        return base64_encode($result);
    }

    $cli = new cli();
    if (!empty($_FILES)) {
        // Upgrade System
        $uploadfs = new fileUpload();
        $uploadfs->upload();
        $cmd = "config import \"{$_FILES['importFile']['name']}\"";
        $cli->run($cmd);
        echo json_encode(array('msg' => '升级成功.'));
    } else if ($switch = $_POST['switch']) {
        // 获取后缀名为.db的文件,然后将此类型的文件存放在一个数组中
        $files  = directoryToArray('/usr/local/conf');
        $dbFiles = array();
        foreach ($files as $v) {
            if (getSuffixOfFileName($v) === 'db') {
                    $dbFiles[] = $v;
                }
        }

        $filename = urlencode(ExportFile());
        header("Content-Type: application/octet-stream; charset=utf-8;");
        header("Content-Disposition: attachment; filename=\"$filename\";");
        header('Pragma: no-cache;');
        header('Cache-Control: must-revalidate, post-check=0, pre-check=0;');
        $result  = '';
        $result .= 'Leadsec Secutiry Netgap' . date('Y-n-d H:i:s', time()) . "\r\n" . 
            '--------DO NOT edit this line' . "\r\n";
        foreach ($dbFiles as $dbFile) {
            $tableStr = $cli->run("sqlite3 $dbFile '.table'");
            $tableArr = preg_split('/\s+/', $tableStr);
            $db       = new dbsqlite($dbFile);
            foreach ($tableArr as $table) {
                $data = $db->query("SELECT * FROM $table")
                    ->getAllData(PDO::FETCH_ASSOC);
                if (0 !== count($data)) {
                    foreach ($data as $key => $val) {
                        $result .= 'setdb ' . getDbName($dbFile) . ' ' . $table . ' ';
                        foreach ($val as $k => $v) {
                            $result .= "$k  $v ";
                        }
                        $result .= "\r\n" ;
                    }
                } else {
                    $result .= 'setdb ' . getDbName($dbFile) . " no content in $table\r\n";
                }
            }           
        }
        if ('on' === $switch) {
            echo getEncryptStr($result);
        } else { //off
            echo $result;
        }
    } else if (!empty($_GET['restore'])){
        // restore the factory configuration
        $cmd = 'Config rest';
        $cli->run($cmd);
        echo json_encode(array('msg' => '恢复出厂配置成功.'));
    } else if (!empty($_GET['save'])){
        // save configuration info
        $cli->run('Config save');
        echo json_encode(array('msg' => '保存配置成功.'));
    } else {
        // initial page info
    }
?>
