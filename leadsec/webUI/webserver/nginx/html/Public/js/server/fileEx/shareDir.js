function showShareDirDialog(id) {
     $("#fileTree a[title!='_more']").die('click');
    var url   = 'Function/server/fileEx/shareDir.php';
    var title = '共享目录查询';
    var data  = {
        taskId: id
    };
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 740,
        height  : 700,
        buttons : buttons,
        position : jQuery.getDialogPosition('740','700')
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function freshTableAndPage() {
    var url = 'Function/server/fileEx/shareDir.php';
    freshTable(url, $('#shareDirTable'));
    freshPagination(url, $('.pager'));
}
