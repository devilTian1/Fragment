var perlipv6regex = "^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";

var perlipv4regex = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$';

var perlDevIpv4regex = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[1-9])$';

var IP_EX_ALL_255=0x04;
var IP_EX_ALL_0=0x02;
// Custom Validation Method
function addValidMethod(params) {
    jQuery.validator.addMethod(params.name, params.validMethod, params.msg);
}

function countUnchecked(doms) {
    return doms.filter(':unchecked').length;
}

function checkIpv4Mask(value) {
    if (value.indexOf('.') === -1) {
        return false;
    }
    var frag = value.split('.');
    if (frag.length != 4) {
        return false;
    }
    for (var i = 0; i <= 3; i++) {
        frag[i] = parseInt(frag[i]);
    }
    if (frag[0] === 0) {
        return false;
    }
    var maskFragArr = "128, 192, 224, 240, 248, 252, 254, 255";
    for (var i = 3; i >= 0; i--) {
        if (frag[i] != 0) {
            if (maskFragArr.indexOf(frag[i]) === -1) {
                return false;
            }
            for (var j = i-1; j >= 0; j--) {
                if (frag[j] != 255) {
                    return false;
                }
            }
        }
    }
    return true;
}

function setCustomErrMsg(dom, errMsg) {
    dom.data('errMsg', errMsg);
    return true;
}

function getCustomErrMsg(dom) {
    return getMessage(dom.data('errMsg')) + '。';
}

function hideBindDom(doms) {
    for (var i in doms) {
        doms[i].removeClass('errorLabel').next('.errorLabel').hide();
    }
}

function getDefaultOptionVal(element) {
    var optsDom = $('fieldset #' + element.id + ' option');
    var length  = optsDom.length;
    for (var i = 0; i < length; i++) {
        if (optsDom[i].defaultSelected) {
            return optsDom[i].value;
        }
    }
    return optsDom[0].value;
}

function sValidate(url, data, dom) {
    var isValid = false;
    var ajaxParams = {
        async: false,
        dataType: 'JSON',
        success: function(result) {
            if (result.msg.length != 0) {
                isValid = false;
                dom.data('errMsg', result.msg.join('.<br/>'))
            } else {
                isValid = true;
            }
        }
    };
    loadAjax(url, data, ajaxParams);
    return isValid;
}

//校验是否有空格
function hasSpace(string)
{
	var ss = string.split(" ");	
	if(ss.length!=1){
		return true;
	}
	return false;
}


