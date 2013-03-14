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
            $cmd = "ctcpctl start 1>/dev/null"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_ctcp]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }           
    }else if ($action_cudp = $_POST['action_cudp']) {
        // 定制访问(udp)    
        $name_cudp = $_POST['switch_name_cudp'];
        if ($action_cudp === 'disable') {
           	$cmd = "cudpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_cudp]已关闭."));
        } else if ($action_cudp === 'enable') {
            $cmd = "cudpctl start 1>/dev/null"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_cudp]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }else if ($action_db = $_POST['action_db']) {
        // 数据库访问    
        $name_db = $_POST['switch_name_db'];
        if ($action_db === 'disable') {
           	$cmd = "dbctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_db]已关闭."));
        } else if ($action_db === 'enable') {
            $cmd = "dbctl start 1>/dev/null"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_db]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }else if ($action_dbswap = $_POST['action_dbswap']) {
        // 数据库同步    
        $name_dbswap = $_POST['switch_name_dbswap'];
        if ($action_dbswap === 'disable') {
           	$cmd = "dbswapctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_dbswap]已关闭."));
        } else if ($action_dbswap === 'enable') {
            $cmd = "dbswapctl start 1>/dev/null"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_dbswap]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }else if ($action_sync = $_POST['action_sync']) {
        // 文件交换    
        $name_sync = $_POST['switch_name_sync'];
        if ($action_sync === 'disable') {
           	$cmd = "fsctl stop 1>/dev/null";         
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
    }else if ($action_fsnew = $_POST['action_fsnew']) {
        // 文件同步    
        $name_fsnew = $_POST['switch_name_fsnew'];
        if ($action_fsnew === 'disable') {
           	$cmd = "fs2ctl stop 1>/dev/null";         
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
    }else if ($action_ftp = $_POST['action_ftp']) {
        // FTP访问    
        $name_ftp = $_POST['switch_name_ftp'];
        if ($action_ftp === 'disable') {
           	$cmd = "cftpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_ftp]已关闭."));
        } else if ($action_ftp === 'enable') {
            $cmd = "cftpctl start 1>/dev/null"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_ftp]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }else if ($action_http = $_POST['action_http']) {
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
    }else if ($action_fastpass = $_POST['action_fastpass']) {
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
    }else if ($action_smtp = $_POST['action_smtp']) {
        // 邮件访问(SMTP)    
        $name_smtp = $_POST['switch_name_smtp'];
        if ($action_smtp === 'disable') {
           	$cmd = "smtpctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_smtp]已关闭."));
        } else if ($action_smtp === 'enable') {
            $cmd = "smtpctl start 1>/dev/null"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_smtp]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }else if ($action_pop3 = $_POST['action_pop3']) {
        // 邮件访问(pop3)    
        $name_pop3 = $_POST['switch_name_pop3'];
        if ($action_pop3 === 'disable') {
           	$cmd = "pop3ctl stop";         
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_pop3]已关闭."));
        } else if ($action_pop3 === 'enable') {
            $cmd = "pop3ctl start 1>/dev/null"; 
            $cli = new cli();
            $cli->run($cmd);
            echo json_encode(array('status' => 0, 'msg' => "[$name_pop3]已启动."));
        } else {        	
            echo json_encode(array('status' => -1, 'msg' => '执行动作错误.'));
        }
    }else if ($action_msgservice = $_POST['action_syncmsg']) {
        // 消息传输   
        $name_msgservice = $_POST['switch_name_syncmsg'];
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
        $ser_name = array(ctcp_status,cudp_status,db_status,db_swap_status,sync_status,fs_new_status,
                          http_status,sync_msg_status);
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
           	    $name = '文件交换';
            }
        	if ($ser_name[$i] == 'fs_new_status' ) {
           	    $name = '文件同步';
            }        	
        	if ($ser_name[$i] == 'http_status' ) {
           	    $name = '安全浏览';
            }
        	if ($ser_name[$i] == 'sync_msg_status' ) {
           	    $name = '消息传输';
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
        
        //从数据库gateway_ftp.db中读取FTP访问
        $ftp_name = array(ftp_status);
        $list_out_ftp = array(); 
        for ($i=0;$i<count($ftp_name);$i++) {
            $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
            $sql = "SELECT ".$ftp_name[0]." FROM system";
            $result_ftp[] = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
           //取得服务的状态值 ：开启为 1 、停止为 0                 
            foreach ($result_ftp[0] as $list_ftp) {
        	    foreach ($list_ftp as $row_ftp) {
        		    $value=$row_ftp[$ftp_name[0]];
        	    }    	       	
            } 
            //取得服务名字的全称
            if ($ftp_name[0] == 'ftp_status' ) {
           	    $name = 'FTP访问';
            }       	
            $list_name = array();
            $list_name['name']=$name;
            $list_name['value']= $value;                      
            $sp_index=split("_",$ftp_name[0]);         
            $list_name['index']= $sp_index[0];                   
            //确定最终的输出结果，包含名字、状态及简单索引  
            $list_out_ftp[0] = $list_name ;            
        }
        $list_out = array_merge($list_out,$list_out_ftp);
        //从数据库netgap_fastpass.db中读取安全通道
        $ftp_name = array(status);
        $list_out_ftp = array(); 
        for ($i=0;$i<count($ftp_name);$i++) {
            $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
            $sql = "SELECT ".$ftp_name[0]." FROM fastpass_status";
            $result_fastpass[] = $db->query($sql)
                  ->getAllData(PDO::FETCH_ASSOC);
           //取得服务的状态值 ：开启为 1 、停止为 0                 
            foreach ($result_fastpass[0] as $list_fastpass) {
        	    foreach ($list_fastpass as $row_fastpass) {
        		    $value=$row_fastpass[$ftp_name[0]];
        	    }    	       	
            } 
            //取得服务名字的全称
            if ($ftp_name[0] == 'status' ) {
           	    $name = '安全通道';
            }       	
            $list_name = array();
            $list_name['name']=$name;
            $list_name['value']= $value;                              
            $list_name['index']= "fastpass";                   
            //确定最终的输出结果，包含名字、状态及简单索引  
            $list_out_fastpass[0] = $list_name ;            
        }
        $list_out = array_merge($list_out,$list_out_fastpass);                                   
        V::getInstance()->assign('list_out', $list_out);                      
    }
?>
