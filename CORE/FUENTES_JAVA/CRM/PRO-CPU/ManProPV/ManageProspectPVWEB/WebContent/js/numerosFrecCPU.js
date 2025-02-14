var indice = 0;
var indiceForm = 0;
var idTabActiva = "tab_1";
var tipoActual = '';
var tipoArr = '';
var tpoOrig = null;
var numTipos = new Array;
var maxNumTipos = new Array;
var cantidadFinalNumerosFijos = 0;
var cantidadFinalNumerosMoviles = 0;
var cantMaxNrosFrecuentes = new Array;
var arrayMaximoNumFijos = new Array;
var arrayMaximoNumMoviles = new Array;
var numerosEliminados = new Array;
var arrayNumerosFrecuentesCPU = new Array;
var arraytiposdeNumerosFrecuentes = new Array;
var arrayCodTiposdeNumerosFrecuentes = new Array;
var arrayCodTipoOriginalNumerosFrecuentes = new Array;
var numerosDeTodosLosProductos = new Array;

function ocultaMensajeErr()
{//taberr mensajes
	try {
		document.getElementById('mensajes').style.display="none";
	}catch(e){
		impAlert(e.name + " - "+e.message+" En ocultaMensajeErr()");
	}
}
function muestraMensajeErr(msgErr){
	//var celda = document.getElementById('tdErr');
	//celda.innerHTML = msgErr;//"El número ingresado "+numero+" para este abonado ya existe";

	try {
		document.getElementById("mensajes").innerHTML = msgErr;
		document.getElementById('mensajes').style.display="block";
	}catch(e){
		impAlert(e.name + " - "+e.message+" En muestraMensajeErr()");
	}
}

function trim(cadena) {
	var cadenaSinEspacio='';	
	for(i=0;i<cadena.length; i++) {
		if(cadena.charAt(i)!=" "){
			cadenaSinEspacio = cadenaSinEspacio + cadena.charAt(i);
		}
	}
	return cadenaSinEspacio;
}

function esnumero(){ 
  if(event.keyCode<48 || event.keyCode>57)
	event.keyCode=0;
}

function IsNumeric(input){
	var passedVal = input.value;
	var ValidChars = "0123456789"; 
	var IsNumber=true;
	var Char;
	
	if(passedVal == ""){
		IsNumber = false;
	}
	for (i = 0; i < passedVal.length; i++){
	
		Char = passedVal.charAt(i);
		if (ValidChars.indexOf(Char) == -1)
		{
			IsNumber = false;
			input.value = '';
			return false;
		}
	}
	return true;
}

function insertLOselect(content,Trow,numero,tipoNumeroP){
	//appendCell(Trow, '&nbsp;','7%');
	appendCell(Trow, '<input id=\"chk'+numero+'\" onmouseover=\"delShow()\" onmouseout=\"delNotShow()\" type=\"checkbox\" name=\"checkPaquete\" value=\"'+numero+'\" />','12%');
	appendCell(Trow, tipoNumeroP,'20%');
	appendCell(Trow, numero,'19%');
}

function appendCell(Trow, txt, porcentaje) {
	var newCell = Trow.insertCell(Trow.cells.length);
	newCell.width = porcentaje;
	newCell.align='center';
	newCell.innerHTML = txt;
}

