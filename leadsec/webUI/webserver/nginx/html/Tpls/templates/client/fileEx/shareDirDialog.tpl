<link rel="stylesheet" href="Public/default/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<table class="column_95 textMid tablesorter">
    <thead>
        <tr>
            <th class="column_20">任务号</th>
            <th class="column_20">发送/接收</th>
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
                接收
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
    $(document).ready(function() {
        var zNodes =[<{$zNodes}>];
        $.fn.zTree.init($("#fileTree"), setting, zNodes);
    });
    
    function getFileSize(path) {
        var dialog = loadingScreen(getMessage('Result'));
        var data = {
            path: path
        };    
        var params = {
            type: 'POST',
            dataType: 'JSON',
            success: function(result, textStatus) {                
                var buttons = {};
                buttons[getMessage('Ok')] = function() {
					$(this).remove();
                };
                var content = result.msg;
                var dialogParams = {
                    width: 250,
                    height: 200,
                    buttons: buttons,
                    position: jQuery.getDialogPosition(250,200)
                };
                dialog.setContent("大小为:"+content);
                dialog.setOptions(dialogParams); 
            }   
        };
        loadAjax('Function/client/fileEx/shareDir.php', data, params);
    }

    function addNewNodes(newNode, dom) {
        var treeObj = $.fn.zTree.getZTreeObj("fileTree");
        if (dom != undefined) {
            var id   = dom.parent().attr('id');
            var node = treeObj.getNodeByTId(id);
            treeObj.addNodes(node.getParentNode(), newNode);
        } else {
            treeObj.addNodes(null, newNode);
        }
    }

    function hideMoreTag(dom) {
        var treeObj = $.fn.zTree.getZTreeObj("fileTree");
        var id   = dom.parent().attr('id');
        var node = treeObj.getNodeByTId(id);
        treeObj.removeNode(node);
    }

    function update(dom, dir, offset) {
        var dialog = loadingScreen('');
        var url  = 'Function/client/fileEx/shareDir.php';
        var data = {
            update: '1',
            dir: dir,
            offset: offset
        };
        var params = {
            dataType: 'json',
            success: function(result) {
                dialog.close();
                var nodes = result.msg;
                for (var i in nodes) {
                    nodes[i] = eval('(' + nodes[i] + ')');
                }
                addNewNodes(nodes, dom);
                hideMoreTag(dom);
            }
        };
        loadAjax(url, data, params);
        return false;
    }
</script>
