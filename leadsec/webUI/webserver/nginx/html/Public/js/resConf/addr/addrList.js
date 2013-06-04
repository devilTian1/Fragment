function openEditAddrListDialog(id) {
    var url  = 'Function/resConf/addr/addrList.php';
    var data = {
        addrId  : id   
    };
    var title   = '修改地址';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editAddrListForm').valid()) {
            addOrEditAddrList('edit', title);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 325,
        buttons : buttons,
        position : jQuery.getDialogPosition('620','325')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function addOrEditAddrList(type, title) {
    if (type === 'next') {
        openNewAddrListDialog();
    }
    var afterSuccessCallback = function() {
        freshTableAndPage();
    };
    ajaxSubmitForm($('#editAddrListForm'), '结果', undefined,
        undefined, afterSuccessCallback);
}

function openNewAddrListDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title   = '定义地址';
    var data  = {
        tpl : 'resConf/addr/editAddrDialog.tpl'
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editAddrListForm').valid()) {
            addOrEditAddrList('next', title);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editAddrListForm').valid()) {
            addOrEditAddrList('add', title);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 325,
        buttons : buttons,
        position : jQuery.getDialogPosition('620','325')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAddr(name, id) {
    var url  = 'Function/resConf/addr/addrList.php';
    var data = {
        delName: name,
        delId: id
    };
    var title  = '删除地址';
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

function openDelAddrDialog(name, id) {
    var dialog  = loadingScreen('删除地址');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAddr(name, id);
        $(this).remove();
        freshTableAndPage();
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
    dialog.setContent("<p>确定要删除名称为" + name + "的地址吗?</p>");
    dialog.setOptions(dialogParams);   
}

function changeAddrType() {
    var checkedDom = $(":radio[name='addrType']:checked");
    var type       = checkedDom.val();
    var addrDiv    = $('#addrDiv, input[name="ip"], input[name="netmask"]');
    var rangeDiv   = $('#rangeDiv, input[name^="range_"]');
    addrDiv.addClass('hide');
    rangeDiv.addClass('hide');
    var saveName = $("input[name='addrName']").val();
    var saveComment = $("input[name='comment']").val();
    $("#editAddrListForm").validate().resetForm();
    if('add' == $("input[name='type']").val()) {
        $("input[name='addrName']").val(saveName);    
        $("input[name='comment']").val(saveComment);    
    }
    $("input[name='addrName']").val(saveName);
    checkedDom.attr('checked', 'checked');
    if (type === 'range') {
        rangeDiv.removeClass('hide');
    } else { // default
        addrDiv.removeClass('hide');
    }
}

function freshTableAndPage() {
    var url = 'Function/resConf/addr/addrList.php';
    freshTable(url, $('#addrTable'));
    freshPagination(url, $('.pager'));
}
