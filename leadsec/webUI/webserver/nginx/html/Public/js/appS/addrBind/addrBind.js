function init() {
	$("#detectbyfec").attr("checked",'checked');
	$("#serverip").attr("disabled",'disabled') ;
}

function changetoip() {
	$("#serverip").removeAttr("disabled",'disabled') ;
	$("#fecchk").attr("disabled",'disabled'); 
	$("#switchbyip").val('on');
	

}

function changetofec() {
	$("#fecchk").removeAttr("disabled",'disabled'); 
	$("#serverip").attr("disabled",'disabled') ;
	$("#switchbyip").val('');
	

}



function detectall() {
	var form = $("#addrBindForm");
	var successCallback = function(result, textStatus) {
	    var content = result.msg;
		//alert(content);
		if (content==='0') {
			alert('请选择网口');
		}
		if (content!=='0') {
			var dialog  = loadingScreen('结果');
			var dialogParams = {
				width: 250,
				height: 200
			};
			dialog.setContent("<p>正在探测，请稍后...</p>");
			dialog.setOptions(dialogParams); 
			setTimeout(function() { dialog.close(); },3000);
			setTimeout(function() { resultDialog(); },3000);
			
		}

	};
	if (form.valid()) {
        var dialog = ajaxSubmitForm(form, '结果', successCallback);
		dialog.close();
    }


}


function resultDialog() {
	var dialog  = loadingScreen('地址绑定');
	var buttons = {};
	buttons['确定'] = function() {
		$(this).remove();
	};
	var dialogParams = {
		width: 250,
		height: 200,
		buttons: buttons
	};
	dialog.setContent("<p>探测完毕，请点击按钮<探测到的IP/MAC对>查看探测结果！</p>");
	dialog.setOptions(dialogParams); 


}


function detectResultShow() {
	var url   = 'Function/appS/addrBind/addrBind.php';
    var title   = '探测到的 IP/MAC 对';
    var data  = {
        tpl : 'appS/addrBind/editAddrBindDialog.tpl',
        showResult : true
    };
    var buttons = {};
    buttons['删除'] = function() {
			
  
    };

    buttons['绑定'] = function() {   
            $(this).remove();     
    };

    buttons['取消'] = function() {
        $(this).remove();
    };

    var dialogParams = {
        width   : 620,
        height  : 600,
        position : ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}


