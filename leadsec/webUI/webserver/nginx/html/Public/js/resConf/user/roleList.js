function openNewRoleListDialog() {
    var url   = 'Function/resConf/user/roleList.php';
    var title   = '定义用户列表';
    var data  = {
        addNewRole : true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editRoleListForm').valid()) {
            openNewRoleListDialog();
            ajaxSubmitForm($('#editRoleListForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editRoleListForm').valid()) {
            ajaxSubmitForm($('#editRoleListForm'), '结果');
            freshTableAndPage();
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
        position : ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAllRoles() {
    var url  = 'Function/resConf/user/roleList.php';
    var data = {
        delAllRoles : true
    };
    var title  = '删除角色列表';
    var buttons = {};
    buttons['Ok'] = function() {
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

function openDelAllRoleListDialog() {
    var dialog  = loadingScreen('删除角色列表');
    var buttons = {};
    buttons['Confirm'] = function() {
        delAllRoles();
        freshTableAndPage();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除所有角色数据吗?</p>");
    dialog.setOptions(dialogParams);   
}

function delSpecRoles(roles) {
    var url  = 'Function/resConf/user/roleList.php';
    if ($('#checkAllRole').attr('checked') === 'checked') {
        var data = {
            delAllRoles: true
        };
    } else {
        var data = {
            delSpecRoles: roles
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
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openBatchDelSpecRoleDialog() {
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
        dialog.setContent("<p>确定要删除已选的角色数据吗?</p>");
        buttons['Confirm'] = function() {
            delSpecRoles(roles);
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
        buttons: buttons
    };
    dialog.setOptions(dialogParams);

}

function openEditSpecRoleDialog(id) {
    var url   = 'Function/resConf/user/roleList.php';
    var data  = {
        editRoleId : id
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRoleListForm').valid()) {
            ajaxSubmitForm($('#editRoleListForm'), '结果');
            freshTableAndPage();
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
        position : ['center', 'top'],
        buttons : buttons
    };
    showDialogByAjax(url, data, '编辑角色列表', dialogParams);
}

function delRole(name) {
    var url  = 'Function/resConf/user/roleList.php';
    var data = {
        delRoleName: name
    };
    var title  = '删除角色列表';
    var buttons = {};
    buttons['Ok'] = function() {
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

function openDelSpecRoleDialog(name) {
    var dialog  = loadingScreen('删除角色列表');
    var buttons = {};
    buttons['Confirm'] = function() {
        delRole(name);
        freshTableAndPage();
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除角色名称为" + name + "的数据吗?</p>");
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
        position : ['left', 'top'],
        buttons : buttons
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

function freshTableAndPage(tableDom, pageDom) {
    var url = 'Function/resConf/user/roleList.php';
    var id  = $('#roleId').val();
    if (id !== undefined) {
        url += '?roleId=' + id;
    }
    if (tableDom === undefined) {
        tableDom = $('#roleListTable');
    }
    if (pageDom === undefined) {
        pageDom = $('#rolePagerDiv');
    }
    freshTable(url, tableDom, false, pageDom);
    freshPagination(url, pageDom, tableDom);
}
