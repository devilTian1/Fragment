<?php
    //require_once WEB_PATH . 'Application/Models/login.php';
    class commonController {
        protected $view;
        protected $model;
        protected $controller;
    
        public function __construct(Loader $loader) {
            $this->view       = $loader->getViewClass();
            $this->model      = $loader->getModelClass();
            $this->controller = $loader->getControllerClass();
            //$this->isTimeout = $loginClass->chklogin();
        }

       /**
         * Get the returned result of execute function.
         * @param $type String. result data type.eg: 'JSON', 'string' and so on.
         * @param $index Integer. the index of returned result set. default is
         *   the first result.
         */
        public function getFilterResult($result) {
            switch($type) {
                case 'json':
                    if (!is_array($result)) {
                        $result = array($result);
                    }
                    return json_encode($result);
                default:
                    return $result;
            }
        }

    }
?>
