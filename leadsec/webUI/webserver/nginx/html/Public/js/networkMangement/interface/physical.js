function openEditPhysicalDialog(external_name) {
    var url  = 'Function/networkMangement/interface/physical.php';
    var data = {
        tpl    : 'networkMangement/interface/editPhysicalDialog.tpl',
        name : external_name
    };
    var title   = '修改物理设备';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editPhysicalForm').valid()) {
            ajaxSubmitForm($('#editPhysicalForm'), '结果');
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

function switchPhysicalDev(name, action, formId) {
    var title   = '启动/停止物理设备';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchPhyDevForm' + '_' + formId), '结果');
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
    dialog.setContent('<p>确定' + str + '设备[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/networkMangement/interface/physical.php';
    freshTable(url, $('#physicalTable'));
    freshPagination(url, $('.pager'));
}
