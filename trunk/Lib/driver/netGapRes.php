<?php
    require_once(WEB_PATH . '/Lib/core/resource.php');

    class netGapRes extends RESOURCE {
        static public $instance;

        // including addList, addrGrp, domainAddr
        public function getAddr($isSA = false) {
            $db     = new dbsqlite(DB_PATH . '/rule.db');
            $sql    = 'SELECT name FROM address UNION SELECT name FROM addrgrp';
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            $result = array();
            foreach ($data as $d) {
                // delete suffix,eg: _ipv4 or ipv6
                $key = $d['name'];
                if ($key === 'any_ipv4' || $key === 'any_ipv6') {
                    $result = array_merge(array($key => 'any'), $result);
                } else {
                    $val = substr($key, 0, -5);
                    $result[$key] = $val;
                } 
            }
            if (!$isSA) {
                $sql = 'SELECT name FROM domain_property';
                $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
                foreach ($data as $d) {
                    $key = $d['name'];
                    $val = substr($key, 0, -5);
                    $result[$key] = $val;
                }
                if (count($result) === 0) {
                    return array('' => '无');
                }
            }
            return $result;
        }
        
     public function getAddrAndGroup($isSA = false) {
            $db     = new dbsqlite(DB_PATH . '/rule.db');
            $sql    = 'SELECT name FROM address UNION SELECT name FROM addrgrp';
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            $result = array();
            foreach ($data as $d) {
                // delete suffix,eg: _ipv4 or ipv6
                $key = $d['name'];
                if ($key === 'any_ipv4' || $key === 'any_ipv6') {
                 //   $result = array_merge(array($key => 'any'), $result);
                } else {
                    $val = substr($key, 0, -5);
                    $result[$key] = $val;
                } 
            }          
            return $result;
        }
        
        
    public function getAddrList($isSA = false) {
            $db     = new dbsqlite(DB_PATH . '/rule.db');
            $sql    = 'SELECT name FROM address';
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);  
            $result = array();         
            foreach ($data as $d) {
                // delete suffix,eg: _ipv4 or ipv6
                $key = $d['name'];
                if ($key === 'any_ipv4' || $key === 'any_ipv6') {
                  if ($isSA) {
                    $result = array_merge(array($key => 'any'), $result);
                  }
                } else {
                    $val = substr($key, 0, -5);
                    $result[$key] = $val;
                } 
            }  
     		if (count($result) === 0) {
                return array('' => '无');
            } 
            return $result;
        }     
       
        

        public function getTimeList() {
            $db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
            $sql = 'SELECT name FROM time_span WHERE spantype = 0 UNION ' .
                'SELECT distinct(name) AS name FROM time_grp';
            $result = array('' => '无');
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            foreach ($data as $d) {
                $name = $d['name'];
                $result[$name] = $name;
            }
            return $result;
        }
        
        public function getRoleList() {
            $db     = new dbsqlite(DB_PATH . '/uma_auth.db');
            $sql    = 'SELECT role_name FROM role';
            $result = array('' => '无');
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            foreach ($data as $d) {
                $role = $d['role_name'];
                $result[$role] = $role;
            }
            return $result;
        }

        public function getInterface() {
            $db     = new dbsqlite(DB_PATH . '/configs.db');
            $sql    = 'SELECT ip, ipv6 FROM interface WHERE enable="1"';
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            $result = array();
            foreach ($data as $d) {
                if (!empty($d['ip'])) {
                    $name = $d['ip']; 
                    $result[$name] = $name;
                }
                if (!empty($d['ipv6'])) {
                    $name = $d['ipv6']; 
                    $result[$name] = $name;
                }
            }
            if (count($result) === 0) {
                return array('' => '无');
            }         
            return $result;
        }

        public function getFileExFilterOpts() {
            $db     = new dbsqlite(DB_PATH . '/netgap_fs.db');
            $sql    = 'SELECT name FROM filter';
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            $result = array('' => '无');
            foreach ($data as $d) {
                $name = $d['name'];
                $result[$name] = $name;
            }
            return $result;
        }

        public function getFtpFilterOpts() {
            $db     = new dbsqlite(DB_PATH . '/gateway_ftp.db');
            $sql    = 'SELECT name FROM options';
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            $result = array('' => '无');
            foreach ($data as $d) {
                $name = $d['name'];
                $result[$name] = $name;
            }
            return $result;
        }

        public function getMailFilterOpts($type) {
            $db     = new dbsqlite(DB_PATH . '/netgap_mail.db');
            if ($type === 'smtp' || $type === 'pop3') {
                $sql = "SELECT name FROM filter WHERE protocol = '$type'";
            } else if ($type === 'allowedext') {
                $sql = 'SELECT name FROM attach_ext';
            } else if ($type === 'smailaddr') {
                $sql = 'SELECT name FROM mailaddr WHERE type = "发件人"';
            } else if ($type === 'rmailaddr') {
                $sql = 'SELECT name FROM mailaddr WHERE type = "收件人"';
            } else if ($type === 'title') {
                $sql = 'SELECT name FROM keyword WHERE type = "主题"';
            } else if ($type === 'content') {
                $sql = 'SELECT name FROM keyword WHERE type = "正文"';
            } else {
                throw new Exception("Can`t check [$type]");
            }
            $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            $result = array('' => '无');
            foreach ($data as $d) {
                $name = $d['name'];
                $result[$name] = $name;
            }
            return $result;
        }

        public function checkExistTaskId($modName, $id) {
            if ($modName === 'customized') {
                $sql = "SELECT id FROM tcp_comm_client_acl WHERE id = $id
                    UNION SELECT id FROM tcp_trans_client_acl WHERE id = $id
                    UNION SELECT id FROM udp_comm_server_acl WHERE id = $id
                    UNION SELECT id FROM tcp_comm_server_acl WHERE id = $id
                    UNION SELECT id FROM udp_comm_client_acl WHERE id = $id
                    UNION SELECT id FROM udp_trans_client_acl WHERE id = $id";
                $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
            } else if ($modName === 'ftp') {
                $sql = "SELECT id FROM ftp_comm_client_acl WHERE id = $id
                    UNION SELECT id FROM ftp_comm_server_acl WHERE id = $id
                    UNION SELECT id FROM ftp_trans_client_acl WHERE id = $id";
                $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
            } else if ($modName === 'dbSync'){
				$sql = "SELECT id FROM db_swap_client_acl WHERE id = $id
                    UNION SELECT id FROM db_swap_server_acl WHERE id = $id";
				$db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
			} else if ($modName === 'safepass') {
            	$sql = "SELECT id FROM fastpass_client_acl WHERE id = $id
            		UNION SELECT id FROM fastpass_server_acl WHERE id = $id";
            	$db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
            } else if ($modName === 'fileSync') {
            	$sql = "SELECT id FROM sync_file_client WHERE id = $id
            		UNION SELECT id FROM sync_file_server WHERE id = $id";
            	$db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
            } else if ($modName === 'trans') {
            	$sql = "SELECT id FROM db_comm_client_acl WHERE id = $id
            	    UNION SELECT id FROM db_comm_server_acl WHERE id = $id
            		UNION SELECT id FROM db_trans_client_acl WHERE id = $id";
            	$db  = new dbsqlite(DB_PATH . '/netgap_db.db');
            } else if ($modName === 'localUsrMng') {
            	$sql = "SELECT name FROM user WHERE name = '$id'";
            	$db  = new dbsqlite(DB_PATH . '/netgap_http.db');
            } else if ($modName === 'filterList') {
            	$sql = "SELECT list FROM url WHERE list = '$id'";
            	$db  = new dbsqlite(DB_PATH . '/netgap_http.db');
            }else if ($modName === 'msg') {
            	$sql = "SELECT id FROM msg_client_task WHERE id = $id
            		UNION SELECT id FROM msg_server_task WHERE id = $id";
                $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
            } else if ($modName === 'filterKeyword') {
            	$sql = "SELECT name FROM context WHERE name = '$id'";
            	$db  = new dbsqlite(DB_PATH . '/netgap_http.db');
            } else if ($modName === 'pop3') {
            	$sql = "SELECT id FROM pop3_comm_client_acl WHERE id = $id
                    UNION SELECT id FROM pop3_trans_client_acl WHERE id = $id
                    UNION SELECT id FROM pop3_comm_server_acl WHERE id = $id";
            	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
            } else if ($modName === 'smtp') {
            	$sql = "SELECT id FROM smtp_comm_client_acl WHERE id = $id
                    UNION SELECT id FROM smtp_trans_client_acl WHERE id = $id
                    UNION SELECT id FROM smtp_comm_server_acl WHERE id = $id";
            	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
            } else if ($modName === 'mailAddr') {
            	$sql = "SELECT name FROM mailaddr WHERE name = '$id'";
            	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
            } else if ($modName === 'keyword') {
            	$sql = "SELECT name FROM keyword WHERE name = '$id'";
            	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
            } else if ($modName === 'attachExt') {
            	$sql = "SELECT name FROM attach_ext WHERE name = '$id'";
            	$db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
            } else if ($modName === 'fileEx') {
            	$sql = "SELECT task_id FROM dir_info WHERE task_id = $id" ;           
        		$db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
            } else if ($modName === 'schedule') {
                $sql = "SELECT id FROM service WHERE virtual_ip='" . $id['virtualAddr'] . "' AND virtual_port='" . $id['virtualPort'] . "'";
                $db  = new dbsqlite(DB_PATH . '/netgap_ha.db');
            } else {
                throw new Exception("Can`t check [$modName]");
            }
            return $db->query($sql)->getCount() > 0 ? 'false' : 'true';
        }
        
        public function checkAliasUsed($aliasName) {
            $checkBuf = Array();
            
            $checkBuf[] = array('type'=>'ifname','dbPath'=>'/netgap_ha.db','table'=>'haif','colname'=>'ifname');
            $checkBuf[] = array('type'=>'ip','dbPath'=>'/gateway_ftp.db','table'=>'ftp_comm_client_acl','colname'=>'lip');
            $checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_custom.db','table'=>'tcp_comm_client_acl','colname'=>'lip');
            $checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_custom.db','table'=>'udp_comm_client_acl','colname'=>'lip');
            $checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_fastpass.db','table'=>'fastpass_client_acl','colname'=>'da');
            $checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_fastpass.db','table'=>'fastpass_server_acl','colname'=>'eip');
            $checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_db.db','table'=>'db_comm_client_acl','colname'=>'lip');
            $checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_msg.db','table'=>'msg_client_task','colname'=>'lip');
			$checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_mail.db','table'=>'pop3_comm_client_acl','colname'=>'lip');
            $checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_mail.db','table'=>'smtp_comm_client_acl','colname'=>'lip');
			$checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_db_swap.db','table'=>'db_swap_client_acl','colname'=>'lip');
			$checkBuf[] = array('type'=>'ip','dbPath'=>'/netgap_new_fs.db','table'=>'sync_file_client','colname'=>'lip');
            foreach($checkBuf as $arr) {
                if($arr['type'] === 'ip') {
                    $db  = new dbsqlite(DB_PATH . '/configs.db');
                    $sql = "SELECT ip,ipv6 FROM interface WHERE external_name='$aliasName'";
                    $result = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
                    $ip = $result['ip'];
                    $ipv6 = $result['ipv6'];
                    $sql = "SELECT {$arr['colname']} FROM {$arr['table']} WHERE {$arr['colname']}='$ip' OR {$arr['colname']}='$ipv6'";
                } else if ($arr['type'] === 'ifname') {                    
                    $sql = "SELECT {$arr['colname']} FROM {$arr['table']} WHERE {$arr['colname']}='$aliasName'";                    
                }
                $db  = new dbsqlite(DB_PATH . $arr['dbPath']);
                $result = $db->query($sql)->getCount() > 0 ? 'true' : 'false';
                if($result === 'true') {
                    return 'true';
                }
            }
            return 'false';
        }

        private function __clone() {}

        public function getInstance() {
            if (!isset(self::$instance)) {
                self::$instance = new self();
            }
            return self::$instance;
        }
    }
?>
