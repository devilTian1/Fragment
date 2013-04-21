function addOrEditFilter(type, title) {
    if (type === 'next') {
        openNewFilterDialog();
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
    var dialog = ajaxSubmitForm($('#editFilterForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditFilterDialog(id,flag) {
	if (id.length===0){
		showErrorDialog('过滤选项不能为空');
    } else {
	var url  = 'Function/client/mail/filter.php';
	if(!flag){
		var data  = {
				tpl: 'client/mail/filter_editDialog.tpl',
				editId: id
			};
	} else {
		var data  = {
				tpl: 'client/mail/filter_editDialog.tpl',
    			editId: id,
    			plug:true
    	    };
	}
    var title   = '管理过滤选项集配置';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editFilterForm').valid()) {
        	if (!flag) {  		
                ajaxSubmitForm($('#editFilterForm'), '结果');
                freshTableAndPage();
         	} else {
         		var dialog = loadingScreen(title);
         	    dialog.dialog('moveToTop');
         	    var buttons = {};
         	    buttons[getMessage('Ok')] = function() {
         	        dialog.close();
         	    }
         	    dialog.setOptions({
         	        width : 250,
         	        height: 170,
         	        buttons: buttons,
         	        position : jQuery.getDialogPosition('250','170')
         	    });
         		var successResult = function(result, textStatus) {
         		        var content = result.msg;
         	            dialog.setContent($('<p>' + content + '</p>'));
         	           var urldata = 'Function/client/mail/filter.php?flag='+flag;
        	            freshPrePage(urldata, $('#filter'));
         	        }    		
         		var dialog_c= ajaxSubmitForm($('#editFilterForm'), '结果',successResult);
         		dialog_c.close();
         		} 
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 510,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','510')
    };
    showDialogByAjax(url, data, title, dialogParams);
    }
}

function openNewFilterDialog(flag) {
    var url   = 'Function/client/mail/filter.php';
    var title = '管理过滤选项集配置';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editFilterForm').valid()) {
        	if (!flag) {  		
        		openNewFilterDialog();
                ajaxSubmitForm($('#editFilterForm'), '结果');
                freshTableAndPage();
         	} else {
         		openNewFilterDialog(flag);
         		var dialog = loadingScreen(title);
         	    dialog.dialog('moveToTop');
         	    var buttons = {};
         	    buttons[getMessage('Ok')] = function() {
         	        dialog.close();
         	    }
         	    dialog.setOptions({
         	        width : 250,
         	        height: 170,
         	        buttons: buttons,
         	        position : jQuery.getDialogPosition('250','170')
         	    });
         		var successResult = function(result, textStatus) {
         		        var content = result.msg;
         	            dialog.setContent($('<p>' + content + '</p>'));
         	            var urldata = 'Function/client/mail/filter.php?flag='+flag;
         	            freshPrePage(urldata, $('#filter'));
         	        }    		
         		var dialog_c= ajaxSubmitForm($('#editFilterForm'), '结果',successResult);
         		dialog_c.close();
         	}
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editFilterForm').valid()) {
        	if (!flag) {  		
                ajaxSubmitForm($('#editFilterForm'), '结果');
                freshTableAndPage();
         	} else {
         		var dialog = loadingScreen(title);
         	    dialog.dialog('moveToTop');
         	    var buttons = {};
         	    buttons[getMessage('Ok')] = function() {
         	        dialog.close();
         	    }
         	    dialog.setOptions({
         	        width : 250,
         	        height: 170,
         	        buttons: buttons,
         	        position : jQuery.getDialogPosition('250','170')
         	    });
         		var successResult = function(result, textStatus) {
         		        var content = result.msg;
         	            dialog.setContent($('<p>' + content + '</p>'));
         	           var urldata = 'Function/client/mail/filter.php?flag='+flag;
        	            freshPrePage(urldata, $('#filter'));
         	        }    		
         		var dialog_c= ajaxSubmitForm($('#editFilterForm'), '结果',successResult);
         		dialog_c.close();
         		} 
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 520,
        buttons : buttons,
        position : jQuery.getDialogPosition('680','520')
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delFilter(id, name) {
    var url  = 'Function/client/mail/filter.php';
    var data = {
        delId: id,
        delName:name
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

function openDelFilterDialog(id, name) {
    var dialog  = loadingScreen('删除');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delFilter(id, name);
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

function freshTableAndPage() {
    var url = 'Function/client/mail/filter.php';
    freshTable(url, $('#filterTable'));
    freshPagination(url, $('.pager'));
}
