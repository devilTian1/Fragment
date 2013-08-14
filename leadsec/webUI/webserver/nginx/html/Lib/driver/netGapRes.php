<?php
    require_once(WEB_PATH . '/Lib/core/resource.php');

    class netGapRes extends RESOURCE {
        static public $instance;
        
        private $dbMapMod;

        public function __construct() {
            $this->dbMapMod = array(
                'netgap_fastpass.db/fastpass_client_acl' => '客户端/安全通道',
                'netgap_fastpass.db/fastpass_server_acl' => '服务端/安全通道',
                'gateway_ftp.db/ftp_trans_client_acl'    => '客户端/FTP访问',
                'gateway_ftp.db/ftp_comm_client_acl'     => '客户端/FTP访问',
                'netgap_db.db/db_comm_client_acl'        => '客户端/数据库访问',
                'netgap_db.db/db_trans_client_acl'       => '客户端/数据库访问',
                'netgap_msg.db/msg_client_task'          => '客户端/消息传输',
                'netgap_mail.db/pop3_comm_client_acl'  => '客户端/POP3邮件访问',
                'netgap_mail.db/pop3_trans_client_acl' => '客户端/POP3邮件访问',
                'netgap_mail.db/smtp_comm_client_acl'  => '客户端/SMTP邮件访问',
                'netgap_mail.db/smtp_trans_client_acl' => '客户端/SMTP邮件访问',
                'netgap_custom.db/tcp_comm_client_acl' => '客户端/TCP定制访问',
                'netgap_custom.db/tcp_trans_client_acl' => '客户端/TCP定制访问',
                'netgap_custom.db/udp_comm_client_acl' => '客户端/UDP定制访问',
                'netgap_custom.db/udp_trans_client_acl' => '客户端/UDP定制访问',
                'netgap_db_swap.db/db_swap_client_acl' => '客户端/数据库同步',
                'netgap_new_fs.db/sync_file_client'    => '客户端/文件交换',
                'netgap_http.db/basic_configure'       => '安全浏览/基本配置',
                'uma_auth.db/auth_policy' => '资源配置/用户/认证配置/认证策略',
                'netgap_http.db/acl'      => '安全浏览',
                'netgap_ha.db/haif'       => '双击热备'
            );
        }
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
            if ($modName === 'customizedtcp') {
                $sql = "SELECT id FROM tcp_comm_client_acl WHERE id = $id
                    UNION SELECT id FROM tcp_trans_client_acl WHERE id = $id                 
                    UNION SELECT id FROM tcp_comm_server_acl WHERE id = $id";                   
                $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
            }else if ($modName === 'customizedudp') {
                $sql = "SELECT id FROM udp_trans_client_acl WHERE id = $id                   
                    UNION SELECT id FROM udp_comm_server_acl WHERE id = $id                   
                    UNION SELECT id FROM udp_comm_client_acl WHERE id = $id";                   
                $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
            }else if ($modName === 'ftp') {
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
        
        private function checkAddrUsed($checkBuf, $addrName, $checkActive) {
            $result = array();
            foreach($checkBuf as $arr) {
                $idCol = 'id';
                $ipCol = $arr['colname'];
                $table = $arr['table'];
                if (isset($arr['taskId'])) {
                    $idCol = $arr['taskId'];
                }
                $activeSql = '';
                if ($checkActive && isset($arr['actSql'])) {
                    $activeSql = $arr['actSql'] . ' AND ';
                }
                if ($arr['type'] === 'ip') {
                    $db  = new dbsqlite(DB_PATH . '/configs.db');
                    $sql = 'SELECT ip, ipv6 FROM interface ' .
                        "WHERE external_name = '$addrName'";
                    $ipData = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
                    $ip     = $ipData['ip'];
                    $ipv6   = $ipData['ipv6'];
                    $sql    = "SELECT $idCol as id FROM {$arr['table']} " .
                        "WHERE $activeSql $ipCol = '$ip' OR $ipCol = '$ipv6'";
                } else if ($arr['type'] === 'ifname') {                    
                    $sql = "SELECT $idCol as id FROM $table " .
                        "WHERE $activeSql $ipCol = '$addrName'";
                }
                $dbPath  = $arr['dbPath'];
                $db      = new dbsqlite(DB_PATH . '/' . $dbPath);
                $modName = $this->dbMapMod[$dbPath . '/' . $table];
                $data    = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
                foreach ($data as $d) {
                    $id       = $d['id'];
                    $result[] = array('id' => $id, 'mod' => $modName);
                }
            }
            return $result;

        }

        public function checkAliasUsed($aliasName, $checkActive = false) {
            $checkBuf = array(
                array('type'    => 'ifname', 'table'  => 'haif',
                      'colname' => 'ifname', 'dbPath' => 'netgap_ha.db',
                      'taskId'  => 'ifname'),
                array('type'    => 'ip',  'table'  => 'ftp_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'gateway_ftp.db',
                      'actSql'  => 'active="Y"'),
                array('type'    => 'ip',  'table'  => 'tcp_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_custom.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'udp_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_custom.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'fastpass_server_acl',
                      'colname' => 'eip', 'dbPath' => 'netgap_fastpass.db',
                      'actSql'  => 'active="ok"'),
                array('type'    => 'ip',  'table'  => 'db_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_db.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'msg_client_task',
                      'colname' => 'lip', 'dbPath' => 'netgap_msg.db',
                      'actSql'  => 'active="ok"'),
                array('type'    => 'ip',  'table'  => 'pop3_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_mail.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'smtp_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_mail.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'db_swap_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_db_swap.db',
                      'actSql'  => 'active="Y"'),
                array('type'    => 'ip',  'table'  => 'sync_file_client',
                      'colname' => 'lip', 'dbPath' => 'netgap_new_fs.db'),
                array('type'    => 'ip',         'table'  => 'basic_configure',
                      'colname' => 'service_ip', 'dbPath' => 'netgap_http.db',
                      'taskId'  => 'service_ip')
            );
            return $this->checkAddrUsed($checkBuf, $aliasName, $checkActive);
        }
        
        public function checkPhysicalUsed($physicalName, $checkActive = false) {
            $checkBuf = array(
                array('type'    => 'ip',  'table'  => 'fastpass_client_acl',
                      'colname' => 'da',  'dbPath' => 'netgap_fastpass.db',
                      'actSql'  => 'active="ok"'),
                array('type'    => 'ip',  'table'  => 'fastpass_server_acl',
                      'colname' => 'eip', 'dbPath' => 'netgap_fastpass.db',
                      'actSql'  => 'active="ok"'),
                array('type'    => 'ip',  'table'  => 'ftp_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'gateway_ftp.db',
                      'actSql'  => 'active="Y"'),
                array('type'    => 'ip',  'table'  => 'tcp_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_custom.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'udp_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_custom.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'db_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_db.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'msg_client_task',
                      'colname' => 'lip', 'dbPath' => 'netgap_msg.db',
                      'actSql'  => 'active="ok"'),
                array('type'    => 'ip',  'table'  => 'pop3_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_mail.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'smtp_comm_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_mail.db',
                      'actSql'  => 'active="1"'),
                array('type'    => 'ip',  'table'  => 'db_swap_client_acl',
                      'colname' => 'lip', 'dbPath' => 'netgap_db_swap.db',
                      'actSql'  => 'active="Y"'),
                array('type'    => 'ip',  'table'  => 'sync_file_client',
                      'colname' => 'lip', 'dbPath' => 'netgap_new_fs.db'),
                array('type'    => 'ip',         'table'  => 'basic_configure',
                      'colname' => 'service_ip', 'dbPath' => 'netgap_http.db',
                      'taskId'  => 'service_ip'),
                array('type'    => 'ifname',         'table'  => 'auth_policy',
                      'colname' => 'ingress',        'dbPath' => 'uma_auth.db',
                      'taskId'  => 'auth_policy_id', 'actSql' => 'active="1"'),
            );
            return $this->checkAddrUsed($checkBuf, $physicalName, $checkActive);
        }

        public function checkAddrResUsed($name, $checkActive = false) {
            $result   = array();
            $checkBuf = array(
                array('table'   => 'sync_file_client',
                      'dbPath'  => 'netgap_new_fs.db',
                      'colname' => 'sa'),
                array('table'   => 'db_comm_client_acl',
                      'dbPath'  => 'netgap_db.db',
                      'activeW' => 'active="1"',
                      'colname' => 'sa'),
                array('table'   => 'db_trans_client_acl',
                      'dbPath'  => 'netgap_db.db',
                      'activeW' => 'active="1"',
                      'colname' => array('sa', 'da')),
                array('table'   => 'acl',
                      'dbPath'  => 'netgap_http.db',
                      'colname' => array('sip', 'dip')),
                array('table'   => 'ftp_comm_client_acl',
                      'dbPath'  => 'gateway_ftp.db',
                      'activeW' => 'active="Y"',
                      'colname' => 'sa'),
                array('table'   => 'ftp_trans_client_acl',
                      'dbPath'  => 'gateway_ftp.db',
                      'activeW' => 'active="Y"',
                      'colname' => array('sa', 'da')),
                array('table'   => 'pop3_comm_client_acl',
                      'dbPath'  => 'netgap_mail.db',
                      'activeW' => 'active="1"',
                      'colname' => 'sa'),
                array('table'   => 'pop3_trans_client_acl',
                      'dbPath'  => 'netgap_mail.db',
                      'activeW' => 'active="1"',
                      'colname' => array('sa', 'da')),
                array('table'   => 'smtp_comm_client_acl',
                      'dbPath'  => 'netgap_mail.db',
                      'activeW' => 'active="1"',
                      'colname' => 'sa'),
                array('table'   => 'smtp_trans_client_acl',
                      'dbPath'  => 'netgap_mail.db',
                      'activeW' => 'active="1"',
                      'colname' => array('sa', 'da')),
                array('table'   => 'db_swap_client_acl',
                      'dbPath'  => 'netgap_db_swap.db',
                      'activeW' => 'active="Y"',
                      'colname' => 'sa'),
                array('table'   => 'tcp_comm_client_acl',
                      'dbPath'  => 'netgap_custom.db',
                      'activeW' => 'active="1"',
                      'colname' => 'sa'),
                array('table'   => 'tcp_trans_client_acl',
                      'dbPath'  => 'netgap_custom.db',
                      'activeW' => 'active="1"',
                      'colname' => array('sa', 'da')),
                array('table'   => 'udp_comm_client_acl',
                      'dbPath'  => 'netgap_custom.db',
                      'activeW' => 'active="1"',
                      'colname' => 'sa'),
                array('table'   => 'udp_trans_client_acl',
                      'dbPath'  => 'netgap_custom.db',
                      'activeW' => 'active="1"',
                      'colname' => array('sa', 'da')),
                array('table'   => 'fastpass_client_acl',
                      'dbPath'  => 'netgap_fastpass.db',
                      'activeW' => 'active="ok"',
                      'colname' => 'sa'),
                array('table'   => 'msg_client_task',
                      'dbPath'  => 'netgap_msg.db',
                      'activeW' => 'active="ok"',
                      'colname' => 'sa')
            );
            foreach ($checkBuf as $arr) {
                $table     = $arr['table'];
                $dbPath    = $arr['dbPath'];
                $colName   = $arr['colname'];
                $activeSql = '';
                if ($checkActive && isset($arr['activeW'])) {
                    $activeSql = $arr['activeW'] . ' AND ';
                }
                if (!is_array($colName)) {
                    $colName = array($colName);
                }
                $where = array();
                foreach ($colName as $cn) {
                    $where[] = "$cn='{$name}_ipv4' OR $cn='{$name}_ipv6'";
                }
                $where   = 'WHERE ' . $activeSql . '(' .
                    join(' OR ', $where) . ')';
                $modName = $this->dbMapMod[$dbPath . '/' . $table];
                $db      = new dbsqlite(DB_PATH . '/' . $dbPath);
                $sql     = "SELECT id FROM $table $where";
                $data    = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
                foreach ($data as $d) {
                    $result[] = array('id' => $d['id'], 'mod' => $modName);
                }
            }
            return $result;
        }
        
        public function checkRoleUsed($roleName, $checkActive = false) {
            $checkBuf = array(
                array('table'  => 'acl', 'activeW' => '',
                      'colname' => 'usergrp',  'dbPath' => 'netgap_http.db'),
                array('table'   => 'ftp_trans_client_acl',  'activeW'  => 'active="Y"',
                      'colname' => 'usergrp', 'dbPath' => 'gateway_ftp.db'),
                array('table'    => 'ftp_comm_client_acl',  'activeW'  => 'active="Y"',
                      'colname' => 'usergrp', 'dbPath' => 'gateway_ftp.db'),
                array('table'    => 'pop3_comm_client_acl',  'activeW'  => 'active="ok"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_mail.db'),
                array('table'    => 'pop3_trans_client_acl',  'activeW'  => 'active="ok"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_mail.db'),
                array('table'    => 'smtp_comm_client_acl',  'activeW'  => 'active="ok"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_mail.db'),
                array('table'    => 'smtp_trans_client_acl',  'activeW'  => 'active="ok"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_mail.db'),
                array('table'    => 'db_trans_client_acl',  'activeW'  => 'active="Y"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_db.db'),
                array('table'    => 'db_comm_client_acl',  'activeW'  => 'active="Y"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_db.db'),
                array('table'    => 'tcp_comm_client_acl',  'activeW'  => 'active="Y"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_custom.db'),
                array('table'    => 'tcp_trans_client_acl',  'activeW'  => 'active="Y"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_custom.db'),
                array('table'    => 'udp_comm_client_acl',  'activeW'  => 'active="Y"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_custom.db'),
                array('table'    => 'udp_trans_client_acl',  'activeW'  => 'active="Y"',
                      'colname' => 'usergrp', 'dbPath' => 'netgap_custom.db')
            );
            foreach ($checkBuf as $arr) {
                $table     = $arr['table'];
                $dbPath    = $arr['dbPath'];
                $colName   = $arr['colname'];
                $activeSql = '';
                if ($checkActive && isset($arr['activeW'])) {
                    $activeSql = $arr['activeW'] . ' AND ';
                }
                if (!is_array($colName)) {
                    $colName = array($colName);
                }
                $where = array();
                foreach ($colName as $cn) {
                    $where[] = "$cn='{$roleName}'";
                }
                $where   = 'WHERE ' . $activeSql . '(' .
                    join(' OR ', $where) . ')';
                $modName = $this->dbMapMod[$dbPath . '/' . $table];
                $db      = new dbsqlite(DB_PATH . '/' . $dbPath);
                $sql     = "SELECT id FROM $table $where";
                $data    = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
                foreach ($data as $d) {
                    $result[] = array('id' => $d['id'], 'mod' => $modName);
                }
            }
            return $result;
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
