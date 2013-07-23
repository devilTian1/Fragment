<?php
    require_once WEB_PATH . '/Lib/driver/leftmenu.php';
    require_once WEB_PATH . '/Application/Models/common.php';

    class LayoutModel {

        /* tabInfo */
        public $level;
        public $tabs;
        public $tabinfo;

        /* initial data on the loaded page. */
        public $tpl;
        public $initData;

        public function __construct() {
            $this->tpl = '';
            $this->initData = null;
            $this->initData = 'TODO';
        }

        private function getNodePath() {
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
            $this->getNodePath();
            list($this->tabinfo, $subMenu) =
                leftmenu::instance()->sort()->getSubMenu($this->level);
            if (!empty($subMenu['children'])) {
                $this->tabs = $subMenu['children'];
            } else {
                $this->tabs = array($subMenu);
                if (isset($subMenu['title'])) {
                    $this->tabinfo = $subMenu['title'];
                }
            }
        }

        public function getInitData() {
            $this->tpl = $_POST['tpl'];
            $tpl = substr($this->tpl, 0, -4); // rm '.tpl' suffix
            $classMap = array(
                //'statusMonitor/systemStatus/statusPanal' =>
                //    array('function', 'Class')
            );
            if (!empty($classMap[$tpl])) {
                list($function, $class) = $classMap[$tpl];
                try {
                    require_once WEB_PATH . "/Application/Models/$class.php";
                    $className = $class . 'Model';
                    $model     = new $className();
                    $this->initData = $model->$function();
                } catch (Exception $e) {
                    $msg = 'Can`t get the page initialization info.' .
                        "[{$e->getMessage()}]";
                    throw new Exception($msg);
                }
            }
        }
    }
?>
