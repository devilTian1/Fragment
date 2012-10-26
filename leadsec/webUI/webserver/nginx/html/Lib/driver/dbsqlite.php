<?php
    require_once(WEB_PATH . '/Lib/core/db.php');

    /**
     *
     */
    class dbsqlite extends DB {

        public function __construct($path) {
            if (!file_exists($path)) {
                throw new DBException('No dsn');
            }
            if (empty(self::$db)) {
                try {
                    $this->dsn = "sqlite:$path";
                    self::$db = new PDO($this->dsn);
                    self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                } catch (DBException $e) {
                    throw new DBException($e->getMessage(), $e->getCode());
                } 
            }
        }

        /**
         * only for 'select' sql cmd.
         */
        public function query($sql) {
            try {
                $this->queryResult = self::$db->query($sql);
                return $this;
            } catch (DBException $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            } 
        }

        /**
         * Use for insert/update/delete cmd
         *@return .Int. The number of modified rows.
         */
        public function exec($sql, $params = array()) {
            // check whether only one sql or multi-rows sql cmd
            try {
                if (!empty($params)) {
                    // get PDO Statement
                    $st = self::$db->prepare($sql);
                    $st->execute($params);
                    $rowCount = $st->rowCount();
                } else {
                    $rowCount = self::$db->exec($sql);
                }
                return $rowCount;
            } catch (DBException $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function execByTransaction($sqls, $paramArr = array()) {
            $result = array();
            try {
                self::$db->beginTransaction();
                foreach ($sqls as $key => $sql) {
                    $result[] = $this->exec($sql, $paramArr[$key]);
                }
                self::$db->commit();
                return $result;
            } catch (DBException $e) {
                self::$db->rollback();
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function getAllData($type = PDO::FETCH_BOTH) {
            try {
                return $this->queryResult->fetchAll($type);
            } catch (DBExcetion $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function getFirstData($type = PDO::FETCH_BOTH) {
            try {
                return $this->queryResult->fetch($type);
            } catch (DBExcetion $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }
    
        public function getCount() {
            try {
                return count($this->getAllData());   
            } catch (DBExcetion $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function close() {
            self::$db = NULL;
            return true;
        }
    }
?>
