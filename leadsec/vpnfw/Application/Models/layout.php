<?php
    require_once WEB_PATH . '/Lib/driver/leftmenu.php';

    class LayoutModel {

        /* tabInfo */
        public $baseurl;
        public $tabs;
        public $tabinfo;

        /* initial data on the loaded page. */
        public $tpl;
        public $initData;

        public function __construct() {
            $this->tpl = '';
            $this->initData = null;
        }

        private function getNodePath() {
            if (!isset($_POST['l1'], $_POST['l2'])) {
                throw new Exception('Can`t get node name of leftmenu');
            }
            $level[] = $_POST['l1'];
            $level[] = $_POST['l2'];
            if (isset($_POST['l3'])) {
                $level[] = $_POST['l3'];
            }
            return $level;
        }

        public function getSpecTab() {
            $level = $this->getNodePath();
            list($this->tabinfo, $subMenu) =
                leftmenu::instance()->getSubMenu($level);
            if (!empty($subMenu['children'])) {
                $this->tabs    = $subMenu['children'];
                $this->baseurl = join('/', $level);
            } else {
                $this->tabs = array($subMenu);
                array_pop($level);
                $this->baseurl = join('/', $level);
            }
        }

        public function getInitPageData() {
            $this->tpl = $_POST['tpl'];
            $path      = substr($this->tpl, 0, -4); // rm '.tpl' suffix
            try {
                require_once WEB_PATH . "/Application/Models/$path.php";
                $className = ucfirst(array_pop(explode('/', $path))) .'Model';
                $model     = new $className();
                $this->initData = $model->getInitPageData();
            } catch (Exception $e) {
                $msg = 'Can`t get the page initialization info.' .
                    "[{$e->getMessage()}]";
                throw new Exception($msg);
            }
        }
    }
?>
