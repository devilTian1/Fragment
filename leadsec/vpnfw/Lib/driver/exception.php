<?php
    require_once(WEB_PATH . '/Lib/core/exception.php');
    
    class DBException extends sisException {
        public function __construct($message, $code = 0) {
	    $message = "Error Database: $message";
            parent::__construct($message, $code);
        }
    }

    class ExecCmdException extends sisException {
        public function __construct($message, $code = 0) {
	    $message = "Error Cmd: $message";
            parent::__construct($message, $code);
        }
    }
?>
