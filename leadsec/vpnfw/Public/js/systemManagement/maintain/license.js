function submitForm(form) {
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}

function importLicense() {
	var form = $('#licenseForm');
	var afterSuccessCallback = function(result, textStatus) {
		var content = result.msg;
        freshTable('Function/systemManagement/maintain/license.php', $('#licenseTable'),'ORDER BY application');
	};
	if (form.valid()) {
		ajaxSubmitForm(form, '结果',undefined,undefined,afterSuccessCallback);
		$(this).remove();
	}  
}


function freshTableAndPage(tableDom) {
    var url = 'Function/systemManagement/maintain/license.php';
	var tableDom = $('#licenseTable');
    freshTable(url,tableDom);
    freshPagination(url,($('.pager')));
}
