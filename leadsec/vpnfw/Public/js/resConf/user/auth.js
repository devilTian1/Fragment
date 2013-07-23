function openNewAuthPolicyDialog() {
	var url   = 'Function/resConf/user/auth.php';
    var title   = '定义认证策略';
    var data  = {
        tpl : 'resConf/user/editAuthPolicyDialog.tpl',
        addNewAuthPolicy : true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editAuthPolicyForm').valid()) {
        	openNewAuthPolicyDialog();
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAuthPolicyForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editAuthPolicyForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAuthPolicyForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 430,
        position : jQuery.getDialogPosition(600,430),
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openEditAuthPolicyDialog(name) {
	var url   = 'Function/resConf/user/auth.php';
    var data  = {
        editAuthPolicy : name
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editAuthPolicyForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editAuthPolicyForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 430,
        position : jQuery.getDialogPosition(600,430),
        buttons : buttons
    };
    showDialogByAjax(url, data, '编辑认证策略', dialogParams);
}

function openDelAuthPolicyDialog(name) {
	var dialog  = loadingScreen('删除认证策略');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAuthPolicy(name);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的认证策略吗?</p>");
    dialog.setOptions(dialogParams);
}

function delAuthPolicy(name) {
    var url  = 'Function/resConf/user/auth.php';
    var data = {
        delName: name
    };
    var title  = '删除用户列表';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelSpecAuthPolicyDialog() {
    var authpolicy = [];
    $('input:checkbox[name="checkSpecPolicy"]:checked').each(function(i) {
        authpolicy[i] = $(this).parent().next().next().html();
    });
    var dialog  = loadingScreen('删除已选认证策略');
    var buttons = {};
    if (authpolicy.length === 0) {
        dialog.setContent("<p>没有选择任何认证策略?</p>");
        buttons[getMessage('Ok')]  = function() {
            $(this).remove();
        };
    } else {
        dialog.setContent("<p>确定要删除已选的认证策略吗?</p>");
        buttons[getMessage('Ok')] = function() {
            delSpecAuthPolicy(authpolicy);
            $(this).remove();
        };
        buttons[getMessage('Cancel')]  = function() {
            $(this).remove();
        };
    }
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition(300,160)
    };
    dialog.setOptions(dialogParams);

}

function delSpecAuthPolicy(authpolicy) {
    var url  = 'Function/resConf/user/auth.php';
    if ($('#checkAllPolicy').attr('checked') === 'checked') {
        var data = {
        		delAllAuthPolicy: true
        };
    } else {
        var data = {
        		delSpecAuthPolicy: authpolicy
        };
    }
    var title  = '删除认证策略';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelAllAuthPolicyDialog() {
	var dialog  = loadingScreen('删除认证策略');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAllAuthPolicy();
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除所有认证策略吗?</p>");
    dialog.setOptions(dialogParams);   
}

function delAllAuthPolicy() {
    var url  = 'Function/resConf/user/auth.php';
    var data = {
        delAllAuthPolicy : true
    };
    var title  = '删除认证策略';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function switchAuthPolicyAcl(name, action, formId) {
	var title   = '启用/停止认证策略';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#switchAuthPolicyForm_' + formId), '结果', undefined,
            undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition(300,160)
    };
    var str = action === 'disable' ? '停止' : '启用';
    dialog.setContent('<p>确定' + str + '认证策略[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/resConf/user/auth.php';
    freshTable(url, $('#authPolicyTable'));
    freshPagination(url, $('.pager'));
}

function checkAll() {
	if ($('#checkAllPolicy').attr('checked')) {
        $('input:checkbox[name="checkSpecPolicy"]').attr('checked', 'checked');
    } else {
        $('input:checkbox[name="checkSpecPolicy"]').removeAttr('checked');
    }
}

function changeAddrType() {
    var checkedDom = $(":radio[name='addrType']:checked");
    var type       = checkedDom.val();
    var addrDiv    = $('#addrDiv, input[name="ip"], input[name="netmask"]');
    var rangeDiv   = $('#rangeDiv, input[name^="range_"]');
    var objDiv   = $('#objDiv, #objaddr');
    addrDiv.addClass('hide');
    rangeDiv.addClass('hide');
    objDiv.addClass('hide');
    if (type === 'range') {
        rangeDiv.removeClass('hide');
    }else if (type === 'object') {
    	objDiv.removeClass('hide');    	
    }else { // default
        addrDiv.removeClass('hide');
    }
}

function setServerConf() {
	if($('#serverConfForm').valid()){
		var afterSuccessCallback = function() {
            freshTableAndPage();
        };
        ajaxSubmitForm($('#serverConfForm'), '认证服务器配置 - 本机认证', undefined,
                undefined, afterSuccessCallback);
    }
}

function setParamsConf() {
	if($('#paramsConfForm').valid()){
		var afterSuccessCallback = function() {
            freshTableAndPage();
        };
		ajaxSubmitForm($('#paramsConfForm'), '认证参数配置', undefined,
                undefined, afterSuccessCallback);
    }
}
