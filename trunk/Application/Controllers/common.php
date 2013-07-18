<?php
    class commonController {

        public function __construct(Loader $loader) {
            if (!empty($_REQUEST['R'])) {
                // check whether the user timout.
                $loader = $loader->loaderModel(array('login', 'chklogin'));
                if ($loader->getResult('default', 0)) {
                    $loader->loaderController()->loaderAllModel();
                } else {

                }
            } else {
                $loader->loaderController()->loaderAllModel();
            }
        }

       /**
         * Get the returned result of execute function.
         * @param $type String. result data type.eg: 'JSON', 'string' and so on.
         * @param $index Integer. the index of returned result set. default is
         *   the first result.
         */
        public function getResult($type = 'json', $index = 0) {
            switch($type) {
                case 'json':
                    $result = $this->result[$index];
                    if (!is_array($result)) {
                        $result = array($result);
                    }
                    return json_encode($result);
                default:
                    return $this->result[$index];
            }
        }

    }
?>
