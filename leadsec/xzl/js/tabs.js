function refreshTab() {
    $("#mainZone>.tabs>ul>li").addClass('linkTab').click(function() {
        $(this).toggleClass('visitedTab');
        $("#mainZone>.tabs>ul>li").not($(this)).removeClass('visitedTab');
		var title=$(this).attr("title");
		var titlearr=title.split('__'),
			groupName=titlearr[0],
			liTitle=titlearr[1],
			toHref=titlearr[2];
		showPageByAjax(groupName,liTitle,toHref);
    });
}
