function editBannedContentDialog(id) {
    var url   = 'Function/client/fileEx/bannedContent.php';
    var title = '内容黑名单';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editBannedContentForm').valid()) {
            $('#bflist option').attr('selected', 'selected');
            ajaxSubmitForm($('#editBannedContentForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 375,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delBannedContent(id) {
    var url  = 'Function/client/fileEx/bannedContent.php';
    var data = {
        delId: id
    };
    var title  = '删除内容黑名单';
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

function delBannedContentDialog(id, name) {
    var dialog  = loadingScreen('删除客户端文件交换');
    var buttons = {};
    buttons['Confirm'] = function() {
        delBannedContent(id);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的内容黑名单吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewBannedContentDialog() {
    var url   = 'Function/client/fileEx/bannedContent.php';
    var title = '内容黑名单';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editBannedContentForm').valid()) {
            $('#bflist option').attr('selected', 'selected');
            openNewBannedContentDialog();
            ajaxSubmitForm($('#editBannedContentForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editBannedContentForm').valid()) {
            $('#bflist option').attr('selected', 'selected');
            ajaxSubmitForm($('#editBannedContentForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 375,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function moveToBFlist() {
    var val       = $('#FEcontext').val();
    var bflistDom = $('#bflist');
    $('#FEcontext').val('');
    if (val === '') {
        return false;
    }
    var isExisted = false;
    bflistDom.find('option').each(function() {
        if ($(this).val() === val) {
            isExisted = true;
            return false;
        }
    });
    if (!isExisted) {
        $('<option value="' + val + '">' + val + '</option>')
            .appendTo(bflistDom);
    }
}

function rmBFlist() {
    var selectedDom = $('#bflist option:selected');
    if (selectedDom.length === 0 ) {
        showErrorDialog(getMessage('请选择要删除的内容.'));
        return false;
    } else {
        selectedDom.remove();
    }
}

function freshTableAndPage() {
    var url = 'Function/client/fileEx/bannedContent.php';
    freshTable(url, $('#bannedContentTable'));
    freshPagination(url, $('.pager'));
}
