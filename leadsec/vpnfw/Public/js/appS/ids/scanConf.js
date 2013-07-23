function setScanConf() {
    if($('#setScanConfForm').valid()){
        ajaxSubmitForm($('#setScanConfForm'), '设置扫描检测 ');
    }
}