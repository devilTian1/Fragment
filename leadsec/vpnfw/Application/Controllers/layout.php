<?php
    class LayoutController extends commonController {
        
        private $level;

        public function showTab() {
            $model = $this->getModel('layout');
            $view  = $this->getView('layout');
            $model->getSpecTab();
            $view->showTab();
        }

        public function showMainContent() {
            $model = $this->getModel('layout');
            $view  = $this->getView('layout');
            $model->getInitPageData();
            $view->showMainContain();
        }
    }
?>
