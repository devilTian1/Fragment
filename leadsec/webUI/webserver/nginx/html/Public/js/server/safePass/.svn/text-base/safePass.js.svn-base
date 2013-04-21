function addOrEditSafePass(type, title) {
    if (type === 'next') {
        openNewSafePassDialog();
    }
    var resultDialog  = loadingScreen(title);
    resultDialog.dialog('moveToTop');
    var buttons = {};
    buttons['关闭'] = function() {    	
        resultDialog.close();
    }
    resultDialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons,
        position : jQuery.getDialogPosition('250','170')
    });
    var successCallback = function(result, textStatus) {
        resultDialog.setContent($('<p>' + result.msg + '</p>'));
        freshTableAndPage();        
    }
    var dialog = ajaxSubmitForm($('#editSafePassServerForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditSafePassDialog(id) {
    var url  = 'Function/server/safePass/safePass.php';
    var data = {
        tpl    : 'server/safePass/safePass_editDialog.tpl',
        editId : id
    };
    var title   = '管理安全通道';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editSafePassServerForm').valid()) {
        	addOrEditSafePass('edit','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 414,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','414')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewSafePassDialog() {
    var url   = 'Function/server/safePass/safePass.php';
    var title = '管理安全通道';
    var data  = {
        tpl : 'server/safePass/safePass_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editSafePassServerForm').valid()) {
        	addOrEditSafePass('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editSafePassServerForm').valid()) {
        	addOrEditSafePass('add','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 414,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','414')
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delSafePass(id) {
    var url  = 'Function/server/safePass/safePass.php';
    var data = {
        delId: id
    };
    var title  = '删除安全通道';
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

function openDelSafePassDialog(id) {
    var dialog  = loadingScreen('删除安全通道');
    var buttons = {};
    buttons['确定'] = function() {
        delSafePass(id);
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
    dialog.setContent("<p>确定要删除任务号为" + id + "的安全通道吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchSafePassActive(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchSafePassServerActiveForm_' + id), '结果');
        freshTableAndPage();
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
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

/******************************************
*函数:function filterRes(daName)
*说明:页面选择IPV4，IPV6选项时，筛选源，目的地址
*     中的ip，只显示支持的地址类型
*******************************************/
function filterRes() {
    var saOpts  = $('select[name="outflowIpList"]');
    saOpts.showOption(); 

    saOpts.hideOption('option[value*=":"]');
}

function portOnCtrl() {
	var service = $("select[name='serviceList'] option:selected").val();
	if (service == "tcp_any" || service== "udp_any") {
		$("#sPortDiv").removeClass("hide");		
	} else {
		$("#sPortDiv").addClass("hide");	
	}
}

function freshTableAndPage() {
    var url = 'Function/server/safePass/safePass.php';
    freshTable(url, $('#safePassServerTable'));
    freshPagination(url, $('.pager'));
}
