<?php
    setlocale(LC_CTYPE, 'zh_CN.utf8');
    // set exception handler
    function exceptionHandler($e) {
        echo json_encode(array('status' => -1, 'msg' => $e->getMessage()));
    }
    set_exception_handler('exceptionHandler');

    // Load Config File
    require_once('Conf/global.php');
    // Exception driver
    require_once(WEB_PATH . '/Lib/driver/exception.php');
    // CLI driver
    require_once(WEB_PATH . '/Lib/driver/cli.php');
    // upload driver
    require_once(WEB_PATH . '/Lib/driver/fileUpload.php');
    // DB driver
    require_once(WEB_PATH . '/Lib/driver/dbsqlite.php');
   
    $msg = '等待生产文件上传';
    if (!empty($_FILES['manuFile'])) {
        // Manufacturea
        // upload file
        $msg   = '生产失败.';
        $dPath = '/tmp';
        $fs    = new fileUpload($_FILES, $dPath);
        $fs->upload();
        // run cli
        $cmd = '/usr/local/sbin/manufact produce ' . $_FILES['manuFile']['name'];
        $cli = new cli();
        //$cli->run($cmd);
        $msg = 'success';
    } else if (!empty($_POST['download'])) {
        // Export manufact result
        header('Content-Type:download-force');
        header("Content-Disposition: attachment; filename=manufact_result.txt");
        readfile('/tmp/manufact_result');
        return true;
    } else {
    }
    // init page data
    $db = new dbsqlite(DB_PATH . '/private.db');
    $result = $db->query("SELECT up_version FROM upgrade_history ORDER BY up_time DESC")
                 ->getFirstData(PDO::FETCH_ASSOC);
    $version = '没有任何升级记录';
    if (false !== $result) {
        $version = $result['up_version'];
    }
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <style>
            #uploadManuFileForm {
                display: inline
            }
        </style>
    </head>
    <body>
        <table>
            <tbody>
                <tr>
                    <td>软件版本号 :</td>
                    <td><?php echo $version?></td>
                </tr>
                <tr>
                    <td>
                        配置文件:
                    </td>
                    <td>
                        <form method="POST" id="uploadManuFileForm" enctype="multipart/form-data">
                            <input type="file" name="manuFile" id="manuFile"/>
                            <button type="submit" onClick="openManuDialog()" id="manuBtn">
                                开始生产</button>
                        </form>
                    </td>
                </tr>
                <tr>
                    <td>结果:</td>
                    <td>
                        <?php if('success' === $msg) {?>
                            <form method="POST" id="uploadManuFileForm" enctype="multipart/form-data">
                                <input type="hidden" name="download" value="1"/>
                                <button type="submit">
                                    导出文件</button>
                            </form>
                        <?php } else {
                            echo $msg;
                        }?>
                    </td>
                </tr>
            </tbody>
        </table>
    </body>
</html>
<script type="text/javascript">
    function openManuDialog() {
        if (document.getElementById('manuFile').value === '') {
            alert('请选择配置文件');
            return false;
        }
    }
</script>
