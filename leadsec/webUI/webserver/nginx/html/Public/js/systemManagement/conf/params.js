function setSysParams() {
    if ($('#setParamsForm').valid()) {
        ajaxSubmitForm($('#setParamsForm'), '设置产品名称');
    }
}
