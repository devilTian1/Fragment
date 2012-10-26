<?php
    require_once(WEB_PATH . '/Lib/core/exception.php');
    
    class DBException extends sisException {
        public function __construct($message, $code = 0) {
            parent::__construct($message, $code);
        }
    }
?>
