<?php
    require_once WEB_PATH . '/Application/Views/common.php';

    class commonView {
        protected $model;

        public function __construct(Loader $loader) {
            $this->model = $loader->getModelClass();
        }
    }
?>
