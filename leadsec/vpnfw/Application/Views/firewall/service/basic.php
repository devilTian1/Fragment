<?php
    require_once WEB_PATH . '/Application/Views/common.php';

    class BasicView extends commonView {
        public function showTable() {
            $tpl = 'firewall/service/basicTable.tpl';
            $result= V::getInstance()->assign('list', $this->model->indata)
                  ->fetch($tpl);
            $msg=array();
            $msg['msg']['tableHtml']=$result;
            echo json_encode($msg);     
        }
        
        public function showTableAndPagination(){
        	$msg=array();
        	$tpl = 'firewall/service/basicTable.tpl';
        	$msg['msg']['tableHtml']=V::getInstance()->assign('list', $this->model->indata)
                  ->fetch($tpl);
            $msg['msg']['pagerHtml']=V::getInstance()->assign('initData', $this->model->initData)
            	  ->assign('func', "index.php?R=firewall/service/basic/freshTableAndPagination")
                  ->fetch("layout/pagination.tpl");
             echo json_encode($msg);        
        }
        
        public function showNewDialog(){
        	$tpl = 'firewall/service/basic_editDialog.tpl';
        	$result=V::getInstance()->fetch($tpl);
        	echo json_encode(array('msg' => $result));
        }
        
    	public function showSimpleAdvSearchDialog(){
			$tpl = 'firewall/service/basic_advSearch.tpl';
        	$result=V::getInstance()->fetch($tpl);
        	echo json_encode(array('msg' => $result));
		}
    }
?>
