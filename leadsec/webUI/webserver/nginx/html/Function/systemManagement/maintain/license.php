<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    /*getLicenseInformation()函数用于获取许可证的相关信息
	 *$orderStatement为参数，是为字符串类型的变量，对sql查询语句增加限制条件
	 *$result为该函数的返回结果，结果的数据类型是为数组
	 */

    function getLicenseInformation($orderStatement) {
        $tpl =  'systemManagement/maintain/licenseTable.tpl';
        $db = new dbsqlite(DB_PATH . '/private.db');
        $data = $db->query("SELECT * FROM license $orderStatement")
					->getAllData(PDO::FETCH_ASSOC);
		$result = array();

    /*判断结果集中value的字段值是否为1，做为前端显示的'停止'与'启用'的状态
     * 将截止时间(stopTime)的unix时间戳进行转换
	 */

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

    /*
	 * 获取查询结果的记录数
	 */

    function getDataCount() {
        $sql = "SELECT * FROM license";
        $db  = new dbsqlite(DB_PATH . '/private.db');
        return $db->query($sql)->getCount();
    }

    if (!empty($_FILES)) {
        $uploadfs = new fileUpload($_FILES);
        $uploadfs->upload();
        $path="/usr/local/license/bin/sls_upload";
        $license="/tmp/".$_FILES['licenseFile']['name'] ;
        $cmd=$path.' '.$license ;
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '升级成功'));
    } else if ($orderStatement =$_POST['orderStatement']) {
        getLicenseInformation($o rderStatement);
    } else {
	/*
	 *页面初始化效果
	 */
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
            ->assign('prev', 1)
            ->assign('next', 2);
    }
?>

