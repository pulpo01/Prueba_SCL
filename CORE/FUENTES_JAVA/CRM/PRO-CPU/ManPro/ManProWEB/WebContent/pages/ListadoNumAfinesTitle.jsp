<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <table width="100%" border="0">
      <tr>
     <td class="mensajeError" align="center"><div id="mensajes"></div></td>
      </tr>
</table>
  <table width="100%" border="0">
    <tr class="textcaminohormigas" >
      <td width="100%" align="left" >Contrataci&oacute;n de Planes Adicionales/Personalizaci&oacute;n/Ingresar Clientes Afines </td>
    <tr >
      <td colspan="10"   class="textoTitulo"><img src="img/green_arrow.gif" width="15" height="15" /> Personalizaci&oacute;n  de Clientes Afines </td>
    <tr>
      <td colspan="10" >
        <table width="100%" border="0">
          <tr>
            <td>&nbsp;</td>
            <td class="campoInformativo">Cliente</td>
            <td >:</td>
            <td class="valorCampoInformativo" >
	            <bean:write name="ClienteVTA" property="nombre"/> 
	            <bean:write name="ClienteVTA" property="apellidoPaterno"/> 
	            <bean:write name="ClienteVTA" property="apellidoMaterno"/> - <bean:write name="ClienteVTA" property="idCliente"/>
            </td>
            <logic:notEqual  name="Abonado" property="idAbonado" value="0">
	            <td class="campoInformativo">L&iacute;nea</td>
	            <td >:</td>
	            <td class="valorCampoInformativo">
	            	<bean:write name="Abonado" property="nombreAbonado"/> - <bean:write name="Abonado" property="idAbonado"/>
	            </td>
            </logic:notEqual>
            <logic:equal name="Abonado" property="idAbonado" value="0">
	            <td class="campoInformativo"></td>
	            <td ></td>
	            <td class="valorCampoInformativo">
            </logic:equal>	
            </td>
          </tr>
          <tr>
         	<logic:present name="descripcionProducto" scope="session">
            <td width="2%">&nbsp;</td>
            <td width="12%" class="campoInformativo">C&oacute;digo Plan Adicional </td>
            <td width="1%" >:</td>
            <td width="33%" class="valorCampoInformativo"><bean:write name="descripcionProducto" /></td>
            </logic:present>
            <td width="14%" class="campoInformativo"></td>
            <td width="1%" ></td>
            <td width="37%" class="valorCampoInformativo"></td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <logic:present name="codigoProductoTitle" scope="session">
            <td class="campoInformativo">Plan Adicional</td>
            <td >:</td>
            <td class="valorCampoInformativo"><bean:write name="codigoProductoTitle" /></td>
            </logic:present>
            <logic:present name="numeroMax" scope="session">
            <td class="campoInformativo">M&aacute;ximos permitidos </td>
            <td >:</td>
            <td class="valorCampoInformativo"><bean:write name="numeroMax" /></td>
            </logic:present>
          </tr>
        </table>        </td>
  </table>


</body>
</html>