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
            autoOpen : false,
            buttons  : buttons,
            modal    : true,
            width    : 450,
            height   : 500,
            position : "center middle"
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
            $(this).dialog('close');
            $(this).dialog('destroy');
            $(this).remove();
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
            //#TODO
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

function getMessage(str) {
    return str;
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
        dialog.setContent('<p>请您重新登录.</p>');
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
            dialog.setContent(result);
            dialog.setOptions(dialogParams)
        }
    }
    if (!errorCallback) {
        errorCallback = function(XMLHttpRequest, textStatus, errorThrown) {
            result = 'ERROR: AJAX error. Respone text: ' +
                XMLHttpRequest.responseText + ', status:' + textStatus +
                ', errorThrown:' + errorThrown;
            dialog.setContent($('<p>' + result + '</p>'));
        }
    }
    var params = {
        type    : 'POST',
        success : successCallback,
        error   : errorCallback
    };
    
    for (var i in ajaxParams) {
        params[i] = ajaxParams[i];
    }

    loadAjax(url, data, params);
    return dialog;
}

function ajaxSubmitForm(formEle, title, successCallback, errorCallback) {
    var dialog = loadingScreen(title);
    dialog.setOptions({
        width : 200,
        height: 100
    });
 
    if (!successCallback) {
        successCallback = function(result, textStatus) {
            if (!checkTimeOut(result)) {
                return false;
            } 
            dialog.setContent($('<p>' + result + '</p>'));
        }
    }
    var s = successCallback;
    successCallback = function(result) {
        if (!checkTimeOut(result)) {
            return false;
        } 
        s(result);
    }
    if (!errorCallback) {
        errorCallback = function(XMLHttpRequest, textStatus, errorThrown) {
            result = 'ERROR: AJAX error. Respone text: ' +
                XMLHttpRequest.responseText + ', status:' + textStatus +
                ', errorThrown:' + errorThrown;
            dialog.setContent($('<p>' + result + '</p>'));
        }
    }
    formEle.ajaxSubmit({
        success  : successCallback,
        error    : errorCallback
    });
}

function showTabByAjax(path) {
    var url  = 'Function/layout/showTab.php';
    var data = {tabPath : path};
    loadEmbedPage(url, data, $("#tab"));
}

function showPageByAjax(url) {
    var data = {func : url};
    loadEmbedPage('Function/view.php', data, $("#mainContent"));
}

function refreshLayout() {
    var contentH  = $("#mainContent").outerHeight();
    var leftmenuH = $("#leftmenu").outerHeight();
    contentH > leftmenuH ? $("#leftmenu").outerHeight(contentH) : 
        $("#mainContent").outerHeight(leftmenuH);
    refreshTabs();
}

function toggleDom(dom) {
    $("div[name='toggleDiv']").addClass('hide');
    dom.removeClass('hide');
}

function tipAutoHide(i,info,time){
	if(!info) tip='';
	switch(i){
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
	}
	tip=info;
	if(!time) time=2;
	time=1000*time;
	ZENG.msgbox.show(tip, i, time);
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
StandardUiFactory();
