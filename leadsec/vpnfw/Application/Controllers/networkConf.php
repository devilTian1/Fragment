<?php
    require_once WEB_PATH . '/Application/Controllers/common.php';

    class NetworkConfController extends commonController{
        public function __construct(Loader $loader) {
            parent::__construct($loader);
        }

        public function setDns() {
            $model = $this->getModel('networkConf');
            $view  = $this->getView('common');
            $model->setDns();
            $view->showConfSuccess();
        }
    }
?>
