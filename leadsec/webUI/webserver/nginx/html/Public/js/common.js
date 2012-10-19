function showPageByAjax(path) {
    var url = 'Function';
    for (k in path) {
        url += '/' + path[k];
    }
    url += '.php';

    $("#mainZone").html("loading... ...").load(url, {
        path : path}, function() {
        var contentH  = $("#mainZone>.mainContent").outerHeight();
        var leftmenuH = $("#leftmenu").outerHeight();
        contentH > leftmenuH ? $("#leftmenu").outerHeight(contentH) : 
            $("#mainZone>.mainContent").outerHeight(leftmenuH);
        refreshTab();
        $("#clientTcp").tablesorter();
    });
}
