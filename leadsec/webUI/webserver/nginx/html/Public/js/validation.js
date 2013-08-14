var perlipv6regex = "^\s*((([0-9A-Fa-f]{1,4}:){7}([0-9A-Fa-f]{1,4}|:))|(([0-9A-Fa-f]{1,4}:){6}(:[0-9A-Fa-f]{1,4}|((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){5}(((:[0-9A-Fa-f]{1,4}){1,2})|:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3})|:))|(([0-9A-Fa-f]{1,4}:){4}(((:[0-9A-Fa-f]{1,4}){1,3})|((:[0-9A-Fa-f]{1,4})?:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){3}(((:[0-9A-Fa-f]{1,4}){1,4})|((:[0-9A-Fa-f]{1,4}){0,2}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){2}(((:[0-9A-Fa-f]{1,4}){1,5})|((:[0-9A-Fa-f]{1,4}){0,3}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(([0-9A-Fa-f]{1,4}:){1}(((:[0-9A-Fa-f]{1,4}){1,6})|((:[0-9A-Fa-f]{1,4}){0,4}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:))|(:(((:[0-9A-Fa-f]{1,4}){1,7})|((:[0-9A-Fa-f]{1,4}){0,5}:((25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)(\.(25[0-5]|2[0-4]\d|1\d\d|[1-9]?\d)){3}))|:)))(%.+)?\s*$";

var perlipv4regex = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])$';

var perlDevIpv4regex = '^(?:(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[0-9])\\.){3}(?:25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9][0-9]|[1-9])$';

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

