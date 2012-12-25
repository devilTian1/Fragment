<table class="column_95">
   <caption>
		历史记录
  </caption>
	<tr>
		<td style="width:100%">
			<textarea name="textarea" id="textarea" cols="45" rows="8" 
			style="width:80%;background:#cccccc" readonly="readonly">
			</textarea>
		</td>
		<td>
			<button class="inputbtn standard" name="empty">
				清空
			</button><br /><br />
			<button class="inputbtn standard" name="export">
				导出
			</button><br /><br />
			<button class="inputbtn standard" name="refresh">
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
			<td style="width:100%">
				<textarea name="textarea2" id="textarea2" cols="45" rows="5" 
				style="width:80%">
				</textarea>
			</td>
			<td>
				<button class="inputbtn standard" name="rewrite">
					重写
				</button><br /><br />
				<button class="inputbtn standard" name="submit">
					提交
				</button>
			</td>
		</tr>
		<tr>
			<td colspan="2" width="100%" class="tdbody">
				导入命令批处理文件
				<input name="upload" type="file" >
       			<button class="inputbtn standard" name="import">
					导入
				</button>
			</td>
		</tr> 
		<tr>
			<td colspan="2" style="background:#cccccc">
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
<script type="text/javascript">
$(document).ready(function() {
	renderStandardUi(); 
});
</script>