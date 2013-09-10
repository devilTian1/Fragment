<?php
    class PhysicalController extends commonController {
        
        public function __construct(Loader $loader) {
			parent::__construct($loader);
			$this->model = $this->getModel();
			$this->view  = $this->getView();
		}
        
        public function showTable() {
            $this->model->getTableData();
            $this->view->showTable();
        }

        public function switchPhysicalDev() {
            $this->model->setPhysicalDevActive();
            $this->view->showMsg();
        }
        
        public function getSpecDataByName() {
            $this->model->getSpecPhysicalData();
            $this->view->showSpecPhysicalDialog();
        }
        
        public function setSpecPhysicalDev() {
            $this->model->setSpecifiedPhysicalDev();
            $this->view->showMsg();
        }
        
        public function batchStop() {
            $this->model->setBatchStopCmd();
            $this->view->showMsg();
        }
        
        public function openAdvSearchDialog() {
            $this->view->showSimpleAdvSearchDialog();
        }
        
        public function freshTableAndPagination() {
            $this->model->freshTableAndPagination();
            $this->view->showTableAndPagination();
        }
        
        public function bandWidthDetect() {
            $this->model->getBandWidth();
        }
    }
?>
