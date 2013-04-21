<{include file='layout/search.tpl' tableId='allowedFileTable'}>
<form action="Function/client/msgTrans/callowedFile.php" method="POST"
    id="filelistForm" onSubmit="return false;">
    <input type="hidden" name="ctl" value="1">
    <label for="namefilter">
        <{if $status.namefilter_status eq Y}>
	    	<input type="checkbox" checked="checked" onClick="switchFileChk('off')" name="filelist" id="filelist">
	        <input id="action_file" type="hidden" name="action_file" value="off"/>
	    <{/if}>
	    <{if $status.namefilter_status eq N}>
	      	<input type="checkbox"   onClick="switchFileChk('on')" name="filelist" id="filelist">
	        <input id="action_file" type="hidden" name="action_file" value="on"/>
	    <{/if}>
        启用文件名控制
    </label>
</form>
<form action="Function/client/msgTrans/callowedFile.php" method="POST"
    id="binlistForm" onSubmit="return false;">
    <label for="binfile">
       <{if $status.bin_file_status eq A}>
	    	<input type="checkbox" checked="checked" onClick="switchBinChk('off')" name="binlist" id="binlist">
	        <input id="action_bin" type="hidden" name="action_bin" value="off"/>
	    <{/if}>
	    <{if $status.bin_file_status eq F}>
	      	<input type="checkbox"   onClick="switchBinChk('on')"  name="binlist" id="binlist">
	        <input id="action_bin" type="hidden" name="action_bin" value="on"/>
	    <{/if}>
        允许二进制文件
    </label>
</form>
<table class="column_95 textMid tablesorter" id="allowedFileTable">
    <caption>文件名控制</caption>
    <thead>
        <tr>
            <th class="column_20" >序号</th>
            <th class="column_60" name="filename">允许以下文件名</th>
            <th class="column_20">操作</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="4">Loading... ...</td>
        </tr>
    </tbody>
</table>
<button class="standard floatLeft" style="position: static"
    onclick="openNewAllowedFileDialog()">添加
</button>
<div class="pager floatRight">
    <{include file='layout/pagination.tpl'
        func='Function/client/msgTrans/callowedFile.php'}>
</div>
<script type="text/javascript" src="Public/js/client/msgTrans/callowedFile.js"></script>
<script type="text/javascript"> 
    $(document).ready(function() {
        renderStandardUi();
        freshTable('Function/client/msgTrans/callowedFile.php',
            $('#allowedFileTable'), 'ORDER BY filename ASC LIMIT 10');
        sortTableInit($('#allowedFileTable'), {0: {sorter: false},2: {sorter: false}}, [[1,0]]);
    });
</script>
