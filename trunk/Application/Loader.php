<?php
    // Analyze the GET/POST request params and load 
    //  corresponding class and methos.
    class Loader {
        private $frag;
        private $class;

        /*
         * Split request action and call the relevant class and function/
         * eg: 'login/chklogin', class->login, function->chklogin.
         */
        public function __construct() {
            $this->frag = explode('/', $_GET['r'], 3);
            $this->loadClass();
            $this->loadFunction();
        }

        /*
         * Load the requested class.
         */
        public function loadClass() {
            try {
                include dirname(__file__) . '/Models/' .
                    $this->frag[0] . '.php';
                $className   = strtoupper($this->frag[0]);
                $this->class = new $className('xx');
            } catch (Exception $exception) {
                $msg = "Can`t Load this Class[$this->class].";
                throw new Exception($msg, 0, $exception);
            }
        }
        /*
         * Load the requested function of specified class.
         */
        public function loadFunction() {
            $funcName = ucfirst(strtolower($this->frag[1]));
            try {
                $this->class->$funcName();
            } catch (Exception $e) {
                $msg = "Can`t execute function[{$this->class}::{$funcName}]";
                throw new Exception($msg);
            }
        }
        /*
         * return the requested class
         */
        public function getClass() {
            return $this->class;
        }
    }

?>
