function openNewQuickDialog() {
    var url   = 'Function/systemManagement/quick/quick.php';
    var data  = {
        tpl : 'systemManagement/quick/editQuick.tpl',
		show: 'yes'
    };
    var title   = '';
    var buttons = {};
	buttons['关闭'] = function() {
        $(this).remove();
    };
    var dialogParams = {
        width   : 840,
        height  : 540,
        buttons : buttons
    };
    showDialogByAjax(url, data, title, dialogParams);
}
function selectTag(showContent,selfObj){
	// 操作标签
	var tag = document.getElementById("tags").getElementsByTagName("li");
	var taglength = tag.length;
	for(i=0; i<taglength; i++){
		tag[i].className = "";
	}
	selfObj.parentNode.className = "selectTag";
	// 操作内容
	for(i=0; i<taglength; i++){
		document.getElementById("tagContent"+i).style.display = "none";
	}
	document.getElementById(showContent).style.display = "block";
}

var Ex=function (o){for(var k in o)this[k]=o[k];return this}
var UI=function (id){return document.getElementById(id)}
var UIs=function (tag){return Ex.call([],this.getElementsByTagName(tag))}
var Each=function (a,fn){for(var i=0;i<a.length;i++)fn.call(a[i],i,a)}
var dhooo=function (ini){
this.bind(ini,this);
this.autoIndex=0;
};
Ex.call(dhooo.prototype,{
bind:function (ini,me){
var dir=ini.dir=='top'?'scrollTop':'scrollLeft',pan=UI(ini.contentID);
var start=function (o){
Each(ini.btns,function(){this.className=''});
o.className=ini.className;
me.autoIndex=o.index;
me.begin(o.index,pan,ini.len,dir);
};
pan.onmouseover=function (){me.stop=true};
Each(ini.btns,function (i){
this.index=i;
this.onmouseover=function (){me.stop=true;start(this)};
pan.onmouseout=this.onmouseout=function(){me.stop=false}
});
var auto=function(){
if(!me.stop){
me.autoIndex=me.autoIndex==4?0:++me.autoIndex;
start(ini.btns[me.autoIndex]);
}
};
if(ini.auto)this.autoPlay=window.setInterval(auto,1000);
}
,begin:function (i,o,len,dir){
(function (me){
clearInterval(me.only);
me.only=setInterval(function (){
var diff=(i*len-o[dir])*0.1;
o[dir]+=Math[diff>0?'ceil':'floor'](diff);
if(diff==0)clearInterval(me.only);
},10)
})(this)
}
})

function initdbhooo(){
	new dhooo({
	btns:UIs.call(UI('myTab_btns'),'LI')
	,className:'hot'
	,contentID:'main'
	,len:760
	});}