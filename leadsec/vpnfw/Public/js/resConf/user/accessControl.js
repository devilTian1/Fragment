function selectedOption() {
    $('#verList option').attr('selected', 'selected');
	$('#procList option').attr('selected', 'selected');
}

function addver() {
	var val          = $('#txt_gapver').val();
    var verListDom = $('#verList');
    var isValid = $('#editRuleListForm').validate().element('#txt_gapver');
    if (!isValid) {
        return false;
    }
    $('#txt_gapver').val('');
    if (val === '') {
        return false;
    }
    var isExisted = false;
    verListDom.find('option').each(function() {
        if ($(this).val() === val) {
            isExisted = true;
            return false;
        }
    });
    if (!isExisted) {
        $('<option title="' + val +'" value="' + val + '">' + val + '</option>')
            .appendTo(verListDom);
    }
	
}

function deleteVer() {
	var selectedDom = $('#verList option:selected');
	if (selectedDom.length === 0 ) {
        showErrorDialog(getMessage('请选择要删除的版本名称。'));
        return false;
    } else {
        selectedDom.remove();
    }
}

function cleanAllVer() {
    var verListDom = $('#verList');
    verListDom.html('');
}

function addProc() {
	var val          = $('#txt_gapProc').val();
    var procListDom = $('#procList');
    var isValid = $('#editRuleListForm').validate().element('#txt_gapver');
    if (!isValid) {
        return false;
    }
    $('#txt_gapProc').val('');
    if (val === '') {
        return false;
    }
    var isExisted = false;
    procListDom.find('option').each(function() {
        if ($(this).val() === val) {
            isExisted = true;
            return false;
        }
    });
    if (!isExisted) {
        $('<option title="' + val +'" value="' + val + '">' + val + '</option>')
            .appendTo(procListDom);
    }
}

function deleteProc() {
	var selectedDom = $('#procList option:selected');
	if (selectedDom.length === 0 ) {
        showErrorDialog(getMessage('请选择要删除的进程名称。'));
        return false;
    } else {
        selectedDom.remove();
    }
}

function cleanAllProc() {
	var procListDom = $('#procList');
    procListDom.html('');	
}

function openNewRuleListDialog() {
    var url   = 'Function/resConf/user/accessControl.php';
    var title   = '接入控制配置';
    var data  = {
        addNewRule : true
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRuleListForm').valid()) {
			selectedOption();
			var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRuleListForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 522,
        height  : 550,
        buttons : buttons,
		position: jQuery.getDialogPosition(522,550)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAllRules() {
    var url  = 'Function/resConf/user/accessControl.php';
    var data = {
        delAllRules : true
    };
    var title  = '删除接入控制列表';
    var buttons = {};
    buttons['确定'] = function() {
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

function openDelAllRuleListDialog() {
    var dialog  = loadingScreen('删除接入控制列表');
    var buttons = {};
    buttons['确定'] = function() {
        delAllRules();
        $(this).remove();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
		position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除所有数据吗?</p>");
    dialog.setOptions(dialogParams);   
}

function delSpecRules(roles) {
    var url  = 'Function/resConf/user/accessControl.php';
    if ($('#checkAllRole').attr('checked') === 'checked') {
        var data = {
            delAllRules: true
        };
    } else {
        var data = {
            delSpecRules: roles
        };
    }
    var title  = '删除角色列表';
    var buttons = {};
    buttons['确定'] = function() {
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

function openBatchDelSpecRuleDialog() {
    var roles = [];
    $('input:checkbox[name="checkSpecRole"]:checked').each(function(i) {
        roles[i] = $(this).parent().next().next().html();
    });
    var dialog  = loadingScreen('删除已选角色');
    var buttons = {};
    if (roles.length === 0) {
        dialog.setContent("<p>没有选择任何角色?</p>");
        buttons['关闭']  = function() {
            $(this).remove();
        };
    } else {
        dialog.setContent("<p>确定要删除已选的数据吗?</p>");
        buttons['确定'] = function() {
            delSpecRules(roles);
            $(this).remove();
        };
        buttons['取消']  = function() {
            $(this).remove();
        };
    }
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
		position: jQuery.getDialogPosition(300,160)
    };
    dialog.setOptions(dialogParams);

}

function openEditSpecRuleDialog(name) {
    var url   = 'Function/resConf/user/accessControl.php';
    var data  = {
        editRuleName : name
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRuleListForm').valid()) {
			selectedOption();
			var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRuleListForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 522,
        height  : 550,
        buttons : buttons,
		position: jQuery.getDialogPosition(522,550)
    };
    showDialogByAjax(url, data, '编辑接入控制列表', dialogParams);
}

function delRule(name) {
    var url  = 'Function/resConf/user/accessControl.php';
    var data = {
        delRuleName: name
    };
    var title  = '删除接入控制列表';
    var buttons = {};
    buttons['确定'] = function() {
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

function openDelSpecRuleDialog(name) {
    var dialog  = loadingScreen('删除接入控制列表');
    var buttons = {};
    buttons['确定'] = function() {
        delRule(name);
        $(this).remove();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
		position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除规则名称为" + name + "的数据吗?</p>");
    dialog.setOptions(dialogParams);
}

function showUsersDialog(id) {
    var url   = 'Function/resConf/user/roleList.php';
    var title   = '用户显示';
    var data  = {
        showUsersByRoleId: id
    };
    var buttons = {};
    buttons['关闭'] = function() {
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

function dynCheckbox() {
    if ($('input:checkbox[name="checkSpecRole"]:unchecked').length === 0) {
        $('#checkAllRole').attr('checked', 'checked');
    } else {
        $('#checkAllRole').removeAttr('checked');
    }
}
function checkAllRole() {
    if ($('#checkAllRole').attr('checked')) {
        $('input:checkbox[name="checkSpecRole"]').attr('checked', 'checked');
    } else {
        $('input:checkbox[name="checkSpecRole"]').removeAttr('checked');
    }
}

function freshTableAndPage(tableDom) {
    var url = 'Function/resConf/user/accessControl.php';
	var tableDom = $('#accessControlListTable');
    freshTable(url,tableDom);
    freshPagination(url,($('.pager')));
}

function toggleCNameDiv() {
    if ($("input:radio[name='checkVer']:checked").val() === '1') {
        $(".cNameDiv").show();
    } else { //N
        $(".cNameDiv").hide();
    }
}

function togglePNameDiv() {
    if ($("input:radio[name='checkProc']:checked").val() === '1') {
        $("#procDiv").show();
    } else { //N
        $("#procDiv").hide();
    }
}
