<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="prodConFrecConfig" value="${sessionScope.prodConFrecConf}"></c:set>
<c:set var="codPadrePaq" value="${sessionScope.codPadrePaq}"></c:set>
<c:set var="numeroFrecuenteConfList" value="${sessionScope.numeroFrecuenteDTOArrList}"></c:set>
<c:set var="cantMaxNrosProducto" value="${sessionScope.maxNumProducto}"></c:set>
<c:set var="arrTiposNumFrec" value="${sessionScope.arrTipos}"></c:set>
<c:set var="numFrecOtrosProductos" value="${sessionScope.numFrecDeOtrosProductos}"></c:set>
<c:set var="identificadorProd" value="${sessionScope.identificadorProducto}"></c:set>
<c:set var="numCelAbonado" value="${sessionScope.numCelAbonado}"></c:set>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/NumerosFrecAJAX.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/numerosFrec.js' ></script>
<%!String colorFila = null;%>
<%
int indice = 1;
int indiceNumProd = 0;
%>
<script>
numCelAbonado = "<c:out value="${numCelAbonado}"/>" ;
cantMaxNrosProducto = "<c:out value="${cantMaxNrosProducto}"/>" ;
<logic:present name="arrTipos" scope="session">
<bean:define id="arrTiposNum" name="arrTipos" type="java.util.ArrayList"/>
<logic:iterate id="tipoNumFrec" name="arrTiposNum"  type="java.lang.String">
	numTipos[indice]="<bean:write name='tipoNumFrec'/>";
	//maxNumTipos[indice]="<bean:write name='tipoNumFrec'/>";
	indice++;
</logic:iterate>
</logic:present>

var indiceNumProd = 0;
<logic:present name="numFrecDeOtrosProductos" scope="session">
<bean:define id="numFOtrosProductos" name="numFrecDeOtrosProductos" type="java.util.ArrayList"/>
<logic:iterate id="listOtrNumfrec" name="numFOtrosProductos" type="java.lang.String">
		numerosDeTodosLosProductos[indiceNumProd] = <bean:write name='listOtrNumfrec' />;
		indiceNumProd++;
</logic:iterate>
</logic:present>
//tiposdeNumerosDeProducto---> manejar indices
//tiposdeNumerosDeProducto[indiceNumProd] = numTipos[4] = 'RED-FIJA';--> deber�a manejar: tiposdeNumerosDeProducto[indiceNumProd] = 4;



function obtenerTipoNumero(numero)
{
 	try
	{
  	  var parametrosNumero=new Object();
  	  parametrosNumero['numero'] = numero;
 	  NumerosFrecAJAX.obtenerTipoNumero(parametrosNumero,retornoValidacionNumero);
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En obtenerTipoNumero()");
	}
 	   
}
function retornoValidacionNumero(data)
{  
	try
	{
		if(data != null)
		{    
			var valoresRetorno=data;
	   		var mensajeEval = null;
	   		var tipoEval = null;
	   		var codTipoEval = null;
	   		mensajeEval=valoresRetorno['mensaje'];
	   	   	if (mensajeEval == null || mensajeEval.length == 0)
			{
				tipoEval=valoresRetorno['tipo'];
				codTipoEval=valoresRetorno['codTipo'];
				verificaTipoNumRespuestaFrec(tipoEval,codTipoEval);
			}
			else
			{
				muestraMensajeErr("N�mero inv�lido o no encontrado en las tablas de numeraci�n");//muestraMensajeErr(mensajeEval);
			}
		}
		else
	   {
	   	  impAlert("No se pudo validar el n�mero");
	   }
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En retornoValidacionNumero()");
	}

}

