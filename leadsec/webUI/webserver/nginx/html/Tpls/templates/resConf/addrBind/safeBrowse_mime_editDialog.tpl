<style type="text/css">
	.sectionDiv hr{ color:#09F;}
	.sectionDiv label{ width:120px; float:left; display:block;}
	.sectionDiv label input[type="checkbox"]{ width:10px;}
	.floatLeft input[type="radio"]{ width:10px;}
</style>
<form action="Function/resConf/addrBind/safeBrowse_mime.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 1-19合法字符，9个中文汉字)
        </div>
        
        <div class="row">
            <label>应用程序:<em class="required">*</em></label>
            <div class="floatLeft">
               <input type="radio" name="app" value="all"/>全选
            </div>
            <div class="floatLeft">
               <input type="radio" name="app" value="part"/>部分选择
            </div>
            <div class="floatLeft">
                <input type="radio" name="app" value="not"/>不选择
            </div>
        </div>
        <div class="row">
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
              <br class="clearFloat"/>
             <hr />
         </div>
       </div>
       <div class="row">
            <label>视频类:<em class="required">*</em></label>
            <div class="floatLeft">
               <input type="radio" name="video" value="all"/>全选
            </div>
            <div class="floatLeft">
               <input type="radio" name="video" value="part"/>部分选择
            </div>
            <div class="floatLeft">
                <input type="radio" name="video" value="not"/>不选择
            </div>
        </div>
        <div class="row">
         <div id="videosection" class="sectionDiv hide">
              <hr />
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <br class="clearFloat"/>
             <hr />
         </div>
        </div>
        
        <div class="row">
            <label>音频类:<em class="required">*</em></label>
            <div class="floatLeft">
               <input type="radio" name="audio" value="all"/>全选
            </div>
            <div class="floatLeft">
               <input type="radio" name="audio" value="part"/>部分选择
            </div>
            <div class="floatLeft">
                <input type="radio" name="audio" value="not"/>不选择
            </div>
        </div>
        <div class="row">
         <div id="audiosection" class="sectionDiv hide">
              <hr />
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <br class="clearFloat"/>
             <hr />
         </div>
        </div>
        
        <div class="row">
            <label>图像类:<em class="required">*</em></label>
            <div class="floatLeft">
               <input type="radio" name="image" value="all"/>全选
            </div>
            <div class="floatLeft">
               <input type="radio" name="image" value="part"/>部分选择
            </div>
            <div class="floatLeft">
                <input type="radio" name="image" value="not"/>不选择
            </div>
        </div>
        <div class="row">
         <div id="imagesection" class="sectionDiv hide">
              <hr />
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <br class="clearFloat"/>
             <hr />
         </div>
        </div>
        
         <div class="row">
            <label>文本类:<em class="required">*</em></label>
            <div class="floatLeft">
               <input type="radio" name="txt" value="all"/>全选
            </div>
            <div class="floatLeft">
               <input type="radio" name="txt" value="part"/>部分选择
            </div>
            <div class="floatLeft">
                <input type="radio" name="txt" value="not"/>不选择
            </div>
        </div>
        <div class="row">
         <div id="txtsection" class="sectionDiv hide">
              <hr />
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <label><input name="mp4" type="checkbox" value="" />mp4</label>
              <br class="clearFloat"/>
             <hr />
         </div>
        </div>
  </fieldset>
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
	$("input[name='video']").click(function(){
		if($(this).val()=="part"){
			$("#videosection").show();
		}else{
			$("#videosection").hide();			
		}				  
	})	
	$("input[name='image']").click(function(){
		if($(this).val()=="part"){
			$("#imagesection").show();
		}else{
			$("#imagesection").hide();			
		}				  
	})	
	$("input[name='audio']").click(function(){
		if($(this).val()=="part"){
			$("#audiosection").show();
		}else{
			$("#audiosection").hide();			
		}				  
	})	
	$("input[name='txt']").click(function(){
		if($(this).val()=="part"){
			$("#txtsection").show();
		}else{
			$("#txtsection").hide();			
		}				  
	})	
});
</script>