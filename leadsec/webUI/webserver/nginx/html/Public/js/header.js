function headerSpan(name,formId) {
	if(formId=='homepage')
	{
		 var path = {
	                '1' : 'systemManagement',
	                '2' : 'overview'
	            };
	            var url  = 'Function/layout/showTab.php';
	            var data = {
	                tabPath : path,
	                tabNum :  0
	            };
	            loadEmbedPage(url, data, $("#tab"));
		
	}
	else if(formId=='fastconf')
	{
		 var path = {
	                '1' : 'systemManagement',
	                '2' : 'quick'
	            };
	            var url  = 'Function/layout/showTab.php';
	            var data = {
	                tabPath : path,
	                tabNum :  0
	            };
	            loadEmbedPage(url, data, $("#tab"));
		
	}
	else if(formId=='save')
	{
	    var title   = '保存配置';
	    var dialog  = loadingScreen(title);
	    var buttons = {};   
	    buttons['确定'] = function() { 
                var dialog = loadingScreen('结果');
                var buttons = {};
                buttons['关闭'] = function() {
                    dialog.close();
                };
                var dialogParamsDisable = {
                    width : 250,
                    height: 170,
                    closeOnEscape: false,
                    position: jQuery.getDialogPosition(250,170)
                };
                var dialogParamsEnable = {
                    width : 250,
                    height: 170,
                    buttons : buttons,
                    closeOnEscape: true,
                    position: jQuery.getDialogPosition(250,170)
                };
                dialog.setOptions(dialogParamsDisable);
	        $(".ui-dialog-titlebar-close").hide();
                var successCallback = function(result, textStatus) {
                    dialog.setContent(result.msg);
                    dialog.setOptions(dialogParamsEnable);
                    $(".ui-dialog-titlebar-close").show();        
                };
	        var dialog_c =ajaxSubmitForm($('#headerFormId_' + formId), '结果',successCallback);      
	        dialog_c.close();      	   
	        $(this).remove();
	    };
	    buttons['取消'] = function() {
	        $(this).remove();
	    };    
	    var dialogParams = {
	        width: 300,
	        height: 160,
	        buttons: buttons,
	        position: jQuery.getDialogPosition(300,160)
	    };
	    dialog.setContent('<p>确定保存配置?</p>');
	    dialog.setOptions(dialogParams);
	}
	
	else if(formId=='help')
	{
		window.open("/manual.pdf", "_blank");
	}
	else if(formId=='refresh')
	{	
		var fullpath = "systemManagement/admin/host.php";
		var a = new Array();
		var b = new Array();
		a=fullpath.split("/");	
		b = a[2].split(".");		
		var path = {
                '1' : a[0],
                '2' : a[1]
            };
        var url  = 'Function/layout/showTab.php';
        var data = {
                tabPath : path,
                action : formId 
            };          
        loadEmbedPage(url, data, $("#tab"));        
		 
	}
	else if(formId=='first')
	{			
		var fullpath = "systemManagement/admin/host.php";
		var a = new Array();
		var b = new Array();
		a=fullpath.split("/");	
		b = a[2].split(".");		
		var path = {
                '1' : a[0],
                '2' : a[1]
            };
        var url  = 'Function/layout/showTab.php';
        var data = {
                tabPath : path,
                action : formId 
            };          
        loadEmbedPage(url, data, $("#tab"));           
	}
	else if(formId=='next')
	{		
		var fullpath = "systemManagement/admin/host.php";
		var a = new Array();
		var b = new Array();
		a=fullpath.split("/");	
		b = a[2].split(".");		
		var path = {
                '1' : a[0],
                '2' : a[1]
            };
            var url  = 'Function/layout/showTab.php';
            var data = {
                tabPath : path,
                action : formId 
            };          
            loadEmbedPage(url, data, $("#tab"));            
	}
	else if(formId=='exit')
	{			
		//window.Location.href="index.php?logout=1";			
	}
	else if(formId=='exportconf')
	{
	    var title   = '导出格式';
	    var dialog  = loadingScreen(title);
	    var buttons = {};   
	    buttons[getMessage('normal format')] = function() {
	       $("input[name='export_format']").val('normal');	      
		headerFormId_exportconf.action = "Function/header.php";   
	        headerFormId_exportconf.submit();  
	        $(this).remove();
	    }
	    buttons[getMessage('encrypt format')] = function() {
	        $("input[name='export_format']").val('encrypt');
	        headerFormId_exportconf.action = "Function/header.php";   
	        headerFormId_exportconf.submit(); 
	        $(this).remove();
	    };
	    buttons[getMessage('readable format')] = function() {
	        $("input[name='export_format']").val('readable');
	        headerFormId_exportconf.action = "Function/header.php";   
	        headerFormId_exportconf.submit(); 
	        $(this).remove();
	    };
	    buttons[getMessage('Cancel')] = function() {
	        $(this).remove();
	    };    
	    var dialogParams = {
	        width: 400,
	        height: 160,
	        buttons: buttons,
	        position: jQuery.getDialogPosition(400,160)
	    };
	    var content = getMessage('config file format');
	    dialog.setContent('<p>'+content+'</p>');
	    dialog.setOptions(dialogParams);
	}
	else if(formId=='exportlog')
	{			
		headerFormId_exportlog.action = "Function/header.php";   
	    headerFormId_exportlog.submit();  	    
	}
	else
		{
		}		
}
