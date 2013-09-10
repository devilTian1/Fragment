<?php
    class BasicController extends commonController{
        
    	public function initTable() {
            $this->model->indata=$this->model->getInitTable();
			$this->view->showTable();
        }
        
        public function openNewDialog(){
            $this->view->showNewDialog();
        }
        
        public function openAdvSearchDialog(){
        	 $this->view->showSimpleAdvSearchDialog();
        }
        
    	public function freshTableAndPagination() {
            $this->model->tablePageData=$this->model->freshTableAndPagination();
            $this->model->indata=$this->model->tablePageData['initTable'];
            $this->model->initData=$this->model->tablePageData['initData'];
            $this->view->showTableAndPagination();
        }
    	public function batchDel() {
            $this->model->batchDel();
            $this->view->showMsg();
        }
    }
?>
