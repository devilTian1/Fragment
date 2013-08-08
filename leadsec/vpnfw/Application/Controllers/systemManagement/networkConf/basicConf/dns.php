<?php
	
	class DnsController extends commonController {
	
		public function __construct(Loader $loader) {
			parent::__construct($loader);
			$this->model = $this->getModel();
			$this->view  = $this->getView('common');
		}
		
        public function setDns() {
            $this->model->setDns();
            $this->view->showMsg();
        }
	}