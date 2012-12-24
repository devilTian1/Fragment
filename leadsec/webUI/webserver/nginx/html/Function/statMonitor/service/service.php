<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    if ($action_ctcp = $_POST['action_ctcp']) {
        // 定制访问(tcp)    
        $name_ctcp = $_POST['switch_name_ctcp'];
        if ($action_ctcp === 'disable') {
           	$cmd = "ctcpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_ctcp]已关闭."));
        } else if ($action_ctcp === 'enable') {
            $cmd = "ctcpctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_ctcp]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }           
    } 
    if ($action_cudp = $_POST['action_cudp']) {
        // 定制访问(udp)    
        $name_cudp = $_POST['switch_name_cudp'];
        if ($action_cudp === 'disable') {
           	$cmd = "cudpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_cudp]已关闭."));
        } else if ($action_cudp === 'enable') {
            $cmd = "cudpctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_cudp]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }
    if ($action_db = $_POST['action_db']) {
        // 数据库访问    
        $name_db = $_POST['switch_name_db'];
        if ($action_db === 'disable') {
           	$cmd = "dbctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_db]已关闭."));
        } else if ($action_db === 'enable') {
            $cmd = "dbctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_db]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }
    if ($action_dbswap = $_POST['action_dbswap']) {
        // 数据库同步    
        $name_dbswap = $_POST['switch_name_dbswap'];
        if ($action_dbswap === 'disable') {
           	$cmd = "dbswapctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_dbswap]已关闭."));
        } else if ($action_dbswap === 'enable') {
            $cmd = "dbswapctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_dbswap]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }
    if ($action_sync = $_POST['action_sync']) {
        // 文件同步    
        $name_sync = $_POST['switch_name_sync'];
        if ($action_sync === 'disable') {
           	$cmd = "fsctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_sync]已关闭."));
        } else if ($action_sync === 'enable') {
            $cmd = "fsctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_sync]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }
    if ($action_fsnew = $_POST['action_fsnew']) {
        // 文件交换    
        $name_fsnew = $_POST['switch_name_fsnew'];
        if ($action_fsnew === 'disable') {
           	$cmd = "fs2ctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_fsnew]已关闭."));
        } else if ($action_fsnew === 'enable') {
            $cmd = "fs2ctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_fsnew]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }
    if ($action_ftp = $_POST['action_ftp']) {
        // FTP访问    
        $name_ftp = $_POST['switch_name_ftp'];
        if ($action_ftp === 'disable') {
           	$cmd = "cftpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_ftp]已关闭."));
        } else if ($action_ftp === 'enable') {
            $cmd = "cftpctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_ftp]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }
    if ($action_http = $_POST['action_http']) {
        // 安全浏览    
        $name_http = $_POST['switch_name_http'];
        if ($action_http === 'disable') {
           	$cmd = "httpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_http]已关闭."));
        } else if ($action_http === 'enable') {
            $cmd = "httpctl_start.sh"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_http]已启动."));
            
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }
    if ($action_fastpass = $_POST['action_fastpass']) {
        // 安全通道    
        $name_fastpass = $_POST['switch_name_fastpass'];
        if ($action_fastpass === 'disable') {
           	$cmd = "fpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_fastpass]已关闭."));
        } else if ($action_fastpass === 'enable') {
            $cmd = "fpctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_fastpass]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }      
    if ($action_smtp = $_POST['action_smtp']) {
        // 邮件访问(SMTP)    
        $name_smtp = $_POST['switch_name_smtp'];
        if ($action_smtp === 'disable') {
           	$cmd = "smtpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_smtp]已关闭."));
        } else if ($action_smtp === 'enable') {
            $cmd = "smtpctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_smtp]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }
    if ($action_pop3 = $_POST['action_pop3']) {
        // 邮件访问(pop3)    
        $name_pop3 = $_POST['switch_name_pop3'];
        if ($action_pop3 === 'disable') {
           	$cmd = "pop3ctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_pop3]已关闭."));
        } else if ($action_pop3 === 'enable') {
            $cmd = "pop3ctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_pop3]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }    
    if ($action_msgservice = $_POST['action_msgservice']) {
        // 消息传输   
        $name_msgservice = $_POST['switch_name_msgservice'];
        if ($action_msgservice === 'disable') {
           	$cmd = "msgctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_msgservice]已关闭."));
        } else if ($action_msgservice === 'enable') {
            $cmd = "msgctl start"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_msgservice]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }else {
        // init service
        $ser_name = array(ctcp_status,cudp_status,db_status,db_swap_status,sync_status,fs_new_status,ftp_status,
                          http_status,fastpass_status);
        $list_out = array();
        //从数据库netgap_system.db中读取服务
        for ($i=0;$i<count($ser_name);$i++) {
            $db  = new dbsqlite(DB_PATH . '/netgap_system.db');
            $sql = "SELECT ".$ser_name[$i]." FROM system";
            $result[] = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
           //取得服务的状态值 ：开启为 1 、停止为 0                 
            foreach ($result[$i] as $list) {
        	    foreach ($list as $row) {
        		    $value=$row[$ser_name[$i]];
        	    }    	       	
            }           
           //取得服务名字 的全称
            if ($ser_name[$i] == 'ctcp_status' ) {
           	    $name = '定制服务(tcp)';
            }
            if ($ser_name[$i] == 'cudp_status' ) {
           	    $name = '定制服务(udp)';
            }
            if ($ser_name[$i] == 'ddos_status' ) {
           	    $name = '抗DDos攻击';
            }
        	if ($ser_name[$i] == 'db_status' ) {
           	    $name = '数据库访问';
            }
        	if ($ser_name[$i] == 'db_swap_status' ) {
           	    $name = '数据库同步';
            }
        	if ($ser_name[$i] == 'sync_status' ) {
           	    $name = '文件同步';
            }
        	if ($ser_name[$i] == 'fs_new_status' ) {
           	    $name = '文件交换';
            }
        	if ($ser_name[$i] == 'ftp_status' ) {
           	    $name = 'FTP访问';
            }
        	if ($ser_name[$i] == 'http_status' ) {
           	    $name = '安全浏览';
            }
        	if ($ser_name[$i] == 'fastpass_status' ) {
           	    $name = '安全通道';
            }       	        	
            $list_name = array();
            $list_name['name']=$name;
            $list_name['value']= $value;                      
            $sp_index=split("_",$ser_name[$i]);
            if (count($sp_index) == 2){
                $list_name['index']= $sp_index[0];    
            }
            else {
            	//count($sp_index) == 3
                $outl = $sp_index[0].$sp_index[1];           	
            	$list_name['index']= $outl;
            }           
            //确定最终的输出结果，包含名字、状态及简单索引  
            $list_out[$i] = $list_name ;          
        }  

        //从数据库netgap_mail.db中读取邮件服务 
        $mail_name = array(smtp_status,pop3_status); 
        $list_out_mail = array(); 
        for ($i=0;$i<count($mail_name);$i++) {
            $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
            $sql = "SELECT ".$mail_name[$i]." FROM mail_system";
            $result_mail[] = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
           //取得服务的状态值 ：开启为 1 、停止为 0                 
            foreach ($result_mail[$i] as $list_mail) {
        	    foreach ($list_mail as $row_mail) {
        		    $value=$row_mail[$mail_name[$i]];
        	    }    	       	
            } 
            //取得服务名字的全称
            if ($mail_name[$i] == 'smtp_status' ) {
           	    $name = '邮件服务(SMTP)';
            }
        	if ($mail_name[$i] == 'pop3_status' ) {
           	    $name = '邮件服务(pop3)';
            } 
            $list_name = array();
            $list_name['name']=$name;
            $list_name['value']= $value;                      
            $sp_index=split("_",$mail_name[$i]);           
            $list_name['index']= $sp_index[0];                   
            //确定最终的输出结果，包含名字、状态及简单索引  
            $list_out_mail[$i] = $list_name ;            
        }
        $list_out = array_merge($list_out,$list_out_mail); 
               
        //从数据库netgap_msg.db中读取消息传输
        $msg_name = array(service_status);
        $list_out_msg = array(); 
        for ($i=0;$i<count($msg_name);$i++) {
            $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
            $sql = "SELECT ".$msg_name[0]." FROM msg_ctl_status";
            $result_msg[] = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
           //取得服务的状态值 ：开启为 1 、停止为 0                 
            foreach ($result_msg[0] as $list_msg) {
        	    foreach ($list_msg as $row_msg) {
        		    $value=$row_msg[$msg_name[0]];
        	    }    	       	
            } 
            //取得服务名字的全称
            if ($msg_name[0] == 'service_status' ) {
           	    $name = '消息传输';
            }       	
            $list_name = array();
            $list_name['name']=$name;
            $list_name['value']= $value;                      
            $sp_index=split("_",$msg_name[0]);
            $sp_index[0]='msg'.$sp_index[0];          
            $list_name['index']= $sp_index[0];                   
            //确定最终的输出结果，包含名字、状态及简单索引  
            $list_out_msg[0] = $list_name ;            
        }
        $list_out = array_merge($list_out,$list_out_msg);                                       
        V::getInstance()->assign('list_out', $list_out);                      
    }
?>
