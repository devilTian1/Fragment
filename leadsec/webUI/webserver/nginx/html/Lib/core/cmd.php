<?php
    /**
     * CMD base class
     * format
     */
    class CMD {
        public function __construct() {}

        protected function record($status, $cmd) {
            $date      = date('Y/m/d H:i:s');
            $logStr    = "#$date return code={$this->status}" . PHP_EOL .
                $cmd . PHP_EOL;
            $file      = '/tmp/webui.cmd.log';
            file_put_contents($file, $logStr, FILE_APPEND);
        }
        /**
         * Execute system command and read the output.
         * @param $cmd. String. System command to execute
         * @return Array.
         *  $status. the return status of the executed command
         *  $result. Array. Output of the command as Array.
         */
        public function exec($cmd) {
            $lines  = array();
            exec($cmd . ' 2>&1; echo $?', $lines);
            $status = array_pop($lines);
            return array($status, $lines);
        }
    }
?>
