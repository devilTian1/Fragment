function editUdpTransClientAclDialog(id) {
    var url  = 'Function/client/customized/udpTransVisit.php';
    var data = {
        editId : id
    };
    var title   = '修改UDP透明访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editUdpTransClientAclForm').valid()) {
            ajaxSubmitForm($('#editUdpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 620,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewUdpTransClientAclDialog() {
    var url   = 'Function/client/customized/udpTransVisit.php';
    var title = '管理UDP透明访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editUdpTransClientAclForm').valid()) {
            openNewUdpTransClientAclDialog();
            ajaxSubmitForm($('#editUdpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editUdpTransClientAclForm').valid()) {
            ajaxSubmitForm($('#editUdpTransClientAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 620,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delUdpTransClientAcl(id) {
    var url  = 'Function/client/customized/udpTransVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除UDP透明访问';
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

function delUdpTransClientAclDialog(id) {
    var dialog  = loadingScreen('删除UDP透明访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        delUdpTransClientAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的UDP透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchUdpTransClientAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchUdpTransClientForm_' + id), '结果');
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
    var url = 'Function/client/customized/udpTransVisit.php';
    freshTable(url, $('#udpTransVisitTable'));
    freshPagination(url, $('.pager'));
}
