function openAllCpuDialog() {
    var url   = 'Function/systemManagement/overview/overview.php';
    var title = '多核处理器下各物理/逻辑核的利用率';
    var data  = {
		openDualCoreDialog: true
    };
    var buttons = {};
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 700,
        height  : 400,
        buttons : buttons,
        position: ['left', 'top']
    };    
    showDialogByAjax(url, data, title, dialogParams);

}
