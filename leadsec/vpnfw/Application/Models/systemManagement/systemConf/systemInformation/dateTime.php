<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';

    class DateTimeModel {
		public $msg = null;
	
		public function getInitPageData() {
		
			$initData['timezoneList'] = array(
                'GMT+12 '=> '(GMT-12)埃尼威托克岛,夸贾林环',
                'GMT+11' => '(GMT-11)中途岛,萨摩亚群岛',
                'GMT+10' => '(GMT-10)夏威夷',
                'GMT+9'  => '(GMT-9)阿拉斯加',
                'GMT+8'  => '(GMT-8)太平洋时间(美国和加拿大),提华纳',
                'GMT+7'  => '(GMT-7)山区时间(美国和加拿大),亚利桑那',
                'GMT+6'  => '(GMT-6)中部时间(美国和加拿大),墨西哥城',
                'GMT+5'  => '(GMT-5)东部时间(美国和加拿大),波哥大,利马,基多',
                'GMT+4'  => '(GMT-4)大西洋时间(加拿大),加拉加斯,拉巴斯',
                'GMT+3'  => '(GMT-3)巴西利亚,布宜诺斯艾利斯,乔治敦,福克兰群岛',
                'GMT+2'  => '(GMT-2)中大西洋,阿森松群岛, 圣赫勒拿岛',
                'GMT+1'  => '(GMT-1)亚速群岛,佛得角群岛',
                'GMT-1'  => '(GMT+1)柏林,布鲁塞尔,哥本哈根,马德里,巴黎,罗马',
                'GMT-2'  => '(GMT+2)开罗,赫尔辛基,加里宁格勒,南非,华沙',
                'GMT-3'  => '(GMT+3)巴格达,利雅得,莫斯科,奈洛比',
                'GMT-4'  => '(GMT+4)阿布扎比,巴库,马斯喀特,特比利斯',
                'GMT-5'  => '(GMT+5)叶卡特琳堡,伊斯兰堡,卡拉奇,塔什干',
                'GMT-6'  => '(GMT+6)阿拉木图,科伦坡,达卡,新西伯利亚',
                'GMT-7'  => '(GMT+7)曼谷,河内,雅加达',
                'GMT-8'  => '(GMT+8)北京,香港,帕斯,新加坡,台北',
                'GMT-9'  => '(GMT+9)大阪,札幌,汉城,东京,雅库茨克',
                'GMT-10' => '(GMT+10)堪培拉,关岛,墨尔本,悉尼,海参崴',
                'GMT-11' => '(GMT+11)马加丹,新喀里多尼亚,所罗门群岛',
                'GMT-12' => '(GMT+12)奥克兰,惠灵顿,斐济,马绍尔群岛',
                'GMT+0'  =>
                    '(GMT+0)[格林尼治标准时间]都柏林,伦敦,里斯本,卡萨布兰卡'
            );
			$db   = new dbsqlite('configs', DB_PATH . '/configs.db');
			$sql  = 'SELECT zoneinfo from timezone;';
			$data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
			$initData['curTimezone'] = $data['zoneinfo'];
			
			$cli = new cli();
			$cmd = 'ntp show';
			$return = $cli->setGetResult(true)->run($cmd);
			
			if (false !== strpos($return[0], 'on')) {
				$initData['type'] = 'on';	
			} else {
				$initData['type'] = 'off';
			}
			
			$nipOrndn = trim(array_pop(explode('：',$return[1])));
			if (preg_match('/[a-zA-Z]/', $nipOrndn) > 0) {
				$initData['nip'] = '';
				$initData['ndn'] = $nipOrndn;				
			} else {
				$initData['nip'] = $nipOrndn;
				$initData['ndn'] = '';
			}
			$initData['interval']   = trim(array_pop(explode('：',$return[2])));
			$initData['serverTime'] = $this->getServerTime();			
			
			return $initData;
		}
		
		private function getServerTime() {
			$cli        = new cli();
			$returnTime = $cli->setGetResult(true)->run('clock show');
			$timeStrArr = explode(' ', $returnTime[0]);
			$serverTime = strtotime($timeStrArr[1] . ' ' . $timeStrArr[2]);
			return $serverTime;
		}		
		
		public function setServerTime() {
			// set server time to localtime
			$cli       = new cli();
			$localTime = $_POST['localTime'];
			$cmd       = "clock set $localTime";
			$msg_log   = '系统管理模块系统维护下的时间同步';
			$cli->setLog($msg_log)->run($cmd);
			$servertime = time();
			$this->msg  = '时间同步成功。';
		}
		
		public function setTimezone() {
			$cli      = new cli();
			$timezone = $_POST['timezone'];
			$cmd      = "timezone set {$timezone}";
			$msg_log  = '系统管理》系统配置》时间 设置时区'; 
			list($status, $lines) = $cli->setLog($msg_log)
                                        ->execCmdGetStatus($cmd);
			
			$db  = new dbsqlite('configs', DB_PATH . '/configs.db');
			$sql = "UPDATE timezone SET zoneinfo='{$timezone}';";	
			$res = $db->exec($sql);
			if ($status == 0 && $res >0) {
				$msg = '时区设置成功。'; 
			} else {
				$msg = '时区设置失败。'; 
			}
			$this->msg =
                array('msg' => $msg, 'timestamp' => $this->getServerTime());
		}		
		
		public function setNTPServer(){
			$cli = new cli();
			
			if (isset($_POST['switchNTP'])) {
				// sync ntp server
				$interval = $_POST['ntpSyncInterval'];
				if (isset($_POST['ip'])) {
					$cmd = "ntp set ip {$_POST['ip']} interval $interval";
				} elseif (isset($_POST['dn'])) {
					$cmd = "ntp set domain {$_POST['dn']} interval $interval";
				}
				
				$msg_log = '系统管理模块系统维护下的设置同步时钟服务器';
				$cli->run('ntp off');
				$cli->setLog($msg_log)->run($cmd);
				$cli->run('ntp on');
				$this->msg = '设置成功。';
			} else {
				// disable NTP server
				$msg_log = '系统管理模块系统维护下的同步时钟服务器取消';
				$cli->setLog($msg_log)->run('ntp off');
				$this->msg = '取消时间同步成功！';
			}
			
		}		
		
		public function syncTime() {
			// sync time immediately
			$cmd     = 'ntp sync';
			$msg_log = '系统管理模块系统维护下的同步时钟服务器';
			$cli     = new cli();
			list($status, $lines) =
                $cli->setLog($msg_log)->execCmdGetStatus($cmd);
			if ($status == 2) {
				$this->msg = '同步失败。';
			} else if ($status == 0) {
				$this->msg = '同步成功。';
			} else {
				$this->msg = join('<br/>', $lines);
			}
		}
	}
?>
