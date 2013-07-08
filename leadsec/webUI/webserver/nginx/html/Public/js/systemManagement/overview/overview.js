var opendialog;
function openAllCpuDialog() {
    var url   = 'Function/systemManagement/overview/overview.php';
    var title = '多核处理器下各物理/逻辑核的利用率';
    var data  = {
		openDualCoreDialog: true
    };
    var buttons = {};
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 850,
        height  : 560,
        buttons : buttons,
        position: ['left', 'top']
    };
    function successCallback(result, textStatus) {
        opendialog.setContent(result.msg);
    }
    opendialog = showDialogByAjax(url, data, title, dialogParams,
        '', successCallback);
}

function setConOption(w, h) {
    if (!w) {
        w = 850;
    }
    if (!h) {
        h = 560;
    }
    var buttons = {};
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : w,
        height  : h,
        buttons : buttons,
        position: ['left', 'top']
    }
    opendialog.setOptions(dialogParams);
}

