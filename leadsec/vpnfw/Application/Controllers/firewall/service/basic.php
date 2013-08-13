<?php
    class BasicController extends commonController{
        public function __construct(Loader $loader) {
            parent::__construct($loader);
        }
        
    	public function showTable() {
            $model = $this->getModel();
            $view  = $this->getView('firewall/service/basic');
            if(isset($_POST['orderStatement'])){
            	$where=$_POST['orderStatement'];
            }else{
            	$where="LIMIT 10 OFFSET 0";
            }
            $data=$model->getTableData($where);
            $view->showTableData($data);
        }
        
        public function openNewDialog(){
            $view  = $this->getView();
            $view->showNewDialog();
        }
    }
?>
