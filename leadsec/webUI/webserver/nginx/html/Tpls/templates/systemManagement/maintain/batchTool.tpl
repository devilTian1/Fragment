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
			<button class="inputbtn standard" type="submit" onclick="cleanUp()">
				清空
			</button><br/><br/>
			<form class="inline" action="Function/systemManagement/maintain/batchTool.php" method="POST">
			<input type="hidden" name="action" value="down"/>
			<button class="inputbtn standard" type="submit">
				导出
			</button>
			</form><br/><br/>
			<button class="inputbtn standard" type="submit" onclick="show()">
				刷新
			</button>
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
				<button class="inputbtn standard" id="rewrite" onclick="reWrite()">
					重写
				</button><br /><br />
				<button class="inputbtn standard" id="upload" type="button" onClick="runBatchCmd()">
					提交
				</button>
			</td>
			
		</tr>

		<tr>
			<td colspan="2" width="100%" class="tdbody">
				导入命令批处理文件
				<form class="inline" action="Function/systemManagement/maintain/batchTool.php"
					id="batchToolExportForm" method="POST" onSubmit="return false;">
					<input name="batchToolExportFile" type="file" id="file"/>
					<input type="hidden" name="action" value="uploadBatchFile">
       				<button class="inputbtn standard" type="button" onclick="exportBatchToolFile()">
						导入
					</button>
				</form>
			</td>
		</tr> 
		<tr>
			<td colspan="2">
				<button class="inputbtn standard" name="performBatchProcessing" 
				id="performBatchProcessing">
					执行批处理
				</button>
				<button class="inputbtn standard" name="cancelExecution" 
				id="cancelExecution">
					取消执行
				</button>
			</td>
		</tr>
</table>
<script type="text/javascript" src="Public/js/systemManagement/maintain/batchTool.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi(); 
    ModifyStyle();
	validateForm($("#batchToolExportForm"));
	show();
});
</script>