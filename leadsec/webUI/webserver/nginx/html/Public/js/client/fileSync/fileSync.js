function openNewFileSyncDialog() {
    var url   = 'Function/client/fileSync/fileSync.php';
    var title = '管理文件同步';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editFileSyncClientAclForm').valid()) {
            openNewFileSyncDialog();
            ajaxSubmitForm($('#editFileSyncClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editFileSyncClientAclForm').valid()) {
            ajaxSubmitForm($('#editFileSyncClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 485,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function editFileSyncClientAclDialog(id) {
    var url   = 'Function/client/fileSync/fileSync.php';
    var title = '管理文件同步';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editFileSyncClientAclForm').valid()) {
            ajaxSubmitForm($('#editFileSyncClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 485,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delFileSyncClientAcl(id) {
    var url  = 'Function/client/fileSync/fileSync.php';
    var data = {
        delId: id
    };
    var title   = '删除客户端文件交换';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
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

function delFileSyncClientAclDialog(id) {
    var dialog  = loadingScreen('删除客户端文件同步');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delFileSyncClientAcl(id);
        freshTableAndPage();
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除任务号为" + id + "的客户端文件同步任务吗?</p>");
    dialog.setOptions(dialogParams);   
}

function filterRes() {
    var type    = $('input:radio[name="ipType"]:checked').val();
    var saOpts  = $('select[name="sa"]');
    var lipOpts = $('select[name="fslip"]');
    saOpts.children('span').showOption(); 
    lipOpts.children('span').showOption(); 
    if (type === 'ipv4') {
        saOpts.find('option[value$="_ipv6"]').hideOption();
        lipOpts.find('option[value*=":"]').hideOption();
    } else if (type === 'ipv6') {
        saOpts.find('option[value$="_ipv4"]').hideOption();
        lipOpts.find('option[value*="."]').hideOption();
    } else {
    }
}

function toggleCNameDiv() {
    if ($("input:radio[name='ssl']:checked").val() === 'Y') {
        $(".cNameDiv").show();
    } else { //N
        $(".cNameDiv").hide();
    }
}

function freshTableAndPage() {
    var url = 'Function/client/fileSync/fileSync.php';
    freshTable(url, $('#fileSyncTable'));
    freshPagination(url, $('.pager'));
}