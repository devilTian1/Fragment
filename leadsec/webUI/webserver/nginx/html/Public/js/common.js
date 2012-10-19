function showPageByAjax(page) {
    $("#mainZone").html("loading... ...").load("test.php", {
        page : page}, function() {
        var contentH  = $("#mainZone>.mainContent").outerHeight();
        var leftmenuH = $("#leftmenu").outerHeight();
        contentH > leftmenuH ? $("#leftmenu").outerHeight(contentH) : 
            $("#mainZone>.mainContent").outerHeight(leftmenuH);
        refreshTab();
        $("#clientTcp").tablesorter();
    });
}
