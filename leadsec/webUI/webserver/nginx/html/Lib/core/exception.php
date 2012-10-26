<?php
    class sisException extends Exception {
        public function __construct() {
            $date = date('Y-m-d H:i:s');
            $msg  = "\n--------------------------\n";
            $msg .= $date . " | errMsg:{$this->message} | " . __CLASS__ .
                " | code:{$this->getCode()}\n";
            $msg .= $this->getTraceAsString() . "\n";
            error_log($msg, 3, WEB_PATH . '/Logs/error_log');
        }
    }
?>
