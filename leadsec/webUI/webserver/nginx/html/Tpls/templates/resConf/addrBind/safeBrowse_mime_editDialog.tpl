<style type="text/css">
	.sectionDiv hr{ color:#09F;}
	.sectionDiv label{ width:120px; float:left; display:block;}
</style>
<form action="xtcs.html" method="POST" id="editForm" onSubmit="return false;">
<table class="column_95">
   	<tbody>
      <tr>
        <td class="tdheader"><span class="red">*</span>名称: <br /></td>
        <td width="77%"><div class="rowElem">
          <input type="text" name="inputtext2" class="inputtext"/>
          &nbsp;(1-19个合法字符)</div></td>
      </tr>
      <tr>
        <td class="tdheader"> 应用程序:</td>
        <td class="tdbody"><div class="rowElem">
          <label>
            <input type="radio" name="app" value="all" checked="checked" />
          </label>
          全选
          <label>
            <input type="radio" name="app" value="part" />
          </label>
          部分选择
          <label>
            <input type="radio" name="app" value="not" />
          </label>
          不选择 </div>
          <div id="appsection" class="sectionDiv hide">
          	<hr />
          	<label><input name="mp4" type="checkbox" value="" />mp4</label>
            <label><input name="mp4" type="checkbox" value="" />mp4</label>
            <label><input name="mp4" type="checkbox" value="" />mp4</label>
            <label><input name="mp4" type="checkbox" value="" />mp4</label>
            <label><input name="mp4" type="checkbox" value="" />mp4</label>
            <label><input name="mp4" type="checkbox" value="" />mp4</label>
            <label><input name="mp4" type="checkbox" value="" />mp4</label>
            <label><input name="mp4" type="checkbox" value="" />mp4</label>
          </div>
        </td>
      </tr>
      <tr>
        <td class="tdheader"> 视频类:</td>
        <td class="tdbody"><div class="rowElem">
          <label>
            <input name="radio1" type="radio" id="radio12" value="radio" checked="checked" />
          </label>
          全选
          <label>
            <input type="radio" name="radio1" id="radio13" value="radio" />
          </label>
          部分选择
          <label>
            <input type="radio" name="radio1" id="radio14" value="radio" />
          </label>
          不选择 </div></td>
      </tr>
      <tr>
        <td class="tdheader"> 音频类:</td>
        <td class="tdbody"><div class="rowElem">
          <label>
            <input name="radio2" type="radio" id="radio15" value="radio" checked="checked" />
          </label>
          全选
          <label>
            <input type="radio" name="radio2" id="radio16" value="radio" />
          </label>
          部分选择
          <label>
            <input type="radio" name="radio2" id="radio17" value="radio" />
          </label>
          不选择 </div></td>
      </tr>
      <tr>
        <td class="tdheader">图像类: </td>
        <td class="tdbody"><div class="rowElem">
          <label>
            <input name="radio3" type="radio" id="radio18" value="radio" checked="checked" />
          </label>
          全选
          <label>
            <input type="radio" name="radio3" id="radio19" value="radio" />
          </label>
          部分选择
          <label>
            <input type="radio" name="radio3" id="radio20" value="radio" />
          </label>
          不选择 </div></td>
      </tr>
      <tr>
        <td class="tdheader">文本类:</td>
        <td class="tdbody"><div class="rowElem">
          <label>
            <input name="radio4" type="radio" id="radio" value="radio" checked="checked" />
          </label>
          全选
          <label>
            <input type="radio" name="radio4" id="radio2" value="radio" />
          </label>
          部分选择
          <label>
            <input type="radio" name="radio4" id="radio8" value="radio" />
          </label>
          不选择 </div></td>
      </tr>
      </tbody>
  </table>
</form>

<script type="text/javascript">
$(document).ready(function() {
	$("input[name='app']").click(function(){
		if($(this).val()=="part"){
			$("#appsection").show();
		}else{
			$("#appsection").hide();			
		}				  
	})					   
});
</script>