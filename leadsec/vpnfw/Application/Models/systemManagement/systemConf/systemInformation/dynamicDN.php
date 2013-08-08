<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';
	
	class DynamicDNModel {
		public $msg = '';
		
		public function getInitPageData() {
			$initData = array();
			$db        = new dbsqlite('ddns_info', DB_PATH . '/configs.db');
			$initData = $db->query('SELECT * FROM ddns_info')
                        //todo只查找需要的列
						   ->getFirstData(PDO::FETCH_ASSOC);
						 
			return $initData;
		}
		
		public function setDdnsUser() {
			$cmd = "ddns set username {$_POST['account']} " .
                "password {$_POST['passwd']} confirm {$_POST['passwd_again']}";
			$cli = new cli();
			$log = "系统管理》系统设置》系统信息》动态域名 设置用户信息。";
            //todo
			list($status, $result) = $cli->setLog($log)->exec($cmd);
			if ($status === 0) {
				$db  = new dbsqlite('ddns_info',DB_PATH . '/configs.db');
				$res = $db->exec('DELETE FROM ddns_info');
				$sql = 'INSERT INTO ddns_info (username,password) VALUES (?,?)';
				$params = array($_POST['account'],$_POST['passwd']);
				if ($db->exec($sql,$params) > 0) {
					$this->msg = "修改成功。";//todo
				} else {
					$this->msg = "设置失败。";//todo
				}
			} else {
				$this->msg = "修改失败。"; //todo
			}
			return $this->msg;
		}
	}
?>
