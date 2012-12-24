function search() {
    var paramsForm = $('#logSearchParamsForm');
    if (paramsForm.valid()) {
        var successCallback = function(result, textStatus) {
            $('#test').html(result.msg);
        }
        var dialog = ajaxSubmitForm(paramsForm, '结果', successCallback);
        dialog.close();
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
