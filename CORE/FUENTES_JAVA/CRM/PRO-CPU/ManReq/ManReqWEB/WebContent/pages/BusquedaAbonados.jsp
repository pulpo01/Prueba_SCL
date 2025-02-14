<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 

<html:hidden name="BusquedaAbonadosForm" property="radioTipoPlan"/>
<html:hidden name="BusquedaAbonadosForm" property="codCliente"/>
<html:hidden name="BusquedaAbonadosForm" property="numMaxAbonados"/>
<html:hidden name="BusquedaAbonadosForm" property="numMaxLineas"/>
<html:hidden name="BusquedaAbonadosForm" property="numMaxPaginas"/>
<html:hidden name="BusquedaAbonadosForm" property="flgAbonadosDistTipoPlan"/>
<table width="100%" border="0" >
  <tr>
     <td class="mensajeError"><div id="mensajes"></div></td>
  </tr> 
</table>

<table width="100%">
  <tr>
    <td colspan="3">
 
<table width="100%" height="100%">
 <tr>
  <td class="barraarriba">Usuario: <c:out value="${clienteOS.usuario}"/>  &nbsp;Operadora: <c:out value="${sessionScope.operadora}"/>
  </td>
 </tr>
 <tr><td colspan=3>&nbsp;</td></tr>
 <tr><td colspan=3>&nbsp;</td></tr>
 <tr><td colspan=3 class="textoSubTitulo"><strong>INFORMACI&Oacute;N DE B&Uacute;SQUEDA DE ABONADOS</strong></td>
 </tr>
 <tr>
 	<td colspan="3">
  		<table width="100%">
		<tr>
			<td width="14%">N&uacute;mero de Abonado :</td>
			<td width="31%"><html:text name="BusquedaAbonadosForm" property="numAbonado" maxlength="10" onkeypress="return acceptNum(event)"/></td>
			<td width="55%">&nbsp;</td>
		</tr>
		<tr>
			<td>N&uacute;mero de Celular :</td>
			<td><html:text name="BusquedaAbonadosForm" property="numCelular" maxlength="10" onkeypress="return acceptNum(event)"/>	</td>
			<td ><img style="cursor: pointer;" src="botones/btn_buscar.gif" name="Siguiente1" width="85" height="19"  border="0" id="Buscar" onclick="f_buscar();"/></td>
		</tr>
		<tr>
			<td>Rut :</td>
			<td><html:text name="BusquedaAbonadosForm" property="rutAbonado" maxlength="10"/></td>
			<td >&nbsp;</td>
		</tr>
		<tr>
		  <td>Prestaci&oacute;n :</td>
          <td width=74% class="valorCampoSeleccionable">
              <html:select property="prestacionCB">
	            	<logic:iterate id="prestacion" name="prestaciones" scope="session" type="com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PrestacionDTO">
					  		<html:option value="<%=String.valueOf(prestacion.getCodPrestacion())%>"> <bean:write name="prestacion" property="codPrestacion"/>-<bean:write name="prestacion" property="desPrestacion"/> </html:option>
					</logic:iterate>
              </html:select>
          </td>
		</tr>			
		<tr>
			<td>Tipo de Plan tarifario :</td>
			<td > 
	      	<label>
        	<html:radio  name="BusquedaAbonadosForm" property="tipoPlanTarif" value="1"  onclick="f_cargaTipoPlan(1)"/>
        	Prepago</label>
      		<label>
        	<html:radio  name="BusquedaAbonadosForm" property="tipoPlanTarif" value="2" onclick="f_cargaTipoPlan(2)" />
        	Pospago</label>
      		<label>
        	<html:radio  name="BusquedaAbonadosForm" property="tipoPlanTarif" value="3" onclick="f_cargaTipoPlan(3)"/> 
        	Hibrido</label>	
			</td>
			<td>
				<table width="100%" >
				<tr>
				  <td width="50%">
					<strong><div id="mensajeBusqueda"></div></strong>
					</td>
					<td align='right' width="50%">
					<img style="cursor: pointer;" src="botones/btn_siguiente.gif" name="Siguiente1" width="85" height="19"  border="0" id="Siguiente1"  alt="Siguiente" onclick="f_siguiente();"/>
					<img src="botones/btn_salir.gif" name="Salir" width="85" height="19"  border="0" id="Salir2" onclick="window.close();" />
					</td>
				<tr>
				</table>
			</td>
		</tr>				
		
  		</table>
  	</td>
	
 </tr>
 <tr>
 	<td width="40%" valign="top" height="100%" >
	<iframe width="100%" height="365" src="pages/AbonadosFiltrados.jsp" name ="filtrados" ></iframe> 
  	</td>
	<td width="10%" align="center">
		<img style="cursor: pointer;" src="botones/btn_agregar.gif" name="Agregar" width="85" height="19"  border="0" id="Agregar" onclick="f_cargaAbonadosSel();"/>
		<img style="cursor: pointer;" src="botones/btn_eliminar.gif" name="Eliminar" width="85" height="19"  border="0" id="Eliminar" onclick="f_elimAbonadosSel();"/>
		<img style="cursor: pointer;" src="botones/btn_limpiar.gif" name="Limpiar" width="85" height="19"  border="0" id="Limpiar" onclick="f_limpiar();"/>
	</td>
 	<td width="40%" valign="top">
	<iframe width="100%" height="365" src="pages/AbonadosSeleccionados.jsp" scrolling="yes" name="seleccionados"></iframe> 	
  	</td>
 </tr>

</table>