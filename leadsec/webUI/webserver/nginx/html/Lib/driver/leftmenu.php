<?php

    require_once(WEB_PATH . '/Lib/core/menu.php');
    /**
     *
     */
    class leftmenu extends MENU {

        private static $instance;

        protected function __construct() {
            require_once(WEB_PATH . '/Conf/leftmenu.php');
            parent::__construct($leftmenuArr);
        }
    
        public static function instance() {
            if (!isset(self::$instance)) {
                self::$instance = new self();
            }
            return self::$instance;
        }

        public function sort() {
            foreach ( self::$menu as $key => $node ) {
                $pid = $node['pid'];
                if ( $pid !== 0 ) {
                    // add array for storing child nodes
                    if ( !is_array(self::$menu[$pid-1]['children']) ) {
                        self::$menu[$pid-1]['children'] = array();   
                    }
                    array_push(self::$menu[$pid-1]['children'], &self::$menu[$key]);
                }
            }
            // romote non-root node
            foreach ( self::$menu as $key => $node ) {
                if ( $node['pid'] !== 0 ) {
                    unset(self::$menu[$key]);
                }
            }
            return self::$instance;
        }
        
        public function getMenu() {
            return self::$menu;
        }

        private function showMenuByUl($menu) {
            echo "<ul>";
            foreach ( $menu as $key => $root ) {
                echo "<li>{$root['name']}</li>\n";
                $children = $root['children'];
                if ( is_array( $children ) ) {
                    $this->showMenuByUl($children);
                }
            }
            echo "</ul>";
        }

        public function show() {
            $this->showMenuByUl(self::$menu);
        }
    }

?>
