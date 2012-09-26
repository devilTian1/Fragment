<?php
    require_once(WEB_PATH . '/Lib/core/cmd.php');

    class cli extends CMD {
        public function __construct() {
        }

        public function run($cmd) {
            list($status, $result) = $this->exec($cmd);
	    $result = join(' ', $result);
            if ($status !== 0) {
                $msg = "cmd:[$cmd], msg:[$result]";
                throw new ExecCmdException($msg);
            }
            return $result;
        }
    }
?>
