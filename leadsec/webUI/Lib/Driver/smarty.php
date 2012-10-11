<?php
require_once(WEB_PATH.'/Lib/thirdParty/Smarty/Smarty.class.php');

class Smarty_SIS extends Smarty {
    public function __construct() {
        parent::__construct();

        $this->setTemplateDir(WEB_PATH.'/Tpls/templates/');
        $this->setCompileDir(WEB_PATH.'/Tpls/templates_c/');
        $this->setConfigDir(WEB_PATH.'/Tpls/config/');
        $this->setCacheDir(WEB_PATH.'/Tpls/cache/');
        
        $this->debugging = DEBUG;
        $this->caching   = Smarty::CACHING_LIFETIME_CURRENT;

        //$this->left_delimiter = '<{';
        //$this->right_delimiter = '}>';
    }
}
?>
