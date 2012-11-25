<?php
require_once(WEB_PATH.'/Lib/thirdParty/Smarty/Smarty.class.php');

class V {
    static public $instance;

    private function __construct() {
        $smarty = new Smarty();

        $smarty->setTemplateDir(WEB_PATH.'/Tpls/templates/');
        $smarty->setCompileDir(WEB_PATH.'/Tpls/templates_c/');
        $smarty->setConfigDir(WEB_PATH.'/Tpls/config/');
        $smarty->setCacheDir(WEB_PATH.'/Tpls/cache/');
        
        $smarty->debugging = DEBUG;
        $smarty->caching = Smarty::CACHING_OFF;
        //$smarty->caching   = Smarty::CACHING_LIFETIME_CURRENT;
        $smarty->cache_lifetime = 60*60*24;

        $smarty->left_delimiter = '<{';
        $smarty->right_delimiter = '}>';
	self::$instance = $smarty;
    }

    private function __clone() {}

    public function getInstance() {
        if (!isset(self::$instance)) {
            new self();
        }
        return self::$instance;
    }
}
?>
