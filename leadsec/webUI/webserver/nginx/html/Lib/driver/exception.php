<?php
    require_once(WEB_PATH . '/Lib/core/exception.php');
    
    class DBException extends sisException {
        public function __construct($message, $code = 0) {
            parent::__construct($message, $code);
            $date = date('Y-m-d H:i:s');
            $msg  = "\n--------------------------\n";
            $msg .= $date . " | errMsg:{$this->message} | " . __CLASS__ .
                " | code:{$this->getCode()}\n";
            $msg .= $this->getTraceAsString() . "\n";
            error_log($msg, 3, WEB_PATH . '/Logs/error_log');
        }
    }
?>
