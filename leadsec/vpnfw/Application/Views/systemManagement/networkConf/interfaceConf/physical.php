<?php
    require_once WEB_PATH . '/Application/Views/common.php';

    class PhysicalView extends commonView {

        public function showTableData() {
            $workmodeArr = array('未指定',   '路由模式',
                             '透明模式', '冗余模式');
            $propertyArr = array('关闭',  '开启');
            $ipaddrArr = array('未指定', '静态指定',
                           '无效',   'DHCP获取');
            $tpl = 'systemManagement/networkConf/interfaceConf/physicalTable.tpl';
            echo V::getInstance()->assign('list', $this->model->indata)
            	->assign('propertyArr', $propertyArr)
            	->assign('ipaddrArr', $ipaddrArr)
            	->assign('workmodeArr', $workmodeArr)
            	->assign('pageCount', 10)
                  ->fetch($tpl);
        }
        
        public function showSpecPhysicalDialog() {
            $tpl = 'systemManagement/networkConf/interfaceConf/editPhysicalDialog.tpl';
            $result = V::getInstance()->assign('res', $this->model->indata)
                                ->assign('comment', $this->model->comment)
                                ->assign('antiARP', $this->model->antiARP)
                                ->assign('ipConflict', $this->model->ipConflict)
                                ->fetch($tpl);
            echo json_encode(array('msg' => $result));
        }
    }
?>
