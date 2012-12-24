<?php
    @session_start();
    require_once(WEB_PATH . '/Lib/core/menu.php');
    /**
     *
     */
    class leftmenu extends MENU {

        private static $instance;

        private $breadCrumbs= array();

        /**
         *
         */
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
        
        private function getCurUserRoles() {
            if (empty($_SESSION)) {
                throw new Exception('Error: invalid user. Please login.');
            }
            return $_SESSION['roles'];
        }
    
        public function sort() {
            $curUserRoles = $this->getCurUserRoles();
            foreach ( $this->menu as $key => $node ) {
                $pid = $node['pid'];
                if ( $pid !== 0 ) {
                    // hide this item for specified ban role
                    $banRolesStr = $this->menu[$key]['ban'];
                    if (!empty($banRolesStr)) {
                        $banRolesArr = array();
                        $banRolesTmp = explode(',', $banRolesStr);
                        foreach ($banRolesTmp as $r) {
                            $banRolesArr[] = trim($r);
                        }
                        $t = count(array_intersect($curUserRoles, $banRolesArr));
                        if ($t > 0) {
                            continue;
                        }
                    }
                    // add array for storing child nodes
                    if ( !isset($this->menu[$pid]['children']) ) {
                        $this->menu[$pid]['children'] = array();   
                    }
                    array_push($this->menu[$pid]['children'], &$this->menu[$key]);
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

        /**
         * According to the path, Get the sub menu.
         * @param $path Array. key: level num. value: node name
         * @return @result associated array.
         */
        public function getSubMenu($path) {
            $subMenu     = array();
            $result      = array($this->breadCrumbs, $subMenu);

            $menu        = $this->menu;
            $count       = count($path);

            foreach ($path as $level => $link) {
                foreach ($menu as $node) {
                    if ($node['link'] === $link) {
                        $this->breadCrumbs[] = $node['name'];
                        if ($count === $level) {
                            $result = array(
                                $this->getTabinfo($node['children']), $node);
                            return $result;
                        }
                        $menu = $node['children'];
                        break;
                    }
                }
            }
            return false;
        }

        /**
         * Get full bread crumbs and note
         */
        private function getTabinfo($tabs) {
            $tabinfo = array();
            $flag    = ' >> ';
            $bc      = join($flag, $this->breadCrumbs);
            if ($tabs != NULL) {
	            foreach ($tabs as $tab) {
                    $note = isset($tab['title']) ? $tab['title'] : '';
	                $tabinfo[] = array(
	                    'breadCrumbs' => $bc . $flag . $tab['name'],
	                    'note'        => $note);
	            }
            }
            return $tabinfo;
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
