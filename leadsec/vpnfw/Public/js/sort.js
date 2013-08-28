/**
 * Initial tablesorter.
 * @param tableDom. dom. ��Ҫ����ı���dom.
 * @param headers. Array. ָ������Ҫ������У���0��ͷ��eg: [0]:��һ�в�����
 * @param sortList. Array. ��ʼ���������eg: [[0,0]]���յ�һ�н������򡣵ڶ�ά
 *  ���ݵĵ�һ������Ϊ�кţ���0��ʼ�����ڶ�������ָ��������0Ϊ����1Ϊ����
 * @param forceList. Array. ǿ���������
 *  �˹��򲻻���Ϊ����ˢ�»����޸����������������ı䡣���巽���ɼ�sortList
 * @param typeList. Array. ��ָ���м����ض��������a[1] === {sorter: 'text'}
 *  �ڶ��а����ı���ʽ����.
 */
function sortTableInit(tableDom, headers, sortList, forceList, typeList) {
    var sortCol = {};
    for (var i in headers) {
        sortCol[headers[i]] = {sorter: false};
    }
    for (var i in typeList) {
        sortCol[i] = typeList[i];
    }
    tableDom.tablesorter({
        headers: sortCol,
        sortList: sortList?sortList:[[0,0]],
        sortMultiSortKey: 'ctrlKey',
        widgets: ['zebra'],
        sortInitialOrder : "asc",
        sortForce: forceList,
        showProcessing: true
    });
}

function generateNoCol(tableDom, pageDom) {
    var colNo = -1;
    tableDom.find('thead>tr').each(function() {
        if ($(this).find('th.NaturalNo').length === 1) {
            colNo = $(this).find('th').index($(this).find('th.NaturalNo'));
        }
    });
    if (colNo === -1) {
        return true;
    }
    var pageNo = parseInt(pageDom.find('ol.pagination>li.selected').text());
    var limit  = pageDom.find('select[name="rowsCount"]>option:selected').val();
    if (limit === 'all') {
        var startNo = 1;
    } else {
        var startNo = ((pageNo - 1) * limit) + 1;
    }
    tableDom.find('tbody>tr').each(function() {
        $(this).find('td:eq(' + colNo + ')').text(startNo++);
    });
}

function getLimitParams(pageDom) {
    pageDom = jQuery.getDefaultVal(pageDom, $('div.pager'));
    // get rows count, val: 10, 20, 50, 100, all
    if (pageDom === undefined) {
        var limit = $('#rowsCount option:selected').val();
        var pageNo   = $('ol.pagination>li.selected').attr('name');
        var dataCount = $('input[name="dataCount"]').val();
    } else {
        var limit     =
            pageDom.find('select[name="rowsCount"] option:selected').val();
        var pageNo    = pageDom.find('ol.pagination>li.selected').attr('name');
        var dataCount = pageDom.find('input[name="dataCount"]').val();
    }
    // check page number boundaries
    var bound =  Math.ceil(dataCount/limit);
    if (pageNo > bound && bound > 0) {
        pageNo = bound;
    }
    var limit  = limit === undefined ? 'all' : limit;
    if (limit === 'all') {
        var offset = 0;
    } else {
        var offset = (pageNo-1)*limit;
    }
    return {
        limit  : limit,
        offset : offset
    }
}

function getOrderParams(tableDom) {
    tableDom = jQuery.getDefaultVal(tableDom, $('table.tablesorter'));
    // get sort key and order
    var result = new Array();
    if (tableDom === undefined) {
       var ths = $('.tablesorter-headerRow>th');
    } else {
       var ths = tableDom.find('.tablesorter-headerRow>th');
    }
    var i = 0;
    ths.each(function() {
        var key       = $(this).attr('name');
        var className = $(this).attr('class');
        if (className.indexOf('SortUp') !== -1) {
            result[i++] = key + 'D';
        } else if (className.indexOf('SortDown') !== -1) {
            result[i++] = key + 'A';
        }
    });
    return result.join('|');
}

function getSqlParams(tableDom, pageDom, advSearchDom) {
     var result = {
        od : getOrderParams(tableDom),
        ld : getLimitParams(pageDom)
    };
    if (advSearchDom.data('advSearchData') !== undefined) {
        result['wd'] = advSearchDom.data('advSearchData');
    }
    return result;
}

function initTable(url, tableDom, pageDom, advSearchDom) {
    tableDom     = jQuery.getDefaultVal(tableDom, $('table.tablesorter'));
    pageDom      = jQuery.getDefaultVal(pageDom, $('div.pager'));
    advSearchDom = jQuery.getDefaultVal(advSearchDom, $('#advSearch'));
    var data = getSqlParams(tableDom, pageDom, advSearchDom);
    var params = {
        dataType: 'JSON',
        success : function(result, textStatus) {
            tableDom.children('tbody').html(result.msg.tableHtml);
            tableDom.trigger("update", [true]);
            generateNoCol(tableDom, pageDom);
            refreshLayout();
        }
    };
    loadEmbedPage(url, data, tableDom.children('tbody'), params);
}

function freshTableAndPagination(url, tableDom, pageDom, advSearchDom) {
	tableDom     = jQuery.getDefaultVal(tableDom, $('table.tablesorter'));
    pageDom      = jQuery.getDefaultVal(pageDom, $('div.pager'));
    advSearchDom = jQuery.getDefaultVal(advSearchDom, $('#advSearch'));
    if (tableDom.find('.checkAll').length > 0) {
    	tableDom.find('.batchCheck').removeAttr('checked');
    }
    var data = getSqlParams(tableDom, pageDom, advSearchDom);
    data['pageDom']   = "$('" + pageDom.selector + "')";
    data['tableDom']  = "$('" + tableDom.selector + "')";
    var ajaxParams = {
        dataType: 'JSON',
        success : function(result, textStatus) {
            tableDom.children('tbody').html(result.msg.tableHtml);
            tableDom.trigger("update", [true]);
            pageDom.html(result.msg.pagerHtml);
            generateNoCol(tableDom, pageDom);
            refreshLayout();
        }
    }
    var displayDom = $(pageDom.selector + ', ' + tableDom.selector + '>tbody');
    loadEmbedPage(url, data, displayDom, ajaxParams);
}
