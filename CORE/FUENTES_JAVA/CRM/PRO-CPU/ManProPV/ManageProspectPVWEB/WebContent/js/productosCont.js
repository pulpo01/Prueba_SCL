var pro=0;
var codPadre;
var idAbonado;
var ProductosIniciales="";
var listProductos = Array();
var listProductosc = Array();
var listCodProductos = Array();//codProdIniciales
var listIdProductos = Array();//idProdIniciales
var listCodProductosErr = Array();
var tablaAbierta = false;
var hayAutoAfinCont = 0;
var hayAutoAfinOfer = 0;
var objCheckAfinOfer;
var productoDePaquete=false;
var listIdProductosSel = Array();//idProdSeleccionados ofertados
var listIndexCantPrdOf = new Array();
var listIdEspecProvision = new Array();

function agregaCodProductoErr(codpro)
{
	try
	{
		listCodProductosErr[listCodProductosErr.length] = codpro;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregaCodProductoErr()");
	}
}

function quitarCodProductoErr(codpro)
{
	try
	{
		var listCodProductosErrTmp = new Array;
		for(k=0;k<listCodProductosErr.length-1;k++)
		{
			if(listCodProductosErr[k] == codpro)
			{
				for(l=k;l<listCodProductosErr.length-1;l++)
				{
					listCodProductosErrTmp[l] = listCodProductosErr[l+1];
				}
				break;
			}
			else
			{
				listCodProductosErrTmp[k] = listCodProductosErr[k];
			}
		}
		listCodProductosErr = listCodProductosErrTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarCodProductoErr()");
	}
}

function obtieneProdErr()
{
	var prodsErr = '';
	var coma = '';
	try
	{
		if(listCodProductosErr.length>1){coma=',';}
		for(l=0;l<listCodProductosErr.length;l++)
		{
			if(listCodProductosErr.length-1==l){coma='';}
			prodsErr+=listCodProductosErr[l]+coma;
		}
		return prodsErr;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En obtieneProdErr()");
	}
}


function agregaCodProducto(codpro,idpro,esPaquete,esHijo)
{
	try
	{
		//alert("codpro "+codpro+" esPaquete "+esPaquete);
		if(esHijo == 0)
		{
			listCodProductos[listCodProductos.length] = codpro;
			listIdProductos[listIdProductos.length] = idpro;
		}

	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregaCodProducto()");
	}
}

function muestraCodProducto()
{
	
	var codigosprod = '';
	try
	{
		//listCodProductos[listCodProductos.length] = codpro;
		//listIdProductos[listIdProductos.length] = idpro;
		for(l=0;l<listCodProductos.length;l++)
		{
			codigosprod+='|'+listCodProductos[l]+'\n';
		}
		alert("codigosprod \n"+codigosprod);
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En muestraCodProducto()");
	}
}

function obtieneCantidadProd(codProd)
{
	var cantidadProdPorTipo = 0;
	try
	{
		for(l=0;l<listCodProductos.length;l++)
		{
			if(codProd == listCodProductos[l])
			{
				cantidadProdPorTipo++;
			}
		}
		return cantidadProdPorTipo;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En obtieneCantidadProd()");
	}
}

function quitarCodPro(codpro,idpro)
{
	try
	{
		var listIdProductosTmp = new Array;
		var listCodProductosTmp = new Array;
		for(k=0;k<listIdProductos.length-1;k++)
		{
			if(listIdProductos[k] == idpro)
			{
				for(l=k;l<listIdProductos.length-1;l++)
				{
					listIdProductosTmp[l] = listIdProductos[l+1];
					listCodProductosTmp[l] = listCodProductos[l+1];
				}
				break;
			}
			else
			{
				listIdProductosTmp[k] = listIdProductos[k];
				listCodProductosTmp[k] = listCodProductos[k];
			}
		}
		listIdProductos = listIdProductosTmp;
		listCodProductos = listCodProductosTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarCodPro()");
	}
}

function agregarProSecId(idpro)
{
	try
	{
		listIdProductosSel[listIdProductosSel.length] = idpro;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregarProSecId()");
	}
}

function quitarProSecId(idpro)
{
	try
	{
		var listIdProductosSelTmp = new Array;
		for(k=0;k<listIdProductosSel.length-1;k++)
		{
			if(listIdProductosSel[k] == idpro)
			{
				for(l=k;l<listIdProductosSel.length-1;l++)
				{
					listIdProductosSelTmp[l] = listIdProductosSel[l+1];
				}
				break;
			}
			else
			{
				listIdProductosSelTmp[k] = listIdProductosSel[k];
			}
		}
		listIdProductosSel = listIdProductosSelTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarProSecId()");
	}
}

function agregarPro(idpro)
{
	try
	{
		listProductos[listProductos.length] = idpro;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregarPro()");
	}
}

