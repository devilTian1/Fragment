function openNewTimeGroupDialog() {
    var url   = 'Function/resConf/time/timeGroup.php';
    var title   = '定义时间组';
    var data  = {
        openNewTimeGrpDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editTimeGroupForm').valid()) {
            openNewTimeGroupDialog();
            $('#timeGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editTimeGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editTimeGroupForm').valid()) {
            $('#timeGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editTimeGroupForm'), '结果');
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
        height  : 400,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openEditTimeGroupDialog(name) {
	var url   = 'Function/resConf/time/timeGroup.php';
    var data = {
        name : name
    };
    var title   = '修改时间组';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editTimeGroupForm').valid()) {
            $('#timeGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editTimeGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 400,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delTimeGrp(name) {
    var url  = 'Function/resConf/time/timeGroup.php';
    var data = {
        delName: name
    };
    var title  = '删除时间组';
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
function openDelTimeGroupDialog(name) {
    var dialog  = loadingScreen('删除时间组');
    var buttons = {};
    buttons['Confirm'] = function() {
        delTimeGrp(name);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的时间组吗?</p>");
    dialog.setOptions(dialogParams);   
}


function freshTableAndPage() {
    var url = 'Function/resConf/time/timeGroup.php';
    freshTable(url, $('#timeGroupTable'));
}


function moveToTimeGroup() {
    $('#timeGrpMember option:selected').appendTo($('#timeGroup'));
}

function moveToTimeGrpMember() {
    $('#timeGroup option:selected').appendTo($('#timeGrpMember'));
}
