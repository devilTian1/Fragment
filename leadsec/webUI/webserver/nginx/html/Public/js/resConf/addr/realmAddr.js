function selectedOption() {
    $('#DynamicAddrList option').attr('selected', 'selected');
    $('#staticAddrList option').attr('selected', 'selected');
}

function openAddRealmAddrDialog() {
    var url   = 'Function/layout/showDialog.php';
    var title = '域名地址维护';
    var data  = {
        tpl : 'resConf/addr/editRealmAddrDialog.tpl'
    };
    var buttons = {};
    buttons['添加下一条'] = function() {
        if ($('#editRealmAddrForm').valid()) {
            selectedOption();
            openAddRealmAddrDialog();
            ajaxSubmitForm($('#editRealmAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['确定'] = function() {
        if ($('#editRealmAddrForm').valid()) {
            selectedOption();
            ajaxSubmitForm($('#editRealmAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 500,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openEditRealmAddrDialog(id) {
    var url  = 'Function/resConf/addr/realmAddr.php';
    var data = {
        tpl    : 'resConf/addr/editRealmAddrDialog.tpl',
        specId : id
    };
    var title   = '域名地址维护';
    var buttons = {};
    buttons['确定'] = function() {
        if ($('#editRealmAddrForm').valid()) {
            selectedOption();
            ajaxSubmitForm($('#editRealmAddrForm'), '结果');
            freshTableAndPage();
            $(this).remove();
        }
    };
    buttons['取消'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 620,
        height  : 550,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}

function openDelRealmAddrDialog() {

}

function addStaticAddrList() {
    var newStaticAddrDom = $('#addStaticAddr');
    if ($("#editRealmAddrForm").validate().element(newStaticAddrDom) === true) {
        var isDuplicated = false;
        var ip           = newStaticAddrDom.val()
        var appendToDom  = $('#staticAddrList');
        newStaticAddrDom.val('');
        appendToDom.children('option').each(function() {
            if (ip === $(this).val()) {
                isDuplicated = true;
                return false;
            }
        });
        if (isDuplicated === false) {
            var optionCount = appendToDom.children('option').length;
            $('<option class="multiSelect option" value="' + ip +
                '" id="staticAddrList-' + optionCount + '">' + ip
                +'</option>').appendTo(appendToDom);
        }
    }
}

function deleteStaticAddr() {
    $('#staticAddrList option:selected').remove();
}

function cleanAllStaticAddr() {
    var staticAddrListDom = $('#staticAddrList');
    staticAddrListDom.html('');
}

function freshTableAndPage() {
    var url = 'Function/resConf/addr/realmAddr.php';
    freshTable(url, $('#realmAddrTable'));
    freshPagination(url, $('.pager'));
}
