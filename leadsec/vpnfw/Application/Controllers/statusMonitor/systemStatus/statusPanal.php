<?php
    class StatusPanalController extends commonController{
        public function __construct(Loader $loader) {
            parent::__construct($loader);
        }

        public function setDns() {
            $model = $this->getModel();
            $view  = $this->getView('common');
            $model->setDns();
            $view->showConfSuccess();
        }
    }
?>
