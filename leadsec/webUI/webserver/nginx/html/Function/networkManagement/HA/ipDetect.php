<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshIpListAddr($where) {
        $result = array();
        $tpl =  'networkManagement/HA/ipDetectTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/netgap_ha_ip_dct.db');
        $sql = "SELECT * FROM ha_ip_detect";
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $data = $db->query($sql,$params)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $d) {
            $result[] = array(
                'ip'     => $d['ip'],
                'comment'=> $d['comment']
            );
        }
        echo V::getInstance()->assign('list', $result)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    
    function getSpecIp($ip) {
        $sql = 'SELECT * FROM ha_ip_detect ' .
            "WHERE ip = '$ip'";
        $db     = new dbsqlite(DB_PATH . '/netgap_ha_ip_dct.db');
        $data   = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result = array();
        $result['ip'] = $data['ip'];
        $result['comment']   = $data['comment'];
        return $result;
    }
  
	function getWhereStatement($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' WHERE (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }

    function getDataCount() {
        $sql = 'SELECT ip FROM ha_ip_detect';
        $db  = new dbsqlite(DB_PATH . '/netgap_ha_ip_dct.db');
		$params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql,$params)->getCount();
    }    

	function getSameIpCount($ip) {
		$sql = "select ip from ha_ip_detect where ip = '$ip'";
		$db     = new dbsqlite(DB_PATH . '/netgap_ha_ip_dct.db');
		$count  = $db->query($sql)->getCount();
		return $count;
	}

    if ('edit' === $_POST['type']) {
        // edit new ip detect address data
			$old_ip = $_POST['old_sip'];
			$new_ip = $_POST['sip'];
			$comment= $_POST['comment'];
			$cmd = "haipdctctl set oldip $old_ip newip $new_ip comment \"$comment\"";
			$msg_log = "网络管理下的双机热备模块下对IP探测的修改";
            $cli = new cli();
            $cli->setLog($msg_log)->run($cmd);
            echo json_encode(array('msg' => '修改成功.'));
    } else if (!empty($_POST['editIp'])) {
        // show dialog for editing specified address data
        $tpl  = 'networkManagement/HA/editIpDetectDialog.tpl';
		$ip   = $_POST['editIp'];
		$data = getSpecIp($ip);
        $result = V::getInstance()->assign('res', $data)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // add new virtual address data
		$ip  = $_POST['sip'];
		$comment = $_POST['comment'];
		$count = getSameIpCount($ip);
		if ($count > 0){
			echo json_encode(array('msg' =>$ip."地址已存在,不能重复添加!"));
		} else {
			$cmd = "haipdctctl add ip $ip comment \"$comment\"";
			$msg_log = "网络管理下的双机热备模块下添加了对".$ip."的探测";
			$cli = new cli();
			$cli->setLog($msg_log)->run($cmd);
			echo json_encode(array('msg' => '添加成功.'));
		}
    } else if ($_POST['openNewIpDialog']) {
        // show dialog to add new ip address data
        $tpl    = 'networkManagement/HA/editIpDetectDialog.tpl';
        $result = V::getInstance()->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['delip'])) {
        // Delete specified data
        $ip  = $_POST['delip'];
		$cmd = "haipdctctl del ip $ip";
		$msg_log = "网络管理下的双机热备模块下对".$ip."探测进行了删除";
		$cli  = new cli();
		$cli->setLog($msg_log)->run($cmd);
		echo json_encode(array('msg' => "删除成功."));
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort virtual address Table
        freshIpListAddr($orderStatement);
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
