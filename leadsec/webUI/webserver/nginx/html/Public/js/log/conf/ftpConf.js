function ftpTransBtn() {
    if($('#ftpTransForm').valid()){
        ajaxSubmitForm($('#ftpTransForm'), '设置FTP相关配置 ');
    }
}
function logTransBtn() {
    if($('#logTransForm').valid()){
        ajaxSubmitForm($('#logTransForm'), '设置自动上传日志 ');
    }
}
function logTransAllrightBtn() {
    var dialog  = loadingScreen('立即上传日志');
    var buttons = {};
    buttons['Confirm'] = function() {
    	download();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要立即上传日志吗?</p>");
    dialog.setOptions(dialogParams);   
}

function download() {
    var url  = 'Function/log/conf/ftpConf.php?log=1';
    var data = {
    	logTrans : true
    };
    var title  = '立即上传日志';
    var buttons = {};
    buttons['Ok'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
