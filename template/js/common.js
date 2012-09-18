function changeClientId(id){
	var height=parent.document.documentElement.clientHeight-168;
	document.getElementById(id).style.height=height+'px';
}
function alert(s){
	Dialog.alert(s)
}

function win(url,width,height,title)
{
	var diag = new Dialog();
	if(width)diag.Width = width;
	if(height)diag.Height = height;
	if(title) diag.Title = title;
	diag.URL = url;

	diag.show();
}
// JavaScript Document
function rsDel(url,msg)
{
	if(!msg) msg='警告：您确认要删除吗？'
	Dialog.confirm(msg,function(){window.location.href=url;});
}

function rsEdit(url,width,height,title,msgtitle,message)
{
	var diag = new Dialog();
	if(!width) width=600;
	if(!height) height=400;
	if(title) diag.Title = title;
	if(msgtitle) diag.MessageTitle=msgtitle
	if(message) diag.Message = message;
	

	diag.Width = width;
	diag.Height = height;
	diag.URL = url;
	diag.OKEvent=function(){
		diag.innerDoc.getElementById('submitbt').click();
		diag.submited=true;};
	diag.OnLoad=function(){
		if(diag.submited){
			diag.opener.location.reload();
            try{
				diag.close();
            }catch(e){}
		}
	};
   diag.show();
}
