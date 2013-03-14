<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    /*
	 * Get the certificate information
	 * @param string $orderStatement. query constraints
	 * @param array $result. query results
	 */
    function getLicenseInformation($orderStatement) {
        $tpl    = 'systemManagement/maintain/licenseTable.tpl';
        $db     = new dbsqlite(DB_PATH . '/private.db');
		$sql    = "SELECT function, value, stop_time 
			FROM license $orderStatement";
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
		$result = array();
        foreach ($data as $key => $val) {
            $result[$key]['function'] = $val['function'];
            $result[$key]['status']   =
                $result[$key]['value'] === '0' ? '停止' : '启用';
            $result[$key]['stopTime'] = date('Y-m-d', $val['stop_time']);
        }
        echo V::getInstance()->assign('licenseInformation', $result)
			->assign('pageCount', 10)->fetch($tpl);
    }

    /*
	 * Get the results of the query to the number from license table
	 */
    function getDataCount() {
        $sql = 'SELECT value FROM license';
        $db  = new dbsqlite(DB_PATH . '/private.db');
        return $db->query($sql)->getCount();
    }

	function getSuffixOfFileName($fileName, $length = 3) {   
        $result = '';
        $p      = strrpos($fileName, '.'); 
        if (false !== $p) {
            $result = substr($fileName, $p+1, $length); 
        }
        return $result;
    } 

    if (!empty($_FILES)) {
		//Import license
		$str_match =  getSuffixOfFileName($_FILES['licenseFile']['name'],3);
		if ($str_match!=='dat') {
			$result = '0';
			echo json_encode(array('status' => true,'msg' => $result));
		} else {
			$dPath = '/tmp';
			$uploadfs = new fileUpload($_FILES,$dPath);
			$uploadfs->upload();
			$cmd  = '/usr/local/license/bin/sls_upload /tmp/' .
			$_FILES['licenseFile']['name'];
			$cli  = new cli();
			$cli->run($cmd);
			$result = '导入成功';
			echo json_encode(array('status' => true,'msg' => $result));
		}
    } else if (isset($_POST['orderStatement'])) {
		//Call getLicenseInformation()
		$orderStatement = $_POST['orderStatement'];
        getLicenseInformation($orderStatement);
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

