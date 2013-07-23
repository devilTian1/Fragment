function editBannedContentDialog(id) {
    var url   = 'Function/client/fileEx/bannedContent.php';
    var title = '内容黑名单';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editBannedContentForm').valid()) {
            $('#bflist option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editBannedContentForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 505,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','505')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delBannedContent(id, name) {
    var url  = 'Function/client/fileEx/bannedContent.php';
    var data = {
        delId: id,
        delName:name
    };
    var title  = '删除内容黑名单';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
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

function delBannedContentDialog(id, name) {
    var dialog  = loadingScreen('删除客户端文件交换');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delBannedContent(id, name);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
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
    buttons[getMessage('Add Next')] = function() {
        if ($('#editBannedContentForm').valid()) {
            $('#bflist option').attr('selected', 'selected');
            openNewBannedContentDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editBannedContentForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editBannedContentForm').valid()) {
            $('#bflist option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editBannedContentForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 505,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','505')
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
        showErrorDialog(getMessage('请选择要删除的内容。'));
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
