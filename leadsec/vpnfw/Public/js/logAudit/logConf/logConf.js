function setLogConf() {
    if ($('#setLogConfForm').valid()) {
        ajaxSubmitForm($('#setLogConfForm'), getMessage('Config Log Conf'));
    }
}
