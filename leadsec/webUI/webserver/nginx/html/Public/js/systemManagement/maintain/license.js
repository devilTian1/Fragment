function submitForm(form) {
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}

function importLicense() {
	var form = $('#licenseForm');
	var successCallback = function(result, textStatus) {
		var content = result.msg;
        var dialog  = loadingScreen('导入许可证');
        var buttons = {};
        buttons['确定'] = function() {
            $(this).remove();
        };
        var dialogParams = {
            width: 200,
            height: 200,
            buttons: buttons
        };
        dialog.setContent(content);
        dialog.setOptions(dialogParams); 
        freshTable('Function/systemManagement/maintain/license.php', $('#licenseTable'),'ORDER BY application');
	};
	if (form.valid()) {
		var dialogcmd = ajaxSubmitForm(form, '结果',successCallback);
		dialogcmd.close();
	}  
}


function freshTableAndPage(tableDom) {
    var url = 'Function/systemManagement/maintain/license.php';
	var tableDom = $('#licenseTable');
    freshTable(url,tableDom);
    freshPagination(url,($('.pager')));
}
