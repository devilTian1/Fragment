function setBasicConfigForm() {
	if ($('#setBasicConfigForm').valid()) {
	    ajaxSubmitForm($('#setBasicConfigForm'), '管理基本配置');
	}
}
