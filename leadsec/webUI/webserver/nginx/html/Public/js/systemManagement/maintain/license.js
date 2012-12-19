function submitForm(form) {
    if (form.valid()) {
        ajaxSubmitForm(form, '结果');
    }
}

function importLicense() {
    submitForm($('#licenseForm'));
}

function freshTableAndPage() {
    var url = 'Function/systemManagement/maintain/license.php';
    freshTable(url, $('#licenseTable'));
    freshPagination(url, $('.pager'));
}

