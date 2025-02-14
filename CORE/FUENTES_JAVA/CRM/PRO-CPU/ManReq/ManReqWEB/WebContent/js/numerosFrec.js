var indice = 0;
var indiceForm = 0;
var idTabActiva = "tab_1";
var tipoActual = '';
var tipoArr = '';
var numTipos = new Array;
var maxNumTipos = new Array;
var cantMaxNrosProducto = new Array;
var numerosEliminados = new Array;
var numerosDeProducto = new Array;
var tiposdeNumerosDeProducto = new Array;
var codTiposdeNumerosDeProducto = new Array;
var numerosDeTodosLosProductos = new Array;

function ocultaMensajeErr()
{//taberr mensajes
	try
	{
		document.getElementById('mensajes').style.display="none";
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En ocultaMensajeErr()");
	}
}
function muestraMensajeErr(msgErr)
{
	//var celda = document.getElementById('tdErr');
	//celda.innerHTML = msgErr;//"El número ingresado "+numero+" para este producto ya existe";

	try
	{
		document.getElementById("mensajes").innerHTML = msgErr;
		document.getElementById('mensajes').style.display="block";
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En muestraMensajeErr()");
	}
}

function existeNumeroFrecIngresado()
{
	ocultaMensajeErr();
	var numero = trim(document.getElementById('nuevoNumFrec').value);
	if(!validaNumero(document.getElementById('nuevoNumFrec')))
	{
		return;
	}
	for(i=0;i<numerosDeProducto.length;i++)
	{
		if(numerosDeProducto[i] == numero)
		{
			muestraMensajeErr("El número ingresado "+numero+"  ya existe para este producto");
			return true;
		}
	}
	
	for(i=0;i<numerosDeTodosLosProductos.length;i++)
	{
		if(numerosDeTodosLosProductos[i] == numero)
		{
			muestraMensajeErr("El número ingresado "+numero+" ya existe para otro producto ");
			return true;
		}
	}
	
	if(excedeMaximoProducto())
	{
		muestraMensajeErr("El producto ya tiene la cantidad máxima de números");
		return false;
	}

	obtenerTipoNumero(numero);
	return false;
}

