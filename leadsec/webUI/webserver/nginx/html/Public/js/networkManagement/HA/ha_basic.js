function setHaForm(){
	if ($('#HaBasicForm').valid()) {
	    ajaxSubmitForm($('#HaBasicForm'), '结果');
	}
}