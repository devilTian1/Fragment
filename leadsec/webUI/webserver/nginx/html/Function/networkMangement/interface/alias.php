<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 	
    function freshAlias($where) {
        $tpl =  'networkMangement/interface/aliasTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT external_name, ip, mask, phy_device, alias_id, enable FROM interface WHERE alias_id != -1 $where";
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        echo V::getInstance()->assign('list', $result)
        	->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getBindDev() {
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = 'SELECT external_name FROM interface WHERE enable == 1 AND alias_id == -1';
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
        $ip         = $_POST['ip'];
        $mask       = $_POST['mask'];
        $adm        = $_POST['admin'] === 'on' ? 'on' : 'off';
        $ping       = $_POST['ping'] === 'on' ? 'on' : 'off';
        $traceRoute = $_POST['traceroute'] === 'on' ? 'on' : 'off';
        $enable     = $_POST['enable'] === 'on' ? 'on' : 'off';
        
        if ($action === 'add') {
            $alias = "bind_if $name alias_id $id";
        } else { //set
            $alias = "if {$name}_{$id}";
        } 
        $result = "interface $action alias $alias " .
            "active $enable ip $ip netmask $mask admin $adm ping $ping " .
            "traceroute $traceRoute";
        return $result;
    }

    function getDataCount() {
        $sql = "SELECT external_name FROM interface where alias_id!=-1";
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        return $db->query($sql)->getCount();
    }

    if (!empty($_POST['name'])) {
        // Get specifie Alias data
        $result = array();
        $name   = $_POST['name'];
        $tpl = $_POST['tpl'];
        $db  = new dbsqlite(DB_PATH . '/configs.db');
        $sql = "SELECT phy_device, alias_id, ip, mask, admin, ping, traceroute, enable " .
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
        $cli->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ('add' === $_POST['type']) {
        // Add the specified Alias
        $cmd = getCmd('add');
        $cli = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if (!empty($_POST['delName'])) {
        // Delete specified Alias data
        $name = $_POST['delName'];
        $cli  = new cli();
        $cli->run("interface del if $name");
        echo json_encode(array('msg' => "删除别名[$name]成功."));
    } else if ($action = $_POST['action']) {
        // Switch specified alias device
        $name = $_POST['switch_name'];
        $cli = new cli();
        if ($action === 'disable') {
            $cmd = "interface set alias if $name active off";
            $cli->run($cmd);
            echo json_encode(array('msg' => "[$name]已关闭."));
        } else if ($action === 'enable') {
            $cmd = "interface set phy if $name active on";
            $cli->run($cmd);
            echo json_encode(array('msg' => "[$name]已启动."));
        } else {
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort alias Table
        freshAlias($orderStatement);
    }else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
