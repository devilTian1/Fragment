function openNewTimeListDialog() {
    var url   = 'Function/resConf/time/timeList.php';
    var title   = '时间列表';
    var data  = {
    	openDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
    	var name=$('#resTimeName').val();
    	var first = name.substring(0,1);
    	var str="abcdefghijklmnopqrstuvwxyz";
    	var str2="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    	var key=str.indexOf(first);
    	var key2=str2.indexOf(first);
    	if(key !== -1 || key2 !== -1){    		
    		if ($('#editTimeListForm').valid()) {
                ajaxSubmitForm($('#editTimeListForm'), '结果');
                freshTableAndPage();
                $(this).remove();
            }
    	}else{
    		showErrorDialog('名称首位请填写字母');
    	}           
    };
    buttons[getMessage('Ok')] = function() {
    	var name=$('#resTimeName').val();
    	var first = name.substring(0,1);
    	var str="abcdefghijklmnopqrstuvwxyz";
    	var str2="ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    	var key=str.indexOf(first);
    	var key2=str2.indexOf(first);
    	if(key !== -1 || key2 !== -1){    		
    		if ($('#editTimeListForm').valid()) {
                ajaxSubmitForm($('#editTimeListForm'), '结果');
                freshTableAndPage();
                $(this).remove();
            }
    	}else{
    		showErrorDialog('名称首位请填写字母');
    	}        
    };
    buttons[getMessage('Cancel')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 405,
        buttons : buttons,
        position: jQuery.getDialogPosition(620,405)
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
    buttons[getMessage('Ok')] = function() {
        if ($('#editTimeListForm').valid()) {
            ajaxSubmitForm($('#editTimeListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 405,
        buttons : buttons,
        position: jQuery.getDialogPosition(620,405)
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
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
} 

function openDelTimeListDialog(name) {
    var dialog  = loadingScreen('删除时间列表');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delTime(name);
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
        position: jQuery.getDialogPosition(300,160)
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
