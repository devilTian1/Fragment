function openNewTimeGroupDialog() {
    var url   = 'Function/resConf/time/timeGroup.php';
    var title   = '定义时间组';
    var data  = {
        openNewTimeGrpDialog: true
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
    		if ($('#editTimeGroupForm').valid()) {
    			openNewTimeGroupDialog();
                $('#timeGrpMember option').attr('selected', 'selected');
                var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editTimeGroupForm'), '结果', undefined,
                        undefined, afterSuccessCallback);
                $(this).remove();
            }
    	}else{
    		showErrorDialog('名称首位请填写字母。');
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
    		if ($('#editTimeGroupForm').valid()) {
                $('#timeGrpMember option').attr('selected', 'selected');
                var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editTimeGroupForm'), '结果', undefined,
                        undefined, afterSuccessCallback);
                $(this).remove();
            }
    	}else{
    		showErrorDialog('名称首位请填写字母。');
    	}        
    };
    buttons[getMessage('Cancel')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 370,
        buttons : buttons,
        position: jQuery.getDialogPosition(620,370)
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
    buttons[getMessage('Ok')] = function() {
        if ($('#editTimeGroupForm').valid()) {
            $('#timeGrpMember option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editTimeGroupForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 370,
        buttons : buttons,
        position: jQuery.getDialogPosition(620,170)
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
function openDelTimeGroupDialog(name) {
    var dialog  = loadingScreen('删除时间组');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delTimeGrp(name);
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
    dialog.setContent("<p>确定要删除名称为" + name + "的时间组吗?</p>");
    dialog.setOptions(dialogParams);   
}


function freshTableAndPage() {
    var url = 'Function/resConf/time/timeGroup.php';
    freshTable(url, $('#timeGroupTable'));
    freshPagination(url, $('.pager'));
}


function moveToTimeGroup() {
    $('#timeGrpMember option:selected').appendTo($('#timeGroup'));
}

function moveToTimeGrpMember() {
    $('#timeGroup option:selected').appendTo($('#timeGrpMember'));
}
