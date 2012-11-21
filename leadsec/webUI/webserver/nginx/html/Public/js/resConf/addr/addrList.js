function openEditAddrListDialog(id) {
    var url  = 'Function/resConf/addr/addrList.php';
    var data = {
        tpl : 'resConf/addr/editAddrDialog.tpl',
        id  : id   
    };
    var title   = '修改地址';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAddrListForm').valid()) {
            ajaxSubmitForm($('#editAddrListForm'), '结果');
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

function openNewAddrListDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title   = '定义地址';
    var data  = {
        tpl : 'resConf/addr/editAddrDialog.tpl'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAddrListForm').valid()) {
            openNewAddrListDialog();
            ajaxSubmitForm($('#editAddrListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAddrListForm').valid()) {
            ajaxSubmitForm($('#editAddrListForm'), '结果');
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

function delAddr(name) {
    var url  = 'Function/resConf/addr/addrList.php';
    var data = {
        delName: name
    };
    var title  = '删除地址';
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

function openDelAddrDialog(name) {
    var dialog  = loadingScreen('删除地址');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAddr(name);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的地址吗?</p>");
    dialog.setOptions(dialogParams);   
}

function changeAddrType() {
    var type      = $(":radio[name='addrType']:checked").val();
    var addrDiv   = $('#addrDiv');
    var addr_rDiv = $('#addr_rDiv');
    var rangeDiv  = $('#rangeDiv');
    addrDiv.hide();
    addr_rDiv.hide();
    rangeDiv.hide();
    if (type === 'reverse') {
        addr_rDiv.show();
    } else if (type === 'range') {
        rangeDiv.show();
    } else { // default
        addrDiv.show();
    }
}

function freshAddrTable() {
    var url  = 'Function/resConf/addr/addrList.php';
    var data = {
        freshAddrList: true
    };
    var params = {
        success : function(result, textStatus) {
            $('#addrTable>tbody').html(result);
            $('#addrTable').trigger("update", [true]);
        }
    };
    loadEmbedPage(url, data, $('#addrTable>tbody'), params);
}

function freshTableAndPage() {
    var url = 'Function/resConf/addr/addrList.php';
    resortTable(url, $('#addrTable'));
    freshPagination(url, $('.pager'));
}

