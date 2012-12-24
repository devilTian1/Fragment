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
		$cmd_str = '#' . date('Y/m/d H:i:s') . ' ' .'return code=' . $status . "\r\n" .$cmd . "\r\n";
		$file = '/tmp/webui.cmd.log';
		$filesize = filesize($file);
		if($filesize>0) {
			file_put_contents($file,$cmd_str,FILE_APPEND);
		} else {
			file_put_contents($file,$cmd_str);
		}
	    if ($status != 0) {
		    $errMsg = "[$cmd]" . join(', ', $result);
	        throw new ExecCmdException($errMsg);
	    }
            return $result;
        }
    }
?>
