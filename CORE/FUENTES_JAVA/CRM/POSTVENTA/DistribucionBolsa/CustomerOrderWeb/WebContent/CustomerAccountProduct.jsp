<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>


<%@page import="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO"%>
<%@page import="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO"%>


<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Servicios Suplementarios :.</title>
<link href="css/CustomerOrder.css" rel="stylesheet" type="text/css">

<script type='text/javascript' src='/CustomerOrderWeb/dwr/engine.js'></script>
<script type='text/javascript' src='/CustomerOrderWeb/dwr/util.js'></script>
<script type='text/javascript' src='/CustomerOrderWeb/dwr/interface/CustomerOrderValidate.js'></script>
<script type='text/javascript' src='/CustomerOrderWeb/customerOrder.js'></script>

<script language="javascript" type="text/javascript">
      function ValGuardar(){
        var chequeado = false
        var unchequeado = false
        
        for( i = 0 ; i < document.forms[0].elements.length ; i++ ){
        	name = document.forms[0].elements[i].name
        	if (name == "checkedInstall"){
        		if (!document.forms[0].elements[i].checked){
        			chequeado = true;
        		}
        	}
        }
        
        for( i = 0 ; i < document.forms[0].elements.length ; i++ ){
        	name = document.forms[0].elements[i].name
        	if (name == "checkedUnInstall"){
        		if (document.forms[0].elements[i].checked){
        			unchequeado = true;
        		}
        	}
        }
        
        if (unchequeado || chequeado){
        	document.forms[0].accion.value='modificar';
        	document.forms[0].submit();
        }else{
        	alert("Debe agregar o eliminar algun servicio")                	
        }
                
      }
     
</script>



</head>
<body>


<%!String colorFila = null;%>

<div align="center"><html:errors bundle="errors" /> 
	<html:form action="/CustomerAccountProductAction">
	<html:hidden property="accion" />
<logic:equal name="CustomerAccountProductForm" property="accion" value="mostrar">	

    <input type=hidden name="codCliente" value="<%=((CustomerOrderSessionDTO)session.getAttribute("CustomerOrder")).getCode()%>"> 

	<table class="tablaInformacion" >
		<tr>
			<td  colspan="7" align="left" class="amarillo"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Informaci&oacute;n del Cliente</strong></td>
			<td>Version 1.3</td>
		</tr>	
		<tr>
			<td align="left">
				<table border="0" cellpadding="0" cellspacing="0" class="bordeTablasCero">
					<jsp:include page="/datosGenerales.jsp" flush="true"></jsp:include>
				</table>
			</td>
		</tr>
	    
        <tr>
			<td td align="right">
				<table border="0" cellspacing="1" cellpadding="2">
					<tr>                  

					</tr>					            
				</table>    
			</td>
		</tr>				
        <tr>
			<td align="right">
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>                  
					    <td width="50%" colspan="8" align="left" class="amarillo" >
					      <img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Servicios Suplementario</strong>
					    </td>					
						<td width="50%" border="0" align="right" class="fondoFilaBlanco">
							<html:button styleClass="fondoFilaPlomo" value="Siguiente" property="nada" onclick="ValGuardar();" />
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
			<td colspan="8" class="textcaminohormigas" align="left">Servicios Contratados</td>
		</tr>					    								    
		<tr>
			<td>				        
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr class="tablaFondoPlomo" >
						<td width = "10%">
							<div align="center">Checked&nbsp;&nbsp;&nbsp;</div>
						</td>
						<td width = "30%">
							<div align="center">Codigo de Servicio&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</td>
						<td width = "60%">
							<div align="center">Descripcion de Servicio&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</td>
					</tr>									    
					<logic:iterate indexId="count" id="installed" name="installedProductBundleList" scope="session" type="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO">
						<%colorFila = null;
						if ((count.intValue() % 2) == 0) {
							colorFila = "fondoFilaBlanco";
						} else {
							colorFila = "fondoFilaPlomo";
						}%>		                    
						<tr class="<%=colorFila%>">												    						
    			        	<td align="center"><input type="checkbox"  name="checkedInstall" value="<%=String.valueOf(installed.getId())%>" checked="checked" onclick="validaAccesoServiciosInstalados(value)" disabled="true"/></td>
				            <td align="center"><bean:write name="installed" property="id" /></td>    			
				            <td align= "justify"><bean:write name="installed" property="name" /></td>    			
						</tr>
					</logic:iterate >		
				</table>
			</td>
		</tr>
		<tr>
			<td>				        
				<p>&nbsp;</p>
			</td>	
		</tr>				        
		<tr>	
			<td colspan="7" class="textcaminohormigas" align="left">Servicios Opcionales</td>
		</tr>					    							        				    
		<tr>
			<td>				        
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr class="tablaFondoPlomo">
						<td width = "10%">
							<div align="center">Checked&nbsp;&nbsp;&nbsp;</div>
						</td>
						<td width = "30%">
							<div align="center">Codigo de Servicio&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</td>
						<td width = "60%">
							<div align="center">Descripcion de Servicio&nbsp;&nbsp;&nbsp;&nbsp;</div>
						</td>
					</tr>	
					<logic:iterate indexId="count" id="unInstalled" name="unInstalledProductBundleList" scope="session" type="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO">
						<%colorFila = null;
						if ((count.intValue() % 2) == 0) {
							colorFila = "fondoFilaBlanco";
						} else {
							colorFila = "fondoFilaPlomo";
						}%>		                    
                        <tr class="<%=colorFila%>">
    			        	<td align="center"><html:multibox value="<%=String.valueOf(unInstalled.getId())%>" property="checkedUnInstall" onclick="validaAccesoServiciosNoInstalados(value)" disabled="true"/></td>
				            <td align="center"><bean:write name="unInstalled" property="id" /></td>    			
				            <td align="justify"><bean:write name="unInstalled" property="name" /></td>    			
						</tr>
					</logic:iterate >		
				</table>
			</td>
		</tr>				    			        
		<tr>
			<td align="center">
				<table border="0" cellspacing="1" cellpadding="2" align="right">
					<tr>
						<td border="0" align="right" class="fondoFilaBlanco">
							<html:button styleClass="fondoFilaPlomo" value="Siguiente" property="nada" onclick="ValGuardar();"/>
						</td>				                    					                
					</tr>					            
				</table>    
			</td>
		</tr>				    								    
	</table>			
</logic:equal>	
	</html:form>
</div>
</body>
</html>				    
				    
				        