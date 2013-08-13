function sortTableInit(tableDom, headers, sortList, forceList) {
    tableDom.tablesorter({
        headers: headers,
        sortList: sortList?sortList:[[0,0]],
        sortMultiSortKey: 'ctrlKey',
        widgets: ['zebra'],
        sortInitialOrder : "asc",
        sortForce: forceList,
        showProcessing: true
    });
}

function getOrderRules(pageDom) {
    // get rows count, val: 10, 20, 50, 100, all
    if (pageDom === undefined) {
        var rowsCount = $('#rowsCount option:selected').val();
        var pageNum   = $('ol.pagination>li.selected').attr('name');
        var dataCount = $('input[name="dataCount"]').val();
    } else {
        var rowsCount = pageDom.find('select[name="rowsCount"] option:selected').val();
        var pageNum = pageDom.find('ol.pagination>li.selected').attr('name');
        var dataCount = pageDom.find('input[name="dataCount"]').val();
    }
    if ($('#isInitSearch').val() === '1') {
        pageNum = 1;
    }
    // check page number boundaries
    var bound =  Math.ceil(dataCount/rowsCount);
    if (pageNum > bound && bound > 0) {
        pageNum = bound;
    }
    var rowsCount = rowsCount === undefined ? 'all' : rowsCount;
    return {
        pageNum:   pageNum,
        rowsCount: rowsCount,
        dataCount: dataCount
    }
}

function getSortThData(tableDom) {
    // get sort key and order
    var sortData  = new Array();
    var firstSortRowName = '';
    if (tableDom === undefined) {
       var ths = $('.tablesorter-headerRow>th');
    } else {
       var ths = tableDom.find('.tablesorter-headerRow>th');
    }
    ths.each(function(i) {
        var key       = $(this).attr('name');
        var className = $(this).attr('class');
        if (className.indexOf('SortUp') !== -1) {
            sortData[i] = new Array(key, 'DESC');
        } else if (className.indexOf('SortDown') !== -1) {
            sortData[i] = new Array(key, 'ASC');
        } else {
            // sort-false
        }
        if (className.indexOf('sorter-false') === -1) {
            firstSortRowName = firstSortRowName === '' ? key : firstSortRowName;
        } 
    });
    if (sortData.length === 0 && firstSortRowName !== '') {
        sortData[0] = new Array(firstSortRowName, 'ASC');
    }
    return sortData;
}

function getOrderStatement(tableDom, pageDom) {
    var result = '';
    var orderRules = getOrderRules(pageDom);
    var sortData   = getSortThData(tableDom);
    if (sortData.length > 0) {
        result += 'ORDER BY ';    
        for (var i in sortData) {
            result += sortData[i][0] + ' ' + sortData[i][1] + ', ';
        }
        result = result.slice(0, -2);
    }
    if (orderRules.rowsCount !== 'all') {
        result += ' LIMIT ' + orderRules.rowsCount + ' OFFSET ' +
            (orderRules.rowsCount * (orderRules.pageNum-1));
    }
    return result;
}

function freshTable(url, tableDom, orderStatement, pageDom) {
    if (!orderStatement) {
        var orderStatement = getOrderStatement(tableDom, pageDom);
    }
    var data = {
        orderStatement: orderStatement
    };
    var params = {
        success : function(result, textStatus) {
            tableDom.children('tbody').html(result);
            tableDom.trigger("update", [true]);
        }
    };
    loadEmbedPage(addQueryParams(url, tableDom.attr('id')), data,
        tableDom.children('tbody'), params);
}

function freshPagination(funcUrl, displayDom, tableDom) {
    if (displayDom === undefined) {
        displayDom = $('.pager');
    }
    var url  = 'index.php?R=layout/showPagination';
    var data = getOrderRules(displayDom);
    data['dataCountFunc'] = funcUrl;
    if (tableDom !== undefined) {
        data['tableDom'] = "$('" + tableDom.selector + "')";
    } else {
        tableDom = $('table.tablesorter');
    }
    data['pageDom'] = "$('" + displayDom.selector + "')";
    loadEmbedPage(addQueryParams(url, tableDom.attr('id')), data, displayDom);
}
