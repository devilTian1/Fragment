<?php
    /**
     *
     */
    abstract class MENU {
        protected $menu;
        
        protected function __construct() {
            $this->init();
        }

        abstract protected function init();

        abstract public function getMenu();
        
        abstract public function sort();
        
        abstract public function show();
    }
?>
