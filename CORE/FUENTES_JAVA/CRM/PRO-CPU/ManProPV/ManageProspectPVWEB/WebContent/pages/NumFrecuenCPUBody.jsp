<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Ingreso de Numeros Frecuentes CPU mti -->
<input type="hidden" name="actualizaNumFrecCPU" id="actualizaNumFrecCPU" />
<input type="hidden" name="volverNumFrec" id="volverNumFrec" />
<input type="hidden" name="limpiarNumFrec" id="limpiarNumFrec" />

<c:set var="cantMaxNrosFrecuentes" value="${sessionScope.cantMaxNrosFrecuentes}"></c:set>
<c:set var="maximoNumFijos" value="${sessionScope.maximoNumFijos}"></c:set>
<c:set var="maximoNumMoviles" value="${sessionScope.maximoNumMoviles}"></c:set>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/NumerosFrecAJAX.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/numerosFrecCPU.js' ></script>
<%!String colorFila = null;%>
<%
int indice = 1;
int indiceNumReg = 0;
%>
<script>
maximoNumFijos = "<c:out value="${maximoNumFijos}"/>" ;
maximoNumMoviles = "<c:out value="${maximoNumMoviles}"/>" ;
cantMaxNrosFrecuentes = "<c:out value="${cantMaxNrosFrecuentes}"/>" ;
<logic:present name="arrTipos" scope="session">
<bean:define id="arrTiposNum" name="arrTipos" type="java.util.ArrayList"/>
<logic:iterate id="tipoNumFrec" name="arrTiposNum"  type="java.lang.String">
	numTipos[indice]="<bean:write name='tipoNumFrec'/>";
	//maxNumTipos[indice]="<bean:write name='tipoNumFrec'/>";
	indice++;
</logic:iterate>
</logic:present>

var indiceNumReg = 0;

</script>
<form name="NumerosFrecuentesCPUForm" id="NumerosFrecuentesCPUForm">
<input type="hidden" name="correlativo" id="correlativo" value="<c:out value="${prodConFrecConfig}"/>" />
<input type="hidden" name="actualizaNumFrec" id="actualizaNumFrec" value="1" />
<input type="hidden" name="cancelaNumFrec" id="cancelaNumFrec"/>
<input type="hidden" name="numFrecArr" id="numFrecArr" value="" />
<input type="hidden" name="tiposNumArr" id="tiposNumArr" value="" />
<input type="hidden" name="codTiposNumArr" id="codTiposNumArr" value="" />
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
        <td width="21%" valign="middle"><span class="campoSeleccionable">
          <input type="text" name="textfield" id="nuevoNumFrec" maxlength="16" onkeypress="javascript: esnumero(this);"/>
        </span></td>
        <td width="44%" valign="bottom"><div align="left">
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
    <% try{%>    
    <tr>
     <td width="646" height="100%">
		<logic:present name="abonadoNumerosFrecuentesListDTO" scope="session">		
		<bean:define id="numerosFrecuentesList" name="abonadoNumerosFrecuentesListDTO" type="java.util.ArrayList"/>
		<logic:present name="numerosFrecuentesList">
		<logic:iterate  indexId="countTipos" id="numerosFrecuentes" name="numerosFrecuentesList"  type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO"> 
		<bean:define id="numeroFrecuenteArrTip" name="numerosFrecuentes" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO[]"  property="numFrecuentesIngresadosList"/>
				<% try {
				%>
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
				<% try {%>
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
				 arrayCodTiposdeNumerosFrecuentes[<%=indiceNumReg%>] = '<bean:write name="numeroFrecuente" property="codTipo" />';
			     arraytiposdeNumerosFrecuentes[<%=indiceNumReg%>] = '<bean:write name="numeroFrecuente" property="tipo" />';
				 arrayNumerosFrecuentesCPU[<%=indiceNumReg%>] = '<bean:write name="numeroFrecuente" property="numero" />';		
				 if (arrayCodTiposdeNumerosFrecuentes[<%=indiceNumReg%>]=="RDF") {
				 	arrayMaximoNumFijos[arrayMaximoNumFijos.length]=arrayMaximoNumFijos.length+1;
				 }else{
				 	arrayMaximoNumMoviles[arrayMaximoNumMoviles.length]=arrayMaximoNumMoviles.length+1;				 
				 }
				</script>
				<%indiceNumReg++; %>
				 <%}catch(Exception e3){ e3.printStackTrace();}%>
			</logic:iterate>
			</logic:present>
			</form>
		   </table>
		   <%}catch(Exception e2){ e2.printStackTrace();}%>
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
		<%}catch(Exception e1){ e1.printStackTrace();}%>
</table>

</td>
</tr>
<tr>
	<td>
	<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td width="2%">
			<div align="right"><img src="img/green_delete.gif" width="20" height="20" onclick="removeRow();" /></div>
			</td>
			<td width="70%">
			<span class="valorCampoInformativo" id="showDel">Al presionar elimina &iacute;tems selecionados. </span>
			</td>
			<td>
			<img style="cursor: pointer;" src="botones/btn_aceptar.gif" name="Aceptar" width="85" height="19"  border="0" id="Aceptar" align="right" onmouseover="sobreElBoton('Aceptar','botones/btn_aceptar_roll.gif')" onMouseOut="sobreElBoton('Aceptar','botones/btn_aceptar.gif')" onclick="enviarFormNF('enviar');" />
   		    <img style="cursor: pointer;" src="botones/btn_volver.gif" name="Volver" width="85" height="19"  border="0" id="Volver" align="right" onmouseover="sobreElBoton('Volver','botones/btn_volver_roll.gif')" onMouseOut="sobreElBoton('Volver','botones/btn_volver.gif')" onclick="enviarFormNF('volver');" />
			</td>			
		</tr>
	</table>
	</td>
</tr>
</table>
