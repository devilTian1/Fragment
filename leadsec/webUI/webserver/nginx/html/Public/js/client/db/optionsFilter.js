function openEditOptionsDialog(id,flag) {
	if (id.length===0){
		showErrorDialog('过滤选项不能为空');
    } else {
    	var title   = '修改过滤选项';
    	var url  = 'Function/client/db/optionsFilter.php';
    	if(!flag){
    		var data = {
    	    	tpl    : 'resConf/client/db/optionsFilter_editDialog.tpl',
    	    	editId : id
    	    };
		} else {
	    	var data = {
	        	    tpl    : 'resConf/client/db/optionsFilter_editDialog.tpl',
	        	    editId : id,
	        	    plug:true
	        };			
		}

    	var buttons = {};
    	buttons[getMessage('Ok')] = function() {
    	    if ($('#optionFilterEditForm').valid()) {
    	    	var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
    	        ajaxSubmitForm($('#optionFilterEditForm'), '结果', undefined,
    	            undefined, afterSuccessCallback);
    	        $(this).remove();
    	    }
    	};
    	buttons[getMessage('Cancel')] = function() {
    	    $(this).remove();
    	};
    	var dialogParams = {
    	    width   : 600,
    	    height  : 277,
    	    buttons : buttons,
    	    position: jQuery.getDialogPosition(600,277)
    	};
    	showDialogByAjax(url, data, title, dialogParams);
    }
   
}

function openNewOptionsDialog(flag) {
    var url   = 'Function/client/db/optionsFilter.php';
    var title = '添加过滤选项';
    var data  = {
		openDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#optionFilterEditForm').valid()) {
        	if (!flag) { 
        		openNewOptionsDialog();
        		var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
    	        ajaxSubmitForm($('#optionFilterEditForm'), '结果', undefined,
    	            undefined, afterSuccessCallback);
        	}else{
        		openNewOptionsDialog(flag);
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
         	       position: jQuery.getDialogPosition(250,170)
         	    });
         	   var optionName = $("input[name='optionName']").val(); 
         		var successResult = function(result, textStatus) {
         		        var content = result.msg;
         	            dialog.setContent($('<p>' + content + '</p>'));
         	            freshPrePage('Function/client/db/optionsFilter.php', $('#filter'),optionName);
         	        }    		
         		var dialog_c= ajaxSubmitForm($('#optionFilterEditForm'), '结果',successResult);
         		dialog_c.close();
        	}
        	
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#optionFilterEditForm').valid()) {
        	if (!flag) { 
        		var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
    	        ajaxSubmitForm($('#optionFilterEditForm'), '结果', undefined,
    	            undefined, afterSuccessCallback);
        	}else{
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
        	        position: jQuery.getDialogPosition(250,170)
        	    });
        	    var optionName = $("input[name='optionName']").val(); 
        		var successResult = function(result, textStatus) {
        		        var content = result.msg;
        	            dialog.setContent($('<p>' + content + '</p>'));
        	            freshPrePage('Function/client/db/optionsFilter.php', $('#filter'),optionName);
        	    }    		
        		var dialog_c= ajaxSubmitForm($('#optionFilterEditForm'), '结果',successResult);
        		dialog_c.close();
        	}          
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 277,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,277)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(name) {
    var url  = 'Function/client/db/optionsFilter.php';
    var data = {
        delName: name
    };
    var title  = '删除过滤选项';
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

function openDelOptionsDialog(name) {
    var dialog  = loadingScreen('删除过滤选项');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        del(name);
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
        position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除序号为" + name + "的过滤选项吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/client/db/optionsFilter.php';
    freshTable(url, $('#dataVisit_optionsTable'));
    freshPagination(url, $('.pager'));
}