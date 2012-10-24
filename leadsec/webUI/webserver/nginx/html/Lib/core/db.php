<?php
    require_once('exception.php');
    abstract class DB {
        static protected $db;

        abstract public function __construct($dsn);

        abstract public function query($sql);

        /**
         * insert/update/delete data
         */
        abstract public function exec($sql, $params = array());

        abstract public function getRowCount();

        abstract public function fetchAll($type = PDO::FETCH_BOTH);

    }
?>
