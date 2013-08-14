<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getANDStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }
    function getWhereStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' where (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }
    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_online.user_id FROM user_online,user,user_role_map,role";       
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	if($_GET['keyword'] === '免认证'){
        		$sql .= ' and user.auth_type=0 ';
        	}else if($_GET['keyword'] === '本地密码认证'){
        		$sql .= ' and user.auth_type=1 ';
        	}else if($_GET['keyword'] === '双因子认证'){
        		$sql .= ' and user.auth_type=5 ';
        	}else{
        		$data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            	$sql   .= $data['sql'];
            	$params = $data['params'];
        	}          
        }
        return $db->query($sql, $params)->getCount();
    }

    function freshUserList($where) {
        $tpl  = 'statMonitor/user/onlineUserTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_online.user_id,user_online.ip, user_online.logon_time,".
        	" user_online.online_time, user.user_name, user.auth_type,".
        	"user_role_map.Role_id,role.role_name FROM user_online,user,".
        	"user_role_map,role where  user.user_id = user_online.user_id ".
        	"and user.locked = 0 and user_role_map.User_id = user_online.user_id ".
        	"and role.role_id = user_role_map.Role_id  ";         
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
        	if($_GET['keyword'] === '免认证'){
        		$sql .= ' and user.auth_type=0 ';
        	}else if($_GET['keyword'] === '本地密码认证'){
        		$sql .= ' and user.auth_type=1 ';
        	}else if($_GET['keyword'] === '双因子认证'){
        		$sql .= ' and user.auth_type=5 ';
        	}else{
        		$data   = getANDStatement($db, $_GET['cols'], $_GET['keyword']);
            	$sql   .= $data['sql'];
            	$params = $data['params'];	
        	}           
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
        $userOnline = array();
    	foreach ($result as $d) {
    		$id                  = $d['user_id'];
    		$user['user_name']   = $d['user_name'];
            $user['auth_type']   = $d['auth_type'];	
    		$user['user_id']     = $d['user_id'];
            $user['ip']          = $d['ip'];
            $user['logon_time']  = $d['logon_time'];
            $user['online_time'] = $d['online_time'];	
            $user['role_name']   = $d['role_name'];           
            $userOnline[]        = $user;      
        }
        echo V::getInstance()->assign('userOnline', $userOnline)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getLockTimeByName($name) {
        $db     = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql    = "SELECT unlock_time FROM user WHERE user_name = '$name'";
        $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $result['unlock_time'];       
    }
    
   if (!empty($_POST['refreshAllUsers'])) {
        // 刷新在线用户
        $cmdArr = array("user show online total","user show online");       	         	 	      	
        $cli = new cli(); 
    	$cli->setLog("刷新在线用户")->run($cmdArr[0]); 
    	$cli->setLog("显示在线用户")->run($cmdArr[1]); 
        echo json_encode(array('msg' => '刷新成功。'));
    }else if (!empty($_POST['delAllUsers'])) {
        // 在线用户全部下线
        $cmdArr = array("user break all","user show online total",
        	"user show online");       	         	 	      	
        $cli = new cli(); 
        $cli->setLog("使在线用户全部下线")->run($cmdArr[0]); 
    	$cli->setLog("所有在线用户")->run($cmdArr[1]); 
    	$cli->setLog("显示在线用户")->run($cmdArr[2]);   
        echo json_encode(array('msg' => '在线用户全部下线。'));
    }else if ($name = $_POST['delSpecUsersName']) {
        // 强制用户下线
        $cli = new cli(); 
        $cmdArr = array("user break username \"$name\"",
        	"user show online total","user show online");       	      	         	 	      	
    	$cli->setLog("名称为".$_POST['delSpecUsersName']."用户下线")
            ->run($cmdArr[0]); 
    	$cli->setLog("所有在线用户")->run($cmdArr[1]); 
    	$cli->setLog("显示在线用户")->run($cmdArr[2]);   
        echo json_encode(array('msg' => '用户下线成功。'));
    } else if ($name = $_POST['resetSpecUsersTime']) {
        // 时间重置
        $cli = new cli(); 
        $cmd = "user reset username \"$name\" time";        	       	      	         	 	      	
        $cli->setLog("对名称为" . $_POST['resetSpecUsersTime'] . "用户时间重置")
            ->run($cmd);  
        echo json_encode(array('msg' => '时间重置成功。'));
    } else if ($order = $_POST['orderStatement']) { 
        // Fresh and resort user list Table
        freshUserList($order);
    } else {
        // Init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
