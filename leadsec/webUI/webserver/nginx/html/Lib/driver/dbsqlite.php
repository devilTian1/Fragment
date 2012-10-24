<?php
    require_once(WEB_PATH . '/Lib/core/db.php');

    /**
     *
     */
    class dbsqlite extends DB {
        // PDOStatement
        private $st;
        
        public function __construct($path) {
            if (!file_exists($path)) {
                throw new DBException('No dsn');
            }
            $dsn = "sqlite:$path";
            if (empty(self::$db)) {
                try {
                    self::$db = new PDO($dsn);
                    self::$db->beginTransaction();
                    self::$db->query("SET NAMES 'utf8'");
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
                return self::$db->query($sql);
            } catch (DBException $e) {
                throw new DBException('Database problem: ' . $e->getMessage(), 0);
            } 
        }

        private function commit() {
            self::$db->commit();
        }
        private function rollback() {
            self::$db->rollback();
        }
        
        /**
         * Use for insert/update/delete cmd
         *@return .Int. The number of modified rows.
         */
        public function exec($sql, $params = array()) {
            // check whether only one sql or multi-rows sql cmd
            try {
                if (!empty($params)) {
                    $this->st = self::$db->prepare($sql);
                    $this->st->execute($params);
                    $rowCount = $this->st->rowCount();
                } else {
                    $rowCount = self::$db->exec($sql);
                }
                $this->commit();
                return $rowCount;
            } catch (DBException $e) {
                $this->rollback();
                throw new DBException('Database problem: ' . $e->getMessage(), 0);
            }
        }

        public function fetchAll($type = PDO::FETCH_BOTH) {
            try {
                return $this->st->fetchAll($type);
            } catch (DBException $e) {
                throw new DBException('Database problem: ' . $e->getMessage(), 0);
            } 
        }

        public function getRowCount() {
            return count($this->fetchAll());   
        }

    }
?>
