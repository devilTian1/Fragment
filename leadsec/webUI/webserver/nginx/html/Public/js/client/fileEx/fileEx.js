function openFileExDialog() {
    var url   = 'Function/layout/showDialog.php';
    var data  = {
        tpl : 'client/fileEx/fileEx_editDialog.tpl'
    };
    var title   = '信息添加';
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editForm').valid()) {
            openNewSFUrlDialog();
            ajaxSubmitForm($('#editForm'), '结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 640,
        height  : 440,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
 
function openEditDVUserDialog(user) {
    var url  = 'Function/systemManagement/admin/account.php';
    var data = {
        tpl      : 'systemManagement/admin/editAccountDialog.tpl',
        editUser : user
    };
    var title   = '修改管理员帐号';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAccountForm').valid()) {
            countUnchecked($('.roles'));
            ajaxSubmitForm($('#editAccountForm'), '结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 540,
        height  : 380,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delDVUser(user) {
    var url    = 'Function/systemManagement/admin/account.php';
    var data   = { delUser : user };
    var title  = 'Delete User';
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

function openDelDVUserDialog(user) {
    var dialog  = loadingScreen('delete account');
    var buttons = {};
    buttons['Confirm'] = function() {
        delUser(user);
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 200,
        buttons: buttons
    };
    dialog.setContent("<p>Do you confirm to delete account [" + user + "]</p>");
    dialog.setOptions(dialogParams);
}