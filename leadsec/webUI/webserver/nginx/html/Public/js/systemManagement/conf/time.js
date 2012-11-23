function displayTime(dom,timestamp){
    if(!timestamp){
        function currentTime(){
            var d = new Date(),str = '';
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
            str =  yy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
            return str;
            }
            setInterval(function(){
                var curTime = currentTime();
                dom.html(curTime);
                },1000);
            } 

    if(timestamp)
        {   
            var i = 0 ;
            function currentServerTime(){
                var d = new Date(timestamp + 1000*i),str = '';
                i = i + 1;
                var yy = d.getYear();
                if (yy<1900) {
                yy = yy+1900;
                }
                var MM = d.getMonth()+1;
                if (MM<10) {
                MM = '0' + MM;
                }
                var dd = d.getDate();
                if  (dd<10) {
                dd = '0' + dd;
                }
                var hh = d.getHours();
                if(hh<10) {
                hh = '0' + hh;
                }
                var mm = d.getMinutes();
                if(mm<10) {
                mm = '0' + mm;
                }
                var ss = d.getSeconds();
                if(ss<10) {
                ss = '0' + ss;
                }
                str =  yy + "-" + MM + "-" + dd + " " + hh + ":" + mm + ":" + ss;
                return str;
                }
                setInterval(function(){
                var curTime = currentServerTime();
                dom.html(curTime);
                },1000);    
        }
}

	
