<?php
    /**
     * CMD base class
     * format
     */
    class CMD {
        public function __construct() {}
        /**
         * Execute system command and read the output.
         * @param $cmd. String. System command to execute
         * @return Array.
         *  $status. the return status of the executed command
         *  $result. Array. Output of the command as Array.
         */
        public function exec($cmd) {
            $status = 0;
            $result = array();
            $cmd = escapeshellcmd($cmd);

	    exec($cmd, $result, $status);
	    if ($status != 0) {
		$errMsg = "[$cmd]" . join(', ', $result);
	        throw new ExecCmdException($errMsg);
	    }
            return $result;
        }
    }
?>
