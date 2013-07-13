<?php
    // Load Global Conf Param
    require_once dirname(__file__) . '/../' . '/Conf/global.php';


    function setLang() {
        // set time zone
        date_default_timezone_set('Asia/chongqing');
        if ($_COOKIE['web_locale']) {
            $lo = $_COOKIE['web_locale'];
        } else {
            $lo = DEFAULT_LOCALE;
            $_COOKIE['web_locale'] = $lo;
        }
        setlocale(LC_CTYPE, DEFAULT_LOCALE);
        setcookie('web_locale', $lo, 0, "/");

        list($lang, $null) = explode('.', $lo, 2);
        $moFile = WEB_PATH . "/Lang/$lang/message.mo";
    }
    setLang();


    new Loader();

?>
