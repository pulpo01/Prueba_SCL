<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html:form action="/Contratar">
<html:hidden property="pagina" value="NivelContracTile"/>
<html:hidden property="accion"/>
<table width="100%" border="0">
  <tr>
    <td><div align="right">
 
    <img
    	src="img/botones/btn_contratar.gif" 
    	name="Contratar" id="Contratar" width="85" height="19"  border="0" id="Contratar"   style="cursor: pointer;"
    	align="Siguiente" alt="Contratar productos"
		onmouseover="sobreElBoton('Contratar','img/botones/btn_contratar_roll.gif')" 
		onmouseout="sobreElBoton('Contratar','img/botones/btn_contratar.gif')"
		onclick="forwardAction(document.forms[0],'<%=request.getContextPath()%>/GenerarVentaAction.do');habilitaBotonPortalVenta();"
	/>
		
	<img 
		src="img/botones/btn_salir.gif" 
		name="Salir" id="Contratar" width="85" height="19"  border="0" id="Salir" style="cursor: pointer;"
		onmouseover="sobreElBoton('Salir','img/botones/btn_salir_roll.gif')" 
		onmouseout="sobreElBoton('Salir','img/botones/btn_salir.gif')"
		onclick="sendContratarPorDefecto();habilitaBotonPortalVenta();"
	/>

	</div></td>
  </tr>
</table>
<input type="hidden" name="contratarPorDefecto" id="contratarPorDefecto" value="0">
</html:form>
