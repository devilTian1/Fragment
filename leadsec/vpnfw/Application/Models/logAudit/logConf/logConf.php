<?php
    requireCache(WEB_PATH . '/Lib/driver/dbsqlite.php');

    class LogConfModel {
    	private $db;
        
        public function __construct() {
            $this->db  = new dbsqlite('configs', DB_PATH . '/configs.db');
        }
        
        public function getInitPageData() {
            $data     = $this->db->getInstance('configs')
                                 ->query('SELECT overwrite, stopwrite,sendemail FROM logset')
                                 ->getFirstData(PDO::FETCH_ASSOC);
            return $data;
        }

        public function setLogConf() {
        	requireCache(WEB_PATH . '/Lib/driver/cli.php');
            $cli     = new cli();
            $overstop  = $_POST['overstop'];			
            if (1 === $overstop) {
                $cmd = 'logset set overwrite on stopwrite off';
                $log = '将域名服务器IP置空';
            } elseif(0 === $overstop) {
                $cmd = "logset set overwrite off stopwrite on";
                $log = '设置域名服务器IP';
            }
            if(isset($_POST['sendemail'])){
            	if($this->ifSetEmail()){
            		$cmd.=" sendemail on";
            	}else{
            		echo json_encode(array('msg' => "请先设置通知邮箱"));
            		exit();
            	}
   
            }else{
            	$cmd.=" sendemail off";
            }
            $cli->setLog($log)->run($cmd);
        }
        //判断是否设置报警邮箱
        public function ifSetEmail(){
            $data     = $this->db->getInstance('configs')
                                 ->query('SELECT power FROM gwmail')
                                 ->getFirstData(PDO::FETCH_ASSOC);
           	if($data['power']==1){
           		return true;
           	}
            return false;
        }
    }
?>
