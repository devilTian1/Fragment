function OpenRoleTipsDialog(external_name) {
    var title   = '提示';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['关闭'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        Height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setContent('<p>角色['+external_name+']正被引用，不能修改或删除此角色。</p>');
    dialog.setOptions(dialogParams);
}

function isRoleInUseCheck(external_name,func) {
    var url  = 'Function/resConf/user/roleList.php';
    var data = {
        isInUseCheck  : true,
        checkName : external_name
    };
        var params = {
        type    : 'GET',
        success : function(result) {
            if (result == 'true') {
                OpenRoleTipsDialog(external_name);
            } else {
                func(external_name);
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function checkRolesInUse (key,roles,func) {
    var url  = 'Function/resConf/user/roleList.php';
    if (key == 'all') {
        var data = {
            checkAll  : true
        };
    } else {
            var data = {
            checkSpecRoles  : true,
            rolesArray: roles
        };
    }
        var params = {
        type    : 'GET',
        success : function(result) {
            if (result != 'false') {
                OpenRoleTipsDialog(result);
            } else {
                if (key == 'all') {
                    func();
                } else {
                    func(roles);
                }
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function openNewRoleListDialog() {
    var url   = 'Function/resConf/user/roleList.php';
    var title   = '定义角色列表';
    var data  = {
        addNewRole : true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editRoleListForm').valid()) {
            openNewRoleListDialog();
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRoleListForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editRoleListForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRoleListForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 522,
        height  : 410,
        position : jQuery.getDialogPosition('522','410'),
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
    buttons['关闭'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelAllRoleListDialog() {
    var dialog  = loadingScreen('删除角色列表');
    var buttons = {};
    if ('0' === $("input[name='dataCount']").val()) {
        dialog.setContent("<p>没有任何角色?</p>");
        buttons['关闭']  = function() {
            $(this).remove();
        };
    } else {
        buttons['确定'] = function() {
            var roles = [];
            checkRolesInUse('all',roles,delAllRoles);
            $(this).remove();
        };
        buttons['取消']  = function() {
            $(this).remove();
        };
        dialog.setContent("<p>确定要删除所有角色数据吗?</p>");
    }
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };    
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
    buttons['关闭'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
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
        buttons['关闭']  = function() {
            $(this).remove();
        };
    } else {
        dialog.setContent("<p>确定要删除已选的角色数据吗?</p>");
        buttons['确定'] = function() {
            if ($('#checkAllRole').attr('checked') === 'checked')  {
                checkRolesInUse('all',roles,delSpecRoles);
            } else {
                checkRolesInUse('spec',roles,delSpecRoles);
            }
            //delSpecRoles(roles);
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
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setOptions(dialogParams);
}

function openEditSpecRoleDialog(name) {
    var url   = 'Function/resConf/user/roleList.php';
    var data  = {
        editRoleName : name
    };
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRoleListForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editRoleListForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 522,
        height  : 410,
        position : jQuery.getDialogPosition('522','410'),
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
    buttons['关闭'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
        position : jQuery.getDialogPosition('250','170')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelSpecRoleDialog(name) {
    var dialog  = loadingScreen('删除角色列表');
    var buttons = {};
    buttons['确定'] = function() {
        delRole(name);
        $(this).remove();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
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
        position : jQuery.getDialogPosition('800','600'),
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
    if ($('#userListTable').length === 1) {
        tableDom = $('#userListTable');
    } else if (tableDom === undefined) {
        tableDom = $('#roleListTable');
    }
    if ($('#userPageDiv').length === 1) {
        pageDom = $('#userPagerDiv');
    } else if (pageDom === undefined) {
        pageDom = $('#rolePagerDiv');
    }
    freshTable(url, tableDom, false, pageDom);
    freshPagination(url, pageDom, tableDom);
}
