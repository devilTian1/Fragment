<?php
if(isset($_GET['act'])){
	$act=$_GET['act'];
	if($act=='hostname'){
		$hostname=$_GET['hostname'];//修改网闸名称
		$comstr="/usr/local/bin/hostname set hostname ".$hostname;
		@exec($comstr, $out,$status);
		if($status==0){
			echo "succeed";
		}else{
			echo "fail";
		}
	}
}

?>