
function bloque(id)
{
	if(document.getElementById(id).style.display=="none"){
		document.getElementById(id).style.display="block";
		document.getElementById('i_'+id).src="img/abierto.gif";
	}
	else{
		document.getElementById(id).style.display="none";
		document.getElementById('i_'+id).src="img/cerrado.gif";
	}
}
function cierratodo(){
	if (document.getElementById("paso1").style.display!="none")	{
		document.getElementById("paso1").style.display="none";
	}
	if (document.getElementById("paso2").style.display!="none")	{
		document.getElementById("paso2").style.display="none";
	}
}
function control(id,video){
	document.getElementById(id).src=video;
}

function bloquex(id){
	cierratodo();
	bloque(id);
}