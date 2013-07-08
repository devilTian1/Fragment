<?php
    require_once(WEB_PATH . '/Lib/core/db.php');
    /**
     *
     */
    class dbsqlite extends DB {
        private function trace($info) {
            $file = '/tmp/webui.log';
            DEBUG && file_put_contents($file, "$info\n", FILE_APPEND | LOCK_EX);
        }

        public function __construct($path) {
            if (!file_exists($path)) {
                throw new DBException('No dsn');
            }
            if (empty(self::$db) || self::$dsn != "sqlite:$path") {
                try {
                    self::$dsn = "sqlite:$path";
                    self::$db = new PDO(self::$dsn);
                    self::$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                } catch (Exception $e) {
                    throw new DBException($e->getMessage(), $e->getCode());
                } 
            }
            $this->trace($path);
        }

        /**
         * only for 'select' sql cmd.
         */
        public function query($sql, $params = array()) {
            $this->trace($sql);
            try {
                if (!empty($params)) {
                    $st = self::$db->prepare($sql);
                    $st->execute($params);
                    $this->queryResult = $st;
                } else {
                    $this->queryResult = self::$db->query($sql);
                }
                return $this;
            } catch (Exception $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            } 
            
        }

        /**
         * Use for insert/update/delete cmd
         * @return .Int. The number of modified rows.
         */
        public function exec($sql, $params = array()) {
            $info = $sql . ' params(' . join(', ', $params) . ')';
            $this->trace($info);
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
            } catch (Exception $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function execByTransaction($sqls, $paramArr = array()) {
            $result = array();
            try {
                self::$db->beginTransaction();
                if (empty($paramArr)) {
                    foreach ($sqls as $sql) {
                        $result[] = $this->exec($sql);
                    }
                } else if (count($sqls) === 1) {
                    foreach ($paramArr as $param) {
                        $result[] = $this->exec($sqls[0], $param);
                    }
                } else {
                    foreach ($paramArr as $key => $param) {
                        $result[] = $this->exec($sqls[$key], $param);
                    }
                }
                self::$db->commit();
                return $result;
            } catch (Exception $e) {
                self::$db->rollback();
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function getAllData($type = PDO::FETCH_BOTH) {
            try {
                return $this->queryResult->fetchAll($type);
            } catch (Exception $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function getFirstData($type = PDO::FETCH_BOTH) {
            try {
                return $this->queryResult->fetch($type);
            } catch (Exception $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }
    
        public function getCount() {
            try {
                return count($this->getAllData());   
            } catch (Exception $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function getLastInsertId() {
            return self::$db->lastInsertId();
        }

        public function replaceAlp($sql, $name) {
            $replace = "REPLACE(upper($name), 'A', '')";
            foreach (array('B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
                           'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
                           'V', 'W', 'X', 'Y', 'Z') as $a) {
                $replace = 'REPLACE(' . $replace . ", '$a', '')";
            }
            $replace .= '+0';
            return str_replace($name, $replace, $sql);
        }

        public function getWhereStatement($colStr, $connect, $operator,
            $value = '?'){
            return str_replace(',', " $operator $value $connect ", $colStr) .
                " $operator $value";
        }

        public function close() {
            self::$db = NULL;
            return true;
        }
    }
?>
