<?php
    header('Content-type: text/html; charset=utf-8');
    setlocale(LC_CTYPE, 'zh_CN.utf8');
    setcookie('web_locale', 'zh_CN.utf8', 0, "/");
    // set exception handler
    function exceptionHandler($e) {
        echo json_encode(array('msg' => $e->getMessage()));
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
        $cmd = '/usr/local/sbin/manufact produce ' .
            $_FILES['manuFile']['name'];
        $cli = new cli();
        list($status, $lines) = $cli->setIsRec(false)->execCmdGetStatus($cmd);
        if ($status == 0) {
            $msg = 'success';
        } else {
            $msg = join('<br/>', $lines);
        }
    } else if (!empty($_POST['download'])) {
        // Export manufact result
        header('Content-Type:download-force');
        header("Content-Disposition: attachment; filename=manufact_result.txt");
        readfile('/tmp/manufact_result');
        return true;
    } else if (!empty($_POST['reboot'])) {
        // reboot device
        $cli = new cli();
        $cli->setIsRec(false)->run('reboot -f');
        return;
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
        <meta http-equiv="charset" content="UTF8"/>
        <link rel='stylesheet' media='screen' type='text/css' href='Public/manufacture/default/css/base.css'/>
        <link rel='stylesheet' media='screen' type='text/css' href='Public/manufacture/default/css/form.css'/>
        <link rel='stylesheet' media='screen' type='text/css' href='Public/manufacture/default/css/link.css'/>
        <link rel="stylesheet" href="Public/js/jquery/smoothness/jquery-ui-1.8.23.custom.css" type="text/css" />
    </head>
    <body>
        <div class="wrapper">
            <!-- HEADER -->
            <div class="header">
                <!-- title & right logo -->
                <div class="float_right top_nav">
                    <div class="float_right toolbar_r">
                    </div>
                </div>
                <br class="clear_float"/>
            </div>

	        <!-- CONTENT -->
            <div class="content">
                <div class="secondary">
                </div>
                <!-- main content -->
                <div class="primary">
                    <div class="tab">
                    </div>
                    <!-- inner page -->
                    <div class="innerPage">
                        <fieldset>
                            <legend><?php echo PRODUCT_NAME;?>&nbsp;生产</legend>
                            <div class="row">
                                <label>软件版本号 :</label>
                                <label><?php echo $version?></label>
                            </div>
                            <br class="clear_float"/>
                            <?php if('success' !== $msg) {?>
                            <em style="color:red;font-weight:bold"><?php echo $msg?></em>
                            <form method="POST" id="uploadManuFileForm" enctype="multipart/form-data">
                            <div class="row">
                                <label for="manuFile">配置文件 :</label>
                                    <input class='uploadFile' type="file" name="manuFile" id="manuFile"/>
                                </form>
                            </div>
                            <br class="clear_float"/>
                            <div class="row">
                                <label>&nbsp;</label>
                                <button class="standard float_left" type="submit" onClick="uploadConfFile()" id="manuBtn">
                                    开始生产</button>
                            </div>
                            </form>
                            <?}?>
                            <br class="clear_float"/>
                            <?php if('success' === $msg) {?>
                            <div class="row">
                                <label>&nbsp;</label>
                                <form style="display:inline" method="POST" id="uploadManuFileForm" enctype="multipart/form-data">
                                    <input type="hidden" name="download" value="1"/>
                                    <button class="standard float_left" style="position: static" type="submit">
                                        导出生产结果文件</button>
                                </form>
                                <form style="display:inline" method="POST" id="rebootForm">
                                    <input type="hidden" name="reboot" value="1"/>
                                    <button class="standard float_left" style="position: static" type="submit">
                                        重启设备</button>
                                </form>
                            </div>
                            <?}?>
                        </fieldset>
                    </div>
                </div>
                <br class="clear_float"/>
            </div>

            <!-- FOOTER -->
            <div class="footer">
                <label>@ 2010-2020 <?php echo COMPANY_NAME;?>版权所有</label>
            </div>
        </div>
    </body>
</html>
<script type="text/javascript" src="Public/js/jquery/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery-ui-1.8.23.custom.min.js"></script>
<script type="text/javascript" src="Public/js/jquery/jquery.validate.min.js"></script>
<!-- Put our libraries next -->
<script type="text/javascript" src="Public/js/common.js"></script>
<script type="text/javascript" src="Public/js/localize.js"></script>
<script type="text/javascript" src="Public/js/ui.standard.js"></script>
<script type="text/javascript" src="Public/js/validation.js"></script>

<script type="text/javascript">
    if ('<?echo $msg?>' === 'success') {
        var dialog = loadingScreen('结果');
        dialog.setContent('<p>生产成功.</p>');
        var buttons = {};
        buttons['关闭'] = function() {
            dialog.close();
        }
        dialog.setOptions({
            buttons: buttons
        });
    }
    $(document).ready(function() {
        renderStandardUi();
        validateForm($('#uploadManuFileForm'));
    });
    function uploadConfFile() {
        if ($('#uploadManuFileForm').valid() === false) {
            $('#uploadManuFileForm').submit(function() {
                return false
            });
        } else {
            var dialog = loadingScreen('');
            $('#uploadManuFileForm').submit();
        }
    }
</script>
