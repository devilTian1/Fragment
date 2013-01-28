function openNewFileSyncDialog() {
    var url   = 'Function/server/fileSync/fileSync.php';
    var title = '管理文件同步';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editFileSyncServerAclForm').valid()) {
            openNewFileSyncDialog();
            ajaxSubmitForm($('#editFileSyncServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editFileSyncServerAclForm').valid()) {
            ajaxSubmitForm($('#editFileSyncServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 550,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function editFileSyncServerAclDialog(id) {
    var url   = 'Function/server/fileSync/fileSync.php';
    var title = '管理文件同步';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editFileSyncServerAclForm').valid()) {
            ajaxSubmitForm($('#editFileSyncServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 550,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delFileSyncServerAcl(id) {
    var url  = 'Function/server/fileSync/fileSync.php';
    var data = {
        delId: id
    };
    var title   = '删除服务端文件交换';
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

function delFileSyncServerAclDialog(id) {
    var dialog  = loadingScreen('删除服务端文件同步');
    var buttons = {};
    buttons['Confirm'] = function() {
        delFileSyncServerAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的服务端文件同步任务吗?</p>");
    dialog.setOptions(dialogParams);   
}

function toggleCNameDiv() {
    if ($("input:radio[name='ssl']:checked").val() === 'Y') {
        $(".cNameDiv").show();
    } else { //N
        $(".cNameDiv").hide();
    }
}

function freshTableAndPage() {
    var url = 'Function/server/fileSync/fileSync.php';
    freshTable(url, $('#fileSyncTable'));
    freshPagination(url, $('.pager'));
}
