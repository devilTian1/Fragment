<?php
    class BasicController extends commonController {

        public function __construct(Loader $loader) {
			parent::__construct($loader);
			$this->model = $this->getModel();
			$this->view  = $this->getView();
		}

        public function openAdvSearchDialog() {
            $this->view->showSimpleAdvSearchDialog();
        }

        public function openAddOrEditBasicListDialog() {
            if ('true' === $_POST['isAdd']) {
                $this->view->openAddDialog();
            } else if ('true' === $_POST['isEdit']) {
                $this->model->getBasicById($_POST['id']);
                $this->view->openEditDialog();
            }
        }

        public function initTable() {
            $this->model->getInitTable();
            $this->view->showTable();
        }

        public function freshTableAndPagination() {
            $this->model->freshTableAndPagination();
            $this->view->showTableAndPagination();
        }

        public function addOrEditBasic() {
            if ($_POST['type'] === 'add') {
                $this->model->addNewBasic();
            } else if ($_POST['type'] === 'edit') {
                $this->model->editSpecBasic();
            }
            $this->view->showMsg();
        }

        public function delSpecBasic() {
            $this->model->delSpecBasic($_POST['delName']);
            $this->view->showMsg();
        }

        public function batchDel() {
            $this->model->batchDel();
            $this->view->showMsg();
        }

        public function uniqueBasicName() {
            $this->model->checkUniqueBasicName();
        }
    }
?>
