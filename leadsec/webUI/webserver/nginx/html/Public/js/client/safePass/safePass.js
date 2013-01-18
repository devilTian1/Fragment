function addOrEditSafePass(type, title) {
    if (type === 'next') {
        openNewSafePassDialog();
    }
    var resultDialog  = loadingScreen(title);
    resultDialog.dialog('moveToTop');
    var buttons = {};
    buttons['Ok'] = function() {    	
        resultDialog.close();
    }
    resultDialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons
    });
    var successCallback = function(result, textStatus) {
        resultDialog.setContent($('<p>' + result.msg + '</p>'));
        freshTableAndPage();        
    }
    var dialog = ajaxSubmitForm($('#editSafePassForm'), '结果',
        successCallback);
    dialog.close();
}

function openEditSafePassDialog(id) {
    var url  = 'Function/client/safePass/safePass.php';
    var data = {
        tpl    : 'client/safePass/safePass_editDialog.tpl',
        editId : id
    };
    var title   = '管理安全通道';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editSafePassForm').valid()) {
        	addOrEditSafePass('edit','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 730,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewSafePassDialog() {
    var url   = 'Function/client/safePass/safePass.php';
    var title = '管理安全通道';
    var data  = {
        tpl : 'client/safePass/safePass_editDialog.tpl',
		openAddDialog: true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editSafePassForm').valid()) {
        	addOrEditSafePass('next','结果');
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editSafePassForm').valid()) {
        	addOrEditSafePass('add','结果');
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 680,
        height  : 730,
        buttons : buttons,
        position: ['center', 'top']
    };    
    showDialogByAjax(url, data, title, dialogParams);
}

function delSafePass(id) {
    var url  = 'Function/client/safePass/safePass.php';
    var data = {
        delId: id
    };
    var title  = '删除安全通道';
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

function openDelSafePassDialog(id) {
    var dialog  = loadingScreen('删除安全通道');
    var buttons = {};
    buttons['确定'] = function() {
        delSafePass(id);
        $(this).remove();
        freshTableAndPage();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除任务号为" + id + "的安全通道吗?</p>");
    dialog.setOptions(dialogParams);   
}

function switchSafePassActive(id, action) {
    var title   = '启动/停止任务';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        ajaxSubmitForm($('#switchSafePassActiveForm_' + id), '结果');
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

/******************************************
*函数:function filterRes(daName)
*说明:页面选择IPV4，IPV6选项时，筛选源，目的地址
*     中的ip，只显示支持的地址类型
*******************************************/
function filterRes(daName) {
    //var type    = $('input:radio[name="ipType"]:checked').val();
    // type目前只支持IPV4
    var type    = 'ipv4';
    var saOpts  = $('select[name="srcIpList"]');
    if (daName == "trans") {
    	var daOpts  = $('select[name="destIpList_trans"]');
	} else {
		var daOpts  = $('select[name="destIpList_normal"]');
	}
    saOpts.children('span').showOption(); 
    daOpts.children('span').showOption(); 
    if (type === 'ipv4') {
        saOpts.find('option[value$="_ipv6"]').hideOption();
        if (daName == "trans") {
        	daOpts.find('option[value$="_ipv6"]').hideOption();
    	} else {
    		daOpts.find('option[value*=":"]').hideOption();
    	}
    } else if (type === 'ipv6') {
        saOpts.find('option[value$="_ipv4"]').hideOption();
        if (daName == "trans") {
        	daOpts.find('option[value$="_ipv4"]').hideOption();
    	} else {
    		daOpts.find('option[value*="."]').hideOption();
    	}
    } else {
    }
    saOpts.find('option:visible:eq(0)').attr('selected','selected');
    daOpts.find('option:visible:eq(0)').attr('selected','selected');
}

/******************************************
*函数:function filterRes(daName)
*说明:页面选择访问类型时，透明访问-->目的地址显示地址
*     普通访问-->目的地址显示接口(别名，物理，冗余设备)
*******************************************/
function changeDestIpList() {
	$("#div_destIp_normal").addClass("hide");
	$("#div_destIp_trans").addClass("hide");
	if ($("input[name='accessType']:checked").val() == "no") {
		$("#div_destIp_trans").removeClass("hide");
	} else {
		$("#div_destIp_normal").removeClass("hide");		
	}
	filterIpList();
}

function filterIpList() {
	if($("input[name='accessType']:checked").attr("value") == "no") {
		// 如果是透明访问
		filterRes('trans');
	} else {
		// 如果是普通访问		
		filterRes('normal');
	}
}

function portOnCtrl() {
	var service = $("select[name='serviceList'] option:selected").val();
	if (service == "tcp_any" || service== "udp_any") {
		$("#sPortDiv").removeClass("hide");
		$("#dPortDiv").removeClass("hide");
	} else {
		$("#sPortDiv").addClass("hide");
		$("#dPortDiv").addClass("hide");
	}
}

function freshTableAndPage() {
    var url = 'Function/client/safePass/safePass.php';
    freshTable(url, $('#safePassTable'));
    freshPagination(url, $('.pager'));
}