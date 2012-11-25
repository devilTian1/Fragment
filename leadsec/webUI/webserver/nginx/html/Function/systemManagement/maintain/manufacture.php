<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    if (!empty($_FILES['manuFile'])) {
        // Manufacture
        $dPath = '/tmp';
        $fs    = new fileUpload($_FILES, $dPath);
        $fs->upload();

        $cmd = 'manufact produce ' . $_FILES['manuFile']['name'];
        $cli = new cli();
        //$cli->run($cmd);
        $result = V::getInstance()->assign('msg', '成功.')
            ->fetch('systemManagement/maintain/manuResult.tpl');
        echo json_encode(array('msg' => $result));
    } else if ('export' === $_GET['action']) {
        // Export manufact result
        echo 'lalla';
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/private.db');
        $result = $db->query("SELECT up_version FROM upgrade_history ORDER BY up_time DESC")
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('lastestVersion', $result['up_version']);
    }
?>