function is_valid_ip_flag(str,flag)
{
	var exp=/^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/;
	var reg = str.match(exp);
	if(reg==null)
	{
		return false;
	}
	if(((flag&IP_EX_ALL_255) && str=="255.255.255.255")||
		 ((flag&IP_EX_ALL_0) && str=="0.0.0.0"))

	{
		return false;
	}

	return true;
}
// Custom Validation Method Params
var validMethodParams = {
    ipValidParam: {
        name: 'ip',
        validMethod: function(value, element, params) {
            var ipv4regex = new RegExp(perlipv4regex);
            var ipv6regex = new RegExp(perlipv6regex);
            return this.optional(element) || ipv4regex.test(value) ||
                ipv6regex.test(value) || /^fe80/i.test(value)
        },
        msg: 'IP格式错误。'
    },
    ipv4ValidParam: {
        name: 'ipv4',
        validMethod: function(value, element, params) {
            var ipv4regex = new RegExp(perlipv4regex);
            return this.optional(element) ||
            ipv4regex.test(value)
        },
        msg: 'IPV4格式错误。'
    },
	ipv4DevValidParam: {
		name: 'ipv4Dev',
		validMethod: function(value, element, params) {
            var ipv4Devregex = new RegExp(perlDevIpv4regex);
            return this.optional(element) ||
            ipv4Devregex.test(value)
        },
        msg: 'IP地址的主机地址部分里的所有字节都设置为0。请输入一个有效的IP地址。'
	},
    ipv4NetmaskValidParam: {
        name: 'ipv4Netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) || checkIpv4Mask(value) ||
            (value >=1 && value <= 32);
        },
        msg: 'IPV4子网掩码格式错误。'
    },
	netmaskValidParam: {
        name: 'netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) || checkIpv4Mask(value) ||
            (value >=1 && value <= 128);
        },
        msg: '子网掩码格式错误。'
    },
    realNameValidParam: {
        name: 'realName',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\-_]{1,15}$/.test(value);
        },
        msg: '1-15个字母、数字、减号、下划线的组合。'
    },
	domainParam:{
		name : 'domain',
		validMethod: function (value,element) {
			var exp=/^[a-zA-Z0-9]+([a-zA-Z0-9\-\.]+)?\.(aero|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|ac|ad|ae|af|ag|ai|al|am|an|ao|aq|ar|as|at|au|aw|az|ba|bb|bd|be|bf|bg|bh|bi|bj|bm|bn|bo|br|bs|bt|bv|bw|by|bz|ca|cc|cd|cf|cg|ch|ci|ck|cl|cm|cn|co|cr|cs|cu|cv|cx|cy|cz|de|dj|dk|dm|do|dz|ec|ee|eg|eh|er|es|et|fi|fj|fk|fm|fo|fr|ga|gb|gd|ge|gf|gg|gh|gi|gl|gm|gn|gp|gq|gr|gs|gt|gu|gw|gy|hk|hm|hn|hr|ht|hu|id|ie|il|im|in|io|iq|ir|is|it|je|jm|jo|jp|ke|kg|kh|ki|km|kn|kp|kr|kw|ky|kz|la|lb|lc|li|lk|lr|ls|lt|lu|lv|ly| ma|mc|md|mg|mh|mk|ml|mm|mn|mo|mp|mq|mr|ms|mt|mu|mv|mw|mx|my|mz|na|nc|ne|nf|ng|ni|nl|no|np|nr|nu|nz|om|pa|pe|pf|pg|ph|pk| pl|pm|pn|pr|ps|pt|pw|py|qa|re|ro|ru|rw|sa|sb|sc|sd|se|sg|sh|si|sj|sk|sl|sm|sn|so|sr| st|su|sv|sy|sz|tc|td|tf|tg|th|tj|tk|tm|tn|to|tp|tr|tt|tv|tw|tz|ua|ug|uk|um|us|uy|uz|va|vc|ve|vg|vi|vn|vu|wf|ws|ye|yt|yu|za|zm|zr|zw|AERO|BIZ|COM|COOP|EDU|GOV|INFO|INT|MIL|MUSEUM|NAME|NET|ORG|AC)$/;
			var reg = value.match(exp);
			if(reg==null) {
				return false;
			} else {
				return true;
			}	
		},
		msg:'域名格式错误。'
	},
	macValidParam: {
	    name: 'mac',
	    validMethod: function(value, element) {
	        return this.optional(element) ||
	        /^(([A-Fa-f0-9]){2}:){5}([A-Fa-f0-9]){2}$/.test(value) ||
	        /^(([A-Fa-f0-9]){2}-){5}([A-Fa-f0-9]){2}$/.test(value);
	    },
	    msg: 'MAC地址格式错误。'
	},
	ipListParam: {
		name:'ipList',
		validMethod: function(value,element,params) {
				var obj = document.getElementById("iplist");
				var length = obj.length;
				if(length > 0){
					return true;
				}else{
					return false;
				}
		},
		msg: "ip地址不能为空。"
	},
	ipRangeParam: {
		name:'ipRange',
		validMethod: function (value,element) {
			var ip_from = $('input[name="ip_from"]').val();
			var ip_to   = $('input[name="ip_to"]').val();
			
			var ipv4regex = new RegExp(perlipv4regex);
            if (ipv4regex.test(ip_from) && ipv4regex.test(ip_to) ) {
				var ip_fromArr = ip_from.split('.');
				var ip_toArr   = ip_to.split('.');
				
				var ip_fromLast = ip_fromArr.pop();
				var ip_toLast   = ip_toArr.pop();
				
				if ((ip_fromArr.join('.') == ip_toArr.join('.'))) {
					var length = parseInt(ip_toLast) - parseInt(ip_fromLast) + 1;
					if (length < 255 && length > 0) {
						return true;
					} else if (length == 255) {
						return false; 
					} else {
						return true; // ip地址的顺序错了，但不用显示提示信息
					}
				} else {
					return false;
				}
			
			} else {
				return true; //ip格式不正确，但不用显示错误信息
			}
			
		},
		
		msg: 'ip地址段不能超过254个ip。'
	},
	ipOrderParam: {
		name:'ipOrder',
		validMethod: function (value,element) {
			var ip_from = $('input[name="ip_from"]').val();
			var ip_to   = $('input[name="ip_to"]').val();
			
			var ipv4regex = new RegExp(perlipv4regex);
            if (ipv4regex.test(ip_from) && ipv4regex.test(ip_to) ) {
				var ip_fromArr = ip_from.split('.');
				var ip_toArr   = ip_to.split('.');
				
				var ip_fromLast = ip_fromArr.pop();
				var ip_toLast   = ip_toArr.pop();
				
				if ((ip_fromArr.join('.') == ip_toArr.join('.'))) {
					var length = parseInt(ip_toLast) - parseInt(ip_fromLast) + 1;
					if (length < 255 && length > 0) {
						return true;
					} else {
						return false;
					}
				} else {
					return true; // 地址长度超过了254，但不用显示错误信息
				}
			
			} else {
				return true; //ip格式不正确，但不用显示错误信息
			}
			
		},
		
		msg: '第二个地址应该在第一个地址之后。'
	},
	commentTextParam: {
		name:'commentText',
		validMethod: function(value,element,params) {
			var invalid_char = "\x22'%*!|>;&<()+?{}[]#^";
			for(i=0;i<value.length;i++) {
				if (invalid_char.indexOf(value.charAt(i)) !=-1) {
					return false;
				}
			}
			return true;			
		},
		msg: "备注含有非法字符。"
	},
	nameParam: {
		name:'nameText',
		validMethod: function(value,element,params) {
			var special_str = "%*!|>;&<()+? {}[]#^.~`@$=/:\',\\·～！￥……（）——｜、｛｝【】：“”；‘’《》？，。\"";
			for(i=0;i<value.length;i++) {
				if (special_str.indexOf(value.charAt(i)) !=-1) {
					return false;
				}
			}
			return true;
		},
		msg: "名称格式错误。"
	},
	portParam: {
		name:'port',
		validMethod: function(value,element,params) {
			if (value.indexOf('.') == -1) {
				if(isNaN(value)){
	            	var pArray = value.split(':');
	            	if(pArray.length == 2 && pArray[0] != '' && pArray[1] != '' && !isNaN(pArray[0]) && !isNaN(pArray[1])){
	            		return true;
	            	}else{
	            		pArray = value.split(',');
	            		for(i=0;i<pArray.length;i++) {
	        				if (pArray[i] == '' || isNaN(pArray[i])) {
	        					return false;
	        				}
	        			}
	            		return true;
	            	}
	            }else{
	            	return true;
	            }
			}else {
				return false;
			}
		},
		msg: "端口格式错误。"  //端口可以用英文逗号分割表示多个端口，或用英文冒号分割表示端口段          by 胡娜
	},
	mtuRangeParam: {
	    name: 'mtuRange',
	    validMethod: function(value,element,params) {
	        var mtuDefRange = $("#flgMtuRange").val();
	        var mtuMax = 0;
	        var mtuMin = 0;
	        if(mtuDefRange === '(68-9216)') {
	            mtuMax = 9216;
	            mtuMin = 68;
	        } else if (mtuDefRange === '(60-1500)') {
	            mtuMax = 1500;
	            mtuMin = 60;
	        } else {
	            return true;
	        }
	        return (value>=mtuMin && value<=mtuMax);
	    },
	    msg: "mtu范围错误。"
	},
	dhcpParam: {
	    name: 'dhcpCheck',
	    validMethod: function(value,element,params) {
	            if(hasSpace(value)) {
	                return false;
                    }
                    var arr=value.split(',');                    
                    if(arr.length)
                	  {
                		for(var i=0;i<arr.length;i++)
                		{
                		    
                			if(!is_valid_ip_flag(arr[i],IP_EX_ALL_0|IP_EX_ALL_255))
                			  return false;
                		}
                	  }
                	  return true;
	    },
	    msg: "dhcp服务器地址格式错误。"
	},
	hostIpParam: {
	    name: 'hostIp',
	    validMethod: function(value,element,params) {
	        var ipStr  = $("input[name='devIpv4']").val();
	        var maskStr  = $("input[name='devIpv4Netmask']").val();
	        var ipArr = ipStr.split('.');
	        var maskArr = maskStr.split('.');
	        for (var i = 0; i < 4; i++) {
	            var iptmp = parseInt(ipArr[i]);
	            var masktmp = parseInt(maskArr[i]);
	            var ip = parseInt(iptmp.toString(2), 2);
	            var mask = parseInt(masktmp.toString(2), 2);
	            if(ip !== (ip&mask)) {
	                return true;
	            }
	        }
	        return false;
	    }, 
	    msg: "该地址是网络地址，请输入主机地址。"
	}
};

