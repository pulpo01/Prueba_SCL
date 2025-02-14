<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set>
<c:set var="numMax" value="${sessionScope.maxNumProducto}"></c:set> 
  <table  width="100%" border="0">
    <tr class="textcaminohormigas">
      <td width="882" colspan="2" >Contrataci&oacute;n Planes Adicionales/Personalizaci&oacute;n/Ingresar N&uacute;meros Frecuentes </td>
    </tr> 
    
  <logic:present name="productoContratadoFrecSess" scope="session">
  <bean:define id="productoContratado" name="productoContratadoFrecSess" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO"/>
  <tr>
    <td colspan= "2" ><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/> <span class="textoTitulo">Personalizaci&oacute;n Planes Adicionales de N&uacute;meros Frecuentes
    </span></td>
  </tr>
  
  <tr>
    <td><table width="98%" border="0">
      <tr>
        <td>&nbsp;</td>
        <td class="campoInformativo">Cliente</td>
        <td >:</td>
        <td class="valorCampoInformativo"><c:out value="${clienteOS.cliente.nombres}"/></td>
		<logic:notEqual  name="Abonado" property="idAbonado" value="0">
			<td class="campoInformativo">L&iacute;nea</td>
			<td >:</td>
			<td class="valorCampoInformativo">
				<%//<bean:write name="Abonado" property="nombreAbonado"/> - %><bean:write name="Abonado" property="idAbonado"/>
			</td>
		</logic:notEqual>
		<logic:equal name="Abonado" property="idAbonado" value="0">
			<td class="campoInformativo"></td>
			<td ></td>
			<td class="valorCampoInformativo">
		</logic:equal>	
      </tr>
      
      <tr>
        <td width="2%">&nbsp;</td>
        <td width="12%" class="campoInformativo">C&oacute;digo  </td>
        <td width="1%" >:</td>
        <td width="33%" class="valorCampoInformativo"><bean:write name="productoContratado" property="codigo"/></td>
        <%/*
		<td width="18%" class="campoInformativo">Correlativo</td>
        <td width="1%" >:</td>
        <td width="33%" class="valorCampoInformativo">1</td>
		*/%>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td class="campoInformativo">Nombre</td>
        <td >:</td>
        <td class="valorCampoInformativo"><bean:write name="productoContratado" property="descripcion"/></td>
        <td class="campoInformativo">M&aacute;x. n&uacute;meros permitidos </td>
        <td >:</td>
        <td class="valorCampoInformativo"><c:out value="${numMax}"/></td>
      </tr>
    </table>
	  <table width="100%" border="0" >
	  <tr>
	     <td class="mensajeError"><div id="mensajes"></div></td>
	  </tr> 
	  </table>
	</logic:present>