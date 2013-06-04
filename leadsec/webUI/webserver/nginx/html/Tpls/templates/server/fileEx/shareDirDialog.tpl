<link rel="stylesheet" href="Public/default/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<table class="column_95 textMid tablesorter">
    <thead>
        <tr>
            <th class="column_20">任务号</th>
            <th class="column_20">发送/接受</th>
            <th class="column_20">服务器IP</th>
            <th class="column_20">服务器共享名</th>
            <th class="column_20">文件系统</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td><{$r.task_id}></td>
            <td>
                <{if $r.mode === 'C'}>
                发送
                <{else}>
                接受
                <{/if}>
            </td>
            <td><{$r.ip}></td>
            <td><{$r.share_name}></td>
            <td><{$r.fs}></td>
        </tr>
    </tbody>
</table>
<div id="fileTree" class="ztree"></div>
<script type="text/javascript" src="Public/js/jquery/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript">
    var setting = {
        data: {
            key: {
                title: 't'
            }
        }
    };
    var zNodes =[<{$zNodes}>];
    $(document).ready(function(){
        $.fn.zTree.init($("#fileTree"), setting, zNodes);
        var t;
		/*
        $('#fileTree a').live('mouseover',function() {
            var dom = $(this);
            t = setTimeout(function() {
                var data   = {
                    path: dom.attr('title')
                };
                var params = {
                    type: 'POST',
                    dataType: 'JSON',
                    success: function(result) {
                        dom.tooltip({content: result.msg}).tooltip('open');
                    }
                };
                loadAjax('Function/server/fileEx/shareDir.php', data, params);
            }, 1000);
        }).live('mouseout', function() {
            if (t != undefined) {
                window.clearTimeout(t);
            }
        });
		*/
		$("#fileTree a").bind('click',function(){
			var dom = $(this);
			var data = {
				path: dom.attr('title')
			};
			var params = {
				type: 'POST',
				dataType: 'JSON',
				success: function(result, textStatus) {
					var content = result.msg;
					var dialog  = loadingScreen('结果');
					var dialogParams = {
						width: 250,
						height: 200,
						position: jQuery.getDialogPosition(250,200)
					};
					dialog.setContent("文件大小为:"+content);
					dialog.setOptions(dialogParams); 
				}
			};
			loadAjax('Function/client/fileEx/shareDir.php', data, params);
		});
    });
</script>
