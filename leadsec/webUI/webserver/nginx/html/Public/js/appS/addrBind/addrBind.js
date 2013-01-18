

function init() {
	$("#detectbyfec").attr("checked",'checked');
	$("#serverip").attr("disabled",'disabled') ;
}


function changetoip() {
	$("#serverip").removeAttr("disabled",'disabled') ;
	$("#fecchk").attr("disabled",'disabled'); 
	$("#switchbyip").val('on');
}


function changetofec() {
	$("#fecchk").removeAttr("disabled",'disabled'); 
	$("#serverip").attr("disabled",'disabled') ;
	$("#switchbyip").val('');
	

}



function detectall() {
	var form = $("#addrBindForm");
	var successCallback = function(result, textStatus) {
	    var content = result.msg;
		//alert(content);
		if (content==='0') {
			showErrorDialog('请选择网口');
		}
		if (content!=='0') {
			var dialog  = loadingScreen('结果');
			var dialogParams = {
				width: 250,
				height: 200
			};
			dialog.setContent("<p>正在探测，请稍后...</p>");
			dialog.setOptions(dialogParams); 
			setTimeout(function() { dialog.close(); },3000);
			setTimeout(function() { resultDialog(); },3000);
			
		}

	};
	if (form.valid()) {
        var dialog = ajaxSubmitForm(form, '结果', successCallback);
		dialog.close();
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
		buttons: buttons
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
        buttons: buttons
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
    var dialog_c = showDialogByAjax(url, data, '', dialogParams, '',
            successCallback, errorCallback);
    dialog_c.close();
	
}


function bind() {
	$("#action").val('bind');		   
	var form = $('#addrBindDialogForm');
	var successCallback = function(result,textStatus) {
		var content = result.msg;
		//alert(content);
		if (content==='3') {
			showErrorDialog('至少要选中一条记录');
		} else if (content==='4') {
			showErrorDialog('无探测到的ip/mac地址对');
		} else if ($.isArray(content)) {
			for (var i =0;i<content.length;i++) {
				showErrorDialog(content[i]+"已被绑定");
			}
		} else {
		   $('#accountTable tbody').html(content);
		}
	};
	if (form.valid()) {
        var bindform = ajaxSubmitForm(form, '结果', successCallback);
		bindform.close();
    }
		freshTable('Function/appS/addrBind/addrBind.php?tpl=editaddrtpl', $('#accountTable'),'ORDER BY id');
}

function delIpListDialog() {
	//alert('text');
	$("#action").val('del');	
	var form = $('#addrBindDialogForm');
	var successCallback = function(result,textStatus) {
		var content = result.msg;
		if (content==='0') {
			showErrorDialog('至少要选中一条记录')
		} else if (content==='empty') {
			showErrorDialog('无探测到的ip/mac地址对')
		} else {
			$('#ipListTable tbody').html(content);
		}
	};
	if (form.valid()) {
        var dialogform = ajaxSubmitForm(form, '结果', successCallback);
		dialogform.close();
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
			ajaxSubmitForm($('#editIpAddrForm'), '结果');
			$(this).remove();
		}
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 300,
        position : ['center', 'top'],
        buttons : buttons
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
    buttons['Ok'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openDelSpecIpDialog(ip) {
    var dialog  = loadingScreen('删除ip/mac地址列表');
    var buttons = {};
    buttons['Confirm'] = function() {
        del(ip);
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除" + ip + "此条记录吗?</p>");
    dialog.setOptions(dialogParams);
}


function openDelAllIpDialog() {
	var dialog  = loadingScreen('删除ip/mac地址列表');
    var buttons = {};
    buttons['Confirm'] = function() {
		delAllIp()
        $(this).remove();
    };
    buttons['Cancel']  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
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
    buttons['Ok'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
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
        dialog.setContent("<p>没有选择任何用户?</p>");
        buttons['Close']  = function() {
            $(this).remove();
        };
    } else {
        dialog.setContent("<p>确定要删除已选的用户数据吗?</p>");
        buttons['Confirm'] = function() {
            delSpecIp(ips);
            $(this).remove();
        };
        buttons['Cancel']  = function() {
            $(this).remove();
        };
    }
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
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
    buttons['Ok'] = function() {
        //freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 250,
        height  : 170,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}


function openNewAccountDialog() {
    var url   = 'Function/appS/addrBind/addrBind.php';
    var title   = '地址绑定与维护';
    var data  = {
        tpl : 'appS/addrBind/editIpDialog.tpl',
        addNewIp : true
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editIpDialogForm').valid()) {   
            openNewAccountDialog();
            ajaxSubmitForm($('#editIpDialogForm'), '结果');
            // freshTableAndPage();
            $(this).remove();  
		}
    };
    buttons['确定'] = function() {
        if ($('#editIpDialogForm').valid()) {
            ajaxSubmitForm($('#editIpDialogForm'), '结果');
           // freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
       // freshTableAndPage();
        $(this).remove();
    };
    var dialogParams = {
        width   : 600,
        height  : 300,
        position : ['center', 'top'],
        buttons : buttons
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