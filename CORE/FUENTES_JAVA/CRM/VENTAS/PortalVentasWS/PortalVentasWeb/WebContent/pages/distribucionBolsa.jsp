<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page import="com.tmmas.cl.scl.portalventas.web.dto.CustomerOrderSessionDTO"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Destribución Unidades Libres Cliente :.</title>
<link href="css/customerorder.css" rel="stylesheet" type="text/css">
<script type='text/javascript' src='<%=request.getContextPath()%>/js/distribucionBolsa.js'></script>
<%if(session.getAttribute("inicio") == null){%>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/distribucionBolsaUtil.js'></script>
<%}
CustomerOrderSessionDTO cust = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
%>
</head>
<body>
<%!String colorFila = null;%>
<%!public String getColorFila(Integer countNum)
  	{
		colorFila = null;
		if ((countNum.intValue() % 2) == 0) {
			colorFila = "fondoFilaBlanco";
		} else {
			colorFila = "fondoFilaPlomo";
		}
		return colorFila;
  	}
%>

<div align="center"><html:errors bundle="errors" /> 
<html:form action="/DistribucionBolsaAction">
<html:hidden property="opcion" value="cargarAbonados" styleId="opcion"/>
<input type="hidden" name="nombreCliente" id="nombreCliente" value="<%=cust.getNames()%>"/>
	  <P>
		<table width="80%" border="0" >
		  <tr>
		     <td class="mensajeError"><div id="mensajes" class="mensajeError"></div></td>
		  </tr> 
		</table>		  
	  <P>
	<table class="tablaInformacion">
		<tr>
			<td  colspan="8" align="left" class="amarillo"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Informaci&oacute;n del Cliente</strong></td>
		</tr>	
		<tr>
			<td align="left">
				<table border="0" cellpadding="0" cellspacing="0" class="bordeTablasCero">
					<jsp:include page="/pages/datosGenerales.jsp" flush="true"></jsp:include>
					<tr>
						<td width=30% class="amarilloInfClie"><strong>Plan Tarifario</strong></td>
						<td width=5% class="amarilloInfClie">:</td>
						<td class="valorCampoSeleccionable" >
						<script language="JavaScript" type="text/javascript">
						freeUnits = <%=cust.getFreeUnits()%>;
						mensaje = '<%=request.getAttribute("mensaje")%>';
						</script>
						<logic:present name="planes" scope="session">
						<script language="JavaScript" type="text/javascript">distribucionCompleta='<bean:write name='planes' property='distribucionCompleta'/>'</script>					
						<bean:define id="planTarifArr" name="planes" type="com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDistDTO[]"  property="planesTarifarios"/>
						<html:select property="planCB" styleId="planCB" onchange="validaComboPlanTarif(this)">
						    <html:option value="sel">- Seleccione -</html:option>
						<logic:iterate  indexId="indexPlan" id="planTarif" name="planTarifArr"  type="com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDistDTO"> 	
							<html:option style="<%=String.valueOf(planTarif.getEstilo())%>" value="<%=String.valueOf(planTarif.getCodigoPlanTarifario())%>"><bean:write name="planTarif" property="descripcionPlanTarifario"/> </html:option>		  							  
						</logic:iterate>
						</html:select>
						</logic:present>						
						</td>
					</tr>
					<% 
					if(session.getAttribute("inicio") == null){%>								
						<html:hidden property="unidadesLibres" styleId="unidadesLibres" value="<%=String.valueOf(cust.getFreeUnits())%>"/>
						<td class="amarilloInfClie"><strong>Unidades Libres</strong></td>
						<td class="amarilloInfClie">:</td>
						<td class="amarilloInfClie"><div id="divFreeUnits" ><%=cust.getFreeUnits()%></div></td>
						</tr><%
					}
					%>
				</table>
			</td>
		</tr>
		<% 
		if(session.getAttribute("inicio") == null){%>
        <tr>		
			<td>
				<br><strong>La distribuci&oacute;n por porcentaje, realiza una aproximaci&oacute;n en minutos a la cota inferior, en caso de haber excedente, se carga a la bolsa del siguiente abonado</strong>
			</td>			    
		</tr>			
        <tr>
			<td align="right">
			   <br>
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>                  
					    <td width="50%" colspan="8" align="left" class="amarillo" >
					      <img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Distribucion de Bolsa</strong>
					    </td>					
						<td width="50%" border="0" align="right" class="fondoFilaBlanco">
							<html:button styleClass="fondoFilaPlomo" value="Aceptar Distribucion del Plan" property="nada" styleId="nada" onclick="validaguardar('dp');" />
					    </td>				                    
					</tr>					            
				</table>    
			</td>
		</tr>
		<tr>
			<td>
				<p>&nbsp;</p>
			</td>			    
	    </tr>
	    <tr>
			<td colspan="7" class="textcaminohormigas" align="left">
 				Unidades Libres por Abonado
 			</td>			
	    </tr>			
		<tr>
			<td>
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
				  <div id="radios">
					<tr>     
						<td  width = "8%" align="left">Unidades&nbsp;<html:radio property="unidadesA" styleId="unidadesA" value="1" onclick="cambiaValores()"/>
						</td>
						<td  width = "8%" align="left">Porcentaje&nbsp;<html:radio property="unidadesA" styleId="unidadesA" value="2" onclick="cambiaValores()"/>
						</td>					
						<td width = "84%" align="right">
					 		<html:button styleClass="fondoFilaPlomo" value="Distribucion Equitativa" property="btnDistEqui" styleId="btnDistEqui" onclick="disEquitativa()" />
						</td>         
					</tr>
				  </div>				            
				</table>    
			</td>
		</tr>				  
		<tr>
			<td>				        
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr class="tablaFondoPlomo">
						<td width = "20%" align="center">
							<div align="center">Identificacion Abonado</div>
						</td>
						<td width = "20%" align="center">
							<div align="center">Numero de Celular</div>
						</td>
						<td width = "20%" align="center">
							<div align="center">Unidades Libres</div>
						</td>             
						<td width = "20%" align="center">
							<div align="center">Conversi&oacute;n</div>
						</td>
					</tr>
					<logic:iterate indexId="count" id="abonado" name="involvementsList" scope="session" type="com.tmmas.cl.scl.productdomain.businessobject.dto.BolsaAbonadoDTO">
						<tr class="<%=getColorFila(count)%>">
							<td align="center"><bean:write name="abonado" property="num_abonado" /></td>
    			            <td align="center"><bean:write name="abonado" property="num_celular" /></td>
				            <td align="right"><html:text styleClass="normal"  value="0" property="minutesToAssign"  styleId="minutesToAssign"
				            onblur='<%=String.valueOf("ValidaSuma(" + count + ");")%>'/></td>
				            <td align="right"><input type="text" disabled="disabled" id="prcToAssign<%=count.intValue()%>" name="conversion" value="0"/></td>
						</tr>
						<script language="javascript" type="text/javascript">
						prcToAssignArr[cantidadElementos]     = '<bean:write name="abonado" property="prc_unidad" />';
						minutesToAssignArr[cantidadElementos] = '<bean:write name="abonado" property="cnt_unidad" />';
						cantidadElementos++;
						</script>
					</logic:iterate >		
				</table>
			</td>
		</tr>
		<tr>
			<td>				        
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>
						<td align="right">
							Total <html:text styleClass="normal" property="minutosTotal" styleId="minutosTotal" disabled="true" value="0"/>
						</td>
					</tr>
				</table>
			</td>							     
		</tr>		
		<tr>
			<td>
				<p>&nbsp;</p>
			</td>
		</tr>
        <tr>
			<td td align="right">
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>  										                
						<td width="100%" border="0" align="right" class=fondoFilaBlanco>
							<html:button styleClass="fondoFilaPlomo" value="Aceptar Distribucion del Plan" property="nada" styleId="nada" onclick="validaguardar('dp');" />
					    </td>				                    
					</tr>					            
				</table>    
			</td>
		</tr>
        <tr>
			<td td align="right">
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>  										                
						<td width="100%" border="0" align="right" class=fondoFilaBlanco>
							<html:button styleClass="fondoFilaPlomo" value="Aceptar Distribucion General" property="btnDistCompleta" styleId="btnDistCompleta" onclick="validaguardar('dc');" />
					    </td>				                    
					</tr>					            
				</table>    
			</td>
		</tr>
		<%}%>				  
	</table>
	<% 
	if(session.getAttribute("inicio") == null){%>
	<script>
		document.forms[0].unidadesA[0].checked = true;
		verificarCantidadAbonados();
	</script>
	<%}%>
	</html:form>
</div>
</body>
</html>