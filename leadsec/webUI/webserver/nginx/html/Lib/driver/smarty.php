<?php
require_once(WEB_PATH.'/Lib/thirdParty/Smarty/Smarty.class.php');

class V extends Smarty {
    static public $instance;

    public function __construct() {
        parent::__construct();

        $this->setTemplateDir(WEB_PATH.'/Tpls/templates/');
        $this->setCompileDir(WEB_PATH.'/Tpls/templates_c/');
        $this->setConfigDir(WEB_PATH.'/Tpls/config/');
        $this->setCacheDir(WEB_PATH.'/Tpls/cache/');
        
        $this->debugging = DEBUG;
        $this->caching = Smarty::CACHING_OFF;
        //$this->caching   = Smarty::CACHING_LIFETIME_CURRENT;
        $this->cache_lifetime = 60*60*24;

        //$this->left_delimiter = '<{';
        //$this->right_delimiter = '}>';
    }
    public function getInstance() {
        if (!isset(self::$instance)) {
            self::$instance = new self();
        }
        return self::$instance;
    }
}
?>
