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
	        ajaxSubmitForm($('#headerFormId_' + formId), '结果');        	   
	        $(this).remove();
	    };
	    buttons['取消'] = function() {
	        $(this).remove();
	    };    
	    var dialogParams = {
	        width: 300,
	        height: 160,
	        buttons: buttons
	    };
	    dialog.setContent('<p>确定保存配置</p>');
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
	    var title   = '导出配置';
	    var dialog  = loadingScreen(title);
	    var buttons = {};   
	    buttons['确定'] = function() { 
	        ajaxSubmitForm($('#headerFormId_' + formId), '结果');        	   
	        $(this).remove();
	    };
	    buttons['取消'] = function() {
	        $(this).remove();
	    };    
	    var dialogParams = {
	        width: 300,
	        height: 160,
	        buttons: buttons
	    };
	    dialog.setContent('<p>确定导出配置</p>');
	    dialog.setOptions(dialogParams);
	}
	else
		{
		}		
}
