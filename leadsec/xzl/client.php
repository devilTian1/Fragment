<?php
$lang_file="messages.mo";
include("include/common.ini.php");
include("menu.php");
$type=isset($_GET['type'])?$_GET['type']:"";
$subtype=isset($_GET['subtype'])?$_GET['subtype']:"";
//echo $type;
//echo $subtype;
$tabmenu=returnSubmenu($menuArr,'client',$type,$subtype);
$picmenu=returnPicmenu($menuArr,'client',$type,$subtype);

if($subtype==""){
	$tplurl="client/".$type.".tpl";
}else{
	$tplurl="client/".$type."/".$subtype.".tpl";
}
if($type=="overview"){
	$tpl->assign("title", __R("this is the test key!"));
}elseif($type=="quick"){
}elseif($type=="conf"){
}elseif($type=="admin"){
}elseif($type=="maintain"){
}
//echo $picmenu;
$tpl->assign('mainmenu',"client");//主menu
$tpl->assign('typemenu',$type);//从menu
$tpl->assign('subtype',$subtype);//子menu
$tpl->assign('picmenu',$picmenu);//面包屑效果
$tpl->assign("tabmenu",$tabmenu);//tabmenu值
$tpl->display($tplurl);
?>