function confirmImport() {
    if ($('#CACertForm').valid()) {
        var dialog  = loadingScreen('导入新证书');
        var buttons = {};
        buttons[getMessage('Confirm')] = function() {
            importCACert();
            $(this).remove();
        };
        buttons[getMessage('Cancel')]  = function() {
            $(this).remove();
        };
        var dialogParams = {
            width: 300,
            height: 160,
            buttons: buttons
        };
        dialog.setContent("<p>请在导入证书后等待5秒，重启浏览器，使新证书生效.</p>");
        dialog.setOptions(dialogParams);
    }
}
