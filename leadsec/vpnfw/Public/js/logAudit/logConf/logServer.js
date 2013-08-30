function setLogServer() {
    if ($('#setLogServerForm').valid()) {
        ajaxSubmitForm($('#setLogServerForm'), getMessage('Config Log Server'));
    }
}
function lookLog(){
	showPageByAjax("logAudit/logShow/logShow.tpl");
}
