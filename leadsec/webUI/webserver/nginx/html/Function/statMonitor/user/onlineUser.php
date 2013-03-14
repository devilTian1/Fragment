<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_id FROM user_online";
        return $db->query($sql)->getCount();
    }

    function freshUserList($where) {
        $tpl  = 'statMonitor/user/onlineUserTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_online.user_id,user_online.ip, user_online.logon_time,".
        	" user_online.online_time, user.user_name, user.auth_type,".
        	"user_role_map.Role_id,role.role_name FROM user_online,user,".
        	"user_role_map,role where  user.user_id = user_online.user_id ".
        	"and user.locked = 0 and user_role_map.User_id = user_online.user_id ".
        	"and role.role_id = user_role_map.Role_id $where ";         
        $result = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $userOnline = array();
    	foreach ($result as $d) {
    		$id = $d['user_id'];
    		$user['user_name'] = $d['user_name'];
            $user['auth_type'] = $d['auth_type'];	
    		$user['user_id'] = $d['user_id'];                               	
            $user['ip'] = $d['ip'];
            $user['logon_time'] = $d['logon_time'];
            $user['online_time'] = $d['online_time'];	
            $user['role_name'] = $d['role_name'];           
            $userOnline[]=$user;        
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
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        }  
        echo json_encode(array('msg' => '刷新成功.'));
    }else if (!empty($_POST['delAllUsers'])) {
        // 在线用户全部下线
        $cmdArr = array("user break all","user show online total",
        	"user show online");       	         	 	      	
        $cli = new cli(); 
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        }  
        echo json_encode(array('msg' => '在线用户全部下线.'));
    }else if ($name = $_POST['delSpecUsersName']) {
        // 强制用户下线
        $cli = new cli(); 
        $cmdArr = array("user break username \"$name\"",
        	"user show online total","user show online");       	      	         	 	      	
    	foreach ($cmdArr as $cmd) {
            $cli->run($cmd);
        }  
        echo json_encode(array('msg' => '用户下线成功.'));
    } else if ($name = $_POST['lockUser']) {
        //锁定用户
        $time = getLockTimeByName($name);
        $tpl  = 'statMonitor/user/editLockUserOnlineDialog.tpl';
        $result = V::getInstance()
            ->assign('name', $name)
            ->assign('lockTime', $time)
            ->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ($name = $_POST['resetSpecUsersTime']) {
        // 时间重置
        $cli = new cli(); 
        $cmd = "user reset username \"$name\" time";        	       	      	         	 	      	
        $cli->run($cmd); 
        echo json_encode(array('msg' => '时间重置成功.'));
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
