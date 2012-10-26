<?php
    abstract class DB {
        protected $dsn;

        static protected $db;

        private $queryResult = '';

        abstract public function __construct($dsn);

        /**
         * only for select query data
         */
        abstract public function query($sql);

        /**
         * insert/update/delete data
         */
        abstract public function exec($sql, $params = array());
        
        abstract public function getAllData($type = PDO::FETCH_BOTH);

        abstract public function getFirstData($type = PDO::FETCH_BOTH);

        abstract public function getCount();
        
        /**
         * close database connection
         */
        abstract public function close();
    }
?>
