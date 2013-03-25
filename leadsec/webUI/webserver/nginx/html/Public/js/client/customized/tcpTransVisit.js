function editTcpTransClientAclDialog(id) {
    var url  = 'Function/client/customized/tcpTransVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改TCP透明访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editTcpTransClientAclForm').valid()) {
            ajaxSubmitForm($('#editTcpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 435,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewTcpTransClientAclDialog() {
    var url   = 'Function/client/customized/tcpTransVisit.php';
    var title = '管理TCP透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editTcpTransClientAclForm').valid()) {
            openNewTcpTransClientAclDialog();
            ajaxSubmitForm($('#editTcpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editTcpTransClientAclForm').valid()) {
            ajaxSubmitForm($('#editTcpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 435,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delTcpTransClientAcl(id) {
    var url  = 'Function/client/customized/tcpTransVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除TCP透明访问';
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

function delTcpTransClientAclDialog(id) {
    var dialog  = loadingScreen('删除TCP透明访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        delTcpTransClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的TCP透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchTcpTransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchTcpTransClientForm_' + id), '结果');
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
    var saOpts  = $('select[name="sa"]');
    var daOpts  = $('select[name="da"]');
    saOpts.find('option[value$="_ipv6"]').hideOption();
    daOpts.find('option[value$="_ipv6"]').hideOption();
}

function freshTableAndPage() {
    var url = 'Function/client/customized/tcpTransVisit.php';
    freshTable(url, $('#tcpTransVisitTable'));
    freshPagination(url, $('.pager'));
}