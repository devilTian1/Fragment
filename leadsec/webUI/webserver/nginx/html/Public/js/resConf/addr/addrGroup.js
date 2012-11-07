function openEditAddrGroupDialog(id) {
    var url  = 'Function/resConf/addr/addrGroup.php';
    var data = {
        tpl : 'resConf/addr/editAddrGroupDialog.tpl',
        id  : id   
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
        height  : 500,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewAddrGroupDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title   = '定义地址';
    var data  = {
        tpl : 'resConf/addr/editAddrGroupDialog.tpl'
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
        height  : 500,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
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
