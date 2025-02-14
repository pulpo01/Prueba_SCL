/**************************************************************************
Esta m?dulo contiene las siguientes funciones:

function validaAccesoServiciosNoInstalados(value): Esta funci?n es invocada
por el evento ONCLICK en la lista de productos DISPONIBLES.

function validaAccesoServiciosInstalados(value)Esta funci?n es invocada
por el evento ONCLICK en la lista de productos INSTALADOS.

function despliegaLigadura(productos): Esta funci?n presenta al usuario la
lista de productos ligados a un producto seleccionado para instalar, si el cliente
acepta esta lista de productos entonces se instala el producto junto a los
productos ligados, en caso contrario se anula la operaci?n.

function despliegaTransferencia(productos):Esta funci?n presenta al usuario la
lista de productos a transferir en caso que el cliente dedsee desinstalar un
producto.Si el cliente acepta esta lista de productos entonces se desinstala
el producto e se instalan los productos de la transferencia, en caso contrario
se anula la operaci?n.

***************************************************************************/


/**************************************************************************/
/********************Declaracion de variables globales *******************/
/**************************************************************************/
var idProducto;/* ID del producto seleccionado desde una lista*/
var indexProducto;/* Indice del producto seleccionado dentro de una lista*/
var listaInstalados;/*Flag que indica si el ONCLICK proviene de la lista de productos instalados*/

/**************************************************************************/
/**************************************************************************/
/*************Funcion que responde al evento ONLOAD de la p?gina **********/
/*****En este evento se cargan las listas de productos instalados y********/
/*****Disponibles adem?s de la tabla de Reglas de validaci?n. *************/
/*****Esas tablas se mantienen como atributos de la clase JAVA ************/
/*****CustomerOrderValidate(javascript) y de la clase CustomerOrderRules **/ 
/*****que instancia el Servler "dwr-invoker" en el SCOPE de SESION,********/
/*****es decir, una instancia por cliente.   ******************************/
/*****Toda la l?gica que maneja el paso provisorio de productos desde******/
/*****la lista de productos instalados a no instalados y al rev?s, ********/
/*****es manejada en la clase CustomerOrderRule, es decir, se maneja*******/
/*****en el WEB CONTAINER.*************************************************/
/**************************************************************************/
/**************************************************************************/
window.onload = function() {
	CustomerOrderValidate.setCustomerAccount(document.forms[0].codCliente.value,display500);			   
}
/*ENDFUNCTION*/
function display500() {
CustomerOrderValidate.getServiciosContratados(Dumy2);
CustomerOrderValidate.getServiciosNoContratados(Dumy2);
CustomerOrderValidate.getReglas(Dumy);

}/*ENDFUNCTION display500*/
function Dumy2(prd){}
function Dumy(cant){
	if (document.forms[0].checkedUnInstall != null){
		if (document.forms[0].checkedUnInstall.length != null){
			for(i=0;i<document.forms[0].checkedUnInstall.length;i++){
				document.forms[0].checkedUnInstall[i].disabled=false;
			}
		}else{
			document.forms[0].checkedUnInstall.disabled=false;
		}
	}
	
	if (document.forms[0].checkedInstall != null){
	    if (document.forms[0].checkedInstall.length != null){
			for(a=0;a<document.forms[0].checkedInstall.length;a++){
				document.forms[0].checkedInstall[a].disabled=false;
			}	
		}else{
			document.forms[0].checkedInstall.disabled=false;
		}
	}
}


