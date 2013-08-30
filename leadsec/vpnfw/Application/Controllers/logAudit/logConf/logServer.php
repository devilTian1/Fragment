<?php
    class LogServerController extends commonController {

        public function __construct(Loader $loader) {
			parent::__construct($loader);
			$this->model = $this->getModel();
		}

    	public function setLogServer() {
            $view  = $this->getView('common');
            $this->model->setLogServer();
            $view->showConfSuccess();
        }
    }
?>
