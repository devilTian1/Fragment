function showTabByAjax(path) {
    var url = 'Function/view.php';
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

function showPageByAjax(baseUrl, page) {
    var url = 'Function/' + baseUrl + '/' + page + '.php';

    $(".mainContent").html("loading... ...").load(url, {
        data : ''}, function() {
        var contentH  = $("#mainZone>.mainContent").outerHeight();
        var leftmenuH = $("#leftmenu").outerHeight();
        contentH > leftmenuH ? $("#leftmenu").outerHeight(contentH) : 
            $("#mainZone>.mainContent").outerHeight(leftmenuH);
        refreshTab();
        $("#clientTcp").tablesorter();
    });
}
