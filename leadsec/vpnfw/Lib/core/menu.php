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
        
        /**
         *@param $path STR. use '/' to concat menu name of every level
         */
        abstract public function getSubMenu($path);
        
        abstract protected function sort();
        
        abstract public function show();
    }
?>
