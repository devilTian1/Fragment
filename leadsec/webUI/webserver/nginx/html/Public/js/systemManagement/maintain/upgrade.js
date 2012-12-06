function updata() {
    if ($('#updataForm').valid()) {
        ajaxSubmitForm($('#updataForm'), '结果');
    }
}

function reboot() {
    if ($('#rebootForm').valid()) {
        ajaxSubmitForm($('#rebootForm'), '结果');
    }
}


