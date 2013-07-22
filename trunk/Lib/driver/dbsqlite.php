<?php
    require_once(WEB_PATH . '/Lib/core/db.php');
    /**
     *
     */
    class dbsqlite extends DB {
        private $key;

        private function trace($info) {
            $file = '/tmp/webui.log';
            DEBUG && file_put_contents($file, "$info\n", FILE_APPEND | LOCK_EX);
        }

        public function __construct($key, $path) {
            $this->key = $key;
            if (!file_exists($path)) {
                throw new DBException('No dsn');
            }
            if (empty(self::$db[$key]) || self::$dsn[$key] != "sqlite:$path") {
                try {
                    self::$dsn[$key] = "sqlite:$path";
                    self::$db[$key]  = new PDO(self::$dsn[$key]);
                    self::$db[$key]->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                } catch (Exception $e) {
                    throw new DBException($e->getMessage(), $e->getCode());
                } 
            }
            return $this;
            $this->trace($path);
        }

        public function setInstance($key, $path) {
            new dbsqlite($key, $path);
            return $this;
        }

        public function getInstance($key) {
            $this->key = $key;
            return $this;
        }

        /**
         * only for 'select' sql cmd.
         */
        public function query($sql, $params = array()) {
            $this->trace($sql);
            try {
                if (!empty($params)) {
                    $st = self::$db[$this->key]->prepare($sql);
                    $st->execute($params);
                    $this->queryResult = $st;
                } else {
                    $this->queryResult = self::$db[$this->key]->query($sql);
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
                    $st = self::$db[$this->key]->prepare($sql);
                    $st->execute($params);
                    $rowCount = $st->rowCount();
                } else {
                    $rowCount = self::$db[$this->key]->exec($sql);
                }
                return $rowCount;
            } catch (Exception $e) {
                throw new DBException('Database problem: ' . $e->getMessage());
            }
        }

        public function execByTransaction($sqls, $paramArr = array()) {
            $result = array();
            try {
                self::$db[$this->key]->beginTransaction();
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
                self::$db[$this->key]->commit();
                return $result;
            } catch (Exception $e) {
                self::$db[$this->key]->rollback();
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
            return self::$db[$this->key]->lastInsertId();
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
        
        public function getFilterParams($params) {
            $search  = array('\\"', "\\'", '%26', '%2B', '%23', '%');
            $replace = array('"',   "'",   '&',   '+',   '#' ,  '/%');
            foreach ($params as &$param) {
                $param = '%' . str_replace($search, $replace, $param) . '%';
            }
            return $params;
        }

        public function getWhereStatement($colStr, $connect, $operator,
            $value = '?'){
            return str_replace(',', " $operator $value $connect ", $colStr) .
                " $operator $value ESCAPE '/'";
        }

        public function close() {
            self::$db[$this->key] = NULL;
            return true;
        }
    }
?>
