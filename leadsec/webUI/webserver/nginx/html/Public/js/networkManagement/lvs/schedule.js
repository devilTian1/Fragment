function freshTableAndPage() {
    var url = 'Function/networkManagement/lvs/schedule.php';
    freshTable(url, $('#scheduleTable'));
    freshPagination(url, $('.pager'));
}