function setClass(table)
{
	 try
	{
		for(k=1;k<table.rows.length;k++)
		{
			if(k%2==0)
			{
				table.rows[k].className = 'textoFilasColorTabla';
			}
			else
			{
				table.rows[k].className = 'textoFilasTabla';
			}
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En setClass()");
	}
}

/** 1.- Llamado desde NumFrecuenCPUBody */
function existeNumeroFrecIngresado(){
	ocultaMensajeErr();
	var numero = trim(document.getElementById('nuevoNumFrec').value);
	if(!validaNumero(document.getElementById('nuevoNumFrec'))) {
		return;
	}
	for(i=0;i<arrayNumerosFrecuentesCPU.length;i++) {
		if(arrayNumerosFrecuentesCPU[i] == numero) {
			muestraMensajeErr("El n\u00FAmero ingresado "+numero+"  ya existe para este abonado");
			return true;
		}
	}
	//if(excedeMaximoNumerosFrec()) {
		//muestraMensajeErr("Se ha superado la cantidad máxima de números para "+tipoEval);
		//return false;
	//}	
	//return false;
			
	obtenerTipoNumero(numero);	
}

/** 2.- Llamado desde existeNumeroFrecIngresado() */
function validaNumero(numero) {
	try {
		numero.value = trim(numero.value);
		if(numero.value.length == 0 ){ //|| Trim(numero) == '' es numero, trim sacar, letras etc....		
			return false;
		}
		if(!IsNumeric(numero)) {
			muestraMensajeErr("Debe ingresar solo n\u00FAmeros");
			return false;
		}
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En validaNumero()");
	}

	return true;
}


/** 3.- Llamado desde existeNumeroFrecIngresado() */
function obtenerTipoNumero(numero) {
 	try {
  	  var parametrosNumero=new Object();
  	  parametrosNumero['numero'] = numero;
 	  NumerosFrecAJAX.obtenerTipoNumero(parametrosNumero,retornoValidacionNumero);
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En obtenerTipoNumero()");
	} 	   
}

/** 4.- Llamado desde obtenerTipoNumero(numero) */
function retornoValidacionNumero(data){  
 	try {
  		if(data != null){    
   			var valoresRetorno=data;
      		var mensajeEval = null;
      		var tipoEval = null;
      		var tpoOrig = null;
      		var codTipoEval = null;
      		var cantNumerosActuales = 0;
      		mensajeEval=valoresRetorno['mensaje'];
         	if (mensajeEval == null || mensajeEval.length == 0) {
    			tipoEval=valoresRetorno['tipo'];
    			tpoOrig=tipoEval;
    			if (tipoEval=='ON-NET') {
        			//alert(tipoEval);
        			tipoEval='MOVILES';
    			}    
    			if(tipoEval=='MOVILES') {
    				//alert(arrayMaximoNumMoviles.length);
     				cantNumerosActuales = arrayMaximoNumMoviles.length;
     				//alert(cantNumerosActuales+">"+maximoNumMoviles);
     				if(cantNumerosActuales >= maximoNumMoviles ) {  
      					muestraMensajeErr("Se ha superado la cantidad m\u00E1xima de n\u00FAmeros para "+tipoEval);
      					return;
     				}
     				arrayMaximoNumMoviles[arrayMaximoNumMoviles.length]=arrayMaximoNumMoviles.length+1;    
     				cantidadFinalNumerosMoviles=arrayMaximoNumMoviles.length;
    			} else {
    				//alert(arrayMaximoNumFijos.length);    			
				    cantNumerosActuales = arrayMaximoNumFijos.length;
				    //alert(cantNumerosActuales+">"+maximoNumFijos);
				    if(cantNumerosActuales >= maximoNumFijos ) {
      					muestraMensajeErr("Se ha superado la cantidad m\u00E1xima de números para "+tipoEval);     
      					return;
     				}        
     				arrayMaximoNumFijos[arrayMaximoNumFijos.length]=arrayMaximoNumFijos.length+1;
     				cantidadFinalNumerosFijos=arrayMaximoNumFijos.length;
				}
    			codTipoEval=valoresRetorno['codTipo'];
    			verificaTipoNumRespuesta(tipoEval,codTipoEval,tpoOrig);
		}else{
    		muestraMensajeErr("N\u00FAmero inv\u00E1lido o no encontrado en las tablas de numeraci\u00F3n");//muestraMensajeErr(mensajeEval);
		}
	} else {
       impAlert("No se pudo validar el n\u00FAmero");
    }
	}catch(e){
		impAlert(e.name + " - "+e.message+" En retornoValidacionNumero()");
	}
}
/** 5.- Llamado desde retornoValidacionNumero(data) */
function verificaTipoNumRespuesta(tipoEval,codTipoEval,tpoOrig){
  	try {
	  	if(tipoEval != null && tipoEval.length > 0)	{
			if(existeTipoEnProducto(tipoEval)) {
				if(!excedeMaximoPorTipo(tipoEval))	{
					agregarNumeroFrec(tipoEval,codTipoEval,tpoOrig);
					document.getElementById('nuevoNumFrec').value = '';
				} else {
					muestraMensajeErr("El abonado ya tiene la cantidad m\u00E1xima de n\u00FAmeros de tipo "+tipoEval+" permitidos");
				}			
			} else {
				muestraMensajeErr("El abonado no puede aceptar n\u00FAmeros de tipo "+tipoEval);
			}
		}		
	} catch(e) 	{
		impAlert(e.name + " - "+e.message+" En verificaTipoNumRespuesta()");
	}
}

/** 6.- Llamado desde verificaTipoNumRespuesta(tipoEval,codTipoEval) */
function existeTipoEnProducto(tipoEval) {
	try {
		if (tipoEval=="MOVILES") {
			return true;
		} else if (tipoEval=="RED-FIJA") {
			return true;
		}
	} catch(e) 	{
		impAlert(e.name + " - "+e.message+" En existeTipoEnProducto()");
	}
	return false;
}

/** 7.- Llamado desde verificaTipoNumRespuesta(tipoEval,codTipoEval) */
function excedeMaximoPorTipo(tipo) {
	var cantNumerosDeTipo = 0;
	var indiceTipo = -1;
	try {
		indiceTipo = obtenerIndiceTipo(tipo);
		for(n=0;n<arraytiposdeNumerosFrecuentes.length;n++) {
			if(arraytiposdeNumerosFrecuentes[n] == tipo) {
				cantNumerosDeTipo++;
			}
		}if(cantNumerosDeTipo < maxNumTipos[indiceTipo] )	{
			return false;
		}
	}
	catch(e){
		impAlert(e.name + " - "+e.message+" En excedeMaximoPorTipo()");
	}
	return false;
}

/** 8.- Llamado desde verificaTipoNumRespuesta(tipoEval,codTipoEval) */
function agregarNumeroFrec(tipo,codTipo,tpoOrig){
	try {
		var numero = document.getElementById('nuevoNumFrec').value;
		var idTabla = obtenerIdTablaTipoNumero(tipo);
		addNewRow(numero,tipo,idTabla);
        //arrayNumerosFrecuentesCPU
		arrayNumerosFrecuentesCPU[arrayNumerosFrecuentesCPU.length] = numero;
		//arraytiposdeNumerosFrecuentes
		arraytiposdeNumerosFrecuentes[arraytiposdeNumerosFrecuentes.length] = tipo;
		//arrayCodTiposdeNumerosFrecuentes
		arrayCodTiposdeNumerosFrecuentes[arrayCodTiposdeNumerosFrecuentes.length] = codTipo;
		//arrayCodTipoOriginalNumerosFrecuentes
		arrayCodTipoOriginalNumerosFrecuentes[arrayCodTiposdeNumerosFrecuentes.length-1]=tpoOrig;		
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En agregarNumeroFrec()");
	}
}

/** 9.- Llamado desde agregarNumeroFrec(tipo,codTipo) */
function addNewRow(numero,tipoNumeroP,idTabla) {
	try {
		var TABLE = document.getElementById(idTabla);//idTabActiva
		var idTrActivo = 'trNumFr'+idTabla.substring(4);//idTabActiva.substring(4);//tab_1
		var TROW = document.getElementById(idTrActivo);//fila  id="trNumFr<%//=indice%>">
		var content = TROW.getElementsByTagName("td");
		var newRow = TABLE.insertRow(-1);
		var idRow = numero;
		var largo=TABLE.rows.length;
		newRow.id=idRow;
		insertLOselect(content,newRow,numero,tipoNumeroP);
		setClass(TABLE);
		tabActivaNF(idTabla,numTipos.length);
	} catch(e) {		
		impAlert(e.name + " - "+e.message+" En addNewRow()");
	}
}

/** 10.- Llamado desde addNewRow(numero,tipoNumeroP,idTabla) */
function tabActivaNF(id,maxtab) {	
	try {
		ocultaMensajeErr();
		idTabActiva = id;
		tabActiva_(id,maxtab);

	} catch(e) {
		impAlert(e.name + " - "+e.message+" En tabActivaNF()");
	}
}

/** 11.- Llamado desde tabActivaNF(id,maxtab) */
function tabActiva_(id,maxtab){		
	var i
	try{
		for (i=1;i<=maxtab;i++) {	
			//oculto todo menos el tab que debo mostrar
			idaux="tab_" + i;
			idtex="tex_" + i;	
			idbkg="bkg_" + i;
		 	document.getElementById(idaux).style.display="none";
			document.getElementById(idtex).className="tabDesactivo";
			document.getElementById(idbkg).className="tab_desactivada";
			//alert("idaux "+idaux+" idtex: "+idtex+" idbkg: "+idbkg)
			if (id==idaux){
				//alert("id==idaux "+id)
			 	document.getElementById(id).style.display="block";
				document.getElementById(idtex).className="tabActivo";			
				document.getElementById(idbkg).className="tab_activada";
			}
		} 
	}catch(e){
		impAlert(e.name + " - "+e.message+" En tabActiva()_");
	}
}

function excedeMaximoNumerosFrec() {
	var cantNumerosActuales = 0;
	var indiceTipo = -1;
	try {
		cantNumerosActuales = arrayNumerosFrecuentesCPU.length;//+ numerosDeTodosLosProductos.length;//revisar que que no vengan los del prod en la lista de todos				
		if(cantNumerosActuales < cantMaxNrosFrecuentes ) {
			return false;
		}
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En excedeMaximoNumerosFrec()");
	}
	return false;
}

function obtenerIdTablaTipoNumero(tipoEval)
{
	var idTabla = 'tab_';
	var indiceTipo = -1;
	try
	{
		indiceTipo = obtenerIndiceTipo(tipoEval);
		if(indiceTipo != -1)
		{
			indiceTipo++;// los ids de tablas inician en 1
			idTabla+=indiceTipo;
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En obtenerIdTablaTipoNumero()");
	}
	return idTabla;
}

function obtenerIndiceTipo(tipoEval) {
	var indiceTip = -1;
	try {
		for(i=0;i<numTipos.length;i++) 	{
			if(numTipos[i] == tipoEval)//equal
			{
				indiceTip = i;
				return indiceTip;
			}
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En obtenerIndiceTipo()");
	}

	return indiceTip;
}

function removeRow()//idfila
{
	//muestraNumyTiposProdActual();
	ocultaMensajeErr();
	var TABLE = document.getElementById(idTabActiva);
	var filadeltraelim='';
	var idRow='';
	var idRows='';
	var numch = TABLE.rows.length;
	var error = '';
	var numEliminados = new Array;
	try {
		for(i=TABLE.rows.length-1;i>0;i--)//el primer check selecciona todos
		{
			numch = TABLE.rows.length;
			idRow = TABLE.rows[i].id;
			if(document.getElementById('chk'+idRow).checked == true )//'chk'+idRow
			{
				TABLE.deleteRow(i);//numEliminados[numEliminados.length] = idRow;
				//alert('llama '+idRow);
				eliminaNumeroArr(idRow);//el id de la fila es el mismo value del check o sea el numero frec
			}
		}//for(i=0;i<numEliminados.length;i++){eliminaNumeroArr(numEliminados[i]);}
		setClass(TABLE);
		if(document.getElementById('checkSelAll').checked == true )
		{
			document.getElementById('checkSelAll').checked = false; 
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+"   TABLE.rows.length "+TABLE.rows.length+ " removeRow()");
	}
}

function eliminaNumeroArr(numero)
{
//	ocultaMensajeErr();
	try {
		var numerosDeProductoTmp = new Array;
		var tiposdeNumerosDeProductoTmp = new Array;
		var codTiposdeNumerosDeProductoTmp = new Array;
		var arrayMaximoNumFijosTmp = new Array;
		var arrayMaximoNumMovilesTmp = new Array;		
		var arrayCodTipoOriginalNumerosFrecuentesTmp = new Array;
		var tp = "";
		//alert('antes del for: '+arrayNumerosFrecuentesCPU.length);
		for(k=0;k<=arrayNumerosFrecuentesCPU.length-1;k++) {
			tp = arrayCodTiposdeNumerosFrecuentes[k];		
			if(arrayNumerosFrecuentesCPU[k] == numero) {
				for(l=k;l<arrayNumerosFrecuentesCPU.length-1;l++) {
					numerosDeProductoTmp[l] = arrayNumerosFrecuentesCPU[l+1];
					tiposdeNumerosDeProductoTmp[l] = arraytiposdeNumerosFrecuentes[l+1];
					codTiposdeNumerosDeProductoTmp[l] = arrayCodTiposdeNumerosFrecuentes[l+1];
					arrayCodTipoOriginalNumerosFrecuentesTmp[l]=arrayCodTipoOriginalNumerosFrecuentes[l+1];
				}
				break;
			} else {
				numerosDeProductoTmp[k] = arrayNumerosFrecuentesCPU[k];
				tiposdeNumerosDeProductoTmp[k] = arraytiposdeNumerosFrecuentes[k];
				codTiposdeNumerosDeProductoTmp[k] = arrayCodTiposdeNumerosFrecuentes[k];
				arrayCodTipoOriginalNumerosFrecuentesTmp[k]=arrayCodTipoOriginalNumerosFrecuentes[k];
			}
		}
		arrayNumerosFrecuentesCPU = numerosDeProductoTmp;
		arraytiposdeNumerosFrecuentes = tiposdeNumerosDeProductoTmp;
		arrayCodTiposdeNumerosFrecuentes = codTiposdeNumerosDeProductoTmp;
		arrayCodTipoOriginalNumerosFrecuentes=arrayCodTipoOriginalNumerosFrecuentesTmp;
		//alert('despues del for: '+arrayNumerosFrecuentesCPU.length);		
		if (tp=="RDF") {
			for (f = 0; f < arrayMaximoNumFijos.length-1;f++) {
				arrayMaximoNumFijosTmp[f] = arrayMaximoNumFijos[f];
	 		}
			arrayMaximoNumFijos=arrayMaximoNumFijosTmp;
			//alert('arrayMaximoNumFijos: '+arrayMaximoNumFijos.length);		
		} else if (tp=="ONN"){
	 		for (m = 0; m < arrayMaximoNumMoviles.length-1;m++) {
				arrayMaximoNumMovilesTmp[m] = arrayMaximoNumMoviles[m];
	 		}
			arrayMaximoNumMoviles=arrayMaximoNumMovilesTmp;	
			//alert('arrayMaximoNumMoviles: '+arrayMaximoNumMoviles.length);					
		}
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En eliminaNumeroArr()");
	}
}

function recuperaNumerosElim() {
	var numElim = '';
	for(a=0;a<numerosEliminados.length;a++) {
		numElim+= numerosEliminados[a]+'\n';
	}
	impAlert("numElim\n\n"+numElim);
}

function obtenerNumeros() {
    
	var numerosProd = '';
	try {		
		for(i=0;i<arrayNumerosFrecuentesCPU.length;i++) {
			numerosProd+= arrayNumerosFrecuentesCPU[i]+',';
		}	
		//impAlert('TODOS LOS NUMEROS \n\n'+numerosProd);
		return numerosProd;
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En obtenerNumeros()");
	}

}

function obtenerTipos() {
	var tiposProd = '';
	try {		
		for(i=0;i<arraytiposdeNumerosFrecuentes.length;i++)	{
			tiposProd+= arraytiposdeNumerosFrecuentes[i]+',';
		}
		//impAlert('TODOS LOS TIPOS \n\n'+tiposProd);
		return tiposProd;

	} catch(e) {
		impAlert(e.name + " - "+e.message+" En obtenerTipos()");
	}

}

function obtenerTiposOrig() {
	var tiposProd = '';
	try {		
		for(i=0;i<arrayCodTipoOriginalNumerosFrecuentes.length;i++)	{
			tiposProd+= arrayCodTipoOriginalNumerosFrecuentes[i]+',';
		}
		//impAlert('TODOS LOS TIPOS \n\n'+tiposProd);
		return tiposProd;
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En obtenerTiposOrig()");
	}


}

function obtenerCodTipos() {
	var codTiposProd = '';
	try {		
		for(i=0;i<arrayCodTiposdeNumerosFrecuentes.length;i++) {
			codTiposProd+= arrayCodTiposdeNumerosFrecuentes[i]+',';
		}
		//impAlert('TODOS LOS COD TIPOS NUMEROS \n\n'+codTiposProd);
		return codTiposProd;
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En obtenerCodTipos()");
	}

}

function enviarFormNF(enviar) {
	var opc = enviar;
	try {
		if(opc == 'enviar') {		
			document.getElementById('actualizaNumFrecCPU').value = "actualizaNumFrecCPU";
			document.getElementById('numFrecArr').value = obtenerNumeros();
			document.getElementById('tiposNumArr').value = obtenerTiposOrig();
			document.getElementById('codTiposNumArr').value = obtenerCodTipos();
			document.getElementById('NumerosFrecuentesCPUForm').action="NumerosFrecuentesCPUAction.do";
		} else if(opc == 'volver') {
			document.getElementById('cancelaNumFrec').value = "volver";
			document.getElementById('NumerosFrecuentesCPUForm').action="NumerosFrecuentesCPUAction.do";		
		}
		document.getElementById('NumerosFrecuentesCPUForm').submit();
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En enviarFormNF()");
	}
}

function creaHeaderForm(indice,tipo) {
	try {
		impAlert("creaHeaderForm indice "+indice+" tipo "+tipo);
		document.write('<table width="646" border="0" cellpadding="0" cellspacing="0" id="tab_'+indice+'">');
		document.write(' <form name="'+tipo+'">');
        document.write('  <tr class="textoColumnaTabla" id="trNumFr'+indice+'">');
        document.write('   <td width="178" align="center"><input title="Seleccionar Todos" name="checkbox5233" type="checkbox" value="checkbox"  onclick="MarcarCS(this.form,this)"/></td>');
        document.write('   <td width="153" align="center">'+tipo+'</td>');
        document.write('   <td width="315" align="center">N&uacute;mero</td>');
        document.write(' </tr>');
        document.write(' </form>');
		document.write('</table>');
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En creaHeaderForm()");
	}
}

function activaPrimerTab(indiceForm,indiceF) {
	try {
		//impAlert("activaPrimerTab indiceForm "+indiceForm+" indiceF "+indiceF);
		if(indiceForm == 1) {
			document.getElementById('tab_1').style.display="block";
			indiceForm++;
		} else {
			document.getElementById('tab_'+indiceF).style.display="none";
		}
	} catch(e){
		impAlert(e.name + " - "+e.message+" En activaPrimerTab()");
	}
}

function existeid(tabla,idfila) {
	for(i=0;i<tabla.rows.length;i++) 	{
		var filaactual = tabla.rows[i];
		for(h=1;h<filaactual.cells.length-2;h++) {	
			imprime3+= filaactual.cells[h].innerHTML+' ';
		}
	}
	for(i=0;i<tabla.rows.length;i++) {
		if(tabla.rows[i].id == idfila) {
			return true;
		}
	}
	return false;
}

function recuperaValores(tabla) {//idfila
	var idRow='';
	var numerosCh='';
	try {
		for(i=1;i<tabla.rows.length;i++){ //el primer check selecciona todos
			numch = tabla.rows.length;
			idRow = tabla.rows[i].id;
			numerosCh+= document.getElementById('chk'+idRow).value+'\n';
		}
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En recuperaValores()");
	}
	impAlert('numerosCh\n\n'+numerosCh);
}

function impAlert(ma){
	alert(ma);
}

function onlyInteger() {
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;
	if( keyASCII != 13 && keyASCII != 75 && keyASCII < 48 || keyASCII > 57 ) { //  And Not IsNumeric(Chr(CodAsc)) )	
	   window.event.keyCode = '';
	}
}

function onlyFloat(valorCampoTexto,numDecimales) {
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;
	
	if (keyASCII == 47) {
	  window.event.keyCode = '';	 
	  return;
	}
	
	if( keyASCII != 13 && keyASCII != 75 && (keyASCII < 46 || keyASCII > 57) ) { //  And Not IsNumeric(Chr(CodAsc)) )
	   window.event.keyCode = '';
	} else {
		if (valorCampoTexto.indexOf('.') != -1){
			dectext = valorCampoTexto.substring(valorCampoTexto.indexOf('.')+1, valorCampoTexto.length);
			if (dectext.length >= numDecimales) {
		   		window.event.keyCode = '';
			}
		}
	}
}

function onlyIntegerLetters() {
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;

	if( (keyASCII > 47 && keyASCII < 58) || (keyASCII > 64 && keyASCII < 91) || (keyASCII > 96 && keyASCII < 123)  ) {
	}else {
	   window.event.keyCode = '';
	}
}

function eliminaNumeroArrErr(numero){
	try {
		ocultaMensajeErr();
		var numerosDeProductoTmp = new Array;
		var tiposdeNumerosDeProductoTmp = new Array;
		for(k=0;k<numerosDeTodosLosProductos.length-1;k++) {
			if(arrayNumerosFrecuentesCPU[k] == numero) {
				for(l=k;l<arrayNumerosFrecuentesCPU.length-1;l++) {
					numerosDeProductoTmp[l] = arrayNumerosFrecuentesCPU[l+1];
					tiposdeNumerosDeProductoTmp[l] = arraytiposdeNumerosFrecuentes[l+1];
				}
				break;
			} else {
				numerosDeProductoTmp[k] = arrayNumerosFrecuentesCPU[k];
				tiposdeNumerosDeProductoTmp[k] = arraytiposdeNumerosFrecuentes[k];
			}
		}
		arrayNumerosFrecuentesCPU = numerosDeProductoTmp;
		arraytiposdeNumerosFrecuentes = tiposdeNumerosDeProductoTmp;
		//muestraNumyTiposProdActual();		
	} catch(e) {
		impAlert(e.name + " - "+e.message+" En eliminaNumeroArr()");
	}
}
