<?php
    class commonView {
        protected $model;

        public function __construct(Loader $loader) {
            $this->model = $loader->getModelClass();
        }

        public function showConfSuccess() {
            echo json_encode(array('msg' => '修改成功。'));
        }
        
        protected function showSimpleTpl($tpl) {
			V::getInstance()->display($tpl);
        }

        protected function getSimpleTpl($tpl) {
			return V::getInstance()->fetch($tpl);
        }
        
        public function showSimpleAdvSearchDialog() {
            $html = $this->getSimpleTpl($this->model->advSearchTpl);
            echo json_encode(array('msg' => $html));
        }

        public function showTable() {
            $msg = array('tableHtml' => $this->model->tableHtml);
            echo json_encode(array('msg' => $msg));
        }

        public function showTableAndPagination() {
            $msg = array('tableHtml' => $this->model->tableHtml,
                         'pagerHtml' => $this->model->pagerHtml);
            echo json_encode(array('msg' => $msg));
        }

		/**
		 * Show public parameter of Model, [$msg]
		 */
		public function showMsg() {
			$msg = $this->model->msg;
			if (is_string($msg)) {
				echo json_encode(array('msg'=>$msg));
			} elseif (is_array($msg)) {
				echo json_encode($msg);
			}
		}
    }
?>
