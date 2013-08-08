<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';
	
//todo 不含变量的字符串用单引号
//todo 使用正确代码结构 
/*
if ($a === $b) {
    a;
} else {
    b;
}
*/
	class SNMPModel{

		public $msg = '';

		public function getInitPageData() {
			// init page data
			$db = new dbsqlite('configs', DB_PATH . '/configs.db');
			$initData['snmp'] = $db->query('SELECT * FROM snmp') //todo
						           ->getFirstData(PDO::FETCH_ASSOC);
			$initData['snmpv3'] = $db->query('SELECT * FROM snmpusm') //todo
						             ->getFirstData(PDO::FETCH_ASSOC);
		    $data = $db->query('SELECT hostname FROM hostname') //todo
						  ->getFirstData(PDO::FETCH_ASSOC);

			if (!empty($initData['snmp']['ip'])) {
				$initData['iplist'] = explode('|', $initData['snmp']['ip']);
			}
			$initData['hostname']   = $data['hostname'];
			$initData['snmpStatus'] = $this->snmpStatus();	
			return $initData;
		}
		
		
		//判断snmp进程是否存在
		protected function snmpStatus() {
			if(file_exists('/tmp/ifstartsnmp')){
				unlink('/tmp/ifstartsnmp'); // 考虑throw exception
			}
			system('ps |grep firewallsnmpd |grep -v grep > /tmp/ifstartsnmp');
            // 请使用lib下的库解决 todo
			if (filesize('/tmp/ifstartsnmp') > 0) {
				return 'on';
			} else {
				return 'off';
			}			
		}

		protected function startSnmp() {
            // 请使用lib下的库解决 todo
			system('/usr/local/ncm/firewallsnmpd >/dev/null 2>/dev/null');
		}
		
		protected function stopSnmp() {
            // 请使用lib下的库解决 todo
			system('killall firewallsnmpd >/dev/null 2>/dev/null');		
		}
		
		public function setSnmp(){
			// modify		
			$cmdUnsetStr = 'snmp unset';
			$cmdstr      = 'snmp set';
				
			// snmpip
			if (!empty($_POST['iplist'])) {
				$iplist  = $_POST['iplist'];
				$ipstr   = join('|', $iplist);
				$cmdstr .= ' snmpip "' . $ipstr . '"';
			} else {
				$cmdUnsetStr .= ' snmpip';
			}
			// principal
			if (!empty($_POST['managerName'])) {
				$managerName = $_POST['managerName'];
				$cmdstr     .= " principal $managerName";
			} else {
				$cmdUnsetStr .= ' principal';
			}
			// telephone
			if (!empty($_POST['managerTel'])) {
				$managerTel = $_POST['managerTel'];
				$cmdstr    .= " telephone $managerTel";
			} else {
				$cmdUnsetStr .= ' telephone';
			}
			// cpu
			if (!empty($_POST['CPU'])) {
				$cpu = $_POST['CPU'];
				$cmdstr .= " cpu $cpu";
			} else {
				$cmdUnsetStr .= ' cpu';
			}
			// mem
			if(!empty($_POST['memory']))
			{
				$mem = $_POST['memory'];
				$cmdstr .= " mem $mem";
			}
			else {
				$cmdUnsetStr .= " mem";
			}
			// fs
			if(!empty($_POST['disk']))
			{
				$disk = $_POST['disk'];
				$cmdstr .= " fs $disk";
			}
			else {
				$cmdUnsetStr .= " fs";
			}
			// comment
			if(!empty($_POST['hostComment']))
			{
				$Comment = $_POST['hostComment'];
				$cmdstr .= " comment $Comment";
			}
			else {
				$cmdUnsetStr .= " comment";
			}
			//trapc
			if(!empty($_POST['trapStr']))
			{
				
				$trapc = $_POST['trapStr'];
				$cmdstr .= " trapc $trapc";
			}
			else {
				$cmdUnsetStr .= " trapc";
			}
			// snmpv1 & v2
			if(isset($_POST['snmpChk']) && $_POST['snmpChk'] === 'on')
			{
				if(!empty($_POST['readOnly']))
				{
					$rcomm = $_POST['readOnly'];
					$cmdstr .= " rcomm $rcomm";
				}
				else {
					$cmdUnsetStr .= " rcomm";
				}
				if(!empty($_POST['writeAndReady']))
				{
					$wcomm = $_POST['writeAndReady'];
					$cmdstr .= " wcomm $wcomm";
				}
				else {
					$cmdUnsetStr .= " wcomm";
				}
				$cmdstr .= " comm2sec on";
			}
			else {
				$cmdstr .= " comm2sec off";
			}

			// snmp v3
			if(isset($_POST['snmpv3Chk']) && $_POST['snmpv3Chk']==='on')
			{
				$v3Username = $_POST['v3Usrname'];
				$secSelect = $_POST['secSelect'];
				$authProtoNum = $_POST['authProto'];
				if($authProtoNum === '0') {
					$authProto = "MD5";
				else {
					$authProto = "SHA";
				$authPhrase = $_POST['authPhrase'];
				$privProtoNum = $_POST['privProto'];
				if($privProtoNum === '0')
					$privProto = "DES";
				else 
					$privProto = "AES";
				$privPhrase = $_POST['privPhrase'];
				$cmdv3Str = "snmpusm set user $v3Username level $secSelect authproto $authProto authpass \"$authPhrase\" privproto $privProto privpass \"$privPhrase\" active on ";
			}
			else {
				$cmdv3Str = "snmpusm set active off";
			}
			
			
			$cli = new cli();
			//要先停止服务再设置，设置完成后再启动服务
			if($this->snmpstatus()=='on') {		
				$this->stopSnmp();		//停止服务
				/*
				if($this->snmpStatus()=='on'){ //如果停止失败
					return $this->msg = 'snmp服务停止失败。';
				}
				*/
			}
			//运行设置命令
			if($cmdUnsetStr !== "snmp unset") {
				$cli->run($cmdUnsetStr);
			}  
			$cli->run($cmdstr);
			$cli->run($cmdv3Str);
			
			//	根据“启用集中管理”选框是否选中决定是否开启snmp服务
			if(isset($_POST['snmpStatus']) && $_POST['snmpStatus']=='on'){
				$this->startSnmp();
				if($this->snmpStatus()!='on'){
					return $this->msg = 'snmp服务启动失败。';
				} else {
					return $this->msg = '修改成功。';
				}
			} else {
				return $this->msg = '修改成功。';
			}

		}
	
	
	}
