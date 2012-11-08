function setExpiredTime(time) {
    var isValid = validateForm($("#expTimeForm"));
    if (!isValid) {
        return false;
    }
    ajaxSubmitForm($('#expTimeForm'), '设置超时时间');
}

function openNewAccountDialog() {
    var url   = 'Function/layout/showDialog.php';
    var data  = {
        tpl : 'systemManagement/admin/editAccountDialog.tpl'
    };
    var title   = '添加管理员帐号';
    var buttons = {};
    buttons['添加下一条'] = function() {
        openNewAccountDialog();
        ajaxSubmitForm($('#editAccountForm'), '结果');
        $(this).remove();
    };
    buttons['确定'] = function() {
        ajaxSubmitForm($('#editAccountForm'), '结果');
        $(this).remove();
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
    function checkRoles() {
        if (!$('#confAdmin').attr('checked') && !$('#confAdmin').attr('checked') && !$('#confAdmin').attr('checked')) {
            alert('check!');
        }
    }
function openEditUserDialog(user) {
    var url  = 'Function/systemManagement/admin/account.php';
    var data = {
        tpl      : 'systemManagement/admin/editAccountDialog.tpl',
        editUser : user
    };
    var title   = '修改管理员帐号';
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#editAccountForm'), '结果');
        $(this).remove();
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

function delUser(user) {
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

function openDelUserDialog(user) {
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

function switchMultiAdm(s) {
    var url    = 'Function/systemManagement/admin/account.php';
    var data   = { 
        multiAdm : s
    };
    var title  = '结果';
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

function multiAdm(switchDom) {
    var s = (switchDom.attr('checked') === 'checked') ? 'on' : 'off';
    if (s === 'on') {
        var dialog  = loadingScreen('确认');
        var buttons = {};
        buttons['确认'] = function() {
            switchMultiAdm('on');
            dialog.close();
        };
        buttons['取消'] = function() {
            switchDom.removeAttr('checked')
            dialog.close();
        };
        dialogParams = {
            width: 400,
            height: 230,
            buttons: buttons
        }
        dialog.setOptions(dialogParams);
        var content = '<p>在多个管理员同时修改配置时,可能导致冲突. </p>'+
            '<p>不推荐使用这种管理方式.</p><p>您真的要这样做吗</p>';
        dialog.setContent(content);
    } else {
        switchMultiAdm('off');
    }
}