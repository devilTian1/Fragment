<?php
    require_once(WEB_PATH . '/Lib/core/resource.php');

    class netGapRes extends RESOURCE {
        static public $instance;

        // including addList, addrGrp, domainAddr
        public function getAddr() {
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
            $sql = 'SELECT name FROM domain_property';
            $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
            foreach ($data as $d) {
                $val = $d['name'];
                $key = $val . '_ipv4';
                $result[$key] = $val;
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
            		UNION SELECT id FROM db_trans_client_acl WHERE id = $id";
            	$db  = new dbsqlite(DB_PATH . '/netgap_db.db');
            }else {
                throw new Exception("Can`t check [$modName]");
            }
            return $db->query($sql)->getCount() > 0 ? 'false' : 'true';
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
