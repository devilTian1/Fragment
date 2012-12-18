<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    //get LicenseInformation  list
    function GetLicenseInformation() {
        $num = 1 ;
        $db = new dbsqlite(DB_PATH . '/private.db');
        $result = $db->query("SELECT * FROM license")->getAllData(PDO::FETCH_ASSOC);
        //向数组里面追加键值对,同时判断value的字段值是否为1，
        //若为1则表示该模块的状态为启用，为0则表示停止
        //将截止时间戳转化为日期格式
        foreach($result as $key => $val) {
            if ($result[$key]['value']>0) {
                $result[$key]['type']='启用';
            } else {
                $result[$key]['type']='停止';
            }
                $result[$key]['id'] = $num;
                $result[$key]['stop_time']=date('Y-m-d',$result[$key]['stop_time']);
                $num++ ;
        }
        V::getInstance()->assign('licenseInformation', $result) ;
    }

    if (!empty($_FILES)) {
        $uploadfs = new fileUpload($_FILES);
        $uploadfs->upload();
        //证书上传后要执行的命令
        $path="/usr/local/license/bin/sls_upload";
        $license="/tmp/".$_FILES['licenseFile']['name'] ;
        $cmd=$path.' '.$license ;
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '升级成功'));
    } else {
        GetLicenseInformation() ;
    }
?>

