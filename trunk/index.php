<?php
    // Load Global Conf Param
    require_once dirname(__file__) . '/Conf/global.php';
    // Enable/Disable Development Environment
    DEBUG && error_reporting(E_ALL);

    try {
        include dirname(__file__) . '/Application/Loader.php';
        include dirname(__file__) . '/Application/bootstrap.php';
    } catch (Exception $exception) {
        if (DEBUG) {
            echo '<html><body><center>' .
                'An exception occured while bootstrapping the application.' .
                '<br /><br />' . $exception->getMessage() . '<br />' .
                '<div align="left">Stack Trace:' .
                '<pre>' . $exception->getTraceAsString() . '</pre></div>' .
                '</center></body></html>';
        } else {
            echo json_encode(array('status' => -1,
                                   'msg'    => $exception->getMessage()));
        }
        exit(1);
    }
?>
