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

        $smarty->compile_check = true;
        $smarty->force_compile = false;

        $smarty->debugging = DEBUG;
        $smarty->caching = Smarty::CACHING_OFF;

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
