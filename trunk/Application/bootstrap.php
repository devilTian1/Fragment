<?php
    // Include common driver
    // Exception driver
    require_once(WEB_PATH . '/Lib/driver/exception.php');
    // Template engine, smarty
    require_once(WEB_PATH . '/Lib/driver/smarty.php');
    // core controller
    require_once(WEB_PATH . '/Application/Controllers/common.php');

    function setLang() {
        // set time zone
        date_default_timezone_set('Asia/chongqing');
        if (isset($_COOKIE['web_locale'])) {
            $lo = $_COOKIE['web_locale'];
        } else {
            $lo = DEFAULT_LOCALE;
            $_COOKIE['web_locale'] = $lo;
        }
        if (isset($_GET['lang'])) {
            setlocale(LC_ALL, '');
        } else {
            setlocale(LC_ALL, DEFAULT_LOCALE);
        }
        putenv('LC_ALL=' . DEFAULT_LOCALE);
        setlocale(LC_CTYPE, DEFAULT_LOCALE);
        setcookie('web_locale', $lo, 0, '/');

        bindtextdomain('message', WEB_PATH . '/Lang');
        textdomain('message');
    }
    setLang();

    $loader = new Loader();
    $loader->loaderController(0);
?>
