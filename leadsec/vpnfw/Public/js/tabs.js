function showInnerText(id){
    $("span[id^='show_text']").addClass('hide');
    $("#show_text"+id).removeClass('hide');
}

function refreshTabs() {
    var li = $("#tab>.tabs>ul>li");
    var visited = 'visitedTab';
    li.addClass('linkTab').click(function() {
        var id = li.index($(this));
        $(this).addClass(visited);
        li.not($(this)).removeClass(visited);
        showInnerText(id);
    });
	$("#leftmenu").outerHeight($("#mainContent").outerHeight()+21);
}
