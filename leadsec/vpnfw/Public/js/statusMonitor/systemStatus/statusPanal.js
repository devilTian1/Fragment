function setDns() {
    if ($('#setDnsForm').valid()) {
        ajaxSubmitForm($('#setDnsForm'), getMessage('Config DNS Server'));
    }
}
