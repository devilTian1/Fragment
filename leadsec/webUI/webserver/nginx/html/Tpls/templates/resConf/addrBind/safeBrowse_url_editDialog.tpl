<form action="Function/resConf/addrBind/safeBrowse_url.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
		<div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 1-19合法字符，9个中文汉字)
        </div>
        
        <div class="row">
          <label for="destip">URL过滤列表:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" class="w200" />
        </div>
        <div class="row">
                <div>说明：</div>
            	<p>1）域名前加.表示该域名以及其子域名，否则表示其本身</p>
            	<p>2）多个域名之间用 ; 隔开</p>
            	<p>3）支持通配符*以及？;</p>
            	<p>4）支持自己定义域名，可分为三部分：首/中/尾,之间可以用通配符代替，如http://*.sina.*.com;</p>
        </div>
        
        <div class="row">
          <label for="destip">备注:</label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 0-253字符. )
        </div>
  </fieldset>
</form>
<style type="text/css">
	fieldset label {
		width:15em;
	}
</style>
<script type="text/javascript">
    $(document).ready(function(){
        validateForm($("#editStaticRouteForm"));
    });
</script>