function quitarPro(idpro)
{
	try
	{
		var listProductosTmp = new Array;
		for(k=0;k<listProductos.length-1;k++)
		{
			if(listProductos[k] == idpro)
			{
				for(l=k;l<listProductos.length-1;l++)
				{
					listProductosTmp[l] = listProductos[l+1];
				}
				break;
			}
			else
			{
				listProductosTmp[k] = listProductos[k];
			}
		}
		listProductos = listProductosTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarPro()");
	}
}

function agregarProc(idpro)
{
	try
	{
		listProductosc[listProductosc.length] = idpro;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregarPro()");
	}
}

function quitarProc(idpro)
{
	try
	{
		var listProductoscTmp = new Array;
		for(k=0;k<listProductosc.length-1;k++)
		{
			if(listProductosc[k] == idpro)
			{
				for(l=k;l<listProductosc.length-1;l++)
				{
					listProductoscTmp[l] = listProductosc[l+1];
				}
				break;
			}
			else
			{
				listProductoscTmp[k] = listProductosc[k];
			}
		}
		listProductosc = listProductoscTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarPro()");
	}
}

function agregarIndexCantPrdOf(idpro)
{
	try
	{
		var indexCant = parseInt(idpro) - parseInt(indiceIniPofer);
		listIndexCantPrdOf[listIndexCantPrdOf.length] = indexCant;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregarIndexCantPrdOf()");
	}
}

function quitarIndexCantPrdOf(idpro)
{
	try
	{
		var indexCant = parseInt(indexCant) - parseInt(indiceIniPofer);
		var listIndexCantPrdOfTmp = new Array;
		for(k=0;k<listIndexCantPrdOf.length-1;k++)
		{
			if(listIndexCantPrdOf[k] == indexCant)
			{
				for(l=k;l<listIndexCantPrdOf.length-1;l++)
				{
					listIndexCantPrdOfTmp[l] = listIndexCantPrdOf[l+1];
				}
				break;
			}
			else
			{
				listIndexCantPrdOfTmp[k] = listIndexCantPrdOf[k];
			}
		}
		listIndexCantPrdOf = listIndexCantPrdOfTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarIndexCantPrdOf()");
	}
}

function agregarIdEspecProvision(idEspecProvision)
{
	try
	{
		listIdEspecProvision[listIdEspecProvision.length] = idEspecProvision;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregarIdEspecProvision()");
	}
}

function quitarIdEspecProvision(idEspecProvision)
{
	try
	{
		var listIdEspecProvisionTmp = new Array;
		for(k=0;k<listIdEspecProvision.length-1;k++)
		{
			if(listIdEspecProvision[k] == idEspecProvision)
			{
				for(l=k;l<listIdEspecProvision.length-1;l++)
				{
					listIdEspecProvisionTmp[l] = listIdEspecProvision[l+1];
				}
				break;
			}
			else
			{
				listIdEspecProvisionTmp[k] = listIdEspecProvision[k];
			}
		}
		listIdEspecProvision = listIdEspecProvisionTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarIdEspecProvision()");
	}
}

