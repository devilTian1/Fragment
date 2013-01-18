function openEditDVUserDialog(id) {
    var url  = 'Function/server/db/db.php';
    var data = {
        tpl    : 'server/db/db_editDialog.tpl',
        editId : id
    };
    var title   = '修改普通访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#serverEditForm').valid()) {
            ajaxSubmitForm($('#serverEditForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 430,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDbDialog() {
    var url   = 'Function/server/db/db.php';
    var title = '添加普通访问';
    var data  = {
        tpl : 'server/db/db_editDialog.tpl',
		openDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#serverEditForm').valid()) {
            openDbDialog();
            ajaxSubmitForm($('#serverEditForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#serverEditForm').valid()) {
            ajaxSubmitForm($('#serverEditForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 430,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(id) {
    var url  = 'Function/server/db/db.php';
    var data = {
        delId: id
    };
    var title  = '删除普通访问';
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

function openDelDVUserDialog(id) {
    var dialog  = loadingScreen('删除普通访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        del(id);
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
    dialog.setContent("<p>确定要删除名称为" + id + "的普通访问吗?</p>");
    dialog.setOptions(dialogParams);   
}
function switchClientCommSer(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchServerCommSer_' + id), '结果');
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
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}
function freshTableAndPage() {
    var url = 'Function/server/db/db.php';
    freshTable(url, $('#serverDbIdTable'));
    freshPagination(url, $('.pager'));
}
