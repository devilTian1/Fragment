function openEditPhysicalDialog(external_name) {
    var url  = 'Function/networkManagement/interface/physical.php';
    var data = {
        name : external_name
    };
    var title   = '修改物理设备';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editPhysicalForm').valid()) {
            var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editPhysicalForm'), '结果', undefined,
                undefined, afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 550,
        buttons : buttons,
        position : ['center', 'top'],
        position : jQuery.getDialogPosition('620','550')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function switchPhysicalDev(name, action, formId) {
    var title   = '启动/停止物理设备';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        var afterSuccessCallback = function() {
                freshTableAndPage();
        };
        ajaxSubmitForm($('#switchPhyDevForm_' + formId), '结果', undefined,
                undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '设备[' + name  + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function OpenTipsDialog(external_name, result) {
    var title   = '提示';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['关闭'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 350,
        height: 400,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','400')
    };
    var table = '';
    if (result.length > 0) {
        table += '<table><tr><th>模块名称</th><th>任务号</th></tr>'
        for (var i in result) {
            table += '<tr><td>' + result[i].mod + '</td><td>[' +
                result[i].id + ']</td></tr>';
        }
        table += '</table>';
    }
    dialog.setContent('<p>物理设备[' + external_name  + ']正被引用，不能修改或删除此设备。</p>' + table);
    dialog.setOptions(dialogParams);
}

function isSwitchCheck(external_name,action,formId,func) {
    var url  = 'Function/networkManagement/interface/physical.php';
    var data = {
        isInUseCheck  : true,
        checkName : external_name
    };
    var params = {
        dataType : 'JSON',
        type     : 'GET',
        success  : function(result) {
            if (result.msg === 'false') {
                func(external_name,action,formId);
            } else {
                OpenTipsDialog(external_name, result.msg);
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function isInUseCheck(external_name,func, checkActive) {
    var url  = 'Function/networkManagement/interface/physical.php';
    var data = {
        checkActive: checkActive,
        isInUseCheck  : true,
        checkName : external_name
    };
    var params = {
        dataType : 'JSON',
        type     : 'GET',
        success  : function(result) {
            if (result.msg === 'false') {
                func(external_name);
            } else {
                OpenTipsDialog(external_name, result.msg);
            }
        }
    };    
    //showDialogByAjax(url, data, title, dialogParams);    
    loadAjax(url, data, params);
}

function freshTableAndPage() {
    var url = 'Function/networkManagement/interface/physical.php';
    freshTable(url, $('#physicalTable'));
    freshPagination(url, $('.pager'));
}
