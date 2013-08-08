<?php
    class PhysicalController extends commonController {
        
        public function showTable() {
            $model = $this->getModel();
            $view  = $this->getView();
            $model->getTableData();
            $view->showTableData();
        }

        public function switchPhysicalDev() {
            $model = $this->getModel();
            $view  = $this->getView('common');
            $model -> setPhysicalDevActive();
            $view -> showMsg();
        }
        
        public function getSpecDataByName() {
            $model = $this->getModel();
            $view  = $this->getView();
            $model -> getSpecPhysicalData();
            $view -> showSpecPhysicalDialog();
        }
        
        public function setSpecPhysicalDev() {
            $model = $this->getModel();
            $view  = $this->getView('common');
            $model -> setSpecifiedPhysicalDev();
            $view -> showMsg();
        }
    }
?>
