function openManuDialog() {
    var form = $('#uploadManuFileForm');
    if (form.valid()) {
        ajaxSubmitForm(form, '生产结果报告');
    }
}
