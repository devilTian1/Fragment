function setScanConf() {
    if($('#setScanConfForm').valid()){
        ajaxSubmitForm($('#setScanConfForm'), '设置扫描检测 ');
    }
}

function clearScanConfIpAddr(){
	$('#setScanConfForm').get(0).action = "Function/appS/ids/scanConf.php?clearScanConf=1";	
		var successResult = function(result, textStatus) {
	            showPageByAjax('appS/ids/scanConf.php');
	        }    		
		ajaxSubmitForm($('#setScanConfForm'), '清除已经阻挡的IP地址',undefined,undefined,successResult);
		$(this).remove();         
}
