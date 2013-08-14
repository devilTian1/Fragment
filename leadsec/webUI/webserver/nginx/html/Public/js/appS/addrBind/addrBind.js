function setServiceForm(action) {
	var title   = '启动/停止服务';
    var dialog  = loadingScreen(title);
    var buttons = {};   
    buttons[getMessage('Ok')] = function() {
        var afterSuccessCallback = function(result, textStatus) {
            if (result.status =='0') { 
				if (action == 'on') {
					$("#switch_serveice").val('off');
					$("button[name='buttonOff']").button({ disabled: false});
					$("button[name='buttonOn']").button({ disabled: true});
					$("#status").html('启动');
				} else {
					$("#switch_serveice").val('on');
					$("button[name='buttonOff']").button({ disabled: true});
					$("button[name='buttonOn']").button({ disabled: false});
					$("#status").html('停止');
				}
            }
        }
        ajaxSubmitForm($('#ipmacServiceForm'), '结果', undefined,
            undefined, afterSuccessCallback);
        $(this).remove();
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };    
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position: jQuery.getDialogPosition(300,160)
    };
    var str = action === 'on' ? '启动' : '停止';
    dialog.setContent('<p>确定' + str + '服务吗?</p>');
    dialog.setOptions(dialogParams);
	
}



function init() {
	$("#detectbyfec").attr("checked",'checked');
	$("#serverip").attr("disabled",'disabled') ;
}


function changetoip() {
	$("#serverip").removeAttr("disabled",'disabled') ;
	//$("#fecchk").attr("disabled",'disabled'); 
	$("input:checkbox[id^='fecchk']").attr("disabled",'disabled');
	$("#switchbyip").val('on');
}


function changetofec() {
	//$("#fecchk").removeAttr("disabled",'disabled'); 
	$("input:checkbox[id^='fecchk']").removeAttr("disabled",'disabled');
	$("#serverip").attr("disabled",'disabled') ;
	$("#switchbyip").val('');
	

}



function detectall() {
	var form = $("#addrBindForm");
	var afterSuccessCallback = function(result, textStatus) {
	    var content = result.msg;
		//alert(content);
		if (content==='0') {
			showErrorDialog('请选择网口');
		} else {

		}
	};
	if (form.valid()) {
        ajaxSubmitForm(form, '结果', undefined,undefined,afterSuccessCallback);
    }
}



function resultDialog() {
	var dialog  = loadingScreen('地址绑定');
	var buttons = {};
	buttons['确定'] = function() {
		$(this).remove();
	};
	var dialogParams = {
		width: 250,
		height: 200,
		buttons: buttons,
		position: jQuery.getDialogPosition(250,200)
	};
	dialog.setContent("<p>探测完毕，请点击按钮<探测到的IP/MAC对>查看探测结果！</p>");
	dialog.setOptions(dialogParams); 

}

function detectResultShow() {
	var dialog  = loadingScreen('探测到的 IP/MAC 对');
	var url   = 'Function/appS/addrBind/addrBind.php';
	var data  = {
        showResult : true
    };
    var buttons = {};
	buttons['删除'] = function() {
		delIpListDialog();
		freshTable('Function/appS/addrBind/addrBind.php?tpl=detecttpl', $('#ipListTable'));
    };
    buttons['绑定'] = function() {
		bind();
        $(this).remove();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 650,
        height: 620,
        buttons: buttons,
		position: jQuery.getDialogPosition(650,620)
    };
    dialog.setOptions(dialogParams);
	
	var successCallback = function(result, textStatus) {
        dialog.setContent(result.msg);
        dialog.setOptions(dialogParams);
    };
	
	
    var errorCallback = function(XMLHttpRequest, textStatus, errorThrown) {
        result = 'ERROR: AJAX error. Respone text: ' +
            XMLHttpRequest.responseText + ', status:' + textStatus +
            ', errorThrown:' + errorThrown;
		dialog.setContent($('<p>' + result + '</p>'));
    };
	
    var dialog_c = showDialogByAjax(url, data, '', dialogParams, '',successCallback,errorCallback);
    dialog_c.close();
	
}


function bind() {
	$("#action").val('bind');
	var form = $('#addrBindDialogForm');
	if (form.valid()) {
		var afterSuccessCallback = function(result,textStatus) {
		};
		ajaxSubmitForm(form, '结果', undefined,undefined,afterSuccessCallback);
		$(this).remove();
		freshTable('Function/appS/addrBind/addrBind.php?tpl=editaddrtpl', $('#accountTable'),'ORDER BY id');
	}
}

function bindsucsess() {
	var dialog  = loadingScreen('地址绑定');
	var buttons = {};
	buttons['确定'] = function() {
		$(this).remove();
	};
	var dialogParams = {
		width: 250,
		height: 200,
		buttons: buttons,
		position: jQuery.getDialogPosition(250,210)
	};
	dialog.setContent("<p>绑定成功！</p>");
	dialog.setOptions(dialogParams); 

}

function delIpListDialog() {
	//alert('text');
	$("#action").val('del');	
	var form = $('#addrBindDialogForm');
	if (form.valid()) {
	var afterSuccessCallback = function(result,textStatus) {
		var content = result.msg;
		if (content==='empty') {
			showErrorDialog('无探测到的ip/mac地址对。')
		} else {

		}
	};
	ajaxSubmitForm(form, '结果', undefined,undefined,afterSuccessCallback);
	$(this).remove();
    }
}

