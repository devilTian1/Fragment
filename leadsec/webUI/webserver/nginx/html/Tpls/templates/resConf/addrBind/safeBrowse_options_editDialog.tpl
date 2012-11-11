<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
  <tbody>
      <tr>
        <td class="tdheader"><span class="red">*</span>名称: </td>
        <td class="tdbody" colspan="2">
          <input type="text" name="inputtext2" class="inputtext"/>
          &nbsp;(过滤选项集的名称，被安全浏览任务引用)</td>
      </tr>
      <tr>
        <td class="tdheader"> 
          <label>
          	<input name="radio4" type="radio" id="radio10" value="radio" checked="checked" />允许
          </label>
         <label>
			<input type="radio" name="radio4" id="radio11" value="radio" />阻止 
         </label>
		</td>
        <td class="tdheader">HTTP请求方法: </td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox5" id="checkbox5" />
          GET
          <input type="checkbox" name="checkbox6" id="checkbox6" />
          POST
          <input type="checkbox" name="checkbox7" id="checkbox7" />
          PUT 
          <input type="checkbox" name="checkbox8" id="checkbox8" />
          
          HEAD
          <input type="checkbox" name="checkbox9" id="checkbox9" />
          COMMONT</div>
          <div style="display:none; border:#06C 1px solid" id="sectionbody1">
            <label>
              <input type="checkbox" name="checkbox2" id="checkbox2" />
              全选
            </label>
            <label>
              <input type="checkbox" name="checkbox3" id="checkbox3" />
              部分选择
            </label>
            <label>
              <input type="checkbox" name="checkbox4" id="checkbox4" />
              不选择
            </label>
          </div></td>
      </tr>
      <tr>
        <td class="tdheader">
          <label>
          	<input name="radio1" type="radio" id="radio3" value="radio" checked="checked" />允许
          </label>
         
          <label>
          	<input type="radio" name="radio1" id="radio4" value="radio" />阻止
      	  </label>
        </td>
        <td class="tdheader"><span class="rowElem"> URL过滤 </span>: </td>
        <td class="tdbody">
          <label>
            <select name="select" class="w200" id="select">
            </select>
          </label></td>
      </tr>
      <tr>
        <td class="tdheader">
          <label>
          	<input name="radio2" type="radio" id="radio5" value="radio" checked="checked" />允许
          </label>
          <label>
            <input type="radio" name="radio2" id="radio6" value="radio" />阻止 
          </label>
         </td>
        <td class="tdheader"><span class="rowElem">MIME类型过滤 </span>: </td>
        <td class="tdbody">
          <label>
            <select name="select" class="w200" id="select">
            </select>
          </label></td>
      </tr>
      <tr>
        <td class="tdheader">
          <label>
          	<input name="radio3" type="radio" id="radio7" value="radio" checked="checked" />允许
          </label>
          <label>
            <input type="radio" name="radio3" id="radio9" value="radio" />阻止
          </label>
		</td>
        <td class="tdheader"><span class="rowElem">文件扩展名 </span>: </td>
        <td class="tdbody">
          <label>
            <select name="select" class="w200" id="select">
              </select>
          </label></td>
      </tr>
      <tr>
        <td colspan="2" class="tdheader"> 病毒扫描 : </td>
        <td class="tdbody">
          <input type="checkbox" name="checkbox" id="checkbox" />
          文件扫描
          <input type="checkbox" name="checkbox" id="checkbox10" />
          流扫描
        </td>
      </tr>
      <tr>
        <td colspan="2" class="tdheader">缓存文件上限: </td>
        <td class="tdbody">
          <input type="text" name="inputtext" class="inputtext"/>
          兆字节(M) 针对文件扫描时，文件大小上限</td>
      </tr>
      <tr>
        <td colspan="2" class="tdheader">HTTP协议头部协议上限: </td>
        <td class="tdbody">
          <input type="text" name="inputtext" class="inputtext"/>
          &nbsp;字节(Bytes) 请求首部上限，最大为10240字节</td>
      </tr>
      <tr>
        <td colspan="2" class="tdheader">备注: </td>
        <td class="tdbody">
          <input type="text" name="inputtext" class="inputtext"/>
        </td>
      </tr>
    </tbody>
</table>
</form>
<script type="text/javascript">
$(document).ready(function() {
						   
});
</script>