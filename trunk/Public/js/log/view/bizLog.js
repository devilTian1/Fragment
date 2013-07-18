function search() {
    var tableDom   = $('#logTable');
    var paramsForm = $('#logSearchParamsForm');
    if (paramsForm.valid()) {
        var afterSuccessCallback = function(result, textStatus) {
            tableDom.children('tbody').html(result.html);
            tableDom.trigger("update");
            var sorting = [[0,1]];
            tableDom.trigger("sorton", [sorting]);
            freshLogPage(result.count, 'search');
        }
        ajaxSubmitForm(paramsForm, '结果', undefined, undefined,
            afterSuccessCallback);
    }
}

function cleanLog() {
    var afterSuccessCallback = function(result, textStatus) {
        freshLogTable('Function/log/view/bizLog.php', $('#logTable'),
            'ORDER BY time DESC LIMIT 10 OFFSET 0');
    }
    ajaxSubmitForm($('#cleanLogForm'), getMessage('Result'), undefined,
        undefined, afterSuccessCallback);
}

function showAdvSearchDiv() {
    $('#advSearchDiv').slideDown('slow', function() {
        $("#searchBtn").insertAfter('#userTrace');
    });
}

function hideAdvSearchDiv() {
    $('#advSearchDiv').slideUp('slow');
    $("#searchBtn").insertAfter('#endTime_log');
}

function freshLogPage(count, type) {
    var data       = {};
    var url        = 'Function/log/view/showPagination.php';
    var funcUrl    = 'Function/log/view/bizLog.php';
    var displayDom = $('.pager');
    if (type === 'search') {
        data['dataCount'] = count
        data['pageCount'] = Math.ceil(count/10);
        data['pageNum']   = 1;
        data['rowsCount'] = 10;
        data['pageDom']   = "$('" + displayDom.selector + "')";
    } else { // freshPage
        data = getOrderRules(displayDom);
        data['dataCount'] = count;
    } 
    data['dataCountFunc'] = funcUrl;
    loadEmbedPage(url, data, displayDom);
}

function freshLogTable(url, tableDom, orderStatement) {
    if (!orderStatement) {
        var orderStatement = getOrderStatement(tableDom, $('.pager'));
    }
    var data = {
        orderStatement: orderStatement
    };
    var params = {
        dataType: 'json',
        success : function(result, textStatus) {
            tableDom.children('tbody').html(result.html);
            tableDom.trigger("update", [true]);
            freshLogPage(result.count, 'freshTable');
        }
    };
    url += '?' + $('#logSearchParamsForm').serialize();
    loadEmbedPage(url, data, tableDom.children('tbody'), params);
}

function freshTableAndPage() {
    var url = 'Function/log/view/bizLog.php';
    freshLogTable(url, $('#logTable'));
}
