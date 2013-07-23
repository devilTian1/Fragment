<?php
    require_once WEB_PATH . '/Lib/driver/admLog.php';
    require_once WEB_PATH . '/Lib/driver/function.php';
    /**
     * CMD base class
     * format
     */
    class CMD {
        public function __construct() {}

        protected function record($status, $cmd, $msg) {
            // add to log
            $account = $_SESSION['account'];
            $pri     = 6;
            if ($status != 0) {
                $pri = 1;
            }
            $msg = getRoleName($_SESSION['roles']) . "管理员[{$account}]" .
                "执行命令, {$msg}.";
            $set = array(
                'time' => time(), 'account' => $account,
                'pri'  => $pri,   'act'     => 'set',
                'cmd'  => $cmd,   'msg'     => $msg
            );
            $admLog = new admLog($set);
            
            // add to batchTool log
            $date      = date('Y/m/d H:i:s');
            $logStr    = "#$date return code=$status" . PHP_EOL .
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
            $cmd   .= ' echo $?';
            exec($cmd, $lines);
            $status = array_pop($lines);
            return array(intval($status), $lines);
        }
    }
?>