function verificaTipoNumRespuestaFrec(tipoEval,codTipoEval)
{
  	try
	{
	  	if(tipoEval != null && tipoEval.length > 0)
		{
			if(existeTipoEnProducto(tipoEval))
			{
				if(!excedeMaximoPorTipo(tipoEval))
				{
					//(+) EV 04/02/09 antes de agregar debe validar max modificaciones
					var numero = document.getElementById('nuevoNumFrec').value;
					
       	  			NumerosFrecAJAX.validaModificaciones(idProdContratado,maximoModificaciones,cantidadModificaciones,"I",numero,tipoEval,codTipoEval,validaModificacionesAjaxReturn);
					//agregarNumeroFrecFrec(tipoEval,codTipoEval);
					//document.getElementById('nuevoNumFrec').value = '';
					//(-)
					

				}
				else
				{
					muestraMensajeErr("El producto ya tiene la cantidad m�xima de n�meros de tipo "+tipoEval+" permitidos");
				}			
			}
			else
			{
				muestraMensajeErr("El producto no puede aceptar n�meros de tipo "+tipoEval);
			}
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En verificaTipoNumRespuestaFrec()");
	}
}

//(+) EV 04/02/09
function validaModificacionesAjaxReturn(data)
{
			var valoresRetorno=data;
	   		var resultado = valoresRetorno['mensaje'];
	   		var tipoEval = valoresRetorno['tipo'];
	   		var codTipoEval = valoresRetorno['codTipo'];

		if (resultado=="OK"){
			agregarNumeroFrecFrec(tipoEval,codTipoEval);
			document.getElementById('nuevoNumFrec').value = '';
		}else if (resultado=="superaMaximo"){
			muestraMensajeErr("Ha superado el  M\u00E1ximo de Modificaciones Permitidas.");
		}else{
			muestraMensajeErr("Error al validar m\u00E1ximo de modificaciones.");
		}
}


function agregarNumeroFrecFrec(tipo,codTipo)
{
	try
	{
		var numero = document.getElementById('nuevoNumFrec').value;
		var idTabla = obtenerIdTablaTipoNumero(tipo);
		addNewRow(numero,tipo,idTabla);
		numerosDeProducto[numerosDeProducto.length] = numero;
		tiposdeNumerosDeProducto[tiposdeNumerosDeProducto.length] = tipo;
		codTiposdeNumerosDeProducto[codTiposdeNumerosDeProducto.length] = codTipo;
		NumerosFrecAJAX.agregaNumeroAListaSesion(idProdContratado, numero, retornoDummy);
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregarNumeroFrecFrec()");
	}
}
function retornoDummy(){}
//(-) EV 04/02/09

function removeRowFrec()//idfila
{
	//muestraNumyTiposProdActual();
	ocultaMensajeErr();
	var TABLE = document.getElementById(idTabActiva);
	var filadeltraelim='';
	var idRow='';
	var idRows='';
	var error = '';
	
	if (TABLE+"" == "undefined" || TABLE+"" == "null" || TABLE+"" == "") {
			return true;
	}
	var numEliminados = new Array;
	try
	{
		//(+) EV 04/02/09
		var totalNumerosSel = 0;
		for(i=TABLE.rows.length-1;i>0;i--)
		{
			idRow = TABLE.rows[i].id;
			if(document.getElementById('chk'+idRow).checked == true )//'chk'+idRow
			{
				totalNumerosSel++;
			}
		}
		if (totalNumerosSel>0){
			var arrNumerosSel = new Array(totalNumerosSel);
			var indiceSel = 0;
			for(i=TABLE.rows.length-1;i>0;i--)
			{
				idRow = TABLE.rows[i].id;
				if(document.getElementById('chk'+idRow).checked == true )//'chk'+idRow
				{
					arrNumerosSel[indiceSel] = idRow;
					indiceSel++;
				}
			}
			
			//antes de eliminar debe validar que no supere el maximo de modificaciones
			NumerosFrecAJAX.validaModificacionesElim(idProdContratado,maximoModificaciones,cantidadModificaciones,arrNumerosSel,validaModificacionesElimAjaxReturn);
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+"   TABLE.rows.length "+TABLE.rows.length+ " removeRow()");
	}
}

function validaModificacionesElimAjaxReturn(resultado){
	var TABLE = document.getElementById(idTabActiva);
	var filadeltraelim='';
	var idRow='';
	var idRows='';
	var error = '';
	
	
	if (resultado=="OK"){
	
		var totalNumerosSel = 0;
		for(i=TABLE.rows.length-1;i>0;i--)
		{
			idRow = TABLE.rows[i].id;
			if(document.getElementById('chk'+idRow).checked == true )//'chk'+idRow
			{
				totalNumerosSel++;
			}
		}
		
		var arrNumerosSel = new Array(totalNumerosSel);
		var indiceSel = 0;
		for(i=TABLE.rows.length-1;i>0;i--)
		{
			idRow = TABLE.rows[i].id;
			if(document.getElementById('chk'+idRow).checked == true )//'chk'+idRow
			{
				arrNumerosSel[indiceSel] = idRow;
				indiceSel++;
			}
		}
		
		for(i=TABLE.rows.length-1;i>0;i--)//el primer check selecciona todos
		{
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
		
		//(+) EV Actualiza lista en sesion 
		NumerosFrecAJAX.eliminaNumeroAListaSesion(idProdContratado, arrNumerosSel, retornoDummy);
		//(-)
	}else if (resultado=="superaMaximo"){
		muestraMensajeErr("Ha superado el  M\u00E1ximo de Modificaciones Permitidas.");
	}else{
		muestraMensajeErr("Error al validar m\u00E1ximo de modificaciones.");
	}	

}

</script>
<form name="NumerosFrecuentesForm" id="NumerosFrecuentesForm">
<input type="hidden" name="correlativo" id="correlativo" value="<c:out value="${prodConFrecConfig}"/>" />
<input type="hidden" name="codPadrePaq" id="codPadrePaq" value="<c:out value="${codPadrePaq}"/>" />
<input type="hidden" name="actualizaNumFrec" id="actualizaNumFrec" value="1" />
<input type="hidden" name="cancelaNumFrec" id="cancelaNumFrec" value="0" />
<input type="hidden" name="numFrecArr" id="numFrecArr" value="" />
<input type="hidden" name="tiposNumArr" id="tiposNumArr" value="" />
<input type="hidden" name="codTiposNumArr" id="codTiposNumArr" value="" />
<input type="hidden" name="identificadorProducto" id="identificadorProducto" value="<c:out value="${identificadorProd}"/>" />
</form>
<table width="650" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><span class="textoSubTitulo">Ingreso</span></td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td width="6%" height="25" valign="middle">
				<div align="right"></div></td>
        <td width="29%" valign="middle"><span class="campoSeleccionable">Nuevo n&uacute;mero frecuente</span></td>
        <td width="27%" valign="middle"><span class="campoSeleccionable">
          <input type="text" name="textfield" id="nuevoNumFrec" maxlength="18" size=23 onkeypress="javascript: esnumero(this);"/>
        </span></td>
        <td width="38%" valign="bottom"><div align="left">
        	<span class="campoSeleccionable"><strong>
        		<img src="botones/btn_agregar.gif" onclick="existeNumeroFrecIngresado()" alt="Ingresa N&deg; en lista" name="ingresar" 
        		width="85" height="19"  border="0" id="ingresar" 	onmouseover="sobreElBoton('ingresar','botones/btn_agregar_roll.gif')" 
        		onmouseout="sobreElBoton('ingresar','botones/btn_agregar.gif')"/></strong>
           </span></div>
        </td>
      </tr>
      <tr>
	 		<%//|Producto Contratado Frecuente <c:out value="${prodConFrecConfig}"/>| Padre <c:out value="${codPadrePaq}"/>|</h3>%>
	 </tr>
    </table></td>
  </tr>
</table>
<br />
<table width="650" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="650">
	
	<table width="500" border="0" cellpadding="0" cellspacing="0">
                <% 
                try
                {
                	%>
                <tr>
                <logic:present name="arrTipos" scope="session">
		        <bean:define id="arrTiposNumTab" name="arrTipos" type="java.util.ArrayList"/>
                <% 
                	int cantidadTipos = arrTiposNumTab.size();
                	
                %>
                <logic:iterate indexId="countTip" id="tipoNumFrec" name="arrTiposNumTab"  type="java.lang.String">
                
                 <%
					int idTab = -1;
                    idTab = countTip.intValue()+1;
                 	if (countTip.intValue() == 0) 
                 	{
                 		%>
                 		<td class="tab_activada" id="bkg_<%=idTab%>"> 
				        <div align="center" onclick="tabActivaNF('tab_<%=idTab%>',<%=cantidadTipos%>)" id="tex_<%=idTab%>" class="tabActivo"><bean:write name="tipoNumFrec"/></div></td>
                 		<%
					} else {
						if (countTip.intValue() > 4){%></tr><tr><%}%>
                 		
                 		<td class="tab_desactivada" id="bkg_<%=idTab%>"> 
				        <div align="center" onclick="tabActivaNF('tab_<%=idTab %>',<%=cantidadTipos %>)" id="tex_<%=idTab%>" class="tabActivo"><bean:write name="tipoNumFrec"/></div></td>
                 		<%
					}
				%>
               	</logic:iterate>
		        </logic:present>
		           <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr> 
                	
                	<%
                }
                catch(Exception e)
                {
                	e.printStackTrace();	
                }
                %>
                <tr>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                </tr> 
    </table>	</td>
  </tr>
  <tr>
    <td>
  <table width="650" height="0%" border="1" cellpadding="0" cellspacing="0" bordercolor="#9AC453">
    <tr>
     <td width="646" height="100%">
		<logic:present name="numerosFrecuentesTipoListDTO" scope="session">
		<bean:define id="numerosFrecuentesTipoList" name="numerosFrecuentesTipoListDTO" type="java.util.ArrayList"/>
		<logic:present name="numerosFrecuentesTipoList">
		<logic:iterate  indexId="countTipos" id="numerosFrecuentes" name="numerosFrecuentesTipoList"  type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO"> 
		<bean:define id="numeroFrecuenteArrTip" name="numerosFrecuentes" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO[]"  property="numFrecuentesIngresadosList"/>
			    <table width="646" border="0" cellpadding="0" cellspacing="0" id="tab_<%=countTipos.intValue()+1%>">
			    <form name="<bean:write name="numerosFrecuentes" property="tipo"/>">
		        <tr class="textoColumnaTabla" id="trNumFr<%=countTipos.intValue()+1%>">
		          <td width="178" align="center"><input title="Seleccionar Todos" id="checkSelAll" name="checkbox5233" type="checkbox" value="checkbox"  onclick="MarcarCS(this.form,this)"/></td>
		          <td width="153" align="center"><bean:write name="numerosFrecuentes" property="tipo"/> (Max <bean:write name="numerosFrecuentes" property="cantidadMaxTipo"/>)</td>
		          <td width="315" align="center">N&uacute;mero</td>
		        </tr>
		        <script language="JavaScript" type="text/javascript">
					maxNumTipos[<%=countTipos.intValue()%>] = '<bean:write name="numerosFrecuentes" property="cantidadMaxTipo" />';
				</script>
			<logic:present name="numeroFrecuenteArrTip">
			<logic:iterate indexId="countNum" id="numeroFrecuente" name="numeroFrecuenteArrTip" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO">
				<%
				colorFila = null;
				
				if ((countNum.intValue() % 2) == 0) {
		   					colorFila = "textoFilasTabla";
				} else {
					colorFila = "textoFilasColorTabla";
				}
				%>	
				<tr class="<%=colorFila%>" id="<bean:write name='numeroFrecuente' property='numero' />">
					<td align="center"><input name="chk<bean:write name='numeroFrecuente' property='numero' />" id="chk<bean:write name='numeroFrecuente' property='numero' />" type="checkbox" 
					    value="<bean:write name='numeroFrecuente' property='numero' />" 
					    onmouseout="delNotShow()" onmouseover="delShow()" /></td>
					<td align="center"><bean:write name="numeroFrecuente" property="tipo" /></td>
					<td align="center"><bean:write name="numeroFrecuente" property="numero" /></td>
				</tr>
				<script language="JavaScript" type="text/javascript">
				 codTiposdeNumerosDeProducto[<%=indiceNumProd%>] = '<bean:write name="numeroFrecuente" property="codTipo" />';
					tiposdeNumerosDeProducto[<%=indiceNumProd%>] = '<bean:write name="numeroFrecuente" property="tipo" />';
					       numerosDeProducto[<%=indiceNumProd%>] = '<bean:write name="numeroFrecuente" property="numero" />';
					       
				</script>
				<%indiceNumProd++; %>
			</logic:iterate>
			</logic:present>
			</form>
		   </table>
			<%
		    if(indice == 1 )
			{%>	
				<script language="JavaScript" type="text/javascript">document.getElementById('tab_<%=indice%>').style.display="block";</script>
			<%
			} else {
			%> <script language="JavaScript" type="text/javascript">document.getElementById('tab_<%=indice%>').style.display="none";</script>
			<%
			}
			%>
			<%
			indice++;
			%>
		</logic:iterate>
		</logic:present>
		</logic:present></td>
	</tr>
</table>
<script language="JavaScript" type="text/javascript">
muestraNumyTiposProdActual();
</script>

</td>
</tr>
<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="2%">
			<div align="right"><img src="img/green_delete.gif" width="20" height="20" onclick="removeRowFrec();" /></div>
			</td>
			<td width="98%"><span class="valorCampoInformativo" id="showDel">
			Al presionar elimina &iacute;tems selecionados. </span></td>
		</tr>
	</table>
	</td>
</tr>
</table>
