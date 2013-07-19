<?php
    class User {
        private $name;
        private $loginTime;

        public function __construct() {
            if (isset($_SESSION['account'])) {
                $this->name = $_SESSION['account'];
            } else {
                $this->name = NULL;
            }
            if (isset($_SESSION['session_time'])) {
                $this->loginTime = $_SESSION['session_time'];
            } else {
                $this->loginTime = 0;
            }
        }

        public function setCurrentUserName($newName) {
            $this->name = $newName;
        }

        public function getCurrentUserName() {
            return $this->name;
        }

        public function getCurrentUserLogTime() {
            return $this->loginTime;
        }

        public function getLoggedInUserInfo() {
            $account = @$_POST['account'];
            $passwd  = @$_POST['passwd'];
            return array($account, $passwd);
        }

        public function getCurrentUserRoles($glue = '/') {
            $result = array();
            if (array_search('super', $_SESSION['roles']) !== false) {
                return '超级';
            }
            if (array_search('manager', $_SESSION['roles']) !== false) {
                $result[] = '配置';
            }
            if (array_search('policyer', $_SESSION['roles']) !== false) {
                $result[] = '策略';
            }
            if (array_search('auditor', $_SESSION['roles']) !== false) {
                $result[] = '日志';
            }
            return join($glue, $result);
        }

        public function saveUserInfo($userData) {
            $roles = array();
            if ($userData['super'] === '1') {
                $roles[] = 'super';
            }
            if ($userData['manager'] === '1') {
                $roles[] = 'manager';
            }
            if ($userData['policyer'] === '1') {
                $roles[] = 'policyer';
            }
            if ($userData['auditor'] === '1') {
                $roles[] = 'auditor';
            }
            $account  = $userData['account'];

            $_SESSION['account']      = $account;
            $_SESSION['roles']        = $roles;
            $_SESSION['session_time'] = time();
        }

        public function getClientIp() {
            if (getenv('HTTP_CLIENT_IP') &&
                strcasecmp(getenv('HTTP_CLIENT_IP'), 'unknown')) {
                $ip = getenv('HTTP_CLIENT_IP');
            } else if(getenv('HTTP_X_FORWARDED_FOR') &&
                strcasecmp(getenv('HTTP_X_FORWARDED_FOR'), 'unknown')) {
                $ip = getenv('HTTP_X_FORWARDED_FOR');
            } else if (getenv('REMOTE_ADDR') &&
                strcasecmp(getenv('REMOTE_ADDR'), 'unknown')) {
                $ip = getenv('REMOTE_ADDR');
            } else if (isset($_SERVER ['REMOTE_ADDR']) &&
                $_SERVER ['REMOTE_ADDR'] &&
                strcasecmp($_SERVER ['REMOTE_ADDR'], 'unknown')) {
                $ip = $_SERVER ['REMOTE_ADDR'];
            } else {
                $ip = 'unknown';
            }
            return $ip;
        }

        public function isOnlineUser($account) {
            return true;
        } 

    }
?>
