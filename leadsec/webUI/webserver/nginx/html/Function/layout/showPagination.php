<?php
    require_once('../common.php');

    // fresh data count of pagination
    if (!empty($_POST['dataCountFunc'])) {
        require_once($_SERVER['DOCUMENT_ROOT'] . "/{$_POST['dataCountFunc']}");
        $dataCount = getDataCount();
    } else {
        $dataCount = $_POST['dataCount'];
    }
    $rowsCount = $_POST['rowsCount'];
    $pageCount = $_POST['pageCount'];
    $clickedPageNo = $_POST['pageNum'];
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
	->assign('func', $_POST['dataCountFunc'])
	->fetch('layout/pagination.tpl');
?>
