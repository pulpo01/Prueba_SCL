<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades" %>
<script type='text/javascript' src='serviciosSup/js/serviciosSup.js'></script>
<script type='text/javascript' src='js/serviciosSup.js'></script>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

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
	<input type="hidden" id="showVendedor" name="showVendedor" value="<c:out value="${requestScope.showVendedor}"/>"/>	
	<input type="hidden" name="contextpathSS" id="contextpathSS"  value="<c:out value="${pageContext.request.contextPath}"/>"/>
	
	<input type="hidden" name="grabarFax" id="grabarFax"  value="false"/>	

	<c:set var="codigoPrograma" value="${requestScope.codigoPrograma}"/> 
	<c:set var="versionPrograma" value="${requestScope.versionPrograma}" />
	
	<input type="hidden" id="btnSeleccionado" name="btnSeleccionado"/>

	<!--  Para almacenar los codigos de servicios a procesar -->
	<input type="hidden" id="contratadosTabla" name="contratadosTabla"/>
	<input type="hidden" id="nocontratadosTabla" name="nocontratadosTabla"/>
	<!--  Para transferir los contactos de asitencia -->	
	<input type="hidden" id="contactosTabla" name="contactosTabla"/>	
	<!--  aqui se agregan los codigos de grupo y nivel para cada SS a contratar. -->	
	<input type="hidden" id="adelantadosTabla" name="adelantadosTabla"/>	

	<input type="hidden" id="textoNoContratados" name="textoNoContratados"/>
	<input type="hidden" id="textoContratados" name="textoContratados"/>

	<input type="hidden" id="condicionError" name="condicionError" value=""/>	
	<input type="hidden" id="mensajeError" name="mensajeError" value=""/>	
	<input type="hidden" id="mensajeStackTrace" name="mensajeStackTrace" value=""/>		
 
	<table width="100%">
	<tr height="30">
		<td class="textoSubTitulo">Servicios por Defecto</td>
	</tr>
	<tr>
		<td align="center"> 	
			<div style="overflow: auto;width:1150px; height:105px; SCROLLBAR-FACE-COLOR:#EBE9DC; BORDER-LEFT-COLOR: #EBE9DC BORDER-BOTTOM-COLOR: #EBE9DC; BORDER-TOP-COLOR: #EBE9DC; BORDER-RIGHT-STYLE: #EBE9DC;  ">
			<table width="1130" border="0" cellpadding="3" cellspacing="3" id="tblServAct">
			<tr class="textoColumnaTabla">
				<td width="70"><b>Activar</b></td>			
				<td width="65" class="textoColumnaTabla">Código</td>
				<td width="65" class="textoColumnaTabla">Grupo</td>
				<td width="65" class="textoColumnaTabla">Nivel</td>
				<td class="textoColumnaTabla">Servicio</td>
				<td class="textoColumnaTabla">Tarifa Conexión</td> 
				<td class="textoColumnaTabla">Tarifa Mensual</td> 
			</tr>			
		
			<%
			try {
				String html1 = null;
		        // Genero la matriz con los datos de los cargos
		        html1 = Utilidades.generaTablaServDefault(request);
		      	out.println(html1);
			}
			catch (Exception ex)	{
				ex.printStackTrace();
			}
		 	%>
			</table>
			</div>
		</td>				
	</tr>
		
	<tr height="10" align="center">
		<td colspan=6>&nbsp;</td>
	</tr>		
			
	<tr height="30">
		<td class="textoSubTitulo">Servicios Activados</td>
	</tr>
	<tr>
		<td align="center"> 	
			<div style="overflow: auto;width:1150px; height:105px; SCROLLBAR-FACE-COLOR:#EBE9DC; BORDER-LEFT-COLOR: #EBE9DC BORDER-BOTTOM-COLOR: #EBE9DC; BORDER-TOP-COLOR: #EBE9DC; BORDER-RIGHT-STYLE: #EBE9DC;  ">
			<table width="1130" border="0" cellpadding="3" cellspacing="3">
			<tr class="textoColumnaTabla">
				<td width="70"><b>Activar</b></td>			
				<td width="65" class="textoColumnaTabla">Código</td>
				<td width="65" class="textoColumnaTabla">Grupo</td>
				<td width="65" class="textoColumnaTabla">Nivel</td>
				<td class="textoColumnaTabla">Servicio</td>
				<td class="textoColumnaTabla">Tarifa Conexión</td> 
				<td class="textoColumnaTabla">Tarifa Mensual</td> 
			</tr>			
		
			<%
			try {
				String html1 = null;
		        // Genero la matriz con los datos de los cargos
		        html1 = Utilidades.generaTablaServAct(request);
		      	out.println(html1);
			}
			catch (Exception ex)	{
				ex.printStackTrace();
			}
		 	%>
			</table>
			</div>
		</td>				
	</tr>
		
	<tr height="10" align="center">
		<td colspan=6>&nbsp;</td>
	</tr>		
			
	<tr height="30">
		<td class="textoSubTitulo">Servicios Disponibles</td>
	</tr>

	<tr>
		<td align="center"> 	
			<table width="1150" border="0" cellpadding="5" cellspacing="0">
			<tr class="textoColumnaTabla">
				<td colspan=2 class="textoColumnaTabla" align=left>
					BUSCAR CODIGO &nbsp;&nbsp;
					<html:text property="codSearch" size="5" maxlength="5"/>
					<input type=button value="Buscar" onclick="buscarCodigo();" style="width:80px;font-face:verdana;color:#000000">
				</td>
			</tr>
			</table>
			
			<div style="overflow: auto;width:1150px; height:200px; SCROLLBAR-FACE-COLOR:#EBE9DC; BORDER-LEFT-COLOR: #EBE9DC BORDER-BOTTOM-COLOR: #EBE9DC; BORDER-TOP-COLOR: #EBE9DC; BORDER-RIGHT-STYLE: #EBE9DC;  ">
			<table width="1130" border="0" cellpadding="3" cellspacing="3"  id="tblServDisp">
			<tr class="textoColumnaTabla">
				<td width="70"><b>Activar</b></td>			
				<td width="65" class="textoColumnaTabla">Código</td>
				<td width="65" class="textoColumnaTabla">Grupo</td>
				<td width="65" class="textoColumnaTabla">Nivel</td>
				<td class="textoColumnaTabla">Servicio</td>
				<td class="textoColumnaTabla">Tarifa Conexión</td> 
				<td class="textoColumnaTabla">Tarifa Mensual</td> 
			</tr>			
		
			<%
			try	{
				String html2 = null;
		        // Genero la matriz con los datos de los cargos
		        html2 = Utilidades.generaTablaServDisp(request);
		      	out.println(html2);
			}
			catch (Exception ex)	{
				ex.printStackTrace();
			}
		 	%>
			</table>		
			</div>
		</td>
	</tr>	
	
	<!--  ------------------------------------------------------------------------------------- --> 
	</table>
	
	<br>

	<script>
		<%
		try	{
			String html3 = null;
	        // Genero la matriz con los datos de los cargos
	        html3 = Utilidades.generaMatricesServSup(request);
	      	out.println(html3);
		}
		catch (Exception ex)	{
			ex.printStackTrace();
		} 	
		%>
		// ------------------------------------------------------------------------------------------------------------------------
	</script>
	