for (var i in validMethodParams) {
    addValidMethod(validMethodParams[i]);
}

// rule
var validRules = {
	gatewayIp: {
		required : true,
		ip		 : true
	},
	detectip: {
		ip : true
	},
	detectip1:{
		ip : true
	},
	detectip2:{
		ip : true
	},
	weight:{
		required: true,
		range:[1,255]
	},
	servGroupName: {
		required : true,
		maxlength: 15,
		nameText : true,
        remote: {
            url: 'index.php?R=firewall/service/servGroup/checkServGroupNameExists',
            data: {
                servGroupName: function() {
                        return $('input[name="servGroupName"]').val();
                }
            }
        }		
	},
	icmpName: {
		required : true,
		maxlength: 15,
		nameText : true,
        remote: {
            url: 'index.php?R=firewall/service/ICMP/checkICMPNameExists',
            data: {
                icmpName: function() {
                        return $('input[name="icmpName"]').val();
                }
            }
        }		
	},
	ip_from : {
		required : true,
		ip		 : true
	},
	ip_to  : {
		required : true,
		ip       : true,
		ipRange  : true,
		ipOrder  : true
	},
	name   : {
		required : true,
		maxlength: 15,
		nameText : true,
        remote: {
            url: 'index.php?R=firewall/address/addrPool/isAddrPoolNameExists',
            data: {
                name: function() {
                        return $('input[name="name"]').val();
                }
            }
        }		
	},
    comment: {
        maxlength: 255,  //powerV2 最大长度为255
		commentText:true
    },
    redundanceIpv4:{
        required: true,
        ipv4: true,
		ipv4Dev: true,
        remote: {
            url: 'index.php?R=systemManagement/networkConf/interfaceConf/redundance/checkIpExists',
            data: {
                checkIpExist: 'ipv4',
				
                exName: function() {
                        return $('#external_name').val();
                }
            }
        }
    },
    redundanceMask:{
        required: 'input[name="redundanceIpv4"]:filled',
        ipv4Netmask: true
    },    
    vlanIpv4:{
    	required: true,
        ipv4: true		
    },
    vlanIpv4Netmask:{
        required: 'input[name="vlanIpv4"]:filled',
        ipv4Netmask: true
    },
	dnssrv: {
        ip: true,
        required: '#dnssrv2:filled'
    },
	dnssrv2: {
        ip: true
    },
    ip: {
        required: true,
	    ip: true
    },	
	'iplist[]' : {
        ipList: true		
	},
	dn: {
		required:true,
		domain:true
	},
    devIpv4: {
        required: true,
		ipv4:true,
	    ipv4Dev: true,
	    hostIp: true
        /*remote: {
            url: 'index.php?R=systemManagement/networkConf/interfaceConf/physical/checkIpv4Exist',
            data: {
                checkIpExist: 'ipv4',
                exName: function() {
                        return $('input[name="external_name"]').val();
                }
            }
        }*/
    },
    devIpv4Netmask: {
        required: 'input[name="devIpv4"]:filled',
        ipv4Netmask: true,
        hostIp: true
    },
    mtu: {
        required: true,
        mtuRange: true,
        digits: true
    },
    vlan_bindrange: {
        required: "#checkBindRange:checked"
    },
    vlan_id: {
        required: "#checkVlanId:checked",
        range: [1,4094]
    },
    DynDomain: {
        domain: "#chkDynDomain:checked"
    },
    serverip: {
        ip: true
    },
    remark_name: {
        realName: true
    },
    DHCPAddr: {
        required: "#chkOpenDHCP:checked",
        dhcpCheck: true,
        maxlength: 255
    },
    mac_address: {
        mac: true
    },
    dynamic_name: {
        required: true,
        realName: true,
        remote: {
            url: 'index.php?R=firewall/service/dynamicServices/checkNameExist',
          data: {
                checkExistName: true              
          }
        }
    },
    dynPort: {
        required: true,
        range: [0,65535],
        digits: true
    },
    batchToolExportFile: {
        required: true
    },
	addrGrpName: {
		required : true,
		maxlength: 15,
		nameText : true,
		remote: {
			url: 'index.php?R=firewall/address/addrGroup/checkExistAddrGroupName',
			data: {
                checkExistAddrGroupName: true              
			}
        }
	},
	'addrGrpMember[]': {
		required: function() {
            return $('select[name="addrGrpMember[]"] option').length === 0;
        }
	},
	phy_device: {
        required: true
    },
    vlanId: {
        required: true,
        range: [1,4094]
    },
    vlanRange: {
        required: true,
        range: [1,4094]
    },
    macAddress: {
        mac: true
    },
    policyname: {
    	required: true,
    	realName: true
    },
    policyid: {
    	required: true,
    	digits: true
    },
    sport: {
    	port: true
    },
    smac: {
    	mac: true
    },
    synflood: {
    	digits: true,
    	range: [0,65535]
    },
    udpflood: {
    	digits: true,
    	range: [0,65535]
    },
    icmpflood: {
    	digits: true,
    	range: [0,65535]
    },
    addrName: {
        required: true,
        nameText: true,
        remote: {
			url: 'index.php?R=firewall/address/address/uniqueAddrName'
        }
    },
    fwIp: {
        required: true,
        ip: true  
    },
    fwIp_r: {
        required: true,
        ip: true  
    },
    fwRange_s: {
        required: true,
        ip: true
    },
    fwRange_e: {
        required: true,
        ip: true
    },
	txt_dip: {
		required: true,
		ipv4: true
	},
	txt_metric: {
		required: true,
		digits: true
	},
	txt_nextHopIP: {
		required: true,
		ipv4: true
	},
	ipv4: {
		ipv4: true
	},
    unlock:{
        required:true,
        range:[10,600]
    },
    expired:{
        required:true,
        range:[60,86400]
    }
};

