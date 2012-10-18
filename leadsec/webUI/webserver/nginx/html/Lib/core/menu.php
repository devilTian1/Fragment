<?php
    /**
     *
     */
    abstract class MENU {

        static protected $menu;
        
        protected function __construct($raw) {
            if (empty(self::$menu)) {
                self::$menu = $this->init($raw);
            }
            return self::$menu;
        }

        protected function init($raw) {
            // initially handle raw data
            $result = $raw;
            return $result;
        }

        abstract public function getMenu();
        
        abstract public function sort();
        
        abstract public function show();
    }
?>
