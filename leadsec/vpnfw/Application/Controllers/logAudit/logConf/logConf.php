<?php
    class LogConfController extends commonController {

        public function __construct(Loader $loader) {
			parent::__construct($loader);
			$this->model = $this->getModel();
		}

    	public function setLogConf() {
            $view  = $this->getView('common');
            $this->model->setLogConf();
            $view->showConfSuccess();
        }
    }
?>
