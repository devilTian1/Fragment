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
    buttons['确定'] = function() {
        if ($('#editFilterForm').valid()) {
            $('#filenames option').attr('selected', 'selected');
            ajaxSubmitForm($('#editFilterForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 375,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','375')
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
    buttons['Ok'] = function() {
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
    buttons['Confirm'] = function() {
        delFilter(id,name);
        freshTableAndPage();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
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
    buttons['添加下一条'] = function() {
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
         	    buttons[getMessage('确定')] = function() {
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
         	            freshPrePage('Function/client/fileEx/filter.php', $('#FEfilterOpt'));
         	        }    		
         		var dialog_c= ajaxSubmitForm($('#editFilterForm'), '结果',successResult);
         		dialog_c.close();
         		}                	
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editFilterForm').valid()) {
            if (!flag) {  		
            	ajaxSubmitForm($('#editFilterForm'), '结果');
                freshTableAndPage();
         	} else {
         		var dialog = loadingScreen(title);
         	    dialog.dialog('moveToTop');
         	    var buttons = {};
         	    buttons[getMessage('确定')] = function() {
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
         	            freshPrePage('Function/client/fileEx/filter.php', $('#FEfilterOpt'));
         	        }    		
         		var dialog_c= ajaxSubmitForm($('#editFilterForm'), '结果',successResult);
         		dialog_c.close();
         		}        		            
             $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 375,
        buttons : buttons,
        position : jQuery.getDialogPosition('660','375')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/client/fileEx/filter.php';
    freshTable(url, $('#filterTable'));
    freshPagination(url, $('.pager'));
}
