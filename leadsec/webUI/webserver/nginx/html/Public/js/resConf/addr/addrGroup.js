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
        buttons : buttons
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
            ajaxSubmitForm($('#editAddrGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAddrGroupForm').valid()) {
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
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAddrGrp(name) {
    var url  = 'Function/resConf/addr/addrGroup.php';
    var data = {
        delName: name
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

function openDelAddrGroupDialog(name) {
    var dialog  = loadingScreen('删除地址组');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAddrGrp(name);
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
    resortTable(url, $('#addrGroupTable'));
    freshPagination(url, $('.pager'));
}

function appendAddrGroupData() {
    var url  = 'Function/resConf/addr/addrGroup.php';
    var data = {
        freshAddrGroup: true
    };
    var params = {
        success : function(result, textStatus) {
            $('#addrGroupTable>tbody').html(result);
            $('#addrGroupTable').trigger("update", [true]);
        }
    };
    loadEmbedPage(url, data, $('#addrGroupTable>tbody'), params);
}

function moveToAddrList() {
    $('#addrGrpMember option:selected').appendTo($('#addrList'));
}

function moveToAddrGrpMember() {
    $('#addrList option:selected').appendTo($('#addrGrpMember'));
}
