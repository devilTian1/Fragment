function openEditAddrGroupDialog(id) {
    var url  = 'Function/resConf/addr/addrGroup.php';
    var data = {
        tpl    : 'resConf/addr/editAddrGroupDialog.tpl',
        editId : id
    };
    var title   = '修改地址组';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAddrGroupForm').valid()) {
            $('#addrGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAddrGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 550,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewAddrGroupDialog() {
    var url   = 'Function/resConf/addr/addrGroup.php';
    var title = '定义地址组';
    var data  = {
        tpl : 'resConf/addr/editAddrGroupDialog.tpl',
        openAddAddrGrpDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAddrGroupForm').valid()) {
            openNewAddrGroupDialog();
            $('#addrGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAddrGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAddrGroupForm').valid()) {
            $('#addrGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAddrGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 550,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAddrGrp(name,id) {
    var url  = 'Function/resConf/addr/addrGroup.php';
    var data = {
        delName: name,
        delId: id
    };
    var title  = '删除地址组';
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

function openDelAddrGroupDialog(name,id) {
    var dialog  = loadingScreen('删除地址组');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAddrGrp(name,id);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的地址组吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/resConf/addr/addrGroup.php';
    freshTable(url, $('#addrGroupTable'));
    freshPagination(url, $('.pager'));
}

function moveToAddrList() {
    $('#addrGrpMember option:selected').appendTo($('#addrList'));
}

function moveToAddrGrpMember() {
    $('#addrList option:selected').appendTo($('#addrGrpMember'));
}
