<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';
	
	class DnsModel {
		public $msg = null;
		
		public function getInitPageData() {
            $db = new dbsqlite('configs', DB_PATH . '/configs.db');
            $initData     = $db->getInstance('configs')
                               ->query('SELECT dnssrv, dnssrv2 FROM dnssrv')
                               ->getFirstData(PDO::FETCH_ASSOC);
			return $initData;
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
			try{
				$cli->setLog($log)->run($cmd);
				$msg = '修改成功。';
			} catch (Exception $e) {
				$msg = DEBUG ? '修改失败。'.$e->getMessage() : '修改失败。';
			}
			$this->msg = $msg;
        }		
	}