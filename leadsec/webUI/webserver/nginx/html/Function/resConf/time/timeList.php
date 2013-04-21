<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function freshTimeList($where) {
    	$limit=split(" ",$where);
    	$nrow = getDataCount();
    	$allNameData = getAllNameData();
    	$nameList = array();
    	$db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
    	if($nrow <= 10){
    		//小于10条数据
    		$sql  = "SELECT name, spantype, comment FROM time_span";	
    	} else if($nrow > 10 && $nrow <= 20){
    		if($limit[2]==='10'){ 
    			//每页显示10行  			  		
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;      				  				
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 10-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";    					
    			}else{
    				//第二页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 10-$tag + $tag*7;
    				for($i=10;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = count($allNameData)-10-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow ";	 				   				
    			}   			   			
    		}else{
    			//其余每页行数显示
    			$sql  = "SELECT name, spantype, comment FROM time_span";
    		}    		
    	}else if($nrow > 20 && $nrow <= 50){
    		if($limit[2]==='10'){
    			//每页显示10行
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				}
    				$limitNrow = 10-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";   				
    			}else if($limit[4]==='10'){
    				//第二页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 10-$tag + $tag*7;				
    				for($i=10;$i<20;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = 10-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow";   			    				
    			}else {
    				//其余每页行数显示
    				$tag=0;
    				$tag1=0;
    				$tag2=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 10-$tag + $tag*7;
    				for($i=10;$i<20;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = 10-$tag1 + $tag1*7;
    				for($i=20;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag2++;   						
    					}
    				}
    				$limitNrow2 = count($allNameData)-20-$tag2 + $tag2*7;
    				$offsetnrow = $limitNrow + $limitNrow1;
    				$sql = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow2 OFFSET $offsetnrow ";    				
    			}	
    		}else if($limit[2]==='20'){
    			//每页显示20行
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;      				  				
    				for($i=0;$i<20;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 20-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";    					
    			}else{
    				//第二页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<20;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 20-$tag + $tag*7;
    				for($i=20;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = count($allNameData)-20-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow ";	 				   				
    			}   			   				   			
    		}else {
    			//
    			$sql  = "SELECT name, spantype, comment FROM time_span";
    		}    			
    	}else if($nrow > 50 && $nrow <= 100){
    		if($limit[2]==='10'){
    			//每页显示10行
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				}
    				$limitNrow = 10-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";   				
    			}else if($limit[4]==='10'){
    				//第二页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 10-$tag + $tag*7;
				
    				for($i=10;$i<20;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = 10-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow";   			    				
    			}else {
    				//第三页
    				$tag=0;
    				$tag1=0;
    				$tag2=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 10-$tag + $tag*7;

    				for($i=10;$i<20;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = 10-$tag1 + $tag1*7;

    				for($i=20;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag2++;   						
    					}
    				}
    				$limitNrow2 = count($allNameData)-20-$tag2 + $tag2*7;
    				$offsetnrow = $limitNrow + $limitNrow1;
    				$sql = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow2 OFFSET $offsetnrow ";    				
    			}	
    		}else if($limit[2]==='20'){
    			//每页显示20行
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;      				  				
    				for($i=0;$i<20;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 20-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";    					
    			}else{
    				//第二页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<20;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 20-$tag + $tag*7;

    				for($i=20;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = count($allNameData)-20-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow ";	 				   				
    			}   			   				   			
    		}else if($limit[2]==='50'){
    			//每页显示50行
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;      				  				
    				for($i=0;$i<50;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 50-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";    					
    			}else{
    				//第二页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<50;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 50-$tag + $tag*7;

    				for($i=20;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = count($allNameData)-50-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow ";	 				   				
    			}   			   				   			
    		}else {
    			$sql  = "SELECT name, spantype, comment FROM time_span";
    		}    			
    	}else {
    		//大于100条
    		if($limit[2]==='10'){
    			//每页显示10条
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				}
    				$limitNrow = 10-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";   				
    			}else if($limit[4]==='10'){
    				//第二页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 10-$tag + $tag*7;   				
    				for($i=10;$i<20;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = 10-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow";   			    				
    			}else {
    				//其余页
    				$tag=0;
    				$tag1=0;
    				$tag2=0;
    				for($i=0;$i<10;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 10-$tag + $tag*7;
    				for($i=10;$i<20;$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = 10-$tag1 + $tag1*7;
    				for($i=20;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag2++;   						
    					}
    				}
    				$limitNrow2 = count($allNameData)-20-$tag2 + $tag2*7;
    				$offsetnrow = $limitNrow + $limitNrow1;
    				$sql = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow2 OFFSET $offsetnrow ";    				
    			}	
    		}else if($limit[2]==='20'){
    			//每页显示20行
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;      				  				
    				for($i=0;$i<20;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 20-$tag + $tag*7;

	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";    					
    			}else{
    				//第二页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<20;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 20-$tag + $tag*7;

    				for($i=20;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = count($allNameData)-20-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow ";	 				   				
    			}   			   				   			
    		}else if($limit[2]==='50'){
    			//每页显示50行
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;      				  				
    				for($i=0;$i<50;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 50-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";    					
    			}else{
    				//其余页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<50;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 50-$tag + $tag*7;

    				for($i=50;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = count($allNameData)-50-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow ";	 				   				
    			}   			   				   			
    		}else if($limit[2]==='100'){
    			//每页显示100行
    			if($limit[4]==='0'){
    				//第一页
    				$tag=0;      				  				
    				for($i=0;$i<100;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 100-$tag + $tag*7;
	   				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow OFFSET 0";    					
    			}else{
    				//其余页
    				$tag=0;
    				$tag1=0;
    				for($i=0;$i<100;$i++){
    					$name=$allNameData[$i]; 				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag++;   						
    					}
    				} 
    				$limitNrow = 100-$tag + $tag*7;
    				
    				for($i=100;$i<count($allNameData);$i++){
    					$name=$allNameData[$i];    				
    					$sql  = "SELECT name FROM time_span where name ='$name' ";
    					$nameList = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    					if($nameList===Array()){
    						$tag1++;   						
    					}
    				}
    				$limitNrow1 = count($allNameData)-100-$tag1 + $tag1*7;
    				$sql  = "SELECT name, spantype, comment FROM time_span LIMIT $limitNrow1 OFFSET $limitNrow ";	 				   				
    			}   			   				   			
    		}else {
    			$sql  = "SELECT name, spantype, comment FROM time_span";
    		}    			
    	}
    			
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC); 
        $tpl  = 'resConf/time/timeListTable.tpl';             
        $result = array();
        $weekName = array('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');
        foreach ($data as $v) {          	     	
        	if ($v['spantype'] !== '0') {
        		$pos = strrpos($v['name'], '_');
            	if ($pos !== false) {
                	$nameSuffix = substr($v['name'], $pos+1);
                	if (false !== array_search($nameSuffix, $weekName)) {
                    	$v['name'] = substr($v['name'], 0, -4);
                    	$sql  = "SELECT comment FROM grp_comment WHERE name = '{$v['name']}'";
                    	$comments = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
                    	$v['comment'] = $comments['comment'];
                    	$result[$v['name']] = $v;
                		} else {
                    		$result[$v['name']] = $v;
                		}
            	} else {
                	$result[$v['name']] = $v;
            	}
        	} else {        		
        		$result[$v['name']] = $v;	
        	}          
        }

        echo V::getInstance()->assign('timeList', $result)
            ->assign('pageCount', 10)
            ->fetch($tpl);
    }

    function getDataCount() {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT name, spantype, comment FROM time_span";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        $result = array();
        $weekName = array('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');
        foreach ($data as $v) {        	
        	if ($v['spantype'] !== '0') {
        		$pos = strrpos($v['name'], '_');
            	if ($pos !== false) {
                	$nameSuffix = substr($v['name'], $pos+1);
                	if (false !== array_search($nameSuffix, $weekName)) {
                    	$v['name'] = substr($v['name'], 0, -4);
                    	$sql  = "SELECT comment FROM grp_comment WHERE name = '{$v['name']}'";
                    	$comments = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
                    	$v['comment'] = $comments['comment'];
                    	$result[$v['name']] = $v;
                		} else {
                    		$result[$v['name']] = $v;
                		}
            	} else {
                	$result[$v['name']] = $v;
            	}
        	} else {        		
        		$result[$v['name']] = $v;	
        	}          
        }
        return count($result);
    }
     function getAllNameData() {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT name, spantype, comment FROM time_span";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);        
        $result = array();
        $allData = array();
        $weekName = array('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');
        foreach ($data as $v) {        	
        	if ($v['spantype'] !== '0') {
        		$pos = strrpos($v['name'], '_');
            	if ($pos !== false) {
                	$nameSuffix = substr($v['name'], $pos+1);
                	if (false !== array_search($nameSuffix, $weekName)) {
                    	$v['name'] = substr($v['name'], 0, -4);
                    	$sql  = "SELECT comment FROM grp_comment WHERE name = '{$v['name']}'";
                    	$comments = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
                    	$v['comment'] = $comments['comment'];
                    	$result[$v['name']] = $v;
                		} else {
                    		$result[$v['name']] = $v;
                		}
            	} else {
                	$result[$v['name']] = $v;
            	}
        	} else {        		
        		$result[$v['name']] = $v;	
        	}          
        }
        foreach ($result as $r) {
        	$allNameData[]=$r['name'];	
        }
        return $allNameData;
    }
    function getDateFormat($str, $type='fullDate') {
        if ($type === 'time') {
            return substr($str, 8, 2) . ':' .
                substr($str, 10, 2) . ':' . substr($str, 12, 2);
        } else {
            return substr($str, 0, 4) . '/' . substr($str, 4, 2) . '/' .
                substr($str, 6, 2) . ' ' . substr($str, 8, 2) . ':' .
                substr($str, 10, 2) . ':' . substr($str, 12, 2);
        }
    }

    function getAddWeekStr() {
        $result = array();
        if ($_POST['startTime_sun'] !== '') {
            $result[] = 'sun ' . $_POST['startTime_sun'] . '-' .
                $_POST['endTime_sun'];
        }
        if ($_POST['startTime_mon'] !== '') {
            $result[] = 'mon ' . $_POST['startTime_mon'] . '-' .
                $_POST['endTime_mon'];
        }
        if ($_POST['startTime_tue'] !== '') {

            $result[] = 'tue ' . $_POST['startTime_tue'] . '-' .
                $_POST['endTime_tue'];
        }
        if ($_POST['startTime_wed'] !== '') {
            $result[] = 'wed ' . $_POST['startTime_wed'] . '-' .
                $_POST['endTime_wed'];
        }
        if ($_POST['startTime_thu'] !== '') {
            $result[] = 'thu ' . $_POST['startTime_thu'] . '-' .
                $_POST['endTime_thu'];
        }
        if ($_POST['startTime_fri'] !== '') {
            $result[] = 'fri ' . $_POST['startTime_fri'] . '-' .
                $_POST['endTime_fri'] . ' ';
        }
        if ($_POST['startTime_sat'] !== '') {
            $result[] = 'sat ' . $_POST['startTime_sat'] . '-' .
                $_POST['endTime_sat'];
        }
        return join(' ', $result);
    }

    function getAddOrEditTimeCmd($type) {
        $name    = $_POST['resTimeName'];
        $comment = $_POST['comment'];

        if ($_POST['scheduleType'] === 'oneTime') {
            $stime = $_POST['startTime_f'];
            $etime = $_POST['endTime_f'];
            $cmd   = "/usr/local/bin/time $type name \"$name\" type once start $stime ".
                "stop $etime comment \"$comment\"";
            return $cmd;
        } else if ($_POST['scheduleType'] === 'week') {
            $str = getAddWeekStr();
            $cmd   = "/usr/local/bin/time $type name \"$name\" type week $str ".
                "comment \"$comment\"";
            return $cmd;
        } else {
            throw new Exception('wrong schedule type.'); 
        }
    }
    function getTimeListInUse($name)
    {
    	 $flag = 0;
    	 //时间组
    	 $db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
    	 $sql = "SELECT subname FROM time_grp WHERE subname = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	 //文件交换
     	 $db  = new dbsqlite(DB_PATH . '/netgap_fs.db');
    	 $sql = "SELECT time FROM dir_info WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//文件同步
     	 $db  = new dbsqlite(DB_PATH . '/netgap_new_fs.db');
    	 $sql = "SELECT time FROM sync_file_client WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//数据库同步
     	 $db  = new dbsqlite(DB_PATH . '/netgap_db_swap.db');
    	 $sql = "SELECT time FROM db_swap_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//安全浏览
     	 $db  = new dbsqlite(DB_PATH . '/netgap_http.db');
    	 $sql = "SELECT time FROM acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//FTP访问
     	 $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
    	 $sql = "SELECT time FROM ftp_comm_client_acl WHERE time = '$name' 
    	     UNION SELECT time FROM ftp_trans_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//邮件访问
     	 $db  = new dbsqlite(DB_PATH . '/netgap_mail.db');
    	 $sql = "SELECT time FROM pop3_comm_client_acl WHERE time = '$name' 
    	     UNION SELECT time FROM pop3_trans_client_acl WHERE time = '$name'
    	     UNION SELECT time FROM smtp_comm_client_acl WHERE time = '$name'
    	     UNION SELECT time FROM smtp_trans_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//数据库访问
     	 $db  = new dbsqlite(DB_PATH . '/gateway_ftp.db');
    	 $sql = "SELECT time FROM db_trans_client_acl WHERE time = '$name' 
    	     UNION SELECT time FROM db_comm_client_acl time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//定制访问
     	 $db  = new dbsqlite(DB_PATH . '/netgap_custom.db');
    	 $sql = "SELECT time FROM tcp_comm_client_acl WHERE time = '$name' 
    	     UNION SELECT time FROM tcp_trans_client_acl WHERE time = '$name'
    	     UNION SELECT time FROM udp_comm_client_acl WHERE time = '$name'
    	     UNION SELECT time FROM udp_trans_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//安全通道
     	 $db  = new dbsqlite(DB_PATH . '/netgap_fastpass.db');
    	 $sql = "SELECT time FROM fastpass_client_acl WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	//消息传输
     	 $db  = new dbsqlite(DB_PATH . '/netgap_msg.db');
    	 $sql = "SELECT time FROM msg_client_task WHERE time = '$name'";
    	 $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
    	 if(count($data) > 0){
    	 	$flag = 1;
    	 	return $flag;
    	 }
    	 return $flag;
    }
    if ($name = $_POST['editName']) {
        // Get specified timelist data
        $tpl = 'resConf/time/editTimeListDialog.tpl';
        $db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql = "SELECT * FROM time_span WHERE name = '$name' or name like '{$name}\_%' ESCAPE '\'";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        $dataCount = count($data);
        if ($dataCount === 1) {
            $result['scheduleType'] = 'oneTime';
            $result['startTime_f']  = getDateFormat($data[0]['starttime']);
            $result['endTime_f']    = getDateFormat($data[0]['endtime']);
            $result['comment']      = $data[0]['comment']; 
        } else {
            $result['scheduleType']  = 'week';
            $sql  = "SELECT comment FROM grp_comment WHERE name = '$name'";
            $comments = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
            $result['comment'] = $comments['comment'];
            foreach ($data as $v) {
                $nullTime = array('0', '00000000000000');
                if (array_search($v['starttime'], $nullTime) !== false || array_search($v['endtime'], $nullTime) !== false) {
                    continue;
                }
                switch ($v['name']) {
                    case $name . '_mon' :
                        $result['startTime_mon'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_mon'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_tue' :
                        $result['startTime_tue'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_tue'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_wed' :
                        $result['startTime_wed'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_wed'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_thu' :
                        $result['startTime_thu'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_thu'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_fri' :
                        $result['startTime_fri'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_fri'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_sat' :
                        $result['startTime_sat'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_sat'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    case $name . '_sun' :
                        $result['startTime_sun'] = getDateFormat($v['starttime'], 'time');
                        $result['endTime_sun'] = getDateFormat($v['endtime'], 'time');
                        break 1;
                    default : 
                        throw new Exception('wrong sql: '.$sql);
                }
            }
        }
        $result['name'] = $name;
        $result = V::getInstance()->assign('timeList', $result)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if (!empty($_POST['openDialog'])) {
        // Display add dialog
        $tpl = 'resConf/time/editTimeListDialog.tpl';
        $result = V::getInstance()->assign('timeList', $result)
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add new time data
        $cmd = getAddOrEditTimeCmd('add');
        $cli = new cli();
        $cli->setLog("添加名称为".$_POST['resTimeName']."的时间列表")->run($cmd);
        echo json_encode(array('msg' => '添加成功.'));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified time data        
        $cmd = getAddOrEditTimeCmd('set');
        $cli = new cli();
        $cli->setLog("编辑名称为".$_POST['resTimeName']."的时间列表")->run($cmd);
        echo json_encode(array('msg' => '修改成功.'));
    } else if ($name = $_POST['delName']) {
        // Delete the specified time data       
        $flag = getTimeListInUse($name);
        if ($flag == 1) {       	
        	$msg = "名称为\"$name\"的时间列表被引用，无法删除";
        	echo json_encode(array('msg' => $msg));
        } else {
        	$cmd  = "/usr/local/bin/time del name \"$name\"";
        	$cli  = new cli();
        	$cli->setLog("删除名称为".$_POST['delName']."的时间列表")->run($cmd);
        	echo json_encode(array('msg' => "[$name]删除成功."));
        }      
    } else if ($orderStatement = $_POST['orderStatement']) {
        // fresh and resort timelist Table
        freshTimeList($orderStatement);
    } else if (!empty($_GET['checkExistResTimeName'])) {
    	$db  = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
    	$sql = "SELECT name FROM time_span WHERE spantype = '0' and name = '".$_GET['resTimeName']."'"
               ."UNION SELECT name FROM grp_comment WHERE name = '".$_GET['resTimeName']."'";
        echo $db->query($sql)->getCount() > 0 ? 'false' : 'true';   	
    } else {
        // init page data
        $result = getDataCount();
        V::getInstance()->assign('dataCount', $result)
            ->assign('pageCount', ceil($result/10))
            ->assign('clickedPageNo', 1)
	        ->assign('prev', 1)
	        ->assign('next', 2);
    }
?>
