function selectedOption() {
    $('#verList option').attr('selected', 'selected');
	$('#procList option').attr('selected', 'selected');
}

function addver() {
    var newTxt_gapverDom = $('#txt_gapver');
    if ($("#editRuleListForm").validate().element(newTxt_gapverDom) === true) {
        var isDuplicated = false;
        var rule           = newTxt_gapverDom.val();
        if (rule === '') {
            return false;
        }
        var appendToDom  = $('#verList');
        newTxt_gapverDom.val('');
        appendToDom.children('option').each(function() {
            if (rule === $(this).val()) {
                isDuplicated = true;
                return false;
            }
        });
        if (isDuplicated === false) {
            var optionCount = appendToDom.children('option').length;
            $('<option class="multiSelect option" value="' + rule +
                '" id="verList-' + optionCount + '">' + rule
                +'</option>').appendTo(appendToDom);
        }
    }
}

function deleteVer() {
    $('#verList option:selected').remove();
}

function cleanAllVer() {
    var verListDom = $('#verList');
    verListDom.html('');
}

function addProc() {
    var newTxt_gapProcDom = $('#txt_gapProc');
    if ($("#editRuleListForm").validate().element(newTxt_gapProcDom) === true) {
        var isDuplicated = false;
        var proc           = newTxt_gapProcDom.val();
        if (proc === '') {
            return false;
        }
        var appendToDom  = $('#procList');
        newTxt_gapProcDom.val('');
        appendToDom.children('option').each(function() {
            if (proc === $(this).val()) {
                isDuplicated = true;
                return false;
            }
        });
        if (isDuplicated === false) {
            var optionCount = appendToDom.children('option').length;
            $('<option class="multiSelect option" value="' + proc +
                '" id="procList-' + optionCount + '">' + proc
                +'</option>').appendTo(appendToDom);
        }
    }
}

function deleteProc() {
    $('#procList option:selected').remove();
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
    buttons['Ok'] = function() {
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
    buttons['Confirm'] = function() {
        delAllRules();
        freshTableAndPage();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
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
    buttons['Ok'] = function() {
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
        buttons['Close']  = function() {
            $(this).remove();
        };
    } else {
        dialog.setContent("<p>确定要删除已选的数据吗?</p>");
        buttons['Confirm'] = function() {
            delSpecRules(roles);
            freshTableAndPage();
            $(this).remove();
        };
        buttons['Cancel']  = function() {
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
    buttons['Ok'] = function() {
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
    buttons['Confirm'] = function() {
        delRule(name);
        freshTableAndPage();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
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
