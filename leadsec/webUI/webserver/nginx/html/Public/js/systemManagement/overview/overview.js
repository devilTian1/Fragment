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

function getInitData(intval, curStampTime) {
    // generate an array of random data
    intval /= 1000;
    var data = [], i;
    for (i = -20; i < intval; i+=intval) {
        data.push({
            x: curStampTime * 1000 + i * 1000,
            y: 0
        });
    }
    return data;
}

function updateUsedStatus(cpuUsed, memUsed, chart1) {
    var left  = chart1.series[0].points[0];
    var right = chart1.series[1].points[0];
    left.update(cpuUsed, false);
    right.update(memUsed, false);
    chart1.redraw();
}
