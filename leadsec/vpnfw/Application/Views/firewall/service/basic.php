<?php
    requireCache(WEB_PATH . '/Application/Views/common.php');
	
	class BasicView extends commonView {

        public function openAddDialog() {
            $html = V::getInstance()->assign('type', 'add')
                ->fetch($this->model->editTpl);
            echo json_encode(array('msg' => $html));
        }

        public function openEditDialog() {
            $html = V::getInstance()->assign('type', 'edit')
                ->assign('basic', $this->model->specBasicById)
                ->fetch($this->model->editTpl);
            echo json_encode(array('msg' => $html));
        }

    }
?>		
