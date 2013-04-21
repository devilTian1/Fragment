function setDefaultSystem() {
    var title = "结果";
    var resultDialog  = loadingScreen(title);
    var buttons = {};
    buttons['关闭'] = function() {    	
    resultDialog.close();
    }
    resultDialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons
    });
    
    var successCallback = function(result, textStatus) {
        resultDialog.setContent($('<p>' + result.msg + '</p>'));        
    };
    var dialog = ajaxSubmitForm($('#dualSystemForm'), '结果',successCallback);
    dialog.close();
}

function backUpSystem(form) {
    var dialog = loadingScreen('结果');
    var buttons = {};
    buttons['关闭'] = function() {
        dialog.close();
    };
    var dialogParamsDisable = {
        width : 250,
        height: 170,
        closeOnEscape: false
    };
    var dialogParamsEnable = {
        width : 250,
        height: 170,
        buttons : buttons,
        closeOnEscape: true
    };
    dialog.setOptions(dialogParamsDisable);
    $(".ui-dialog-titlebar-close").hide();
    var successCallback = function(result, textStatus) {
        dialog.setContent(result.msg);
        dialog.setOptions(dialogParamsEnable);
        $(".ui-dialog-titlebar-close").show();        
        $("#systemStatus tbody td:eq(2)").html(result.status);   
        $("#recoverForm tbody td:eq(0)").html('将备份系统('+result.status+')恢复至');     
    };
    var dialog_c =ajaxSubmitForm(form, '结果',successCallback);
    dialog_c.close();    
}

function submitBackupForm(form) {
    //ajaxSubmitForm(form, '结果');
    var dialog = loadingScreen('提示');
    var buttons = {};
    buttons['确定'] = function() {
        $(this).remove();
        backUpSystem(form);        
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 180,
        buttons: buttons
    };
    dialog.setContent("<p>备份系统前，请确认配置已保存。点击'确定'备份系统，点击'取消'去保存配置。</p>");
    dialog.setOptions(dialogParams);
}

function submitRecoverForm(form) {
    //ajaxSubmitForm(form, '结果');
    var dialog = loadingScreen('结果');
    var buttons = {};
    buttons['关闭'] = function() {
        dialog.close();
    };
    var dialogParamsDisable = {
        width : 250,
        height: 170,
        closeOnEscape: false
    };
    var dialogParamsEnable = {
        width : 250,
        height: 170,
        buttons : buttons,
        closeOnEscape: true
    };
    dialog.setOptions(dialogParamsDisable);
    $(".ui-dialog-titlebar-close").hide();
    var successCallback = function(result, textStatus) {
        dialog.setContent(result.msg);
        dialog.setOptions(dialogParamsEnable);
        $(".ui-dialog-titlebar-close").show();
        if ($("input:radio[name='recoverSystem']:checked").val() == "systemA") {
            $("#systemStatus tbody td:eq(0)").html(result.status);
        } else {
            $("#systemStatus tbody td:eq(1)").html(result.status);
        }
    };
    var dialog_c =ajaxSubmitForm(form, '结果',successCallback);
    dialog_c.close();    
}