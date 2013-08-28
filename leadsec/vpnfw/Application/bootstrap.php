<?php
    // Include common driver
    // Exception driver
    require_once(WEB_PATH . '/Lib/driver/exception.php');
    // Template engine, smarty
    require_once(WEB_PATH . '/Lib/driver/smarty.php');
    // public controller
    require_once(WEB_PATH . '/Application/Controllers/common.php');
    // public view
    require_once(WEB_PATH . '/Application/Views/common.php');

    function setLang() {
        // set time zone
        date_default_timezone_set('Asia/Chongqing');
        if (isset($_GET['lang'])) {
            $lo = $_GET['lang'];
            setcookie('web_locale', $lo, 0, '/');
            $_COOKIE['web_locale'] = $lo;
        } else if (isset($_COOKIE['web_locale'])) {
            $lo = $_COOKIE['web_locale'];
        } else {
            $lo = DEFAULT_LOCALE;
            setcookie('web_locale', $lo, 0, '/');
        }
        setlocale(LC_ALL, $lo);
        putenv('LC_ALL=' . $lo);
        setlocale(LC_CTYPE, $lo);

        bindtextdomain('message', WEB_PATH . '/Lang');
        textdomain('message');
    }
    setLang();
    include_once WEB_PATH . '/Conf/product.php';

    $loader = new Loader();
    $loader->loader();
?>
