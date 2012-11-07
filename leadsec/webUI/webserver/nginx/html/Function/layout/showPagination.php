<?php
    require_once('../common.php');

    $dataCount = $_POST['dataCount'];
    $rowsCount = $_POST['rowsCount'];
    $pageCount = $_POST['pageCount'];
    $clickedPageNo = $_POST['clickedPageNo'];
    if ($clickedPageNo === 1) {
	$prev = 1;
    } else {
	$prev = $clickedPageNo-1;
    }
    if ($clickedPageNo === $pageCount) {
	$next = $pageCount;
    } else {
	$next = $clickedPageNo+1;
    }
    // display pagination
    echo V::getInstance()->assign('dataCount', $dataCount)
            ->assign('rowsCount', $rowsCount)
            ->assign('pageCount', $pageCount)
            ->assign('clickedPageNo', $clickedPageNo)
	    ->assign('prev', $prev)
	    ->assign('next',$next)
	    ->fetch('layout/pagination.tpl');
?>
