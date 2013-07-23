<?php
    require_once WEB_PATH . '/Application/Views/common.php';

    class LayoutView extends commonView {

        public function showTab() {
            V::getInstance()->assign('tabs', $this->model->tabs)
                ->assign('tabinfo', $this->model->tabinfo)
                ->assign('baseurl', join('/', $this->model->level))
                //->assign('modStat', getCurModStat($path))
                ->display('layout/tabs.tpl');
        }   
    }
?>
