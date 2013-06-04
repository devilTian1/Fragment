function addOrEditGeneralAccessCtrl(type, title) {
    if (type === 'next') {
        openNewGeneralAccessCtrlDialog();
    }
    var resultDialog  = loadingScreen(title);
    resultDialog.dialog('moveToTop');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {    	
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
    var dialog = ajaxSubmitForm($('#editGeneralAccessCtrlForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditGeneralAccessCtrlDialog(id) {
    var url  = 'Function/client/safeBrowse/generalVisit.php';
    var data = {
        tpl    : 'client/safeBrowse/generalVisit_editDialog.tpl',
        editId : id
    };
    var title   = '管理普通访问控制';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editGeneralAccessCtrlForm').valid()) {
        	addOrEditGeneralAccessCtrl('edit','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 340,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','340')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewGeneralAccessCtrlDialog() {
    var url   = 'Function/client/safeBrowse/generalVisit.php';
    var title = '管理普通访问控制';
    var data  = {
        tpl : 'client/safeBrowse/generalVisit_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editGeneralAccessCtrlForm').valid()) {
        	addOrEditGeneralAccessCtrl('next','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editGeneralAccessCtrlForm').valid()) {
        	addOrEditGeneralAccessCtrl('add','结果');
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 340,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','340')
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delGeneralAccess(id) {
    var url  = 'Function/client/safeBrowse/generalVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除';
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

function openDelGeneralAccessCtrlDialog(id) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delGeneralAccess(id);
        $(this).remove();        
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
    dialog.setContent("<p>确定要删除吗?</p>");
    dialog.setOptions(dialogParams);   
}


/******************************************
*函数:function filterRes(daName)
*说明:页面选择IPV4，IPV6选项时，筛选源，目的地址
*     中的ip，只显示支持的地址类型
*******************************************/
function filterRes() {
    var saOpts  = $('select[name="srcIpList"]');
    var daOpts  = $('select[name="destIpList"]');
    saOpts.showOption(); 
	daOpts.showOption();
    saOpts.hideOption('option[value$="_ipv6"]');
    daOpts.hideOption('option[value$="_ipv6"]');
}

function freshTableAndPage() {
    var url = 'Function/client/safeBrowse/generalVisit.php';
    freshTable(url, $('#generalVisitTable'));
    freshPagination(url, $('.pager'));
}
