function selectAll(){
	var obj = document.getElementById("iplist");	
	if(obj)
	{
		var length = obj.length;
		
		for(var i=0; i<length ; i++)
		{
			obj.options[i].selected = true;
		}
	}
}

function setSnmpForm(){
	if ($('#setSnmpForm').valid()) {
		selectAll();
	    ajaxSubmitForm($('#setSnmpForm'), '结果');
	}
}

