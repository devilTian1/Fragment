function editAllowedFileDialog(id) {
    var url   = 'Function/client/fileEx/allowedFile.php';
    var title = '文件名控制';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAllowedFileForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 580,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAllowedFile(id) {
    var url  = 'Function/client/fileEx/allowedFile.php';
    var data = {
        delId: id
    };
    var title  = '删除文件名控制';
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

function delAllowedFileDialog(id, name) {
    var dialog  = loadingScreen('删除客户端文件交换');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAllowedFile(id);
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
    buttons['添加下一条'] = function() {
        if ($('#editAllowedFileForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            openNewAllowedFileDialog();
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAllowedFileForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 580,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function moveToFileNames() {
    var val          = $('#filename').val();
    var filenamesDom = $('#filenames');
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
        $('<option value="' + val + '">' + val + '</option>')
            .appendTo(filenamesDom);
    }
}

function rmFileName() {
    var selectedDom = $('#filenames option:selected');
    if (selectedDom.length === 0 ) {
        showErrorDialog(getMessage('请选择要删除的文件名.'));
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
