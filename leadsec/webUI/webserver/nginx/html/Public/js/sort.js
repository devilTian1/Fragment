function sortTableInit(tableDom, headers, sortList, forceList) {
    tableDom.tablesorter({
        headers: headers,
        sortList: sortList,
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
    var sortData  = {};
    $('.tablesorter-headerRow>th').each(function() {
        var key       = $(this).attr('name');
        var className = $(this).attr('class');
        if (className.indexOf('SortUp') !== -1) {
            sortData[key] = 'DESC';
        } else if (className.indexOf('SortDown') !== -1) {
            sortData[key] = 'ASC';
        } else {
            //no need to sort
        }
    });
    var pageCount = Math.ceil(Number(dataCount)/Number(rowsCount));
    return {
        pageNum:   pageNum,
        sortData:  sortData,
        rowsCount: rowsCount,
        dataCount: dataCount,
        pageCount: pageCount
    }
}

function resortTable(url, tableDom) {
    var orderRules = getOrderRules();
    var data = {
        pageNum:   orderRules.pageNum,
        sortData:  orderRules.sortData,
        rowsCount: orderRules.rowsCount
    };
    var params = {
        success : function(result, textStatus) {
            tableDom.children('tbody').html(result);
            tableDom.trigger("update", [true]);
        }
    };
    loadEmbedPage(url, data, tableDom.children('tbody'), params);
}


function freshPagination(displayDom) {
    var url  = 'Function/layout/showPagination.php';
    var data = getOrderRules();
    loadEmbedPage(url, data, displayDom);
}
