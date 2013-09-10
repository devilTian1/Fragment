<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';
    require_once WEB_PATH . '/Application/Models/developTools/data.php';
    require_once WEB_PATH . '/Application/Models/developTools/vpnfwRes.php';

    class PhysicalModel {
        
        private $db; 
        private $workmodeArr;
        private $propertyArr;
        private $ipaddrArr;
        private $selectSts;
        private $whereSts;
        public $indata;
        public $msg;
        public $comment;
        public $antiARP;
        public $ipConflict;
        public $tableHtml;
        public $advSearchTpl;
        public $tableTpl;
        public $speedBuf;
        
        public function __construct() {
            $this->db = new dbsqlite('interface', DB_PATH . '/configs.db');
            $this->selectSts = array('external_name', 'ip', 'mask',  'workmode',
                                    'ipaddr_type', 'qos_enable', 'enable', 'ha_enable');
            $this->fromSts = array('interface');
            $this->whereSts  =
            array(array('colName' => 'external_name',    'wFilterOp' => '%M%'),
                      array('colName' => 'ip',      'wFilterOp' => '%M%'),
                      array('colName' => 'mask',    'wFilterOp' => '%M%'),
                      array('colName' => 'workmode',    'wFilterOp' => 'F'),
                      array('colName' => 'device_type',    'wFilterOp' => 'F'),
                      array('colName' => 'valid',    'wFilterOp' => 'F'),
                      array('colName' => 'type',    'wFilterOp' => '!F')
                      );

            $this->advSearchTpl = 
                'systemManagement/networkConf/interfaceConf/physical_advSearch.tpl';
            $this->tableTpl = 
               'systemManagement/networkConf/interfaceConf/physicalTable.tpl';
            $this->workmodeArr = array('',   '路由模式',
                             '透明模式', '冗余模式');
            $this->propertyArr = array('关闭',  '开启');
            $this->ipaddrArr = array('', '静态指定',
                           '无效',   'DHCP获取');
        }
        
        private function getDataCount() {
            $sql = 'SELECT * FROM interface WHERE device_type =1 and valid =1 and type!=1';
            $data = $this->db->getInstance('interface')->query($sql)
                ->getCount();
        }

        private function getOrderDataCount() {
            require_once WEB_PATH .
                '/Application/Models/developTools/assembleSql.php';
            $assembleSqlObj = new AssembleSql($this->selectSts, $this->fromSts,
                $this->whereSts);
            //'device_type =1 and valid =1 and type!=1';
            $sql = $assembleSqlObj->getNoLimitSql();
            $data = $this->db->getInstance('interface')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            return $data['count'];
        }
        
        private function getEnableRdDevNameByBindName($name) {
            $sql  = 'SELECT external_name, interface_list FROM interface ' .
                'WHERE interface_list != ""';
            $data = $this->db->getInstance('interface')->query($sql)
                ->getAllData(PDO::FETCH_ASSOC);
            foreach ($data as $v) {
                $interfaceList = explode(',', $v['interface_list']);
                if (false !== array_search($name, $interfaceList)) {
                    return $v['external_name'];
                }
            }
            return false;
        }
        
        private function getEnableAliasDevNamesByPhyName($name) {
            $sql  = 'SELECT external_name FROM interface ' .
                "WHERE phy_device='$name' AND enable=1";
            $data = $this->db->getInstance('interface')->query($sql)
                ->getAllData(PDO::FETCH_ASSOC);
            if (count($data) === 0) {
                return false;
            } else {
                $result = array();
                foreach ($data as $v) {
                    $result[] = $v['external_name'];
                }
                return $result;
            }
        }
        
        private function getDevComment($name) {
            $this->db->setInstance('phy_comment', DB_PATH . '/configs.db');
            $sql =
                "SELECT comment FROM phy_comment WHERE external_name='$name'";
            $result = $this->db->getInstance('phy_comment')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            $this->comment = $result['comment'];
        }
        
        private function getDevAntiARP($name) {
            $this->db->setInstance('anti_arp_table',
                DB_PATH . '/anti_attack.db');
            $sql    = "SELECT action FROM anti_arp_table WHERE dev='$name' ";
            $result = $this->db->getInstance('anti_arp_table')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            $this->antiARP = $result['action'];
        }
        
        private function getDevIpconflict($name) {
            $this->db->setInstance('anti_ipconflict_table',
                DB_PATH . '/anti_attack.db');
            $sql = 'SELECT action FROM anti_ipconflict_table ' . 
                "WHERE dev='$name'";
            $result = $this->db->getInstance('anti_ipconflict_table')
                ->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $this->ipConflict = $result['action'];
        }       
        
        private function getSetPhysicalDevCmd() {
            $if      = $_POST['external_name'];
            $comment = $_POST['remark_name'];
            $mtu     = $_POST['mtu'];
            $ipType  = '';
            $vlanStr = '';
            require_once WEB_PATH .
            '/Application/Models/developTools/netmask.php';
            if ($_POST['devIpv4Netmask'] >= 1 && $_POST['devIpv4Netmask'] <= 32) {
                $mask = Ipv4Netmask::convertLenToDot($_POST['devIpv4Netmask']);
            } else {
                $mask = $_POST['devIpv4Netmask'];
            }
            $enable             = Data::filterSwitch($_POST['enable']);
            $chkDomain          = Data::filterSwitch($_POST['chkDynDomain']);
            $ipmac_check        = Data::filterSwitch($_POST['ipmac_check']);
            $ipmac_check_policy =
                Data::filterSwitch($_POST['ipmac_check_policy']);
            $antispoof          = Data::filterSwitch($_POST['antispoof']);
            $qos_enable         =
                Data::filterSwitch($_POST['chkBandwidthManage']);            
            $dhcp               = Data::filterSwitch($_POST['chkOpenDHCP']);
            $admin              = Data::filterSwitch($_POST['admin']);
            $ping               = Data::filterSwitch($_POST['ping']);
            $traceroute         = Data::filterSwitch($_POST['traceroute']);
            $workmode           = Data::filterIsSet($_POST['workmode'],
                array($_POST['workmode'], '1'));

            $macCli   = Data::filterIsEmpty($_POST['mac_address'],
                array(' mac none ', " mac {$_POST['mac_address']} "));
            $linkmode = Data::filterMultiStat($_POST['linkmode'],
                array('0' => 'auto', '1' => 'full', 'else' => 'half'));
            $speed    = Data::filterMultiStat($linkmode,
                array('auto' => '', 'else' => ' speed ' . $_POST['speed']));

            $workStr = "mtu $mtu workmode " . Data::filterMultiStat($workmode,
                array('1' => 'route', '2'    => 'rd', '3' => 'trunk',
                      '0' => 'trans', 'else' => ''));
            if ($workmode === '1' && $_POST['ipaddr_type'] === '1') {
                $ipv4     = $_POST['devIpv4'];
                $ipv4Mask = Data::filterIsEmpty($mask, array('', $mask));
                $ipType   = ' ipaddr_type static';
                $ipType  .= Data::filterIsEmpty($mask,
                    array('', " ip $ipv4 netmask $ipv4Mask"));
            } else if ($workmode === '1' && $_POST['ipaddr_type'] === '3') {
                $ipType = ' ipaddr_type dhcp';
            }
            
            if ($chkDomain === 'on') {
                $dns = ' dns_enable on domain_name ' . $_POST['DynDomain'];
            } else {
                $dns = ' dns_enable off domain_name' .
                    Data::filterIsEmpty($_POST['DynDomain'],
                    array('none', $_POST['DynDomain']));
            }
            $qosStr = "qos_enable $qos_enable " .
                Data::filterMultiStat($qos_enable,
                array('on' => 'qos_device_bw '.$_POST['BandwidthValue'], 'else' => ''));

            if ($dhcp === 'on' && !empty($_POST['DHCPAddr'])) {
                $dhcpServer = $_POST['DHCPAddr'];
            } else {
                $dhcpServer = 'none';
            }
                        
            if ($workmode === '3') {
                $vlanRangeValid = Data::filterSwitch($_POST['checkBindRange']);
                $vlanIdValid    = Data::filterSwitch($_POST['checkVlanId']);
                if($vlanRangeValid === 'on' &&
                    !empty($_POST['vlan_bindrange'])) {
                    $vlanStr = 'bind_vlanrange ' . $_POST['vlan_bindrange'];
                } else {
                    $vlanStr = 'bind_vlanrange none';
                }
                if ($vlanIdValid === 'on' && !empty($_POST['vlan_id'])) {
                    $vlanStr .= ' native_vlanid ' . $_POST['vlan_id'];
                } else {
                    $vlanStr .= ' native_vlanid none';
                }
            }
            $result = "interface set phy if $if comment $comment active " .
                "$enable{$macCli}linkmode $linkmode{$speed} " .
                "$workStr{$ipType} ipmac_check $ipmac_check " .
                "ipmac_check_policy $ipmac_check_policy antispoof $antispoof " .
                "$qosStr dhcp_relay $dhcp dhcpserver $dhcpServer" .
                " admin $admin ping $ping traceroute $traceroute $vlanStr";
            return $result;
        }
        
        private function getSetArpCmd() {
            $ifname  = $_POST['external_name'];
            $antiArp = Data::filterSwitch($_POST['chkAntiARPAttack']);
            $result = "anti_config -t arp -i $ifname";            
            if (isset($_POST['devIpv4'])) {
                require_once WEB_PATH .
                '/Application/Models/developTools/netmask.php';
                if ($_POST['devIpv4Netmask'] >= 1 && $_POST['devIpv4Netmask'] <= 32) {
                    $mask = Ipv4Netmask::convertLenToDot($_POST['devIpv4Netmask']);
                } else {
                    $mask = $_POST['devIpv4Netmask'];
                }
                $result .= " -s {$_POST['devIpv4']} -m {$mask}";
            }
            if ($antiArp === 'on') {
                $result .= ' -j on';
            } else {
                $result .= ' -j off';
            }
            return $result;
        }
        
        private function getSetIpconflictCmd() {
            $ifname = $_POST['external_name'];
            $antiIpconflict = Data::filterSwitch($_POST['chkIPConflict']);
            $result = "anti_config -t ipconflict -i $ifname";
            if (isset($_POST['devIpv4'])) {
                require_once WEB_PATH .
                '/Application/Models/developTools/netmask.php';
                if ($_POST['devIpv4Netmask'] >= 1 && $_POST['devIpv4Netmask'] <= 32) {
                    $mask = Ipv4Netmask::convertLenToDot($_POST['devIpv4Netmask']);
                } else {
                    $mask = $_POST['devIpv4Netmask'];
                }
                $result .= " -s {$_POST['devIpv4']} -m {$mask}";
            }
            if ($antiIpconflict === 'on') {
                $result .= ' -j on';
            } else {
                $result .= ' -j off';
            }
            return $result;
        }                   
        
        private function getPhysicalList() {
            require_once WEB_PATH .
                '/Application/Models/developTools/assembleSql.php';
            //'device_type =1 and valid =1 and type!=1';
             $assembleSqlObj = new AssembleSql($this->selectSts, $this->fromSts,
                $this->whereSts);
            $sql = $assembleSqlObj->getSimpleQuerySql();
            $data = $this->db->getInstance('interface')->query($sql)
                ->getAllData(PDO::FETCH_ASSOC);
            $haIsUsed = vpnfwRes::getInstance()->isHaIfEnabled();
            foreach ($data as $key => $v) {
        		if ($v['ha_enable'] == '1'  && $haIsUsed) {
        			$data[$key]['ip'] = '';
        			$data[$key]['mask'] = '';
        			$data[$key]['ipaddr_type'] = 0;
        			$data[$key]['workmode'] = 0;
        			$data[$key]['ha_enable'] = '';
        			$data[$key]['enable'] = 'HA使用';
        		}
        	}
            return $data;
        }
        
        private function checkPhysicalEditValid() {
            require_once WEB_PATH .
                '/Application/Models/developTools/netmask.php';
            $name     = $_POST['external_name'];
            $workmode = Data::filterIsSet($_POST['workmode'],
                array($_POST['workmode'], '1'));
            $whereinfo = "WHERE vmif='$name'";
            $checkArray = array(array('database'=>'configs',
                    'table'=>'vminterface','whereinfo'=>$whereinfo));
            $res = vpnfwRes::getInstance()->checkObjectIsUsed($checkArray);
            if ($res === 1) {
                $this->msg = "接口{$name}已被虚拟网关使用，请先删除" . 
                        "虚拟网关中此接口，再修改接口的IP地址或工作模式。";
                return 'false';
            }
            $whereinfo = "WHERE localport='$name'";
            $checkArray = array(array('database'=>'configs',
                'table'=>'ids','whereinfo'=>$whereinfo));
            $res = vpnfwRes::getInstance()->checkObjectIsUsed($checkArray);
            if ($res === 1) {
                $this->msg = "接口{$name}已被ISM联动使用，请先删除" . 
                        "ISM联动中此接口，再修改接口的IP地址或工作模式。";
                return 'false';
            }
            if ($_POST['ipaddr_type'] === '1') {
                // 当地址类型为静态地址时
                $sql = "SELECT * FROM mrg_node_info WHERE ifname_ext='$name'";
                $db = new dbsqlite('mrg_node_info', DB_PATH . '/multiroute.db');                   
                $reCnt = $db->query($sql)->getCount();
                if ($reCnt>0) {
                    $ip = $_POST['devIpv4'];
                    if ($_POST['devIpv4Netmask'] >= 1 && $_POST['devIpv4Netmask'] <= 32) {
                        $mask = Ipv4Netmask::convertLenToDot($_POST['devIpv4Netmask']);
                    } else {
                        $mask = $_POST['devIpv4Netmask'];
                    }
                    $result = $db->query($sql)
                            ->getFirstData(PDO::FETCH_ASSOC);
                    $chkRes = Ipv4Netmask::isIpTheSameNet($ip, $result['ip'], $mask);           
                    if ($workmode=== '1' || !$chkRes) {                
                        $this->msg = "接口{$name}已被默认路由引用，请先删除" . 
                                "引用此接口的默认路由，再修改接口的IP地址或工作模式。";
                        return 'false';
                    }
                }
            }
            if ($workmode !==  '1') {
            // 当工作模式不是路由模式
                $whereinfo = "WHERE localdev='$name'";
                $checkArray = array(array('database'=>'vpn',
                        'table'=>'gre','whereinfo'=>$whereinfo));
                $res = vpnfwRes::getInstance()->checkObjectIsUsed($checkArray);
                if ($res === 1) {
                    $this->msg = "名称{$name}已被GRE隧道使用，不能够修改其工作模式。";
                    return 'false';
                }
                $whereinfo = "WHERE interface='$name'";
                $checkArray = array(array('database'=>'configs',
                        'table'=>'route_list','whereinfo'=>$whereinfo));
                $res = vpnfwRes::getInstance()->checkObjectIsUsed($checkArray);
                if ($res === 1) {
                    $this->msg = "接口{$name}已被静态路由使用，请先删除" . 
                                "静态路由，再修改接口的IP地址或工作模式。";
                    return 'false';
                }
            } else if ($_POST['ipaddr_type'] === '1') {
            // 当工作模式是路由模式，且地址类型为静态
                $whereinfo = "WHERE interface='$name'";
                $checkArray = array(array('database'=>'configs',
                        'table'=>'route_list','whereinfo'=>$whereinfo));
                $res = vpnfwRes::getInstance()->checkObjectIsUsed($checkArray);
                if ($res === 1) {
                    $whereinfo = "WHERE external_name='$name' and ip='{$_POST['devIpv4']}'";
                    $checkArray = array(array('database'=>'configs',
                            'table'=>'interface','whereinfo'=>$whereinfo));
                    $res = vpnfwRes::getInstance()->checkObjectIsUsed($checkArray);
                    if ($res === 0) {
                        $this->msg = "接口{$name}已被静态路由使用，请先删除" . 
                                "静态路由，再修改接口的IP地址或工作模式。";
                        return 'false';
                    }
                }
            }
            return 'true';
        }
        
        public function getTableData() {
            require_once WEB_PATH .
                '/Application/Models/developTools/table.php';            
            $data = array(
                'tpl'  => $this->tableTpl,
                'data' => array('list' => $this->getPhysicalList(),
                            'propertyArr'=>$this->propertyArr,
                            'ipaddrArr'=>$this->ipaddrArr,
                            'workmodeArr'=>$this->workmodeArr)
            );
            $t = new Table($data);
            $this->tableHtml = $t->getTableHtml();
        }
        
        public function getInitPageData() {
            $result = $this->getDataCount();
            $pageCount = ceil($result/10);
            return array('dataCount' => $result, 'pageCount' => $pageCount);
        }
        
        public function setPhysicalDevActive() {
            $name   = $_POST['switch_name'];
            $action = $_POST['action'];
            $cli = new cli();
            if ($action === 'disable') {
                $cmd = "interface set phy if $name active off";
                $cli->setLog("关闭物理名称为{$name}的设备")->run($cmd);
                $this->msg = "[$name]已关闭.";
            } else if ($action === 'enable') {
                $cmd = "interface set phy if $name active on";
                $cli->setLog("启动物理名称为{$name}的设备")->run($cmd);
                $this->msg = "[$name]已启动.";
            }
       }
       
       public function getSpecPhysicalData() {
            $external_name  = $_POST['name'];
            $sql = 'SELECT * FROM interface WHERE device_type = 1 AND ' .
                "external_name = '$external_name'";
            $result = $this->db->getInstance('interface')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            $result['vpn'] = vpnfwRes::getInstance()->isRestartVPN($external_name);
            $this->indata = $result ;
            $this->getDevComment($external_name);
            $this->getDevAntiARP($external_name);
            $this->getDevIpconflict($external_name);
            $res = vpnfwRes::getInstance()->getAutoSpeedByCli($external_name);
            if ($res['cardType'] === '10000M' || $res['cardType'] === '1000M') {
                $mtuRange = '(68-9216)';
            } else if ($res['cardType'] === '100M' || $res['cardType'] === '10M') {
                $mtuRange = '(60-1500)';
            } else {
                $mtuRange = '';
            }
            if ($res['cardType'] === '100M') {
                $speedOption = array(10, 100);
            } else if ($res['cardType'] === '1000M') {
                $speedOption = array(10, 100, 1000);
            } else {
                $speedOption = array(10, 100, 1000, 10000);
            }
            $this->speedBuf = array('mtuRange'=>$mtuRange, 
                          'linkSpeedOption'=>$speedOption);
        }
        
        public function setSpecifiedPhysicalDev() {
            $cli      = new cli();
            $name     = $_POST['external_name'];
            $workmode = Data::filterIsSet($_POST['workmode'],
                array($_POST['workmode'], '1'));
            $res = $this->checkPhysicalEditValid();
            if ($res === 'false') {
                return;
            }
            $cmd    = $this->getSetPhysicalDevCmd();
            $cmdArp = $this->getSetArpCmd();
            $cmdIp  = $this->getSetIpconflictCmd();
            list($status,$lines) = $cli->setLog("修改物理设备{$name}")
                            ->execCmdGetStatus($cmd);
            if ($status === 1) {
                $this->msg = '若更改链路模式或链路速度，请关闭带宽管理功能。';
                return;
            }
            if (!empty($cmdArp)) {
                $cli->setLog("物理设备{$name}")->run($cmdArp);
            }
            if (!empty($cmdIp)) {
                $cli->setLog("修改物理设备{$name}")->run($cmdIp);
            }
            $this->msg ="修改成功。";            
         }
         
        public function setBatchStopCmd() {
            $cli = new cli();
            $array = $_GET['batchKey'];
            if(count($array) === 0) {
                $this->msg = '没有选择任何物理设备。';
                return;
            }
            foreach($array as $key => $name) {
                if ($key !== 'all') {                
                    $cmd = "interface set phy if $name active off";
                    $cli->setLog("停止物理设备[{$name}]")->run($cmd);
                } else {
                    unset($array['all']);
                }
            }
            $this->msg = '物理设备[' . join(',', $array) . ']已停止。';
        }
        
        public function freshTableAndPagination() {
            require_once WEB_PATH .
                '/Application/Models/developTools/tableAndPager.php';
            $data = array(
                'url'       => 'index.php?R=systemManagement/networkConf/interfaceConf/physical/' .
                               'freshTableAndPagination',
                'tableTpl'  => $this->tableTpl,
                'tableData' => array('list' => $this->getPhysicalList(),
                            'propertyArr'=>$this->propertyArr,
                            'ipaddrArr'=>$this->ipaddrArr,
                            'workmodeArr'=>$this->workmodeArr),
                'dataCount' => $this->getOrderDataCount()
            );
            $tp = new tableAndPager($data);
            list($this->tableHtml, $this->pagerHtml) = $tp->getResult();
        }
        
        public function getBandWidth() {       
            echo json_encode(vpnfwRes::getInstance()->getBandWidth());
        }
    }       
?>
