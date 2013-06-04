function isInUseCheck(external_name,func) {
    var url  = 'Function/networkManagement/interface/redundance.php';
    var data = {
        isInUseCheck  : true,
        checkName : external_name
    };
        var params = {        
			type    : 'GET',        
			success : function(result) {           
				if (result == 'true') {               
					OpenTipsDialog(external_name);          
				} else {               
					func(external_name);          
				}     
			}   
		};        
    loadAjax(url, data, params);
}

function OpenTipsDialog(external_name) {
    var title   = '提示';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['关闭'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        Height: 160,
        buttons: buttons,       
		position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent('<p>冗余设备[' + external_name  + ']正被引用，不能修改或删除此别名。</p>');
    dialog.setOptions(dialogParams);
}

function openEditRedundanceDevDialog(external_name) {
    var url  = 'Function/networkManagement/interface/redundance.php';
    var data = {
        tpl  : 'networkManagement/interface/editRedundanceDialog.tpl',
        name : external_name
    };
    var title   = '修改冗余设备';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRedundanceForm').valid()) {
            $('#external_name').removeAttr('disabled');
            $('#addrMember option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRedundanceForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 780,
        height  : 550,
        buttons : buttons,
        position : jQuery.getDialogPosition('780','550')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewRedundanceDevDialog() {
    var url   = 'Function/networkManagement/interface/redundance.php';
    var title = '添加冗余设备';
    var data  = {
        tpl : 'networkManagement/interface/editRedundanceDialog.tpl',
        openNewRedundanceDevDialog : true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editRedundanceForm').valid()) {
            $('#addrMember option').attr('selected', 'selected');
            openNewRedundanceDevDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRedundanceForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editRedundanceForm').valid()) {
            $('#addrMember option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRedundanceForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 700,
        height  : 520,
        buttons : buttons,
        position : jQuery.getDialogPosition('700','520')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delRedundanceDev(name) {
    var url  = 'Function/networkManagement/interface/redundance.php';
    var data = {
        delName: name
    };
    var title  = '删除冗余设备';
    var buttons = {};
    buttons['关闭'] = function() {
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

function openDelRedundanceDevDialog(name) {
    var dialog  = loadingScreen('删除冗余设备');
    var buttons = {};
    buttons['确定'] = function() {
        delRedundanceDev(name);
        $(this).remove();
        freshTableAndPage();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,       
		position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的冗余设备吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchRedundanceDev(name, action, formId) {
    var title   = '启动/停止冗余设备';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        var afterSuccessCallback = function() {
                freshTableAndPage();
        };
        ajaxSubmitForm($('#switchRedundanceDevForm_' + formId), '结果', undefined,
                undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,       
		position : jQuery.getDialogPosition('300','160')
    };
    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '冗余设备[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function openSetWorkModeDialog() {
    var url   = 'Function/networkManagement/interface/redundance.php';
    var title = '高级设置';
    var data  = {
        openNewWorkModeDialog : true
    };
    var buttons = {};
    buttons['确定'] = function() {
        var afterSuccessCallback = function() {
                freshTableAndPage();
        };
        ajaxSubmitForm($('#editWorkModeForm'), '结果', undefined,
                undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 390,
        height  : 260,
        buttons : buttons,
        position : jQuery.getDialogPosition('390','260')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function moveToAddrMember() {
    $('#addrList option:selected').appendTo($('#addrMember'));
}

function moveToAddrList() {
    $('#addrMember option:selected').appendTo($('#addrList'));
}

function freshTableAndPage() {
    var url = 'Function/networkManagement/interface/redundance.php';
    freshTable(url, $('#redundanceTable'));
    freshPagination(url, $('.pager'));
}
