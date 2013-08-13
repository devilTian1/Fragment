<?php
    require_once WEB_PATH . '/Application/Views/common.php';

    class BasicView extends commonView {

        public function showTableData($data) {
            $tpl = 'firewall/service/basicTable.tpl';
            echo V::getInstance()->assign('list', $data)
                  ->fetch($tpl);
        }
        
        public function showNewDialog(){
        	$tpl = 'firewall/service/basic_editDialog.tpl';
        	$result=V::getInstance()->fetch($tpl);
        	echo json_encode(array('msg' => $result));
        }
    }
?>
