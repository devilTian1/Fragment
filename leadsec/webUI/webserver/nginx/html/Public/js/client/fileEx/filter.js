function editFilterDialog(id) {
    var url   = 'Function/client/fileEx/filter.php';
    var title = '';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editFilterForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            ajaxSubmitForm($('#editFilterForm'), '结果');
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

function delFilter(id) {
    var url  = 'Function/client/fileEx/filter.php';
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

function delFilterDialog(id, name) {
    var dialog  = loadingScreen('删除文件属性控制');
    var buttons = {};
    buttons['Confirm'] = function() {
        delFilter(id);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的过滤选项吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewFilterDialog() {
    var url   = 'Function/client/fileEx/filter.php';
    var title = '过滤选项集配置';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editFilterForm').valid()) {
            openNewFilterDialog();
            ajaxSubmitForm($('#editFilterForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editFilterForm').valid()) {
            ajaxSubmitForm($('#editFilterForm'), '结果');
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

function freshTableAndPage() {
    var url = 'Function/client/fileEx/filter.php';
    freshTable(url, $('#filterTable'));
    freshPagination(url, $('.pager'));
}
