function NoControl() {
    if ($("input[name=No]").val() != '') {
        $('#advSearchTable input').not('[name=No]')
            .attr('disabled', 'disabled');
        $('#advSearchTable select').attr('disabled', 'disabled');
    } else {
        $('#advSearchTable input').not('[name=No]').removeAttr('disabled');
        $('#advSearchTable select').removeAttr('disabled');
    }
}

function initPagerCss(pageDom) {
    var liSelected = pageDom.find('ol.pagination>li.selected');
    var txt = liSelected.text();
    liSelected.removeClass('selected').removeClass('selected')
        .html('<a href="#page=' + txt + '">' + txt + '</a>');
    pageDom.find('ol.pagination>li:eq(2)').addClass('selected').html(1);

    pageDom.find('select[name="rowsCount"]>option:eq(0)')
        .attr('selected', 'selected');
}

function openAdvSearchDialog(dialogFunc, searchFunc, formId, searchId, tableDom, pageDom, dialogPosition) {
    var title     = '高级查询';
    var buttons   = {};
    buttons[getMessage('Search')] = function() {
        var formDom   = $('#' + formId);
        var searchDom = $('#' + searchId);
        addAdvSearchData(searchDom, formDom.serializeArray());
        initPagerCss(pageDom);
        freshTableAndPagination(searchFunc, tableDom, pageDom, searchDom);
        $(this).remove();
    };
    var width  = dialogPosition[0];
    var height = dialogPosition[1];
    var dialogParams = {
        width   : width,
        height  : height,
        buttons : buttons,
        position: jQuery.getDialogPosition(width, height)
    };
    showDialogByAjax(dialogFunc, {}, title, dialogParams);
}

function addAdvSearchData(dom, newObjArr) {
    var origVal = dom.data('advSearchData');
    if (origVal !== undefined && origVal.length > 0) {
        for (var i in newObjArr) {
            for (var j in origVal) {
                if (newObjArr[i].name === origVal[j].name) {
                    origVal[j].value = newObjArr[i].value;
                } else if (parseInt(j) === (origVal.length-1)) {
                    origVal[origVal.length] = newObjArr[i];
                    break;
                }
            }
        }
        dom.data('advSearchData', origVal);
    } else {
        dom.data('advSearchData', newObjArr);
    }
}

function removeAdvSearchData(selector) {
    selector = jQuery.getDefaultVal(selector, '#advSearch');
    $(selector).removeData('advSearchData');
}
