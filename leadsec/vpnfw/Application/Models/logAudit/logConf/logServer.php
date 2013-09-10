<?php
    requireCache(WEB_PATH . '/Lib/driver/dbsqlite.php');
    
    class LogServerModel {
     	private $db;
        
        public function __construct() {
            $this->db  = new dbsqlite('configs', DB_PATH . '/configs.db');
        }
        
        public function getInitPageData() {
        	$sql	= "SELECT logsrv, protocol,port FROM logsrv";
            $data   = $this->db->getInstance('configs')
                                 ->query($sql)
                                 ->getFirstData(PDO::FETCH_ASSOC);
            return $data;
        }

        public function setLogServer() {
        	requireCache(WEB_PATH . '/Lib/driver/cli.php');
            $cli     = new cli();
            $logsrv  = $_POST['logsrv'];
            $port = $_POST['port'];
            $protocol = $_POST['protocol'];

            if ('' === $logsrv) {
                $cmd = 'logserver unset';
                $log = '将取消设置';
            } else {
                $cmd = "logserver set ip $logsrv port $port protocol udp";
                $log = '设置日志服务器';
            }
            $cli->setLog($log)->run($cmd);
        }
    }
?>
