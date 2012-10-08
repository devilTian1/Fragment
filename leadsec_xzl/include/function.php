<?php
//输出不现国家的语言
function __R($string){
	$mo2po = new gettext_reader(new CachedFileReader(MO_FILE));
	return $mo2po->translate($string);
}

function redirect($info,$url)
{
	echo "<meta http-equiv='refresh' content='1;url=$url'>";
        echo '<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />';
        echo $info;
}
function redirect_once($url)
{
	echo "<meta http-equiv='refresh' content='0;url=$url'>";
}

function showtt($tt)
{
    if($tt<=60){
        echo $tt."秒";
    }
    elseif($tt>60 & $tt<=3600){
        $tt1=intval($tt/60);
        $tt2=$tt-$tt1*60;
        echo $tt1."分".$tt2."秒";
    }
    elseif($tt>3600 & $tt <=86400){
        $tt3=intval($tt/3600);
        $tt4=intval(($tt-$tt3*3600)/60);
        $tt5=$tt-$tt3*3600-$tt4*60;
        echo $tt3."小时".$tt4."分".$tt5."秒";
    }
    else{
        $tt6=intval($tt/86400);
        $tt7=intval(($tt-$tt6*86400)/3600);
        $tt8=intval(($tt-$tt6*86400-$tt7*3600)/60);
        $tt9=$tt-$tt6*86400-$tt7*3600-$tt8*60;
        echo $tt6."天".$tt7."小时".$tt8."分".$tt9."秒";
    }
}

function gethttpdata($url,$post='')
{
    $tmpInfo = '';
    $curl = curl_init();
    
    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_USERAGENT, $_SERVER['HTTP_USER_AGENT']);
    curl_setopt($curl, CURLOPT_AUTOREFERER, 1);
    if($post) {
    curl_setopt($curl, CURLOPT_POST, 1);
    curl_setopt($curl, CURLOPT_POSTFIELDS, $post);
    }
    //curl_setopt($curl, CURLOPT_FOLLOWLOCATION, 1);
    curl_setopt($curl, CURLOPT_TIMEOUT, 100);
    curl_setopt($curl, CURLOPT_HEADER, 0);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
    $tmpInfo = curl_exec($curl);
    if (curl_errno($curl)) {
    return curl_error($curl);
    }
    curl_close($curl);
    return $tmpInfo;

}

function lang($msg){
    global $langfile;
    preg_match("/\"$msg\"\:\"(.*?)\"/is",$langfile,$array);
    if(isset($array[1])) return $array[1];
    else return "";
}
//得到menu.php中的值，
//返回时数组
function returnSubmenu($menuarray=array(),$maincfgname='',$typecfgname='',$subtypecfgname=''){
	$findArr=array();
	foreach($menuarray as $key=>$value){
		if($value['cfgname']==$maincfgname){
			if($typecfgname==''){
				$findArr=$value;
				return $findArr;
			}else{
				foreach($value['subMenu'] as $value2){
					if($value2['cfgname']==$typecfgname){
						if($subtypecfgname==''){
							$findArr=$value2;
							return $findArr;
						}else{
							foreach($value2['subMenu'] as $value3){
								if($value3['cfgname']==$subtypecfgname){
									$findArr=$value2['subMenu'];
									return $findArr;
								}
							}
						}
					}
				}
			}
		}
		
	}
}

//得到menu.php中的值name的值，
//返回时数组
function returnPicmenu($menuarray=array(),$maincfgname='',$typecfgname='',$subtypecfgname='',$flag='--'){
	$str="";
	foreach($menuarray as $key=>$value){
		if($value['cfgname']==$maincfgname){
			if($typecfgname==''){
				$str=$value['name'];
				return $str;
			}else{
				foreach($value['subMenu'] as $value2){
					if($value2['cfgname']==$typecfgname){
						if($subtypecfgname==''){
							$str=$value['name'].$flag.$value2['name'];
							return $str;
						}else{
							foreach($value2['subMenu'] as $value3){
								if($value3['cfgname']==$subtypecfgname){
									$str=$value['name'].$flag.$value2['name'].$flag.$value3['name'];
									return $str;
								}
							}
						}
					}
				}
			}
		}
		
	}
}

?>