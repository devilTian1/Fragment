<?php
    requireCache(WEB_PATH . '/Lib/driver/dbsqlite.php');

    class BasicModel {

        private $db;
        private $selectSts;
        private $whereSts;
        private $tableTpl;

        public $msg;
        public $advSearchTpl;
        public $editTpl;
        public $tableHtml;
        public $pagerHtml;
        
        public $specBasicById;

        public function __construct() {
            $this->msg = '';
            $this->db  = new dbsqlite('rule', DB_PATH . '/rule.db');
            $this->selectSts = array('id', 'name','comment');
            $this->fromSts   = array('service|service');
            $this->whereSts  =
                array(array('colName' => 'id',    'wFilterOp' => '%M%'),
                      array('colName' => 'name',      'wFilterOp' => '%M%'),
                      array('colName' => 'comment', 'wFilterOp' => '%M%'));

            $this->tableTpl = 'firewall/service/basicTable.tpl';

            $this->advSearchTpl = 'firewall/service/basic_advSearch.tpl';
            $this->editTpl      = 'firewall/service/basic_edit.tpl';
        }

        private function getOrderDataCount() {
            requireModelDevClass('assembleSql');
            $assembleSqlObj = new AssembleSql($this->selectSts, $this->fromSts,
                $this->whereSts);
            $sql = $assembleSqlObj->getNoLimitSql();
            $data = $this->db->getInstance('rule')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
            return $data['count'];
        }

        private function getDataCount() {
            $sql = 'SELECT id FROM service';
            return $this->db->getInstance('rule')->query($sql)->getCount();
        } 

        private function getBasicList() {
            requireModelDevClass('assembleSql');
            $assembleSqlObj = new AssembleSql($this->selectSts, $this->fromSts,
                $this->whereSts);
            $sql = $assembleSqlObj->getSimpleQuerySql();
            return $this->db->getInstance('rule')->query($sql)
                ->getAllData(PDO::FETCH_ASSOC);
        }

        private function getDelCli($name) {
            return "service del name \"$name\"";
        }    

        private function getAddEditCli($type) {
            $name    = $_POST['basicName'];
            $comment = $_POST['comment'];
       		$str="";
            $protocolArray=array("TCP"=>6,"UDP"=>17,"Other"=>256);
            $slport1 = ($_POST['slport1']!='')?intval($_POST['slport1']):0;
            $shport1 = ($_POST['shport1']!='')?intval($_POST['shport1']):0;
            $dlport1 = ($_POST['dlport1']!='')?intval($_POST['dlport1']):0;
            $dhport1 = ($_POST['dhport1']!='')?intval($_POST['dhport1']):0;
            $protocol1 = $protocolArray[$_POST['protocol1']];
            
            $slport2 = ($_POST['slport2']!='')?intval($_POST['slport2']):0;
            $shport2 = ($_POST['shport2']!='')?intval($_POST['shport2']):0;
            $dlport2 = ($_POST['dlport2']!='')?intval($_POST['dlport2']):0;
            $dhport2 = ($_POST['dhport2']!='')?intval($_POST['dhport2']):0;
            $protocol2 = $protocolArray[$_POST['protocol2']];
            
            $slport3 = ($_POST['slport3']!='')?intval($_POST['slport3']):0;
            $shport3 = ($_POST['shport3']!='')?intval($_POST['shport3']):0;
            $dlport3 = ($_POST['dlport3']!='')?intval($_POST['dlport3']):0;
            $dhport3 = ($_POST['dhport3']!='')?intval($_POST['dhport3']):0;
            $protocol3 = $protocolArray[$_POST['protocol3']];
            
            $slport4 = ($_POST['slport4']!='')?intval($_POST['slport4']):0;
            $shport4 = ($_POST['shport4']!='')?intval($_POST['shport4']):0;
            $dlport4 = ($_POST['dlport4']!='')?intval($_POST['dlport4']):0;
            $dhport4 = ($_POST['dhport4']!='')?intval($_POST['dhport4']):0;
            $protocol4 = $protocolArray[$_POST['protocol4']];
            
            $slport5 = ($_POST['slport5']!='')?intval($_POST['slport5']):0;
            $shport5 = ($_POST['shport5']!='')?intval($_POST['shport5']):0;
            $dlport5 = ($_POST['dlport5']!='')?intval($_POST['dlport5']):0;
            $dhport5 = ($_POST['dhport5']!='')?intval($_POST['dhport5']):0;
            $protocol5 = $protocolArray[$_POST['protocol5']];
            
            $slport6 = ($_POST['slport6']!='')?intval($_POST['slport6']):0;
            $shport6 = ($_POST['shport6']!='')?intval($_POST['shport6']):0;
            $dlport6 = ($_POST['dlport6']!='')?intval($_POST['dlport6']):0;
            $dhport6 = ($_POST['dhport6']!='')?intval($_POST['dhport6']):0;
            $protocol6 = $protocolArray[$_POST['protocol6']];
            
            $slport7 = ($_POST['slport7']!='')?intval($_POST['slport7']):0;
            $shport7 = ($_POST['shport7']!='')?intval($_POST['shport7']):0;
            $dlport7 = ($_POST['dlport7']!='')?intval($_POST['dlport7']):0;
            $dhport7 = ($_POST['dhport7']!='')?intval($_POST['dhport7']):0;
            $protocol7 = $protocolArray[$_POST['protocol7']];
            
            $slport8 = ($_POST['slport8']!='')?intval($_POST['slport8']):0;
            $shport8 = ($_POST['shport8']!='')?intval($_POST['shport8']):0;
            $dlport8 = ($_POST['dlport8']!='')?intval($_POST['dlport8']):0;
            $dhport8 = ($_POST['dhport8']!='')?intval($_POST['dhport8']):0;
            $protocol8 = $protocolArray[$_POST['protocol8']];
            
            $str.= "slport1 $slport1 shport1 $slport1 dlport1 $dlport1 dhport1 $dhport1 protocol1 $protocol1 ";
            $str.= "slport2 $slport2 shport2 $slport2 dlport2 $dlport2 dhport2 $dhport2 protocol2 $protocol2 ";
            $str.= "slport3 $slport3 shport3 $slport3 dlport3 $dlport3 dhport3 $dhport3 protocol3 $protocol3 ";
            $str.= "slport4 $slport4 shport4 $slport4 dlport4 $dlport4 dhport4 $dhport4 protocol4 $protocol4 ";
            $str.= "slport5 $slport5 shport5 $slport5 dlport5 $dlport5 dhport5 $dhport5 protocol5 $protocol5 ";
            $str.= "slport6 $slport6 shport6 $slport6 dlport6 $dlport6 dhport6 $dhport6 protocol6 $protocol6 ";
            $str.= "slport7 $slport7 shport7 $slport7 dlport7 $dlport7 dhport7 $dhport7 protocol7 $protocol7 ";
            $str.= "slport8 $slport8 shport8 $slport8 dlport8 $dlport8 dhport8 $dhport8 protocol8 $protocol8 ";
            
            return "service $type name \"$name\" comment \"$comment\" ".$str;
        }

        private function runAddEditDelCmd($type, $log, $delName = '') {
            requireCache(WEB_PATH . '/Lib/driver/cli.php');
            $cli = new cli();
            if ($type === 'del') {
                $cmd = $this->getDelCli($delName);
            } else {
                $cmd = $this->getAddEditCli($type);
            }
            echo $cmd;
			//$cli->setLog($log)->run($cmd);
        }

        public function getInitPageData() {
            $dataCount = $this->getDataCount();
            $pageCount = ceil($dataCount/10);
            return array('dataCount' => $dataCount, 'pageCount' => $pageCount);
        }

        public function getInitTable() {
            requireModelDevClass('table');
            $data = array(
                'tpl'  => $this->tableTpl,
                'data' => array('basicList' => $this->getBasicList())
            );
            $t = new Table($data);
            $this->tableHtml = $t->getTableHtml();
        }
    
        public function freshTableAndPagination() {
            requireModelDevClass('tableAndPager');
            $data = array(
                'url'       => 'index.php?R=firewall/service/basic/' .
                               'freshTableAndPagination',
                'tableTpl'  => $this->tableTpl,
                'tableData' => array('basicList' => $this->getBasicList()),
                'dataCount' => $this->getOrderDataCount()
            );
            $tp = new tableAndPager($data);
            list($this->tableHtml, $this->pagerHtml) = $tp->getResult();
        }

        public function getBasicById($id) {
            $sql = 'SELECT * FROM service ' .
                "WHERE id = $id";
            $this->specBasicById = $this->db->getInstance('rule')->query($sql)
                ->getFirstData(PDO::FETCH_ASSOC);
        }

        public function addNewBasic() {
            $log = "防火墙》服务》基本服务,添加新服务{$_POST['basicName']}.";
            $this->runAddEditDelCmd('add', $log);
        }

        public function editSpecBasic() {
            $log = "防火墙》服务》基本服务,修改{$_POST['basicName']}.";
            $this->runAddEditDelCmd('set', $log);
        }

        public function delSpecBasic($name) {
            $log = "防火墙》服务》基本服务,删除$name.";
            $this->runAddEditDelCmd('del', $log, $name);
        }

        public function batchDel() {
            foreach ($_GET['batchKey'] as $name) {
                $this->delSpecBasic($name);
            }
        }

        public function checkUniqueBasicName() {
            $name  = $_GET['basicName'];
            $sql   = "SELECT id FROM service WHERE name = '$name'";
            $count = $this->db->getInstance('rule')->query($sql)->getCount();
			echo $count > 0 ? 'false' : 'true';
        }
    }
?>
