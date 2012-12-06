function openManuDialog() {
    var form = $('#uploadManuFileForm');
    if (form.valid()) {
        var dialog = ajaxSubmitForm(form, '生产结果报告');
        dialog.setOptions({
            width : 320,
            height: 220
        });
    }
}
