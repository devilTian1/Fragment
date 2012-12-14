function submitForm(form) {
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}

function importLicense() {
    submitForm($('#licenseForm'));
}