/**************************************************************************/
/**************************************************************************/
/*************Funcion que responde al ONCLICK sobre un CHECKBUTTON ********/
/***************de la lista de productos DISPONIBLES***********************/
/**************************************************************************/
/**************************************************************************/
/*Se setea el flag listaInstalados en FALSE indicando que el evento *******/
/*proviene de la lista de productos DISPONIBLES ***************************/
/*Se setea la variable global indexProdicto que contiene el indice en la **/
/*lista del producto CLICKEADO ********************************************/
/*Se setea el ID del producto CLICKEADO ***********************************/
/**************************************************************************/
function validaAccesoServiciosNoInstalados(value) {

	idProducto=value;/*Contiene el ID del producto seleccionado*/
	noInstalados=document.forms[0].checkedUnInstall

   if (noInstalados.length != null){ // RRG 12-06-2008 65662
   		// Se debe validar siempre que no sea arreglo RRG 12-06-2008 65662

		for(i=0;i<noInstalados.length;i++){
			if (noInstalados[i].value==value){
				//alert("el clicado es el"+ i+" y su estado anterior era "+ !noInstalados[i].checked);
				indexProducto=i;
				listaInstalados=false;
				break;
			}/*ENDIF (noInstalados[i].value==value)*/
		}/*ENDFOR (i=0;i<noInstalados.length;i++)*/
		if (!noInstalados[i].checked){
			//txt="Deselecciona el producto que previamente habia seleccionado para instalar"
			CustomerOrderValidate.ValidaProductoDesSeleccionado(value,despliegaTransferencia);
		}else{
			//txt="Selecciona el producto para instalarlo desde la lista de productos disponibles"
			CustomerOrderValidate.ValidaProductoSeleccionado(value,despliegaLigadura);
		}/*ENDIF (!noInstalados[i].checked)*/	
	} else {   // RRG 12-06-2008	 65662
		if (noInstalados.value==value){
			indexProducto=0;
			listaInstalados=false;
		}
		if (!noInstalados.checked){
			CustomerOrderValidate.ValidaProductoDesSeleccionado(value,despliegaTransferencia);
		}else{
			CustomerOrderValidate.ValidaProductoSeleccionado(value,despliegaLigadura);
		}
	}   // RRG 12-06-2008	 65662
}/*ENDFUNCTION validaAccesoServiciosNoInstalados*/

/**************************************************************************/
/**************************************************************************/
/*************Funcion que responde al ONCLICK sobre un CHECKBUTTON ********/
/***************de la lista de productos INSTALADOS************************/
/**************************************************************************/
/**************************************************************************/
/**************************************************************************/
/*Se setea el flag listaInstalados en TRUE  indicando que el evento *******/
/*proviene de la lista de productos INSTALADOS ****************************/
/*Se setea la variable global indexProdicto que contiene el indice en la **/
/*lista del producto CLICKEADO ********************************************/
/*Se setea el ID del producto CLICKEADO.***********************************/
/**************************************************************************/
function validaAccesoServiciosInstalados(value) {

	idProducto=value;/*Contiene el ID del producto seleccionado*/
	Instalados=document.forms[0].checkedInstall

	for(i=0;i<Instalados.length;i++){
		if (Instalados[i].value==value){
			//alert("el clicado es el"+ i+" y su estado anterior era "+ !Instalados[i].checked);
			indexProducto=i;
			listaInstalados=true;
			break;
		}/*ENDIF (Instalados[i].value==value)*/
	}/*ENDFOR (i=0;i<Instalados.length;i++)*/

    if (Instalados.length != null){
		if (Instalados[i].checked){/* Asumiendo que en la lista de instalados, checked=TRUE ==> instalado */
			//txt="Deselecciona el servicio que previamente habia seleccionado para desinstalar"
			CustomerOrderValidate.ValidaProductoSeleccionado(value,despliegaLigadura);
		}else{
			//txt="Selecciona el servicio para desinstalarlo"
			CustomerOrderValidate.ValidaProductoDesSeleccionado(value,despliegaTransferencia);
			
		}/*ENDIF (Instalados[i].checked)*/
	}else{
		if (Instalados.checked){/* Asumiendo que en la lista de instalados, checked=TRUE ==> instalado */
			//txt="Deselecciona el servicio que previamente habia seleccionado para desinstalar"
			CustomerOrderValidate.ValidaProductoSeleccionado(value,despliegaLigadura);
		}else{
			//txt="Selecciona el servicio para desinstalarlo"
			CustomerOrderValidate.ValidaProductoDesSeleccionado(value,despliegaTransferencia);
		}/*ENDIF (Instalados[i].checked)*/
	}
}/*ENDFUNCTION validaAccesoServiciosInstalados*/

