function freshTableAndPage() {
    var url = 'Function/resConf/addr/addrGroup.php';
    resortTable(url, $('#addrGroupTable'));
    freshPagination(url, $('.pager'));
}

function appendAddrGroupData() {
    var url  = 'Function/resConf/addr/addrGroup.php';
    var data = {
        freshAddrGroup: true
    };
    var params = {
        success : function(result, textStatus) {
            $('#addrGroupTable>tbody').html(result);
            $('#addrGroupTable').trigger("update", [true]);
        }
    };
    loadEmbedPage(url, data, $('#addrGroupTable>tbody'), params);
}
