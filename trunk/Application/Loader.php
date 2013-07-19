<?php
    // Analyze the GET/POST request params and load 
    //  corresponding class and methos.
    class Loader {
        private $frags;
        private $class;

        private function getClassPath($name, $t) {
            if ($t === 'M') {
                return WEB_PATH . '/Application/Models/' .
                    strtolower($name) . '.php';
            } else if ($t === 'C') {
                return WEB_PATH . '/Application/Controllers/' .
                    strtolower($name) . '.php';
            } else {
                throw new Exception("Can`t get class[$name] path, type [$t].");
            }
        }

        private function getRawClassName($name) {
            return ucfirst(strtolower($name));
        }
        private function getControllerClassName($name) {
            return ucfirst(strtolower($name)) . 'Controller';
        }
        private function getModelClassName($name) {
            return ucfirst(strtolower($name)) . 'Model';
        }

        private function getFuncName($name) {
            return strtolower($name);
        }

        private function formatRequest() {
            foreach ($this->frags as &$frag) {
                $frag = explode('/', $frag, 3);
                $frag[0] = $this->getRawClassName($frag[0]);
                $frag[1] = $this->getFuncName($frag[1]);
            }
            unset($frag);
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
                $frags = 'login/login';
            }
            if (!is_array($frags)) {
                $frags = array($frags);
            }
            $this->frags = $frags;
            $this->formatRequest();
            return $this;
        }

        /*
         * Load the requested class.
         * @param $path String. class full path.
         * @param $className String.
         * @param $params Mixed. params which be used in construct func.
         *
         */
        private function loadClass($path, $className, $params = null) {
            try {
                if (count($this->class) > 10) {
                    throw new Exception('Load Class number is more than 10.');
                } 
                if (empty($this->class[$className])) {
                    include_once $path;
                    if (isset($params)) {
                        $this->class[$className] = new $className($params);
                    } else {
                        $this->class[$className] = new $className();
                    }
                }
            } catch (Exception $exception) {
                $msg = "Can`t Load this Class[$className].";
                throw new Exception($msg, 0, $exception);
            }
        }

        /*
         * Load the requested function of specified class.
         * @param $funcName String. functon name in class "$className".
         * @param $className String.
         */
        private function loadFunction($funcName, $className) {
            try {
                // return the return value of the callback or FALSE on error.
                call_user_func(array($this->class[$className],
                                     $funcName));
            } catch (Exception $e) {
                $msg = "Can`t execute function[{$className}::{$funcName}]." .
                    "Reason: {$e->getMessage()}";
                throw new Exception($msg);
            }
        }

        private function loader($path, $className, $funcName, $initParam) {
            $this->loadClass($path, $className, $initParam);
            $this->loadFunction($funcName, $className);
            return $this;
        }

        /**
         * Remove specified class res from param. purpose: clean mem.
         * @param $className String.
         */
        public function unsetClass($className) {
            unset($this->class[$className]);
        }

        public function loaderModel($frag) {
            $path      = $this->getClassPath($frag[0], 'M');
            $className = $this->getModelClassName($frag[0]);
            $funcName  = $frag[1];
            $initParam = @$frag[2];

            $this->loader($path, $className, $funcName, $initParam);
            return $this;
        }

        public function loaderController($index = 0) {
            $path      = $this->getClassPath($this->frags[$index][0], 'C');
            $className = $this->getControllerClassName($this->frags[$index][0]);
            $funcName  = $this->frags[$index][1];
            $initParam = @$this->frags[$index][2];

            $this->loader($path, $className, $funcName, $initParam);
            return $this;
        }

        public function loaderAllModel() {
            foreach($this->frags as $f) {
                $this->loaderModel($f);
            }
            return $this;
        }
    }
?>
