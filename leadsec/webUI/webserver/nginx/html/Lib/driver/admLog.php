<?php
    require_once(WEB_PATH . '/Lib/core/log.php');
    require_once(WEB_PATH . '/Lib/driver/dbsqlite.php');
    require_once(WEB_PATH . '/Lib/driver/function.php');

    class admLog extends Log {
        protected $account;

        protected $priority;
        
        private $hostname;

        private $act;

        private $cmd;
        /**
         * 管理操作日志
         * @param associate array.
         *  timestamp.$time 操作时间
         *  string.  $user 操作管理员
         *  string.  $msg 信息描述
         *  integer. $pri. 优先级
         *  string.  $act. 动作. including login logout show set
         */
        public function __construct($infoSet = NULL) {
            if (!empty($infoSet)) {
                $this->add($infoSet);
            }
            return self;
        }

        public function add($infoSet) {
            $this->account  = $infoSet['account'];
            $this->priority = $infoSet['pri'];
            $this->hostname = $this->getHostname();
            $this->act      = $infoSet['act'];
            $this->cmd      = $infoSet['cmd'];
            parent::add($infoSet['time'], $infoSet['msg']);
            $this->record();
        }

        private function getHostname() {
            $db = new dbsqlite(DB_PATH . '/configs.db');
            $result = $db->query("SELECT hostname FROM hostname")
                         ->getFirstData(PDO::FETCH_ASSOC);
            return $result['hostname'];
        }

        private function getPublicInfo() {
            $date = date('Y/m/d H:i:s', $this->time);
            $mod  = 'webui';
            return "devid=" . LOG_DEVID . " date=\"$date\" " .
                "dname={$this->hostname} logtype=9 pri={$this->priority} " .
                "mod=$mod event=\"{$this->msg}\"";
        }

        private function getPrivateInfo() {
            $cip = get_client_ip();
            $result = " from=\"$cip\" admin=\"{$this->account}\" " .
                "act=\"{$this->act}\"";
            if (!empty($this->cmd)) {
                $result .= " cmd=\"{$this->cmd}\"";
            }
            return $result;
        }

        protected function record() {
            $publicInfo  = $this->getPublicInfo();
            $privateInfo = $this->getPrivateInfo();

            $msg = $publicInfo . $privateInfo;
            $msg = str_replace('"', '\\"',$msg);
            $cli = new cli();                                    
            $cli->setIsRec(false)->run("logger \"$msg\"");
            return self;
        }
    }
?>
