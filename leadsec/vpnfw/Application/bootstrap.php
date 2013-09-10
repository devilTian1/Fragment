<?php
// 记载运行时所需要的文件
function loadRuntimeFile() {
    // Load system basic function library
    require WEB_PATH . '/Application/Common/common.php';

    // Exception driver
    requireCache(WEB_PATH . '/Lib/driver/exception.php');

    // Template engine, smarty
    requireCache(WEB_PATH . '/Lib/driver/smarty.php');

    // public controller
    requireCache(WEB_PATH . '/Application/Controllers/common.php');

    // public view
    requireCache(WEB_PATH . '/Application/Views/common.php');
    
    // Load language.
    setLang();
    // company and product name.
    requireCache(WEB_PATH . '/Conf/product.php');

}
// 加载运行时所需文件
loadRuntimeFile();
// 执行入口
$loader = new Loader();
$loader->loader();
?>
