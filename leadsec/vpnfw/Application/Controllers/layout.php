<?php
    class LayoutController extends commonController {
        
        private $level;

        public function showTab() {
            $model = $this->getModel('layout');
            $view  = $this->getView('layout');
            $model->getSpecTab();
            $view->showTab();
        }

        public function showMainContent() {
            $model = $this->getModel('layout');
            $view  = $this->getView('layout');
            $model->getInitPageData();
            $view->showMainContain();
        }
        
        public function showPagination(){
        	 if (!empty($_POST['dataCountFunc'])) {
		    	$func = $_POST['dataCountFunc'];
		        $pos  = strpos($func, '?');
		        if (false !== $pos) {
		            $func   = substr($func, 0, $pos);
		        }
		        /*require_once($_SERVER['DOCUMENT_ROOT'] . "/$func");
		        $dataCount = getDataCount();*/
		    } else {
		        $dataCount = $_POST['dataCount'];
		    }
		    $dataCount = $_POST['dataCount'];
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
		   	    $initData['dataCount']=$dataCount;
		        $initData['pageCount']=$pageCount;
		        $initData['clickedPageNo']=$clickedPageNo;
		        $initData['prev']=$prev;
		        $initData['next']=$next;
		        
		    //display pagination
		    echo V::getInstance()->assign('initData', $initData)
		        ->assign('rowsCount', $rowsCount)
			    ->assign('func', $_POST['dataCountFunc'])
		        ->assign('tableDom', stripslashes($_POST['tableDom']))
		        ->assign('pageDom', stripslashes($_POST['pageDom']))
			    ->fetch('layout/pagination.tpl');
		    }
    }
?>
