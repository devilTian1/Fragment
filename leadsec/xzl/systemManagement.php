<?php
//系统配置文件
$lang_file="systemManagement.mo";
include("include/common.ini.php");
include("menu.php");
$type=isset($_GET['type'])?$_GET['type']:"";
$subtype=isset($_GET['subtype'])?$_GET['subtype']:"";

$tabmenu=returnSubmenu($menuArr,'systemManagement',$type,$subtype);
$picmenu=returnPicmenu($menuArr,'systemManagement',$type,$subtype);

if($subtype==""){
	$tplurl="systemManagement/".$type.".tpl";
}else{
	$tplurl="systemManagement/".$type."/".$subtype.".tpl";
}
if($type=="overview"){
	$tpl->assign("title", __R("this is the test key!"));
}elseif($type=="quick"){
	
}elseif($type=="conf"){//配置
	if($subtype=='argument'){//系统参数
		$tpl->assign("label_0", __R("安全隔离网闸名称"));
		$tpl->assign("explain_0", __R("1-20 个ASCII字符"));
		$tpl->assign("btn_0", __R("确定"));
	
		$db_sqlite=new db_sqlite();//读取数据显示
		$conn=$db_sqlite->connect_sqlite('configs.db');
		$sql="select * from hostname";
		$result=$db_sqlite->query_first($conn,$sql);
		$tpl->assign("hostname",$result["hostname"]);
		
	}
}elseif($type=="admin"){
	
}elseif($type=="maintain"){
}
//echo $picmenu;
$tpl->assign('mainmenu',"systemManagement");//主menu
$tpl->assign('typemenu',$type);//从menu
$tpl->assign('subtype',$subtype);//子menu
$tpl->assign('picmenu',$picmenu);//面包屑效果
$tpl->assign("tabmenu",$tabmenu);//tabmenu值
$tpl->display($tplurl);
?>
