function showInnerText(id){
    var showText = "i don`t know";
    switch(id){
        case 1:
           showText =  "headline2";
           break;
        case 2:
           showText =  "system setting!";
           break;
        case 3:
           showText =  "User Manage";
           break;          
        case 4:
           showText =  "Chanage Manage";
           break;   
        case 5:
           showText =  "Ad AND news!";
           break;                  
    }
    $("#show_text").html(showText);
}

function refreshTab() {
    $("#mainZone>.tabs>ul>li").addClass('linkTab').click(function() {
        $(this).toggleClass('visitedTab');
        $("#mainZone>.tabs>ul>li").not($(this)).removeClass('visitedTab');
        var id = $("#mainZone>.tabs>ul>li").index($(this)) + 1;
        showInnerText(id);
    });
}
