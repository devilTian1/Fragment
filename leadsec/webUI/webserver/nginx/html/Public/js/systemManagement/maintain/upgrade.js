function updata() {
    var form = $('#upgradeForm');
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}

function reboot() {
    if ($('#rebootForm').valid()) {
        ajaxSubmitForm($('#rebootForm'), '结果');
    }
}


