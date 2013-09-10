function openEditPhysicalDialog(external_name) {
    var adminChkResult = 0;
    var url  = 'index.php?R=systemManagement/networkConf/interfaceConf/physical/getSpecDataByName';
    var data = {
        name : external_name
    };
    var title   = '修改物理设备';
    var buttons = {};
    buttons['确定'] = function() {
        var adminDef = $("#chkAdminDef").val();
        var adminCur = $("#admin");
        if (adminDef === '1' && adminCur.attr("checked")!=='checked') {
            var ret = confirm("关闭设备的用于管理属性可能会导致设备不能被管理，是否继续？");
            if (ret === true) {
                adminChkResult = 1;
            } else {
                adminCur.attr("checked","checked");
            }
        } else {
            adminChkResult = 1;
        }
        if (adminChkResult===1 && $('#editPhysicalForm').valid()) {
            if ($("input[name='hid_vpn']").val() == '1' && $("input[name='hid_ip']").val() != $("input[name='devIpv4']").val()) {
        		alert("协商口的IP地址已经改变，VPN进程将自动重启！");
        	  }
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

function displayAdvanced() {
    $("#div_advanced").toggle(); 
}

function bindRangeCtrl() {
    if($("#checkBindRange").attr("checked") === "checked" && $("#checkBindRange").attr("disabled") !== "disabled") {
        $("#vlan_bindrange").removeAttr("disabled");
        $("#vlan_bindrange").val('2-4094');
    } else {
        $("#vlan_bindrange").attr("disabled",'disabled');
        $("#vlan_bindrange").val('');
    }
}

function vlanIdCtrl() {
    if($("#checkVlanId").attr("checked") === "checked" && $("#checkVlanId").attr("disabled") !== "disabled") {
        $("#vlan_id").removeAttr("disabled");
        $("#vlan_id").val('1');
    } else {
        $("#vlan_id").attr("disabled",'disabled');
        $("#vlan_id").val('');
    }
}

function vlanOnCtrl() {
    bindRangeCtrl();
    vlanIdCtrl();
}

function dhcpOnCtrl() {
    if($("#chkOpenDHCP").attr("checked") === "checked" && $("#chkOpenDHCP").attr("disabled") !== "disabled") {
        $("#DHCPAddr").removeAttr("disabled");
    } else {
        $("#DHCPAddr").attr("disabled",'disabled');
    }
}

function dynDomainCtrl() {
    if($("input[name='chkDynDomain']").attr("checked") === "checked" && $("input[name='chkDynDomain']").attr("disabled") !== "disabled") {
        $("input[name='DynDomain']").removeAttr("disabled");
    } else {
        $("input[name='DynDomain']").attr("disabled",'disabled');
    }
}

function bindwidthOnCtrl() {
    if($("#chkBandwidthManage").attr("disabled") === "disabled") {
        $("#BandwidthValue").attr("disabled",'disabled');
        return;
    }
    if($("#chkBandwidthManage").attr("checked") !== "checked") {
        if($("#chkBandwidthDef").val() === '1') {
            var ret = confirm("停止设备的带宽管理功能将会导致带宽管理规则失去作用,是否继续？");
            if (ret === false) {
                $("#chkBandwidthManage").attr("checked",'checked');                
                return;
            }
        }
        $("#BandwidthValue").attr("disabled",'disabled');
    } else {
        $("#BandwidthValue").removeAttr("disabled");
    }
}

function switchRouteWorkMode(flagOn) {
    if(flagOn === 1) {
    // route
        $("#routeDiv").show();
        $("#routeDiv2").show();
        $("#divAntispoof").show();
        $("#addrDiv").show();
        $("#ipaddr_type").removeAttr("disabled");
        $("#devIpv4").removeAttr("disabled");
        $("input[name='devIpv4Netmask']").removeAttr("disabled");
        $("input[name='admin']").removeAttr("disabled");
        $("input[name='ping']").removeAttr("disabled");
        $("input[name='traceroute']").removeAttr("disabled");
        $("input[name='chkDynDomain']").removeAttr("disabled");
        $("input[name='antispoof']").removeAttr("disabled");
        $("input[name='chkAntiARPAttack']").removeAttr("disabled");
        $("input[name='chkIPConflict']").removeAttr("disabled");
        dynDomainCtrl();
    } else {
        $("#routeDiv").hide();
        $("#routeDiv2").hide();
        $("#addrDiv").hide();
        $("#divAntispoof").hide();
        $("#ipaddr_type").attr("disabled",'disabled');
        $("#devIpv4").attr("disabled",'disabled');
        $("input[name='devIpv4Netmask']").attr("disabled",'disabled');
        $("input[name='admin']").attr("disabled",'disabled');
        $("input[name='ping']").attr("disabled",'disabled');
        $("input[name='traceroute']").attr("disabled",'disabled');
        $("input[name='chkDynDomain']").attr("disabled",'disabled');
        $("input[name='antispoof']").attr("disabled",'disabled');
        $("input[name='chkAntiARPAttack']").attr("disabled",'disabled');
        $("input[name='chkIPConflict']").attr("disabled",'disabled');
        dynDomainCtrl();
    }
}

function checkIpmacCheck()
{
	if( $("input[name='ipmac_check']").attr("checked") == 'checked' ) {
		$("input[name='ipmac_check_policy']").attr("checked",'checked');
		$("input[name='ipmac_check_policy']").removeAttr("disabled");		
	} else {
	        $("input[name='ipmac_check_policy']").removeAttr("checked");
		$("input[name='ipmac_check_policy']").attr("disabled",'disabled');

	}
}

function freshTableAndPage() {
    var url = 'index.php?R=systemManagement/networkConf/interfaceConf/physical/showTable';
    initTable(url, $('#physicalTable'));
    //freshPagination(url, $('.pager'));
}

function bandWidthDetect() {
    var title   = '设备带宽检测';
    var dialog  = loadingScreen(title);
    var buttons = {};
    buttons['确定'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width: 300,
        height: 160,
        buttons: buttons,
        position : jQuery.getDialogPosition('300','160')
    };
    dialog.setOptions(dialogParams);
    var url = "index.php?R=systemManagement/networkConf/interfaceConf/physical/bandWidthDetect";
    var params ={
	type  : "POST",
	dataType : 'json',
	success: function(result, textStatus) {
	    if(result.status != -1) {
    	        dialog.setContent(result.msg);
	        $('#BandwidthValue').val(result.speed); 
	    } else {
	        dialog.setContent(result.msg);
	    }
	    setTimeout(function(){
	        dialog.close();
	    },2000);
	}
    };
    var name = $("input[name='external_name']").val();    
    var data = {
        ifname: name
    };
    loadAjax(url, data, params);
}
