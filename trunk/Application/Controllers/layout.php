<?php
    require_once WEB_PATH . '/Application/Controllers/common.php';

    class LayoutController extends commonController {
        
        private $level;

        public function showTab() {
            $this->model->getSpecTab();
            $this->view->showTab();
        }
    }
?>
