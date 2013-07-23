/**
 * @file
 * This javascript provide common functions to all pages
 */

/**
 * Standard JQuery UI Factory
 */
function StandardUiFactory() {
    /**
     * Create a dialog object
     * @param title. String. dialog title
     * @return a extended dialog object
     */
    function createDialog(title) {
        var dialog  = $('<div title="' + title  + '" class="StandardDialog"></div>');
        var buttons = {};
        $(dialog).dialog({
            autoOpen  : false,
            buttons   : buttons,
            modal     : true,
            width     : 450,
            height    : 500,
            bgiframe  : true,
            resizable : false,
            draggable : false,
            position : ['center', 'center'],
            close: function(event, ui) {
                $(this).dialog('destroy');
                $(this).remove();
            }
        });
        
        /**
         * Set the content into the dialog
         * @param contentE1. DOM. element of the content to be set.
         */
        dialog.setContent = function(contentE1) {
            dialog.html(contentE1);
        }

        /**
         * Display the dialog
         */
        dialog.open = function() {
            $(this).dialog('open');
        }

        /**
         * destroy the dialog
         */
        dialog.close = function() {
            $(this).dialog('destroy');
        }

        /**
         * Set extra or override options of the dialog
         * @param options. Anassociated array of options
         */
        dialog.setOptions = function(options) {
            $(this).dialog(options);
        }
        return dialog;
    }
    StandardUiFactory.createDialog = createDialog;
}



/**
 * Load a dynamic page and return in callback
 * The page is invoked with AJAX via GET method.
 * @param url String
 *  The URL of the dynamic page. eg, /Function/sys/admin/cert.php
 * @param data Object
 *  GET data. eg, key1=value1&key2=value2
 *  You may pass either string or object. Objects will be serialized by jQuery.
 * @param params
 *  Extra parameters to pass to $.ajax, eg, success/error callbacks.
 */
function loadAjax(url, data, params) {
    // default params
    var ajaxParams = {
        url   : url,
        type  : "GET",
        data  : data,
        error : function(XMLHttpRequest, textStatus, errorThrown) {
            if (!checkTimeOut(XMLHttpRequest.responseText)) {
                return false;
            }
            showAjaxErrorDialog(XMLHttpRequest, textStatus, errorThrown);
        }
    };
    // merge with user specified parameters, then send it
    for (var i in params) {
        ajaxParams[i] = params[i];
    }
    var s = ajaxParams.success;
    ajaxParams.success = function(result) {
        if (!checkTimeOut(result)) {
            return false;
        } 
        if (status != undefined && Number(status) != 0) {
            showErrorDialog(result.msg);
            return;
        }
        s(result);
    }
    $.ajax(ajaxParams);
}

function showAjaxErrorDialog(XMLHttpRequest, textStatus, errorThrown) {
    var dialog = loadingScreen(getMessage('error'));
    var resTxt = XMLHttpRequest.responseText == '' ? getMessage('None') :
        XMLHttpRequest.responseText;
    result = getMessage('ERROR') + ': [' + getMessage('request error') +
        ']. ' + getMessage('Respone text') + ': [' + resTxt + '], ' +
        getMessage('error msg') + ':[' + textStatus + ']';
    dialog.setContent($('<p>' + result + '</p>'));
}

function showErrorDialog(msg) {
    var dialog = loadingScreen(getMessage('错误'));
    dialog.setContent(msg);
    var buttons = {};
    buttons[getMessage('关闭')] = function() {
        dialog.close();
    };
    dialog.setOptions({
        buttons : buttons
    });
    return dialog;
}

/**
 * Show a spinning icon, indicate the user to wait and prevent the user to
 * click anything.
 * @param title
 *  the title is at the top of dialog.
 * @return dialog. dom
 */
function loadingScreen(title) {
    var loadHtml = '<label>' + getMessage("loading") + '... ...' + '</label>';
    var dialog = StandardUiFactory.createDialog(title);
    dialog.setContent(loadHtml);
    dialog.setOptions({
        width : 250,
        height: 200
    });
    dialog.open();
    return dialog;
}

/**
 * Embed loading html dom
 * @param elementDom
 *  embed loading html in this param
 */
function loadingHtmlText(elementDom) {
    var loadHtml = '<label>' + getMessage("loading") + '... ...' + '</label>';
    elementDom.html(loadHtml);
}

