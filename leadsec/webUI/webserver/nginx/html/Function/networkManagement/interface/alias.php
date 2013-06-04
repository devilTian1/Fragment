<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    function freshAlias($where) {
        $tpl =  'networkManagement/interface/aliasTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT external_name, ip, mask, ipv6, ipv6_mask, phy_device,' .
            " alias_id, enable FROM interface WHERE alias_id != -1";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
          echo V::getInstance()->assign('list', $result)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getBindDev() {
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT external_name FROM interface WHERE enable = 1 AND ' .
            'alias_id = -1 AND workmode <> 3';
        $d   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($d as $v) {
            $result[] = $v['external_name'];
        }
        return $result;
    }

    function getCmd($action) {
        $name       = $_POST['external_name'];
        $id         = $_POST['aliasId'];
        $ipv4       = $_POST['devIpv4'];
        $ipv4Mask   = $_POST['ipv4Netmask'];
        $ipv4Mask   = !empty($ipv4Mask) ? convertToIpv4Mask($ipv4Mask) : '';
        $ipv6       = $_POST['devIpv6'];
        $ipv6Mask   = $_POST['ipv6Netmask'];
        $adm        = $_POST['admin'] === 'on' ? 'on' : 'off';
        $ping       = $_POST['ping'] === 'on' ? 'on' : 'off';
        $traceRoute = $_POST['traceroute'] === 'on' ? 'on' : 'off';
        $enable     = $_POST['enable'] === 'on' ? 'on' : 'off';
        
        $ipParams   = '';
        if (!empty($ipv4)) {
            $ipParams .= "ip $ipv4 netmask $ipv4Mask";
        }
        if (!empty($ipv4) && !empty($ipv6)) {
            $ipParams .= ' ';
        }
        if (!empty($ipv6)) {
            $ipParams .= "ipv6 $ipv6 ipv6_mask $ipv6Mask";
        }
 
        if ($action === 'add') {
            $alias = "bind_if $name alias_id $id";
        } else { //set
            $alias = "if {$name}";
        } 
        $result = "interface $action alias $alias " .
            "active $enable $ipParams admin $adm ping $ping " .
            "traceroute $traceRoute";
        return $result;
    }

    function getWhereStatement($db, $cols, $keyword) {
        $value  = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }
    
    function getDataCount() {
        $sql = "SELECT external_name FROM interface where alias_id!=-1";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }
    
    function isInUseCheck($name) {
        $sql = "SELECT ifname FROM haif where ifname='$name'";
        $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
        $num = $db->query($sql)->getCount();
        if(intval($num) > 0) {
            return true;
        } else {
            return false;
        }
    }
    
    if (!empty($_POST['name'])) {
        // Get specifie Alias data
        $result = array();
        $name   = $_POST['name'];
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT phy_device, alias_id, ip, mask, ipv6, ipv6_mask,' .
            ' admin, ping, traceroute, enable ' .
            "FROM interface WHERE external_name = '$name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        $result['bindDev'] = getBindDev();
        $result = V::getInstance()->assign('res', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['openNewAliasDialog'])) {
        // Open New Alias data Dialog
        $tpl    = $_POST['tpl'];
        $result = array();
        $result['bindDev'] = getBindDev();
        $result = V::getInstance()->assign('res', $result)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified Alias
        $cmd = getCmd('set');
        $cli = new cli();
        $cli->setLog("修改别名设备".$_POST['external_name'])->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add the specified Alias
        $cmd = getCmd('add');
        $cli = new cli();
		list($status,$result) = $cli->setLog("添加别名设备".$_POST['external_name'])->execCmdGetStatus($cmd);
        //$cli->setLog("添加别名设备".$_POST['external_name'])->run($cmd);
		if ($status>0) {
			echo json_encode(array('msg' => '该别名设备被占用,添加失败!'));
		} else {
			echo json_encode(array('msg' => '添加成功.'));
		} 
    } else if (!empty($_POST['delName'])) {
        // Delete specified Alias data
        $name = $_POST['delName'];
        $cli  = new cli();
        $cli->setLog("删除别名设备".$_POST['external_name'])->run("interface del if $name");
        echo json_encode(array('msg' => "删除别名[$name]成功."));
    } else if ($action = $_POST['action']) {
        // Switch specified alias device
        $name = $_POST['switch_name'];
        $cli = new cli();
        if ($action === 'disable') {
            $cmd = "interface set alias if $name active off";
            $cli->setLog("关闭别名设备{$name}")->run($cmd);
            echo json_encode(array('msg' => "[$name]已关闭."));
        } else if ($action === 'enable') {
            $cmd = "interface set alias if $name active on";
            $cli->setLog("启用别名设备{$name}")->run($cmd);
            echo json_encode(array('msg' => "[$name]已启动."));
        } else {
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    } else if ($_GET['isInUseCheck']) {
        $name = $_GET['checkName'];
        /*if(isInUseCheck($name)) {
            echo "true";
        } else {
            echo "false";
        }*/        
        if(netGapRes::getInstance()->checkAliasUsed($name) === 'true') {
            echo "true";
        } else {
            echo "false";
        }
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort alias Table
        freshAlias($orderStatement);
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
