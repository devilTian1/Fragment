function openEditAddrGroupDialog(id) {
    var url  = 'Function/resConf/addr/addrGroup.php';
    var data = {
        tpl    : 'resConf/addr/editAddrGroupDialog.tpl',
        editId : id
    };
    var title   = '修改地址组';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        if ($('#editAddrGroupForm').valid()) {
            $('#addrGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAddrGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 370,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openNewAddrGroupDialog() {
    var url   = 'Function/resConf/addr/addrGroup.php';
    var title = '定义地址组';
    var data  = {
        tpl : 'resConf/addr/editAddrGroupDialog.tpl',
        openAddAddrGrpDialog: true
    };
    var buttons = {};
    buttons[getMessage('Add Next')] = function() {
        if ($('#editAddrGroupForm').valid()) {
            openNewAddrGroupDialog();
            $('#addrGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAddrGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Ok')] = function() {
        if ($('#editAddrGroupForm').valid()) {
            $('#addrGrpMember option').attr('selected', 'selected');
            ajaxSubmitForm($('#editAddrGroupForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons[getMessage('Cancel')] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 370,
        buttons : buttons,
        position: ['center', 'top']
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function delAddrGrp(name,id) {
    var url  = 'Function/resConf/addr/addrGroup.php';
    var data = {
        delName: name,
        delId: id
    };
    var title  = '删除地址组';
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
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

function openDelAddrGroupDialog(name,id) {
    var dialog  = loadingScreen('删除地址组');
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        delAddrGrp(name,id);
        $(this).remove();
        freshTableAndPage();
    };
    buttons[getMessage('Cancel')]  = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons
    };
    dialog.setContent("<p>确定要删除名称为" + name + "的地址组吗?</p>");
    dialog.setOptions(dialogParams);   
}

function freshTableAndPage() {
    var url = 'Function/resConf/addr/addrGroup.php';
    freshTable(url, $('#addrGroupTable'));
    freshPagination(url, $('.pager'));
}

function moveToAddrList() {
    $('#addrGrpMember option:selected').appendTo($('#addrList'));
}

function moveToAddrGrpMember() {	
	var ListValue = $('#addrList option:selected').val();
	var listlen = ListValue.length;
	var listType =ListValue.substring(listlen-4,listlen);
	var GrpValue = document.getElementById('addrGrpMember').value;  
	var Grplen = GrpValue.length;
	var GrpType =GrpValue.substring(Grplen-4,Grplen);
	var ipType = $('#iptype').val();
	if(ipType==""){
		//添加页面
		if (GrpValue =="") {
			$('#addrList option:selected').appendTo($('#addrGrpMember')); 			
		}else {
			if(ListValue =="any"){
				$('#addrList option:selected').appendTo($('#addrGrpMember')); 	
			}else {
				if (listType == GrpType) {
					$('#addrList option:selected').appendTo($('#addrGrpMember')); 
				}else {
					showErrorDialog('请添加与本组成员同IP类型的地址组成员');
				}
			}			
		}  	
	} else {
		//编辑页面
		if (GrpValue =="") {
			if(ListValue =="any"){
				$('#addrList option:selected').appendTo($('#addrGrpMember')); 
			}else {
				if (listType == ipType) {
					$('#addrList option:selected').appendTo($('#addrGrpMember')); 
				}else {
					showErrorDialog('请添加与本组成员同IP类型的地址组成员');
				}
			}						
		}else {
			if(ListValue =="any"){
				$('#addrList option:selected').appendTo($('#addrGrpMember')); 	
			}else {
				if (listType == ipType) {
						$('#addrList option:selected').appendTo($('#addrGrpMember')); 
				}else {
						showErrorDialog('请添加与本组成员同IP类型的地址组成员');
				} 
			}
		}			
	}  
}	          	

