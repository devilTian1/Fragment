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

function displayTime(dom,timestamp, propName){
    if (dom.attr('id') == 'localTime') {
        dom.val(currentTime(timestamp));
    } else {
        dom.html(currentTime(timestamp));
    }
    setInterval(function() {
        timestamp += 1000;
        if (dom.attr('id') == 'localTime') {
            dom.val(currentTime(timestamp));
        } else {
            dom.html(currentTime(timestamp));
        }
    },1000);
}

function setServerTime() {
    ajaxSubmitForm($('#setServerTimeForm'), '设置产品名称');
}
