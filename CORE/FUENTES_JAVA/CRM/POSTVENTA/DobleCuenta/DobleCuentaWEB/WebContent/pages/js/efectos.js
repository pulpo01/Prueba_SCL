var ProductosIniciales="";
function detallaPaquete(codPaq){
	if (document.getElementById(codPaq).style.display!="none")	{
		document.getElementById(codPaq).style.display="none";
		return true;
	}
	if (document.getElementById(codPaq).style.display=="none")	{
		document.getElementById(codPaq).style.display="block";
		return true;
	}
}

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
	
	var i
	for (i=1;i<=maxtab;i++) {		
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

function MarcarCS( formulario ,valor ) {
	var i
	for (i=0; i < formulario.elements.length; i++) {
				formulario.elements[i].checked =valor.checked	//lo marca
		}
}








function HabilitaTexto(textbox,checkeo,idproducto)
{
	if (checkeo.checked){
		textbox.disabled=false;
	}
	else
	{
		textbox.disabled=true;
	}	
}

var listProductos = Array();
var pro=0;

function agregarPro(idpro){
	for (i=0; i < pro; i++) {
		if (listProductos[i]==idpro){
			return false;
		}
	}	
	pro=pro+1;
	listProductos[pro]=idpro;
}

function quitarPro(idpro){
	for (i=0; i < pro; i++) {
		if (listProductos[i]==idpro){
			listProductos[i]='';
		}
	}		
}

function getProductos(){
	var todos
	todos='';
	for (i=0; i < pro; i++) {
		if (listProductos[i]!=''){
			if (todos==''){
				todos = listProductos[i];				
			}
			else
			{
				todos = todos + '|' + listProductos[i];
			}
		}
	}	
	return todos;	
}

function setProductos(idpro){
//	if (document.getElementById('bitacora').value!='')
//	{
//		document.getElementById('bitacora').value =	document.getElementById('bitacora').value + '|' + idpro;
//	}
//	else
//	{
		document.getElementById('bitacora').value =	idpro;
//	}
}

function gestionProducto(textbox,checkeo,idproducto,isPaquete)
{	
//	document.getElementById("alerta").height=16;
	var ProductoKey;
	var valorActual;
	var valorInicial =  document.getElementById("inicial_" + idproducto).value;  
	var valorMaximo  =  document.getElementById("maxcon_" + idproducto).value;   

	try{
	  valorActual = document.getElementById("maximo_"+idproducto).value;
	}catch(e){
	  valorActual = document.getElementById("maximoPaq_"+idproducto).value;
	}

	try{
		ProductoKey='O.' + document.getElementById('codPadre_' + idproducto).value + '.' + document.getElementById('codigo_' + idproducto).value;
		//producto
		if (document.getElementById('codPadre_' + idproducto).value!=idAbonado)
		{
			checkeo.checked = !checkeo.checked;			
			if (checkeo.checked)
			{
				document.getElementById('boton_' + idproducto).style.display="block";
				document.getElementById('boton_inicial_' + idproducto).style.display="none";
			}
			else
			{
				document.getElementById('boton_' + idproducto).style.display="none";
				document.getElementById('boton_inicial_' + idproducto).style.display="block";
			}
			return false;
		}
	}
	catch(err)
	{
		ProductoKey='O.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto).value;
		//paquete
	}


	if (isPaquete==0){
		//conserva el error antes de cambiar
		if (checkeo.checked){
			textbox.disabled=false;
			listProductos[pro]=ProductoKey;
			agregarPro(ProductoKey);
			document.getElementById('boton_'+idproducto).style.display="block";
			document.getElementById('boton_inicial_'+idproducto).style.display="none";				
		}
		else
		{
			textbox.disabled=true;
			// si lo descheckeo volver al valor inicial siempre cuando la cantidad maxima sea superada
			document.getElementById("maximo_" + idproducto).value = validaMaximo(valorActual,valorInicial,valorMaximo);
			document.getElementById('boton_'+idproducto).style.display="none";
			document.getElementById('boton_inicial_'+idproducto).style.display="block";
			listProductos.splice(ProductoKey);
			quitarPro(ProductoKey);
		}				
	}
	else
	{
		//validacion por Paquete	
		if (checkeo.checked){
			textbox.disabled=false;
			listProductos[pro]=ProductoKey;
			agregarPro(ProductoKey);
		}
		else
		{
			textbox.disabled=true;
			listProductos.splice(ProductoKey);
			quitarPro(ProductoKey);
		}				
		//validacion por productos del paquete
		var i
		formulario = textbox.form;
		for (i=0; i < formulario.elements.length; i++) {
			//chequeo solo los hijos del producto
			//alert(formulario.elements[i].id + ' = ' + idproducto);
			if (formulario.elements[i].id==document.getElementById('codigo_' + idproducto).value)
			{				
				formulario.elements[i].checked =checkeo.checked	//lo marca
			
//				idProductoDTO = document.getElementById(formulario.elements[i+2].name).value;
//				listProductos[pro]=idproducto;//guardo los hijos

				var texto1
				var check1
				var hidde1
				var idProductoHijo

				//formulario.elements[i+1].value <-- nombre de los textos
				//formulario.elements[i].value;  <-- nombre de los check
				//formulario.elements[i-3].value;  <-- nombre del idproducto
				texto1 = formulario.elements[i+1];
				check1 = formulario.elements[i];
				hidde1 = formulario.elements[i-3];
				idProductoHijo = document.getElementById(formulario.elements[i+4].name).value;
				//alert('Cantidad :' + texto1.value + '\n checkeado :' + check1.value + '\n codigo :'+hidde1.value );
				
				if (check1.checked)
				{
//					document.getElementById(formulario.elements[i+1].name).disabled=false;
					texto1.disabled=false;
					document.getElementById('boton_' + idProductoHijo).style.display="block";
					document.getElementById('boton_inicial_' + idProductoHijo).style.display="none";
				}
				else
				{
//					document.getElementById(formulario.elements[i+1].name).disabled=true;
					texto1.disabled=true;
					document.getElementById('boton_' + idProductoHijo).style.display="none";
					document.getElementById('boton_inicial_' + idProductoHijo).style.display="block";
				}
				// no agrego los productos hijos al listado de bitacora dado que si se selecciono el padre
				// todos los hijos en NavegacionWEB.java seran seleccionados..
			}
		}		
	}
	document.getElementById('bitacora').value=getProductos();
	
}

var codPadre;
var idAbonado;

function setIdAboando(idAbonAux){
//	alert('Seteando' + codPadreAux);
	idAbonado=idAbonAux;
}


function setCodPadre(codPadreAux){
//	alert('Seteando' + codPadreAux);
	codPadre=codPadreAux;
}

function cierraPaq(codigoPadreNew,isPaquete){
	if (codPadre==codigoPadreNew)
	{
		document.write('</table>');
		document.write('</tr>');
		document.write('</td>');		

	}
	if (isPaquete==1)
	{
		codPadre=codigoPadreNew;
	}
}

function descripcionTipo(cod){		
		if (cod=='PFRC'){
			document.write('Frecuentes');
			return true;
		}
		if (cod=='PAFN'){
			document.write('Afines');
			return true;
		}
		if (cod=='PMOD'){
			document.write('Pasa Módulos');
			return true;
		}
		if (cod=='PAFN'){
			document.write('Numeros afines');
			return true;
		}
		if (cod=='ABNO'){
			document.write('Bono Altamira');
			return true;
		}	
		if (cod=='ALST'){
			document.write('Lista Altamira');
			return true;
		}		
		if (cod=='PACK'){
			document.write('Lista productos');
			return true;
		}		
}

function validaMaximo(valorActual,valorInicial,valorMaximo){
	if (valorActual>valorMaximo)
	{
		return valorInicial;
	}
	else
	{
		return valorActual;
	}
}