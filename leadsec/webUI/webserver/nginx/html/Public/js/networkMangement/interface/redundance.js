function openEditRedundanceDevDialog(external_name) {
    var url  = 'Function/networkMangement/interface/redundance.php';
    var data = {
        tpl  : 'networkMangement/interface/editRedundanceDialog.tpl',
        name : external_name
    };
    var title   = '修改冗余设备';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRedundanceForm').valid()) {
            $('#external_name').removeAttr('disabled');
            $('#addrMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editRedundanceForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 780,
        height  : 550,
        buttons : buttons,
        position : ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewRedundanceDevDialog() {
    var url   = 'Function/networkMangement/interface/redundance.php';
    var title = '添加冗余设备';
    var data  = {
        tpl : 'networkMangement/interface/editRedundanceDialog.tpl',
        openNewRedundanceDevDialog : true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editRedundanceForm').valid()) {
            $('#addrMember option').attr('selected', 'selected');
            openNewRedundanceDevDialog();
            ajaxSubmitForm($('#editRedundanceForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editRedundanceForm').valid()) {
            $('#addrMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editRedundanceForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 700,
        height  : 520,
        buttons : buttons,
        position : ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delRedundanceDev(name) {
    var url  = 'Function/networkMangement/interface/redundance.php';
    var data = {
        delName: name
    };
    var title  = '删除冗余设备';
    var buttons = {};
    buttons['Ok'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelRedundanceDevDialog(name) {
    var dialog  = loadingScreen('删除冗余设备');
    var buttons = {};
    buttons['Confirm'] = function() {
        delRedundanceDev(name);
        $(this).remove();
        freshTableAndPage();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的冗余设备吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchRedundanceDev(name, action, formId) {
    var title   = '启动/停止冗余设备';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchRedundanceDevForm_' + formId), '结果');
        freshTableAndPage();
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '冗余设备[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function moveToAddrMember() {
    $('#addrList option:selected').appendTo($('#addrMember'));
}

function moveToAddrList() {
    $('#addrMember option:selected').appendTo($('#addrList'));
}

function freshTableAndPage() {
    var url = 'Function/networkMangement/interface/redundance.php';
    freshTable(url, $('#redundanceTable'));
    freshPagination(url, $('.pager'));
}
