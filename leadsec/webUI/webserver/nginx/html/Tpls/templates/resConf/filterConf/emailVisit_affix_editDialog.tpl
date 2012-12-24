<form action="Function/resConf/addrBind/emailVisit_affix.php" method="POST" id="editForm" onSubmit="return false;">
    <input type="hidden" name="type" value="<{$type|default: 'add'}>"/>
    <input type="hidden" name="id" value="<{$res.id}>"/>
     <fieldset>
        <!--<legend></legend>-->
        <div class="row">
          <label for="destip">名称:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(1-15 字母、数字、减号、下划线、点的组合)
        </div>
         <div class="row">
          <label for="destip">扩展名:<em class="required">*</em></label>
          <input type="text" name="destip" value="<{$res.destip}>" />(如.exe)
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