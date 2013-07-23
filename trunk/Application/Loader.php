<?php
    session_start();
    // Analyze the GET/POST request params and load 
    //  corresponding class and methos.
    class Loader {
        private $frags;
        private $viewClass;
        private $modelClass;
        private $controllerClass;

        private function getModelClassPath() {
            return WEB_PATH . '/Application/Models/' .
                $this->frags[0] . '.php';
        }

        private function getViewClassPath() {
            return WEB_PATH . '/Application/Views/' .
                $this->frags[0] . '.php';
        }

        private function getControllerClassPath() {
            return WEB_PATH . '/Application/Controllers/' .
                $this->frags[0] . '.php';
        }

        private function getRawClassName() {
            return ucfirst($this->frags[0]);
        }

        private function getControllerClassName() {
            return ucfirst($this->frags[0]) . 'Controller';
        }

        private function getViewClassName() {
            return ucfirst($this->frags[0]) . 'View';
        }

        private function getModelClassName() {
            return ucfirst($this->frags[0]) . 'Model';
        }

        private function getFuncName() {
            return $this->frags[1];
        }

        private function formatRequest() {
            $this->frags = explode('/', $this->frags, 2);
        }

        /*
         * Split request action and call the relevant class and function/
         * eg: 'login/chklogin', class->login, function->chklogin.
         */
        final public function __construct() {
            $this->frags = array();
            if (isset($_GET['R'])) {
                $frags = $_GET['R'];
            } else if (isset($_POST['R'])) {
                $frags = $_POST['R'];
            } else {
                $frags = 'login/index';
            }
            $this->frags = $frags;
            $this->formatRequest();
            return $this;
        }

        /*
         * Load the requested function of specified controller class.
         */
        private function loaderFunction() {
            $className = $this->getControllerClassName();
            $funcName  = $this->frags[1];
            try {
                // return the return value of the callback or FALSE on error.
                call_user_func(array($this->controllerClass,
                                     $funcName));
            } catch (Exception $e) {
                $msg = "Can`t execute controller function" .
                    "[{$className}::{$funcName}].<br/>{$e->getMessage()}";
                throw new Exception($msg);
            }
        }

        private function loaderModel() {
            $path      = $this->getModelClassPath();
            $className = $this->getModelClassName();
            try {
                include_once $path;
                $this->modelClass = new $className();
            } catch (Exception $exception) {
                $msg = "Can`t generate this Model Class[$className].<br/>" .
                    $exception->getMessage();
                throw new Exception($msg);
            }
        }

        private function loaderView() {
            $path      = $this->getViewClassPath();
            $className = $this->getViewClassName();
            try {
                include_once $path;
                $this->viewClass = new $className($this);
            } catch (Exception $exception) {
                $msg = "Can`t generate this View Class[$className].<br/>" .
                    $exception->getMessage();
                throw new Exception($msg);
            }   
        }

        private function loaderController() {
            $path      = $this->getControllerClassPath();
            $className = $this->getControllerClassName();
            try {
                include_once $path;
                $this->controllerClass = new $className($this);
                return $this;
            } catch (Exception $exception) {
                $msg = "Can`t generate this Controller Class[$className].<br/>".
                    $exception->getMessage();
                throw new Exception($msg);
            }
        }

        public function getModelClass() {
            return $this->modelClass;
        }

        public function getControllerClass() {
            return $this->controllerClass;
        }

        public function getViewClass() {
            return $this->viewClass;
        }

        public function loader() {
            $this->loaderModel();
            $this->loaderView();
            $this->loaderController()->loaderFunction();
        }
    }
?>
