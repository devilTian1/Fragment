function openNewRealAddrDialog() {
    var url  = 'Function/networkManagement/lvs/schedule.php';
    var title   = '添加真实地址';
    var data  = {
        openNewRealAddrDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editRealAddrForm').valid() && ($("#erroDiv").attr("class")=='hide')) {
            openNewRealAddrDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRealAddrForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editRealAddrForm').valid() && ($("#erroDiv").attr("class")=='hide')) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRealAddrForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 440,
        buttons : buttons,
        position : jQuery.getDialogPosition('600','440')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openEditRealAddrDialog(ip,port) {
   var url  = 'Function/networkManagement/lvs/schedule.php';
    var title   = '编辑真实地址';
    var data  = {
        openEditRealAddrDialog: true,
        rip: ip,
        rport: port
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editRealAddrForm').valid()) {
        	var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRealAddrForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 440,
        buttons : buttons,
        position : jQuery.getDialogPosition('600','440')
    };
    showDialogByAjax(url, data, title, dialogParams);    
}

function delAddr(ip,port) {
    var url  = 'Function/networkManagement/lvs/schedule.php';
    var data = {
        delRealAddr: true,
        delIp: ip,
        delPort: port
    };
    var title  = '删除配置';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelRealAddrDialog(ip,port) {
    var dialog  = loadingScreen('删除配置');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAddr(ip,port);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent("<p>确定要删除虚拟地址为" + ip + "的配置吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/networkManagement/lvs/schedule.php';
    freshTable(url, $('#scheduleTable'));
    freshPagination(url, $('.pager'));
}

function checkIpAndPort() {
    var url  = 'Function/networkManagement/lvs/schedule.php';
    var vip = $('select[name="virtualAddr"] option:selected').val();
    var vport = $('input[name="virtualPort"]').val();
    var data  = {
        checkExistVirtualAddr: true,
        virtualAddr: vip,
        virtualPort: vport
    };
    var params = {
        type    : 'GET',
        success : function(result) {
            if (result == 'true') {
                 if ($("#erroDiv label[for='virtual']").html() == '此虚拟地址/端口已存在。') {
                    $("#erroDiv label[for='virtual']").parent().attr("style",'display:none;');
		  $("#erroDiv label[for='virtual']").attr("style",'display:none;');
		   $("#erroDiv").attr("style",'display:none');
                    $("#erroDiv").addClass("hide");
                }
            } else {
                var errorStr = "<li><label class=\"errorContainer\" for=\"virtual\" generated=\"true\" style=\"display: block;\">此虚拟地址/端口已存在。</label></li>";
                if ($("#erroDiv label[for='virtual']").html() == '此虚拟地址/端口已存在。') {
                    $("#erroDiv label[for='virtual']").parent().attr("style",'display:list-item;');
		  $("#erroDiv label[for='virtual']").attr("style",'display:block');
		  $("#erroDiv").attr("style",'display:block');
                    $("#erroDiv").removeClass("hide");
                } else {
                    $("#erroDiv").append(errorStr);
                    $("#erroDiv").attr("style",'display:block');
                    $("#erroDiv").removeClass("hide");
                }
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}