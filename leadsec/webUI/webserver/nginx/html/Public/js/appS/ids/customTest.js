function openEditCustomTestDialog(id,active) {
	var type = active ;
	if (type === 'on') {
		showErrorDialog('状态须停止后才能进行编辑！');
	 } else {
		var url  = 'Function/appS/ids/customTest.php';
		var data = {
			tpl  : 'appS/ids/editCustomTestDialog.tpl',
			editId: id,
			openEditCustomTestDialog: true
			
		};
		var title   = '修改自定义检测规则';
		var buttons = {};
		buttons[getMessage('Ok')] = function() {
			if ($('#editCustomTestForm').valid()) {
				var afterSuccessCallback = function() {
					freshTableAndPage();
				};
				ajaxSubmitForm($('#editCustomTestForm'), '结果',undefined,
					undefined,afterSuccessCallback);
				
				$(this).remove();
			}
		};
		buttons[getMessage('Cancel')]  = function() {
			$(this).remove();
		};
		var dialogParams = {
			width   : 800,
			height  : 600,
			buttons : buttons,
			position: jQuery.getDialogPosition(800,600)
		};
		showDialogByAjax(url, data, title, dialogParams);
	}
}

function openNewCustomTestDialog() {
    var url  = 'Function/appS/ids/customTest.php';
    var title   = '添加检测规则';
    var data  = {
        tpl : 'appS/ids/editCustomTestDialog.tpl',
        openNewCustomTestDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editCustomTestForm').valid()) {
            openNewCustomTestDialog();
			var afterSuccessCallback = function() {
				freshTableAndPage();
			};
            ajaxSubmitForm($('#editCustomTestForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editCustomTestForm').valid()) {
			var afterSuccessCallback = function() {
				freshTableAndPage();
			};
            ajaxSubmitForm($('#editCustomTestForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 800,
        height  : 600,
        buttons : buttons,
        position: jQuery.getDialogPosition(800,600)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAlias(id) {
    var url  = 'Function/appS/ids/customTest.php';
    var data = {
        delRuleId: id
    };
    var title  = '删除检测规则';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
		position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelAliasDialog(id,active) {
	var type = active;
	if (type==='on') {
		showErrorDialog('状态须停止后才能进行删除。');
	} else {
		var dialog  = loadingScreen('删除检测规则');
		var buttons = {};
		buttons[getMessage('Ok')] = function() {
			delAlias(id);
			$(this).remove();
		};
		buttons[getMessage('Cancel')]  = function() {
			$(this).remove();
		};
		var dialogParams = {
			width: 300,
			height: 160,
			buttons: buttons,
			position: jQuery.getDialogPosition(300,160)
		};
		dialog.setContent("<p>确定要删除任务" + id + "吗?</p>");
		dialog.setOptions(dialogParams);  
	}
}

function switchPhysicalDev(name, action, formId) {
    var title   = '启动/停止服务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
		var afterSuccessCallback = function() {
			freshTableAndPage();
		};
        ajaxSubmitForm($('#switchPhyDevForm_' + formId), '结果',undefined,
			undefined,afterSuccessCallback);
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
		position: jQuery.getDialogPosition(300,160)
    };
    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/appS/ids/customTest.php';
    freshTable(url, $('#customTestTable'));
    freshPagination(url, $('.pager'));
}


function chk_tcpNULL_clicked() {
	if ($("#tcp_empty").attr("checked")) {
		$("#tcp_retain_1").removeAttr("checked");
		$("#tcp_retain_2").removeAttr("checked");
		$("#tcp_urg").removeAttr("checked");
		$("#tcp_ack").removeAttr("checked");
		$("#tcp_psh").removeAttr("checked");
		$("#tcp_rst").removeAttr("checked");
		$("#tcp_syn").removeAttr("checked");
		$("#tcp_fin").removeAttr("checked");

		$("#tcp_retain_1").attr("disabled","disabled");
		$("#tcp_retain_2").attr("disabled","disabled");
		$("#tcp_urg").attr("disabled","disabled");
		$("#tcp_ack").attr("disabled","disabled");
		$("#tcp_psh").attr("disabled","disabled");
		$("#tcp_rst").attr("disabled","disabled");
		$("#tcp_syn").attr("disabled","disabled");
		$("#tcp_fin").attr("disabled","disabled");
	} else {
		$("#tcp_syn").attr("checked",true);
		
		$("#tcp_retain_1").removeAttr("disabled");
		$("#tcp_retain_2").removeAttr("disabled");
		$("#tcp_urg").removeAttr("disabled");
		$("#tcp_ack").removeAttr("disabled");
		$("#tcp_psh").removeAttr("disabled");
		$("#tcp_rst").removeAttr("disabled");
		$("#tcp_syn").removeAttr("disabled");
		$("#tcp_fin").removeAttr("disabled");
	}
}


function chk_one_clicked() {
	if (($("#tcp_retain_1").attr("checked")) || ($("#tcp_retain_2").attr("checked")) ||
		($("#tcp_urg").attr("checked")) || ($("#tcp_ack").attr("checked")) || 
		($("#tcp_psh").attr("checked")) || ($("#tcp_rst").attr("checked")) ||
		($("#tcp_syn").attr("checked")) || ($("#tcp_fin").attr("checked"))) {
		$("#tcp_empty").removeAttr("checked")

		$("#tcp_retain_1").removeAttr("disabled");
		$("#tcp_retain_2").removeAttr("disabled");
		$("#tcp_urg").removeAttr("disabled");
		$("#tcp_ack").removeAttr("disabled");
		$("#tcp_psh").removeAttr("disabled");
		$("#tcp_rst").removeAttr("disabled");
		$("#tcp_syn").removeAttr("disabled");
		$("#tcp_fin").removeAttr("disabled");
	} else {
		$("#tcp_empty").attr("checked",true);
		
		$("#tcp_retain_1").attr("disabled","disabled");
		$("#tcp_retain_2").attr("disabled","disabled");
		$("#tcp_urg").attr("disabled","disabled");
		$("#tcp_ack").attr("disabled","disabled");
		$("#tcp_psh").attr("disabled","disabled");
		$("#tcp_rst").attr("disabled","disabled");
		$("#tcp_syn").attr("disabled","disabled");
		$("#tcp_fin").attr("disabled","disabled");
	}
}

function changeToLinkMode() {
	var val = $("#link_mode").find("option:selected").val();
	if (val == 'icmp') {
		$('#icmp_type_div').show();
		$('#tcp_type_div').hide();
	} else if (val == 'tcp') {
		$('#icmp_type_div').hide();
		$('#tcp_type_div').show();
	} else if (val == 'udp') {
		$('#icmp_type_div').hide();
		$('#tcp_type_div').hide();
	}
}