<?php
    require_once(WEB_PATH . '/Lib/core/cmd.php');
    require_once(WEB_PATH . '/Lib/driver/function.php');

    class cli extends CMD {
        protected $msg;

        protected $isRec;

        protected $getResult;

        public $cmd;

        private function setCmdSuffix() {
            if ($this->getResult) {
                $this->cmd .= ' 2>&1;';
            } else {
                $this->cmd .= ' >/dev/null 2>&1;';
            }
        }

        public function __construct() {
            $this->getResult = false;
            $this->isRec     = true;
            $this->msg       = '';
            $this->cmd       = '';
            return $this;
        }

        public function setLog($msg) {
            $this->msg = $msg;
            return $this;
        }

        public function setIsRec($isRec) {
            $this->isRec = $isRec;
            return $this;
        }
        
        public function setGetResult($s) {
            $this->getResult = $s;
            return $this;
        }

        public function run($cmd) {
            $this->cmd = $cmd;
            $this->setCmdSuffix();
            list($status, $lines) = $this->exec($this->cmd);
            if ($this->isRec) {
                $this->record($status, $this->cmd, $this->msg);
            }
            if ($status != 0) {
                //$errMsg = "[{$this->cmd}]" . join(', ', $lines);
                $errMsg = "[执行命令错误]" . join(', ', $lines);
                throw new ExecCmdException($errMsg);
            }
            if ($this->getResult) {
                return $lines;
            }
        }

        /**
         * Execute system command, read the status and output.
         * @param $cmd. System command to execute.
         * @param $isSetGetResult. whether to get return status.
         * @return associate array.
         *  $status.Integer. Status returned from the command.
         *  $lines.Array. Output of the Command
         */
        public function execCmdGetStatus($cmd, $isSetGetResult = true) {
            $this->cmd = $cmd;
            $this->setGetResult($isSetGetResult);
            $this->setCmdSuffix();
            list($status, $lines) = $this->exec($this->cmd);
            if ($this->isRec) {
                $this->record($status, $this->cmd, $this->msg);
            }
            return array($status, $lines);
        }
    }
?>
