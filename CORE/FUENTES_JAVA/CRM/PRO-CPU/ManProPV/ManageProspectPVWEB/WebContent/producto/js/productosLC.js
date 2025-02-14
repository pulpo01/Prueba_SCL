var indiceIniPofer;
var codLimCons = new Array();
var desLimCons = new Array();
var mtosConsum = new Array();
var mtosMinimo = new Array();
var mtosMaximo = new Array();
var cantLCProd = new Array();
var listCodProductosErrLC = Array();

function agregaCodProductoErrLC(codpro)
{
	try
	{
		listCodProductosErrLC[listCodProductosErrLC.length] = codpro;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregaCodProductoErrLC()");
	}
}

function quitarCodProductoErrLC(codpro)
{
	try
	{
		var listCodProductosErrLCTmp = new Array;
		for(k=0;k<listCodProductosErrLC.length-1;k++)
		{
			if(listCodProductosErrLC[k] == codpro)
			{
				for(l=k;l<listCodProductosErrLC.length-1;l++)
				{
					listCodProductosErrLCTmp[l] = listCodProductosErrLC[l+1];
				}
				break;
			}
			else
			{
				listCodProductosErrLCTmp[k] = listCodProductosErrLC[k];
			}
		}
		listCodProductosErrLC = listCodProductosErrLCTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarCodProductoErrLC()");
	}
}

function validarSelectLC(selectLC,idProducto,codProducto)
{//lamado en onchange del select
	var	txtmto;
	var	desLC;
	try
	{
		
		desLC = desLimCons[idProducto][selectLC.selectedIndex];
		txtmto = document.getElementById("txtmtolc_"+idProducto);
		txtmto.value = mtosConsum[idProducto][selectLC.selectedIndex];
		var montoLCesValido = validarLC(selectLC,idProducto);
		if("- Seleccione -" == desLC)
		{
			montoLCesValido=true;
		}
		if(!montoLCesValido){
			gestionErrorLC(codProducto,txtmto);
		}else
		{
			prodConErr = obtieneProdErrLC();
			if(prodConErr.indexOf(codProducto)>-1)
			{
				actualizarErrorLC(codProducto,txtmto);				
			}
			txtmto.className="none";
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En validarSelectLC()");
	}
}

function validarRangoLC(montolc,idProducto,codProducto,mtoConsumidoIni,pdtEsCheckeado)
{//lamado en onchange del txt
	var prodConErr =' ';
	var idSelectLC ='combo_lc_';
	var	desLC;
		
	try{
		if(montolc.name=="montoslc_c"){ idSelectLC+="C";}
		var selectLC = document.getElementById(idSelectLC+idProducto);
		desLC = desLimCons[idProducto][selectLC.selectedIndex];
		if("- Seleccione -" == desLC)
		{
			montolc.value = mtosConsum[idProducto][selectLC.selectedIndex];
			return;
		}

		var montoLCesValido = validarLC(selectLC,idProducto);
		if(!montoLCesValido && pdtEsCheckeado){
			gestionErrorLC(codProducto,montolc);
		}
		else
		{
			if (!montoLCesValido)
			{
				montolc.value = mtoConsumidoIni;
				actualizarErrorLC(codProducto,montolc);
			}
			else
			{
				prodConErr = obtieneProdErrLC();
				if(prodConErr.indexOf(codProducto)>-1)
				{
					actualizarErrorLC(codProducto,montolc);				
				}
			}
			montolc.className="none";
		}
		if (!esNumerico(montolc)){
			montolc.value =  mtoConsumidoIni;	  
		}
	}
	catch(e){
		impAlert(e.name + " - "+e.message+" En validarRangoLC() montolc "+montolc+"|idProducto "+idProducto);
	}
}

function validarLC(selectLC,idProducto)
{
	try
	{
		var mtoMinimo = mtosMinimo[idProducto][selectLC.selectedIndex];
		var mtoMaximo = mtosMaximo[idProducto][selectLC.selectedIndex];
		var	txtmto = document.getElementById("txtmtolc_"+idProducto);
		var	txtmtoval = txtmto.value;
		if(parseFloat(txtmtoval)<parseFloat(mtoMinimo) || parseFloat(txtmtoval)>parseFloat(mtoMaximo))
		{
			return false;
		}else
		{
			return true;
		}	
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En validarLC()");
	}
}

function gestionErrorLC(codProducto,montolc)
{
	var cantp =' ';
	var prodConErr =' ';
	var indpos = -1;
	try
	{
		prodConErr = obtieneProdErrLC();
		indpos = prodConErr.indexOf(codProducto);
		if(indpos == -1)
		{
			agregaCodProductoErrLC(codProducto);
			prodConErr = obtieneProdErrLC();
			if(prodConErr.indexOf(',')>-1){cantp='s ';}
			muestraMensajeError("Limite de consumo fuera de rango para producto"+cantp+prodConErr,montolc); 
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En gestionErrorLC()");
	}
}

function actualizarErrorLC(codProducto,txtmontolc)
{
  	var cantp =' ';
	var prodConErrA =' ';
	try
	{
		quitarCodProductoErrLC(codProducto);
		prodConErrA = obtieneProdErrLC();
		if(prodConErrA.length >0)
		{
			if(prodConErrA.indexOf(',')>-1){cantp='s ';}
			muestraMensajeError("Limite de consumo fuera de rango para producto"+cantp+prodConErrA,txtmontolc); 
		}else
		{
			ocultaMensajeError(txtmontolc);  
		}	  
	}catch(e){
		impAlert(e.name + " - "+e.message+" En actualizarErrorLC()");
	}			
}

function obtieneProdErrLC()
{
	var prodsErr = '';
	var coma = '';
	try
	{
		if(listCodProductosErrLC.length>1){coma=',';}
		for(l=0;l<listCodProductosErrLC.length;l++)
		{
			if(listCodProductosErrLC.length-1==l){coma='';}
			prodsErr+=listCodProductosErrLC[l]+coma;
		}
		return prodsErr;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En obtieneProdErrLC()");
	}
}
