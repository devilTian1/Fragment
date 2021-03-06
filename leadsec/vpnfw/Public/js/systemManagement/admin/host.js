function openEditHostDialog(hostId) {
    var url  = 'Function/systemManagement/admin/host.php';
    var data = {
        tpl        : 'systemManagement/admin/editHostDialog.tpl',
        editHostId : hostId
    };
    var title   = '修改管理主机信息';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editHostForm').valid()) {
			var afterSuccessCallback = function() {
					freshTable(url, $('#hostTable'));
			};
            ajaxSubmitForm($('#editHostForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 650,
        height  : 284,
        buttons : buttons,
		position: jQuery.getDialogPosition(650,284)
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openNewHostDialog() {
	var num = $("#hostnum").val();
	if (num >=6) {
		showErrorDialog('管理主机不能超过6条记录!');
	} else {
		var title   = '添加管理主机';
		var url    = 'Function/systemManagement/admin/host.php';
		var data   = {
			openAddDialog: true
		};
		var buttons = {};
		buttons['添加下一条'] = function() {
			if ($('#editHostForm').valid()) {
				var afterSuccessCallback = function() {
					freshTable(url, $('#hostTable'));
				};
				openNewHostDialog();
				ajaxSubmitForm($('#editHostForm'), '结果',undefined,undefined,
					afterSuccessCallback);
				//freshHostList();
				freshTable(url, $('#hostTable'));
				$(this).remove();
			}
		};
		buttons['确定'] = function() {
			if ($('#editHostForm').valid()) {
				var afterSuccessCallback = function() {
					freshTable(url, $('#hostTable'));
				};
				ajaxSubmitForm($('#editHostForm'), '结果',undefined,undefined,
					afterSuccessCallback);
				//freshHostList();
				//freshTable(url, $('#hostTable'));
				$(this).remove();
			}
		};
		buttons['取消'] = function() {
			$(this).remove();
		};
		var dialogParams = {
			width   : 650,
			height  : 284,
			buttons : buttons,
			position: jQuery.getDialogPosition(650,284)
		};
		showDialogByAjax(url, data, title, dialogParams);
	}
}

function openDelHostDialog(ip, netmask) {
    var dialog  = loadingScreen('删除管理主机');
    var buttons = {};
    buttons[getMessage('Confirm')] = function() {
        delHost(ip, netmask);
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
    dialog.setContent("<p>确定要删除管理主机[" + ip + "]?</p>");
    dialog.setOptions(dialogParams);
}

function delHost(ip, netmask) {
    var url    = 'Function/systemManagement/admin/host.php';
    var data = {
        delHostIp: ip,
        delHostNetmask: netmask
    };
    var title  = '删除主机';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
       // freshHostList();
		freshTable(url, $('#hostTable'));
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

function openSnmpDialog() {
   var path = {
                '1' : 'systemManagement',
                '2' : 'conf'
            };
            var url  = 'Function/layout/showTab.php';
            var data = {
                tabPath : path,
                tabNum :  3
            };
            loadEmbedPage(url, data, $("#tab"));
}

function freshHostList() {
    var url  = 'Function/systemManagement/admin/host.php';
    var data = {
        freshHostList: true
    };
    loadEmbedPage(url, data, $('#hostTable>tbody'));
}

