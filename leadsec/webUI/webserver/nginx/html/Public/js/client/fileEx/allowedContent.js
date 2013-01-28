function editAllowedContentDialog(id) {
    var url   = 'Function/client/fileEx/allowedContent.php';
    var title = '内容白名单';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editAllowedContentForm').valid()) {
            $('#aflist option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAllowedContentForm'), '结果');
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

function delAllowedContent(id) {
    var url  = 'Function/client/fileEx/allowedContent.php';
    var data = {
        delId: id
    };
    var title  = '删除内容白名单';
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

function delAllowedContentDialog(id, name) {
    var dialog  = loadingScreen('删除客户端文件交换');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAllowedContent(id);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的内容白名单吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewAllowedContentDialog() {
    var url   = 'Function/client/fileEx/allowedContent.php';
    var title = '内容白名单';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editAllowedContentForm').valid()) {
            $('#aflist option').attr('selected', 'selected');
            openNewAllowedContentDialog();
            ajaxSubmitForm($('#editAllowedContentForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editAllowedContentForm').valid()) {
            $('#aflist option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAllowedContentForm'), '结果');
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

function moveToAFlist() {
    var val       = $('#FEcontext').val();
    var aflistDom = $('#aflist');
    $('#FEcontext').val('');
    if (val === '') {
        return false;
    }
    var isExisted = false;
    aflistDom.find('option').each(function() {
        if ($(this).val() === val) {
            isExisted = true;
            return false;
        }
    });
    if (!isExisted) {
        $('<option value="' + val + '">' + val + '</option>')
            .appendTo(aflistDom);
    }
}

function rmAFlist() {
    var selectedDom = $('#aflist option:selected');
    if (selectedDom.length === 0 ) {
        showErrorDialog(getMessage('请选择要删除的内容.'));
        return false;
    } else {
        selectedDom.remove();
    }
}

function freshTableAndPage() {
    var url = 'Function/client/fileEx/allowedContent.php';
    freshTable(url, $('#allowedContentTable'));
    freshPagination(url, $('.pager'));
}
