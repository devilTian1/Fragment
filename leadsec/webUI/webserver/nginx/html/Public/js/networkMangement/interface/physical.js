function openEditPhysicalDialog(external_name) {
    var url  = 'Function/networkMangement/interface/physical.php';
    var data = {
        tpl    : 'networkMangement/interface/editPhysicalDialog.tpl',
        external_name : external_name
    };
    var title   = '修改物理设备';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editPhysicalForm').valid()) {
            $('#addGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editPhysicalForm'), '结果');
            //freshTableAndPage();
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

function freshTableAndPage() {
    var url = 'Function/networkMangement/interface/physical.php';
    freshTable(url, $('#physicalTable'));
    freshPagination(url, $('.pager'));
}
