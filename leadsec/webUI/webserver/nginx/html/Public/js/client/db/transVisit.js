function openEditDialog(id) {
    var url  = 'Function/client/db/transVisit.php';
    var data = {
        tpl    : 'client/db/transVisit_editDialog.tpl',
        editId : id
    };
    var title   = '修改透明访问';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 440,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewDialog() {
    var url   = 'Function/client/db/transVisit.php';
    var title = '添加透明访问';
    var data  = {
        tpl : 'client/db/transVisit_editDialog.tpl',
		openDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editForm').valid()) {
            openNewDialog();
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editForm').valid()) {
            ajaxSubmitForm($('#editForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 440,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function del(id) {
    var url  = 'Function/client/db/transVisit.php';
    var data = {
        delId: id
    };
    var title  = '删除透明访问';
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

function openDelDialog(id) {
    var dialog  = loadingScreen('删除透明访问');
    var buttons = {};
    buttons['Confirm'] = function() {
        del(id);
        $(this).remove();
        freshTableAndPage();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除名称为" + id + "的透明访问吗?</p>");
    dialog.setOptions(dialogParams);   
}
function switchClientCommSer(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchClientCommForm_' + id), '结果');
        freshTableAndPage();
        $(this).remove();
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };

    var str = action === 'disable' ? '停止' : '启动';
    dialog.setContent('<p>确定' + str + '任务[' +  id + ']吗?</p>');
    dialog.setOptions(dialogParams);
}

function getOracleDataIp(tableDom) {
    // get oracle data ip
    if (tableDom === undefined) {
        var oracleDataIp = $('#oracleDataIp option:selected').val();       
    } else {
        var oracleDataIp = tableDom.find('select[name="oracleDataIp"] option:selected').val();
    }
    return {
    	oracleDataIp: oracleDataIp
    }
}
function filterRes() {
    var saOpts  = $('select[name="sAddress"]');
    var daOpts  = $('select[name="lAddress"]');
    saOpts.find('option[value$="_ipv6"]').hideOption();
    daOpts.find('option[value$="_ipv6"]').hideOption();
}
function freshOracleDataIpTable(url,tableDom,oracleDataIp) {
    if (!oracleDataIp) {
        var oracleDataIp = getOracleDataIp(tableDom);
    }
    var data = {
    		oracleDataIp: oracleDataIp
    };
    var params = {
        success : function(result, textStatus) {
            tableDom.children('tbody').html(result);
        }
    };
    loadEmbedPage(url, data, tableDom.children('tbody'), params);
}
function freshTableAndPage() {
    var url = 'Function/client/db/transVisit.php';
    freshTable(url, $('#transVisitTable'));
    freshPagination(url, $('.pager'));
}