function openNewDialog() {
    var url   = 'Function/server/dbSync/dbSync.php';
    var title = '添加数据库同步';
    var data  = {
        tpl : 'server/dbSync/dbSync_editDialog.tpl',
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
        width   : 680,
        height  : 368,
        buttons : buttons,
		position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openEditDialog(id) {
    var url  = 'Function/server/dbSync/dbSync.php';
	var title   = '修改数据库同步';
    var data = {
        editId : id
    };
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
        width   : 680,
        height  : 368,
        buttons : buttons,
		position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelDialog(id) {
    var dialog  = loadingScreen('删除数据库同步');
    var buttons = {};
    buttons['Confirm'] = function() {
        delDbSyncClient(id);
        freshTableAndPage();
		$(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
		position: ['center', 'top']
    };
    dialog.setContent("<p>确定要删除吗?</p>");
    dialog.setOptions(dialogParams);   
}

function delDbSyncClient(id) {
	var url  = 'Function/server/dbSync/dbSync.php';
    var data = {
		delId : id
    };
    var title   = '删除客户端数据库交换';
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

function toggleCNameDiv() {
    if ($("input:radio[name='ssl']:checked").val() === 'Y') {
        $(".cNameDiv").show();
    } else { 
        $(".cNameDiv").hide();
    }
}

function switchPhysicalDev(id, action, formId) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchForm_' + formId), '结果');
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
    dialog.setContent('<p>确定' + str + '任务[' + id  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}


function freshTableAndPage() {
    var url = 'Function/server/dbSync/dbSync.php';
    freshTable(url, $('#dbSyncServerTable'),'ORDER BY id ASC LIMIT 10');
    freshPagination(url, $('.pager'));
}