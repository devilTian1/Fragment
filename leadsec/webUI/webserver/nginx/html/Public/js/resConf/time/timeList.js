function openNewTimeListDialog() {
    var url   = 'Function/resConf/time/timeList.php';
    var title   = '时间列表';
    var data  = {
    	openDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editTimeListForm').valid()) {
            openNewTimeListDialog();
            ajaxSubmitForm($('#editTimeListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editTimeListForm').valid()) {
            ajaxSubmitForm($('#editTimeListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 405,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openEditTimeListDialog(name) {
    var url  = 'Function/resConf/time/timeList.php';
    var data = {
        editName : name   
    };
    var title   = '修改时间列表';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editTimeListForm').valid()) {
            ajaxSubmitForm($('#editTimeListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 405,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delTime(name) {
    var url  = 'Function/resConf/time/timeList.php';
    var data = {
        delName: name
    };
    var title  = '删除时间列表';
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

function openDelTimeListDialog(name) {
    var dialog  = loadingScreen('删除时间列表');
    var buttons = {};
    buttons['Confirm'] = function() {
        delTime(name);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的时间数据吗?</p>");
    dialog.setOptions(dialogParams);   
}

function changeScheduleType() {
    var scheduleType = $(':radio[name="scheduleType"]:checked').val();
    if ('oneTime' === scheduleType) {
        $('.oneTimeDiv').show();
        $('.weekDiv').hide();
    } else {
        //week
        $('.oneTimeDiv').hide();
        $('.weekDiv').show();
    }
}

function freshTableAndPage() {
    var url = 'Function/resConf/time/timeList.php';
    freshTable(url, $('#timeListTable'));
    freshPagination(url, $('.pager'));
}