// Custom Validation Method Params
var validMethodParams = {
    letterValidParam: {
        name: 'letters',
        validMethod: function(value, element, params) {
            var regexp = new RegExp("^[a-zA-Z]{" + 
                params[0] + "," + params[1] + "}$");
            return this.optional(element) || regexp.test(value);
        },
        msg: jQuery.format("{0}至{1}位英文字母")
    },
    adminPwdValidParam: {
        name: 'adminPwd',
        validMethod: function(value, element, params) {
            var regexp =
	        new RegExp("^[a-zA-Z0-9]{" + params[0] + "," + params[1] + "}$");
            return this.optional(element) || (regexp.test(value) && 
                /[a-zA-Z]+/.test(value) && /[0-9]+/.test(value));
        },
        msg: jQuery.format("{0}至{1}位字母和数字")
    },

    passwdValidParam: {
        name: 'passwd',
        validMethod: function(value, element, params) {
            var regexp =
	        new RegExp("^[a-zA-Z0-9]{" + params[0] + "," + params[1] + "}$");
            return this.optional(element) || regexp.test(value);
        },
        msg: jQuery.format("{0}至{1}位字母或数字")
    },
    UserPasswdValidParam: {
        name: 'passwd_user',
        validMethod: function(value, element) {
            return this.optional(element) ||
                /^([0-9]{10,20}|[a-zA-Z\W]{9,20}|.{12,20})$/.test(value);
        },
        msg: jQuery.format('9-20个字符的口令，但至少满足以下条件之一:<br/>1.英文大写字母（从A到Z）<br/>2.英文小写字母（从a到z）<br/>'
                                        +'3.10个基本数字（从0到9）<br/>4.非字母字符（如:!,$,#,%）<br/>5.口令达到12个字符长度')
    },   
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
    ipv6ValidParam: {
        name: 'ipv6',
        validMethod: function(value, element, params) {
            var ipv6regex =
            new RegExp(perlipv6regex);
            return this.optional(element) || ipv6regex.test(value) || /^fe80/i.test(value)
        },
        msg: 'IPV6格式错误。'
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
    netmaskValidParam: {
        name: 'netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) || checkIpv4Mask(value) ||
            (value >=1 && value <= 128);
        },
        msg: '子网掩码格式错误。'
    },
    ipv4NetmaskValidParam: {
        name: 'ipv4Netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) || checkIpv4Mask(value) ||
            (value >=1 && value <= 32);
        },
        msg: 'IPV4子网掩码格式错误。'
    },
    ipv6NetmaskValidParam: {
        name: 'ipv6Netmask',
        validMethod: function(value, element, params) {
            return this.optional(element) || (value >=1 && value <= 128)
        },
        msg: 'ipv6子网掩码格式错误。'
    },
    addrNameValidParam: {
        name: 'addrName',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\-_\.]{1,15}$/.test(value);
        },
        msg: '1-15个字母、数字、减号、下划线、点的组合。'
    },
    domainAddrNameValidParam: {
    	name: 'domainAddrName',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z][a-zA-Z0-9\-_\.]{0,14}$/.test(value);
        },
        msg: '1-15个字母、数字、减号、下划线、点的组合，首字符必须为字母。'
    },
    realNameValidParam: {
        name: 'realName',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\-_]{1,15}$/.test(value);
        },
        msg: '1-15个字母、数字、减号、下划线的组合。'
    },
    commentValidParam: {
        name: 'comment',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\-_\u4E00-\u9fa5 ]{0,254}$/.test(value);
        },
        msg: '0-254个字母、中文、空格、数字、减号、下划线的组合。'
    },
	realContext_txtValidParam: {
		name: 'realContext_txt',
		validMethod: function(value, element, params) {
            return this.optional(element) ||
            ///^[a-zA-Z0-9\-_(\u4E00-\U9FA5)]{1,30}$/.test(value);
			/^[a-zA-Z0-9_\一-\龥]{1,30}$/.test(value);
        },
        msg: '仅支持中文、字母、数字、下划线的组合。'
	},
    userNameListValidParam: {
        name: 'userFilterName',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\-_\.\,]{1,1024}$/.test(value);
        },
        msg: '1-1024个字母、数字、减号、下划线、点、逗号的组合。'
    },
	realTxt_gapverParam: {
		name : 'realTxt_gapver',
		validMethod: function(value, element, params) {
            return this.optional(element) ||
            (/^(\d+\.)+(\d+)$/.test(value) && value.length<=32);
        },
        msg: '数字与点的组合并且长度不超过32个字符。'
	},
	realTxt_gapProcParam: {
		name : 'realTxt_gapProc',
		validMethod: function(value, element, params) {
            return this.optional(element) ||
            (/^([\s\S]*)(\.exe)|(\.EXE)$/.test(value) && value.length<=50);
        },
        msg: '进程名称结尾必须以.exe或.EXE结尾且不超过50个字符。'
	},
    dateTimeValidParam: {
        name: 'dateTime',
        validMethod: function(value, element, params) {
            var regexpStr = '';

            var yyyymmdd  = 
                '[0-9]{4}/(0?[1-9]|1[0-2])/(0?[0-9]|[12][0-9]|3[01])';
            var hhmm      = '(0?[0-9]|1[0-9]|2[0-3]):(0?[0-9]|[1-5][0-9])';
            var hhmm_ss   = hhmm + '(:(0?[0-9]|[1-5][0-9]))?';
            var hhmmss    = hhmm + ':(0?[0-9]|[1-5][0-9])';

            if (params[0] === 'YYYY/MM/DD hh:mm(:ss)') {
                regexpStr = yyyymmdd + ' ' + hhmm_ss;
            } else if (params[0] === 'YYYY/MM/DD hh:mm') {
                regexpStr = yyyymmdd + ' ' + hhmm;
            } else if (params[0] === 'hh:mm(:ss)') {
                regexpStr = hhmm_ss;
            } else {
                regexpStr = yyyymmdd + ' ' + hhmmss;
            }
            var regexp = new RegExp('^' + regexpStr + '$');
            return this.optional(element) || regexp.test(value);
        },
        msg: jQuery.format("格式为{0}. ")
    },
    startOrEndFullDateValidParam: {
        name: 'fullDate_s_or_e',
        validMethod: function(value, element, params) {
            var sv = $(params[0]).val();
            var ev = $(params[1]).val();
            if (sv == '' && ev == '') {
                return true;
            }
            var st = new Date(sv);
            var et = new Date(ev);
            return Date.parse(sv) < Date.parse(ev);
        },
        msg: "时间下限应小于时间上限。"
    },
    startOrEndTimeValidParam: {
        name: 'time_s_or_e',
        validMethod: function(value, element, params) {
            var sv = $(params[0]).val();
            var ev = $(params[1]).val();
            if (sv == '' && ev == '') {
                return true;
            }
            var hms_s = sv.split(':');
            var hms_e = ev.split(':');
            if (parseInt(hms_s[0]) < parseInt(hms_e[0])) {
                return true;
            } else if (parseInt(hms_s[0]) == parseInt(hms_e[0])) {
                if (parseInt(hms_s[1]) < parseInt(hms_e[1])) {
                    return true;
                } else if (parseInt(hms_s[1]) == parseInt(hms_e[1])) {
                    var s_s = hms_s[2] === undefined ? 0 : hms_s[2];
                    var s_e = hms_e[2] === undefined ? 0 : hms_e[2];
                    if (parseInt(s_s) < parseInt(s_e)) {
                        return true;
                    } else {
                        return false;
                    }
                } else {
                    return false;
                }
            } else {
                return false;
            }
        },
        msg: "时间下限应小于时间上限。"
    },
    filledValidParam: {
        name: 'isFilled',
        validMethod: function(value, element, params) {
            return $(params[0] + ':filled').length > 0;
        },
        msg: jQuery.format("{1}")
    },
    ftpFilterOptUserInfoValidParam: {
        name: 'ftpFilterOptUserInfo',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
                /^([^\（\）\(\)\×\*,\s]{1,255},)*[^\（\）\(\)\×\*,\s]{1,255}$/g.test(value)
        },
        msg: '不能填写星号和小括号, 单个用户名少于256个字符，多个用户类型用","分开。'
    },
    ftpFilterOptUploadOrDownInfoValidParam: {
        name: 'ftpFilterOptUploadOrDownInfo',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^(\.([^_\(\)，\u4e00-\u9fa5,\s\.\\\/:\*\?"<>\|'%]+)?,)*\.([^_\(\)，\u4e00-\u9fa5,\s\.\\\/:\*\?"<>\|'%]+)?$/g.test(value)
        },
        msg: '多个文件类型用","分开, 单个"."表示所有的没有后缀的文件. 例.exe, .txt'
    },
    serviceListValidParam: {
        name: 'serviceList',
        validMethod: function(value, element, params) {
			var selectedOption =$("select[name='serviceList'] option:selected").val();
			var tcp = '|tcp_any|RemoteDesk|http|https|pop3|smtp|telnet|ftp|rtsp|tns|';
			var udp = '|udp_any|Syslog|snmp|tftp|';
			var tcp_udp='|dns|h323|h323_gk|mms|sip|';
			
            if (($('#synFloodChk').attr("checked") == 'checked')&&($('#udpFloodChk').attr("checked") != 'checked')
             	&& ((tcp+tcp_udp).indexOf('|'+selectedOption+'|')==-1) ) {
             	return false;
            } else if (($('#synFloodChk').attr("checked") != 'checked')&&($('#udpFloodChk').attr("checked") == 'checked')
					&& ((udp+tcp_udp).indexOf('|'+selectedOption+'|')==-1) ) {
             	return false;
            }else if(($('#synFloodChk').attr("checked") == 'checked')&&($('#udpFloodChk').attr("checked") == 'checked')
					&&(tcp_udp.indexOf('|'+selectedOption+'|')==-1 )){
				return false;
			}else{
				return true;
			}
        },
        msg: '请选择正确的服务类型。'
    },
    srcIpUnequalDestIpValidParam: {
        name: 'srcIpUnequalDestIp',
        validMethod: function(value, element, params) {
            var dom = $('fieldset #sdata');
            dom.data('errMsg', '');
            if (params[0] === 'trans') {
                hideBindDom([$("select[name='srcIpList']"), $("select[name='destIpList']"), $('input[name="destPort"]')]);
                var srcIpOption  =
                    $("select[name='srcIpList'] option:selected").val();
                var destIpOption =
                    $("select[name='destIpList'] option:selected").val();
                var destPort     = $('input[name="destPort"]').val();
                if (destPort === '') {
                    setCustomErrMsg(dom, 'destPort is required');
                    return false;
                }
                var url = 'Function/client/safeBrowse/transVisit.php';
                var data = {
                    checkAddrValid: 1,
                    srcAddr : srcIpOption,
                    destAddr: destIpOption,
                    destPort: destPort,
                    id : $('input[name="transAccId"]').val()
                };
            } else {
                var srcIpList_general =
                    $("select[name='srcIpList_general'] option:selected").val();
                var url = 'Function/client/safeBrowse/generalVisit.php';
                var data = {
                    checkAddrValid: 1,
                    srcAddr : srcIpList_general,
                    id : $('input[name="generalAccId"]').val()
                };
            }
            sValidate(url, data, dom);
            return dom.data('errMsg').length === 0;
        },
        //msg: '源地址,目的地址和目的端口的组合不唯一。'
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #sdata'));
        }
    },
    safePassUnequalIpValidParam: {
        name: 'srcIpUnequalDestIp_safePass',
        validMethod: function(value, element, params) {
        	var srcIpOption = $("select[name='srcIpList_safePass'] option:selected").val();
        	if ($("input[name='accessType']:checked").val()=='no') {
        		var destIpOption = $("select[name='destIpList_trans'] option:selected").val();
        		if (destIpOption == 'any_ipv4' && srcIpOption == 'any_ipv4') {
        			return false;
        		}
        	}        	
        	return true;
        },
        msg: '源地址与目的地址不能同时为any.'
    },  
    allowedFileNameValidParam: {
        name: 'filename',
        validMethod: function(value, element, params) {
            return this.optional(element) || /^[^\\\/:\"'<>\|%]+$/.test(value)
        },
        msg: "文件名中可以使用通配符*和? 但不能包括以下字符 % \ / : \" < > | '"
    },
    fileExchangeFilterName: {
        name: 'FEfilterName',
         validMethod: function(value, element, params) {
            return this.optional(element) || /^[a-zA-Z0-9_]{1,30}$/.test(value)
        },
        msg: "30个由任意数字, 中文, 字母, 下划线组成。"
    },
    urlFilterValidParam: {
        name: 'urlFilter',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^\.?(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value)
        },
        msg: 'URL格式错误。'
    },
    urlValidParam: {
        name: 'urlStandard',
        validMethod: function(value, element, params) {
            return this.optional(element) ||
            /^(((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:)*@)?(((\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5])\.(\d|[1-9]\d|1\d\d|2[0-4]\d|25[0-5]))|((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.?)(:\d*)?)(\/((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)+(\/(([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)*)*)?)?(\?((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|[\uE000-\uF8FF]|\/|\?)*)?(\#((([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(%[\da-f]{2})|[!\$&'\(\)\*\+,;=]|:|@)|\/|\?)*)?$/i.test(value)
        },
        msg: 'URL格式错误。'
    },
    fragPortValidParam: {
        name: 'httpPort',
        validMethod: function(value, element, params) {
            var portArr = value.split(',');
            for (var i in portArr) {
                var frag = portArr[i];
                if (frag.indexOf('-') !== -1) { //eg: 80-8080
                    var pf = frag.split('-');
                    var p1 = parseInt(pf[0]);
                    var p2 = parseInt(pf[1]);
                    if (!(p1 >= 1 && p1 <= 65535) || !(p2 >= 1 && p2 <= 65535)||
                        !(p1 < p2)) {
                        return false;
                    }
                } else { //eg: 22
                    if (!(frag >= 1 && frag <= 65535)) {
                        return false;
                    }
                }
            }
            return true;
        },
        msg: '端口格式错误。'
    },
    portRangeParam: {
        name: 'unrequiredPortRange',
        validMethod: function(value, element, params) {
            if(value === '' || value==='----') {
                return true;
            }
            var pos = value.indexOf(':');
            if (pos === -1 && value >= 1 && value <= 65535 && /^\d+$/.test(value)) {
                return true;
            } else if (pos !== -1 && /^([0-9]+):([0-9]+)$/.test(value)) {
                var portArr = value.split(':');
                var p1      = parseInt(portArr[0]);
                var p2      = parseInt(portArr[1]);
                if ((p1 >= 1 && p1 <= 65535 && /^\d+$/.test(p1)) && (p2 >= 1 && p2 <= 65535 && /^\d+$/.test(p2))
                    && (p1 <= p2)) {
                    return true;
                }
            }
            return false;
        },
        msg: '端口范围格式错误。'
    },
    IPRangeParam: {
        name: 'iprange',
        validMethod: function(value, element, params) {
            if(value != "")
            {
            	if (value.indexOf(',') !== -1)
            	{
            		var ipRangeArr = value.split(',');
            		for (var i in ipRangeArr) {
            			if(ipRangeArr[i].indexOf('/') !== -1)
                    	{
                    	    var ipmaskArr1 = ipRangeArr[i].split('/');	
                    	    var ipv4regex = new RegExp(perlipv4regex);
                    	    var ipv6regex = new RegExp(perlipv6regex);
                    	    var maskregex = new RegExp('^[0-9]+$');
                    	    if(ipv4regex.test(ipmaskArr1[0]) || ipv6regex.test(ipmaskArr1[0]))
                    	    {
                    	    	if(!maskregex.test(ipmaskArr1[1]))
                    	    	{
                    	    		return false;
                    	    	}
                    	    	else
                    	    	{
                    	    		var p1 = parseInt(ipmaskArr1[1]);
                    	    		if(!(p1 >= 1 && p1 <=32))
                        	    	{
                        	    		return false;
                        	    	}
                    	    	}
                    	    }
                    	    else
                    	    {
                    	    	return false;
                    	    }           	    
                    	}
                    	else
                    	{
                    		return false;
                    	}
            		}
            	}
            	else if(value.indexOf('/') !== -1)
            	{
            	    var ipmaskArr2 = value.split('/');	
            	    var ipv4regex = new RegExp(perlipv4regex);
            	    var ipv6regex = new RegExp(perlipv6regex);
            	    var maskregex = new RegExp('^[0-9]+$');
            	    if(ipv4regex.test(ipmaskArr2[0]) || ipv6regex.test(ipmaskArr2[0]))
            	    {
            	    	
            	    	if(!maskregex.test(ipmaskArr2[1]))
            	    	{
            	    		return false;
            	    	}
            	    	else
            	    	{
            	    		var p2 = parseInt(ipmaskArr2[1]);
            	    		if(!(p2 >= 1 && p2 <=32))
                	    	{
                	    		return false;
                	    	}
            	    	}
            	    		
            	    }
            	    else
            	    {
            	    	return false;
            	    }           	    
            	}
            	else
            	{
            		return false;
            	}
            }
        	
            return true;
        },
        msg: '网段格式:ip/mask,其中mask用缩写形式'
    },
    AutoIPParam: {
    	name: 'autoip',
        validMethod: function(value, element, params) {
        	var ipv4regex = new RegExp(perlipv4regex);
    	    var ipv6regex = new RegExp(perlipv6regex);
        	if(value != "")
            {
        		if (value.indexOf(',') !== -1)
            	{
        			var ipArr = value.split(',');	
        			for (var i in ipArr) {
        				if(!(ipv4regex.test(ipArr[i]) || ipv6regex.test(ipArr[i])))
                	    {
        					return false;
                	    }
        			}
            	}
        		else
        		{
        			if(!(ipv4regex.test(value) || ipv6regex.test(value)))
            	    {
    					return false;
            	    }            	    
        		}
            }
        	return true;
        },
        msg: '格式不合法'
     },
     AuthNetmaskValidParam: {
         name: 'Authnetmask',
         validMethod: function(value, element, params) {
            return this.optional(element) || checkIpv4Mask(value);
         },
         msg: '子网掩码格式错误。'
     },
     checkMaxLargerThanMin: {
    	 name: 'checkMax',
         validMethod: function(value, element, params) {
             var sv = $(params[0]).val();
             var ev = $(params[1]).val();
             if (sv == '' && ev == '') {
                 return true;
             }
             return parseInt(sv) < parseInt(ev);
     },
         msg: '上限值要大于下限值。'
     },
     checkMaxLargerOrEqMin: {
    	 name: 'checkMaxEq',
         validMethod: function(value, element, params) {
             var sv = $(params[0]).val();
             var ev = $(params[1]).val();
             if (sv == '' && ev == '') {
                 return true;
             }
             return parseInt(sv) <= parseInt(ev);
         },
         msg: '上限值要大于或等于下限值。'
     },
     checkMulticase: {
        name: 'mulIp',
        validMethod: function(value, element) {
            var frag = value.split('.');
            var f    = parseInt(frag[0]);
            if (f >= 224 && f <= 239) {
                return true;
            } else {
                return false;
            }
        },
        msg: '组播地址范围从224.0.0.0到239.255.255.255'
    },
    hostnameParam: {
        name: 'hostname',
        validMethod: function(value, element) {
            return this.optional(element) ||
            /^[a-zA-Z0-9\`\~\!\@\#\$\%\^\&\*\(\)\-\_\+\=\\\|\[\]\{\}\;\:\/\.\,\<\>\?]{1,20}$/.test(value);
        },
        msg: jQuery.format("1-20 个ASCII字符.")
    },
    transIdParams: {
        name: 'transId',
        validMethod: function(value, element, params) {
            var dialogType = $('input:hidden[name="type"]').val();
            var dom        = $('fieldset #' + element.id);
            var defaultVal = dom[0].defaultValue;
            dom.data('errMsg', '');

            var lportDom   = $(params[1]);
            var lportVal   = parseInt(lportDom.val());
            if (!lportVal) {
                lportVal = 0;
            }
            var idPlusPort = parseInt(value) + lportVal;
            hideBindDom([lportDom]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value) &&
                setCustomErrMsg(dom, 'Please enter only digits')) {
                return false;
            } else if (65535 < (params[3] + idPlusPort)) {
                var str = getMessage('id+port+%1s<=65535', [params[3]]);
                setCustomErrMsg(dom, str);
                return false;
            } else if (!(value >= 1 && value <= 1000) &&
                setCustomErrMsg(dom, 'Task id range between 1 and 1000')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                if (params[2] === undefined) {
                    var url = 'Function/client/validation.php';
                } else {
                    var url = params[2];
                }
                var data = {};
                data[params[0] + 'ClientTaskAndPort'] = idPlusPort;
                data[params[0] + 'TransId'] = value;
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    transLportParam: {
        name: 'transLport',
        validMethod: function(value, element, params) {
            var dialogType = $('input:hidden[name="type"]').val();
            var dom        = $('fieldset #' + element.id);
            var defaultVal = dom[0].defaultValue;
            dom.data('errMsg', '');
            
            var taskIdDom  = $(params[1]);
            var taskIdVal  = parseInt(taskIdDom.val());
            if (!taskIdVal) {
                taskIdVal = 0;
            }
            var idPlusPort = parseInt(value) + taskIdVal;
            hideBindDom([taskIdDom]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value)) {
                setCustomErrMsg(dom, 'Please enter only digits');
                return false;
            } else if ((65535 < (params[3] + idPlusPort))) {
                var str = getMessage('id+port+%1s<=65535', [params[3]]);
                setCustomErrMsg(dom, str);
                return false;
            } else if (!(value >= 1 && value <= 65535) &&
                setCustomErrMsg(dom, 'Port range between 1 and 65535')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                if (params[2] === undefined) {
                    var url = 'Function/client/validation.php';
                } else {
                    var url = params[2];
                }
                var data = {};
                data[params[0] + 'ClientTaskAndPort'] = idPlusPort;
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    fileEXIdParams: {
        name: 'fileEXId',
        validMethod: function(value, element, params) {
            var dom  = $('fieldset #' + element.id);
            dom.data('errMsg', '');
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value) &&
                setCustomErrMsg(dom, 'Please enter only digits')) {
                return false;
            } else if (!(value >= 1 && value <= 20) &&
                setCustomErrMsg(dom, 'Task id range between 1 and 20')) {
                return false;
            }
            var data = {};
            data[params[0] + 'GeneralId'] = value;
            if (params[1] === undefined) {
                var url = 'Function/client/validation.php';
            } else {
                var url = params[1];
            }
            sValidate(url, data, dom);
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    generalIdParams: {
        name: 'generalId',
        validMethod: function(value, element, params) {
            var dom  = $('fieldset #' + element.id);
            dom.data('errMsg', '');
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value) &&
                setCustomErrMsg(dom, 'Please enter only digits')) {
                return false;
            } else if (!(value >= 1 && value <= 1000) &&
                setCustomErrMsg(dom, 'Task id range between 1 and 1000')) {
                return false;
            }
            var data = {};
            data[params[0] + 'GeneralId'] = value;
            if (params[1] === undefined) {
                var url = 'Function/client/validation.php';
            } else {
                var url = params[1];
            }
            sValidate(url, data, dom);
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    generalLipParams: {
        name: 'generalLip',
        validMethod: function(value, element, params) {
            var dialogType = $('input:hidden[name="type"]').val();
            var dom        = $('fieldset #' + element.id);
            var lportDom   = $(params[1]);
            var defaultVal = getDefaultOptionVal(element);
            dom.data('errMsg', '');
            hideBindDom([lportDom]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                if (params[2] === undefined) {
                    var url = 'Function/client/validation.php';
                } else {
                    var url = params[2];
                }
                var data = {};
                data['lip'] = value;
                data[params[0] + 'GeneralLport'] = lportDom.val();
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    generalLportParams: {
        name: 'generalLport',
        validMethod: function(value, element, params) {
            var dialogType = $('input:hidden[name="type"]').val();
            var dom        = $('fieldset #' + element.id);
            var defaultVal = dom[0].defaultValue;
            dom.data('errMsg', '');
            hideBindDom([$(params[1])]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value) &&
                setCustomErrMsg(dom, 'Please enter only digits')) {
                return false;
            } else if (!(value >= 1 && value <= 65535) &&
                setCustomErrMsg(dom, 'Port range between 1 and 65535')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                if (params[2] === undefined) {
                    var url = 'Function/client/validation.php';
                } else {
                    var url = params[2];
                }
                var data = {};
                data['lip'] = $(params[1] + ' option:selected').val();
                data[params[0] + 'GeneralLport'] = value;
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    customTcpGeneralIdParams: {
        name: 'customTcpGeneralId',
        validMethod: function(value, element, params) {
            var dom  = $('fieldset #' + element.id);
            dom.data('errMsg', '');
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value) &&
                setCustomErrMsg(dom, 'Please enter only digits')) {
                return false;
            } else if (!(value >= 1 && value <= 500) &&
                setCustomErrMsg(dom, 'Task id range between 1 and 500')) {
                return false;
            }
            var data = {
            		customTcpGeneralId: value
            };
            sValidate('Function/client/validation.php', data, dom);
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    tcpGeneralLipParams: {
        name: 'tcpGeneralLip',
        validMethod: function(value, element, params) {
            var dialogType    = $('fieldset input:hidden[name="type"]').val();

            var dom        = $('fieldset #' + element.id);
            var lportDom   = $('fieldset #tcpGeneralLport');
            var defaultVal = getDefaultOptionVal(element);
            dom.data('errMsg', '');
            hideBindDom([lportDom]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                var url  = 'Function/client/validation.php';
                var data = {
                	tcpGeneralLport: lportDom.val(),
                    lip: value
                };
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    ftpTransdaParams: {
        name: 'ftpTransda',
        validMethod: function(value, element, params) {
            var dialogType    = $('fieldset input:hidden[name="type"]').val();

            var dom        = $('fieldset #' + element.id);
            var lportDom   = $('fieldset #ftpTranslportReq');
            var defaultVal = getDefaultOptionVal(element);
            dom.data('errMsg', '');
            hideBindDom([lportDom]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                var url  = 'Function/client/validation.php';
                var data = {
                	ftpTranslportReq: lportDom.val(),
                    lip: value
                };
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    tcpGeneralLportParams: {
        name: 'tcpGeneralLport',
        validMethod: function(value, element, params) {
            var dialogType    = $('fieldset input:hidden[name="type"]').val();

            var dom        = $('fieldset #' + element.id);
            var defaultVal = dom[0].defaultValue;
            dom.data('errMsg', '');
            hideBindDom([$('fieldset #tcpGeneralLip')]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value) &&
                setCustomErrMsg(dom, 'Please enter only digits')) {
                return false;
            } else if (!(value >= 1 && value <= 65535) &&
                setCustomErrMsg(dom, 'Port range between 1 and 65535')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                var url  = 'Function/client/validation.php';
                var data = {
                	tcpGeneralLport: value,
                    lip: $('fieldset #tcpGeneralLip option:selected').val()
                };
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    customUdpGeneralIdParams: {
        name: 'customUdpGeneralId',
        validMethod: function(value, element, params) {
            var dom  = $('fieldset #' + element.id);
            dom.data('errMsg', '');
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value) &&
                setCustomErrMsg(dom, 'Please enter only digits')) {
                return false;
            } else if (!(value >= 1 && value <= 500) &&
                setCustomErrMsg(dom, 'Task id range between 1 and 500')) {
                return false;
            }
            var data = {
            		customUdpGeneralId: value
            };
            sValidate('Function/client/validation.php', data, dom);
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    udpGeneralLipParams: {
        name: 'udpGeneralLip',
        validMethod: function(value, element, params) {
            var dialogType    = $('fieldset input:hidden[name="type"]').val();

            var dom        = $('fieldset #' + element.id);
            var lportDom   = $('fieldset #udpGeneralLport');
            var defaultVal = getDefaultOptionVal(element);
            dom.data('errMsg', '');
            hideBindDom([lportDom]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                var url  = 'Function/client/validation.php';
                var data = {
                	udpGeneralLport: lportDom.val(),
                    lip: value
                };
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    udpGeneralLportParams: {
        name: 'udpGeneralLport',
        validMethod: function(value, element, params) {
            var dialogType    = $('fieldset input:hidden[name="type"]').val();

            var dom        = $('fieldset #' + element.id);
            var defaultVal = dom[0].defaultValue;
            dom.data('errMsg', '');
            hideBindDom([$('fieldset #udpGeneralLip')]);
            if (value === '' && setCustomErrMsg(dom, 'Required')) {
                return false;
            } else if (!/^\d+$/.test(value) &&
                setCustomErrMsg(dom, 'Please enter only digits')) {
                return false;
            } else if (!(value >= 1 && value <= 65535) &&
                setCustomErrMsg(dom, 'Port range between 1 and 65535')) {
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                var url  = 'Function/client/validation.php';
                var data = {
                	udpGeneralLport: value,
                    lip: $('fieldset #udpGeneralLip option:selected').val()
                };
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },                                                                                                                                                                                                                                                                                                      
   customTcpTransIdParams: {
   	name: 'customTcpTransId',
       validMethod: function(value, element, params) {                     
           var dialogType    = $('fieldset input:hidden[name="type"]').val();
           var dom        = $('#' + element.id);                           
           var defaultVal = dom[0].defaultValue;                           
           dom.data('errMsg', '');                                         
                                                                      
           var lportDom   = $('fieldset #customtcpTransLport');                           
           var lportVal   = parseInt(lportDom.val());                      
           if (!lportVal) {                                                
               lportVal = 0;                                               
           }                                                               
           var idPlusPort = parseInt(value) + lportVal;                    
           hideBindDom([lportDom]);                                        
           if (value === '' && setCustomErrMsg(dom, 'Required')) {         
               return false;                                               
           } else if (!/^\d+$/.test(value) &&                              
               setCustomErrMsg(dom, 'Please enter only digits')) {         
               return false;                                               
           } else if (!(value >= 1 && value <= 500) &&                    
               setCustomErrMsg(dom, 'Task id range between 1 and 500')) { 
               return false;                                               
           } else if ((65535 <= (54000 + idPlusPort)) &&                   
               setCustomErrMsg(dom, 'Task Id + dport >= 65535')) { 
               return false;                                               
           }                                                               
           if (dialogType === 'add' || defaultVal !== value) {             
               var url  = 'Function/client/validation.php';                
               var data = {                                                
                   customTcpTransClientTaskAndPort: idPlusPort,                          
                   customTcpTransId: value                                          
               };                                                          
               sValidate(url, data, dom);                                  
           }                                                               
           return dom.data('errMsg').length === 0;                         
       },                                                                  
       msg: function(result, element) {                                    
           return getCustomErrMsg($('fieldset #' + element.id));
       }                                                                   
   },                                                                      
   customtcpTransLportParam: {
   	 name: 'customtcpTransLport',
        validMethod: function(value, element, params) {                    
            var dialogType    = $('fieldset input:hidden[name="type"]').val();
                                                                      
            var dom        = $('fieldset #' + element.id);
            var defaultVal = dom[0].defaultValue;
            dom.data('errMsg', '');
                                                                           
            var taskIdDom  = $('fieldset #customTcpTransId');                
            var taskIdVal  = parseInt(taskIdDom.val());                    
            if (!taskIdVal) {                                              
                taskIdVal = 0;                                             
            }                                                              
            var idPlusPort = parseInt(value) + taskIdVal;                  
            hideBindDom([taskIdDom]);                                      
            if (value === '' && setCustomErrMsg(dom, 'Required')) {        
                return false;                                              
            } else if (!/^\d+$/.test(value)) {                             
                setCustomErrMsg(dom, 'Please enter only digits');          
                return false;                                              
            } else if (!(value >= 1 && value <= 65535) &&
                    setCustomErrMsg(dom, 'Port range between 1 and 65535')) {
                return false;
            } else if ((65535 <= (54000 + idPlusPort)) &&                  
                setCustomErrMsg(dom, 'Task Id + dport >= 65535')) {
                return false;
            }                                                              
            if (dialogType === 'add' || defaultVal !== value) {            
                var url  = 'Function/client/validation.php';            
                var data = {                                               
                	customTcpTransClientTaskAndPort: idPlusPort
                };                                                         
                sValidate(url, data, dom);                                 
            }                                                              
            return dom.data('errMsg').length === 0;                        
        },                                                                 
        msg: function(result, element) {                                   
            return getCustomErrMsg($('fieldset #' + element.id)); 
        }                                                                  
   },
   customUdpTransIdParams: {
	   	name: 'customUdpTransId',
	       validMethod: function(value, element, params) {                     
	           var dialogType = $('fieldset input:hidden[name="type"]').val(); 
	           var dom        = $('#' + element.id);                           
	           var defaultVal = dom[0].defaultValue;                           
	           dom.data('errMsg', '');

	           var lportDom   = $('fieldset #customUdpTransLport');                           
	           var lportVal   = parseInt(lportDom.val());                      
	           if (!lportVal) {                                                
	               lportVal = 0;                                               
	           }                                                               
	           var idPlusPort = parseInt(value) + lportVal;                    
	           hideBindDom([lportDom]);                                        
	           if (value === '' && setCustomErrMsg(dom, 'Required')) {         
	               return false;                                               
	           } else if (!/^\d+$/.test(value) &&                              
	               setCustomErrMsg(dom, 'Please enter only digits')) {         
	               return false;                                               
	           } else if (!(value >= 1 && value <= 500) &&                    
	               setCustomErrMsg(dom, 'Task id range between 1 and 500')) { 
	               return false;                                               
	           } else if ((65535 <= (idPlusPort)) &&                   
	               setCustomErrMsg(dom, 'Task Id + dport >= 65535')) { 
	               return false;                                               
	           }                                                               
	           if (dialogType === 'add' || defaultVal !== value) {             
	               var url  = 'Function/client/validation.php';                
	               var data = {                                                
	            	   customUdpTransClientTaskAndPort: idPlusPort,                          
	               	   customUdpTransId: value                                          
	               };                                                          
	               sValidate(url, data, dom);                                  
	           }                                                               
	           return dom.data('errMsg').length === 0;                         
	       },                                                                  
	       msg: function(result, element) {                                    
	           return getCustomErrMsg($('fieldset #' + element.id));
	       }                                                                   
	   },                                                                      
	   customUdpTransLportParam: {
	   	 name: 'customUdpTransLport',
	        validMethod: function(value, element, params) {                    
	            var dialogType = $('fieldset input:hidden[name="type"]').val();
	            var dom        = $('fieldset #' + element.id);
	            var defaultVal = dom[0].defaultValue;
  
	            dom.data('errMsg', '');
	            var taskIdDom  = $('fieldset #customUdpTransId');
	            var taskIdVal  = parseInt(taskIdDom.val());                    
	            if (!taskIdVal) {                                              
	                taskIdVal = 0;                                             
	            }                                                              
	            var idPlusPort = parseInt(value) + taskIdVal;                  
	            hideBindDom([taskIdDom]);                                      
	            if (value === '' && setCustomErrMsg(dom, 'Required')) {        
	                return false;                                              
	            } else if (!/^\d+$/.test(value)) {                             
	                setCustomErrMsg(dom, 'Please enter only digits');          
	                return false;                                              
	            } else if (!(value >= 1 && value <= 65535) &&
	                    setCustomErrMsg(dom, 'Port range between 1 and 65535')){
	                return false;
	            } else if ((65535 <= (idPlusPort)) &&                  
	                setCustomErrMsg(dom, 'Task Id + dport >= 65535')) {
	                return false;
	            }                                                              
	            if (dialogType === 'add' || defaultVal !== value) {            
	                var url  = 'Function/client/validation.php';               
	                var data = {                                               
	                	customUdpTransClientTaskAndPort: idPlusPort
	                };                                                         
	                sValidate(url, data, dom);                                 
	            }                                                              
	            return dom.data('errMsg').length === 0;                        
	        },                                                                 
	        msg: function(result, element) {                                   
	            return getCustomErrMsg($('fieldset #' + element.id));
	        }                                                                  
	   },
    StartTimeLessThanEndTimeParam: {
        name: 'StartTimeLessThanEndTime',
        validMethod: function(value, element, params) {
            var startTime = $(params[0]).val();
            var endTime   = $(params[1]).val();
            if (startTime === '' && endTime === '') {
                return true;
            }
            if (Date.parse($(params[0]).val()) <= Date.parse($(params[1]).val())) {
                return true;
            } else {
                return false;
            } 
        },
        msg: '终止时间应该大于起始时间。'
    },
    shareNameParam: {
        name: 'shareNameParam',
        validMethod: function(value, element, params) {
            var urlregex = new RegExp("#","i");
            return this.optional(element) ||
            !urlregex.test(value)
        },
        msg: '名称不能包含\'#\'特殊字符。'
    },
    safePassIdParams: {
        name: 'safePassId',
        validMethod: function(value, element, params) {
            var dialogType    = $('fieldset input:hidden[name="type"]').val();

            var dom        = $('fieldset #' + element.id);
            var defaultVal = dom[0].defaultValue;
            dom.data('errMsg', '');

            if (value === '') {
                setCustomErrMsg(dom, 'Required');
                return false;
            } else if (!/^\d+$/.test(value)) {
                setCustomErrMsg(dom, 'Please enter only digits');
                return false;
            } else if (!(value >= 1 && value <= 200)) {
                setCustomErrMsg(dom, 'Task id range between 1 and 200');
                return false;
            }
            if (dialogType === 'add' || defaultVal !== value) {
                var url  = 'Function/client/validation.php';
                var data = {
                    safePassId: value
                };
                sValidate(url, data, dom);
            }
            return dom.data('errMsg').length === 0;
        },
        msg: function(result, element) {
            return getCustomErrMsg($('fieldset #' + element.id));
        }
    },
    realAddrParams: {
        name: 'realAddr',
        validMethod: function(value, element, params) {
            if(value == "")
                return true;
            for (i=1 ; i<=16 ; i++) {
                var realAddrKey = "realAddr" + i;                
                if (realAddrKey != element.id) {
                    var getRealAddrValue = $("input[name='"+ realAddrKey +"']").val();
                    if(getRealAddrValue == value) {
                        return false;
                    }
                }
            }
            return true;
        },
        msg: function(result, element) {
            return "真实地址不能重复。";
        }
    },
    vipParams:{
        name: 'viprequired',
        validMethod: function(value, element, params) {
            if($("input[name='authType']:checked").val() != "vip"){            
                return true;
            }
            if($("#bindMac").val() != "" || $("#bindIp").val() != ""){
                return true;
            }
            if(value == "")
                return false;
            return true;
        },
        msg: function(result, element) {
            return "vip用户必须绑定IP或MAC地址。";
        }
    },
    dbTransAddressParams: {
        name: 'dbTransAddress',
        validMethod: function(value, element) {
            var sa = $('#sAddress').val();
            var la = $('#lAddress').val();
            return !(sa === 'any_ipv4' && la === 'any_ipv4');
        },
        msg: function(result) {
            return "源地址不能与目的地址同时为'any'。";
        }
    },
    extensionParams: {
        name: 'fileExtension',
        validMethod: function(value, element, params) {
            for (var i in params) {
                var ext = params[i];
                if (value.indexOf(ext, value.length - ext.length) !== -1) {
                    return true;
                }
            }
            return false;
        },
        msg: function(result) {
            return '后缀名称不正确。';
        }
    },
    mailAddrParams: {
    	name: 'mailAddr',
        validMethod: function(value, element, params) {
        	if(!this.optional(element)){
        		var emailstr = value.split('@');
            	if(emailstr.length == 2){
            		if(/^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))$/i.test(emailstr[0])){
            			var ipv4regex = new RegExp(perlipv4regex);
            	        var ipv6regex = new RegExp(perlipv6regex);
            	        if(ipv4regex.test(emailstr[1]) || ipv6regex.test(emailstr[1]) || /^fe80/i.test(emailstr[1])){
            	        	return true;
            	        }else if(/^((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$/i.test(emailstr[1])){
            	        	return true;
            	        }
            	        return false;
            		}
            		return false;
            	}
            	return false;
        	}else{
        		return true;
        	}        	
        },
        msg: function(result) {
            return '请输入有效的邮件地址。';
        }
    },
    realPortParams: {
    	name: 'realPort',
        validMethod: function(value, element, params) {
        	if(value == "")
                return true;
        	var vPort = $('input[name="virtualPort"]').val();
        	if(value !== vPort){
        		return false;
        	}
        	return true;
        },
        msg: function(result) {
                return '虚拟端口和真实端口必须一致。';
        }                
    },
    rcStringParam: {
        name: 'rcString',
        validMethod: function(value, element, params) {
            var sv = $(params[0]).val();
            var ev = $(params[1]).val();
            if (sv == '' && ev == '') {
                return true;
            }
            if (sv == ev) {
                return false;
            }else{
            	return true;
            }          
        },
        msg: "源名标识与完成后标识不能相同。"
    },
    checknetmaskParam: {
    	name: 'checknetmask',
    	validMethod: function(value, element, params) {
    		var ip = $(params[0]).val();
            var ipv4regex = new RegExp(perlipv4regex);
            var ipv6regex = new RegExp(perlipv6regex);
            if(!this.optional(element)){
            	if(ipv4regex.test(ip)){
            		return checkIpv4Mask(value) || (value >=1 && value <= 32);
            	}else if(ipv6regex.test(ip) || /^fe80/i.test(ip)){
            		return value >=1 && value <= 128;
            	}
            	return true;
            } else {
            	return true;
            }
    	},
        msg: "子网掩码格式错误。"
    },
    checkMTUParam: {
        name: 'mtuRange',
        validMethod: function(value, element, params) {
            var ipv6 = $("#devIpv6").val();
            if(ipv6!=null && ipv6!='') {
                return value >=1280 && value <= 16128;
            } else {
                return value >=64 && value <= 16128;
            }
        },
        msg: "千兆设备的范围是64-16128。IPV6地址要求MTU至少1280。"
    }
};
for (var i in validMethodParams) {
    addValidMethod(validMethodParams[i]);
}

// rule
var validRules = {
    expTime: {
        required: true,
        range: [1, 1440],
        digits: true
    },
	haTime : {
		required: true,
        range: [15, 120],
        digits: true
	},
    limitErrNum: {
        required: true,
        range: [1, 5],
        digits: true
    },
    limitErrTime: {
        required: true,
        range: [1, 1440],
        digits: true
    },
    account: {
        required: true,
        letters: [1, 15],
		remote: {
            url: 'Function/systemManagement/admin/account.php',
            data: {
                checkExistAccountName: true              
            }
        }
    },
    passwd: {
        required: true,
        adminPwd: [8, 15]
    },
    passwd_again: {
        required: true,
        equalTo: "#passwd"
    },
    role: {
        required: function() {
            return (countUnchecked($('.roles')) === 3);
        }
    },
    defaultGateway: {
	    ipv4: true
    },
    defaultGateway6: {
	    ipv6: true
    },
    ip: {
        required: true,
	    ip: true
    },
    addrnetmask:{
    	required: 'input[name="ip"]:filled',
    	checknetmask: ['#addrip']    	
    },
    netmask: {
        required: 'input[name="hostIp"]:filled',
        netmask: true
    },
    ipv4: {
        required: 'input[name="ipv6"]:blank',
	    ipv4: true
    },
    ipv4Netmask: {
        required: 'input[name="devIpv4"]:filled',
        ipv4Netmask: true
    },
    ipv6: {
        required: 'input[name="ipv4"]:blank',
	    ipv6: true
    },
    ipv6Netmask: {
        required: 'input[name="devIpv6"]:filled',
        ipv6Netmask: true
    },
    devIpv4: {
        required: 'input[name="devIpv6"]:blank',
		ipv4:true,
	    ipv4Dev: true,
        remote: {
            url: 'Function/networkManagement/interface/physical.php',
            data: {
                checkIpExist: 'ipv4',
                exName: function() {
                        return $('input[name="external_name"]').val();
                }
            }
        }
    },
    devIpv4Netmask: {
        required: 'input[name="devIpv4"]:filled',
        ipv4Netmask: true
    },
    redundanceIpv4:{
        required: true,
        ipv4: true,
		ipv4Dev: true,
        remote: {
            url: 'Function/networkManagement/interface/redundance.php',
            data: {
                checkIpExist: 'ipv4',
                exName: function() {
                        return $('input[name="external_name"]').val();
                }
            }
        }
    },
    redundanceMask:{
        required: 'input[name="redundanceIpv4"]:filled',
        ipv4Netmask: true
    },
    devIpv6: {
        required: 'input[name="devIpv4"]:blank',
	    ipv6: true,
        remote: {
            url: 'Function/networkManagement/interface/physical.php',
            data: {
                checkIpExist: 'ipv6',
                exName: function() {
                    return $('input[name="external_name"]').val();
                }
            }
        }
    },
    devIpv6Netmask: {
        required: 'input[name="devIpv6"]:filled',
        ipv6Netmask: true
    },
    ipAddr_r: {
        required: true,
	    ip: true
    },
    range_s: {
        required: true,
        ipv4: true
    },
    range_e: {
        required: true,
        ipv4: true
    },
    comment: {
        comment: true
    },
    addrName: {
        required: true,
        addrName: true,
        remote: {
            url: 'Function/resConf/addr/addrList.php',
            data: {
            	checkExistAddrName: true
            },
            cache: false
        }
    },
    domainAddrName: {
        required: true,
        domainAddrName: true,
        remote: {
            url: 'Function/resConf/addr/addrList.php',
            data: {
            	checkExistAddrName: true
            }
        }
    },
    addrGrpName : {
        required: true,
        addrName: true,
        remote: {
            url: 'Function/resConf/addr/addrGroup.php',
            data: {
            	checkExistAddrGrpName: true
            }
        }
    },
    'addrGrpMember[]': {
        required: function() {
            return $('select[name="addrGrpMember[]"] option').length === 0;
        }
    },
    domainName: {
        required: true
    },
    netname: {
        required: true,
        hostname: true
    },
    record_type_mx: {
        required: function() {
            return (countUnchecked($(".record_type")) === 2);
        }
    },
    addStaticAddr: {
        ipv4: true
    },
    ntpSyncInterval: {
        required: true,
        range: [1, 65535],
        digits: true
    },
    max_record: {
        required: true,
        range: [1, 65535],
        digits: true
    },
    interval: {
        required: true,
        range: [1, 65535],
        digits: true
    },
    autoParseErrInterval: {
        required: true,
        range: [1, 65535],
        digits: true
    },
    primaryDns: {
        ip: true
    },
    slaveDns: {
        ip: true
    },
    timeListName: {
        required: true,
        addrName: true
    },
    startTime_f: {
        required: true,
        dateTime: ['YYYY/MM/DD hh:mm(:ss)']
    },
    endTime_f: {
        required: true,
        dateTime: ['YYYY/MM/DD hh:mm(:ss)'],
        fullDate_s_or_e: ['#startTime_f', '#endTime_f']
    },
    startTime_mon: {
        required: '#endTime_mon:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_mon: {
        required: '#startTime_mon:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_mon', '#endTime_mon']
    },
    startTime_tue: {
        required: '#endTime_tue:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_tue: {
        required: '#startTime_tue:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_tue', '#endTime_tue']
    },
    startTime_wed: {
        required: '#endTime_wed:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_wed: {
        required: '#startTime_wed:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_wed', '#endTime_wed']
    },
    startTime_thu: {
        required: '#endTime_thu:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_thu: {
        required: '#startTime_thu:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_thu', '#endTime_thu']
    },
    startTime_fri: {
        required: '#endTime_fri:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_fri: {
        required: '#startTime_fre:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_fri', '#endTime_fri']
    },
    startTime_sat: {
        required: '#endTime_sat:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_sat: {
        required: '#startTime_sat:filled',
        dateTime: ['hh:mm(:ss)'],
        time_s_or_e: ['#startTime_sat', '#endTime_sat']
    },
    startTime_sun: {
        required: '#endTime_sun:filled',
        dateTime: ['hh:mm(:ss)']
    },
    endTime_sun: {
        required: '#startTime_sun:filled',
        isFilled: ['.weekDiv :text', '请至少输入一天的起始时间。'],
        time_s_or_e: ['#startTime_sun', '#endTime_sun'],
        dateTime: ['hh:mm(:ss)']
    },
    'timeGrpMember[]': {
        required: function() {
            return $('select[name="timeGrpMember[]"] option').length === 0;
        }
    },
    timeGroupName: {
        required: true,
        addrName: true
    },
	dnssrv: {
        ip: true,
        required: '#dnssrv2:filled'
    },
	dnssrv2: {
        ip: true
    },
	destip: {
        required: true,
	    ip: true
    },
	nexthopip: {
        required: true,
	    ip: true
    },
    mac_address: {
        mac: true
    },
    mtu: {
        required: true,
        mtuRange: true,
        digits: true
    },
    manuFile: {
        required: true
    },
    upgradeFile: {
        required: true
    },
    CAcert: {
        required: true
    },
    SIScert: {
        required: true
    },
    SISkey: {
        required: true
    },
    realName: {
        realName: true
    },
	context_txt: {
		realContext_txt: true	
	},
    bindIp: {
        ipv4: true,
        viprequired: true
    },
    bindMac: {
        mac: true,
        viprequired: true
    },
    passwd_user: {
        required: true,
        passwd_user: true
    },
    passwd_user_again: {
        equalTo: "#passwd_user"
    },
    userListName: {
        required: true,
        realName: true,
        remote: {
            url: 'Function/resConf/user/userList.php',
            data: {
            	checkExistUserName: true
            }
        }
    },
    authUserListName: {
        required: true,
        realName: true,
        remote: {
            url: 'auth_check_login.php',
            data: {
            	checkExistUserName: true
            }
        }
    },

    activePwd: {
        required: true
    },
    'rolesMember[]': {
        required: function() {
            return $('select[name="rolesMember[]"] option').length === 0;
        }
    },
    authType: {
        required: true
    },
    validTime: {
        range: [0, 3650],
        digits: true
    },
    validTime_pwd: {
        range: [0, 3650],
        digits: true,
        checkMaxEq: ['#validTime_pwd', '#validTime']
    },
    twofaType: {
        required: true
    },
    lockTime: {
        required: true,
        range: [0, 3650],
        digits: true
    },
    importFile: {
        required: true
    },
    licenseFile: {
        required:true
    },
    startTime_log: {
        required: '#endTime_log:filled',
        dateTime: ['YYYY/MM/DD hh:mm']
    },
    endTime_log: {
        required: '#startTime_log:filled',
        dateTime: ['YYYY/MM/DD hh:mm'],
        StartTimeLessThanEndTime: ['#startTime_log', '#endTime_log']
    },
    sAddr: {
        ip: true   
    }, 
    dAddr: {
        ip: true   
    },
    sport: {
        range: [1, 65535],
        digits: true
    },
    dport: {
        range: [1, 65535],
        digits: true
    },
	ruleName: {
		required: true,
        realName: true,
        remote: {
            url: 'Function/resConf/user/accessControl.php',
            data: {
            	checkExistRuleName: true
            }
        }
	},
    roleName: {
        required: true,
        realName: true,
        remote: {
            url: 'Function/resConf/user/roleList.php',
            data: {
            	checkExistRoleName: true
            }
        }
    },
    allocatedTime: {
        range: [0, 525600],
        digits: true
    },
	batchToolExportFile: {
		required: true,
		fileExtension:['dat','txt']
	},
    hostComment: {
    	maxlength: 20
    },
    managerName: {
    	maxlength: 20
    },
    managerTel: {
    	maxlength: 20
    },
    CPU: {
    	range: [1,100],
        digits: true
    },
    memory: {
    	range: [1,100],
        digits: true
    },
    disk: {
    	range: [1,100],
        digits: true
    },
    trapStr: {
    	maxlength: 32
    },
    readOnly: {
    	maxlength: 32
    },
    writeAndReady: {
    	maxlength: 32
    },
    v3Usrname: {
    	required: '#snmpChk:checked',
    	maxlength: 32
    },
    authPhrase: {
    	required: '#snmpChk:checked',
    	minlength: 8,
    	maxlength: 32
    },
    privPhrase: {
    	required: '#snmpChk:checked',
    	minlength: 8,
    	maxlength: 32
    },
    serverip: {
		required: true,
    	ip: true
    },
    upPort: {
    	required: true,
        range: [1, 65535],
        digits: true
    },
    upAddr: {
    	required: true,
    	urlStandard: true
    },
    file: {
    	required: true
    },
    uploadLicense: {
    	required: true,
        fileExtension: ['dat']
    },
	'procList[]': {
		required: function() {
			if ($("input:radio[name='checkProc']:checked").val() === '1' && $('#procList option').length === 0){
				return true;
			} else {
				return false;
			}		
		}
    },
	'verList[]': {
		required: function() {
			if ($("input:radio[name='checkVer']:checked").val() === '1' && $('#verList option').length === 0){
				return true;
			} else {
				return false;
			}		
		}
	},
	txt_gapver: {
		realTxt_gapver: true
	},
	txt_gapProc : {
		realTxt_gapProc: true
	},
    updateFile: {
    	required: true
    },
    gateway: {
        required: true,
	    ip: true
    },     
    userInfo: {
    	ftpFilterOptUserInfo:true
    },    
    ftpId: {
        generalId: ['ftp']
    },
    uploadInfo: {
    	ftpFilterOptUploadOrDownInfo: true
    },
    downInfo: {
    	ftpFilterOptUploadOrDownInfo: true
    }, 
	hostIp: {
		required: true,
		ip: true,
		remote: {
            url: 'Function/systemManagement/admin/host.php',
            data: {
                checkExistIp: true
            }
        }
	},
	customTcpId: {
        required: true,
        digits: true,
        range: [1, 500],
        digits: true,
        remote: {
            url: 'Function/client/customized/tcpGeneralVisit.php',
            data: {
                checkExistId: true
            }
        }
    },
    customUdpId: {
        required: true,
        digits: true,
        range: [1, 500],
        digits: true,
        remote: {
            url: 'Function/client/customized/udpGeneralVisit.php',
            data: {
                checkExistId: true
            }
        }
    },
    dportReq: {
        required: true,
        range: [1, 65535],
        digits: true,
        remote: {
            url: 'Function/client/ftp/generalVisit.php',
            data: {
                checkExistLport: true
            }

        }
    }, 
    tcplportReq: {
        required: true,
        range: [1, 65535],
        digits: true,
        remote: {
            url: 'Function/client/customized/tcpGeneralVisit.php',
            data: {
                checkExistLport: true
            }

        }
    },    
    udplportReq: {
        required: true,
        range: [1, 65535],
        digits: true,
        remote: {
            url: 'Function/client/customized/udpGeneralVisit.php',
            data: {
                checkExistLport: true
            }
        }
    },
    fslip: {
        required: true,
        isFilled: ['input[name="fslportReq"]', '请填写本机端口。'],
        remote: {
            url: 'Function/client/fileSync/fileSync.php',
            data: {
                checkExistLport: true,
                fslportReq: function() {
                    return $('input[name="fslportReq"]').val();
                }
            }
        }
    },
	cslip: {
        required: true,
        isFilled: ['input[name="cslportReq"]', '请填写本机端口。'],
        remote: {
            url: 'Function/client/dbSync/dbSync.php',
            data: {
                checkExistLport: true,
                cslportReq: function() {
                    return $('input[name="cslportReq"]').val();
                }
            }
        }
    },
    fslportReq: {
        required: true,
        range: [1, 65535],
        digits: true,
        remote: {
            url: 'Function/client/fileSync/fileSync.php',
            data: {
                checkExistLport: true,
                fslip: function() {
                    return $('select[name="fslip"] option:selected').val();
                }
            }
        }
    },
    sportReq: {
        required: true,
        range: [1, 65535],
    	digits: true
    },
    lip: {
        required: true
    },
    serverIp: {
        required: true,
        ip: true
    },
    ftpFilterOptName: {
        required: true,
        realName: true,
        remote: {
            url: 'Function/client/ftp/ftp.php',
            data: {
                checkExistName: true
            }
        }
    },
    banner: {
        maxlength: 250
    },
    mulIp: {
        required: true,
        ipv4: true,
        mulIp: true
    },
    mulSrc: {
        required: true,
        ipv4: true
    },
    safePassId: {
        safePassId:true
    },
    safePassSrcPort: {
        unrequiredPortRange: true
    },
    safePassDestPort: {
    	required: true,
        unrequiredPortRange: true
    },
    serverPort:{
        unrequiredPortRange: true
    },
	serverDbsyncPort :{
		required: true,
    	digits: true,
		range: [1, 65535]
	},
	serverFileSyncPort:{
        required: true,
    	digits: true,
		range: [1, 65535]
    },
    publicPort:{
        unrequiredPortRange: true
    },
    srcIpList: {
    	required: true,
    	srcIpUnequalDestIp: ['trans']
    },
    srcIpList_safePass: {
    	required: true,
    	srcIpUnequalDestIp_safePass: true
    },
    srcIpList_general: {
    	required: true,
    	srcIpUnequalDestIp: ['general']
    },
    destIpList: {
    	required: true,
    	srcIpUnequalDestIp: ['trans']
    },
    destIpList_normal: {
    	required: true
    },
    destIpList_trans: {
    	required: true,
    	srcIpUnequalDestIp_safePass: true
    },
    serviceList: {
        serviceList: true
    },
    synFloodTxt: {
    	required: "#synFloodChk:checked",
    	digits: true,
		range: [1, 10000]
    },
    udpFloodTxt: {
    	required: "#udpFloodChk:checked",
    	digits:true,
		range:[1,10000]
    },
    icmpFloodTxt: {
    	required: "#icmpFloodChk:checked",
    	digits:true
    },
    
	clientDbId: {
		 required: true,
		 digits: true,
		 range: [1, 1000],
		 remote: {
            url: 'Function/client/dbSync/dbSync.php',
            data: {
                checkExistId: true
            }
        }
	},
	serverDbId: {
		required: true,
		digits: true,
		range: [1, 1000],
		remote: {
           url: 'Function/server/dbSync/dbSync.php',
           data: {
               checkExistId: true
            }
        }
	},
    spServerIp: {
    	required: true,
    	ipv4: true
    },
    outflowIpList: {
    	required: true
    },
    fsId: {
        required: true,
        digits: true,
        range: [1, 1000],
        remote: {
            url: 'Function/client/fileSync/fileSync.php',
            data: {
                checkExistId: true
            }
        }
    },
    commname: {
        required: true,
        addrName: true   
    },
    srcPort: {
    	range: [1,65535]
    },
    destPort: {
    	required: true,
    	range: [1,65535],
    	digits: true,
    	srcIpUnequalDestIp: ['trans']
    },
    clientId: {
    	required: true,
        range: [1, 1000],
        digits: true,
        remote: {
            url: 'Function/client/db/generalVisit.php',
            data: {
            	checkExistId: true
            }
        }
    },
	clientFileSyncTaskId: {
        generalId: ['clientFileSync']
    },
	clientFileSyncLip : {
		generalLip: ['cs', 'fieldset #clientFileSyncLport']	
	},
	clientFileSyncLport: {
		generalLport: ['cs','fieldset #clientFileSyncLip']
	},
	clientDbSyncTaskId: {
		generalId: ['clientDbSync']
	},
	clientDbSyncLip: {
		generalLip: ['cdbs','fieldset #clientDbSyncLport']
	},
	clientDbSyncLport: {
		generalLport: ['cdbs','fieldset #clientDbSyncLip']
	},
	sfileSyncTaskId: {
		generalId: ['sfileSync','Function/server/validation.php']
	},
	serverDbSyncTaskId: {
		generalId: ['serverDbSync','Function/server/validation.php']
	},
    ftpTransId: {
        transId: ['ftp', 'fieldset #ftpTranslportReq', undefined, 60000]
    },
    ftpTransda: {
    	ftpTransda: true
    },
    ftpTranslportReq: {
        transLport: ['ftp', 'fieldset #ftpTransId', undefined, 60000]
    },
    ftpGeneralId: {
        generalId: ['ftp']
    },
    ftpGeneralLip: {
        generalLip: ['ftp', 'fieldset #ftpGeneralLport']
    },
    ftpGeneralLport: {
        generalLport: ['ftp', 'fieldset #ftpGeneralLip']
    },
    customTcpGeneralId: {
    	customTcpGeneralId: true
    },
    tcpGeneralLip: {
    	tcpGeneralLip: true
    },
    tcpGeneralLport: {
    	tcpGeneralLport: true
    },
    customUdpGeneralId: {
    	customUdpGeneralId: true
    },
    udpGeneralLip: {
    	udpGeneralLip: true
    },
    udpGeneralLport: {
    	udpGeneralLport: true
    },
    pop3TransId: {
    	transId: ['pop3', 'fieldset #pop3TranslportReq', undefined, 42000]
    },
    pop3TranslportReq: {
    	transLport: ['pop3', 'fieldset #pop3TransId', undefined, 42000]
    },
    pop3GeneralId: {
    	generalId: ['pop3']
    },
    pop3GeneralLip: {
    	generalLip: ['pop3', 'fieldset #pop3GeneralLport']
    },
    pop3GeneralLport: {
    	generalLport: ['pop3', 'fieldset #pop3GeneralLip']
    },
    smtpTransId: {
    	transId: ['smtp', 'fieldset #smtpTranslportReq', undefined, 36000]
    },
    smtpTranslportReq: {
    	transLport: ['smtp', 'fieldset #smtpTransId', undefined, 36000]
    },
    smtpGeneralId: {
    	generalId: ['smtp']
    },
    smtpGeneralLip: {
    	generalLip: ['smtp', 'fieldset #smtpGeneralLport']
    },
    smtpGeneralLport: {
    	generalLport: ['smtp', 'fieldset #smtpGeneralLip']
    },
    sendTaskId: {
    	fileEXId: ['send']
    },
    sendTaskPort: {
    	required: true,
        range: [1, 65535],
    	digits: true
    },
    receiveTaskId: {
    	fileEXId: ['receive','Function/server/validation.php']
    },
    receiveTaskPort: {
    	required: true,
        range: [1, 65535],
    	digits: true
    },
    pop3GeneralSport: {
    	required: true,
        range: [1, 65535],
    	digits: true
    },
    smtpGeneralSport: {
    	required: true,
        range: [1, 65535],
    	digits: true
    },
    cdbGeneralId: {
    	generalId: ['cdb']  
    },
    cdbGeneralLip: {
    	generalLip: ['cdb', 'fieldset #cdbGeneralLport']  
    },                     
    cdbGeneralLport: {     
    	generalLport: ['cdb', 'fieldset #cdbGeneralLip']
    },                     
    cdbTransId: {          
    	transId: ['cdb', 'fieldset #cdbTransLport', undefined, 2000]
    },                     
    cdbTransLport: {       
        transLport: ['cdb', 'fieldset #cdbTransId', undefined, 2000]
    },                     
    cmsgGeneralId: {         
    	generalId: ['cmsg']    
    },                     
    cmsgGeneralLip: {        
    	generalLip: ['cmsg', 'fieldset #cmsgGeneralLport']   
    },                     
    cmsgGeneralLport: {      
    	generalLport: ['cmsg', 'fieldset #cmsgGeneralLip'] 
    },
    customTcpTransId: {       
    	customTcpTransId: true  
    },                     
    customtcpTransLport: {         
    	customtcpTransLport: true    
    },                     
    customUdpTransId: {        
    	customUdpTransId: true   
    },                     
    customUdpTransLport: {      
    	customUdpTransLport: true 
    },   
    FEname: {
        required: true,
        addrName: true,
        remote: {
            url: 'Function/client/fileEx/allowedFile.php',
            data: {
                checkExistFileName: true
            }
        }
    },
    FEfilename: {
        filename: true,
        maxlength: 255
    },
    'FEfilenames[]': {
        required: function() {
            return $('#filenames option').length === 0;
        }
    },
    'FEbflist[]': {
        required: function() {
            return $('#bflist option').length === 0;
        }
    },
    'FEaflist[]': {
        required: function() {
            return $('#aflist option').length === 0;
        }
    },
    FEcontext: {
        maxlength: 50
    },
    FECCname: {
        required: true,
        addrName: true,
        remote: {
            url: 'Function/client/fileEx/bannedContent.php',
            data: {
                checkExistName: true
            }
        }
    },
    FEfilterName: {
        required: true,
        FEfilterName: true,
        remote: {
            url: 'Function/client/fileEx/filter.php',
            data: {
                checkExistName: true
            }
        }
    },
    sizemax: {
        digits: true,
        checkMax: ['#sizemin', '#sizemax']
    },
    sizemin: {
        digits: true,
        checkMax: ['#sizemin', '#sizemax']
    },
    timemax: {
        dateTime: ['YYYY/MM/DD hh:mm:ss'],
        fullDate_s_or_e: ['#timemin', '#timemax']
    },
    timemin: {
        dateTime: ['YYYY/MM/DD hh:mm:ss'],
        fullDate_s_or_e: ['#timemin', '#timemax']
    },
    usrName: {
    	required: true,
        realName: true,
        remote: {
            url: 'Function/client/safeBrowse/localUsrManage.php',
            data: {
            	checkExistName: true
            }
        }
    },
    psswd1: {
    	required: true,
        passwd: [6, 15]
    },
    psswd2: {
    	equalTo: "#psswd1"
    },
    readyString: {
        required: '#sendMethod_C:checked',
        rcString: ['#readyString', '#completeString'],
        maxlength: 15
    },
    completeString: {
        required: '#sendMethod_C:checked',
        rcString: ['#readyString', '#completeString'],
        maxlength: 15
    },
    radiusSIp: {
    	required: true,
    	ip: true
    },
    radiusPort: {
    	required: true,
    	range: [1,65535],
    	digits: true
    },
    sharedKey: {
    	required: true
    },
    ldapSIp: {
    	required: true,
    	ip: true
    },
    ldapDN: {
    	required: true
    },
    sip: {
        required: true,
        ip: true
    },
    shareName: {
        required: true,
        shareNameParam: true
    },
    smbUser: {
        maxlength: 20
    },
    smbPwd: {
        maxlength: 20
    },
    url_list: {
    	required: true,
    	urlFilter: true,
    	remote: {
            url: 'Function/client/safeBrowse/urlFilter.php',
            data: {
            	checkExistList: true,
            	edit: function() {
            		return $("input[name='type']").val();
            	},
            	hi_list: function() {
            		return $("input[name='hid_list']").val();
            	}
            }
        }
    },
    postfix_list: {
        required: true,
        ftpFilterOptUploadOrDownInfo: true,
        remote: {
            url: 'Function/client/safeBrowse/postfixFilter.php',
            data: {
            	checkExistList: true,
            	edit: function() {
            		return $("input[name='type']").val();
            	},
            	hi_list: function() {
            		return $("input[name='hid_list']").val();
            	}
            }
        }
    },
    portReq: {
        required: true,
        range: [1, 65535],
        digits: true
    },
    msgTransId: {
    	required: true,
        range: [1, 1000],
        digits: true,
        remote: {
            url: 'Function/client/msgTrans/msgTrans.php',
            data: {
            	checkExistId: true
            }
        }
    },
    keyName: {
    	required: true,
    	addrName: true,
    	remote: {
    		url: 'Function/client/safeBrowse/keywordFilter.php',
            data: {
            	checkExistName: true
            }
    	}
    },
    'contextList[]': {
        required: function() {
            return $('#contextList option').length === 0;
        }
    },
    nativePort: {
        range: [1,65535],
        digits: true
    },
    httpPort: {
    	required: true,
    	httpPort: true
    },
    httpsPort: {
    	required: true,
    	httpPort: true
    },
    memoryMax: {
        required: true,
        range: [10,256]
    },
    httpRequestMax: {
        required: true,
        range: [1,64]
    },
    mailName: {
    	required: true,
    	addrName: true,
    	remote: {
    		url: 'Function/client/mail/mailAddr.php',
            data: {
            	checkExistName: true
            }
    	}
    },
    mailAddr_txt: {
    	mailAddr: true
    },
    'mailList[]': {
        required: function() {
            return $('#mailList option').length === 0;
        }
    },
    keywordName: {
    	required: true,
    	maxlength: 15,
    	remote: {
    		url: 'Function/client/mail/keyword.php',
            data: {
            	checkExistName: true
            }
    	}
    },
    'keywordList[]': {
        required: function() {
            return $('#keywordList option').length === 0;
        }
    },
    attachName: {
    	required: true,
    	maxlength: 15,
    	remote: {
    		url: 'Function/client/mail/attachExt.php',
            data: {
            	checkExistName: true
            }
    	}
    },
    'attachList[]': {
        required: function() {
            return $('#attachList option').length === 0;
        }
    },
    attach_txt: {
    	ftpFilterOptUploadOrDownInfo: true
    },
    cfilename: {
        required: true,
        filename: true,
        maxlength: 128,
        remote: {
            url: 'Function/client/msgTrans/callowedFile.php',
            data: {
                checkExistcFileName: true,
                type: function() {
            		return $("input[name='type']").val();
            	},
            	hi_list: function() {
            		return $("input[name='hid_list']").val();
            	}
            }
        }
    },
    cblacklist: {
        required: true,
        maxlength: 64,
        remote: {
            url: 'Function/client/msgTrans/cbannedContent.php',
            data: {
            	checkExistcBlacklist: true,
            	type: function() {
            		return $("input[name='type']").val();
            	},
            	hi_list: function() {
            		return $("input[name='hid_list']").val();
            	}
            }
        }
    },
    cwhitelist: {
        required: true,
        maxlength: 64,
        remote: {
            url: 'Function/client/msgTrans/callowedContent.php',
            data: {
            	checkExistcWhitelist: true,
            	type: function() {
            		return $("input[name='type']").val();
            	},
            	hi_list: function() {
            		return $("input[name='hid_list']").val();
            	}
            }
        }
    },
    userAuthenName: {
        required: true,
        realName: true,
        remote: {
            url: 'Function/client/msgTrans/localUserAuthen.php',
            data: {
            	checkExistAuthenName: true
            }
        }
    },
    UserPriName: {
        required: true,
        remote: {
            url: 'Function/client/msgTrans/userPrivilege.php',
            data: {
            	checkExistUserPriName: true
            }
        }
    },
    fslportReq: {
        required: true,
        range: [1, 65535],
        digits: true,
        remote: {
            url: 'Function/client/fileSync/fileSync.php',
            data: {
                checkExistLport: true,
				fsId : function() {
					if ($('input[name="type"]').val() === 'edit') {
                        return $('fieldset input[name="fsId"]').val();
                    } else {
                        return -1;
                    }
				},
                fslip: function() {
					return $('select[name="fslip"] option:selected').val();
                }
            }
        }
    },
	cslportReq: {
        required: true,
        range: [1, 65535],
        digits: true,
        remote: {
            url: 'Function/client/dbSync/dbSync.php',
            data: {
                checkExistLport: true,
				clientDbId : function() {
					if ($('input[name="type"]').val() === 'edit') {
                        return $('fieldset input[name="clientDbId"]').val();
                    } else {
                        return -1;
                    }
				},
                cslip: function() {
					return $('select[name="cslip"] option:selected').val();
                }
            }
        }
    },
    MfilterName: {
        required: true,
        realName: true,
        remote: {
            url: 'Function/client/mail/mailfilter.php',
            data: {
                checkExistName: true
            }
        }
    },
    attachmax: {
        range: [0, 10],
        digits: true
    },
    sendfilter: {
        required : function() {
            return $('select[name="senderList"] option:selected').val() !== '';
        }
    },
    recvfilter: {
        required : function() {
            return $('select[name="recvList"] option:selected').val() !== '';
        }
    },
    resTimeName: {
        required: true,
        realName: true,
        remote: {
            url: 'Function/resConf/time/timeList.php',
            data: {
            	checkExistResTimeName: true
            }
        }
    },
    ifname: {
        required: true
    },
    addr: {
        required: true,
        remote: {
            url : 'Function/networkManagement/virtualAddr/virtualAddr.php',
            data: {
                checkExistVirtualAddr: true
            }
        }
    },
    cdblportReq: {
        required: true,
        range: [1, 65535],
        digits: true,
        remote: {
            url: 'Function/client/db/generalVisit.php',
            data: {
            	checkExistLport: true,
                cdblip: function() {
                	return $('#cdblip option:selected').val();                	
                },
                type: function () {
                	return $('#type').val();                	
                },
                clientId: function() {
                	return $('#clientId').val();
                }
            }
        }
    },
    cdblip: {
        required: true,
        remote: {
            url: 'Function/client/db/generalVisit.php',
            data: {
                checkExistLip: true           
            }
        }
    }, 
    sAddress: {
        dbTransAddress: true
    },
    lAddress: {
        dbTransAddress: true
    },
    cmsglportReq: {
        required: true,
        range: [1, 65535],
        digits: true,
        remote: {
            url: 'Function/client/msgTrans/msgTrans.php',
            data: {
            	checkExistLport: true,
                cmsgLip: function() {
                	return $('#cmsgLip option:selected').val();                	
                },
                type: function () {
                	return $('#type').val();                	
                },
                msgTransId: function() {
                	return $('#msgTransId').val();
                }
            }
        }
    },
    cmsgLip: {
        required: true,
        remote: {
            url: 'Function/client/msgTrans/msgTrans.php',
            data: {
                checkExistLip: true              
            }
        }
    },
    serverPortReq: {
        required: true,
        range: [1, 65535],
        digits: true
    },
    ipaddr: {
    	iprange: true
    },
    userNameList: {
        required: true
    },
    userFilterNameList: {
        required: true,
        userFilterName: true,
        maxlength: 1024        
    },
    userName: {
        required: true,
        addrName: true,
        remote: {
            url: 'Function/client/db/userFilter.php',
            data: {
                checkExistUserName: true              
            }
        }
    },
    sqlName: {
        required: true,
        addrName: true,
        remote: {
            url: 'Function/client/db/sqlFilter.php',
            data: {
                checkExistSqlName: true              
            }
        }
    },
    "sqlCmdInfo[]": {
        required: true,
        remote: {
            url: 'Function/client/db/sqlFilter.php',
            data: {
                checkSqlCmdInfo: true               
            }
        }
    },
    optionName: {
        required: true,
        addrName: true,
        remote: {
            url: 'Function/client/db/optionsFilter.php',
            data: {
                checkExistOptionsName: true              
            }
        }
    },
    scanInterval: {
        required: true,
        range: [1,1000],
    	digits: true
    },
    connectTimes: {
        required: true,
        range: [1,1000],
    	digits: true
    },
    ignoreIp: {
    	autoip: true
    },
    virtualAddr: {
        required: true
    },
    virtualPort: {
        required: true,
        range: [1, 65535],
    	digits: true
    },
	source_address: {
        required: true,
        ipv4: true
    },
	target_address: {
		required: true,
		ipv4: true
	},
	txt_msg: {
		required: true
	},
	txt_ipID:{
		digits: true
	},
	txt_ipTTL:{
		digits: true
	},
	txt_tcpACKnum:{
		digits: true
	},
	txt_tcpSEQnum:{
		digits: true
	},
    ftpName: {
        required: true,
        addrName: true
    },   
    ftpPort: {
        required: true,
        range: [1, 65535],
    	digits: true
    },
    password1: {
        required: true
    },
    ftpMinute: {
        required: true,
        range: [0, 59],
    	digits: true
    },
    ftpHour: {
        required: true,
        range: [0, 23],
    	digits: true
    },
    ftpDay: {
        required: true,
        range: [0, 31],
    	digits: true
    },
    remoteLogIp: {
        required: true,
        ip: true,
        remote: {
          url: 'Function/log/conf/remoteConf.php',
          data: {
                checkExistServerIP: true              
          }
        }
    },
    logPortReq: {
        required: true,
        range: [1, 65535],
    	digits: true
    },
    logLimitSize: {
        required: true,
        range: [5, 30],
    	digits: true
    },
    timeLimit: {
        range: [0, 5000],
    	digits: true
    },
    iplist: {
        autoip: true
    },
    redirectUrl: {
    	required: true,
        url: true
    },
    authPort: {
        required: true,
        range: [1, 65535],
    	digits: true
    },
    maxLoadTimes: {
        required: true,
        range: [1, 5],
    	digits: true
    },
    unlockTime: {
        required: true,
        range: [1, 1440],
    	digits: true
    },
    pwdPeriod: {
        required: true,
        range: [0, 365],
    	digits: true
    },
    pwdRemind: {
        required: true,
        range: [1, 30],
    	digits: true
    },
    idleTime: {
        required: true,
        range: [0, 1440],
    	digits: true
    },
    AuthPolicyName: {
        required: true,
        realName: true
    },
    authIp: {
        ipv4: true
    },
    authNetmask: {
    	Authnetmask: true
    },   
    authRange_s: {
        ipv4: true
    },
    authRange_e: {
        ipv4: true
    },
    userKeyWord: {
        required: true,
        maxlength: 32
    },
    certCommname: {
        maxlength: 32
    },
	ha_ip: {
		required: true,
		ipv4: true
	},
	ipaddress: {
		required: true,
		ipv4: true	
	},
	macaddress: {
		required: true,
		mac:true	
	},
    fileSize: {
        range: [1, 60]
    }
};

// message
var validMsg = {
    expTime: '不能小于1分钟或超过1440分钟(24小时)',
	haTime: '不能小于15秒或超过120秒',
    limitErrNum: '登录错误次数不能小于1次或超过5次',
    limitErrTime: '间隔时间不能小于1分钟或超过1440分钟(24小时)',
    account: {
        required: '请填写帐号名。',
		remote: '该用户名已存在，请重新填写。'
    },
    passwd: {
        required: '请填写密码。'
    },
    passwd_again: '两次密码不一致。',
    role: '请至少选择一个帐号类型。',
    ip: {
        required: '请填写IP地址。'
    },
    netmask: {
        required: '请填写子网掩码。'
    },
    addrnetmask: {
        required: '请填写子网掩码。'
    },
    addrName: {
        required: '请填写地址名称。',
        remote: '此名称已在地址列表/地址组里存在，请重新填写。'
    },
    domainAddrName: {
        required: '请填写域名地址名称。',
        remote: '此名称已在地址列表/地址组里存在，请重新填写。'
    },
    addrGrpName: {
        required: '请填写地址组名称。',
        remote: '此名称已在地址列表/地址组里存在，请重新填写。'
    },
    'addrGrpMember[]': '请至少选择一个地址组成员。',
    netname: {
        required: '必填。'
    },
    ipAddr_r: {
        required: '请输入反IP地址。'
    },
    range_s: {
        required: '请输入起始地址。',
        ipv4: '起始地址只支持IPV4地址。'
    },
    range_e: {
        required: '请输入结束地址。',
        ipv4: '结束地址只支持IPV4地址。'
    },
    record_type_mx: '请至少选择一个帐号类型。',
    addStaticAddr: '请填写IP地址。',
    ntpSyncInterval: '不能小于1分钟或超过65535分钟。',
    max_record: '请填写最大记录数。',
    interval: {
        required: '必填。',
        range: '1-65535。'
    },
    autoParseErrInterval: '请填写自动解析记录失效间隔。',
    timeListName: {
        required: '请填写时间列表名称。'
    },
    startTime_f: {
        required: '请填写起始时间。'
    },
    endTime_f: {
        required: '请填写终止时间。'
    },
    startTime_mon: {
        required: '请填写星期一的起始时间。'
    },
    endTime_mon: {
        required: '请填写星期一的终止时间。'
    },
    startTime_tue: {
        required: '请填写星期二的起始时间。'
    },
    endTime_tue: {
        required: '请填写星期二的终止时间。'
    },
    startTime_wed: {
        required: '请填写星期三的起始时间。'
    },
    endTime_wed: {
        required: '请填写星期三的终止时间。'
    },
    startTime_thur: {
        required: '请填写星期四的起始时间。'
    },
    endTime_thur: {
        required: '请填写星期四的终止时间。'
    },
    startTime_fri: {
        required: '请填写星期五的起始时间。'
    },
    endTime_fri: {
        required: '请填写星期五的终止时间。'
    },
    startTime_sat: {
        required: '请填写星期六的起始时间。'
    },
    endTime_sat: {
        required: '请填写星期六的终止时间。'
    },
    startTime_sun: {
        required: '请填写星期日的起始时间。'
    },
    endTime_sun: {
        required: '请填写星期日的终止时间。'
    },
    'timeGrpMember[]': '请至少选择一个时间组成员。',
    timeGroupName: {
        required: '请填写时间组名称。'
    },
	destip: {
        required: '目的地址不能为空'
    },
	nexthopip: {
        required: '下一跳地址不能为空'
    },
    mac_address: {
        required: '请填写MAC地址。'
    },
    mtu: {
        required: '千兆设备的范围是64-16128'
    },
    manuFile: '请选择要上传的配置文件',
    upgradeFile:'请选择要升级的文件',
    CAcert:'请选择CA中心证书。',
    SIScert:'请选择证书。',
    SISkey:'请选择密钥。',
    passwd_user: {
        required: '请填写密码。'
    },
    passwd_user_again: '两次密码不一致。',
    userListName: {
        required: '用户名称不允许为空。',
        remote: '用户名称已存在。'
    },
    authUserListName: {
        required: '用户名称不允许为空。',
        remote: '用户名称已存在。'
    },
    activePwd: {
        required: '动态密码不能为空。'
    },
    'rolesMember[]': '所属角色不能为空。',
    authType: {
        required: '选择任意一种认证方式。'
    },
    validTime: {
        range: '0表示永久生效, 要求在0到3650之间' ,
        digits: '请填写数字'
    },
    validTime_pwd: {
        range: '0表示永久生效, 要求在0到3650之间',
        digits: '请填写数字',
        checkMaxEq: '密码有效时间不能超过用户有效时间。'
    },
    twofaType: {
        required: '选择任意一种认证方式。'
    },
    lockTime: {
        required: '请输入锁定时间。',
        range: '0到3650分钟,0表示永久锁定。',
        digits: '请填写数字'
    },
    importFile: '请选择文件',
    licenseFile: '请选择证书',
    startTime_log: {
        required: '请填写起始时间。'
    },
    endTime_log: {
        required: '请填写截至时间。'
    },
    sAddr: {
        ip: '源地址格式错误。'
    },
    dAddr: {
        ip: '目的地址格式错误。'
    },
    sport: '源端口范围1 - 65535',
    dport: '目的端口1 - 65535',
	ruleName: {
		required: '请输入规则名称。',        
        remote: '规则名称已存在。'
	},
    roleName: {
        required: '请输入用户名称。',        
        remote: '角色名称已存在。'
    },
    allocatedTime: '分配时间在0 - 525600之间',
    dnssrv: {
        ip: '域名服务器IP1格式错误。',
        required: '域名服务器IP1不能为空。'
    },
    dnssrv2: '域名服务器IP2格式错误。',
	batchToolExportFile: {required: '请选择要上传的文件'},
    v3Usrname: '用户名称不能超过32个字符且不能为空',
    hostComment: '本机备注不能超过20个字符',
    managerName: '负责人姓名不能超过20个字符',
    managerTel: '负责人电话不能超过20个字符',
    CPU: 'CPU 利用率阈值范围1 - 100 %',
    memory: '内存利用率阈值范围1 - 100 %',
    disk: '磁盘利用率阈值本机地址不能为空.范围1 - 100 %',
    trapStr: 'Trap发送字符串不能超过32个字符',
    readOnly: '只读团体字符串不能超过32个字符',
    writeAndReady: '读写团体字符串不能超过32个字符',
    authPhrase: '认证密码不能超过32个字符且不能少于8个字符',
    privPhrase: '加秘密码不能超过32个字符且不能少于8个字符',
    serverip: {
		required: '必填。'
	},
    ipv4: {
        required: '请填写IPV4或者IPV6地址。'
    },
    ipv6: {
        required: '请填写IPV4或者IPV6地址。'
    },
    devIpv4: {
        required: '请填写IPV4或者IPV6地址。',
        remote: '此ip地址已被使用。'
    },
    devIpv6: {
        required: '请填写IPV4或者IPV6地址。',
        remote: '此ip地址已被使用。'
    },
    ipv4Netmask : {
        required: '请填写IPV4地址的子网掩码。'
    },
    ipv6Netmask : {
        required: '请填写IPV6地址的子网掩码。'
    },
    redundanceIpv4:{
        required: '请填写IPV4地址。',
        remote: '此ip地址已被使用。'
    },
    redundanceMask:{
        required: '请填写IPV4地址的子网掩码。'
    },
    devIpv4Netmask : {
        required: '请填写IPV4地址的子网掩码。'
    },
    devIpv6Netmask : {
        required: '请填写IPV6地址的子网掩码。'
    },
    upPort: {
    	required: '请输入服务器端口。',
    	range: '无效的升级服务器端口。',
    	digits: '请填写有效数字'
    },
    upAddr: {
        required: '请输入升级服务器地址。',
        urlStandard: '升级服务器地址格式错误。'
    },
    file: '请选择要升级的文件',
    uploadLicense: {
        required: '请选择要升级的文件'
    },
	'procList[]': {
		required: '进程不能为空。'
	},
	'verList[]': {
		required: '版本不能为空。'
	},
    updateFile: '请选择要升级的文件',
    gateway : {
        required: '请填写IP地址。'
    },
	hostIp:{
		required: '请输入IP地址。',
		ip : 'IP格式错误',
		remote :'此IP地址已存在'
	},	
	customTcpId: {
        required: '请输入任务号。',
        digits: '请填写有效数字。',
        range: '任务号范围为1-500。',
        remote: '任务号已存在。'
    },
    customUdpId: {
        required: '请输入任务号。',
        digits: '请填写有效数字。',
        range: '任务号范围为1-500。',
        remote: '任务号已存在。'
    },
    cusTcpTransId: {
        required: '请输入任务号。',
        digits: '请填写有效数字。',
        range: '任务号范围为1-1000',
        remote: '任务号已存在。'
    },
    cusUdpTransId: {
        required: '请输入任务号。',
        digits: '请填写有效数字。',
        range: '任务号范围为1-1000',
        remote: '任务号已存在。'
    },
    cliTransPortReq: {
    	required: '请输入端口号。',
    	range: '目的端口1 - 65535。',   
    	digits: '请填写有效数字。'
    },
	lport: {
		required: '请输入端口号。',
    	range: '目的端口1 - 65535。',   
    	digits: '请填写有效数字。'
	},
    dblocalPort: {
    	required: '请输入端口号。',
    	range: '目的端口1 - 65535。',   
    	digits: '请填写有效数字。',
    	remote: '任务号与端口号的和已存在，请重新添加。'
    },
    lip: '本机地址不能为空。',
    tcplportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被使用。'
    },
    dportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被使用。'
    },
    tcpTranslportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被使用。'
    },
    udpTranslportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被使用。'
    },
    pop3TransdportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被使用。'
    },
    udplportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被使用。'
    },
    fslip: {
        required: '请填写本机端口。',
        remote: '此本机端口已被使用。'
    },
	cslip: {
        required: '请填写本机端口。',
        remote: '此本机端口已被使用。'
    },
    fslportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被使用。'
    },
	cslportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被使用。'
    },
    sportReq: {
    	required: '必填。',
    	range: '服务器端口1 - 65535。',
    	digits: '请填写有效数字。'
    },
    serverIp: {
        required: '必填。'
    },
    safePassDestPort: {
    	required: '请输入目的端口。'
    },
	srcIpList: {
		required: '请选择源地址。'
	},
	destIpList_normal: {
		required: '请选择目的地址。'
	},
	destIpList_trans: {
		required: '请选择目的地址。'
	},
	synFloodTxt: {
    	required: '请输入抗synflood阈值。',
    	digits: '请输入有效数字。',
		range: '阈值大小为1 - 10000。'
    },
    udpFloodTxt: {
    	required: '请输入抗udpflood阈值。',
    	digits: '请输入有效数字。',
		range: '阈值大小为1 - 10000。'
    },
    icmpFloodTxt: {
    	required: '请输入抗icmpflood阈值。',
    	digits: '请输入有效数字。'
    },
    ftpId: {
        required: '必填。',
        digits: '请填写有效数字。',
        range: '任务号范围为1-1000',
        remote: '任务号已存在。'
    },
	clientDbId: {
		required: '请输入任务号。',
        digits: '请填写有效数字。',
        range: '任务号范围为1-1000',
        remote: '任务号已存在。'
	},
	serverDbId : {
		required: '请输入任务号。',
        digits: '请填写有效数字。',
        range: '任务号范围为1-1000',
        remote: '任务号已存在。'
	},
    ftpFilterOptName: {
        required: '必填。',
        remote: '名称已存在。'
    },
    banner: '您最多能够输入250个字符。',
    spServerIp: {
    	required:'请输入服务器地址'
    },
    outflowIpList: {
    	required:'请选择流出网口IP'
    },
    fsId: {
        required: '请输入任务号。',
        digits: '请填写有效数字。',
        range: '任务号范围为1-1000',
        remote: '任务号已存在。'
    },
    commname: {
        required: '必填。'
    },
    destPort: {
    	required: '请输入目的端口',
    	range: '目的端口范围为1-65535',
    	digits: '请填写有效数字。'
    },
    clientId: {
    	required: '请输入任务号。',
        range: '任务号范围为1-1000',
        digits: '请填写有效数字。',
        remote: '任务号已存在。'
    },
    clientTransId: {
    	required: '请输入任务号。',
        range: '任务号范围为1-1000',
        digits: '请填写有效数字。',
        remote: '任务号已存在。'
    },
    FEname: {
        required: '必填。',
        remote: '文件名已存在。'
    },
    'FEfilename': {
        maxlength: '不得超过255个字符。'
    },
    'FEfilenames[]': '内容不能为空。',
    'FEbflist[]': '内容不能为空。',
    'FEaflist[]': '内容不能为空。',
    FECCname: {
        required: '必填。',
        remote: '文件名已存在。'
    },
    FEfilterName: {
        required: '必填。',
        remote: '名称已存在。'
    },
    sizemax: {
        digits: '请填写有效数字。'
    },
    sizemin: {
        digits: '请填写有效数字。'
    },
    usrName: {
    	required: '请输入用户名。',
    	remote: '用户名已存在'
    },
    psswd1: {
    	required: '请输入密码。'
    },
    psswd2:  '两次输入密码不一致。',
    readyString: {
        required: '必填。',
        maxlength: '不得超过15个字符。'
    },
    completeString: {
        required: '必填。',
        maxlength: '不得超过15个字符。'
    },
    radiusSIp: {
    	required: '请输入服务器IP地址。'
    },
    radiusPort: {
    	required: '请输入端口。',
    	range: '端口范围为1-65535。',
    	digits: '请填写有效数字。'
    },
    sharedKey: '请输入共享密钥。',
    ldapSIp: {
    	required: '请输入LDAP服务器地址。'
    },
    ldapDN: '请输入LDAP DN。',
    sip: {
        required: '必填。'
    },
    shareName: {
        required: '必填。'
    },
    smbUser: '不得超过20个字符。',
    smbPwd: '不得超过20个字符。',
    url_list: {
    	required: '请输入URL。',
		remote: 'URL已存在。'
    },
    postfix_list: {
        required: '请输入文件后缀名。',
        remote: '文件后缀名已存在。'
    },
    portReq: {
        required: '必填。',
        range: '端口范围1-65535',
        digits: '请填写有效数字。'
    }, msgTransId: {
    	required: '请输入任务号。',
        range: '任务号范围为1-1000',
        digits: '请填写有效数字。',
        remote: '任务号已存在。'
    },
    keyName: {
    	required: '请输入名称。',
    	remote: '名称已存在。'
    },
    'contextList[]': '请输入禁止的内容。',
    nativePort: {
        range: '端口范围1-65535',
        digits: '请填写有效数字。'
    },
    httpPort: {
    	required: '请输入Http协议可访问端口。'
    },
    httpsPort: {
    	required: '请输入Https协议可访问端口。'
    },
    memoryMax: {
        required: '请输入缓存文件上限。',
        range: '缓存文件上限范围为10-256M'
    },
    httpRequestMax: {
        required: '请输入HTTP请求头部上限。',
        range: 'HTTP请求头部上限范围为1-64KB'
    },
    mailName: {
    	required: '请输入名称。',
    	remote: '名称已存在。'
    },    
    'mailList[]': '请输入邮件地址。',
    keywordName: {
    	required: '请输入名称。',
    	maxlength: '名称最大长度为15。',
    	remote: '名称已存在。'
    },
    'keywordList[]': '请输入关键字。',
    attachName: {
    	required: '请输入名称。',
    	maxlength: '名称最大长度为15。',
    	remote: '名称已存在。'
    },
    'attachList[]': '请输入扩展名。',
    attach_txt: '请输入正确的扩展名。如:.exe',
    cfilename: {
        required: '必填。',
        remote: '文件名已存在。',
        maxlength: '您最多能够输入128个字符。'
    },
    cblacklist: {
        required: '必填。',
        remote: '文件名已存在。',
        maxlength: '您最多能够输入64个字符。'
    },
    cwhitelist: {
        required: '必填。',
        remote: '文件名已存在。',
        maxlength: '您最多能够输入64个字符。'
    },
    userAuthenName: {
        required: '必填。',
        remote: '文件名已存在。'
    },
    UserPriName: {
        required: '必填。',
        remote: '文件名已存在。'
    },
    MfilterName: {
        required: '必填。',
        remote: '此名称已存在。'
    },
    attachmax: '范围在0-10。',
    sendfilter: '请选择发件人过滤类型。',
    recvfilter: '请选择收件人过滤类型。',
    resTimeName: {
        required: '必填。',
        remote: '此名称已在时间列表/时间组里存在，请重新添加。'
    },
    ifname: {
        required: '必填。'
    },
    addr: {
        required: '必填。',
        remote: '已存在。'
    },
    cdblportReq: {
        required: '请填写目的端口。',
        range: '目的端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此目的端口已被与本IP相同的IP使用，请重新填写。'
    },
    cdblip: {
    	required: '请填写本机地址。',
        remote: '请填写本机地址。'
    },
    cmsglportReq: {
        required: '请填写本机端口。',
        range: '本机端口1 - 65535。',
        digits: '请填写有效数字。',
        remote: '此本机端口已被与本IP相同的IP使用，请重新填写。'
    },
    cmsgLip: {
    	required: '请填写本机地址。',
        remote: '请填写本机地址。'
    },
    serverPortReq: {
        required: '请填写服务器端口。',
        range: '服务器端口1 - 65535。',
        digits: '请填写有效数字。'
    },
	serverDbsyncPort: {
		required: '请填写服务器端口。',
        range: '服务器端口1 - 65535。',
        digits: '请填写有效数字。'
	},
	serverFileSyncPort: {
        required: '请填写服务器端口。',
        range: '服务器端口1 - 65535。',
        digits: '请填写有效数字。'
    },
    userNameList: {
        required: '必填。'
    },
    userFilterNameList: {
        required: '必填。',
        maxlength: '您最多能够输入1024个字符。'
    },
    userName: {
        required: '必填。',
        remote: '该用户名已存在，请重新填写。'
    },
    sqlName: {
        required: '必填。',
        remote: '该SQL名已存在，请重新填写。'
    },
    'sqlCmdInfo[]': {
        required: '请至少选择一项SQL语句列表。',
        remote: '请至少选择一项SQL语句列表。'
    },
    optionName: {
        required: '必填。',
        remote: '该过滤名已存在，请重新填写。'
    },
    scanInterval: {
        required: '请配置时间间隔。',
        range: '时间间隔1 - 1000。',
        digits: '请填写有效数字。'
    },
    connectTimes: {
        required: '请配置发现端口连接次数。',
        range: '发现端口连接次数1 - 1000。',
        digits: '请填写有效数字。'
    },
    virtualAddr: {
        required: '请填写虚拟地址。'
    },
    virtualPort: {
        required: '请填写虚拟端口。',
        range: '虚拟端口范围是1至65535',
        digits: '请填写有效数字。'
    },
	source_address: {
        required: '源地址不能为空。'
    },
	target_address:{
		required: '目的地址不能为空。'
	},
	txt_msg:{
		required: '报警事件主题不能为空。'
	},
	txt_ipID:{
		digits: '请填写有效数字。'
	},
	txt_ipTTL:{
		digits: '请填写有效数字。'
	},
	txt_tcpACKnum:{
		digits: '请填写有效数字。'
	},
	txt_tcpSEQnum:{
		digits: '请填写有效数字。'
	},
    ftpName: {
        required: '请输入用户名。'
    },
    ftpPort: {
        required: '请填写端口号。',
        range: '范围1 - 65535。',
        digits: '请填写有效数字。'        	
    },
    password1: {
    	required: '请填写密码。'
    },
    ftpMinute: {
        required: '请填写分钟,0表示未选择。',
        range: '范围0 - 59。',
        digits: '请填写有效数字。'        	
    },
    ftpHour: {
        required: '请填写小时,0表示未选择。',
        range: '范围0 - 23。',
        digits: '请填写有效数字。'
    },
    ftpDay: {
        required: '请填写日期,0表示未选择。',
        range: '范围0 - 31。',
        digits: '请填写有效数字。'
    },
    remoteLogIp: {
        required: '请输入服务器IP地址。',
        remote: '此服务器IP已使用，请重新填写。'
    },
    logPortReq: {
        required: '请填写端口。',
        range: '范围1 - 65535。',
        digits: '请填写有效数字。'
    },
    logLimitSize: {
        required: '请填写日志文件阈值。',
        range: '范围5 - 30。',
        digits: '请填写有效数字。'
    },
    timeLimit: {
        required: '必填。',
        range: '范围为0-5000。',
        digits: '请填写有效数字。'
    },
    redirectUrl: {
    	required: '请输入URL。',
        url: '不正确的URL格式。'
    },
    authPort: {
    	required: '请填写认证端口。',
        range: '认证端口1 - 65535。',
        digits: '请填写有效数字。'
    },
    maxLoadTimes: {
        required: '必填。',
        range: '范围为1-5。',
        digits: '请填写有效数字。'
    },
    unlockTime: {
    	required: '必填。',
        range: '范围为1-1440。',
        digits: '请填写有效数字。'
    },
    pwdPeriod: {
    	required: '必填。',
        range: '范围为0-365。',
        digits: '请填写有效数字。'
    },
    pwdRemind: {
    	required: '必填。',
        range: '范围为1-30。',
        digits: '请填写有效数字。'
    },
    idleTime: {
    	required: '必填。',
        range: '范围为0-1440。',
        digits: '请填写有效数字。'
    },
    AuthPolicyName: {
        required: '必填。'
    },
    authRange_s: {
        ipv4: '起始地址只支持IPV4地址。'
    },
    authRange_e: {
        ipv4: '结束地址只支持IPV4地址。'
    },
    userKeyWord: {
        required: '请填写用户密钥口令。',
        maxlength: '您最多能够输入32个字符。'
    },
    certCommname: {
        maxlength: '您最多能够输入32个字符。'
    },
    mulIp: {
        required: '必填'
    },
    mulSrc: {
        required: '必填'
    },
	ha_ip: {
		required: '必填',
		ipv4: 'IPV4格式错误。'
	},
	ipaddress: {
		required: '请填写IP地址',
		ipv4: 'ip格式错误。'
	},
	macaddress: {
		required: '请填写MAC地址。'
	},
	addip: {
		required: '请填写IP地址',
		ipv4: 'ip格式错误。'
	},
	domainName: {
		required: '请填写域名。'
	},
	pop3dportReq: {
    	required: '请输入端口号。',
    	range: '目的端口1 - 65535。',   
    	digits: '请填写有效数字。',
    	remote: '任务号与端口号的和已存在，请重新添加。'
    },
    smtpdportReq: {
    	required: '请输入端口号。',
    	range: '目的端口1 - 65535。',   
    	digits: '请填写有效数字。',
    	remote: '任务号与端口号的和已存在，请重新添加。'
    },
    sendTaskPort: {
    	required: '请输入端口号。',
    	range: '端口范围1 - 65535。',
    	digits: '请填写有效数字。'
    },
    receiveTaskPort: {
    	required: '请输入端口号。',
    	range: '端口范围1 - 65535。',
    	digits: '请填写有效数字。'
    },
    pop3GeneralSport: {
    	required: '请输入端口号。',
    	range: '端口范围1 - 65535。',
    	digits: '请填写有效数字。'
    },
    smtpGeneralSport: {
    	required: '请输入端口号。',
    	range: '端口范围1 - 65535。',
    	digits: '请填写有效数字。'
    },
    fileSize: '范围在1-60之间。'
};

// special for lvs/schedule
for (var i = 1; i <= 16; i++) {
    var realAddrKey = "realAddr" + i;
    var realPortKey = "realPort" + i;
    if (i < 3) {
        validRules[realAddrKey] = {
            required: true,
            ipv4: true,
            realAddr:true
        };
        validRules[realPortKey] = {
            required: true,
            range: [1, 65535],
            digits: true,
            realPort: true
        }; 
    } else {
        validRules[realAddrKey] = {
            required: 'input[name="'+realPortKey+'"]:filled',
            ipv4: true,
            realAddr: true
        };
        validRules[realPortKey] = {
            required: 'input[name="'+realAddrKey+'"]:filled',
            range: [1, 65535],
            digits: true,
            realPort: true
        }; 
    }
    validMsg[realAddrKey] = {
        required: '请填写真实地址' + i + '.',
        ipv4: '真实地址' + i + '格式错误.'
    };
    validMsg[realPortKey] = {
        required: '请填写真实端口' + i + '.',
        range: '真实端口' + i + '的范围是1至65535。',
        digits: '请填写有效数字。'
    }; 
}

var groups = {
    fsLipLport: 'fslip fslportReq'
};

var errorPlacement = function (error, element) {
    if (element.attr('name') === "sendfilter") {
        error.insertAfter("label[for='sendfilter_black']");
    } else if (element.attr('name') === "recvfilter") {
        error.insertAfter("label[for='recvfilter_black']");
    } else if (element.attr('name') === "sqlCmdInfo[]") {
        error.insertAfter("input[name='sqlCmdInfo[]']:last");
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
