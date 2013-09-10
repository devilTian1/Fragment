<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';
	
	class SNMPModel{

		public $msg = '';

		public function getInitPageData() {
			// init page data
			$db 	 = new dbsqlite('configs', DB_PATH . '/configs.db');
			$snmpSql = 'SELECT comment,adminname,adminphone,cpu,mem,file,'.
							'trapcomm,rcomm,wcomm,comm2sec,ip FROM snmp';
			$initData['snmp'] = $db->query($snmpSql)
								   ->getFirstData(PDO::FETCH_ASSOC);
			$snmpv3Sql = 'SELECT username,seclevel,authphrase,privphrase,v3usm,'.
							'authproto,privproto FROM snmpusm';
			$initData['snmpv3'] = $db->query($snmpv3Sql)
									 ->getFirstData(PDO::FETCH_ASSOC);
		    $data = $db->query('SELECT hostname FROM hostname') 
						  ->getFirstData(PDO::FETCH_ASSOC);

			if (!empty($initData['snmp']['ip'])) {
				$initData['iplist'] = explode('|', $initData['snmp']['ip']);
			}
			$initData['hostname']   = $data['hostname'];
			$initData['snmpStatus'] = $this->snmpStatus();	
			return $initData;
		}
		
			
		/**
		 * 判断snmp进程是否存在
		 */
		protected function snmpStatus() {
			$cli = new cli();
			$cmd = 'ps -ef |grep firewallsnmpd';
			list($status,$lines) = $cli->setGetResult(true)->run($cmd);
			if (substr_count($status,'/usr/local/ncm/firewallsnmpd')>0) {
				return 'on';
			} else {
				return 'off';
			}
		}
		
		/**
		 * 启动snmp进程
		 */
		protected function startSnmp() {
           $cli = new cli();
		   $cmd = '/usr/local/ncm/firewallsnmpd';
		   $cli->run($cmd);
		}
		
		/**
		 * 停止snmp进程
		 */		
		protected function stopSnmp() {
           $cli = new cli();
		   $cmd = 'killall firewallsnmpd';
		   $cli->run($cmd);			
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
			if (!empty($_POST['memory'])) {
				$mem = $_POST['memory'];
				$cmdstr .= " mem $mem";
			} else {
				$cmdUnsetStr .= ' mem';
			}
			// fs
			if (!empty($_POST['disk'])) {
				$disk = $_POST['disk'];
				$cmdstr .= " fs $disk";
			} else {
				$cmdUnsetStr .= ' fs';
			}
			// comment
			if (!empty($_POST['hostComment'])) {
				$Comment = $_POST['hostComment'];
				$cmdstr .= " comment $Comment";
			} else {
				$cmdUnsetStr .= " comment";
			}
			//trapc
			if (!empty($_POST['trapStr'])) {
				
				$trapc = $_POST['trapStr'];
				$cmdstr .= " trapc $trapc";
			} else {
				$cmdUnsetStr .= ' trapc';
			}
			// snmpv1 & v2
			if (isset($_POST['snmpChk']) && $_POST['snmpChk'] === 'on') {
				if (!empty($_POST['readOnly'])) {
					$rcomm = $_POST['readOnly'];
					$cmdstr .= " rcomm $rcomm";
				} else {
					$cmdUnsetStr .= ' rcomm';
				}
				if (!empty($_POST['writeAndReady'])) {
					$wcomm = $_POST['writeAndReady'];
					$cmdstr .= " wcomm $wcomm";
				} else {
					$cmdUnsetStr .= ' wcomm';
				}
				$cmdstr .= ' comm2sec on';
			} else {
				$cmdstr .= ' comm2sec off';
			}

			// snmp v3
			if (isset($_POST['snmpv3Chk']) && $_POST['snmpv3Chk']==='on') {
				$v3Username = $_POST['v3Usrname'];
				$secSelect = $_POST['secSelect'];
				$authProtoNum = $_POST['authProto'];
				if ($authProtoNum === '0') {
					$authProto = 'MD5';
				} else {
					$authProto = 'SHA';
				}
				$authPhrase = $_POST['authPhrase'];
				$privProtoNum = $_POST['privProto'];
				if ($privProtoNum === '0') {
					$privProto = 'DES';
				} else {
					$privProto = 'AES';
				}
				$privPhrase = $_POST['privPhrase'];
				$cmdv3Str = "snmpusm set user $v3Username level $secSelect ".
							"authproto $authProto authpass \"$authPhrase\" ".
							"privproto $privProto privpass \"$privPhrase\" ".
							'active on ';
			} else {
				$cmdv3Str = "snmpusm set active off";
			}
			
			$cli = new cli();
			//要先停止服务再设置，设置完成后再启动服务
			if ($this->snmpstatus()=='on') {		
				$this->stopSnmp();		//停止服务
				
				if($this->snmpStatus()=='on'){ //如果停止失败
					$this->msg = 'snmp服务停止失败。';
				}
			}
			//运行设置命令
			if ($cmdUnsetStr !== 'snmp unset') {
				$cli->run($cmdUnsetStr);
			}  
			$cli->run($cmdstr);
			$cli->run($cmdv3Str);
			
			//	根据“启用集中管理”选框是否选中决定是否开启snmp服务
			if (isset($_POST['snmpStatus']) && $_POST['snmpStatus']=='on') {
				$this->startSnmp();
				if ($this->snmpStatus()!='on'){
					$this->msg = 'snmp服务启动失败。';
				} else {
					$this->msg = '修改成功。';
				}
			} else {
				$this->msg = '修改成功。';
			}

		}
	
	
	}
