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
        var pageNum   = $('ol.pagination>li.selected').text();
        var dataCount = $('input[name="dataCount"]').val();
    } else {
        var rowsCount = pageDom.find('select[name="rowsCount"] option:selected').val();
        var pageNum   = pageDom.find('ol.pagination>li.selected').text();
        var dataCount = pageDom.find('input[name="dataCount"]').val();
    }
    var rowsCount = rowsCount === undefined ? 'all' : rowsCount;
    var pageCount = Math.ceil(Number(dataCount)/Number(rowsCount));
    return {
        pageNum:   pageNum,
        rowsCount: rowsCount,
        dataCount: dataCount,
        pageCount: pageCount
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
            (orderRules.rowsCount * (orderRules.pageNum-1))
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
    loadEmbedPage(url, data, tableDom.children('tbody'), params);
}

function freshPagination(funcUrl, displayDom) {
    var url  = 'Function/layout/showPagination.php';
    var data = getOrderRules();
    data['dataCountFunc'] = funcUrl;
    loadEmbedPage(url, data, displayDom);
}
