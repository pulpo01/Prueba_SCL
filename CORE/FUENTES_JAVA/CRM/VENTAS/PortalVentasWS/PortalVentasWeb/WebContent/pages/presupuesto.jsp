<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JCargosAJAX.js'></script>
<script>
  	window.history.forward(1);

  	var puedeDistribuir = '<%=request.getAttribute("puedeDistribuir")%>';
  
	function fncInicio() {
		formatoDecimales($("txtParamDecForm").value);  	    
    	var valor = $("totalConceptos").value;
    	if (parseFloat(valor) == 0) {
      		document.getElementById("btnImprimir").disabled = true;	
    	}
    	else {
    		document.getElementById("btnImprimir").disabled = false;	
    	}
    	
	   	/* Incidencia 134089. Combobox de preactivacion debe quedar solo lectura y con valor SI  */
		/* en venta prepago, cuando existe el parámetro.  Aplica a TMS y TMG. */
	   	var codTipoCliente = '<bean:write name="CargosForm" property="codTipoCliente" />';
		var codTipoClientePrepago = '<bean:write name="CargosForm" property="codTipoClientePrepago" />';
		var preactivacionSoloLectura = '<bean:write name="CargosForm" property="preactivacionSoloLectura" />';
		
		if ( codTipoCliente == codTipoClientePrepago && preactivacionSoloLectura == 'SI' ) {
	  		document.getElementsByName("preactivacion")[0].setAttribute("disabled", "disabled");
	  	}
  	}
  
  	function fncImprimirPresupuesto() {
 		document.getElementById("opcion").value = "imprimirPresupuesto";
	   	document.forms[0].submit();
  	}
  
  function fncAceptar(){
  		document.getElementById("btnImprimir").disabled=true;	
		document.getElementById("btnContinuar").disabled=true;	
		document.getElementById("btnVolver").disabled=true;	
	  	document.getElementById("opcion").value = "aceptarPresupuesto";
	  	$("distribuir").value = "NO";
	  	if(puedeDistribuir == "SI"){//if (confirm("Desea distribuir la bolsa del plan?"))
		  	$("distribuir").value = "SI";
		  	alert("Se realizar\u00E1 distribuci\u00F3n de bolsa");
	  	}
	   	document.forms[0].submit();
  }
  
  function fncReversarVenta(){
  
  		if (confirm("¿Esta seguro que desea cancelar la venta?")){
  			document.getElementById("btnImprimir").disabled=true;	
			document.getElementById("btnContinuar").disabled=true;	
			document.getElementById("btnVolver").disabled=true;	
		    	     
	   		//habilita menus
	 		var win = parent;	 		
			win.fncActDesacMenu(false);
			
		  	document.getElementById("opcion").value = "reversarVenta";
		   	document.forms[0].submit();

	   	}
  }

  function fncValidaLongitud()
	{
			var valor = $("mensajeFacturacion").value;
  		    if(valor.length > 500) {
		     	alert("El mensaje no puede superar los 500 caracteres");
		     	//$("mensaje").value = valor.substring(0,499);		     	
  		    }
	}
	
	function formatoDecimales(nroDecimales){
		for (i=0; i<document.forms.length; i++){
			for (j = 0; j < document.forms[i].elements.length; j++){
				if (document.forms[i].elements[j].type == "text" 
			  		&& !isNaN(document.forms[i].elements[j].value)
		          	) { 
		           num = parseFloat(document.forms[i].elements[j].value);
		           num =Math.round(num * Math.pow(10,nroDecimales)) / Math.pow(10, nroDecimales);
		           document.forms[i].elements[j].value = num.toFixed(nroDecimales);
		        }
			}
		}
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
		
</script>
</head>

<body onload="history.go(+1);fncInicio();" onkeydown="validarTeclas();">
<html:form method="POST" action="/CargosAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="txtParamDecForm" styleId="txtParamDecForm"/>
<html:hidden property="distribuir" styleId="distribuir"/>


      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Presupuesto
         </td>            
        </tr>
      </table>
	  <P>
	  <table width="100%" >
		  <tr>
		     <td class="mensajeError">
			     <div id="mensajes" >
			     	  <logic:present name="mensajeError"> <bean:write name="mensajeError"/> </logic:present>
		     	</div>
		     </td>
		  </tr> 
	  </table>	
	  
     <logic:equal name="cabeceraDTO" property="esVentaRegalo" value="S"> 
	  <table width="100%">
		    <tr>
		        <td class="mensajeInformativo">&nbsp; Venta sin costo para el cliente</td>
		    </tr>
	  </table>
	  </logic:equal>
	  <P>
	  
      <TABLE width="70%" border=0 align="center" border="0">
       <tr>
          <td width="30%" align="left">Total Conceptos</td>
          <td width="20%" align="left">
			<input type="text" id="totalConceptos" name="totalConceptos" style="text-align:right"
				   size="20" maxlength="20" disabled="disabled"
				   value="<bean:write name="cabeceraDTO" property="totalCargosVenta"/>" 
			/>
          </td>
        <bean:define id="codOperadoraSalvador" name="CargosForm" property="codOperadoraSalvador" type="java.lang.String"/>
    	<logic:equal name="CargosForm" property="codOperadora" value="<%= codOperadoraSalvador %>"> 
          <td width="25%" align="left">&nbsp;&nbsp;Total Impuestos</td>
          <td width="15%" align="left">
			<input type="text" name="totalImpuestos" style="text-align:right"
				   size="20" maxlength="20" disabled="disabled"
				   value="<bean:write name="cabeceraDTO" property="totalImpuestoVenta"/>" 
			/>
          </td>	
    	</logic:equal>
    	
    	<logic:notEqual name="CargosForm" property="codOperadora" value="<%= codOperadoraSalvador %>">           
    		<td colspan="2">&nbsp;</td>        
    	</logic:notEqual>  
    	
        </tr>
        <tr>
          <td align="left">Total Descuentos</td>
          <td align="left">
          
			<input type="text" name="totalDescuentos" style="text-align:right"
				   size="20" maxlength="20" disabled="disabled"
				   value="<bean:write name="cabeceraDTO" property="totalDescuentosVenta"/>" 
			/>
			
          </td>	
          <td align="left" >&nbsp;&nbsp;Total Presupuesto</td>
          <td align="left" align="left">
          
			<input type="text" name="totalPresupuesto" style="text-align:right"
				   size="20" maxlength="20" disabled="disabled"
				   value="<bean:write name="cabeceraDTO" property="totalPresupuestoVenta"/>" 
			/>
			
          </td>
        </tr>
        
        <tr>
          <td align="left">Tipo de Documento</td>
          <td align="left" colspan="3">
          
			<input type="text" name="tipoDocumento" style="text-align:right"
				   size="20" maxlength="20" disabled="disabled"
				   value="<bean:write name="cabeceraDTO" property="categoriaTributaria"/>" 
			/>
			
          </td>
      	</tr>
      	<tr><td></td></tr>
      <!--   <tr>
            <td align="left"><strong>Mensaje Facturaci&oacute;n</strong></td>
         	<td align="left" colspan="3">
              <html:textarea  rows="8" cols="60" styleClass="normal" property="mensajeFacturacion" onKeyDown="fncValidaLongitud();" onKeyUp="fncValidaLongitud();"/>
        	</td> 
        </tr>    -->
        <tr>
        <td align="left">Activar lineas moviles contrato</td>
        <td align="left">
	        <!-- MA-184592 
	         <html:select name="CargosForm" property="preactivacion" style="width:130px;" styleId="preactivacion" > 
				<html:option value="N">NO</html:option> 
				<html:option value="S">SI</html:option>
	         </html:select>
	        --> 
	         <html:select name="CargosForm" property="preactivacion" style="width:130px;" styleId="preactivacion"> 
		  	 	<logic:notEmpty name="CargosForm" property="activacionLineaDTO">
              		<html:optionsCollection property="activacionLineaDTO" value="codigoValor" label="descripcionValor"/>
          		</logic:notEmpty>
          	 </html:select>
	    </td>
	    </tr>
      </TABLE>
      
      <P>
      <P>
      <P>
      <P>

     <P>
     <P>
     <P>
     <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
      
        <td align="left" width="50%" >
       		<input type="button" id="btnVolver" name="btnVolver" value="CANCELAR VENTA" onclick="ocultarMensajeError();fncReversarVenta();" style="width:150px;color:black">        
        </td>
        <td width="25%" align="right">
	        <html:button style="width:150px;color:black;" value="IMPRIMIR PRESUPUESTO" property="btnImprimir" styleId="btnImprimir" onclick="ocultarMensajeError();fncImprimirPresupuesto();" />
        </td>
        <td width="25%" align="right">
			<html:button  value="ACEPTAR PRESUPUESTO" style="width:150px;color:black" property="btnContinuar" styleId="btnContinuar" onclick="ocultarMensajeError();fncAceptar();"/>        
        </td>
      </tr>
     </TABLE>

</html:form>

</body>
</html:html>