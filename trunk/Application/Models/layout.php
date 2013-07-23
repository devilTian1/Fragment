<?php
    require_once(WEB_PATH . '/Lib/driver/leftmenu.php');

    class LayoutModel {

        public $level;
        public $tabs;
        public $tabinfo;

        public function __construct() {
            if (!isset($_POST['l1'], $_POST['l2'])) {
                throw new Exception('Can`t get node name of leftmenu');
            }
            $this->level[] = $_POST['l1'];
            $this->level[] = $_POST['l2'];
            if (isset($_POST['l3'])) {
                $this->level[] = $_POST['l3'];
            }
        }

        public function getSpecTab() {
            list($this->tabinfo, $subMenu) =
                leftmenu::instance()->sort()->getSubMenu($this->level);
            $this->tabs = $subMenu['children'];
            if (count($this->tabs) === 0) {
                $this->tabs = array($subMenu);
                $this->tabinfo = $subMenu['title'];
            }
        }
    }
?>
