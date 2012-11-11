<style type="text/css">
	#listLable label{ width:120px; display:block; float:left}
</style>
<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
    <tr>
      <td class="tdheader" width="100">名称:</td>
      <td class="tdbody">
      	<input type="text" name="inputtext2" class="inputtext"/>
      </td>
    </tr>
    <tr>
      <td rowspan="2" class="tdheader">用户控制:</td>
      <td class="tdbody">
      	<input name="radio" type="radio" id="radio" value="radio" checked="checked" />禁止用户
        <input type="text" name="inputtext3" />多个用户用,隔开
       </td>
    </tr>
    <tr>
      	<td class="tdbody">
        <input type="radio" name="radio" id="radio2" value="radio" />允许用户
		<input type="text" name="inputtext" />多个用户用,隔开
		</td>
    </tr>
    <tr>
      <td rowspan="2" class="tdheader">命令控制: </td>
      <td>控制动作：
        <input name="radio1" type="radio" id="radio3" value="radio" checked="checked" />禁止命令
     	<input name="radio1" type="radio" id="radio4" value="radio" />允许命令
      </td>
    </tr>
    <tr>
      <td id="listLable">
        <label>
          <input type="checkbox" name="checkbox4" id="checkbox4" />dir
        </label>
      <label>
        <input type="checkbox" name="checkbox5" id="checkbox5" />delete
      </label>
      <label>
        <input type="checkbox" name="checkbox6" id="checkbox6" />ls
      </label>
      <label>
      	<input type="checkbox" name="checkbox7" id="checkbox7" />cd
      </label> 
      <label>
      	<input type="checkbox" name="checkbox8" id="checkbox8" />get 
      </label>
      <label>
     	 <input type="checkbox" name="checkbox9" id="checkbox9" />put
      </label>
      <label>
     	 <input type="checkbox" name="checkbox10" id="checkbox10" />pwd
      </label>
      <label> 
      	<input type="checkbox" name="checkbox11" id="checkbox11" />quit
      </label>
      <label>
      	<input type="checkbox" name="checkbox12" id="checkbox12" />mkdir
      </label>
      <label>
     	 <input type="checkbox" name="checkbox13" id="checkbox13" />rename
      </label>
      <label>
     	 <input type="checkbox" name="checkbox14" id="checkbox14" />radir
      </label>
      <label>
      <input type="checkbox" name="checkbox15" id="checkbox15" /> append
     </label>
      </td>
    </tr>
    <tr>
      <td rowspan="3" class="tdheader">上传控制:</td>
      <td class="tdbody">多个文件类型用,分开，单个.表示没有后缀的文件，如.exe,.txt</td>
    </tr>
    <tr>
      <td class="tdbody">
      <label>
      	<input name="radio3" type="radio" id="radio7" value="radio" checked="checked" />禁止上传文件类型
          </label>
        <input type="text" name="inputtext6"  />
      </td>
      </tr>
    <tr>
      <td class="tdbody">
      <label>
          <input name="radio3" type="radio" id="radio5" value="radio" />允许上传文件类型
          </label>
        <input type="text" name="inputtext6"  />
      </td>
      </tr>
    <tr>
      <td rowspan="3" class="tdheader">下载控制:</td>
      <td class="tdbody"> 多个文件类型用,分开，单个.表示没有后缀的文件，如.exe,.txt</td>
      </tr>
    <tr>
      <td class="tdbody">
        <label>
          <input name="radio4" type="radio" id="radio5" value="radio" checked="checked" />禁止下载文件类型
          </label>
        <input type="text" name="inputtext4"  />
      </td>
      </tr>
    <tr>
      <td class="tdbody">
        <label>
          <input name="radio4" type="radio" id="radio6" value="radio" />允许下载文件类型
          </label>
        <input type="text" name="inputtext5"  />
      </td>
      </tr>
    <tr>
      <td rowspan="3" class="tdheader">缓存控制:</td>
      <td class="tdbody">
		文件大小上限<input type="text" name="inputtext7"  />兆(M)(针对缓存文件过滤时，文件大小上限)</td>
    </tr>
    <tr>
      <td class="tdbody">
       	文件病毒扫描
        <input name="radio5" type="radio" id="radio8" value="radio" checked="checked" />
        开启
        <input name="radio5" type="radio" id="radio9" value="radio" checked="checked" />
        关闭
      </td>
    </tr>
    <tr>
      <td class="tdbody">
        <input type="checkbox" name="checkbox16" id="checkbox16" />
        边收边发机制（可保持活连接，减少延迟）
      </td>
    </tr>
    <tr>
      <td class="tdheader">Banner保护:<br /></td>
      <td class="tdbody">
        bannner替换<input type="text" name="inputtext8"  />
      </td>
    </tr>
    <tr>
      <td class="tdheader">备注</td>
      <td class="tdbody">
        <input type="text" name="inputtext10"  />
      </td>
    </tr>
  </table>
  
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>