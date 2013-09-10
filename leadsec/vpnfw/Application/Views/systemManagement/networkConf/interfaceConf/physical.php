<?php
    require_once WEB_PATH . '/Application/Views/common.php';

    class PhysicalView extends commonView {
        
        public function showSpecPhysicalDialog() {
            $tpl = 'systemManagement/networkConf/interfaceConf/editPhysicalDialog.tpl';
            $result = V::getInstance()->assign('res', $this->model->indata)
                                ->assign('comment', $this->model->comment)
                                ->assign('antiARP', $this->model->antiARP)
                                ->assign('ipConflict', $this->model->ipConflict)
                                 ->assign('speedBuf', $this->model->speedBuf)
                                ->fetch($tpl);
            echo json_encode(array('msg' => $result));
        }
    }
?>
