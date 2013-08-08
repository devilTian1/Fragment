<?php
    class SNMPController extends commonController {
	
		public function __construct(Loader $loader) {
			parent::__construct($loader);
			$this->model = $this->getModel();
			$this->view  = $this->getView('common');
		}
		
		public function setSnmp(){
			$this->model->setSnmp();
			$this->view->showMsg();
		}
	}
?>
