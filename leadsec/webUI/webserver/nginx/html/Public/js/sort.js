function sortTable(tableDom, headers, sortList, forceList) {
    tableDom.tablesorter({
        headers: headers,
        sortList: sortList,
        sortMultiSortKey: 'ctrlKey',
        widgets: ['zebra'],
        sortInitialOrder : "asc",
        sortForce: forceList
    });
}

function freshTable() {
    var rowsCount = $('#rowsCount').val();
    var pageNum   = $('.pagination>li.selected').text();
    $('.tablesorter-headerRow>th').each(function() {
        var className = $(this).attr('class');
        if (className.indexOf('SortUp') !== -1) {
            alert('DESC')
        } else if (className.indexOf('SortDown') !== -1) {
            alert('ASC');
        } else {
            //no need to sort
        }
    });
}
