function getQueryCols(tableId) {
    var tableDom = $('#' + tableId);
    var colNames = $('#colNames').val();
    var cols     = '';
    if (colNames === '') {
        tableDom.find('thead>tr>th[name]').each(function() {
            cols += $(this).attr('name') + ',';
        });
        cols = cols.substr(0, cols.length-1);
    } else {
        cols = colNames;
    }
    return cols;
}

function addQueryParams(url, tableId) {
    if ($('#search').val() !== '请输入关键字') {
        var cols = getQueryCols(tableId);
        if (url.indexOf('?') !== -1) {
            url += '&';
        } else {
            url += '?';
        }
        url += 'cols=' + cols + '&keyword=' + $('#search').val();
    }
    return encodeURI(url);
}

function setInitSearch(isFirst) {
    if (isFirst) {
        $('#isInitSearch').val(1);
    } else {
        $('#isInitSearch').val(0);
    }
}

function blurFunc(str) {
    if( $('#search').val().trim() === '') {
        $('#search').val(str);
    }
}

function focusFunc(str) {
    if( $('#search').val().trim() === str) {
        $('#search').val('');
    }
}
