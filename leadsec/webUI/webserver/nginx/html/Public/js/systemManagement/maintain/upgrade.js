function submitForm(form) {
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}

function upgradeSystem() {
    submitForm($('#upgradeForm'));
}

function reboot() {
    submitForm($('#rebootForm'));
}
