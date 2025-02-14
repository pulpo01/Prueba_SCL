var ProductosIniciales="";
var productoDePaquete=false;
var tablaAbierta = false;
var listProductos = Array();
var pro=0;

function detallaPaquete(codPaq)
{
	if (document.getElementById(codPaq).style["display"]!="none")	
	{
		document.getElementById(codPaq).style["display"]="none";
		return true;
	}
	if (document.getElementById(codPaq).style["display"]=="none")	
	{
		document.getElementById(codPaq).style["display"]="block";
		return true;
	}
}

function sobreElBoton(id,imagen)
{
 	document.getElementById(id).src=imagen;
 	document.getElementById(id).style["cursor"]="pointer";
}
function fueraDelBoton(id,imagen){
 	document.getElementById(id).src=imagen;
 	document.getElementById(id).style["cursor"]="pointer";
}

function muestraBlockNone(id)
{
	if(document.getElementById(id).style["display"]=="none"){
		document.getElementById(id).style["display"]="block";
	}
	else{
		document.getElementById(id).style["display"]="none";
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
	 	document.getElementById(idaux).style["display"]="none";
		document.getElementById(idtex).className="tabDesactivo";
		document.getElementById(idbkg).className="tab_desactivada";
		
		if (id==idaux){
		 	document.getElementById(id).style["display"]="block";
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

function HabilitaTexto(textbox,checkeo, idPlan)
{
    if ('2'==idPlan) {
    	textbox.disabled=true;
    }else {
    	if (checkeo.checked){
			textbox.disabled=false;
		} else {
			textbox.disabled=true;
		}
    }
	
}

function HabilitaTextoPaquete(textbox,checkeo,idproducto)
{
	
		textbox.disabled=true;
		
}


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

function syncSelect(Select, theValue)
{
	laFila = 0;
	elFin = Select.length;
	for(i = 0; i < elFin; i++)
	if( Select.options[i].value == theValue)
	{
		laFila = i;
		Select.disabled = false;
		break;
	}
	Select.selectedIndex = laFila;	
}

function verificarSelect(Select, theValue)
{
	try{
	  	if(isNaN(theValue) || parseInt(theValue) < 1){
			//Select.options[0].value = 'Sin Lista LC';
		}
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En verificarSelect1()");
	}

}

function setValorSeleccionados()
{

	var x = document.getElementsByName("combo_lc_D");
		
	var listProductosDef = '';
	var montoslcD = ''; 
	if(x.length > 0)
	{    
		var campos = document.ProductoFormContratados.combo_lc_D;
		
		if(x.length == 1)
		{
			listProductosDef += campos.value + "|";
			montoslcD = document.ProductoFormContratados.montoslc_D.value;
		}
		else
		{	
			for(i=0; i<campos.length; i++)
			{
				listProductosDef += campos[i].value + "|";
				montoslcD+= document.ProductoFormContratados.montoslc_D[i].value+'|';
			}
		}
		document.getElementById('bitacoraLcDef').value=listProductosDef;
		document.getElementById('montoslc_D_ih').value=montoslcD;
	}

}



function gestionProducto(textbox, checkeo,idproducto,isPaquete,codProducto, maximo, combo,txtmtolc, codTipoProducto)
{	
    //	document.getElementById("alerta").height=16;
	var ProductoKey;
	var valorActual;
	var valorMaximo  =  document.getElementById("maxcon_" + idproducto).value;   
	var valorInicial =  document.getElementById("inicial_" + idproducto).value;  	
	//var textbox =  document.getElementById("maximo_" + idproducto);  	
	var valorInicialLC;
	// alert(checkeo.checked);

	try{
	  valorActual = document.getElementById("maximo_"+idproducto).value;
	  valorInicialLC =  document.getElementById("inicialLC_" + idproducto).value;
	}catch(e){
	  valorActual = document.getElementById("maximoPaq_"+idproducto).value;
	}

	//codTipoProducto = document.getElementById("tipoPlanAdic_"+idproducto).value; // MIX 09003 INC 155400

	try{

		/* INICIO INC 147622 18112010
		* Se valida que el plan adicional que se ha seleccionado, se Opcional u Opcional Obligatorio
		* Esto con el fin de controlar el parametro ind_condicion_contratacion a almacenar O(Opcional) u B (Opcional Obligatorio)
		**/
		//ProductoKey='O.' + document.getElementById('codPadre_' + idproducto).value + '.' + document.getElementById('codigo_' + idproducto).value;
		
		if (codTipoProducto == "2"){
			ProductoKey='B.' + document.getElementById('codPadre_' + idproducto).value + '.' + document.getElementById('codigo_' + idproducto).value;
		}else{	
			ProductoKey='O.' + document.getElementById('codPadre_' + idproducto).value + '.' + document.getElementById('codigo_' + idproducto).value;
		}
		// MIX 09003 INC 155400
		//producto
		if (document.getElementById('codPadre_' + idproducto).value!=idAbonado)
		{
			checkeo.checked = !checkeo.checked;			
			if (checkeo.checked)
			{
				document.getElementById('boton_' + idproducto).style.display="block";
				document.getElementById('boton_inicial_' + idproducto).style.display="none";

				if (valorActual>1)
				{
					document.getElementById('boton_' + idproducto).style.display="none";
				    document.getElementById('boton_inicial_' + idproducto).style.display="block";
				}

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
		/* INICIO INC 147622 18112010
		* Se valida que el plan adicional que se ha seleccionado, se Opcional u Opcional Obligatorio
		* Esto con el fin de controlar el parametro ind_condicion_contratacion a almacenar O(Opcional) u B (Opcional Obligatorio)
		**/	
		//ProductoKey='O.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto).value;
		if (codTipoProducto == "2"){
			ProductoKey='B.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto).value;
		}else{
		ProductoKey='O.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto).value;
		textbox.disabled=false;
		}
		// INICIO INC 147622 18112010
		//paquete
	}

   try{
	if (isPaquete==0){
		//conserva el error antes de cambiar
		if (checkeo.checked){

            if ("3"==codTipoProducto) {
				textbox.disabled=false;
			}
			
			txtmtolc.disabled=false;
			listProductos[pro]=ProductoKey;
			agregarPro(ProductoKey);
			document.getElementById('boton_'+idproducto).style["display"]="block";
			document.getElementById('boton_inicial_'+idproducto).style.display="none";			
			lcProducto = document.getElementById('combo_lc_'+idproducto).value;
			combo.disabled = false;//******** TMM-09008 ********** Fin/
	
			//(+) EV 23/03/09
			if (maximo > 0){ //EV 25/03/09
				if (parseInt(textbox.value)>0){     
					 //buscar si existe el producto seleccionado en lista de productos por defecto
					  var cantidadContratados = 0;
					  var totalProductos = 0
					   for(j=0;j<listaCodigosProdPorDefecto.length;j++) {
					   	var codigoSel = document.getElementById("codigo_" + idproducto).value;
					   	
					   	if (listaCodigosProdPorDefecto[j]==codigoSel){
						   	var cantProdj = listaCantidadProdPorDefecto[j];
						    cantidadContratados = cantidadContratados + parseInt(cantProdj);
					   	}
					   }
					  totalProductos = cantidadContratados + parseInt(textbox.value);
	
					  if (parseInt(totalProductos)>parseInt(maximo))
					  {
					  	  document.getElementById("maximo_" + idproducto).className="error";
					  	  document.getElementById("mensajes").innerHTML="Cantidad máxima excedida para producto seleccionado";
					  	  document.getElementById("mensajes").style["display"]="block";
					  	  document.getElementById("boton_" + idproducto).style["display"]="none";  	  
					  	  document.getElementById("boton_error_" + idproducto).style["display"]="block"; 
						  impIdProdError();
						  addIdProdError(idproducto);
						  impIdProdError();
					  }else{
					  	limpiaErrores(textbox,idproducto);//EV 27/03/09
					  }
	  			}
	  		}else{
			  	limpiaErrores(textbox,idproducto);//EV 27/03/09
			}
  			//(-) EV 23/03/09
  		}
		else
		{
			textbox.disabled=true;
			txtmtolc.disabled=true;
			volOrig=false;
			document.getElementById("maximo_" + idproducto).value = validaMaximo(valorActual,valorInicial,valorMaximo,idproducto);
			limpiaErrores(textbox,idproducto);
			listProductos.splice(ProductoKey);
			quitarPro(ProductoKey);
			//******** TMM-09008 ********** Inicio/
			combo.disabled = true;
			combo.selectedIndex = 0;
			//******** TMM-09008 ********** Fin/
		}
		validarRangoLC(txtmtolc,idproducto,codProducto,valorInicialLC,checkeo.checked);		
	}
	else
	{
		//validacion por Paquete	
		if (checkeo.checked){
			textbox.disabled=true;
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
				var comboHijo
				var idProductoHijo

				//formulario.elements[i+1].value <-- nombre de los textos
				//formulario.elements[i].value;  <-- nombre de los check
				//formulario.elements[i-3].value;  <-- nombre del idproducto
				texto1 = formulario.elements[i+1];
				check1 = formulario.elements[i];
				hidde1 = formulario.elements[i-3];
				
				//******** TMM-09008 ********** Inicio/
								
				idProductoHijo = document.getElementById(formulario.elements[i+5].name).value;
				comboHijo = document.getElementById(formulario.elements[i+4].name+'_'+idProductoHijo);
								
				if (checkeo.checked)
				comboHijo.disabled = false;
				else
				{
					comboHijo.disabled = true;
					comboHijo.selectedIndex = 0;
				}
				
								
				//******** TMM-09008 ********** Fin/
				
				//alert('Cantidad :' + texto1.value + '\n checkeado :' + check1.value + '\n codigo :'+hidde1.value );
				var cantPaqueteHijo=texto1.value;
					
				if (check1.checked)
				{
//					document.getElementById(formulario.elements[i+1].name).disabled=false;
					texto1.disabled=true;
					if (cantPaqueteHijo>1)
					{
					   document.getElementById('boton_' + idProductoHijo).style["display"]="none";
					  document.getElementById('boton_inicial_' + idProductoHijo).style["display"]="block";
					
					}
					else{
					  document.getElementById('boton_' + idProductoHijo).style["display"]="block";
					  document.getElementById('boton_inicial_' + idProductoHijo).style["display"]="none";
					
					}
				}
				else
				{
//					document.getElementById(formulario.elements[i+1].name).disabled=true;
					
					texto1.disabled=true;
					   document.getElementById('boton_' + idProductoHijo).style["display"]="none";
					  document.getElementById('boton_inicial_' + idProductoHijo).style["display"]="block";
					
					
					
				}
				// no agrego los productos hijos al listado de bitacora dado que si se selecciono el padre
				// todos los hijos en NavegacionWEB.java seran seleccionados..
			}
		}		
	 }
	}
	catch(err){
		
	}
	verificaPersonalizable(textbox,idproducto,isPaquete);
	

	document.getElementById('bitacora').value=getProductos();
	
}

var codPadre;
var idAbonado;
var volOrig=false;

function setIdAboando(idAbonAux){
//	alert('Seteando' + codPadreAux);
	idAbonado=idAbonAux;
}


function setCodPadre(codPadreAux){
//	alert('Seteando' + codPadreAux);
	codPadre=codPadreAux;
}

function cierraPaq(codigoPadreNew,isPaquete){
	try{
		
		
		if (codPadre==codigoPadreNew && tablaAbierta == true)
		{
		
			productoDePaquete=false;
			document.write('</table>');
			document.write('</td>');
			document.write('</tr>');
			tablaAbierta = false;
			//alert("cerro tabla...");
			setCodPadre("undefined");
			
		}
		if (isPaquete==1)
		{
			codPadre=codigoPadreNew;
		}
		//alert("codigoPadreNew  :"+codigoPadreNew +"\n codPadre "+codPadre +"\n isPaquete :"+isPaquete + "\n tablaAbierta "+tablaAbierta);
	}catch(e){
		impAlert(e.name + " - "+e.message+" En cierraPaq() codigoPadreNew "+codigoPadreNew+" isPaquete "+isPaquete);
	}
}
/*
function cierraPaqxxx(codigoPadreNew,isPaquete){
	if (codPadre==codigoPadreNew)
	{
		
		document.write('</table>');
		document.write('</tr>');
		document.write('</td>');	
		productoDePaquete=false;	

	}
	if (isPaquete==1)
	{
		codPadre=codigoPadreNew;
	}
}
*/
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

function validaMaximo(valorActual,valorInicial,valorMaximo,idproducto){
	if (valorActual>valorMaximo)
	{   
		volOrig=true;
		//error=error-1;
		impIdProdError();
		eliminaProdArrError(idproducto);
		impIdProdError();
		return valorInicial;
	}
	else
	{
		return valorActual;
	}
}


function verificaPersonalizable(cantidad,idProducto,isPaquete){
	try{
	   if(isPaquete==0)
	   {
	   	   if (cantidad.value>1||cantidad.value<1||cantidad.disabled){
				document.getElementById("boton_" + idProducto).style["display"]="none";  	  
			  	document.getElementById("boton_inicial_" + idProducto).style["display"]="block";  	
		  }
		  else if (!volOrig)
		  {
		  	  document.getElementById("boton_" + idProducto).style["display"]="block";
		  	  document.getElementById("boton_inicial_" + idProducto).style["display"]="none"; 
		  }
	   }

	}catch(e){
		impAlert(e.name + " - "+e.message+" verificaPersonalizable ");
	}
}

function limpiaErrores(cantidad,idProducto)
{
  	 cantidad.className="none";
  	  document.getElementById("boton_" + idProducto).style.display="none";  
	  document.getElementById("boton_error_" + idProducto).style["display"]="none"; 
	  document.getElementById("boton_inicial_" + idProducto).style["display"]="block"; 
	 /*  if (arrError.length==0)//por si otro error hizo desplegarse el mensaje de error
  	  {*/
	  	  document.getElementById("mensajes").style["display"]="none";
	  	  //quitaError(); //EV 26/03/09
  	  /*}*/
}

function eliminaProdArrError(numero)
{
//	ocultaMensajeErr();
	try
	{
		var arrErrorTmp = new Array;
		//var tiposdearrErrorTmp = new Array;
		//var codTiposdearrErrorTmp = new Array;
		for(k=0;k<arrError.length-1;k++)
		{
			if(arrError[k] == numero)
			{
				for(l=k;l<arrError.length-1;l++)
				{
					arrErrorTmp[l] = arrError[l+1];
					/*tiposdearrErrorTmp[l] = tiposdearrError[l+1];
					codTiposdearrErrorTmp[l] = codTiposdearrError[l+1];*/
				}
				break;
			}
			else
			{
				arrErrorTmp[k] = arrError[k];
				/*tiposdearrErrorTmp[k] = tiposdearrError[k];
				codTiposdearrErrorTmp[k] = codTiposdearrError[k];*/
			}
		}
		arrError = arrErrorTmp;
		/*tiposdearrError = tiposdearrErrorTmp;
		codTiposdearrError = codTiposdearrErrorTmp;*/
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En eliminaNumeroArr()");
	}
	
}

function addIdProdError(idProducto){
	var isExistProduc=false;

	 try
	{
		for (i=0;i<arrError.length;i++ )
		  {
			  
			  if (arrError[i]==idProducto)
			  {
					isExistProduc=true;
			  }
		  }
		  if (!isExistProduc)
		  {
			  arrError[arrError.length]=idProducto;
		  }
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En addIdProdError()");
	}
}

function impIdProdError()
{
	var numerosProd = 'IDS DE PROD ERR\n\n';
	for(i=0;i<arrError.length;i++)
	{
		numerosProd+= arrError[i]+',';
		//alert(arrError[i]);
	}
	//alert(numerosProd);
	//return numerosProd;

}