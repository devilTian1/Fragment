function editAllowedFileDialog(id) {
    var url   = 'Function/client/msgTrans/callowedFile.php';
    var title = '编辑文件名控制';
    var data  = {
		editId: id
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editAllowedFileForm').valid()) {
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 300,
        buttons : buttons,
        position: jQuery.getDialogPosition(660,240)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAllowedFile(name) {
    var url  = 'Function/client/msgTrans/callowedFile.php';
    var data = {
        delId: name
    };
    var title  = '删除文件名控制';
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

function delAllowedFileDialog(name) {
    var dialog  = loadingScreen('删除文件名控制');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAllowedFile(name);
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
        position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的文件名控制吗?</p>");
    dialog.setOptions(dialogParams);   
}

function openNewAllowedFileDialog() {
    var url   = 'Function/client/msgTrans/callowedFile.php';
    var title = '添加文件名控制';
    var data  = {
		openAddDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editAllowedFileForm').valid()) {
            openNewAllowedFileDialog();
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editAllowedFileForm').valid()) {
            ajaxSubmitForm($('#editAllowedFileForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 660,
        height  : 300,
        buttons : buttons,
        position: jQuery.getDialogPosition(660,240)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/client/msgTrans/callowedFile.php';
    freshTable(url, $('#allowedFileTable'));
    freshPagination(url, $('.pager'));
}

function switchFileChk(action) {
    var title   = '启用/停止文件名控制';
    var dialog  = loadingScreen(title);
    var buttons = {};   
    buttons[getMessage('Ok')] = function() {
        var resultDialog  = loadingScreen(title);
        var successCallback = function(result, textStatus) {
            var buttons = {};
            buttons[getMessage('Ok')] = function() {
                resultDialog.close();
            }
            resultDialog.setOptions({
                width : 250,
                height: 170,
                buttons: buttons,
                position: jQuery.getDialogPosition(250,170)
            });
            var content = result.msg;         
            resultDialog.setContent($('<p>' + content + '</p>'));        
            if (result.status =='0') { 
                if ($('#action_file').val() =='on') {   
                    $('#filelist').attr("checked","checked");
                    $('#action_file').attr("value","off");
                }else {
                	//$('#whilist').attr("checked","");
                    $('#action_file').attr("value","on");
                }	 
            }    		
        }
        var returnDialog = 
            ajaxSubmitForm($('#filelistForm'), '结果',
        	    successCallback);
        returnDialog.close();
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
    var str = $('#action_file').val() === 'off' ? '停止' : '启用';
    dialog.setContent('<p>确定' + str + '文件名控制吗?</p>');
    dialog.setOptions(dialogParams);
}
function switchBinChk(action) {
    var title   = '启用/停止二进制文件控制';
    var dialog  = loadingScreen(title);
    var buttons = {};   
    buttons[getMessage('Ok')] = function() {
        var resultDialog  = loadingScreen(title);
        var successCallback = function(result, textStatus) {
            var buttons = {};
            buttons[getMessage('Ok')] = function() {
                resultDialog.close();
            }
            resultDialog.setOptions({
                width : 250,
                height: 170,
                buttons: buttons,
                position: jQuery.getDialogPosition(250,170)
            });
            var content = result.msg;         
            resultDialog.setContent($('<p>' + content + '</p>'));        
            if (result.status =='0') { 
                if ($('#action_bin').val() =='on') {   
                    $('#binlist').attr("checked","checked");
                    $('#action_bin').attr("value","off");
                }else {
                	//$('#whilist').attr("checked","");
                    $('#action_bin').attr("value","on");
                }	 
            }    		
        }
        var returnDialog = 
            ajaxSubmitForm($('#binlistForm'), '结果',
        	    successCallback);
        returnDialog.close();
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
    var str = $('#action_bin').val() === 'off' ? '停止' : '启用';
    dialog.setContent('<p>确定' + str + '二进制文件控制吗?</p>');
    dialog.setOptions(dialogParams);
}