function checkTimeOut(result) {
    if (result === 'timeOut') {
        var dialog = StandardUiFactory.createDialog('超时退出');
        var buttons = {};
        buttons['确定'] = function() {
            location.href = "index.php";
        };
        var dialogParams = {
            buttons : buttons,
            width   : 250,
            height  : 170
        };
        dialog.setOptions(dialogParams);
        dialog.setContent('<p>请您重新登录。</p>');
        dialog.open();
        return false;
    }
    return true;
}

/**
 * Load a dynamic page, put it inside an existing page.
 * The page is invoked with AJAX method.
 * @param url
 *  The URL of the dynamic page. eg, /Function/layout/showTab.php
 * @param data
 *  GET data
 *  You may pass either string or object. Objects will be serialized by jQuery.
 * @param displayDom
 *  The DOM of a div. This function will insert the dynamic page content into
 *  the DIV. If there is error, this function will insert error message into
 *  Div
 * @param params
 *  Extra parameters to pass top $.ajax, eg, success/error callbacks.
 */
function loadEmbedPage(url, data, displayDom, params) {
    loadingHtmlText(displayDom);
    var embedPageParams = {
        type    : 'POST',
        success : function(result, textStatus) {
            if (result.status) {
                displayDom.html(result.msg);
            } else {
                displayDom.html(result);
            }
            refreshLayout();
        }
    };
    for (var i in params) {
        embedPageParams[i] = params[i];
    }
    loadAjax(url, data, embedPageParams);
}

/**
 * Show a dialog and load the context by AJAX.
 * @param url
 *  The URL of the page to load
 * @param data
 *  The key-value pairs passed to url via GET
 * @param title
 *  The string displayed on the title of the dialog
 * @param dialogParams
 *  The params of the dialog, optional.
 * @param ajaxParams
 *  Extra parameters to pass to $.ajax, optional. eg, success/error callbacks.
 * @param successCallback
 *   The function to be invoked when the AJAX successes.
 *   If not set, the dialog will show the AJAX return content.
 * @param errorCallback
 *  The function to be invoked when the AJAX fails.
 *  If not set, the dialog will show the error message.
 * @return dialog. dom
 */
function showDialogByAjax(url, data, title, dialogParams, ajaxParams,
    successCallback, errorCallback) {
    
    var dialog = loadingScreen(title);
    if (!successCallback) {
        successCallback = function(result, textStatus) {
            dialog.setContent(result.msg);
            dialog.setOptions(dialogParams)
        }
    }
    if (!errorCallback) {
        errorCallback = function(XMLHttpRequest, textStatus, errorThrown) {
            if (!checkTimeOut(XMLHttpRequest.responseText)) {
                return false;
            }
            showAjaxErrorDialog(XMLHttpRequest, textStatus, errorThrown);
        }
    }
    var params = {
        type     : 'POST',
        dataType : 'json',
        success  : successCallback,
        error    : errorCallback
    };
    
    for (var i in ajaxParams) {
        params[i] = ajaxParams[i];
    }

    loadAjax(url, data, params);
    return dialog;
}

function freshPrePage(url, tableDom,name){
    var data = {
    		selectList: true
    };
	var params = {
			dataType : 'json',
	        success : function(result, textStatus) {
	            var sl = result.msg;
	            
	        	var opstr = "<option id=\""+tableDom.attr('id')+"-0\" class=\"select "+tableDom.attr('id')+" option\" value=\"\">无</option>";

	            for(var i in sl)
	            {
	            	var a = parseInt(i)+1;
	            	if(sl[i] == name){
	            		opstr = opstr + "<option id=\""+tableDom.attr('id')+"-"+a+"\" class=\"select "+tableDom.attr('id')+" option\" value=\""+sl[i]+"\" selected>"+sl[i]+"</option>";
	            	}else{
	            		opstr = opstr + "<option id=\""+tableDom.attr('id')+"-"+a+"\" class=\"select "+tableDom.attr('id')+" option\" value=\""+sl[i]+"\">"+sl[i]+"</option>";
	            	}	            	
	            }
	            
	            tableDom.html(opstr);
	        }
	    };
	    loadEmbedPage(url, data, tableDom, params);   
}

