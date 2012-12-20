function search() {
    if ($('#logSearchParamsForm').valid()) {

    }
}

function showAdvSearchDiv() {
    $('#advSearchDiv').slideDown('slow', function() {
        $("#searchBtn").insertAfter('#userTrace');
    });
}

function hideAdvSearchDiv() {
    $('#advSearchDiv').slideUp('slow');
    $("#searchBtn").insertAfter('#endTime_log');
}

