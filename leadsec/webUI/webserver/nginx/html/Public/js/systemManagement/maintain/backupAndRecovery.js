function submitForm(form) {
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}


function switchEncrypt() {
    if ($('#encryption').attr('checked') === 'checked') {
	$('#switch').val('on');
    } else {
	$('#switch').val('off');
    }
}

function exportConfigFile() {
    $('#action').val('exportConfigFile');
    //ajaxSubmitForm($('#backupAndRecoveryForm'), '结果');
}


function importConfigFile() {
    submitForm($('#importFileForm'));
}

function rest() {
    submitForm($('#restForm'));
}

function save(){
    submitForm($('#saveForm'));
}
