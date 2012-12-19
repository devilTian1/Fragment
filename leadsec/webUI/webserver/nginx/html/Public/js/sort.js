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

function getOrderRules() {
    // get rows count, val: 10, 20, 50, 100, all
    var rowsCount = $('#rowsCount option:selected').val();
    // get page num
    var pageNum   = $('ol.pagination>li.selected').text();
    // get sort key and order
    var dataCount = $('#dataCount').val();
    var sortData  = new Array();
    var firstSortRowName = '';
    $('.tablesorter-headerRow>th').each(function() {
        var key       = $(this).attr('name');
        var className = $(this).attr('class');
        if (className.indexOf('SortUp') !== -1) {
            sortData[key] = 'DESC';
        } else if (className.indexOf('SortDown') !== -1) {
            sortData[key] = 'ASC';
        } else {
            // sort-false
        }
        if (className.indexOf('sorter-false') === -1) {
            firstSortRowName = firstSortRowName === '' ? key : firstSortRowName;
        } 
    });
    if (sortData.length === 0 && firstSortRowName !== '') {
        sortData[firstSortRowName] = 'ASC';
    }
    var pageCount = Math.ceil(Number(dataCount)/Number(rowsCount));
    return {
        pageNum:   pageNum,
        sortData:  sortData,
        rowsCount: rowsCount,
        dataCount: dataCount,
        pageCount: pageCount
    }
}

function getOrderStatement() {
    var result = '';
    var orderRules = getOrderRules();
    if (orderRules.sortData.length > 0) {
        result += 'ORDER BY ';    
        for (var i in orderRules.sortData) {
            result += i + ' ' + orderRules.sortData[i] + ', ';
        }
        result = result.slice(0, -2);
    }
    if (orderRules.rowsCount !== 'all') {
        result += ' LIMIT ' + orderRules.rowsCount + ' OFFSET ' +
            (orderRules.rowsCount * (orderRules.pageNum-1))
    }
    return result;
}

function freshTable(url, tableDom, orderStatement) {
    if (!orderStatement) {
        var orderStatement = getOrderStatement();
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
