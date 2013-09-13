function openEditOrAddDialog(type, title, data) {
    var url =
        'index.php?R=firewall/service/basic/openAddOrEditBasicListDialog';
    var buttons = {};
    var afterSuccessCallback = function() {
        $('#basicTable').trigger('sorton', [[[2,0]]]);
        initPagerCss($('div.pager'));
        removeAdvSearchData();
        freshTableAndPage();
    };
    if (type === 'add') {
        buttons['添加下一条'] = function() {
            if ($('#editBasicListForm').valid()) {
                openEditOrAddDialog(type, title, data);
                ajaxSubmitForm($('#editBasicListForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
                $(this).remove();
            }
        };
    }
    buttons['确定'] = function() {
        if ($('#editBasicListForm').valid()) {
            ajaxSubmitForm($('#editBasicListForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width    : 800,
        height   : 525,
        position : jQuery.getDialogPosition('800','525'),
        buttons  : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewBasicListDialog() {
    var title = '添加服务';
    var data = {
        isAdd : true
    };
    openEditOrAddDialog('add', title, data);
} 

function openEditBasicListDialog(id) {
    var title = '编辑服务';
    var data = {
        isEdit : true,
        id     : id
        
    }
    openEditOrAddDialog('edit', title, data);
}

function delBasic(name) {
    var url  = 'index.php?R=firewall/service/basic/delSpecBasic';
    var data = {
        delName: name
    };
    var ajaxParams = {
        dataType: 'JSON',
        type: 'POST',
        complete: function(result) {
            afterSucessBatchDel();
        }
    };
    loadAjax(url, data, ajaxParams);
}

function openDelBasicListDialog(name) {
    var dialog  = loadingScreen('删除服务');
    var buttons = {};
    buttons['确定'] = function() {
        delBasicess(name);
        dialog.close();
    };
    buttons['取消']  = function() {
        dialog.close();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除" + name + "吗？</p>");
    dialog.setOptions(dialogParams);
}

function freshTableAndPage() {
    var url = 'index.php?R=firewall/service/basic/freshTableAndPagination';
	freshTableAndPagination(url);
}

function afterSucessBatchDel() {
    $('#basicTable').trigger('sorton', [[[2,0]]]);
    initPagerCss($('div.pager'));
    removeAdvSearchData();
    freshTableAndPage();
}
