<?php
    session_start();
    // Analyze the GET/POST request params and load 
    //  corresponding class and methos.
    class Loader {
        private $frags;
        private $viewClass;
        private $modelClass;
        private $controllerClass;

        private function getModelClassPath($name) {
            return WEB_PATH . "/Application/Models/$name.php";
        }

        private function getViewClassPath($name) {
            return WEB_PATH . "/Application/Views/$name.php";
        }

        private function getControllerClassPath() {
            return WEB_PATH . '/Application/Controllers/' .
                $this->frags[0] . '.php';
        }

        private function getModelClassName($name) {
            return ucfirst($name) . 'Model';
        }

        private function getViewClassName($name) {
            return ucfirst($name) . 'View';
        }

        private function getControllerClassName() {
            return ucfirst($this->frags[0]) . 'Controller';
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

        public function loaderModel($name) {
            $path      = $this->getModelClassPath($name);
            $className = $this->getModelClassName($name);
            try {
                include_once $path;
                $this->modelClass = new $className();
                return $this;
            } catch (Exception $exception) {
                $msg = "Can`t generate this Model Class[$className].<br/>" .
                    $exception->getMessage();
                throw new Exception($msg);
            }
        }

        public function loaderView($name) {
            $path      = $this->getViewClassPath($name);
            $className = $this->getViewClassName($name);
            try {
                include_once $path;
                $this->viewClass = new $className($this);
                return $this;
            } catch (Exception $exception) {
                $msg = "Can`t generate this View Class[$className].<br/>" .
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
            $this->loaderController()->loaderFunction();
        }
    }
?>
