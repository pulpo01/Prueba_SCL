<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<form name="ProductoFormContratados" method="post" action="/ManProWEB/producto.do">
<table width="100%" border="0">
  <tr >
    <td class="textoSubTitulo" colspan="8">Por Defecto </td>
  </tr>
  <tr>
    <td valign="top" colspan="8">
    <logic:present name="Abonado" property="productoContratados">
    
    <bean:size id="size" name="Abonado" property="productoContratados"/>
		<logic:equal name="size" value="0">
		<!-- Crear un mensaje si no encuentra -->
		<h1 class="textoSubTitulo">No existen planes adicionales por defecto</h1>
		</logic:equal>
    <logic:greaterThan name="size" value="0">
    
	<!--  input type="hidden" name="codigo" id="d_codigo"/>
	<input type="hidden" name="comportamiento" id="d_comportamiento"/>
	<input type="hidden" name="codPadrePaq" id="d_codPadrePaq"/>
	<input type="hidden" name="idProducto" id="d_idProducto"/ -->
    

    <table width="100%" border="0" cellpadding="0" cellspacing="2">
    
      <tr class="textoColumnaTabla">
        <td>Contratados </td>
        <td>Cantidad</td>
        <td>C&oacute;digo</td>
        <td colspan="2">Plan Adicional</td>
        <!--  <td><div align="center">Personalizado</div></td>-->
        <td> Tipo</td>
        <td>L&iacute;mite de Consumo </td>
        <td>Monto LC</td>
        <td>Modo Contrataci&oacute;n </td>
      </tr>
      <%int idProducto = 0;%>
      <logic:iterate id="Contratados" name="Abonado" property="productoContratados">      
      <%if (idProducto%2==0){ %> 	
      <tr class="textoidProductoTabla">
      <%}else{ %>
      <tr class="textoidProductoColorTabla">
      <%}%>     
        	<td align="center">
        		<img src="img/check.gif">
        		<input type="hidden" name="ind_paquete_<%=idProducto%>" value="<bean:write name="Contratados" property="paquete"/>">
        	</td>
        	<td align="center">
        		<bean:write name="Contratados" property="cantidadDesplegado"/>
        	</td>
	        <td>
        		<bean:write name="Contratados" property="codProducto"/>
    	    </td>
	        <td width="20%" >
        		<bean:write name="Contratados" property="nombre"/>
    	    </td>
	        <td width="4%" align="center">
	        	<strong>
					<input 
						type	="hidden" 
						name	="codigo_<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>" 
						id		="codigo_<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>" 
						value	="<bean:write name="Contratados" property="codigo"/>" />
					<input 
						type	="hidden" 
						name	="comportamiento_<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>" 
						id		="comportamiento_<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>" 
						value	="<bean:write name="Contratados" property="comportamiento"/>" 
					/>
					<input 
						type	="hidden" 
						name	="codPadrePaq_<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>" 
						id		="codPadrePaq_<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>" 
						value	="<bean:write name="Contratados" property="codPadre"/>" />
					<input 
						type	="hidden" 
						name	="idProducto_<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>" 
						id		="idProducto_<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>"  
						value	="<bean:write name="Contratados" property="comportamiento"/>" 
					/>   
					<bean:define id="isPersonalizable" name="Contratados" property="modificable"/>	 
				    <logic:equal name="isPersonalizable" value="1"> 						     	
	        		<img 
	        			src="img/botones/btn_puntos.gif" 
	        			onclick = "guardarCabecera(this.form,'<bean:write name="Contratados" property="nombre"/>','<bean:write name="Contratados" property="codProducto"/>','<bean:write name="Contratados" property="numMaximoLista"/>');contratados('<bean:write name="Contratados" property="codigo"/>_<%=idProducto%>');"
	        		/>
					</logic:equal>
				    <logic:equal name="isPersonalizable" value="0"> 	        		
						<img
							title="no es posible personalizar este producto" 
							src="img/botones/btn_puntos_pre.gif" width="19" height="19" 
							name="con_boton_<%=idProducto%>" 
							id="con_boton_<%=idProducto%>"
							alt="no es posible personalizar este producto"
						/>
	        		</logic:equal>	        		
	       		</strong>
	       	</td>
        <!-- 
        <td>
        	<div align="center"><bean:write name="Contratados" property="personalizado"/></div></td>
        -->
        <td align="center">
       
        <script>
        	descripcionTipo('<bean:write name="Contratados" property="comportamiento"/>');
			codLimCons[<%=idProducto%>] = new Array();
			desLimCons[<%=idProducto%>] = new Array();
			mtosConsum[<%=idProducto%>] = new Array();
			mtosMinimo[<%=idProducto%>] = new Array();
			mtosMaximo[<%=idProducto%>] = new Array();
			var cantidadLC;	        	
        </script>                
        </td>
       <td align="center">
       				<bean:define id="listaLimConsumo" name="Contratados" property="listaLimiteConsumoValMto"/>
					   <select name="combo_lc_D" id="combo_lc_<%=idProducto%>" onchange = "setValorSeleccionados()" style="width:250px;">
					       <logic:iterate indexId="countLC" id="element" name="listaLimConsumo">
				                <option value="<bean:write name='element' property='codLimCons'/>"><bean:write name="element" property="descripcion"/></option>
				                <script language="JavaScript" type="text/javascript">
								 codLimCons[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="codLimCons" />';
								 desLimCons[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="descripcion" />';
								 mtosConsum[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="mtoConsumido" />';
								 mtosMinimo[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="mtoMinimo" />';
								 mtosMaximo[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="mtoMaximo" />';
								 cantidadLC=<%=countLC.intValue()%>;
								</script>	
				           </logic:iterate>
				        </select>
				            <script>
				            	syncSelect(document.ProductoFormContratados.combo_lc_<%=idProducto%>, '<bean:write name="Contratados" property="codLimConsuSeleccionado"/>');
				            </script>
		</td>
		<td align="left" width="5%"><%//disabled="disabled" txtmtolc_c<%//=idProducto%>
			<%//verificarVacio(this,"<%//=idProducto,<bean:write name="Contratados" property="codProducto"/>"), %>
			<input type="text" name="montoslc_D" id="txtmtolc_<%=idProducto%>" onfocus="javascript: setValorActual(this);"
				   onkeypress="javascript: validaNumero(this);" onblur="javascript: esNumerico(this);"
				   value='<bean:write name="Contratados" property="mtoConsumido"/>'  
				   onChange	='validarRangoLC(this,"<%=idProducto%>",
				   "<bean:write name="Contratados" property="codProducto"/>",
				   "<bean:write name="Contratados" property="mtoConsumido"/>", "check_<%=idProducto%>c")' size="11" maxlength="10"/>
		</td>	
        <td align="center">Defecto</td>
      </tr>
       <%idProducto++; %>
      </logic:iterate>
    </table>

	</logic:greaterThan>
	</logic:present>          
    </td>
  </tr>
</table>
<br>

<logic:equal name="navegacion" property="origen" value="SCORING">
	<table width="100%" border="0">
	  <tr >
	    <td class="textoSubTitulo" colspan="8">Scoring </td>
	  </tr>
	
	  <tr>
	    <td valign="top" colspan="8">
	    <logic:greaterThan name="Abonado" property="totalPlanesScoring" value="0">
		Existen planes pre-evaluados :
		<%int idProductoScoring = 0;%>
		<logic:iterate id="PreEvaluados" name="Abonado" property="productosScoring">   
		    <%if (idProductoScoring>0){ %>,&nbsp;  <%}%>  
      		<b>(<bean:write name="PreEvaluados" property="cantidad"/>)
			<bean:write name="PreEvaluados" property="idProductoOfertado"/>&nbsp;-&nbsp;
			<bean:write name="PreEvaluados" property="desProductoOfertado"/>
			</b>
			 <%idProductoScoring++; %>
	    </logic:iterate>
	    
		    
	    </logic:greaterThan>
	    <logic:equal name="Abonado" property="totalPlanesScoring" value="0">
		    No existen planes pre-evaluados
	    </logic:equal>

	    </td>
	  </tr>
	</table>
</logic:equal>

</form>