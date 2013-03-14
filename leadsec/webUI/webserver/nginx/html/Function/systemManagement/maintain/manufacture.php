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
        $result = V::getInstance()->assign('msg', '生产成功.')
            ->fetch('systemManagement/maintain/manuResult.tpl');
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['download'])) {
        // Export manufact result
        header('Content-Type:download-force');
        header("Content-Disposition: attachment; filename=manufact_result.txt");
        readfile('/tmp/manufact_result');
    } else {
        // init page data
        $db = new dbsqlite(DB_PATH . '/private.db');
        $result = $db->query("SELECT up_version FROM upgrade_history ORDER BY up_time DESC")
                     ->getFirstData(PDO::FETCH_ASSOC);
        V::getInstance()->assign('lastestVersion', $result['up_version']);
    }
?>
