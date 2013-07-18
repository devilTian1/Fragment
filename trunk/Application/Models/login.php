<?php
    require_once WEB_PATH . '/Lib/driver/dbsqlite.php';
    require_once WEB_PATH . '/Lib/driver/admLog.php';
    require_once WEB_PATH . '/Application/Models/user.php';

    class LoginModel {
        private $db;
        private $admLog;
        private $uTool;

        public function __construct($p = null) {
            $this->db     = new dbsqlite(DB_PATH . '/configs.db');
            $this->admLog = new admLog();
            $this->uTool  = new User();
        }

        function b() {
            $sql = "SELECT allow FROM allow_multiple";
            $result = $this->db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            var_dump($result);
            echo '<br/>' . _('one') . '<br/>';
            printf(_('1 + %d = 3|'), 2);
        }

        /*
         * Check the limit number of logged-in user
         */
        private function chkLimitErrTime() {
            $cIp               = $this->uTool->getClientIp();
            list($account, $n) = $this->uTool->getLoggedInUserInfo();
            if (@$_SESSION[$account] >= LIMITERR_NUM &&
                !chkLimitErrTime($account)) {
                $_SESSION['limitErrTime'] = time();
                $errMsg = "输错密码超过规定次数,账号".$account."已被封锁!";
                $msg = "用户[$account]" . str_replace('<br/>', ', ', $errMsg) .
                    "地址来自[$cIp].";
                $logParam = array(
                    'time' => time(), 'account' => $account, 'pri' => 3,
                    'act' => 'login', 'msg'     => $msg
                );
                $this->admLog->add($logParam);
                return false;
            }
            return true;
        }

        /*
         * Check if allow multiple-users to admin gui or not.
         */
        private function allowMulAdm() {
            $cIp               = $this->uTool->getClientIp();
            list($account, $n) = $this->uTool->getLoggedInUserInfo();

            $isAllow = false;
            $sql     = 'SELECT allow FROM allow_multiple';
            $data    = $this->db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $isAllow = $data['allow'] === '1' ? true : false;
            if (!$isAllow &&
                $this->isOnlineUser($account)) {
                $msg = "禁止多管理员同时登录. 用户[$account], 地址来自[$cIp].";
                $logParam = array(
                    'time' => time(),  'account' => $account, 'pri' => 3,
                    'act'  => 'login', 'msg'     => $msg
                );
                $this->admLog->add($logParam);
                return false;
            }
            return $isAllow;
        }

        /**
         * Check user/passwd
         */
        private function validUserAndPwd() {
            $cIp                    = $this->uTool->getClientIp();
            list($account, $passwd) = $this->uTool->getLoggedInUserInfo();
            $sql  = 'SELECT * FROM accounts ' .
                "WHERE account = '$account' AND passwd='$passwd'";
            $data = $this->db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            if (count($data) === 0 || $data === false) {
                //$_SESSION[$account]++;
                $msg = "用户名或密码错误! 用户[$account], 地址来自[$cIp].";
                $logParam = array(
                    'time' => time(),  'account' => $account, 'pri' => 3,
                    'act'  => 'login', 'msg'     => $msg
                );
                $this->admLog->add($logParam);
                return false;
            } else {
                // login successful
                session_regenerate_id();
                $this->uTool->saveUserInfo($data);
                $role = $this->uTool->getCurrentUserRoles();
                $msg = "{$role}管理员[$account]登录成功, 地址来自[$cIp].";
                $logParam = array(
                    'time' => time(), 'account' => $account, 'pri' => 5,
                    'act' => 'login', 'msg'     => $msg
                );
                $this->admLog->add($logParam);
                return true;
            }
        }

        /*
         * Validate user name and password.
         */
        public function login() {   
            if (true === $this->validUserAndPwd()) {
            } else {
                V::getInstance()->display('login/login.tpl');
            }
        }

        /*
         * Log the currently logged on user out.
         */
        public function logout() {
            $user = $this->uTool->getCurrentUserName();

            try {
                $_SESSION = array();
                setcookie(session_name(), '', time()-42000, '/');
                session_destroy();
                unset($this->uTool);
            } catch (exception $e) {
                throw new Exception("Can`t clean session:[{$e->getMessage()}]");
            }

            $cIp  = $this->uTool->getClientIp();
            $role = $this->uTool->getCurrentUserRoles();
            $msg  = "{$role}管理员[$user]退出成功, 地址来自[$cIp].";
            $logParam = array(
                'time' => time(), 'account' => $user,
                'pri'  => 5,      'act'     => 'logout',
                'msg'  => $msg
            );
            $this->admLog->add($logParam);
        }

        /*
         * Check if the user operation timed out,
         * update login time if not timeout, otherwise re-login.
         * @param $timeout Integer. unit: second.
         */
        public function chklogin($timeout = null) {
            if (!isset($timeout)) {
                $timeout = EXPIRED_TIME;
            }
            $now       = time();
            $account   = $this->uTool->getCurrentUserName();
            $loginTime = $this->uTool->getCurrentUserLogTime();

            if (empty($account) || empty($loginTime)) {
                $this->login();
                return false;
            }
            if (($now - $loginTime) > $timeout) {
                $logParam = array(
                    'time' => $now, 'account' => $account,
                    'pri'  => 5,    'act'     => 'logout',
                    'msg'  => "管理员[$account]访问超时."
                );
                $this->admLog->add($logParam);

                $this->logout();
                return false;
            }
            $_SESSION['session_time'] = time();
            return true;
        }
    }
?>
