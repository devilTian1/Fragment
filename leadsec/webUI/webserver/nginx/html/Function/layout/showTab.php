<?php
    require_once('../common.php');

    // display tab content
    if ($_POST['action']) { 	
    	$action = $_POST['action'];    
    	if($action=='first')
    	{
    		$_SESSION['action'] = "back";     		  		
    		if($_SESSION['pos'] > (1-count($_SESSION['history'])))
    		{
    			$_SESSION['pos']=$_SESSION['pos']-1;     			    			
    		}    					
    	}
    	else if($action=='next')
    	{
    		$_SESSION['action'] = "next";    	
    		if($_SESSION['pos'] < 0)
    		{
    			$_SESSION['pos']=$_SESSION['pos']+1;    		
    		}       		 		
    	}
    	else if($action=='refresh')
    	{
    		$_SESSION['action'] = "refresh";    		
    		
    	}
    	$urlPath = $_SESSION['history'][count($_SESSION['history'])-1+$_SESSION['pos']];    	
    	$a_path = explode("/",$urlPath);       
        $path =array (
        	"1"=>$a_path[0], //一级菜单
        	"2"=>$a_path[1], //二级菜单
        );
        $a_name = explode(".",$a_path[2]);
        $tabName = $a_name[0]; //"mode"    
        list($tabinfo, $subMenu) =
            leftmenu::instance()->sort()->getSubMenu($path);  
        $tabs = $subMenu['children'];     
        for($i=0;$i<count($tabs);$i++)
        {
        	if($tabName==$tabs[$i][link])
        	{
        		$tabnum = $i;
        		break;
        	} 	
        }       
        if (count($tabs) === 0) {
            $tabs = array($subMenu);
            $tabinfo = $subMenu['title'];
        }        
        V::getInstance()->assign('tabs',    $tabs)
                        ->assign('tabinfo', $tabinfo)
                        ->assign('baseurl', join('/', $path))
                        ->assign('tabnum',$tabnum)
                        ->display('layout/tabs.tpl');
    } else if ($_POST['tabNum']) {
        $tabnum = $_POST['tabNum'];
        $path = $_POST['tabPath'];
        list($tabinfo, $subMenu) =
            leftmenu::instance()->sort()->getSubMenu($path);
        $tabs = $subMenu['children'];       
        if (count($tabs) === 0) {
            $tabs = array($subMenu);
            $tabinfo = $subMenu['title'];
        } 
        V::getInstance()->assign('tabs',    $tabs)
                        ->assign('tabinfo', $tabinfo)
                        ->assign('baseurl', join('/', $path))
                        ->assign('tabnum',$tabnum)
                        ->display('layout/tabs.tpl');
    } else {
        $path = $_POST['tabPath'];
        list($tabinfo, $subMenu) =
            leftmenu::instance()->sort()->getSubMenu($path);
        $tabs = $subMenu['children'];
        if (count($tabs) === 0) {
            $tabs = array($subMenu);
            $tabinfo = $subMenu['title'];
        }
        V::getInstance()->assign('tabs',    $tabs)
                        ->assign('tabinfo', $tabinfo)
                        ->assign('baseurl', join('/', $path))
                        ->display('layout/tabs.tpl');
    }
?>
