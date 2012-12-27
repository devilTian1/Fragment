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

function openDelAllRoleListDialog() {

}

function openDelSpecRoleListDialog() {

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
