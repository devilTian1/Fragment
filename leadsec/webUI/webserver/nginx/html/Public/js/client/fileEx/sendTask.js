function editSendTaskDialog(id) {
    var url   = 'Function/client/fileEx/sendTask.php';
    var title = '编辑任务';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editSendTaskForm').valid()) {
            ajaxSubmitForm($('#editSendTaskForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 600,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delSendTask(id) {
    var url  = 'Function/client/fileEx/sendTask.php';
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
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delSendTaskDialog(id) {
    var dialog  = loadingScreen('删除发送任务');
    var buttons = {};
    buttons['Confirm'] = function() {
        delSendTask(id);
        freshTableAndPage();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除任务号为" + id + "的发送任务?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewSendTaskDialog() {
    var url   = 'Function/client/fileEx/sendTask.php';
    var title = '配置任务';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editSendTaskForm').valid()) {
            openNewSendTaskDialog();
            ajaxSubmitForm($('#editSendTaskForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editSendTaskForm').valid()) {
            ajaxSubmitForm($('#editSendTaskForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 600,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function switchSendMethod() {
    $('div.changenameDiv').show();
    var fs = $('input:radio[name="sendMethod"]:checked').val();
    if (fs !== 'C') {
        $('div.changenameDiv').hide();
    }
}

function switchFs() {
    $('div.smbDiv').show();
    var fs = $('input:radio[name="fs"]:checked').val();
    $('input[name="portReq"]').val(445);
    if (fs !== 'smbfs') {
        $('input[name="portReq"]').val(2049);
        $('div.smbDiv').hide();
    }
}

function switchSendTaskAcl(id, action) {
    var title   = '启动/停止发送任务';

    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchSendTaskForm_' + id), '结果');
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

function filterRes() {
    var lipOpts = $('select[name="lip"]');
    lipOpts.find('option[value*=":"]').hideOption();
}

function freshTableAndPage() {
    var url = 'Function/client/fileEx/sendTask.php';
    freshTable(url, $('#sendTaskTable'));
    freshPagination(url, $('.pager'));
}
