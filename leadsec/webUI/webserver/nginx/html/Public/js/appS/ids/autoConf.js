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
    	var url  = 'Function/appS/ids/autoConf.php';
        var title  = '设置自动响应配置';
        var dialog = loadingScreen(title);
 	    dialog.dialog('moveToTop');
 	    var buttons = {};
 	    buttons[getMessage('Ok')] = function() {
 	        dialog.close();
 	    }
 	    dialog.setOptions({
 	        width : 250,
 	        height: 170,
 	        buttons: buttons
 	    });
 		var successResult = function(result, textStatus) {
 		        var content = result.msg;
 	            dialog.setContent($('<p>' + content + '</p>'));
 	            showPageByAjax('appS/ids/autoConf.php');
 	        }    		
 		var dialog_c= ajaxSubmitForm($('#setConfForm'), '设置自动响应配置',successResult);
 		dialog_c.close();          
    }
}

function clearIpAddr(){
	$('#setConfForm').get(0).action = "Function/appS/ids/autoConf.php?clear=1";
	var url  = 'Function/appS/ids/autoConf.php';
	var title  = '清除已经阻挡的IP地址';
	var dialog = loadingScreen(title);
	    dialog.dialog('moveToTop');
	    var buttons = {};
	    buttons[getMessage('Ok')] = function() {
	        dialog.close();
	    }
	    dialog.setOptions({
	        width : 250,
	        height: 170,
	        buttons: buttons
	    });
		var successResult = function(result, textStatus) {
		        var content = result.msg;
	            dialog.setContent($('<p>' + content + '</p>'));
	            showPageByAjax('appS/ids/autoConf.php');
	        }    		
		var dialog_c= ajaxSubmitForm($('#setConfForm'), '清除已经阻挡的IP地址',successResult);
		dialog_c.close();          
}