// message
var validMsg = {
	gatewayIp: {
		required : '不能为空。'
		//ip		 : 'IP格式错误。'
	},
	weight:{
		required: '不能为空。',
		range:'1到255的整数。'
	},
	servGroupName: {
		required : '名称不能为空。',
		nameText : '由1-15个字母、数字、减号、中文、下划线组成',
        remote   : '此名称已被使用，不可重复。' 		
	},
	ip_from : {
		required : '起始IP不能为空。',
		ip		 : '起始IP格式错误。'
	},
	ip_to  : {
		required : '终止IP不能为空。',
		ip       : '终止IP格式错误。',
		ipRange  : 'IP地址段最多只可包含254个IP。',
		ipOrder  : '第二个IP地址应当在第一个IP地址之后。'
	},
	name   : {
		required : '名称不能为空。',
		nameText : '由1-15个字母、数字、减号、中文、下划线组成',
		remote   : '该名称已存在。'
	},
    comment: {
        maxlength: '备注不能超过255个字符。',  
		commentText:"备注不能超过255个字符，不能含有'%\"*!|>;&<()+?{}[]#^等特殊字符。"
    },
	icmpName: {
		required : '名称不能为空。',
		nameText : '由1-15个字母、数字、减号、中文、下划线组成',
        remote:   '该名称已存在,不可重复。'
	},
    redundanceIpv4:{
        required: '请填写IPV4地址。',
        remote: '此ip地址已被使用。'
    },
    redundanceMask:{
        required: '请填写IPV4地址的子网掩码。'
    },
    vlanIpv4:{
        required: '请填写IP地址。'
    },
    vlanIpv4Netmask:{
        required: '请填写IPV4地址的子网掩码。'
    },
    dnssrv: {
        ip: '域名服务器IP1格式错误。',
        required: '域名服务器IP1不能为空。'
    },
    dnssrv2: '域名服务器IP2格式错误。',		
    ip: {
        required: '请填写IP地址。'
    },	
	'iplist[]':{
		ipList: 'ip列表不能为空。'
	},
	dn: {
		required:'域名不能为空。'
	},	
    devIpv4: {
        required: '请填写IPV4或者IPV6地址。',
        remote: '此ip地址已被使用。'
    },
    devIpv4Netmask : {
        required: '请填写IPV4地址的子网掩码。'
    },
    mtu: {
        required: '必填。',
        digits: '请填写有效数字。'
    },
    vlan_bindrange: {
        required: '请输入绑定VLAN区间。'
    },
    serverip: {
        required: '必填。',
        ip:'管理主机 IP格式错误。'
    },
    DHCPAddr: {
        required: '请输入DHCP服务器地址。',
        maxlength: 'DHCP服务器地址最大输入长度为255。'
    },
    vlan_id: {
        range: 'Native VLAN ID范围1-4094。',
        required: '请输入Native VLAN ID。'
    },
    dynamic_name: {
        required: '请输入服务名称。',
        remote: '服务名已存在。'
    },
    dynPort: {
        required: '请输入端口',
        range: '端口范围0 - 65535。',
        digits: '请填写有效数字。'
    },
    batchToolExportFile: '请选择要上传的文件！',
	addrGrpName: {
		required : '名称不能为空。',
		maxlength: '名称不能超过15个字符',
		nameText : '名称格式错误。',
		remote: '该名称已存在。'
	},
	'addrGrpMember[]':'请至少选择一个地址组成员。',
	phy_device: {
        required: '请选择绑定设备。'
    },
    vlanId: {
        required: '请填写VLAN ID。',
        range: 'VLAN ID范围1-4094。'
    },
    vlanRange: {
        required: '请填写VLAN区间。',
        range: 'VLAN区间范围1-4094。'
    },
    policyname: {
    	required: '请填写策略名称。'    	
    },
    policyid: {
    	required: '请填写策略序号。',
    	digits: '请填写有效数字。'
    },
    synflood: {
    	range: '端口范围0 - 65535。',
        digits: '请填写有效数字。'
    },
    udpflood: {
    	range: '端口范围0 - 65535。',
        digits: '请填写有效数字。'
    },
    icmpflood: {
    	range: '端口范围0 - 65535。',
        digits: '请填写有效数字。'
    },
    addrName: {
		required : '名称不能为空。',
		nameText : '由1-15个字母、数字、减号、中文、下划线组成',
		remote   : '该名称已存在。'
	},
    fwIp: {
        required: '地址必填。'
    },
    fwIp_r: {
        required: '反向地址必填。'
    },
    fwRange_s: {
        required: '起始地址必填。'
    },
    fwRange_e: {
        required: '终止地址必填。'
    },
	txt_dip: {
		required: '请填写IP地址。',
	},
	txt_metric: {
		required: 'metric不能为空。',
		digits: 'metric必须为数字。'
	},
	txt_nextHopIP: {
		required: '下一跳地址不能为空。'
	},
    unlock:{
        required:'请填写解锁超时时间',
        range:'时间范围10 - 600'
    },
    expired:{
        required:'请填写空闲超时时间',
        range:'时间范围60 - 8640060'
    }
};

var groups = {
    fw_addr_range : 'fwRange_s fwRange_e' 
};

var errorPlacement = function (error, element) {
    if (element.attr('name') === "sendfilter") {
        error.insertAfter("label[for='sendfilter_black']");
    } else if (element.attr('name') === "recvfilter") {
        error.insertAfter("label[for='recvfilter_black']");
    } else {
        error.insertAfter(element);
    }
};

function validateForm(form, displayId) {
    var options = {
        rules:    validRules,
        messages: validMsg,
        groups: groups,
        errorPlacement: errorPlacement,
        errorClass: 'errorLabel'
    };

    if (displayId !== undefined) {
        options['wrapper']             = 'li';
        options['errorLabelContainer'] = '#' + displayId;
        options['errorClass'] = 'errorContainer';
    }

    return form.validate(options);
}
