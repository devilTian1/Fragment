function search() {
    var tableDom   = $('#logTable');
    var paramsForm = $('#logSearchParamsForm');
    if (paramsForm.valid()) {
        var successCallback = function(result, textStatus) {
            tableDom.children('tbody').html(result.msg);
            //tableDom.trigger("update", [true]);
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

function freshTableAndPage() {
    var url = 'Function/networkMangement/interface/physical.php';
    freshTable(url, $('#physicalTable'));
    freshPagination(url, $('.pager'));
}
