function editAllowedFileDialog(id) {
    var url   = 'Function/client/fileEx/allowedFile.php';
    var title = '文件名控制';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editAllowedFileForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAllowedFileForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 395,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','395')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAllowedFile(id, name) {
    var url  = 'Function/client/fileEx/allowedFile.php';
    var data = {
        delId: id,
        delName:name
    };
    var title  = '删除文件名控制';
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

function delAllowedFileDialog(id, name) {
    var dialog  = loadingScreen('删除客户端文件交换');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAllowedFile(id, name);
        freshTableAndPage();
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
    dialog.setContent("<p>确定要删除名称为" + name + "的文件名控制吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewAllowedFileDialog() {
    var url   = 'Function/client/fileEx/allowedFile.php';
    var title = '文件名控制';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editAllowedFileForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            openNewAllowedFileDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAllowedFileForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editAllowedFileForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAllowedFileForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 395,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','395')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function moveToFileNames() {
    var val          = $('#filename').val();
    var filenamesDom = $('#filenames');
    var isValid = $('#editAllowedFileForm').validate().element('#filename');
    if (!isValid) {
        return false;
    }
    $('#filename').val('');
    if (val === '') {
        return false;
    }
    var isExisted = false;
    filenamesDom.find('option').each(function() {
        if ($(this).val() === val) {
            isExisted = true;
            return false;
        }
    });
    if (!isExisted) {
        $('<option title="' + val +'" value="' + val + '">' + val + '</option>')
            .appendTo(filenamesDom);
    }
}

function rmFileName() {
    var selectedDom = $('#filenames option:selected');
    if (selectedDom.length === 0 ) {
        showErrorDialog(getMessage('请选择要删除的文件名。'));
        return false;
    } else {
        selectedDom.remove();
    }
}

function freshTableAndPage() {
    var url = 'Function/client/fileEx/allowedFile.php';
    freshTable(url, $('#allowedFileTable'));
    freshPagination(url, $('.pager'));
}
