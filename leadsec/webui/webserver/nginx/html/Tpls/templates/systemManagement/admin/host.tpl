<form action="" method="post" id="form">
<table class="column_95 textMid tablesorter" id="clientTcp">
    <caption>
    管理主机
    </caption>
    <thead>
      <tr>
        <th class="column_10">序号</th>
        <th class="column_20">管理主机IP</th>
        <th class="column_20">子网掩码</th>
        <th class="column_50">说明</th>
      </tr>
    </thead>
    <tr>
      <td>1</td>
      <td>
          <input type="text" name="ip1" id="ip1" /><div id="ip1Tip" style="width:300px"></div>
        </td>
      <td><input type="text" name="netmask1" id="netmask1" /><div id="netmask1Tip" style="width:300px"></div></td>
      <td><input type="text" name="comment1" id="comment1" class="column_80"/></td>
    </tr>
    <tr>
      <td>2</td>
      <td>
          <input type="text" name="ip2" id="ip2" /><div id="ip2Tip" style="width:300px"></div>
        </td>
      <td><input type="text" name="netmask2" id="netmask2" /><div id="netmask2Tip" style="width:300px"></div></td>
      <td><input type="text" name="comment2" id="comment2" class="column_80" /></td>
    </tr>
    <tr>
      <td>3</td>
      <td>
          <input type="text" name="ip3" id="ip3" /><div id="ip3Tip" style="width:300px"></div>
        </td>
      <td><input type="text" name="netmask3" id="netmask3" /><div id="netmask3Tip" style="width:300px"></div></td>
      <td><input type="text" name="comment3" id="comment3" class="column_80" /></td>
    </tr>
    <tr>
      <td>4</td>
      <td>
          <input type="text" name="ip4" id="ip4" /><div id="ip4Tip" style="width:300px"></div>
        </td>
      <td><input type="text" name="netmask4" id="netmask4" /><div id="netmask4Tip" style="width:300px"></div></td>
      <td><input type="text" name="comment4" id="comment4" class="column_80" /></td>
    </tr>
    <tr>
      <td>5</td>
      <td>
          <input type="text" name="ip5" id="ip5" /><div id="ip5Tip" style="width:300px"></div>
        </td>
      <td><input type="text" name="netmask5" id="netmask5" /><div id="netmask5Tip" style="width:300px"></div></td>
      <td><input type="text" name="comment5" id="comment5" class="column_80" /></td>
    </tr>
    <tr>
      <td>6</td>
      <td>
          <input type="text" name="ip6" id="ip6" /><div id="ip6Tip" style="width:300px"></div>
        </td>
      <td><input type="text" name="netmask6" id="netmask6" /><div id="netmask6Tip" style="width:300px"></div></td>
      <td><input type="text" name="comment6" id="comment6" class="column_80" /></td>
    </tr>
    <tr>
      <td></td>
      <td colspan="3"><input class="floatLeft inputbtn"  type="submit" value="确定"/>
        <a href="#">集中管理主机</a>
        </td>
    </tr>
</table>
</form>
<script type="text/javascript">
   	$(document).ready(function(){
			$.formValidator.initConfig({formID:"form",theme:"Default",
			 ajaxForm:{
				type : "POST",
				url: "index.php",
				success:function(data){
					if(data==='sucess'){
						//tipAutoHide(2);//修改成功
					}else{
						//tipAutoHide(1);//修改失败
					}
				}
			},
			submitAfterAjaxPrompt : '身份正在验证中，请稍等...'
		});
		$("#ip1").formValidator({onShow:"请输入主机ip,不能为空",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		$("#netmask1").formValidator({onShow:"请输入子网掩码，不能为空",onfocus:"例如：255.255.255.0",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		
		
		$("#ip2").formValidator({empty:true,onShow:"请输入主机ip，可以为空",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		$("#netmask2").formValidator({empty:true,onShow:"请输入子网掩码，可以为空",onfocus:"例如：255.255.255.0",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		
		$("#ip3").formValidator({empty:true,onShow:"请输入主机ip，可以为空",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		$("#netmask3").formValidator({empty:true,onShow:"请输入子网掩码，可以为空",onfocus:"例如：255.255.255.0",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		
		$("#ip4").formValidator({empty:true,onShow:"请输入主机ip，可以为空",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		$("#netmask4").formValidator({empty:true,onShow:"请输入子网掩码，可以为空",onfocus:"例如：255.255.255.0",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		
		$("#ip5").formValidator({empty:true,onShow:"请输入主机ip，可以为空",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		$("#netmask5").formValidator({empty:true,onShow:"请输入子网掩码，可以为空",onfocus:"例如：255.255.255.0",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		
		$("#ip6").formValidator({empty:true,onShow:"请输入主机ip，可以为空",onfocus:"例如：172.16.201.18",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		$("#netmask6").formValidator({empty:true,onShow:"请输入子网掩码，可以为空",onfocus:"例如：255.255.255.0",onCorrect:""}).regexValidator({regExp:"ip4",dataType:"enum",onError:"格式不正确"});
		
		
		
				
	});
   </script>
