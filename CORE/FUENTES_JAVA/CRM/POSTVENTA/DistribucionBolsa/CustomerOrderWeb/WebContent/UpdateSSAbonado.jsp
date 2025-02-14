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
      function selectAll(){
        seleccionar = null;
        if( document.forms[0].todas.checked ){
          seleccionar = true;
        }
        else{
          seleccionar = false;
        }
        for( i = 0 ; i < document.forms[0].elements.length ; i++ ){
        	name = document.forms[0].elements[i].name
        	if (name == "numProduct") document.forms[0].elements[i].checked = seleccionar;
        }
      }
      
      function guardar(){
    
      	var forma = document.forms[0];
      	
     	var i;
      	var chequeado = false
      	
      	if (document.forms[0].numProduct == null){
      		alert("No existen productos a guardar")
      		return false             	
      	}
      	
        for( i = 0 ; i < document.forms[0].elements.length ; i++ ){
        	name = document.forms[0].elements[i].name
        	if (name == "numProduct") {
        		if (document.forms[0].elements[i].checked) chequeado = true;
        	}
        }      	
        if (!chequeado) {
      		alert("Debe seleccionar al menos un producto")
      		return false        
        }
	    forma.accion.value='Guardar';
	    forma.submit()
	    return true
      }   
      
      
      function Actualizar(editar) {
      	var forma = document.forms[0];
      	forma.editar.value= editar;
      	if (typeof(forma.priority) != 'undefined') {
	      	var resp = isNotEmpty(forma.priority)
	      	if (resp == false) {
	      		alert('El campo prioridad no puede ser vacío')
	      		return false;
	      	}
	      	
	     	resp = IsNumeric(forma.priority.value)
	     	
	      	if (resp == false) {
	      		alert('El campo prioridad no es un número')
	      		return false;
	      	}     	
      	}     	
      	
      	forma.accion.value='Actualizar';
      	forma.submit()

      }
    </script>

</head>
<body>
<%!String colorFila = null;%>

<div align="center"><html:errors bundle="errors" /> <html:form
	action="/UpdateSSAbonadoAction">
	<html:hidden property="editar" />
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
					    <td width="80%" colspan="8" align="left" class="amarillo" >
					      <img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Modificación de Atributos de Servicios Suplementarios a Nivel de Abonado</strong>
					    </td>					
						<td width="20%" border="0" align="right" class="fondoFilaBlanco">
							<html:button styleClass="fondoFilaPlomo" value="Siguiente" property="nada" onclick="return guardar()" />
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
			<td colspan="8" class="textcaminohormigas" align="left">Servicios Suplementario</td>
		</tr>					    								    	
	
		<tr>
			<td>
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr class="tablaFondoPlomo">
						<td width = "3%">
							<html:checkbox property="todas" onclick="selectAll();" />
						</td>
						<td width = "7%">
							<div align="center">C&oacute;digo</div>
						</td>
						<td width = "25%">
							<div align="center">Descripci&oacute;n</div>
						</td>
						<td width = "10%">
							<div align="center">Prioridad</div>
						</td>
						<td width = "25%">
							<div align="center">Desborde</div>
						</td>
						<td width = "28%">
							<div align="center">Perfil</div>
						</td>
						<td width = "5%">
							<div align="center">Editar</div>
						</td>
					</tr>				
						<logic:iterate indexId="count" id="fila"
							name="UpdateSSAbonadoForm" property="listaProductos"
							type="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO">



							<logic:equal name="UpdateSSAbonadoForm" property="editar"
								value="<%=String.valueOf(count.intValue())%>">
								<%String colorFila = null;
			if ((count.intValue() % 2) == 0) {
				colorFila = "fondoFilaBlanco";
			} else {
				colorFila = "fondoFilaPlomo";
			}%>

								<tr class="<%=colorFila%>">
									<td><html:multibox
										value="<%=String.valueOf(count.intValue())%>"
										property="numProduct" /></td>
									<td>
									<div align="center"><bean:write name="fila" property="id" /></div>
									</td>
									<td>
									<div align="center"><bean:write name="fila" property="name" /></div>
									</td>

									<c:choose>
										<c:when test="${fila.update}">
											<td>
											<div align="center"><html:text property="priority"
												styleClass="<%=colorFila%>" tabindex="1" /></div>
											</td>
											<td>
											<div align="center"><html:select styleClass="normal"
												property="exceedId">
												<logic:iterate indexId="i" id="desborde"
													name="listaDesbordesporAbonado" scope="session"
													type="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DesbordeDTO">
													<html:option
														value="<%=String.valueOf(desborde.getCodigoDesborde())%>">
														<%=String.valueOf(desborde.getDescripcionDesborde())%>
													</html:option>
												</logic:iterate>
											</html:select></div>
											</td>
										</c:when>
										<c:when test="${!fila.update}">
											<td>
											<div align="center"><bean:write name="fila"
												property="priority" /></div>
											</td>
											<td>
											<div align="center"><bean:write name="fila"
												property="descExceedId" /></div>
											</td>

										</c:when>
									</c:choose>
									<td>
									<div align="center"><html:select styleClass="normal"
										property="profileId">
										<logic:iterate indexId="j" id="limiteConsumo"
											name="listaLimiteConsumo" scope="request"
											type="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO">
											<html:option
												value="<%=String.valueOf(limiteConsumo.getProfileId())%>">
												<%=String.valueOf(limiteConsumo.getDescProfileId())%>
											</html:option>
										</logic:iterate>
									</html:select></div>
									</td>
									<td>
									<div align="center"><input type="button" value="Actualizar"
										class="fondoFilaPlomo"
										onclick="return Actualizar('<%=String.valueOf(count.intValue())%>')" />
									</div>
									</td>
								</tr>
							</logic:equal>



							<logic:notEqual name="UpdateSSAbonadoForm" property="editar"
								value="<%=String.valueOf(count.intValue())%>">

								<%colorFila = null;
			if ((count.intValue() % 2) == 0) {
				colorFila = "fondoFilaBlanco";
			} else {
				colorFila = "fondoFilaPlomo";
			}%>
								<tr class="<%=colorFila%>">
									<td><html:multibox
										value="<%=String.valueOf(count.intValue())%>"
										property="numProduct" /></td>
									<td>
									<div align="center"><bean:write name="fila" property="id" /></div>
									</td>
									<td>
									<div align="center"><bean:write name="fila" property="name" /></div>
									</td>
									<td>
									<div align="center"><bean:write name="fila" property="priority" /></div>
									</td>
									<td>
									<div align="center"><bean:write name="fila"
										property="descExceedId" /></div>
									</td>
									<td>
									<div align="center"><bean:write name="fila"
										property="descProfileId" /></div>
									</td>
									<td>
									<div align="center"><input type="button" value="Editar"
										class="fondoFilaPlomo"
										onclick="accion.value='Editar';editar.value='<%=String.valueOf(count.intValue())%>';submit();" />
									</div>
									</td>
								</tr>
							</logic:notEqual>

						</logic:iterate>
				</table>
			</td>										
		</tr>
		
		<tr>
			<td align="center">
				<table border="0" cellspacing="1" cellpadding="2" align="right">
					<tr>
						<td border="0" align="right" class="fondoFilaBlanco">
							<html:button styleClass="fondoFilaPlomo" value="Siguiente" property="nada" onclick="return guardar()"/>
						</td>				                    					                
					</tr>					            
				</table>    
			</td>
		</tr>				    								    	
	</table>
</html:form></div>
</body>
</html:html>