function cierraPaq(codigoPadreNew,isPaquete){
	try{
	    if (codPadre==codigoPadreNew && tablaAbierta == true)
		//if (codPadre==codigoPadreNew && isPaquete==0 && tablaAbierta == true)
		{
			productoDePaquete=false;
			document.write('</table>');
			document.write('</td>');
			document.write('</tr>');
			tablaAbierta = false;
		}
		if (isPaquete==1)
		{
			codPadre=codigoPadreNew;
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En cierraPaq() codigoPadreNew "+codigoPadreNew+" isPaquete "+isPaquete);
	}
}

function delNotShow(){
	try{
		document.getElementById("showDel").className="valorCampoInformativo";
	}catch(e){
		impAlert(e.name + " - "+e.message+" En delNotShow()");
	}
}

function delShow(){
	try{
		document.getElementById("showDel").className="verde";
	}catch(e){
		impAlert(e.name + " - "+e.message+" En delShow()");
	}
}

function descripcionIndCont(cod){		
	try{
		if ('D'==cod){
			document.write('Default');
			return true;
		}
		if ('O'==cod){
			document.write('Opcional');
			return true;
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En descripcionIndCont() cod "+cod);
	}	
}

function descripcionTipo(cod){		
	try{
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
		if (cod=='PADC'){
			document.write('Plan Adicional');
			return true;
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En descripcionTipo() cod "+cod);
	}	
}

function detallaPaquete(codPaq){
	try{
		//Hace visible la tabla de los productos de un paquete
		if (document.getElementById(codPaq).style.display!="none")	{
		document.getElementById(codPaq).style.display="none";
		return true;
		}
		if (document.getElementById(codPaq).style.display=="none")	{
			document.getElementById(codPaq).style.display="block";
			return true;
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En detallaPaquete()");
	}
}

function fueraDelBoton(id,imagen){
	try{
	 	document.getElementById(id).src=imagen;
	 	document.getElementById(id).style="cursor:pointer";
	}catch(e){
		impAlert(e.name + " - "+e.message+" En fueraDelBoton() id "+id+" imagen "+imagen);
	}
}

function sobreElBoton(id,imagen){
	try{
	 	document.getElementById(id).src=imagen;
 	    document.getElementById(id).style="cursor:pointer";

	}catch(e){
		impAlert(e.name + " - "+e.message+" En sobreElBoton() id "+id+" imagen "+imagen);
	}
}

function gestionProductoCont(checkeo,idproducto,isPaquete,idProdContratado,esAutoAfin, combo,txtmtolc)
{	
	var ProductoKey='';
	combo.disabled = true;
	//try{ProductoKey='C.' + document.getElementById('codPadre_' + idproducto+'c').value + '.' + document.getElementById('codigo_' + idproducto+'c').value;
		//if (document.getElementById('codPadre_' + idproducto+'c').value!=idAbonado){checkeo.checked = !checkeo.checked;return false;}
	//}catch(err){ProductoKey='C.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto+'c').value;}
	try{
		ProductoKey='C.' + idProdContratado + '.' + document.getElementById('codigo_' + idproducto+'c').value;
		if (PadreChequeado==''&&document.getElementById('codPadre_' + idproducto+'c').value!=idAbonado)
		{
			checkeo.checked = !checkeo.checked;	
			return false;
		}
	}
	catch(err)
	{
		ProductoKey='C.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto+'c').value;
	}
	try{
		if (!checkeo.checked){
			txtmtolc.disabled=true;
			agregarProc(ProductoKey);
			//lcProducto = document.getElementById('combo_lc_C'+idproducto).value;
			//******** TMM-09008 ********** Inicio/
								
				//if (checkeo.checked)
					//combo.disabled = false;
				//else
				//{
					combo.disabled = true;
					//combo.selectedIndex = 0;
				//}
			
			//******** TMM-09008 ********** Fin/
			if(esAutoAfin == 1)
			{
				hayAutoAfinCont = "0";
				ocultaMensajeErrorAfin();
			}	
		}
		else
		{
			txtmtolc.disabled=false;
			quitarProc(ProductoKey);
			//******** TMM-09008 ********** Inicio/
								
				//if (checkeo.checked)
					//combo.disabled = false;
				//else
				//{
					combo.disabled = false;
					//combo.selectedIndex = 0;
				//}
			
			//******** TMM-09008 ********** Fin/
			if(esAutoAfin == 1)
			{
				hayAutoAfinCont = "1";
			}
			//alert("chequeo el contraAut objCheckAfinOfer "+objCheckAfinOfer+" hayAutoAfinOfer "+hayAutoAfinOfer);
			if(hayAutoAfinOfer == 1)
			{
				hayAutoAfinOfer = 0;
				objCheckAfinOfer.checked = false;
				muestraMensajeErrorAfin("Se ha desmarcado el producto ofertado afin");
				/*var aInput=document.getElementsByName(objCheckAfinOfer);
				aInput.checked = false;*/
				//document.getElementsByName(objCheckAfinOfer).checked = false;
			}
		}
		if (isPaquete==1)
		{  //validacion por productos del paquete
			var idObj = '';
			formulario = checkeo.form;
			for (i=0; i < formulario.elements.length; i++) {
				//chequeo solo los hijos del producto
				idObj=formulario.elements[i].id;
				if (idObj==idproducto+'_'+idProdContratado)
				{//para no recorrer todos los objetos, manejar un arreglo
					
					//******** TMM-09008 ********** Inicio/
						
						if(formulario.elements[i+5]!=null)
							formulario.elements[i+5].checked =checkeo.checked ;
								
						if(formulario.elements[i+4]!=null)
						{
							idProductoHijo = formulario.elements[i+4].value;
							comboHijo = document.getElementById('combo_lc_C'+idProductoHijo);
											
							if (checkeo.checked)
							{
								comboHijo.disabled = true;
								//comboHijo.disabled = false;
							}
							else
							{
								comboHijo.disabled = true;
								//comboHijo.disabled = true;
								//comboHijo.selectedIndex = 0;
								
							}
						}
									
					//******** TMM-09008 ********** Fin/
						
				}
				else
				{
					if (idProdContratado==idObj.substring(idObj.indexOf('_')+1,idObj.length))
					{
						formulario.elements[i].checked =checkeo.checked	//lo marca
					}
				}
			}
		}
		document.getElementById('bitacorac').value=getProductosCont();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En gestionProductoCont() idproducto "+idproducto);//gestionProducto(textbox,checkeo,idproducto,isPaquete)
	}
}

function gestionAbonoLimiteConsumo(checkeo,abono,idProducto)
{
	
	if (checkeo.checked)
	{
		abono.disabled = false;
		document.getElementById('RegistraCambio_'+idProducto).value = "1";
	}
	else
	{
		document.getElementById('total_'+idProducto).style.display="block";
		document.getElementById('total_'+idProducto).innerHTML = document.getElementById('importe_'+idProducto).value;
		document.getElementById('RegistraCambio_'+idProducto).value = "0";
		abono.value = '';
		abono.disabled = true;
	}

}

function gestionProductoContManLc(checkeo,idproducto,isPaquete,idProdContratado,esAutoAfin, combo)
{	
	var ProductoKey='';
	combo.disabled = true;
	//try{ProductoKey='C.' + document.getElementById('codPadre_' + idproducto+'c').value + '.' + document.getElementById('codigo_' + idproducto+'c').value;
		//if (document.getElementById('codPadre_' + idproducto+'c').value!=idAbonado){checkeo.checked = !checkeo.checked;return false;}
	//}catch(err){ProductoKey='C.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto+'c').value;}
	try{
		ProductoKey='C.' + idProdContratado + '.' + document.getElementById('codigo_' + idproducto+'c').value;
		if (PadreChequeado==''&&document.getElementById('codPadre_' + idproducto+'c').value!=idAbonado)
		{
			checkeo.checked = !checkeo.checked;	
			return false;
		}
	}
	catch(err)
	{
		ProductoKey='C.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto+'c').value;
	}
	try{
		if (!checkeo.checked){
			agregarProc(ProductoKey);
			
			lcProducto = document.getElementById('combo_lc_C'+idproducto).value;
			//******** TMM-09008 ********** Inicio/
								
				if (checkeo.checked)
					combo.disabled = false;
				else
				{
					combo.disabled = true;
					combo.selectedIndex = 0;
				}
			
			//******** TMM-09008 ********** Fin/
			if(esAutoAfin == 1)
			{
				hayAutoAfinCont = "0";
				ocultaMensajeErrorAfin();
			}	
		}
		else
		{
			quitarProc(ProductoKey);
			//******** TMM-09008 ********** Inicio/
								
				if (checkeo.checked)
					combo.disabled = false;
				else
				{
					combo.disabled = true;
					combo.selectedIndex = 0;
				}
			
			//******** TMM-09008 ********** Fin/
			if(esAutoAfin == 1)
			{
				hayAutoAfinCont = "1";
			}
			//alert("chequeo el contraAut objCheckAfinOfer "+objCheckAfinOfer+" hayAutoAfinOfer "+hayAutoAfinOfer);
			if(hayAutoAfinOfer == 1)
			{
				hayAutoAfinOfer = 0;
				objCheckAfinOfer.checked = false;
				muestraMensajeErrorAfin("Se ha desmarcado el producto ofertado afin");
				/*var aInput=document.getElementsByName(objCheckAfinOfer);
				aInput.checked = false;*/
				//document.getElementsByName(objCheckAfinOfer).checked = false;
			}
		}
		if (isPaquete==1)
		{  //validacion por productos del paquete
			var idObj = '';
			formulario = checkeo.form;
			for (i=0; i < formulario.elements.length; i++) {
				//chequeo solo los hijos del producto
				idObj=formulario.elements[i].id;
				if (idObj==idproducto+'_'+idProdContratado)
				{//para no recorrer todos los objetos, manejar un arreglo
					
					//******** TMM-09008 ********** Inicio/
						
						if(formulario.elements[i+5]!=null)
							formulario.elements[i+5].checked =checkeo.checked ;
								
						if(formulario.elements[i+4]!=null)
						{
							idProductoHijo = formulario.elements[i+4].value;
							comboHijo = document.getElementById('combo_lc_C'+idProductoHijo);
											
							if (checkeo.checked)
							{
								comboHijo.disabled = false;
							}
							else
							{
								
								comboHijo.disabled = true;
								comboHijo.selectedIndex = 0;
								
							}
						}
									
					//******** TMM-09008 ********** Fin/
						
				}
				else
				{
					if (idProdContratado==idObj.substring(idObj.indexOf('_')+1,idObj.length))
					{
						formulario.elements[i].checked =checkeo.checked	//lo marca
					}
				}
			}
		}
		document.getElementById('bitacorac').value=getProductosCont();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En gestionProductoContManLc() idproducto "+idproducto);//gestionProducto(textbox,checkeo,idproducto,isPaquete)
	}
}


function syncSelect(Select, theValue, indexLimConsuInicial)
{
	if(indexLimConsuInicial > 0)
	{
		elFin = Select.length;
		for(i = 0; i < elFin; i++)
		{
			if(i==indexLimConsuInicial)
			{
				Select.selectedIndex = indexLimConsuInicial;
				return;
			}
		}
		return;
	}
	/*
	laFila = 0;
	elFin = Select.length;
	for(i = 0; i < elFin; i++)
	if( Select.options[i].value == theValue)
	{
		laFila = i;
		Select.disabled = false;
		break;
	}
	Select.selectedIndex = laFila;*/
	
	
	
}

function syncSelectContratado(Select, theValue, indexLimConsuInicial)
{
	//if(true) return;//150210 se agrega el primer elemento (- Seleccione -) el cual debe ser el seleccionado
	//alert("indexLimConsuInicial "+indexLimConsuInicial);
	if(indexLimConsuInicial > 0)
	{
		Select.selectedIndex = indexLimConsuInicial;
		/*elFin = Select.length;
		for(i = 0; i < elFin; i++)
		{
			if(i==indexLimConsuInicial)
			{
				
				Select.selectedIndex = indexLimConsuInicial;
				alert("Select.selectedIndex "+Select.selectedIndex);
				return;
			}
		}
		return;
		laFila = 0;
		for(i = 0; i < elFin; i++)
		if( Select.options[i].value == theValue)
		{
			laFila = i;
			Select.disabled = true;
			break;
		}
		Select.selectedIndex = laFila;
		Select.disabled = true*/
	}
	
	
}

function setValorSeleccionados()
{
	try{
		var x = document.getElementsByName("combo_lc_C");
		var y = document.getElementsByName("combo_lc");
			
		var listProductosDef = '';
		var listIndexLCDef   = '';
		var listSelCodLCDef  = '';
		var listSelMtoLCDef  = '';
		var listCantPdt      = '';
		if(x.length > 0)
		{    
			var campos = document.ProductoForm.combo_lc_C;
			
			if(x.length == 1)
			{
				listProductosDef += campos.value + "|";
				listIndexLCDef += campos.selectedIndex + "|";
			}
			else
			{	
				for(i=0; i<campos.length; i++)
				{
					listProductosDef += campos[i].value + "|";
					listIndexLCDef += campos[i].selectedIndex + "|";
				}
			}
			//alert("bitacoraLcDef "+listProductosDef);
			//alert("bitacoraContIndexLcDef   "+listIndexLCDef);
			document.getElementById('bitacoraLcDef').value=listProductosDef;
			document.getElementById('bitacoraContIndexLcDef').value=listIndexLCDef;
		}
		listIndexLCDef = '';
		if(y.length > 0)
		{    
			var campos = document.ProductoForm.combo_lc;
			
			if(y.length == 1)
			{
				listIndexLCDef += campos.selectedIndex + "|";
			}
			else
			{	
				for(i=0; i<campos.length; i++)
				{
					listIndexLCDef += campos[i].selectedIndex + "|";
				}
			}
			document.getElementById('bitacoraOferIndexLcDef').value=listIndexLCDef;
			//alert("bitacoraOferIndexLcDef   "+listIndexLCDef);
		}
		var idProdOf = '';
		var idSelectLC ='combo_lc_';
		var	codLC;
		//if(montolc.name=="montoslc_c"){ idSelectLC+="C";}

		for (i=0; i < listIdProductosSel.length; i++) {
		
			idProdOf = listIdProductosSel[i];
			var selectLC = document.getElementById(idSelectLC+idProdOf);
			var txtmto   = document.getElementById("txtmtolc_"+idProdOf);
			var cantPdt  = document.getElementById("maximo_"+idProdOf);
			codLC = codLimCons[idProdOf][0];
			if(codLC == '-0')
			{
				listSelCodLCDef += "-0|";
				listSelMtoLCDef += "0|";
				listIndexLCDef  += selectLC.selectedIndex + "0|";
				
			}else
			{
				listSelCodLCDef += selectLC.value + "|";
				listSelMtoLCDef += txtmto.value + "|";
				listIndexLCDef  += selectLC.selectedIndex + "|";
			}
			listCantPdt     += cantPdt.value+"|";//siempre debe estar habilitado el text de cantidad de los checkeados
		}
		//document.getElementById('bitacoraOferCodLC').value=listSelCodLCDef;
		//document.getElementById('bitacoraOferMtoLC').value=listSelMtoLCDef;
		//document.getElementById('bitacoraOferIndexLcDef').value=listIndexLCDef;
		//document.getElementById('cantidadPdt').value=listCantPdt;

		//alert("listSelCodLCDef["+listSelCodLCDef+"]");
		//alert("listSelMtoLCDef["+listSelMtoLCDef+"]");
		
	}catch(e){
		impAlert(e.name + " - "+e.message+" En setValorSeleccionados()");
	}
}

function gestionProducto(textbox,checkeo,idproducto,isPaquete,codProducto,esAutoAfin, esHijo,idEspecProvision,combo,txtmtolc)
{	
	var ProductoKey;
	var valorActual;
	var textboxmax;
	var valorInicial;  
	var valorMaximo;
	var valorInicialLC;
	var indGesPr=0;
	var f='1';
	try{
		//if((hayAutoAfinCont == 1 && esAutoAfin == 1) || (hayAutoAfinOfer == 1 && esAutoAfin == 1 ))
		if (esHijo==1)
		{
			checkeo.checked = !checkeo.checked;
			return;
		}
		if(esAutoAfin == 1)
		{
			//alert(hayAutoAfinCont+" esAutoAfin "+esAutoAfin);
			if(hayAutoAfinCont == 1 || (hayAutoAfinOfer == 1 && checkeo != objCheckAfinOfer))
			{
				//alert("hayAutoAfinCont "+hayAutoAfinCont+" esAutoAfin "+esAutoAfin+" hayAutoAfinOfer "+hayAutoAfinOfer);
				if(checkeo.checked)
				{
					checkeo.checked = !checkeo.checked;
					muestraMensajeErrorAfin("No puede seleccionar otro producto afin porque ya posee uno contratado ");
				}
				return;
			}
		}
		//alert("hayAutoAfinCont "+hayAutoAfinCont+" esAutoAfin "+esAutoAfin);
		//return;
		valorInicial =  document.getElementById("inicial_" + idproducto).value;
		valorMaximo  =  document.getElementById("maxcon_" + idproducto).value;
		valorInicialLC =  document.getElementById("inicialLC_" + idproducto).value;
		maxpro(textbox,valorMaximo,idproducto,codProducto,checkeo.checked,valorInicial,esAutoAfin);

	}catch(e){
		impAlert(e.name + " - "+e.message+" En gestionProducto() valorInicial valorMaximo err");
	}
	valorActual =textbox.value;//textboxmax.value;
	try{
		ProductoKey='O.' + document.getElementById('codPadre_' + idproducto).value + '.' + document.getElementById('codigo_' + idproducto).value;
		//producto
		if (document.getElementById('codPadre_' + idproducto).value!=idAbonado)
		{
			checkeo.checked = !checkeo.checked;	
			return false;
		}
	}
	catch(err)
	{
		ProductoKey='O.' + idAbonado + '.' +  document.getElementById('codigo_' + idproducto).value;
		alert("ProductoKey "+ProductoKey);
		//paquete
	}
	//alert("checkeo.checked "+checkeo.checked);

	try{
		if (isPaquete==0){
			//conserva el error antes de cambiar
			if (checkeo.checked){
				textbox.disabled=false;
				
				actualizarBoton(idproducto,true);
				agregarPro(ProductoKey);
				agregarProSecId(idproducto);
				agregarIndexCantPrdOf(idproducto);
				agregarIdEspecProvision(idEspecProvision);
				var	desLC = desLimCons[idproducto][combo.selectedIndex];
				if("SIN LIMITE" != desLC)
				{
					txtmtolc.disabled=false;
					combo.disabled = false;//******** TMM-09008 ********** Fin/
				}

				if(esAutoAfin == 1)
				{
					hayAutoAfinOfer = 1;
					objCheckAfinOfer = checkeo;
					//textbox.disabled=true;
					//ocultaMensajeErrorAfin;
					//alert("hayAutoAfinOfer "+hayAutoAfinOfer);
				}
			}
			else
			{
				textbox.disabled=true;
				txtmtolc.disabled=true;
				actualizarBoton(idproducto,false);
				// si lo descheckeo volver al valor inicial siempre cuando la cantidad maxima sea superada
				//document.getElementById("maximo_" + idproducto).value = validaMaximo(valorActual,valorInicial,valorMaximo);
				//textbox.value = validaMaximo(valorActual,valorInicial,valorMaximo);
				//quitarCodProductoErr(codProducto);
				//ocultaMensajeError(textbox);
				quitarPro(ProductoKey);
				quitarProSecId(idproducto);
				quitarIndexCantPrdOf(idproducto);
				quitarIdEspecProvision(idEspecProvision);
				if(esAutoAfin == 1)
				{
					hayAutoAfinOfer = 0;
					//alert("hayAutoAfinOfer "+hayAutoAfinOfer);
				}
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
				textbox.disabled=false;
				agregarPro(ProductoKey);
				agregarProSecId(idproducto);
				agregarIndexCantPrdOf(idproducto);f='5';
				agregarIdEspecProvision(idEspecProvision);
				//alert("agregarProPaq "+ProductoKey);
			}
			else
			{
				textbox.disabled=true;
				//quitarCodProductoErr(codProducto);
				//textbox.value = validaMaximo(valorActual,valorInicial,valorMaximo);
				//ocultaMensajeError(textbox);
				quitarPro(ProductoKey);
				quitarProSecId(idproducto);
				quitarIndexCantPrdOf(idproducto);
				quitarIdEspecProvision(idEspecProvision);
			}				
			//validacion por productos del paquete
			var i
			formulario = textbox.form;
			for (i=0; i < formulario.elements.length; i++) {
				//chequeo solo los hijos del producto
				//alert(formulario.elements[i].id + ' = ' + idproducto);
				f+='|'+i;
				if (formulario.elements[i].id==document.getElementById('codigo_' + idproducto).value)
				{				
					formulario.elements[i].checked =checkeo.checked	//lo marca
					var texto1
					var check1
					var hidde1
					var idProductoHijo
					
					
					//formulario.elements[i+1].value <-- nombre de los textos
					//formulario.elements[i].value;  <-- nombre de los check
					//formulario.elements[i-3].value;  <-- nombre del idproducto
					//texto1 = formulario.elements[i+1];
					check1 = formulario.elements[i];
					//hidde1 = formulario.elements[i-3];
					
					
					//******** TMM-09008 ********** Inicio/
								
					idProductoHijo = document.getElementById(formulario.elements[i-1].name).value;
					comboHijo = document.getElementById(formulario.elements[i+2].name+'_'+idProductoHijo);
									
					if (checkeo.checked)
					comboHijo.disabled = false;
					else
					{
						comboHijo.disabled = true;
						comboHijo.selectedIndex = 0;
					}
					
									
					//******** TMM-09008 ********** Fin/
				
					//idProductoHijo = document.getElementById(formulario.elements[i+4])//en ff no encuentra la prop
					
									
					if (check1.checked)
					{
						//texto1.disabled=false;
					}
					else
					{
						texto1.disabled=true;
					}
					// no agrego los productos hijos al listado de bitacorad dado que si se selecciono el padre
					// todos los hijos en NavegacionWEB.java seran seleccionados..
				}
			}
		}
		document.getElementById('bitacorad').value=getProductos();
		document.getElementById('bitacoradindexcant').value=listIndexCantPrdOf;//getIndexCantPrdOf();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En gestionProducto() idproducto "+idproducto+' f '+f);//gestionProducto(textboxmax,checkeo,idproducto,isPaquete)
	}
}

function actualizarBoton(idproducto,mostrar)
{
	try{
		var boton = document.getElementById('boton_'+idproducto);
		if(boton != null)
		{
			if(mostrar)
			{
				document.getElementById('boton_'+idproducto).style["display"]="block";
				document.getElementById('boton_inicial_'+idproducto).style.display="none";	
			}
			else
			{
				document.getElementById('boton_'+idproducto).style["display"]="none";
				document.getElementById('boton_inicial_'+idproducto).style.display="block";	
			}
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En actualizarBoton()");
	}
}

function getProductosCont(){
	var todos
	todos='';
	try{
		for (i=0; i < listProductosc.length; i++) {
			if (listProductosc[i]!='' && listProductosc[i]!=undefined){
				if (todos==''){
					todos = listProductosc[i];				
				}
				else
				{
					todos = todos + '|' + listProductosc[i];
				}
			}
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En getProductos()");
	}
	return todos;	
}

function getProductos(){
	var todos
	todos='';
	try{
		for (i=0; i < listProductos.length; i++) {
			if (listProductos[i]!='' && listProductos[i]!=undefined){
				if (todos==''){
					todos = listProductos[i];				
				}
				else
				{
					todos = todos + '|' + listProductos[i];
				}
			}
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En getProductos()");
	}
	return todos;	
}

function impAlert(ma)
{
	alert(ma);
}

function HabilitaTexto(textbox,txtmtolc,checkeo,idproducto)
{
	try{
		if (checkeo.checked){
			textbox.disabled=false;
			txtmtolc.disabled=false;
		}
		else
		{
			textbox.disabled=true;
			txtmtolc.disabled=true;			
		}
		
	}catch(e){
		impAlert(e.name + " - "+e.message+" En HabilitaTexto() idproducto "+idproducto);
	}
}

function MarcarCS( formulario ,valor ) {
	var i
	try{
		for (i=0; i < formulario.elements.length; i++) {
			formulario.elements[i].checked =valor.checked	//lo marca
		}

	}catch(e){
		impAlert(e.name + " - "+e.message+" En MarcarCS() valor "+valor);
	}
}

function muestraBlockNone(id)
{
	try{
		if(document.getElementById(id).style.display=="none"){
			document.getElementById(id).style.display="block";
		}
		else{
			document.getElementById(id).style.display="none";
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En muestraBlockNone() id "+id);
	}
}

function tabActiva(id,maxtab){	
	
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
			
			if (id==idaux){
			 	document.getElementById(id).style.display="block";
				document.getElementById(idtex).className="tabActivo";			
				document.getElementById(idbkg).className="tab_activada";
			}
		} 
	}catch(e){
		impAlert(e.name + " - "+e.message+" En tabActiva()");
	}
}

function setCodPadre(codPadreAux){
//	alert('Seteando' + codPadreAux);
	codPadre=codPadreAux;
	//PadreChequeado=codPadreAux;
}
function resetCodPadre(){
	setCodPadre('');
	PadreChequeado='';
}

function setIdAbonado(idAbonAux){
//	alert('Seteando' + codPadreAux);
	idAbonado=idAbonAux;
}

function setHayAutoAfinCont(hayAAfin){
//	alert('Seteando setHayAutoAfinCont ' + hayAAfin);
	hayAutoAfinCont=hayAAfin;
}

function setProductos(idpro){
//	if (document.getElementById('bitacorad').value!='')
//	{
//		document.getElementById('bitacorad').value =	document.getElementById('bitacorad').value + '|' + idpro;
//	}
//	else
//	{
	alert(" no deberia salir este msg En setProductos() idpro "+idpro);
	try{
		document.getElementById('bitacorad').value =	idpro;
	}catch(e){
		impAlert(e.name + " - "+e.message+" En setProductos() idpro "+idpro);
	}
		
//	}
}

function verificarCheckCont(chequeado,idProdContratado,codigo,indCondicionContratacion,indexLimConsuInicial,idProducto,esPaquete){
	try{
		//D indica que es por defecto, entonces no se puede descontratar y el check debe aparecer deshabilitado
		
		var nameCheck = idProducto+'_'+idProdContratado;
		if ('D'==indCondicionContratacion)
		{
			if ('1'==esPaquete)
			{
				PadreChequeado = codigo;
			}
			//alert("indCondicionContratacion "+indCondicionContratacion+" idCheck "+nameCheck);
			document.getElementById(nameCheck).checked=true;
			document.getElementById(nameCheck).disabled=true;
			//document.getElementById("myCheck").checked=true
			//document.getElementsById(nameCheck).click();
			//document.getElementsByName('check_<%=idProducto%>c').disabled=true;
		}
		else
		{//En la primera carga los productos contratados deben aparecer chequeados, 
		 //y el usuario puede deschequear para descontratar 
			if (chequeado =='true')
			{
				if ('1'==esPaquete)
				{
					PadreChequeado = codigo;
				}
				document.getElementById(nameCheck).click();
				if(indexLimConsuInicial > 0)
				{
					selectLC.selectedIndex = indexLimConsuInicial;
				}
				
			}else
			{
				var txtmto = document.getElementById("txtmtolc_"+idProducto);
				txtmto.disabled=true;
				var idSelectLC ='combo_lc_C';
				var selectLC = document.getElementById(idSelectLC+idProducto);
				selectLC.disabled = true;
				
				/*var ProductoKey='';
				try{
					ProductoKey='C.' + idProdContratado + '.' + document.getElementById('codigo_' + idProducto+'c').value;
					if (PadreChequeado==''&&document.getElementById('codPadre_' + idProducto+'c').value!=idAbonado)
					{
						checkeo.checked = !checkeo.checked;	
						return false;
					}
				}
				catch(err)
				{
					ProductoKey='C.' + idAbonado + '.' +  document.getElementById('codigo_' + idProducto+'c').value;
				}
				agregarProc(ProductoKey); //hayAutoAfinCont = "1"; revisar
				document.getElementById('bitacorac').value=getProductosCont();*/
			}
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En verificarCheckCont() nameCheck "+nameCheck);
	}
}

function verificarCheck(idProducto,chequeado,nameCheck,esPaquete,codigo){
	
					
	try{
		if (chequeado =='true')
		{
			if ('1'==esPaquete)
			{
				PadreChequeado = codigo;
			}
			document.getElementById(nameCheck).click();
			//document.getElementById('boton_'+idProducto).style["display"]="block";
			//document.getElementById('boton_inicial_'+idProducto).style.display="none";
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En verificarCheck() nameCheck "+nameCheck);
	}
}

function validaMaximo(valorActual,valorInicial,valorMaximo){
	try{
		if (valorActual>valorMaximo)
		{
			alert("valorActual>valorMaximo valorActual "+valorActual+"|valorMaximo "+valorMaximo);
			return valorInicial;
		}
		else
		{
			alert("valorActual<valorMaximo valorActual "+valorActual+"|valorMaximo "+valorMaximo);
			return valorActual;
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En validaMaximo() valorActual "+valorActual+"|valorInicial "+valorInicial+"|valorMaximo "+valorMaximo);
	}

}
