function sendCmd() {
    if($('#setConfForm').valid()){   	
 		var successResult = function(result, textStatus) {
 	            showPageByAjax('appS/ids/conf.php');
 	        }    		
 		ajaxSubmitForm($('#setConfForm'), '设置入侵检测基本配置',undefined,undefined,successResult);
 		$(this).remove();
    }
}

function initIfRadio() {
	var $flag = 0;
	$("input[name='ifname']").each(function(){
		if($(this).val() == '<{$ipsConf.mode}>')
		{
			$(this).attr("checked",'checked');
			var $flag = 1;
		}
	});
	if($flag != 1)
	{
		$("input[name='ifname']:eq(0)").attr("checked",'checked');
	}	

}
