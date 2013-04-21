function editReceiveTaskDialog(id) {
    var url   = 'Function/server/fileEx/receiveTask.php';
    var title = '编辑任务';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editReceiveTaskForm').valid()) {
            ajaxSubmitForm($('#editReceiveTaskForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 400,
        buttons : buttons,
        position : jQuery.getDialogPosition('600','400')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delReceiveTask(id) {
    var url  = 'Function/server/fileEx/receiveTask.php';
    var data = {
        delId: id
    };
    var title  = '结果';
    var buttons = {};
    buttons['Ok'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delReceiveTaskDialog(id) {
    var dialog  = loadingScreen('删除接收任务');
    var buttons = {};
    buttons['Confirm'] = function() {
        delReceiveTask(id);
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
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除任务号为" + id + "的接收任务?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewReceiveTaskDialog() {
    var url   = 'Function/server/fileEx/receiveTask.php';
    var title = '配置任务';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editReceiveTaskForm').valid()) {
            openNewReceiveTaskDialog();
            ajaxSubmitForm($('#editReceiveTaskForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editReceiveTaskForm').valid()) {
            ajaxSubmitForm($('#editReceiveTaskForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 400,
        buttons : buttons,
        position : jQuery.getDialogPosition('600','400')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function switchFs() {
    $('div.smbDiv').show();
    var fs = $('input:radio[name="fs"]:checked').val();
    $('input[name="portReq"]').val(445);
    if (fs !== 'smbfs') {
        $('div.smbDiv').hide();
        $('input[name="portReq"]').val(2049);
    }
}

function switchReceiveTaskAcl(id, action) {
    var title   = '启动/停止接收任务';

    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchReceiveTaskForm_' + id), '结果');
        freshTableAndPage();
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function filterRes() {
    var lipOpts = $('select[name="lip"]');
    lipOpts.hideOption('option[value*=":"]');
}

function freshTableAndPage() {
    var url = 'Function/server/fileEx/receiveTask.php';
    freshTable(url, $('#receiveTaskTable'));
    freshPagination(url, $('.pager'));
}
