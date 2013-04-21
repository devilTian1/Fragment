function sendCmd() {
    if($('#setConfForm').valid()){
        ajaxSubmitForm($('#setConfForm'), '设置ips基本配置 ');
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