/**************************************************************************/
/********************Funcion de CALLBACK invocada por *********************/
/*********CustomerOrderValidate.ValidaProductoSeleccionado ****************/
/******* desde validaAccesoServiciosInstalados o desde ********************/
/**************validaAccesoServiciosInstalados dependiendo de la lista ****/
/************** desde la que se seleccion? el producto ********************/
/**************************************************************************/
/********En caso que se sedee instalar un producto que contiene************/
/********productos ligados, esta funcion se los despliega al usuario*******/
/********para su aceptacion oo rechazo. Tambien valida la compatibilidad***/
/********con los sercicios ya instalados, pues si la lista de ligadura*****/
/********no contiene ningun producto, entonces el producto seleccionado****/
/********es incompatible con los ya instalados.****************************/
/**************************************************************************/
/**************************************************************************/
/* Adem?s de la lista de productos ligados, se utiliza la variable global */
/* idProducto que contiene el ID del producto seleccionado*****************/
/* para saber que producto debe instalar **********************************/
/* Utiliza el indexProducto y el flag listaInstalados para DESCLICKEAR ****/
/* el producto si acaso el cliente no acepta las ligaduras*****************/
/**************************************************************************/
function despliegaLigadura(productos){

	noInstalados=document.forms[0].checkedUnInstall
	Instalados=document.forms[0].checkedInstall

	/***************************************************************/
	/***************************************************************/
	/* si el servicio es incompatible, la ligadura viene vacia******/
	/***************************************************************/
	if (productos.length>0){
		text="La activacion de este Servicio [" + idProducto+"] implica la activacion automatica de otro servicio:  \n"
		for(i=0;i<productos.length;i++){
			/*Despliega solo los servicios ligados, no el seleccionado*/
			if(idProducto!=productos[i].id){
				text=text+"Codigo: ["+productos[i].id+"]\n";
			}/*ENDIF (idProducto!=productos[i].id)*/
		}/*ENDFOR (i=0;i<productos.length;i++)*/
		 
		/*** Si hay ligadura de productos, entonces deben venir el producto seleccionado mas los ligados ***/
		if(productos.length>1){
			/*?Acepta los productos ligados?*/
			var x=confirm(text);
			}
		else{
			var x=true;/* No hay ligadura y en la lista viene solo el producto seleccionado*/
		}/*ENDIF (productos.length>1)*/
		/*IF X=TRUE, el cliente acepta los productos ligados ademas del seleccionado ******/
		if(x){
			CustomerOrderValidate.InstalaServicio(idProducto,Dumy);
			
			for(i=0;i<productos.length;i++){
				for(j=0;j<noInstalados.length;j++){
					if (productos[i].id==noInstalados[j].value){
					 	noInstalados[j].checked=true;
					 	}/*ENDIF (productos[i].id==noInstalados[j].value)*/
				}/*ENDFOR (j=0;j<noInstalados.length;j++)*/
			}/*ENDFOR (i=0;i<productos.length;i++)*/
			
			
		}else{
			if(listaInstalados) Instalados[indexProducto].checked=!Instalados[indexProducto].checked;
			else noInstalados[indexProducto].checked=!noInstalados[indexProducto].checked;
		}/*ENDIF X=TRUE, si el cliente acepta los productos ligados*/
	}else{/*En la lista no viene ningun producto, es porque hay incompatibilidad*/
		CustomerOrderValidate.GetServiciosIncompatibles(despliegaIncompatibles);
	
	}/*ENDIF (productos.length>0)*/	
}/*ENDFUNCTION despliegaLigadura*/
/**************************************************************************/
/********************Funcion de CALLBACK invocada por *********************/
/*********** CustomerOrderValidate.GetServiciosIncompatibles***************/
/************desde la funcion despliegaLicaduras en el caso que************/
/************haya una incompatibilidad con algun productos contratado******/
/**************************************************************************/
function despliegaIncompatibles(incompatibles){
		
		text="No puede contratar el Cod. Servicio : [ " + idProducto + " ]\n"; 
		text=text+"Existe Incompatibilidad con el Cod. Servicio Contratado :";
		text=text+ "[ " + incompatibles + " ]";
		alert(text);
		if(listaInstalados) Instalados[indexProducto].checked=!Instalados[indexProducto].checked;
		else noInstalados[indexProducto].checked=!noInstalados[indexProducto].checked;
}/*ENDFUNCTION despliegaIncompatibles*/

