<?php
 require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
 $steptpl=$_POST['steptpl'];
 //url filter;
 if($steptpl=='url'){
 	
 	V::getInstance()->assign('name', "显示测试名字1");
 
 }elseif($steptpl=='mime'){
 	
 	V::getInstance()->assign('name', "显示测试名字2");
 
 }elseif($steptpl=='extend'){
 	
 	V::getInstance()->assign('name', "显示测试名字3");
 	
 }elseif($steptpl=='options'){
 	
 	V::getInstance()->assign('name', "显示测试名字4");
 }