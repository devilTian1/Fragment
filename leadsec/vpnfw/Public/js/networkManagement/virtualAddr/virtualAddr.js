function openNewVirtualAddrDialog() {
    var url  = 'Function/networkManagement/virtualAddr/virtualAddr.php';
    var title   = '添加虚拟地址';
    var data  = {
        openNewVirtualAddrDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editVirtualAddrForm').valid()) {
            openNewVirtualAddrDialog();
            ajaxSubmitForm($('#editVirtualAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editVirtualAddrForm').valid()) {
            ajaxSubmitForm($('#editVirtualAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 310,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,310)
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openEditVirtualAddrDialog(ifname) {
    var url  = 'Function/networkManagement/virtualAddr/virtualAddr.php';
    var title   = '修改虚拟地址';
    var data  = {
        editIfName : ifname
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editVirtualAddrForm').valid()) {
            ajaxSubmitForm($('#editVirtualAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 310,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,310)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delVirtualAddr(ifname) {
    var url  = 'Function/networkManagement/virtualAddr/virtualAddr.php';
    var data = {
        delName: ifname
    };
    var title  = '删除虚拟地址';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelVirtualAddrDialog(phyDevice, ifname) {
    var dialog  = loadingScreen('删除虚拟地址');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delVirtualAddr(ifname);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除名称为[" + phyDevice + "]的虚拟地址吗?</p>");
    dialog.setOptions(dialogParams);   

}

function showSpecIpMask(type) {
    var ifname  = $('#ifname option:selected').val();
    var addrDom = $('#addr');
    if (type == 'change') {
        addrDom.find('option').removeAttr('selected');
        addrDom.find('option:first').attr('selected', 'selected');
        addrDom.find('option:gt(0)').remove();
    } else {
        addrDom.hideOption('option:gt(0)');
    }
    if (ifname != '') {
        addrDom.data('hideOpts').filter('[value^="' + ifname + '_"]')
            .appendTo(addrDom);
    }
}

function freshTableAndPage() {
    var url = 'Function/networkManagement/virtualAddr/virtualAddr.php';
    freshTable(url, $('#virtualAddrTable'));
    freshPagination(url, $('.pager'));
}
