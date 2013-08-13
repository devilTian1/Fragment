<?php
    require_once WEB_PATH . '/Application/Views/common.php';

    class LayoutView extends commonView {

        public function showTab() {
            V::getInstance()->assign('tabs', $this->model->tabs)
                ->assign('tabinfo', $this->model->tabinfo)
                ->assign('baseurl', $this->model->baseurl)
                ->display('layout/tabs.tpl');
        }
        
        public function showMainContain() {
            try {
            	//var_dump($this->model->initData);
                V::getInstance()->assign('initData', $this->model->initData)
                                ->display($this->model->tpl);
            } catch(SmartyException $e) {
                $msg = "Unable to display mainContain tpl[{$e->getMessage()}].";
                throw new Exception($msg);
            }
        }
    }
?>
