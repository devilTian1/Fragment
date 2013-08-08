<?php
    class commonView {
        protected $model;

        public function __construct(Loader $loader) {
            $this->model = $loader->getModelClass();
        }

        public function showConfSuccess() {
            echo json_encode(array('msg' => '修改成功。'));
        }
		
		/**
		 * public function for all moduels to show msg
		 */
		public function showMsg() {
			$msg = $this->model->msg;
			if(is_string($msg)){
				echo json_encode(array('msg'=>$msg));
			} elseif (is_array($msg)) {
				echo json_encode($msg);
			}
			
		}
    }
?>
