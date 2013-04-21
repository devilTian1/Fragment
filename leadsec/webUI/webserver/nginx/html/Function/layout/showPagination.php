<?php
    require_once('../common.php');

    // fresh data count of pagination
    if (!empty($_POST['dataCountFunc'])) {
        $func = $_POST['dataCountFunc'];
        $pos  = strpos($func, '?');
        if (false !== $pos) {
            $func = substr($func, 0, $pos);
        }
        require_once($_SERVER['DOCUMENT_ROOT'] . "/$func");
        $dataCount = getDataCount();
    } else {
        $dataCount = $_POST['dataCount'];
    }
    $rowsCount = $_POST['rowsCount'];
    if ($rowsCount === 'all') {
        $pageCount = 1;
    } else {
        $pageCount = ceil($dataCount/$rowsCount);
    }
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
        ->assign('tableDom', stripslashes($_POST['tableDom']))
        ->assign('pageDom', stripslashes($_POST['pageDom']))
	    ->fetch('layout/pagination.tpl');
?>
