<?php
    require_once(WEB_PATH . '/Lib/core/cmd.php');

    class cli extends CMD {
        public function __construct() {
        }

        public function run($cmd) {
            $result =  $this->exec($cmd);
	        return join(' ', $result);
        }
    }
?>
