<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');
    require(WEB_PATH . '/Conf/leftmenu.php');
    //get one arr
    function getArrFromID($ID){
    	global $leftmenuArr;
    	$returnArr=array();
    	$returnArr['title']=$leftmenuArr[$ID]['name'];
    	$returnArr['id']=$ID;
    	$returnArr['img']=$ID;
    	$returnArr['smenu']=$leftmenuArr[$ID]['link'];
    	
    	$pid=$leftmenuArr[$ID]['pid'];
    	$parr=$leftmenuArr[$pid];
    	if($parr['pid']!==0){
    		return 0;
    	}else {
    		$returnArr['pmenu']=$parr['link'];
    		//$returnArr['url']=$parr['link']."/".$leftmenuArr[$ID]['link']."/".$leftmenuArr[$ID]['link'].".php";
    	}
    	return $returnArr;
    }
    //get all arr from link
	function getAllArrFromID($arr){
		$returnArr=array();
		if($arr[0]=="") return $returnArr;
		foreach ($arr as $val){
			$temp=getArrFromID($val);
			if($temp!=0){
				$returnArr[]=$temp;
			}
		}
		return $returnArr;
	}
	/*************************************************/
	function getSubArr($pid){
		$returnArr=array();
		global $leftmenuArr;
		foreach ($leftmenuArr as $key=>$val){
			if($val["pid"]===$pid){
				$returnArr[$key]=$val;
			}
		}
		return $returnArr;
	}
	function getAllArr(){
		$returnArr=array();
		global $leftmenuArr;
		$topArr=getSubArr(0);
		$topnum=0;
		foreach ($topArr as $topkey=>$topval){
			$returnArr[$topnum]['toptitle']=$topval['name'];
			$subArr=getSubArr($topkey);
			$subnum=0;
			$toplink=$topval['link'];
			foreach ($subArr as $subkey=>$subval){
				if (getLicense($subval['link'])) {
					$returnArr[$topnum]['subarr'][$subnum]['subtitle']=$subval['name'];
					$returnArr[$topnum]['subarr'][$subnum]['id']=$subkey;
					$returnArr[$topnum]['subarr'][$subnum]['img']=$subkey;
					$returnArr[$topnum]['subarr'][$subnum]['pmenu']=$toplink;
					$returnArr[$topnum]['subarr'][$subnum]['smenu']=$subval['link'];
					$subnum+=1;
				} else {
					continue;
				}
			}
			$topnum+=1;
		}
		
		return $returnArr;
	}
    if (isset($_POST['show'])) {
        $tpl = $_POST['tpl'];
        $arrall=getAllArr();
        $result = V::getInstance()->assign('res',$arrall)
        			->fetch($tpl);
        echo json_encode(array('msg' => $result));
    }elseif($_POST['type']=='add'){
    	$id=$_POST['id'];
    	$index=$_POST['index'];
    	$pathfile=WEB_PATH."/Logs/quick/".$_SESSION['account'];
    	$strcon="";
    	if(file_exists($pathfile)){
    		$filecontent=file_get_contents($pathfile);
    		if((false === stripos($filecontent, $id.';'))&&
               (false === stripos($filecontent, $id.','))&&
               (false === stripos($filecontent, $id.' '))){
	    	    $arr_temp=explode(";",$filecontent);
	    		foreach ($arr_temp as $key=>$arr_val){
	    			if ($index==$key+1){
	    				if($arr_val==''){
	    					$arr_val.=$id;
	    				}else{
	    					$arr_val.=",".$id;
	    				}
	    			}
	    			if($key==3){
	    				$strcon.=$arr_val;	
	    			}else{
	    				$strcon.=$arr_val.";";
	    			}
	    			
	    		}
	    		file_put_contents($pathfile,$strcon);
    		}
    	}else{
    		for ($i=1;$i<5;$i++){
    			if($i==$index){
    				$strcon.="$id";	
    			}
    			if($i!=4)$strcon.=";";
    		}
    		echo $strcon;
    		file_put_contents($pathfile,$strcon);
    	}
    	
    }elseif($_POST['type']=='del'){
    	$id=$_POST['id'];
    	$pathfile=WEB_PATH."/Logs/quick/".$_SESSION['account'];
    	$filecontent=file_get_contents($pathfile);
    	$filestr=str_replace($id.",","",$filecontent);
    	$filestr=str_replace(",".$id,"",$filestr);
    	$filestr=str_replace($id.";",";",$filestr);
    	$filestr=str_replace(";".$id,";",$filestr);
    	
    	$filestr=str_replace(",,",",",$filestr);
    	$filestr=str_replace(";,",";",$filestr);
    	$filestr=str_replace(",;",";",$filestr);
    	if(substr($filestr,0,1)==',')$filestr=substr($filestr,1,strlen($filestr));
    	if(substr($filestr,-1)==',')$filestr=substr($filestr,0,strlen($filestr)-1);
    	file_put_contents($pathfile,$filestr);
    }else {
    	$pathfile=WEB_PATH."/Logs/quick/".$_SESSION['account'];
    	$arr=$arr1=$arr2=$arr3=$arr4=array();
    	if(file_exists($pathfile)){
    		$filecontent=file_get_contents($pathfile);
    		$arr_temp=explode(";",$filecontent);
    		foreach ($arr_temp as $key=>$arr_val){
    			if($key==0){$arr1=explode(",",$arr_val);}
    			elseif($key==1){$arr2=explode(",",$arr_val);}
    			elseif($key==2){$arr3=explode(",",$arr_val);}
    			elseif($key==3){$arr4=explode(",",$arr_val);}
    		}
    	}
    	$arr=array_merge($arr1,$arr2,$arr3,$arr4);
    	$arrto1=getAllArrFromID($arr1);
    	$arrto2=getAllArrFromID($arr2);
    	$arrto3=getAllArrFromID($arr3);
    	$arrto4=getAllArrFromID($arr4);
    	/*echo "<pre>";
    	var_dump($arrto1);
    	var_dump($arr1);
    	echo "</pre>";*/
    	$arrtoAll=array_merge($arrto1,$arrto2,$arrto3,$arrto4);
    	V::getInstance()->assign('res1', $arrto1)
        				->assign('res2', $arrto2)
        				->assign('res3', $arrto3)
        				->assign('res4', $arrto4)
        				->assign('resall',$arrtoAll);
    }
?>
