<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">


<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:form action="/CNumSimAction" method="POST">

	<c:set var="codigoPrograma" value="${requestScope.codigoPrograma}"/> 
	<c:set var="versionPrograma" value="${requestScope.versionPrograma}" />
	<c:set var="tecnologia" value="${requestScope.tecnologia}" />
	
	<input type="hidden" id="num_abonado" name="num_abonado" value="<c:out value="${ClienteOOSS.numAbonado}"/>"/>
	<input type="hidden" id="nom_usuario" name="nom_usuario" value="<c:out value="${ClienteOOSS.usuario}"/>"/>
 	<input type="hidden" id="codTipContrato" name="codTipContrato" value="<c:out value="${usuarioAbonado.codTipContrato} "/>"/>
	<input type="hidden" id="des_tipcontrato" name="des_tipcontrato" value="<c:out value="${usuarioAbonado.des_tipcontrato}"/>"/>

	<input type="hidden" id="cod_vendedor" name="cod_vendedor" value="<c:out value="${usuarioSistema.cod_vendedor}"/>"/>
	<input type="hidden" id="cod_cliente" name="cod_cliente" value="<c:out value="${usuarioAbonado.cod_cliente}"/>"/>
	<input type="hidden" id="cod_tecnologia" name="cod_tecnologia" value="<c:out value="${usuarioAbonado.cod_tecnologia}"/>"/>
	<input type="hidden" id="nom_usuario" name="nom_usuario" value="<c:out value="${usuarioSistema.nom_usuario}"/>"/>
	<input type="hidden" id="cod_tipcomis" name="cod_tipcomis" value="<c:out value="${usuarioSistema.cod_tipcomis}"/>"/>	
	<input type="hidden" id="cod_ooss" name="cod_ooss" value="<c:out value="${ClienteOOSS.codOrdenServicio}"/>"/>	

	<input type="hidden" id="causaCambio" name="causaCambio" value="<c:out value="${requestScope.causaCambio}"/>"/>
	<input type="hidden" id="tipoContrato" name="tipoContrato" value="<c:out value="${requestScope.tipoContrato}"/>"/>
	<input type="hidden" id="tipoContrato" name="tipoContrato" value="<c:out value="${requestScope.tipoContrato}"/>"/>	
modalidadPago	

	<!--  Este flag impide ejecutar el mismo proceso asincronico hasta que se ejecute su metodo de callback --> 
	<input type="hidden" id="flagT" name="flagT" value="0"/>
	<!--  flag de estado de bloqueo de serie --> 
	<input type="hidden" id="flagBloqueo" name="flagBloqueo"/>

	<!--  --- CAMBIO DE SIMCARD --------------------  -->
	
	<table border=0 width="100%" cellpadding=3 cellspacing=3>
	<tr height="30" colspan=10>
	<td colspan=2>
		<font class="textoSubTitulo"><img src="img/black_arrow.gif"> Seleccionar SimCard</font>
	</tr>
	<tr height="25">
		<td align="right"> Nro.de Serie  &nbsp;</td>
		<td> 
			<html:text  tabindex="7" property="nroSerie" size="30" maxlength="30" onkeypress="if (window.event.keyCode==13) window.event.keyCode=0;"/>
		</td>

		<td align="right"> HLR  &nbsp;</td>
		<td> 
			<html:text property="hlr" size="30" maxlength="30"  readonly="true"/>
		</td>

	</tr>	
	
	<tr height="25">
		<td align="right"> Uso   &nbsp;</td>
		<td>							
			<html:text property="usoVenta" size="30" maxlength="30" readonly="true"/>
		</td>
		
		<td align="right"> Central   &nbsp;</td>
		<td>
			<html:select size="1" property="centralHlr" >
				<option value="">
			</html:select>									
		</td>
		
	</tr>	
	
	<tr height="25">
	    <td align="center" colspan=10>
			<img style="cursor: pointer;" src="botones/btn_bloquear.gif" name="bloquear" border="0" id="bloquear"  alt="bloquear"
			onmouseover="sobreElBoton('bloquear','botones/btn_bloquear_roll.gif')" onMouseOut="sobreElBoton('bloquear','botones/btn_bloquear.gif')" onclick="bloquearSerie('bloquear');" />
			 <img src="botones/btn_desbloquear.gif" name="desbloquear" border="0" id="desbloquear" 
			onmouseover="sobreElBoton('desbloquear','botones/btn_desbloquear_roll.gif')" onMouseOut="sobreElBoton('desbloquear','botones/btn_desbloquear.gif')" onclick="bloquearSerie('desbloquear');" />
		</td>
	</tr>	
	</table>

</html:form>
