<?php

    require_once(WEB_PATH . '/Lib/core/menu.php');
    /**
     *
     */
    class leftmenu extends MENU {

        private static $instance;

        protected function __construct() {
            parent::__construct();
        }
    
        public static function instance() {
            if (!isset(self::$instance)) {
                self::$instance = new self();
            }
            return self::$instance;
        }

        protected function init() {
            require_once(WEB_PATH . '/Conf/leftmenu.php');
            $this->menu = $leftmenuArr;
        }

        public function sort() {
            foreach ( $this->menu as $key => $node ) {
                $pid = $node['pid'];
                if ( $pid !== 0 ) {
                    // add array for storing child nodes
                    if ( !is_array($this->menu[$pid-1]['children']) ) {
                        $this->menu[$pid-1]['children'] = array();   
                    }
                    array_push($this->menu[$pid-1]['children'], &$this->menu[$key]);
                }
            }
            // romote non-root node
            foreach ( $this->menu as $key => $node ) {
                if ( $node['pid'] !== 0 ) {
                    unset($this->menu[$key]);
                }
            }
            return self::$instance;
        }
        
        public function getMenu() {
            return $this->menu;
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
            $this->showMenuByUl($this->menu);
        }
    }

?>
