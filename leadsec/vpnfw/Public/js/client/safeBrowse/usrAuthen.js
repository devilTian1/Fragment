function setUsrAuthenForm() {
    ajaxSubmitForm($('#setUsrAuthenForm'), '设置用户认证方式');
}

function setRadiusConfigForm() {
	if ($('#setRadiusForm').valid()) {
    	ajaxSubmitForm($('#setRadiusForm'), 'Radius配置');
	}
}

function setLDAPConfigForm() {
	if ($('#setLDAPForm').valid()) {
    	ajaxSubmitForm($('#setLDAPForm'), 'LDAP配置');
	}
}
