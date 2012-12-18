function switchEncrypt() {
    if ($('#encryption').attr('checked') === 'checked') {
	$('#switch').val('on');
    } else {
	$('#switch').val('off');
    }
}

function submitForm(form) {
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}

function importConfigFile() {
    submitForm($('#importFileForm'));
    $('#importFile').val('');
}

function restore() {
    submitForm($('#restoreForm'));
}

function save(){
    submitForm($('#saveForm'));
}
