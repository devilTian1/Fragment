function freshTableAndPage() {
    var url = 'Function/appS/ids/testResult.php';
    freshTable(url, $('#testResultTable'));
    freshPagination(url, $('.pager'));
}

function cleanLog() {
    var afterSuccessCallback = function(result, textStatus) {
        freshTable('Function/appS/ids/testResult.php',
            $('#testResultTable'), "LIMIT 10 OFFSET 0");
    }
    ajaxSubmitForm($('#cleanLogForm'), getMessage('Result'), undefined,
        undefined, afterSuccessCallback);
}

