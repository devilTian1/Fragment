function editFilterDialog(id,flag) {
	if (id.length===0){
		showErrorDialog('过滤选项不能为空');
    } else {
	var url   = 'Function/client/fileEx/filter.php';
    var title = '';
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
        if ($('#editFilterForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editFilterForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 520,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','520')
    };
    showDialogByAjax(url, data, title, dialogParams);
    }
}

function delFilter(id,name) {
    var url  = 'Function/client/fileEx/filter.php';
    var data = {
        delId: id,
        delName:name
    };
    var title  = '删除文件属性控制';
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

function delFilterDialog(id, name) {
    var dialog  = loadingScreen('删除文件属性控制');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delFilter(id,name);
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
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的过滤选项吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewFilterDialog(flag) {
    var url   = 'Function/client/fileEx/filter.php';
    var title = '过滤选项集配置';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editFilterForm').valid()) {
            if (!flag) {  		
            	openNewFilterDialog();
            	var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editFilterForm'), '结果', undefined,
                    undefined, afterSuccessCallback);
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
         	    var filterName = $("input[name='FEfilterName']").val(); 
         		var successResult = function(result, textStatus) {
         		        var content = result.msg;
         	            dialog.setContent($('<p>' + content + '</p>'));
         	            freshPrePage('Function/client/fileEx/filter.php', $('#FEfilterOpt'),filterName);   
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
            	var afterSuccessCallback = function() {
                    freshTableAndPage();
                };
                ajaxSubmitForm($('#editFilterForm'), '结果', undefined,
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
         	        position : jQuery.getDialogPosition('250','170')
         	    });
         	    var filterName = $("input[name='FEfilterName']").val(); 
         		var successResult = function(result, textStatus) {
         		        var content = result.msg;
         	            dialog.setContent($('<p>' + content + '</p>'));
         	            freshPrePage('Function/client/fileEx/filter.php', $('#FEfilterOpt'),filterName);            
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
        width   : 660,
        height  : 520,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','520')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/client/fileEx/filter.php';
    freshTable(url, $('#filterTable'));
    freshPagination(url, $('.pager'));
}
