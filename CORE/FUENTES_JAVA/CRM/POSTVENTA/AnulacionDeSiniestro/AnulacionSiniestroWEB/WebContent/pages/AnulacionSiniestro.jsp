<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO" %>
<%@ page import="com.tmmas.scl.operations.crm.fab.cusintman.web.form.AnulacionSiniestroForm" %>
<%@ page import="com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades" %>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>

<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="reqContradenuncia" value="${sessionScope.reqContradenuncia}"></c:set>
<c:set var="listSin" value="${sessionScope.listaSiniestros}" scope="session" />
<c:set var="fec_hoy" value="${sessionScope.fec_Anula}" scope="session" />
<c:out value=""/>
	
	<script>
	 function seleccionaSiniestro(siniestro){
 		//Incluido santiago ventura 23-03-2010
	 	var s = siniestro.value;
		
		<c:forEach var="sin" items="${listSin}"> 
			<c:set var="num_siniestro" value="${sin.num_siniestro}"/>
			<c:set var="num_terminal" value="${sin.num_terminal}"/>			
			<c:set var="des_terminal" value="${sin.des_terminal}"/>
			<c:set var="des_estado_d" value="${sin.des_estado_d}"/>
			<c:set var="des_causa" value="${sin.des_causa}"/>
			<c:set var="fec_siniestro" value="${sin.fec_siniestro}"/>
			<c:set var="fec_formaliza" value="${sin.fec_formaliza}"/>
			<c:if test="${not empty sin.fec_anula}">
				<c:set var="fec_anula" value="${sin.fec_anula}"/>
			 </c:if>
			<c:if test="${empty sin.fec_anula}">
				<c:set var="fec_anula" value="${fec_hoy}"/>
			 </c:if>			 					
			<c:set var="fec_restituc" value="${sin.fec_restituc}"/>
			<c:set var="num_siniestro" value="${sin.num_siniestro}"/>			
			<c:set var="num_constpol" value="${sin.num_constpol}"/>
			<c:set var="cod_causa" value="${sin.cod_causa}"/>
			
			if (s == '<c:out value="${num_siniestro}"/>') {
			
				<c:if test="${num_terminal!=null}">		
					document.getElementById("nroTerminal").value = '<c:out value="${num_terminal}"/>';	
	          	</c:if>				
				<c:if test="${num_siniestro!=null}">		
					document.getElementById("numSiniestro").value = '<c:out value="${num_siniestro}"/>';
	          	</c:if>				
				<c:if test="${des_terminal!=null}">	
						document.getElementById("tipTerminal").value = '<c:out value="${des_terminal}"/>';
	          	</c:if>	
				<c:if test="${des_estado_d!=null}">		
					document.getElementById("desEstado").value = '<c:out value="${des_estado_d}"/>';
	          	</c:if>	
				<c:if test="${des_causa!=null}">	
					document.getElementById("desCausa").value = '<c:out value="${des_causa}"/>';				
	          	</c:if>	
				<c:if test="${fec_siniestro!=null}">		
					document.getElementById("fecSiniestro").value = '<c:out value="${fec_siniestro}"/>';
	          	</c:if>	
				<c:if test="${fec_formaliza!=null}">		
					document.getElementById("fecFormalizacion").value = '<c:out value="${fec_formaliza}"/>';
	          	</c:if>	
				<c:if test="${fec_anula!=null}">			
					document.getElementById("fecAnulacion").value = '<c:out value="${fec_anula}"/>';
	          	</c:if>	
				<c:if test="${fec_restituc!=null}">		
					document.getElementById("fecRestitucion").value = '<c:out value="${fec_restituc}"/>';
	          	</c:if>	
				<c:if test="${num_constpol!=null}">	
					document.getElementById("nroConstancia").value = '<c:out value="${num_constpol}"/>';		
	          	</c:if>	
				<c:if test="${cod_causa!=null}">		
					document.getElementById("codCausa").value = '<c:out value="${cod_causa}"/>';
	          	</c:if>						
			}					
  		</c:forEach>

	 	
	}	
	// ------------------------------------------------------------------------------------------	
		// Transpasa los valores de la matriz al formulario
		function cargaFormulario(fila)	{
			document.getElementById("nroTerminal").value = arraySiniestros[fila][0];
			document.getElementById("tipTerminal").value = arraySiniestros[fila][1];
			document.getElementById("desEstado").value = arraySiniestros[fila][2];
			document.getElementById("desCausa").value = arraySiniestros[fila][3];
			document.getElementById("fecSiniestro").value = arraySiniestros[fila][4];
			document.getElementById("fecFormalizacion").value = arraySiniestros[fila][5];
			document.getElementById("fecAnulacion").value = arraySiniestros[fila][6];
			document.getElementById("fecRestitucion").value = arraySiniestros[fila][7];
			document.getElementById("nroConstancia").value = arraySiniestros[fila][8];			
			document.getElementById("numSiniestro").value = arraySiniestros[fila][9];
			document.getElementById("codCausa").value = arraySiniestros[fila][10];	
			cargaCheckListNegra();		
			
		} // cargaFormulario


	  
	// ------------------------------------------------------------------------------------------	
	
		function validaContradenuncia() {
		var nunc = '';      	
		nunc = document.getElementById("numConstaPolAnula").value;
      	if ('<c:out value="${reqContradenuncia}"/>' == 'TRUE' && nunc==''){
    	    alert('Número Constancia Policial Contradenuncia es requerido');
      	} else {
      	 	enviarFormulario();
      	 } 	   
	  }
	</script>

	<c:set var="codigoPrograma" value="${requestScope.codigoPrograma}"/> 
	<c:set var="versionPrograma" value="${requestScope.versionPrograma}" />
	
	<input type="hidden" id="btnSeleccionado" name="btnSeleccionado"/>

	<input type="hidden" id="num_abonado" name="num_abonado" value="<c:out value="${ClienteOOSS.numAbonado}"/>"/>
	<input type="hidden" id="nom_usuario" name="nom_usuario" value="<c:out value="${ClienteOOSS.usuario}"/>"/>

	<input type="hidden" id="condicionError" name="condicionError" value=""/>	
	<input type="hidden" id="mensajeError" name="mensajeError" value=""/>	
	<input type="hidden" id="mensajeStackTrace" name="mensajeStackTrace" value=""/>		
 
	<table width="100%">
	<tr height="30">
		<td class="textoSubTitulo">Seguimiento de Siniestros</td>
	</tr>

	<tr>
		<table width="100%">
		<tr>
			<td width="120">Número de Terminal</td>
			<td> <html:text style="text-align: right;" property="nroTerminal" size="15" readonly="true"/> </td>				
	
			<td width="120">Tipo Terminal</td>
			<td> <html:text property="tipTerminal" size="35" readonly="true"/> </td>				
		</tr>
		</table>				
		
	</tr>
	
	<tr height="30">
		<td class="textoSubTitulo">Campos</td>
	</tr>

	<tr>
		<td> 	
			<table width="100%">
			<tr>
				<td width="120">Número de Siniestro</td>
				<td> <html:text style="text-align: right;" property="numSiniestro" size="15" readonly="true"/> </td>				

				<td width="120">Estado</td>
				<td> <html:text property="desEstado" size="15" readonly="true"/> </td>				

				<td width="120">Código/Causa</td>
				<td> 	<html:text style="text-align: right;" property="codCausa" size="5" readonly="true"/> &nbsp;/&nbsp;
						<html:text property="desCausa" size="50" readonly="true"/> 
				</td>				
				
			</tr>				
			
			<tr>
				<td width="120">Número Constancia Policial denuncia</td>
				<td> <html:text style="text-align: right;" property="nroConstancia" maxlength="15" size="15" readonly="true"/> </td>				
				
				<td width="120">Fecha Siniestro</td>
				<td> <html:text property="fecSiniestro" maxlength="15" size="15" readonly="true" /> </td>				
				
				<td width="120">Fecha Formalización</td>
				<td> <html:text property="fecFormalizacion" maxlength="15" size="15"  readonly="true" /> 
				</td>				
			</tr>				

			<tr>
				<td colspan=2></td>
			
				<td width="120">Fecha Anulación</td>
				<td> <html:text property="fecAnulacion" maxlength="15" size="15" readonly="true"/> </td>

				<td width="120">Fecha Restitución</td>
				<td> <html:text property="fecRestitucion" maxlength="15" size="15" readonly="true"/> </td>	
			</tr>
			<tr>
				<td colspan=2 ></td>			
				<td width="120" align="left">Número Constancia Policial Contradenuncia</td>
				<td> <html:text property="numConstaPolAnula" maxlength="20" size="15"/> </td>
				<td colspan=2></td>	
			</tr>							
			</table>
		</td>
	</tr>	
	
	<!--  ------------------------------------------------------------------------------------- --> 
	<tr height="30">
		<td class="textoSubTitulo">Control</td>
	</tr>
	<tr>  
         <td width="100%"align="left">	          
			<display:table  id="siniestros" name="listaSiniestros" scope="session" pagesize="10"  width="100%">		
				<display:column align="center" title = "Seleccionar" headerClass="textoColumnaTabla" class="textoFilasColorTabla" width="5%">
					<input type="radio" name="num_siniestro" onclick="seleccionaSiniestro(this);" value='<c:out value="${siniestros.num_siniestro}"/>'>
				</display:column>			
				<display:column align="center" property="num_siniestro" title = "N&uacute;mero de Siniestro" headerClass="textoColumnaTabla" width="15%"/>					
				<display:column align="center" property="des_terminal" title = "Tipo de Terminal" headerClass="textoColumnaTabla" width="20%"/>
				<display:column align="center" property="des_estado_d" title = "Estado" headerClass="textoColumnaTabla" width="15%"/>
				<display:column align="center" property="des_causa" title = "Causa" headerClass="textoColumnaTabla" width="15%"/>
				<display:column align="center" property="fec_siniestro" title = "Fec.Siniestro" headerClass="textoColumnaTabla" width="15%"/>
				<display:column align="center" property="srt_fec_anula" title = "Fecha Anulación" headerClass="textoColumnaTabla" width="15%"/>				
				<display:column align="center" property="fec_formaliza" title = "Fec.Formalización" headerClass="textoColumnaTabla" width="30%"/>
				<display:column align="center" property="fec_restituc" title = "Fecha Restitución" headerClass="textoColumnaTabla" width="30%"/>
			</display:table>	          		
         </td>               
	</tr>	
	<tr>
		<td> 	
		  	<div id="listaNegra" style="display: none;">
			<table border=0 cellspacing=0 cellpadding=0>
		  	
		  	<tr>
		  		<td>
		  			<html:checkbox name="AnulacionSiniestroForm" property="vaListaNegra"/>
		  			Mantener la Serie en Lista Negra
		  		</td>
		  	</tr>
		  	</table>
		  	</div>
		</td>
	</tr>	
	</table>		
	<br>



	


