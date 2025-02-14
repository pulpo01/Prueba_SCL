function sobreElBoton(id,imagen){
 	document.getElementById(id).src=imagen;
 	document.getElementById(id).style="cursor:pointer";
}
function fueraDelBoton(id,imagen){
 	document.getElementById(id).src=imagen;
 	document.getElementById(id).style="cursor:pointer";
}

function muestraBlockNone(id)
{
	if(document.getElementById(id).style.display=="none"){
		document.getElementById(id).style.display="block";
	}
	else{
		document.getElementById(id).style.display="none";
	}
}

function delNotShow(){
	document.getElementById("showDel").className="valorCampoInformativo";
}

function delShow(){
	document.getElementById("showDel").className="verde";
}

function tabActiva(id,maxtab){	
	
	var i;

	try
	{
		for (i=1;i<=maxtab;i++) 
		{		
			//oculto todo menos el tab que debo mostrar
			idaux="tab_" + i;
			idtex="tex_" + i;	
			idbkg="bkg_" + i;
		 	document.getElementById(idaux).style.display="none";
			document.getElementById(idtex).className="tabDesactivo";
			document.getElementById(idbkg).className="tab_desactivada";
			
			if (id==idaux){
			 	document.getElementById(id).style.display="block";
				document.getElementById(idtex).className="tabActivo";			
				document.getElementById(idbkg).className="tab_activada";
			}
		}
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En tabActiva()");
	}
}

function MarcarCS( formulario ,valor ) {
	var i
	for (i=0; i < formulario.elements.length; i++) {
				formulario.elements[i].checked =valor.checked	//lo marca
		}
}

function HabilitaTexto(textbox)
{
	if (textbox.disabled){
		textbox.disabled = false;
	}else
	{
		textbox.disabled=true;
	}
}

	function addCommas(nStr)
	{
	    nStr += '';
	    x = nStr.split('.');
	    x1 = x[0];
	    x2 = x.length > 1 ? '.' + x[1] : '';
	    var rgx = /(\d+)(\d{3})/;
	    while (rgx.test(x1)) {
	        x1 = x1.replace(rgx, '$1' + ',' + '$2');
	    }
	    return x1 + x2;
	}


	function controlarAbono(campo,idProducto)
	{
		var e = e || window.event;
		var abono = e.srcElement || e.which;
		onlyFloat(abono.value,2);
		if(abono.value == '')
		{
		
				var total = parseFloat(document.getElementById('importe_'+idProducto).value);		
		
				document.getElementById('total_'+idProducto).style.display="block";
				document.getElementById('total_'+idProducto).innerHTML = addCommas(total);
				return;
		
		}
		else
		{	
			    var total = parseFloat(document.getElementById('importe_'+idProducto).value) + parseFloat(abono.value);		
				total=addCommas(total);
				document.getElementById('total_'+idProducto).style.display="block";
				document.getElementById('total_'+idProducto).innerHTML=total+'';
		}
	} 
