<?php
    require_once(WEB_PATH . '/Lib/core/cmd.php');

    class cli extends CMD {
        public function __construct() {}

        public function run($cmd, $isRec = true) {
            list($status, $lines) =  $this->exec($cmd);
            if ($isRec) {
                $this->record($status, $cmd);
            }
            if ($status != 0) {
                $errMsg = "[$cmd]" . join(', ', $lines);
                throw new ExecCmdException($errMsg);
            }
            return $lines;
        }
    }
?>
