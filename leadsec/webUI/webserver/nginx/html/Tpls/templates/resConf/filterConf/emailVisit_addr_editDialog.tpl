<style type="text/css">
	.floatLeft input[type="radio"]{ width:10px;}
</style>
<form action="Function/resConf/addrBind/emailVisit_addr.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-15 字母、数字、减号、下划线、点的组合)
        </div>
         <div class="row">
          <label for="destip">邮件地此:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />( 如test@sina.com.cn)
        </div>
        
        <div class="row">
        	<div class="column column_25">
                <button class="standard floatLeft" type="button" onClick="addto()"> &gt;&gt;
                </button>
                <br/><br/><br/>
                <button class="standard floatLeft" type="button" onClick="moveto()"> &lt;&lt;
                </button>
            </div>
            <div class="column column_35">
                <{html_options class='multiSelect' size="5" multiple="multiple"
                    name="addrMember[]" id="addrMember"
                    output=$addrMemberArr values=$addrMemberArr}>
	        </div>
        </div>
        
        <div class="row">
            <label>类别:</label>
            <div class="floatLeft">
               <input name="http" type="radio" value="all" checked="checked"/>收件人
            </div>
            <div class="floatLeft">
               <input type="radio" name="http" value="part"/>发件人
            </div>
        </div>
        
        <div class="row">
          <label for="destip">备注:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />
        </div>
   </fieldset>
</form>
<script type="text/javascript">
$(document).ready(function() {
	$(".standard").button();	   
});
</script>