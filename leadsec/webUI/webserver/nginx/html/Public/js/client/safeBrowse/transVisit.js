function addOrEditTransAccessCtrl(type, title) {
    if (type === 'next') {
        openNewTransAccessCtrlDialog();
    }
    var resultDialog  = loadingScreen(title);
    resultDialog.dialog('moveToTop');
    var buttons = {};
    buttons['Ok'] = function() {    	
        resultDialog.close();
    }
    resultDialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons
    });
    var successCallback = function(result, textStatus) {
        resultDialog.setContent($('<p>' + result.msg + '</p>'));
        freshTableAndPage();        
    }
    var dialog = ajaxSubmitForm($('#editTransAccessCtrlForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditTransAccessCtrlDialog(id) {
    var url  = 'Function/client/safeBrowse/transVisit.php';
    var data = {
        tpl    : 'client/safeBrowse/transVisit_editDialog.tpl',
        editId : id
    };
    var title   = '管理透明访问控制';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editTransAccessCtrlForm').valid()) {
        	addOrEditTransAccessCtrl('edit','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 380,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewTransAccessCtrlDialog() {
    var url   = 'Function/client/safeBrowse/transVisit.php';
    var title = '管理透明访问控制';
    var data  = {
        tpl : 'client/safeBrowse/transVisit_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editTransAccessCtrlForm').valid()) {
        	addOrEditTransAccessCtrl('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editTransAccessCtrlForm').valid()) {
        	addOrEditTransAccessCtrl('add','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 380,
        buttons : buttons,
        position: ['center', 'top']
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delTransAccess(id) {
    var url  = 'Function/client/safeBrowse/transVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除';
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

function openDelTransAccessCtrlDialog(id) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons['确定'] = function() {
        delTransAccess(id);
        $(this).remove();        
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
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
    saOpts.children('span').showOption(); 
	daOpts.children('span').showOption();
    saOpts.find('option[value$="_ipv6"]').hideOption();
    daOpts.find('option[value$="_ipv6"]').hideOption();
    saOpts.find('option:visible:eq(0)').attr('selected','selected');
    daOpts.find('option:visible:eq(0)').attr('selected','selected');   
}

function freshTableAndPage() {
    var url = 'Function/client/safeBrowse/transVisit.php';
    freshTable(url, $('#transVisitTable'));
    freshPagination(url, $('.pager'));
}