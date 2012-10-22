function showInnerText(id){
    $("span[id^='show_text']").addClass('hide');
    $("#show_text"+id).removeClass('hide');
}

function refreshTab() {
    var li = $("#mainZone>.tabs>ul>li");
    li.addClass('linkTab').click(function() {
        var id = li.index($(this));
        $(this).toggleClass('visitedTab');
        li.not($(this)).removeClass('visitedTab');
        showInnerText(id);
    });
}
