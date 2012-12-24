function searchKeyData(tableId) {
    var keyWord  = $('#search').val().toLowerCase();
    var tableDom = $('#' + tableId);
    var trDoms   = tableDom.find('tbody>tr');
    
    trDoms.each(function() {
        $(this).show();
        var isShow = false;
        $(this).find('td[class!="no_search"]').each(function() {
            var unitContent = $(this).text().toLowerCase();
            if (unitContent.indexOf(keyWord) !== -1) {
                isShow = true;
                return;
            }
        });
        if (!isShow) {
            $(this).hide();
        }
    });
}
