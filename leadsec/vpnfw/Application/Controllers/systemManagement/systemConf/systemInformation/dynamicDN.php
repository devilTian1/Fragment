<?php
    class DynamicDNController extends commonController{
		public function __construct(Loader $loader) {
			parent::__construct($loader);
			$this->model = $this->getModel();
			$this->view  = $this->getView('common');
		}
		
		public function setDdnsUser() {
			$this->model->setDdnsUser();
			$this->view->showMsg();
		}
	}
?>