function validaNumero(numero)
{
	try
	{
		numero.value = trim(numero.value);
		if(numero.value.length == 0 )//|| Trim(numero) == '' es numero, trim sacar, letras etc....
		{
			return false;
		}
		if(!IsNumeric(numero))
		{
			muestraMensajeErr("Debe ingresar solo números");
			return false;
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En validaNumero()");
	}

	return true;
}

function trim(cadena)
{
	var cadenaSinEspacio='';	
	for(i=0;i<cadena.length; i++)
	{
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

function addNewRow(numero,tipoNumeroP,idTabla)
{
	try
	{
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
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En addNewRow()");
	}
}

function insertLOselect(content,Trow,numero,tipoNumeroP)
{
	//appendCell(Trow, '&nbsp;','7%');
	appendCell(Trow, '<input id=\"chk'+numero+'\" onmouseover=\"delShow()\" onmouseout=\"delNotShow()\" type=\"checkbox\" name=\"checkPaquete\" value=\"'+numero+'\" />','12%');
	appendCell(Trow, tipoNumeroP,'20%');
	appendCell(Trow, numero,'19%');
}

function appendCell(Trow, txt, porcentaje)
{
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

function verificaTipoNumRespuesta(tipoEval,codTipoEval)
{
  	try
	{
	  	if(tipoEval != null && tipoEval.length > 0)
		{
			if(existeTipoEnProducto(tipoEval))
			{
				if(!excedeMaximoPorTipo(tipoEval))
				{
					agregarNumeroFrec(tipoEval,codTipoEval);
					document.getElementById('nuevoNumFrec').value = '';
				}
				else
				{
					muestraMensajeErr("El producto ya tiene la cantidad máxima de números de tipo "+tipoEval+" permitidos");
				}			
			}
			else
			{
				muestraMensajeErr("El producto no puede aceptar números de tipo "+tipoEval);
			}
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En verificaTipoNumRespuesta()");
	}
}

function excedeMaximoPorTipo(tipo)
{
	var cantNumerosDeTipo = 0;
	var indiceTipo = -1;
	try
	{
		indiceTipo = obtenerIndiceTipo(tipo);
		for(n=0;n<tiposdeNumerosDeProducto.length;n++)
		{
			if(tiposdeNumerosDeProducto[n] == tipo)
			{
				cantNumerosDeTipo++;
			}
		}
		if(cantNumerosDeTipo < maxNumTipos[indiceTipo] )
		{
			return false;
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En excedeMaximoPorTipo()");
	}
	return true;
}

function excedeMaximoProducto()
{
	var cantNumerosActuales = 0;
	var indiceTipo = -1;
	try
	{
		cantNumerosActuales = numerosDeProducto.length;//+ numerosDeTodosLosProductos.length;//revisar que que no vengan los del prod en la lista de todos
		if(cantNumerosActuales < cantMaxNrosProducto )
		{
			return false;
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En excedeMaximoProducto()");
	}
	return true;
}

function existeTipoEnProducto(tipoEval)
{
//	var indice
	try
	{
		for(i=0;i<numTipos.length;i++)
		{
			if(numTipos[i] == tipoEval)//equal
			{
				return true;
			}
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En existeTipoEnProducto()");
	}
	return false;
}

function agregarNumeroFrec(tipo,codTipo)
{
	try
	{
		var numero = document.getElementById('nuevoNumFrec').value;
		var idTabla = obtenerIdTablaTipoNumero(tipo);
		addNewRow(numero,tipo,idTabla);
		numerosDeProducto[numerosDeProducto.length] = numero;
		tiposdeNumerosDeProducto[tiposdeNumerosDeProducto.length] = tipo;
		codTiposdeNumerosDeProducto[codTiposdeNumerosDeProducto.length] = codTipo;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregarNumeroFrec()");
	}
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

function obtenerIndiceTipo(tipoEval)
{
	var indiceTip = -1;
	try
	{
		for(i=0;i<numTipos.length;i++)
		{
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
	var numch = 0;//TABLE.rows.length;
	var error = '';
	
	if (TABLE+"" == "undefined" || TABLE+"" == "null" || TABLE+"" == "") {
			return true;
	}
	var numEliminados = new Array;
	try
	{
		for(i=TABLE.rows.length-1;i>0;i--)//el primer check selecciona todos
		{
			numch = TABLE.rows.length;
			idRow = TABLE.rows[i].id;
			if(document.getElementById('chk'+idRow).checked == true )//'chk'+idRow
			{
				TABLE.deleteRow(i);//numEliminados[numEliminados.length] = idRow;
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
	try
	{
		var numerosDeProductoTmp = new Array;
		var tiposdeNumerosDeProductoTmp = new Array;
		var codTiposdeNumerosDeProductoTmp = new Array;
		for(k=0;k<numerosDeProducto.length-1;k++)
		{
			if(numerosDeProducto[k] == numero)
			{
				for(l=k;l<numerosDeProducto.length-1;l++)
				{
					numerosDeProductoTmp[l] = numerosDeProducto[l+1];
					tiposdeNumerosDeProductoTmp[l] = tiposdeNumerosDeProducto[l+1];
					codTiposdeNumerosDeProductoTmp[l] = codTiposdeNumerosDeProducto[l+1];
				}
				break;
			}
			else
			{
				numerosDeProductoTmp[k] = numerosDeProducto[k];
				tiposdeNumerosDeProductoTmp[k] = tiposdeNumerosDeProducto[k];
				codTiposdeNumerosDeProductoTmp[k] = codTiposdeNumerosDeProducto[k];
			}
		}
		numerosDeProducto = numerosDeProductoTmp;
		tiposdeNumerosDeProducto = tiposdeNumerosDeProductoTmp;
		codTiposdeNumerosDeProducto = codTiposdeNumerosDeProductoTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En eliminaNumeroArr()");
	}
}

function recuperaNumerosElim()
{
	var numElim = '';
	for(a=0;a<numerosEliminados.length;a++)
	{
		numElim+= numerosEliminados[a]+'\n';
	}
	impAlert("numElim\n\n"+numElim);
}

function tabActivaNF(id,maxtab)
{	
	try
	{
		ocultaMensajeErr();
		idTabActiva = id;
		tabActiva(id,maxtab);

	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En tabActivaNF()");
	}
}

function obtenerNumeros()
{
	
	var numerosProd = '';
	for(i=0;i<numerosDeProducto.length;i++)
	{
		numerosProd+= numerosDeProducto[i]+',';
	}
	return numerosProd;
	//impAlert('TODOS LOS NUMEROS \n\n'+numerosProd);
}

function obtenerTipos()
{
	var tiposProd = '';
	for(i=0;i<tiposdeNumerosDeProducto.length;i++)
	{
		tiposProd+= tiposdeNumerosDeProducto[i]+',';
	}
	return tiposProd;
	//impAlert('TODOS LOS NUMEROS \n\n'+numerosProd);
}

function obtenerCodTipos()
{
	var codTiposProd = '';
	for(i=0;i<codTiposdeNumerosDeProducto.length;i++)
	{
		codTiposProd+= codTiposdeNumerosDeProducto[i]+',';
	}
	return codTiposProd;
	//impAlert('TODOS LOS NUMEROS \n\n'+numerosProd);
}

function enviarFormNF(enviar)
{
	try
	{
		if(enviar == 0)
		{
			document.getElementById('cancelaNumFrec').value = "1";
		}
		else
		{
			document.getElementById('numFrecArr').value = obtenerNumeros();
			document.getElementById('tiposNumArr').value = obtenerTipos();
			document.getElementById('codTiposNumArr').value = obtenerCodTipos();
		}
		document.getElementById('NumerosFrecuentesForm').action="NumerosFrecuentesAction.do";
		document.getElementById('NumerosFrecuentesForm').submit();
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En enviarFormNF()");
	}
}

function creaHeaderForm(indice,tipo)
{
	try
	{
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
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En creaHeaderForm()");
	}
}

function activaPrimerTab(indiceForm,indiceF)
{
	try
	{
		//impAlert("activaPrimerTab indiceForm "+indiceForm+" indiceF "+indiceF);
		if(indiceForm == 1)
		{
			document.getElementById('tab_1').style.display="block";
			indiceForm++;
		}
		else
		{
			document.getElementById('tab_'+indiceF).style.display="none";
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En activaPrimerTab()");
	}
}









function existeid(tabla,idfila)
{
	for(i=0;i<tabla.rows.length;i++)
	{
		var filaactual = tabla.rows[i];
		for(h=1;h<filaactual.cells.length-2;h++)
		{	
			imprime3+= filaactual.cells[h].innerHTML+' ';
		}
	}
	for(i=0;i<tabla.rows.length;i++)
	{
		if(tabla.rows[i].id == idfila)
		{
			return true;
		}
	}
	return false;
}
function recuperaValores(tabla)//idfila
{
	var idRow='';
	var numerosCh='';
	try
	{
		for(i=1;i<tabla.rows.length;i++)//el primer check selecciona todos
		{
			numch = tabla.rows.length;
			idRow = tabla.rows[i].id;
			numerosCh+= document.getElementById('chk'+idRow).value+'\n';
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En recuperaValores()");
	}
	impAlert('numerosCh\n\n'+numerosCh);
}

function impAlert(ma)
{
	alert(ma);
}

function muestraNumyTiposProdActual()
{
	var numerosDeProductoV='';
	for(z=0;z<numerosDeProducto.length;z++)
	{
		numerosDeProductoV+= numerosDeProducto[z]+' '+tiposdeNumerosDeProducto[z]+'\n';
	}
	//impAlert("muestraNumyTiposProdActual \n\n"+numerosDeProductoV);
	return true;
}

function onlyInteger()
{
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;
	if( keyASCII != 13 && keyASCII != 75 && keyASCII < 48 || keyASCII > 57 ) //  And Not IsNumeric(Chr(CodAsc)) )
	{
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
	
	if( keyASCII != 13 && keyASCII != 75 && (keyASCII < 46 || keyASCII > 57) ) //  And Not IsNumeric(Chr(CodAsc)) )
	{
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

function onlyIntegerLetters()
{
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;

	if( (keyASCII > 47 && keyASCII < 58) || (keyASCII > 64 && keyASCII < 91) || (keyASCII > 96 && keyASCII < 123)  ) 
	{
	}else {
	   window.event.keyCode = '';
	}
}

function eliminaNumeroArrErr(numero)
{
	try
	{
		ocultaMensajeErr();
		
		var numerosDeProductoTmp = new Array;
		var tiposdeNumerosDeProductoTmp = new Array;
		
		for(k=0;k<numerosDeTodosLosProductos.length-1;k++)
		{
			if(numerosDeProducto[k] == numero)
			{
				for(l=k;l<numerosDeProducto.length-1;l++)
				{
					numerosDeProductoTmp[l] = numerosDeProducto[l+1];
					tiposdeNumerosDeProductoTmp[l] = tiposdeNumerosDeProducto[l+1];
				}
				break;
			}
			else
			{
				numerosDeProductoTmp[k] = numerosDeProducto[k];
				tiposdeNumerosDeProductoTmp[k] = tiposdeNumerosDeProducto[k];
			}
		}
		numerosDeProducto = numerosDeProductoTmp;
		tiposdeNumerosDeProducto = tiposdeNumerosDeProductoTmp;
		//muestraNumyTiposProdActual();
		
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En eliminaNumeroArr()");
	}
}
