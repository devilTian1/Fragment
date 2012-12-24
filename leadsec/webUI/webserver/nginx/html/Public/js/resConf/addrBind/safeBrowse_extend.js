function openEditDialog(id) {
    var url  = 'Function/resConf/addrBind/safeBrowse_extend.php';
    var data = {
        tpl    : 'resConf/addrBind/safeBrowse_extend_editDialog.tpl',
        editId : id
    };
    var title   = '修改扩展名';
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
        height  : 340,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewDialog() {
    var url   = 'Function/resConf/addrBind/safeBrowse_extend.php';
    var title = '添加扩展名';
    var data  = {
        tpl : 'resConf/addrBind/safeBrowse_extend_editDialog.tpl',
		openDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editForm').valid()) {
            openNewDialog();
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
        height  : 340,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(name) {
    var url  = 'Function/resConf/addrBind/safeBrowse_extend.php';
    var data = {
        delName: name
    };
    var title  = '删除扩展名';
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

function openDelDialog(name) {
    var dialog  = loadingScreen('删除扩展名');
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
    dialog.setContent("<p>确定要删除名称为" + name + "的扩展名吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/resConf/addrBind/safeBrowse_extend.php';
    freshTable(url, $('#safeBrowse_extendTable'));
    freshPagination(url, $('.pager'));
}