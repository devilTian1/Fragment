function headerSpan(name,formId) {
    var title   = '头部快捷方式';
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
