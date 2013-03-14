function openNewVirtualAddrDialog() {
    var url  = 'Function/networkManagement/virtualAddr/virtualAddr.php';
    var title   = '添加虚拟地址';
    var data  = {
        openNewVirtualAddrDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editVirtualAddrForm').valid()) {
            openNewVirtualAddrDialog();
            ajaxSubmitForm($('#editVirtualAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editVirtualAddrForm').valid()) {
            ajaxSubmitForm($('#editVirtualAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 310,
        buttons : buttons,
        position : ['center', 'top']
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
    buttons['确定'] = function() {
        if ($('#editVirtualAddrForm').valid()) {
            ajaxSubmitForm($('#editVirtualAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 310,
        buttons : buttons,
        position : ['center', 'top']
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

function openDelVirtualAddrDialog(phyDevice, ifname) {
    var dialog  = loadingScreen('删除虚拟地址');
    var buttons = {};
    buttons['Confirm'] = function() {
        delVirtualAddr(ifname);
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
    dialog.setContent("<p>确定要删除名称为" + phyDevice + "的虚拟地址吗?</p>");
    dialog.setOptions(dialogParams);   

}

function showSpecIpMask(type) {
    var addrDom = $('#addr');
    var ifname  = $('#ifname option:selected').val();
    if (type == 'change') {
        addrDom.removeSelectedOptAttr();
        addrDom.find('option:first').attr('selected', 'selected');
    }
    addrDom.children('option').not(':first').hideOption();
    if (ifname != '') {
        addrDom.find('span option[value^="' + ifname + '_"]')
            .parents('span').showOption();
    }
}

function freshTableAndPage() {
    var url = 'Function/networkManagement/virtualAddr/virtualAddr.php';
    freshTable(url, $('#virtualAddrTable'));
    freshPagination(url, $('.pager'));
}
