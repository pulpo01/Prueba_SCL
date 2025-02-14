<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:set var="codigoPrograma" value="${requestScope.codigoPrograma}" />
<c:set var="versionPrograma" value="${requestScope.versionPrograma}" />

<input type="hidden" id="btnSeleccionado" name="btnSeleccionado" />
<input type="hidden" id="flagCrearPeriodo" name="flagCrearPeriodo" />

<input type="hidden" id="condicionError" name="condicionError" value="" />
<input type="hidden" id="mensajeError" name="mensajeError" value="" />
<input type="hidden" id="mensajeStackTrace" name="mensajeStackTrace" value="" />

<table width="100%">
	<tr height="10" align="center">
		<td colspan="6">&nbsp;</td>
	</tr>

	<tr height="30">
		<td class="textoSubTitulo">Consulta de suspensiones</td>
	</tr>
	<tr>
		<td align="center">
			<table width="100%">
			<tr>
				<td width="120">Fecha Desde </td>
				<td> <html:text readonly="true" tabindex="1" size="15" property="fechaDesde"/>
					<a href="#" onclick="displayCalendar(document.forms[0].fechaDesde,'dd/mm/yyyy',this); return false;"><img src="../suspensionVol/img/calendar.gif" border="0" alt="Seleccionar Fecha"></a></td>
	
				<td width="120">Fecha Hasta </td>
				<td> <html:text readonly="true" tabindex="2" size="15" property="fechaHasta"/>
					<a href="#" onclick="displayCalendar(document.forms[0].fechaHasta,'dd/mm/yyyy',this); return false;"><img src="../suspensionVol/img/calendar.gif" border="0" alt="Seleccionar Fecha"></a></td>
			</tr>
			<tr>
				<td colspan="6" align="center"><br>
					<img border=0 src="../suspensionVol/botones/btn_consultar.gif" alt="" onclick="submitForm('consultar');">
				</td>
			</tr>
			</table>
		</td>
	</tr>

	<tr height="10" align="center">
		<td colspan="6">&nbsp;</td>
	</tr>
	
			
	<!-- Si encontro datos -->
	<c:if test="${suspensionesAbonado != null}">
		<tr height="30">
			<td class="textoSubTitulo">Suspensiones del Abonado</td>
		</tr>
		<tr>
			<td align="center">
	           <div style="overflow: auto;width:1200px; height:400px; SCROLLBAR-FACE-COLOR:#EBE9DC; BORDER-LEFT-COLOR: #EBE9DC BORDER-BOTTOM-COLOR: #EBE9DC; BORDER-TOP-COLOR: #EBE9DC; BORDER-RIGHT-STYLE: #EBE9DC;  ">
				<table width='1180' border="0" cellpadding="3" cellspacing="3" >
				<tr class="textoColumnaTabla">
				<td class="textoColumnaTabla">Código de Suspensión</td>			
				<td class="textoColumnaTabla">Fecha de Solicitud</td>			
				<td class="textoColumnaTabla">Causa</td>			
				<td class="textoColumnaTabla">Fecha Suspensión</td>			
				<td class="textoColumnaTabla">Fecha Rehabilitación</td>			
				<td class="textoColumnaTabla">Fecha Actualización</td>			
				<td class="textoColumnaTabla">Primer Periodo</td>			
				<td class="textoColumnaTabla">Días del Primer Periodo</td>			           		
				<td class="textoColumnaTabla">Segundo Periodo</td>			
				<td class="textoColumnaTabla">Días del Segundo Periodo</td>			
				<td class="textoColumnaTabla">Estado</td>		
				<td class="textoColumnaTabla">Usuario</td>		
				<td class="textoColumnaTabla">OOSS Suspensión</td>			
				<td class="textoColumnaTabla">OOSS Rehabilitación</td>												
				
			</td>
		</tr>
	
		<logic:iterate id="suspensiones" name="suspensionesAbonado">
			<tr class="textoFilasTabla">

			<td align=right><bean:write name="suspensiones" property="num_det_sus_vol_prg"/></td>
			<td><fmt:formatDate value="${suspensiones.fechaSolicitud}" pattern="dd/MM/yyyy"/></td>
			<td><bean:write name="suspensiones" property="causaSuspension.descripcionCausa"/></td>
			<td><fmt:formatDate value="${suspensiones.fechaSuspension}" pattern="dd/MM/yyyy"/></td>
			<td><fmt:formatDate value="${suspensiones.fechaRehabilitacion}" pattern="dd/MM/yyyy"/></td>
			<td><fmt:formatDate value="${suspensiones.fechaActualizacion}" pattern="dd/MM/yyyy"/></td>			
			<td>
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<td>
							<fmt:formatDate value="${suspensiones.fechaInicioPeriodo1}" pattern="dd/MM/yyyy"/>&nbsp;-
						</td>
					</tr>
					<tr>
						<td>
							<fmt:formatDate value="${suspensiones.fechaFinPeriodo1}" pattern="dd/MM/yyyy"/>
						</td>
					</tr>
				</table>
			</td>
			<td align=right><bean:write name="suspensiones" property="diasSus1"/></td>			
			<td>
				<table border="0" cellspacing="0" cellpadding="0" width="100%">
					<tr>
						<td>
							<c:if test="${suspensiones.fechaInicioPeriodo2 != null}">
								<fmt:formatDate value="${suspensiones.fechaInicioPeriodo2}" pattern="dd/MM/yyyy"/>&nbsp;-
							</c:if>
						</td>
					</tr>
					<tr>
						<td>
							<fmt:formatDate value="${suspensiones.fechaFinPeriodo2}" pattern="dd/MM/yyyy"/>
						</td>
					</tr>
				</table>
			</td>
			<td align=right>
				<c:if test="${suspensiones.diasSus2 != 0}">
					<bean:write name="suspensiones" property="diasSus2"/>
				</c:if>
			</td>			
			<td><bean:write name="suspensiones" property="estado"/></td>			
			<td><bean:write name="suspensiones" property="usuario"/></td>			
			<td align=right><bean:write name="suspensiones" property="numOsSus"/></td>			
			<td align=right><bean:write name="suspensiones" property="numOsReh"/></td>						
		</logic:iterate>
	</c:if>					
	
</table>






