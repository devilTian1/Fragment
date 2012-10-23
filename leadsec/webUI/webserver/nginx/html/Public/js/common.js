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

function loadEmbedPage(url, data, displayDom, params) {
    var loadHtml = getMessage("loading") + '... ...';
    displayDom.html(loadHtml);
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
    refreshTab();
}
