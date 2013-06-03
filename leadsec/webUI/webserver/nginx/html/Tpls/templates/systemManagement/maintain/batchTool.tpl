<table class="column_95">
   <caption>
		历史记录
  </caption>
	<tr>
		<td width="100%">
			<textarea id="textareaA" cols="45" rows="8" 
			 readonly="readonly">
			</textarea>
		</td>
		<td>
        	<input class="inputbtn standard" type="submit" onclick="cleanUp()" value="清空"/>
			<br/><br/>
			<form class="inline" action="Function/systemManagement/maintain/batchTool.php" method="POST">
			<input type="hidden" name="action" value="down"/>
			<input class="inputbtn standard" type="submit" value="导出"/>
			</form><br/><br/>
			<input class="inputbtn standard" type="submit" onclick="show()" value="刷新"/>
		</td>
	</tr>
</table>
  

<table class="column_95">
	<caption>
	命令批处理
    </caption>
		<tr>
			<td width="100%">
				<form class="inline" action="Function/systemManagement/maintain/batchTool.php" 
					id="runBatchCmdForm" method="POST" onSubmit="return false;">
					<textarea cols="45" rows="5" name="batchCmd" id="textareaB" onkeyup="ModifyStyle()"></textarea>
				</form>
			</td>
			<td>
				<input type="button" class="inputbtn standard" id="rewrite" onclick="reWrite()" value="重写"/>
					<br /><br />
				<input type="button" class="inputbtn standard" id="upload" onClick="runBatchCmd()" value="提交"/>
					
			</td>
			
		</tr>

		<tr>
			<td colspan="2" width="100%" class="tdbody">
				导入命令批处理文件
				<form class="inline" action="Function/systemManagement/maintain/batchTool.php"
					id="batchToolExportForm" method="POST" onSubmit="return false;">
					<input name="batchToolExportFile" type="file" id="file"/>
					<input type="hidden" name="action" value="uploadBatchFile">
       				<input class="inputbtn standard" type="button" onclick="exportBatchToolFile()" value="导入"/>
						
				</form>
			</td>
		</tr> 
		<tr>
			<td colspan="2">
			<form class="inline" action="Function/systemManagement/maintain/batchTool.php" 
				id="performBatchProcessingForm" method="POST" onSubmit="return false;">
				<input type="hidden" name="action" value="performBatchProcessing" />
				<input type="button" class="inputbtn standard" id="performBat" onclick="performBatchProcessingForm()" value="执行批处理" />
			</form>
			</td>
		</tr>
</table>
<script type="text/javascript" src="Public/js/systemManagement/maintain/batchTool.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi(); 
    function testTextAreaB(){
		ModifyStyle();
		setTimeout(function(){
				testTextAreaB();		
						},20);
	}
	testTextAreaB();
	validateForm($("#batchToolExportForm"));
	show();
});
</script>