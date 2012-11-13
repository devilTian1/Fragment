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
            countUnchecked($('.roles'));
            ajaxSubmitForm($('#editAddrListForm'), '结果');
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
    var data  = {
        tpl : 'resConf/addr/editAddrDialog.tpl'
    };
    var title   = '定义地址';
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAddrListForm').valid()) {
            openNewAccountDialog();
            ajaxSubmitForm($('#editAddrListForm'), '结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAddrListForm').valid()) {
            ajaxSubmitForm($('#editAddrListForm'), '结果');
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
