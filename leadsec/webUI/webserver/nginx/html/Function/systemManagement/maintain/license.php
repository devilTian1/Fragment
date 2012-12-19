<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    //get LicenseInformation  list
    function getLicenseInformation() {
        $tpl =  'systemManagement/maintain/licenseTable.tpl';
        $db = new dbsqlite(DB_PATH . '/private.db');
        $data = $db->query("SELECT * FROM license")->getAllData(PDO::FETCH_ASSOC);
        //向数组里面追加键值对,同时判断value的字段值是否为1，
        //若为1则表示该模块的状态为启用，为0则表示停止
        //将截止时间戳转化为日期格式
        $result = array();
        foreach($data as $key => $val) {
            $result[$key]['function'] = $val['function'];
            $result[$key]['status']   =
                $result[$key]['value'] === '0' ? '停止' : '启用';
            $result[$key]['stopTime'] = date('Y-m-d', $val['stop_time']);
        }
        echo V::getInstance()->assign('licenseInformation', $result)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    //获取查询的记录数
    function getDataCount() {
        $sql = "SELECT * FROM license";
        $db  = new dbsqlite(DB_PATH . '/private.db');
        return $db->query($sql)->getCount();
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
    } else if ($_POST['orderStatement'] === '') {
        getLicenseInformation();
    } else {
        //页面初始化
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
            ->assign('prev', 1)
            ->assign('next', 2);
    }
?>

