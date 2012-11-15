function sortTable(tableDom, headers, sortList, forceList) {
    tableDom.tablesorter({
        headers: headers,
        sortList: sortList,
        sortMultiSortKey: 'ctrlKey',
        widgets: ['zebra']
        //sortForce: forceList
    });
}
