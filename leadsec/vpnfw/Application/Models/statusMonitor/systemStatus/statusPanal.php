<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';

    class statusPanalModel {
        
        public function getInitPageData() {
            $this->db = new dbsqlite('configs', DB_PATH . '/configs.db');
            $data     = $this->db->getInstance('configs')
                                 ->query('SELECT dnssrv, dnssrv2 FROM dnssrv')
                                 ->getFirstData(PDO::FETCH_ASSOC);
            return $data;
        }

        public function setDns() {
            $cli     = new cli();
            $dnssrv  = $_POST['dnssrv'];
            $dnssrv2 = $_POST['dnssrv2'];

            if ('' === $dnssrv && '' === $dnssrv2) {
                $cmd = 'dns unset';
                $log = '将域名服务器IP置空';
            } else {
                $cmd = "dns set ip $dnssrv $dnssrv2";
                $log = '设置域名服务器IP';
            }
            $cli->setLog($log)->run($cmd);
        }
    }
?>
