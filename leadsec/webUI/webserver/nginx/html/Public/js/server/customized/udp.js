function editUdpCommServerAclDialog(id) {
    var url  = 'Function/server/customized/udp.php';
    var data = {
        editId : id
    };
    var title   = '修改UDP普通访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editUdpCommServerAclForm').valid()) {
            ajaxSubmitForm($('#editUdpCommServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 330,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewUdpCommServerAclDialog() {
    var url   = 'Function/server/customized/udp.php';
    var title = '添加UDP普通访问';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editUdpCommServerAclForm').valid()) {
            openNewUdpCommServerAclDialog();
            ajaxSubmitForm($('#editUdpCommServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editUdpCommServerAclForm').valid()) {
            ajaxSubmitForm($('#editUdpCommServerAclForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 330,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delUdpCommServerAcl(id) {
    var url  = 'Function/server/customized/udp.php';
    var data = {
        delId: id
    };
    var title  = '删除UDP普通访问';
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

function delUdpCommServerAclDialog(id) {
    var dialog  = loadingScreen('删除UDP普通访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        delUdpCommServerAcl(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的UDP普通访问吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchUdpCommServerAcl(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchUdpCommServerForm_' + id), '结果');
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
    var url = 'Function/server/customized/udp.php';
    freshTable(url, $('#udpCommServerTable'));
    freshPagination(url, $('.pager'));
}