function ajaxSubmitForm(formEle, title, successCallback, errorCallback,
    afterSuccessCallback) {
    var dialog = loadingScreen(title);
    dialog.dialog('moveToTop');
    var buttons = {};
    
    dialog.setOptions({
        width : 250,
        height: 170,
        buttons: buttons
    });
 
    if (!successCallback) {
        successCallback = function(result, textStatus) {
	        var content = result.msg;
	        if ($.isArray(content)) {
	            content = content.join('<br/>');	
	        }
            dialog.setContent($('<p>' + content + '</p>'));
            if (afterSuccessCallback != undefined &&
                typeof(afterSuccessCallback) == 'function') {
                afterSuccessCallback(result, textStatus);
            }
        }
    }
    var s = successCallback;
    successCallback = function(result) {
        if (!checkTimeOut(result)) {
            return false;
        }
        buttons[getMessage('Ok')] = function() {
            dialog.close();
        }
        dialog.setOptions({
            buttons: buttons
        });
        s(result);
    }
    if (!errorCallback) {
        errorCallback = function(XMLHttpRequest, textStatus, errorThrown) {
            if (!checkTimeOut(XMLHttpRequest.responseText)) {
                return false;
            }
            var resTxt = XMLHttpRequest.responseText == '' ?
                getMessage('None') : XMLHttpRequest.responseText;
            result = getMessage('ERROR') + ': [' + getMessage('request error') +
                ']. ' + getMessage('Respone text') + ': [' + resTxt + '], ' +
                getMessage('error msg') + ':[' + textStatus + ']';
            dialog.setContent($('<p>' + result + '</p>'));
        }
    }
    var options = {
        forceSync: true,
        dataType : 'json',
        success  : successCallback,
        error    : errorCallback
    };
    formEle.ajaxSubmit(options);
    return dialog;
}

function showTabByAjax(path) {
    var url  = 'index.php?R=layout/showTab';
    loadEmbedPage(url, path, $("#tab"));
}

function showPageByAjax(tpl) {
    var url = 'index.php?R=layout/showContent'
    var data = {
        tpl : tpl
    };
    loadEmbedPage(url, data, $("#mainContent"));
}

function showStepPageByAjax(url) {
	var data = {func : url};
	loadEmbedPage('Function/view.php', data, $("#stepDivContent"));
}

function refreshLayout() {
    var contentH  = $("#mainContent").outerHeight();
    var leftmenuH = $("#leftmenu").outerHeight();
    contentH > leftmenuH ? $("#leftmenu").outerHeight(contentH+21) : 
        $("#mainContent").outerHeight(leftmenuH-21);
    setTimeout(function(){$("#mainContent").getNiceScroll().resize();},500);
    refreshTabs();
}

function tipAutoHide(info, time){
    var tip = '';
	switch(info){
		case 1:
			tip = "服务器繁忙，请稍后再试。";
	    	break;
		case 2:
			tip = "设置成功！";
    		break;
		case 3:
			tip = "数据拉取失败";
		    break;
		case 4:
			tip = "正在加载中，请稍后...";
	    	break;
        case 5:
            tip = "数据正在处理，请稍后";
            break;
        default:
            tip = '请稍候';
	}
	if (!time) {
        time=2;
    }
	time = 1000*time;
	ZENG.msgbox.show(tip, info, time);
    // overlay
    var overlayDom = $("<div class='ui-widget-overlay'></div>");
    overlayDom.height($('body').height());
    overlayDom.width('100%');
    $("body").append(overlayDom);
    
    // hide overlay
    setTimeout(function() {
        overlayDom.hide();
    }, time);
}

function getCookie(str) {
    if (document.cookie.length > 0) {
        var start = document.cookie.indexOf(str + '=');
        if (start != -1) {
            start += str.length + 1;
            end = document.cookie.indexOf(';', start);
            if (end == -1) {
                end = document.cookie.length;
            }
            return unescape(document.cookie.substring(start, end));
        }
        
    }
}

if(!String.prototype.trim){
	var TRIM_REG = /(^\s*)|(\s*$)/g;
	String.prototype.trim = function(){
		return this.replace(TRIM_REG,'');
	}
}
/*
 * Extend jQuery element set to support new function.
 *
 * Show/Hide options in select element. For IE6
 */
jQuery.extend({
    getDialogPosition : function(dialogWidth,dialogHeight) {
    	var width  = $(window).innerWidth();
        var height = $(window).innerHeight();
        var left   = (width - dialogWidth)/2;
        var top    = (height - dialogHeight)/2;
     	return [left, top];
    }
});
jQuery.fn.extend({
    hideOption : function(findParams) {
        var findDom = $(this).find(findParams);
        $(this).data('hideOpts', findDom);
        findDom.remove();
    },
    showOption : function() {
        if ($(this).data('hideOpts') !== undefined) {
            $(this).data('hideOpts').appendTo($(this));
        }
    }
});
StandardUiFactory();
