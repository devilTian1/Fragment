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
                $this->frags['path'] . '/' . $this->frags[0] . '.php';
        }

        private function getModelClassName($p) {
            if (false !== strpos($p, '/')) {
                $name = array_pop(explode('/', $p));
            } else {
                $name = $p;
            }
            return ucfirst($name) . 'Model';
        }

        private function getViewClassName($p) {
            if (false !== strpos($p, '/')) {
                $name = array_pop(explode('/', $p));
            } else {
                $name = $p;
            }
            return ucfirst($name) . 'View';
        }

        private function getControllerClassName() {
            return ucfirst($this->frags[0]) . 'Controller';
        }

        private function getFuncName() {
            return $this->frags[1];
        }

        private function formatRequest($frags) {
            $fragArr   = explode('/', $frags);
            $funcName  = array_pop($fragArr);
            $className = array_pop($fragArr);
            $classPath = join('/', $fragArr);
            $this->frags = array($className, $funcName, 'path' => $classPath);
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
                $frags = 'login/login/index';
            }
            $this->formatRequest($frags);
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
                $msg = DEBUG ? "Can`t execute controller function" .
                    "[{$className}::{$funcName}].<br/>{$e->getMessage()}" :
                    $e->getMessage();
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

        public function loaderModel($name=null) {
            if ($name === null) {
                $name =  $this->frags['path'] . '/' . $this->frags[0];
            }
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
            if ($name === null) {
                $name =  $this->frags['path'] . '/' . $this->frags[0];
            }
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
