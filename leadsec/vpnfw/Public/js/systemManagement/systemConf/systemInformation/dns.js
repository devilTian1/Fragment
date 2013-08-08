function setDdnsUser() {
    if($('#setDnsUserForm').valid()){
        ajaxSubmitForm($('#setDnsUserForm'), '动态DNS注册：用户信息 ');
    }
	showPageByAjax('systemManagement/systemConf/systemInformation/dynamicDN.tpl');
}