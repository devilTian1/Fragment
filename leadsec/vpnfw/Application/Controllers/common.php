<?php
    class commonController {
        protected $view;
        protected $model;
        protected $loader;
        protected $controller;

        public function __construct(Loader $loader) {
            $this->model      = null;
            $this->view       = null;
            $this->loader     = $loader;
            $this->controller = $loader->getControllerClass();
        }

        protected function getModel($model=null) {
            return $this->loader->loaderModel($model)->getModelClass();
        }

        protected function getView($view=null) {
            return $this->loader->loaderView($view)->getViewClass();
        }

       /**
         * Get the returned result of execute function.
         * @param $type String. result data type.eg: 'JSON', 'string' and so on.
         * @param $index Integer. the index of returned result set. default is
         *   the first result.
         */
        public function getFilterResult($result) {
            switch($type) {
                case 'json':
                    if (!is_array($result)) {
                        $result = array($result);
                    }
                    return json_encode($result);
                default:
                    return $result;
            }
        }
    }
?>
