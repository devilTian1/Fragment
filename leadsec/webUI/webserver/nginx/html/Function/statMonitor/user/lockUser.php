<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    
	function getWhereStatement($db, $cols, $keyword) {
        $value = '%' . $keyword . '%';
        $params = array_fill(0, count(explode(',', $cols)), $value);
        return array('sql'    => ' AND (' .
                              $db->getWhereStatement($cols, 'OR', 'like') . ')',
                     'params' => $params);
    }
    function getDataCount() {
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_name FROM user where locked != 0";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        return $db->query($sql, $params)->getCount();
    }

    function freshUserList($where) {
        $tpl  = 'statMonitor/user/lockUserTable.tpl';
        $db  = new dbsqlite(DB_PATH . '/uma_auth.db');
        $sql = "SELECT user_online.user_id, user.user_name, user.unlock_time,".
        	"user_role_map.Role_id,role.role_name FROM user_online,user,".
        	"user_role_map,role where user.user_id = user_online.user_id".
        	" and user.locked != 0 and user_role_map.User_id = user_online.user_id".
        	" and role.role_id = user_role_map.Role_id  ";
        $params = array();
        if (!empty($_GET['cols']) && !empty($_GET['keyword'])) {
            $data   = getWhereStatement($db, $_GET['cols'], $_GET['keyword']);
            $sql   .= $data['sql'];
            $params = $data['params'];
        }
        $sql .=  ' ' . $where;
        $result = $db->query($sql, $params)->getAllData(PDO::FETCH_ASSOC);
                 
    	$lockUser = array();
    	foreach ($result as $d) {
    		$id = $d['user_id'];    		
    		$user['user_name'] = $d['user_name'];
            $user['unlock_time'] = $d['unlock_time'];	            		                      
            $user['role_name'] = $d['role_name'];                     
            $lockUser[]=$user;        
        }     	
        echo V::getInstance()->assign('lockUser', $lockUser)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }
    
   if ($name = $_POST['unlockUsersTime']) {
        // 时间解锁
        $cli = new cli(); 
        $cmd = "user unlock username \"$name\"";        	       	      	         	 	      	
        $cli->setLog("名称为".$_POST['unlockUsersTime']."的用户进行时间解锁")->run($cmd);
        echo json_encode(array('msg' => '时间解锁成功。'));
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