function edit(id) {
	var dialog = loadingScreen('地址绑定维护');
    var url   = 'Function/appS/addrBind/addrBind.php';
    var data  = {
        editIpId : id
    };
    var buttons = {};
    buttons['确定'] = function() {
		if ($('#editIpAddrForm').valid()) {
			var afterSuccessCallback = function() {
                freshTableAndPage();
            };
			ajaxSubmitForm($('#editIpAddrForm'), '结果',undefined,
				undefined,afterSuccessCallback);
			$(this).remove();
		}
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 300,
        buttons : buttons,
		position: jQuery.getDialogPosition(600,300)
    };
    var successCallback = function(result, textStatus) {
        dialog.setContent(result.msg);
        dialog.setOptions(dialogParams);
    };
    var errorCallback = function(XMLHttpRequest, textStatus, errorThrown) {
        result = 'ERROR: AJAX error. Respone text: ' +
            XMLHttpRequest.responseText + ', status:' + textStatus +
            ', errorThrown:' + errorThrown;
        dialog.setContent($('<p>' + result + '</p>'));
    };
    var dialog_c = showDialogByAjax(url, data, '', dialogParams, '',
            successCallback, errorCallback);
    dialog_c.close();
}


function del(ip) {
    var url  = 'Function/appS/addrBind/addrBind.php';
    var data = {
        deleteIpId : ip
    };
    var title  = '删除ip/mac地址列表';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
		position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openDelSpecIpDialog(ip) {
    var dialog  = loadingScreen('删除ip/mac地址列表');
    var buttons = {};
    buttons['确定'] = function() {
        del(ip);
		freshTableAndPage();
        $(this).remove();
    };
    buttons['取消']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
		position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除" + ip + "此条记录吗?</p>");
    dialog.setOptions(dialogParams);
}


function openDelAllIpDialog() {
	var dialog  = loadingScreen('删除ip/mac地址列表');
    var buttons = {};
    buttons[getMessage('Confirm')] = function() {
		delAllIp()
		freshTableAndPage();
        $(this).remove();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
		position: jQuery.getDialogPosition(300,160)
    };
    dialog.setContent("<p>确定要删除所有的记录吗?</p>");
    dialog.setOptions(dialogParams);

}


function delAllIp() {
    var url  = 'Function/appS/addrBind/addrBind.php';
    var data = {
        delAllIp : true
    };
    var title  = '删除ip/mac地址列表';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
		position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function checkAllIp() {
    if ($('#checkAllIp').attr('checked')) {
        $('input:checkbox[name="checkSpecIp"]').attr('checked', 'checked');
    } else {
        $('input:checkbox[name="checkSpecIp"]').removeAttr('checked');
    }
}

function openDelSpecIpListDialog() {
    var ips = [];
    $('input:checkbox[name="checkSpecIp"]:checked').each(function(i) {
        ips[i] = $(this).parent().next().html();
    });
    var dialog  = loadingScreen('删除已选ip/mac地址对');
    var buttons = {};
    if (ips.length === 0) {
        dialog.setContent("<p>没有选择任何用户！</p>");
        buttons['关闭']  = function() {
            $(this).remove();
        };
    } else {
        dialog.setContent("<p>确定要删除已选的用户数据吗?</p>");
        buttons[getMessage('Confirm')] = function() {
            delSpecIp(ips);
            $(this).remove();
        };
        buttons[getMessage('Cancel')]  = function() {
            $(this).remove();
        };
    }
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
		position: jQuery.getDialogPosition(300,160)
    };
    dialog.setOptions(dialogParams);
}


function delSpecIp(ips) {
    var url  = 'Function/appS/addrBind/addrBind.php';
    if ($('#checkAllIp').attr('checked') === 'checked') {
        var data = {
            delAllIp: true
        };
    } else {
        var data = {
            delSpecIps: ips
        };
    }
    var title  = '删除ip/mac地址记录';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons,
		position: jQuery.getDialogPosition(250,170)
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openNewAccountDialog() {
    var url   = 'Function/appS/addrBind/addrBind.php';
    var title   = '地址绑定与维护';
    var data  = {
        tpl : 'appS/addrBind/editAddrBindDialog.tpl',
        addNewIp : true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editIpAddrForm').valid()) {   
            openNewAccountDialog();
            ajaxSubmitForm($('#editIpAddrForm'), '结果');
            // freshTableAndPage();
            $(this).remove();  
		}
    };
    buttons['确定'] = function() {
        if ($('#editIpAddrForm').valid()) {
			var afterSuccessCallback = function() {
                freshTableAndPage();
            };
            ajaxSubmitForm($('#editIpAddrForm'), '结果',undefined,
				undefined,afterSuccessCallback);
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 300,
        buttons : buttons,
		position: jQuery.getDialogPosition(600,300)
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function checkAll() {
	if ($('#checkAllUser').attr('checked')) {
        $('input:checkbox[name="checkSpecUser[]"]').attr('checked', 'checked');
    } else {
        $('input:checkbox[name="checkSpecUser[]"]').removeAttr('checked');
    }
}

function freshTableAndPage() {
    var url = 'Function/appS/addrBind/addrBind.php';
    freshTable(url, $('#accountTable'));
    freshPagination(url, $('.pager'));
}

function selectOne(obj) {
	var objCheckBox = $('input:checkbox[name="ifname"]');
	for (var i=0;i<objCheckBox.length;i++) {
		if (objCheckBox[i]!=obj){
			objCheckBox[i].checked = false;
		} else {
			objCheckBox[i].checked = true;
		}
	}
}