<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/cli.php';

    class PhysicalModel {
        
        private $db; 
        public $indata;
        public $msg;
        public $comment;
        public $antiARP;
        public $ipConflict;
        
        public function __construct() {
            $this->db = new dbsqlite('interface', DB_PATH . '/configs.db');
        }     

        private function getDataCount() {
            $sql = 'SELECT external_name FROM interface ' .
                    'WHERE device_type =1 and valid =1 and type!=1';
            return
                $this->db->getInstance('interface')->query($sql)->getCount();
        }
        
        private function getEnableRdDevNameByBindName($name) {
            $sql      = 'SELECT external_name, interface_list FROM interface ' .
                'WHERE interface_list != ""';
            $data    = $this->db->getInstance('interface')->query($sql)
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
            $result = array();
            $sql      = 'SELECT external_name FROM interface ' .
                "WHERE phy_device='$name' AND enable=1";
            $data   = $this->db->getInstance('interface')->query($sql)
                ->getAllData(PDO::FETCH_ASSOC);
            if (count($data) === 0) {
                return false;
            } else {
                foreach ($data as $v) {
                    $result[] = $v['external_name'];
                }
                return $result;
            }
        }
        
        private function getDevComment($name) {
            $db = new dbsqlite('phy_comment', DB_PATH . '/configs.db');
            $sql    = "SELECT comment FROM phy_comment " . 
                "WHERE external_name='$name'";
            $result = $db->getInstance('phy_comment')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            $this -> comment = $result['comment'];
        }
        
        private function getDevAntiARP($name) {
            $db = new dbsqlite('anti_arp_table', DB_PATH . '/anti_attack.db');
            $sql    = "SELECT action FROM anti_arp_table WHERE dev='$name' ";
            $result = $db->getInstance('anti_arp_table')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            $this -> antiARP = $result['action'];
        }
        
        private function getDevIpconflict($name) {
            $db = new dbsqlite('anti_ipconflict_table', DB_PATH . '/anti_attack.db');
            $sql    = "SELECT action FROM anti_ipconflict_table " . 
                "WHERE dev='$name' ";
            $result = $db->getInstance('anti_ipconflict_table')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            $this -> ipConflict = $result['action'];
        }
        
        private function getSetPhysicalDevCmd() {
            $if               = $_POST['external_name'];
            $comment = $_POST['remark_name'];
            $mtu          = $_POST['mtu'];
            $ipType     = '';
            $vlanStr    = '';
            $enable     = 
                ( isset($_POST['enable']) && ($_POST['enable'] === 'on') ) ? 'on' : 'off';
            $chkDomain = ( isset($_POST['chkDynDomain']) 
                && ($_POST['chkDynDomain'] === 'on') ) ? 'on' : 'off';
            $ipmac_check             = ( isset($_POST['ipmac_check']) && 
                ($_POST['ipmac_check'] === 'on')) ? 'on' : 'off';
            $ipmac_check_policy = ( isset($_POST['ipmac_check_policy']) && 
                ($_POST['ipmac_check_policy'] === 'on') ) ? 'on' : 'off';
            $antispoof                   = (isset($_POST['antispoof']) && 
                ($_POST['antispoof'] === 'on')) ? 'on' : 'off';
            $qos_enable                = (isset($_POST['chkBandwidthManage']) &&
                ($_POST['chkBandwidthManage'] === 'on')) ? 'on' : 'off';
            $dhcp                           = (isset($_POST['chkOpenDHCP']) && 
                ($_POST['chkOpenDHCP'] === 'on')) ? 'on' : 'off';
            $admin                         = (isset($_POST['admin']) && 
                ($_POST['admin'] === 'on')) ? 'on' : 'off';
            $ping                            =  (isset($_POST['ping']) &&
                 ($_POST['ping'] === 'on')) ? 'on' : 'off';
            $traceroute                  = (isset($_POST['traceroute']) && 
                ($_POST['traceroute'] === 'on')) ? 'on' : 'off';
            $workmode = isset($_POST['workmode']) ? $_POST['workmode']:'1';
            if (empty($_POST['mac_address'])) {
                $macCli  = ' mac none ';
            } else {
                $macCli  = " mac {$_POST['mac_address']} ";
            }
            if ($_POST['linkmode'] === '0') {
                $linkmode = 'auto';
            } else if ($_POST['linkmode'] === '1') {
                $linkmode = 'full';
            } else { //2
                $linkmode = 'half';
            }
	   if ($linkmode !=='auto') {
                $speed = ' speed ' . $_POST['speed'];
	   } else {
	       $speed = '';
	   }
            if ($workmode === '1') {
                $workStr = "mtu $mtu workmode route";
                if ($_POST['ipaddr_type'] === '1') {
                    $ipv4          = $_POST['devIpv4'];
                    $ipv4Mask = $_POST['devIpv4Netmask'];
                    $ipv4Mask = 
                        !empty($ipv4Mask) ? convertToIpv4Mask($ipv4Mask) : '';
                    $ipType      = ' ipaddr_type static';
                    if (!empty($ipv4)) {
                        $ipType .= " ip $ipv4 netmask $ipv4Mask";
                    }
                } else if ($_POST['ipaddr_type'] === '3') {
                    $ipType      = ' ipaddr_type dhcp';
                }
            } else if ($workmode === '2') {
                $workStr = "mtu $mtu workmode rd";
            } else if ($workmode === '3') { 
                $workStr = "mtu $mtu workmode trunk";
            } else if ($workmode === '0') { //0
                $workStr = "mtu $mtu workmode trans";
            } else {
            }   
            
            if($chkDomain === 'on') {
                $dns = ' dns_enable on domain_name ' . $_POST['DynDomain'];                
            } else {
                $dns = ' dns_enable off';
                if(empty($_POST['DynDomain'])) {
                    $dns .= ' domain_name none';
                } else {
                    $dns .= ' domain_name ' . $_POST['DynDomain'];
                }
            }
            
            if ($qos_enable === 'on') {
                $qosStr = "qos_enable $qos_enable qos_device_bw "
                     . $_POST['BandwidthValue'];
            } else {
                $qosStr = "qos_enable $qos_enable";
            }

            if($dhcp === 'on' && !empty($_POST['DHCPAddr'])) {
                $dhcpServer = $_POST['DHCPAddr'];
            } else {
                $dhcpServer = 'none';
            }
                        
            if($workmode === '3') {
                $vlanRangeValid = (isset($_POST['checkBindRange']) && 
                    ($_POST['checkBindRange'] === 'on')) ? 'on' : 'off';
                $vlanIdValid         = (isset($_POST['checkVlanId']) && 
                    ($_POST['checkVlanId'] === 'on')) ? 'on' : 'off';
                if($vlanRangeValid==='on' && !empty($_POST['vlan_bindrange'])) {
                    $vlanStr = 'bind_vlanrange ' . $_POST['vlan_bindrange'];
                } else {
                    $vlanStr = 'bind_vlanrange none';
                }
                if($vlanIdValid==='on' && !empty($_POST['vlan_id'])) {
                    $vlanStr .= ' native_vlanid ' . $_POST['vlan_id'];
                } else {
                    $vlanStr .= ' native_vlanid none';
                }
            }
            $result = "interface set phy if $if comment $comment active " .
                "$enable{$macCli}linkmode $linkmode{$speed} $workStr{$ipType} " .
                "ipmac_check $ipmac_check ipmac_check_policy $ipmac_check_policy ".
                "antispoof $antispoof $qosStr dhcp_relay $dhcp dhcpserver $dhcpServer".
                " admin $admin ping $ping traceroute $traceroute $vlanStr";
            return $result;
        }
        
        private function getSetArpCmd() {
            if (!isset($_POST['chkAntiARPAttack'])) {
                return '';
            }
            $ifname = $_POST['external_name'];
            $antiArp = 
                ($_POST['chkAntiARPAttack'] === 'on') ? 'on' : 'off';
            $result = "anti_config -t arp -i $ifname";
            if (isset($_POST['devIpv4'])) {
                $result .= " -s {$_POST['devIpv4']} -m {$_POST['devIpv4Netmask']}";
            }
            if ($antiArp === 'on') {
                $result .= ' -j on';
            } else {
                $result .= ' -j off';
            }
            return $result;
        }
        
        private function getSetIpconflictCmd() {
            if (!isset($_POST['chkIPConflict'])) {
                return '';
            }
            $ifname = $_POST['external_name'];
            $antiIpconflict = 
                ($_POST['chkIPConflict'] === 'on') ? 'on' : 'off';
            $result = "anti_config -t ipconflict -i $ifname";
            if (isset($_POST['devIpv4'])) {
                $result .= " -s {$_POST['devIpv4']} -m {$_POST['devIpv4Netmask']}";
            }
            if ($antiIpconflict === 'on') {
                $result .= ' -j on';
            } else {
                $result .= ' -j off';
            }
            return $result;
        }
        
        public function getTableData() {
            $sql = "SELECT * FROM interface " . 
                "WHERE device_type=1 AND valid=1 and type!=1";
            $data     = $this->db->getInstance('interface')
                                 ->query($sql)
                                 ->getAllData(PDO::FETCH_ASSOC);
            $this -> indata = $data ;
        }
        
        public function getInitPageData() {
            $result = $this->getDataCount();
            return $result;
        }
        
        public function setPhysicalDevActive() {
            $name  = $_POST['switch_name'];
            $action = $_POST['action'];
            $cli = new cli();
            if ($action === 'disable') {
                if ($rdName = $this->getEnableRdDevNameByBindName($name)) {
                    $msg = 
                        "请先关闭冗余设备[$rdName]后, 再关闭[$name]设备.";
                    $this -> msg = $msg ;
                    return false;
                }
                if ($nameArr = $this->getEnableAliasDevNamesByPhyName($name)) {
                    $msg = '请先将别名设备[' . join(', ', $nameArr) .
                        ']关闭后, 再关闭[' . $name . ']设备.';
                        $this -> msg = $msg ;
                    return false;
                }
                $cmd = "interface set phy if $name active off";
                $cli->setLog("关闭物理名称为{$name}的设备"  )   
                      ->run($cmd);
                $this -> msg = "[$name]已关闭." ;
            } else if ($action === 'enable') {
                $cmd = "interface set phy if $name active on";
                $cli->setLog("启动物理名称为{$name}的设备")   
                      ->run($cmd);
                $this -> msg = "[$name]已启动." ;
            }
        }
        
        public function getSpecPhysicalData() {
            $external_name  = $_POST['name'];            
            $sql = 'SELECT * FROM interface '.
                "WHERE device_type = 1 AND external_name = '$external_name'";
            $result = $this->db->getInstance('interface')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            $this -> indata = $result ;
            $this -> getDevComment($external_name);
            $this -> getDevAntiARP($external_name);
            $this -> getDevIpconflict($external_name);
        }
        
        public function setSpecifiedPhysicalDev() {
            $name = $_POST['external_name'];
            $enable = (isset($_POST['enable']) && 
                ($_POST['enable']==='on'))?'on':'off';
            $workmode = isset($_POST['workmode']) ? $_POST['workmode']:'1';
            if (('on' !== $enable || '3' !== $workmode) &&
                $rdName = $this->getEnableRdDevNameByBindName($name)) {
                if ('on' !== $enable) {
                    $this -> msg = 
                        "请先关闭冗余设备[$rdName]后, 再关闭[$name]设备.";
                }
                if ('3' !== $enable) {
                    $this -> msg = "此设备被冗余设备[$rdName]绑定.";
                }
            }
            if (('on' !== $enable || '3' === $workmode) &&
                $nameArr = $this->getEnableAliasDevNamesByPhyName($name)) {
                $this -> msg = '请先将别名设备[' . join(', ', $nameArr) .
                    ']关闭后, 再将[' . $name . ']设备设置成冗余设备.';
            }
            $cmd = $this->getSetPhysicalDevCmd();
            $cmdArp = $this->getSetArpCmd();
            $cmdIp = $this->getSetIpconflictCmd();
            $cli = new cli();
            $cli->setLog("修改物理设备{$name}")->run($cmd);
            if (! empty($cmdArp)) {
                $cli->setLog("物理设备{$name}")->run($cmdArp);
            }
            if (! empty($cmdIp)) {
                $cli->setLog("修改物理设备{$name}")->run($cmdIp);
            }
            $this -> msg = '修改成功。';
        }
        
        
    }
?>
