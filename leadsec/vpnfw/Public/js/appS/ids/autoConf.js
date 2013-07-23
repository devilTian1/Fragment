/*
function sendCmd() {
    if($('#setConfForm').valid()){
        ajaxSubmitForm($('#setConfForm'), '设置自动响应配置');
        showPageByAjax('appS/ids/autoConf.php');
    }
}

function clearIpAddr(){
	$('#setConfForm').get(0).action = "Function/appS/ids/autoConf.php?clear=1";
	ajaxSubmitForm($('#setConfForm'), '清除已经阻挡的IP地址');
	showPageByAjax('appS/ids/autoConf.php');
}*/

function sendCmd() {
    if($('#setConfForm').valid()){
 		var successResult = function(result, textStatus) {
 	            showPageByAjax('appS/ids/autoConf.php');
 	        }    		
 		ajaxSubmitForm($('#setConfForm'), '设置自动响应配置',undefined,undefined,successResult);
 		$(this).remove();
    }
}

function clearIpAddr(){
	$('#setConfForm').get(0).action = "Function/appS/ids/autoConf.php?clear=1";	
		var successResult = function(result, textStatus) {
	            showPageByAjax('appS/ids/autoConf.php');
	        }    		
		ajaxSubmitForm($('#setConfForm'), '清除已经阻挡的IP地址',undefined,undefined,successResult);
		$(this).remove();         
}
