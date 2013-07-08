function currentTime(timestamp) {
    var result = '';
    var d = new Date();
    if (timestamp) {
        d = new Date(timestamp);
    }
    var yy = d.getYear();
    if (yy<1900) {
        yy = yy+1900;
    }
    var MM = d.getMonth()+1;
    if (MM<10) { 
        MM = '0' + MM;
    }
    var dd = d.getDate();
    if (dd<10) { 
        dd = '0' + dd;
    }
    var hh = d.getHours();
    if (hh<10) {
         hh = '0' + hh;
    }
    var mm = d.getMinutes();
    if (mm<10) {
         mm = '0' + mm;
    }
    var ss = d.getSeconds();
    if (ss<10) {
         ss = '0' + ss;
    }
    result =  yy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
    return result;
}

function modifyDom(dom, timestamp) {
    if (dom.attr('id') == 'localTime') {
        dom.val(currentTime(timestamp));
    } else {
        dom.html(currentTime(timestamp));
    }
}

function displayTime(dom, timestamp) {
    modifyDom(dom, timestamp);
    return setInterval(function() {
        timestamp += 1000;
        modifyDom(dom, timestamp);
    },1000);
}

function setServerTime() {
   if ($('#setServerTimeForm').valid()){
    var afterSuccessCallback = function(result, textStatus) {
        var timestamp = parseInt(result.msg) * 1000;
        if (oldServerTime != '') {
            clearInterval(oldServerTime);
        }
        displayTime($('#server'), timestamp);
        dialog.setContent($('<p>修改成功。</p>'));
    };
        ajaxSubmitForm($('#setServerTimeForm'),'时间同步',undefined,
			undefined,afterSuccessCallback);
   }
}

function setNTPServer() {
    if ($('#syncTimeForm').valid()) {
        ajaxSubmitForm($('#syncTimeForm'), '结果');
    }
}

function syncTime() {
    var buttons = {};
    buttons[getMessage('Ok')] = function() {
        $(this).remove();
    }
    var dialogOptions = {
        width : 250,
        height: 170,
        buttons: buttons
    };
    showDialogByAjax('Function/systemManagement/conf/time.php',
        {syncTime: true}, '结果', dialogOptions);
}
