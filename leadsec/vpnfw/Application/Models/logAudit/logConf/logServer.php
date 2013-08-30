<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';

    class logServerModel {
        
        public function getInitPageData() {
            $this->db = new dbsqlite('configs', DB_PATH . '/configs.db');
            $data     = $this->db->getInstance('configs')
                                 ->query('SELECT logsrv, protocol,port FROM logsrv')
                                 ->getFirstData(PDO::FETCH_ASSOC);
            return $data;
        }

        public function setLogServer() {
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