/**************************************************************************/
/**************************************************************************/
/********************Funcion de CALLBACK invocada por *********************/
/*********CustomerOrderValidate.ValidaProductoDesSeleccionado *************/
/******* desde validaAccesoServiciosInstalados o desde ********************/
/**************validaAccesoServiciosInstalados dependiendo de la lista ****/
/************** desde la que se desseleccion? el producto *****************/
/**************************************************************************/
/*******Esta funcion presenta al usuario la lista de productos ************/
/*******a transferir en en en caso que este haya desee desinstalar*********/
/*******un producto, dandole la opci?n de aceptarlos o no.****************/
/**************************************************************************/
/**************************************************************************/
/* Adem?s de la lista de productos a transferis, se utiliza la variable ***/
/* global idProducto que contiene el ID del producto seleccionado**********/
/* para saber que producto debe desinstalar *******************************/
/* Utiliza el indexProducto y el flag listaInstalados para DESCLICKEAR ****/
/* el producto si acaso el cliente no acepta la transferencia**************/
/**************************************************************************/
function despliegaTransferencia(productos){
	

	noInstalados=document.forms[0].checkedUnInstall
	Instalados=document.forms[0].checkedInstall
	
	text="Advertencia: La desactivacion de este servicio\n"
	text=text+"implica la activacion automatica de otro servicio\n" 
	for(i=0;i<productos.length;i++){
		text=text+"Codigo: ["+ productos[i].id+"]\n";
	}/*ENDFOR (i=0;i<productos.length;i++)*/
	text=text+"Desea seguir?" 	
	/*IF hay transferencia*/
	if(productos.length>0){
		var x=confirm(text);
		}
	else{
		var x=true;
	}/*ENDIF (productos.length>0), si hay transferencia X=TRUE */
	/*************************************************************/
	/*********Si acepta los productos de la transferencia,********/
	/*********entonces desinstala el producto seleccionado y******/
	/*********luego instala los productos de la transferencia*****/
	/*************************************************************/
	if(x){
		CustomerOrderValidate.DesInstalaServicio(idProducto, Dumy);
		for(i=0;i<productos.length;i++){
			for(j=0;j<noInstalados.length;j++){
				if (productos[i].id==noInstalados[j].value){
				 	noInstalados[j].checked=true;
				 	}/*ENDIF (productos[i].id==noInstalados[j].value)*/
			}/*ENDFOR (j=0;j<noInstalados.length;j++)*/
		}/*ENDFOR (i=0;i<productos.length;i++)*/
	}else{
		if(listaInstalados) Instalados[indexProducto].checked=!Instalados[indexProducto].checked;
		else noInstalados[indexProducto].checked=!noInstalados[indexProducto].checked;
	}/*ENDIF X=TRUE, si no hay transferencia o si es que hay y el cliente los acept?*/
}/*ENDFUNCTION despliegaTransferencia*/

/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/********************* Funciones de debugging **************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
/***********************************************************************/
function despliegaEstado(){

	CustomerOrderValidate.getContratadosTabla(despliegaContratados);
	CustomerOrderValidate.getNocontratadosTabla(despliegaNoContratados);

}

function despliegaNoContratados(productos){
	text="Tabla de Servicios Disponibles"+"\n\n\n"
	
	productosNoContratados=productos;
	for(i=0;i<productosNoContratados.length;i++){
		text=text+productosNoContratados[i].id+" "+productosNoContratados[i].name+"\n";
	}
	if (text=="Tabla de Servicios Disponibles"+"\n\n\n") text=text+"Este cliente no tiene servicios disponibles."
	alert(text);
}
function despliegaContratados(productos){
	text="Tabla de Servicios Contratados"+"\n\n\n"
	productosContratados=productos;

	for(i=0;i<productosContratados.length;i++){
		text=text+productosContratados[i].id+" "+productosContratados[i].name+"\n";
	}
	if (text=="Tabla de Servicios Contratados"+"\n\n\n") text=text+"Este cliente no tiene servicios contratados."
	alert(text);
}

/***************************  FIN ************************************************/
