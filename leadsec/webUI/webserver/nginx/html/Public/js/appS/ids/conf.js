function sendCmd() {
    if($('#setConfForm').valid()){
    	var title = '设置ids基本配置';
    	var dialog = loadingScreen(title);
 	    dialog.dialog('moveToTop');
 	    var buttons = {};
 	    buttons[getMessage('确定')] = function() {
 	        dialog.close();
 	    }
 	    dialog.setOptions({
 	        width : 250,
 	        height: 170,
 	        buttons: buttons,
 	        position: jQuery.getDialogPosition(250,170)
 	    });
 		var successResult = function(result, textStatus) {
 		        var content = result.msg;
 	            dialog.setContent($('<p>' + content + '</p>'));
 	            showPageByAjax('appS/ids/conf.php');
 	        }    		
 		var dialog_c= ajaxSubmitForm($('#setConfForm'), '设置ids基本配置',successResult);
 		dialog_c.close();
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
