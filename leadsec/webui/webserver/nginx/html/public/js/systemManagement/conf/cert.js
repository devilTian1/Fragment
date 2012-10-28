function openImportCertDialog() {
    var url  = 'Function/layout/showDialog.php';
    var data = {
        'tpl' : 'systemManagement/admin/certForm.tpl'
    };
    var title = '管理员证书';

    var buttons = {};
    buttons['Import'] = function() {
        importCert();
        updateCertTable();
        $(this).remove();
    }
    buttons['Close']  = function() {
        $(this).remove();
    }
    var dialogParams = {
        buttons : buttons,
        width   : 540,
        height  : 370
    }
    showDialogByAjax(url, data, title, dialogParams);
}

function importCert() {
    ajaxSubmitForm($('#certForm'), '结果');
}

function updateCertTable() {

}
