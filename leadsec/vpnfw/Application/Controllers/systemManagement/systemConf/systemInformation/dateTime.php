<?php
    class DateTimeController extends commonController {

		public function __construct(Loader $loader) {
			parent::__construct($loader);
			$this->model = $this->getModel();
			$this->view  = $this->getView('common');
		}

		public function setServerTime() {
			$this->model->setServerTime();
			$this->view->showMsg();	
		}
		
		public function setTimezone() {
			$this->model->setTimezone();
			$this->view->showMsg();
		}

		public function setNTPServer(){
			$this->model->setNTPServer();
			$this->view->showMsg();	
		}
		
		public function syncTime() {
			$this->model->synTime();
			$this->view->showMsg();			
		}
	}
?>
