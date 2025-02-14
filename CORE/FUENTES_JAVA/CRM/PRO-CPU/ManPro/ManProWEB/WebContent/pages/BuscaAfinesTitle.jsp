<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telef&oacute;nica M&oacute;viles.: B&uacute;squeda de Clientes</title>
</head>
<body>
<table width="100%" border="0">
      <tr>
     <td class="mensajeError" align="center"><div id="mensajes"></div></td>
      </tr>
</table>
<table width="100%" border="0">
  <tr class="textcaminohormigas" >
    <td align="left" >Contrataci&oacute;n de Planes Adicionales/Personalizaci&oacute;n/Ingresar Clientes Afines/Buscar Clientes </td>
  </tr>
  <tr>
    <td ><img src="img/green_arrow.gif" width="15" height="15" /> <span class="textoTitulo">B&uacute;squeda de Clientes </span></td>
  </tr>
  <tr>
    <td class="textoSubTitulo">&nbsp;</td>
  </tr>
  <tr>
    <td class="textoSubTitulo">Criterios de B&uacute;squeda  </td>
  </tr>
  
  <tr>
    <td>
      <table width="100%" border="0">
        <tr>
          <td width="48%"><select name="select1" id="select1" onchange="habilitaCombo(this);" >
            <option value="ident">Identificador</option>
            <option value="celular" selected="selected">N&uacute;mero Celular</option>
          </select>
            <input name="numeroCelular" type="text"  id="numeroCelular" value="" maxlength="20" onblur="limpiaMensajeError();" onfocus="limpiaText();"/>
            <input name="vieneCelular" type="hidden" id="vieneCelular"  value="" />
            <select name="select2" id="select2" style="display :none">
              <logic:present name="listaIdentidad" scope="request"> 
	           	<logic:iterate id="dto" name="listaIdentidad" type="com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.TipIdentDTO" scope="request">
					<option value="<bean:write name='dto' property='codTipIdent'/>"> <bean:write name="dto" property="descTipIdent"/> </option>
				</logic:iterate>
			 </logic:present>				
		    </select>
		    </td><td width="52%"><img src="img/botones/btn_buscar.gif" name="buscar" width="85" height="19" id="buscar" onclick="buscarCliente();" onmouseover="sobreElBoton('buscar','img/botones/btn_buscar_roll.gif')" onmouseout="sobreElBoton('buscar','img/botones/btn_buscar.gif')"/></td>
        </tr>
      </table>    </td>
  </tr>
  <tr>  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</body>
</html>