<form action="" method="post" name="form1" id="form1">
<table class="column_95">
 <caption>
  集中管理
  </caption>
  <tbody>
    <tr>
      <td width="250" class="tdheader">集中管理主机 IP: </td>
      <td class="tdbody"><input name="serverip" type="text" id="serverip" class="inputtext"  /></td>
    </tr>
    <tr>
      <td class="tdheader"><input type="button" name="button" id="addip" value="&gt;&gt;" />
        <br/>
        <br/>
        <input type="button" name="button" id="delip" value="&lt;&lt;" /></td>
      <td class="tdbody">
        <select name="iplist" size="6" multiple="multiple" id="serveriplist" style="width:160px" >
        </select>
      </td>
    </tr>
    <tr>
      <td class="tdheader"><{$smarty.const.PRODUCT_NAME}>名称:</td>
      <td class="tdbody">NetGap</td>
    </tr>
    <tr>
      <td class="tdheader">本机备注:</td>
      <td class="tdbody"><input name="input3" type="text" class="inputtext"  />
        ( 20 个以内字符 ) </td>
    </tr>
    <tr>
      <td class="tdheader">负责人姓名: </td>
      <td class="tdbody"><input name="input2" type="text" class="inputtext"  />
        ( 20 个以内字符 ) </td>
    </tr>
    <tr>
      <td class="tdheader">负责人电话:</td>
      <td class="tdbody"><input name="input4" type="text" class="inputtext"  />
        ( 20 个以内字符 ) </td>
    </tr>
    <tr>
      <td class="tdheader">CPU 利用率阈值: </td>
      <td class="tdbody"><input name="input5" type="text" class="inputtext" value="85" size="10"  />
        % ( 1-100 ) </td>
    </tr>
    <tr>
      <td class="tdheader">内存利用率阈值:</td>
      <td class="tdbody"><input name="input5" type="text" class="inputtext" value="85" size="10"  />
        % ( 1-100 ) </td>
    </tr>
    <tr>
      <td class="tdheader">磁盘利用率阈值: </td>
      <td class="tdbody"><input name="input" type="text" class="inputtext" value="85" size="10"  />
        % ( 1-100 ) </td>
    </tr>
    <tr>
      <td class="tdheader">Trap发送字符串:</td>
      <td class="tdbody"><input name="input7" type="text" class="inputtext"  />
        ( 32个以内字符 ) </td>
    </tr>
    <tr>
      <td valign="middle" class="tdheader"><input name="checkbox2" type="checkbox" id="checkbox2" checked="checked" />
        snmp v1&amp;v2 </td>
      <td class="tdbody">
        <div>只读团体字符串:
        <input name="input9" type="text" />
        ( 32个以内字符 )
        </div>
        <div class="margintop3">
           读写团体字符串:
          <input name="input9" type="text" />
          ( 32个以内字符 )
         </div>
         </td>
    </tr>
    <tr>
      <td valign="middle" class="tdheader"><input name="checkbox" type="checkbox" id="checkbox" />
        snmp v3 </td>
      <td class="tdbody">
       <div class="margintop3">
      	<span class="red">*</span>
        用户名称: 
        <input name="input6" type="text" />
        ( 32个以内字符 )
        </div>
        
        <div class="margintop3"><span class="red">*</span>
           安全选项:
          <select name="select2" id="select2" style="width:160px" disabled="disabled" >
            <option>非授权认证方式</option>
          </select>
        </div>
        
        <div class="margintop3"><span class="red">*</span>
           认证协议:
          	 <input name="radio" type="radio" id="radio" value="radio" checked="checked" /> MD5 

             <input type="radio" name="radio" id="radio" value="radio" />SHA 
        </div>
        
        <div class="margintop3"><span class="red">*</span>
           认证密码:
          <input name="input8" type="password" />
          ( 32个以内字符 )
        </div>
         
        <div class="margintop3"><span class="red">*</span>
           加密协议:
          
            <input name="radio1" type="radio" id="radio" value="radio" checked="checked" />DES 
          
            <input type="radio" name="radio1" id="radio" value="radio" />AES 
        </div>
        
        <div class="margintop3"><span class="red">*</span>
          加秘密码:
          <input name="input8" type="password" />
          ( 32个以内字符 )
        </div></td>
    </tr>
    <tr>
      <td></td>
      <td class="tdbody">
        <input type="submit" value="确定" width="50" class="inputbtn" />
  	  </td>
    </tr>
   </tbody>
</table>
</form>
<script type="text/javascript">
$(document).ready(function() {
	$(":button, :submit").button();
	$("#addip").click(function(){
		var serverip=$("#serverip").val(),
			flag=0;
		$("#serveriplist option").each(function(){
			if($(this).val()==serverip){
				flag=1;
			}
		});	
		if(flag==0&&serverip!=''){
			var option = "<option value='"+serverip+"'>"+serverip+"</option>";                   
        	$("#serveriplist").append(option);  
		}
	})
	
	$("#serveriplist").dblclick(function(){  
		$("#serveriplist option:selected").each(function(){ 
			$(this).remove();  
		});  
     });
	$("#delip").click(function(){
		$("#serveriplist option:selected").each(function(){
			$(this).remove();  
		});					   
	})

 	/*$.formValidator.initConfig({formID:"form1",theme:"126",
			ajaxForm:{
				type : "POST",
				url: "index.php?chkusr=ok",
				success:function(data){
					
				}
			},
			submitAfterAjaxPrompt : '身份正在验证中，请稍等...'
	});*/
		/*$("#netname").formValidator({tipID:"netnameTip",onShow:"( 1-20 个ASCII字符 )",onShowText:"( 1-20 个ASCII字符 )",onFocus:"名称不能为空",onCorrect:""}).inputValidator({min:1,max:20,onError:"名称非法"})*/
 
});
</script>
