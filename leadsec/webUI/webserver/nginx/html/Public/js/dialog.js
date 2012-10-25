function openDialog() {
    $("#dialogForm").dialog({
        autoOpen: false,
        height: 300,
        width: 500,
        modal: true,
        title: '客户端普通访问添加',
        buttons: {
            'Confirm': function() {alert('Confirm');},
            'Cancel' : function() {
                $(this).dialog('close');
                $(this).dialog('destroy');
                $(this).remove();
            }
        }
    });
    $("#dialogForm").dialog("open");
}
