function openEditOptionsDialog(id) {
    var url  = 'Function/client/db/optionsFilter.php';
    var data = {
        tpl    : 'resConf/client/db/optionsFilter_editDialog.tpl',
        editId : id
    };
    var title   = '修改过滤选项';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 277,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewOptionsDialog() {
    var url   = 'Function/client/db/optionsFilter.php';
    var title = '添加过滤选项';
    var data  = {
		openDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editForm').valid()) {
        	openNewOptionsDialog();
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 277,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(name) {
    var url  = 'Function/client/db/optionsFilter.php';
    var data = {
        delName: name
    };
    var title  = '删除过滤选项';
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

function openDelOptionsDialog(name) {
    var dialog  = loadingScreen('删除过滤选项');
    var buttons = {};
    buttons['Confirm'] = function() {
        del(name);
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
    dialog.setContent("<p>确定要删除序号为" + name + "的过滤选项吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/client/db/optionsFilter.php';
    freshTable(url, $('#dataVisit_optionsTable'));
    freshPagination(url, $('.pager'));
}