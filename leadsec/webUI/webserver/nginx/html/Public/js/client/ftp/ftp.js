function openNewFtpFilterOptionsDialog(flag) {
    if ($('input[name="dataCount"]').val() >= 1000) {
        showErrorDialog(getMessage('Reach Upper Limit 1000') + '.');
        return false;
    }
    var url   = 'Function/client/ftp/ftp.php';
    var title = '添加FTP过滤选项';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editFtpFilterOptionForm').valid()) {
        	if (!flag) {  		
        		openNewFtpFilterOptionsDialog();
        		var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
         	} else {
         		openNewFtpFilterOptionsDialog(flag);
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
         	    var ftpFilterOptName = $("input[name='ftpFilterOptName']").val(); 
         		var successResult = function(result, textStatus) {
         		        var content = result.msg;
         	            dialog.setContent($('<p>' + content + '</p>'));
         	            freshPrePage('Function/client/ftp/ftp.php', $('#filter'),ftpFilterOptName);
         	        }    		
         		var dialog_c= ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果',successResult);
         		dialog_c.close();
         		}                	
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editFtpFilterOptionForm').valid()) {
        	if (!flag) {  		
        		var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
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
        	        position: jQuery.getDialogPosition(250,170)
        	    });
        	    var ftpFilterOptName = $("input[name='ftpFilterOptName']").val(); 
        		var successResult = function(result, textStatus) {
        		        var content = result.msg;
        	            dialog.setContent($('<p>' + content + '</p>'));
        	            freshPrePage('Function/client/ftp/ftp.php', $('#filter'),ftpFilterOptName);
        	        }    		
        		var dialog_c= ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果',successResult);
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
        height  : 690,
        buttons : buttons,
        position: jQuery.getDialogPosition(600,690)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function editFtpFilterOptionsDialog(id, flag) {
	if (id.length===0) {
		showErrorDialog('过滤选项不能为空');
    } else {
		var url   = 'Function/client/ftp/ftp.php';
		var title = '修改FTP过滤选项';
		if(!flag){
    		var data  = {
    				editId: id
    			};
		} else {
			var data  = {
	    			editId: id,
	    			plug:true
	    	    };
		}
		var buttons = {};
		buttons[getMessage('Ok')] = function() {
			if ($('#editFtpFilterOptionForm').valid()) {
				var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
				$(this).remove();
			}
		};
		buttons[getMessage('Cancel')] = function() {
			$(this).remove();
		};
		var dialogParams = {
			width   : 600,
			height  : 690,
			buttons : buttons,
			position: jQuery.getDialogPosition(600,690)
		};
		showDialogByAjax(url, data, title, dialogParams);
	}
}

function delFtpFilterOptions(id) {
    var url  = 'Function/client/ftp/ftp.php';
    var data = {
        delId: id
    };
    var title  = '删除FTP过滤';
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

function delFtpFilterOptionsDialog(id, name) {
    var dialog  = loadingScreen('删除FTP过滤选项');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delFtpFilterOptions(id);
        //rm this row~!!!!!
        //freshTableAndPage();
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
    dialog.setContent("<p>确定要删除名称为" + name + "的FTP过滤选项吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/client/ftp/ftp.php';
    freshTable(url, $('#ftpFilterOptionsTable'));
    freshPagination(url, $('.pager'));
}
