function openNewFtpFilterOptionsDialog(flag) {
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
                ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果');
                freshTableAndPage();
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
         	        buttons: buttons
         	    });
         		var successResult = function(result, textStatus) {
         		        var content = result.msg;
         	            dialog.setContent($('<p>' + content + '</p>'));
         	            freshPrePage('Function/client/ftp/ftp.php', $('#filter'));
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
               ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果');
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
        	        buttons: buttons
        	    });
        		var successResult = function(result, textStatus) {
        		        var content = result.msg;
        	            dialog.setContent($('<p>' + content + '</p>'));
        	            freshPrePage('Function/client/ftp/ftp.php', $('#filter'));
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
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function editFtpFilterOptionsDialog(id,flag) {
	var url   = 'Function/client/ftp/ftp.php';
    var title = '修改FTP过滤选项';
    if(!flag){
    	var data  = {
    			editId: id
    	    };
    }else{
    	var data  = {
    			editId: id,
    			plug:true
    	    };
    }
    
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editFtpFilterOptionForm').valid()) {
            ajaxSubmitForm($('#editFtpFilterOptionForm'), '结果');
            freshTableAndPage();
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
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
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
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delFtpFilterOptionsDialog(id, name) {
    var dialog  = loadingScreen('删除FTP过滤选项');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delFtpFilterOptions(id);
        freshTableAndPage();
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的FTP过滤选项吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/client/ftp/ftp.php';
    freshTable(url, $('#ftpFilterOptionsTable'));
    freshPagination(url, $('.pager'));
}
