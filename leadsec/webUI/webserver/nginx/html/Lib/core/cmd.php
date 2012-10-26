<?php
    /**
     * CMD base class
     * format
     */
    class CMD {
        public function __construct() {
            
        }
        /**
         * Execute system command and read the output.
         * @param $cmd. String. System command to execute
         * @return $lines. String. Output of the command as string.
         */
        public function exec($cmd) {
            $cmd = escapeshellcmd($cmd);
            $result = shell_exec($cmd);
            return $result;
        }
    }
?>
