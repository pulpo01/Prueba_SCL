<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Telefónica Móviles .: Customer Order :.</title>
<link href="css/CustomerOrder.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="include/lib.js">
</script>
<script language="javascript" type="text/javascript">   

	function validarChecked(){	
	
		var ValorFunc = false;
		
		if (document.forms[0].checked == null){
      		alert("No existen productos a guardar")
      	}else{      	
	        for( i = 0 ; i < document.forms[0].elements.length ; i++ ){
    	    	name = document.forms[0].elements[i].name
        		if (name == "checked") {
        			if (document.forms[0].elements[i].checked) ValorFunc = true;
	        	}
    	    }      	
      	
			if(ValorFunc){
				document.forms[0].accion.value='modificar';
				document.forms[0].submit();
			}else{
				alert("Debe Seleccionar al Menos un Servicio");
			}      		      		
		}

	}      
	
	
	function validaNum(obj, valor){
	
		if (obj.value.length == 0){
			alert("El valor no debe ser nulo");
			obj.value = valor;
		}else {	
				if ( isNumber(obj) != 0){			
					alert("Debe solo ingresar números");
					obj.value = valor;
				}else{
					if (parseInt(obj.value) < parseInt(valor)){
						alert("El valor debe ser mayor al mínimo");
						obj.value = valor;
					}
				}
		}
	}    		
	function validarChecked(){	
	
		var ValorFunc = false;
		
		if (document.forms[0].checked == null){
      		alert("No existen productos a guardar")
      	}

      	
        for( i = 0 ; i < document.forms[0].elements.length ; i++ ){
        	name = document.forms[0].elements[i].name
        	if (name == "checked") {
        		if (document.forms[0].elements[i].checked) ValorFunc = true;
        	}
        }      	
      	
		if(ValorFunc){
			document.forms[0].accion.value='modificar';
			document.forms[0].submit();
		}else{
			alert("Debe Seleccionar al Menos un Servicio");
		}      		      		

	}      
	
	
	function validaNum(obj, valor){
	
		if (obj.value.length == 0){
			alert("El valor no debe ser nulo");
			obj.value = valor;
		}else {	
				if ( isNumber(obj) != 0){			
					alert("Debe solo ingresar números");
					obj.value = valor;
				}else{
					if (parseInt(obj.value) < parseInt(valor)){
						alert("El valor debe ser mayor al mínimo");
						obj.value = valor;
					}
				}
		}
	}    		
	
</script>

</head>
<body>
<%!String colorFila = null;%>

<div align="center"><html:errors bundle="errors" /> <html:form
	action="/LimiteConsumoTemporalClienteAction">
	<html:hidden property="accion" />
	
	<table class="tablaInformacion" >
		<tr>
			<td  colspan="8" align="left" class="amarillo"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Informaci&oacute;n del Cliente</strong></td>
		</tr>	
		<tr>
			<td align="left">
				<table border="0" cellpadding="0" cellspacing="0" class="bordeTablasCero">
					<jsp:include page="/datosGenerales.jsp" flush="true"></jsp:include>
				</table>
			</td>
		</tr>
        <tr>		
			<td>
				<p>&nbsp;</p>
			</td>			    
		</tr>			
        <tr>
			<td align="right">
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>                  
					    <td width="50%" colspan="8" align="left" class="amarillo" >
					      <img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Modificaci&oacute;n Temporal de Limite de Consumo por Cliente</strong>
					    </td>					
						<td width="50%" border="0" align="right" class="fondoFilaBlanco">
							<html:button styleClass="fondoFilaPlomo" value="Siguiente" property="nada" onclick="validarChecked();" />
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
			<td colspan="8" class="textcaminohormigas" align="left">
 				Limite de Consumo por Servicio Suplementario
 			</td>				           
	    </tr>				    	    																
		<tr>
			<td>				        
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr class="tablaFondoPlomo">
				    	<td width = "8%" align="center">
							<div align="center">Checked</div>
						</td>
						<td width = "8%" align="center">
							<div align="center">Servicio</div>
						</td>
						<td width = "35%" align="center">
							<div align="center">Nombre Servicio</div>
						</td>
						<td width = "10%" align="center">
							<div align="center">Limite Actual</div>
						</td>												
						<td width = "10%" align="center">
							<div align="center">Valor Minimo</div>
						</td>						
						<td width = "24%" align="center">
							<div align="center">Valor Limite de Consumo</div>
						</td>
					</tr>					           
					<logic:iterate indexId="count" id="servicio" name="limConTempList" scope="session" type="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoTemporalDTO">
						<%colorFila = null;
						if ((count.intValue() % 2) == 0) {
							colorFila = "fondoFilaBlanco";
						} else {
							colorFila = "fondoFilaPlomo";
						}%>		
						
						<%!String valLimitCons;%>						
						<%valLimitCons = servicio.getLimiteConsumido();%>
						
						<tr class="<%=colorFila%>">
							<td align="center"><html:multibox value="<%=String.valueOf(servicio.getCodigoServicio())%>" property="checked"/></td>
    			            <td align="center"><bean:write name="servicio" property="codigoServicio" /></td>
				            <td align="left"><bean:write name="servicio" property="nombreServicio" /></td>    			
				            <td align="right"><bean:write name="servicio" property="limiteActual" /></td> 
				            <td align="right"><bean:write name="servicio" property="limiteConsumido" /></td> 				               							            
				            <td align="right"><input type="text" name="valorAsignado" value="<%=servicio.getLimiteActual()%>" onblur="validaNum(this,<%=servicio.getLimiteConsumido()%>);"  align="right" class="normal"></td>
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
			<td td align="right">
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>  										                
						<td width="100%" border="0" align="right" class=fondoFilaBlanco>
							<html:button styleClass="fondoFilaPlomo" value="Siguiente" property="nada" onclick="validarChecked();" />
					    </td>				                    
					</tr>					            
				</table>    
			</td>
		</tr>					  
	</table>				    
</html:form></div>
</body>
</html:html>

