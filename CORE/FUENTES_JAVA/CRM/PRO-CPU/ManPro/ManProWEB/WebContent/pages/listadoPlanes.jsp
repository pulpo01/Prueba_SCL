<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Planes Disponibles</title>

<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script>


function fncAceptar(){
	var productos = document.getElementById("productos");
	
	if (productos == null){
		window.close();
		return;
	}
	
	if (productos!=null){
		var cadenaProductos = "";
		for(var i=0;i<productos.length;i++){
			if (productos.options[i].selected){
				if (cadenaProductos=="") cadenaProductos = productos.options[i].value;
				else	 				 cadenaProductos = cadenaProductos + "," +productos.options[i].value;
			}
		}
		
		if (cadenaProductos==""){
			if (confirm("No hay productos seleccionados.¿Desea continuar?")){
				window.close();
		    }
		    return;
		}
		
		window.returnValue = cadenaProductos;  
		window.close();
	}

}

</script>
</head>

<body  >
<html:form method="POST" action="/cliente.do">

 <table width="80%" align="center">
 <tr>
 	<td width="100%">&nbsp;</td>
 </tr>
 <tr>
 	<td align="center"><h2 class="textoSubTitulo">Seleccione Productos</h2></td>
 </tr>
 <tr><td>&nbsp;</td></tr>
 <tr>
 	<td  align="center"> 

	<logic:empty name="listaProductos" scope="session">
		NO SE ENCONTRARON PRODUCTOS
	</logic:empty>
		
	<logic:notEmpty name="listaProductos" scope="session">
	
	<select name="productos"  style="width:400px;text-transform: uppercase;" multiple="true" size="30">
       <logic:iterate id="prod" name="listaProductos"  type="com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoFrmkDTO">
           <logic:notEmpty  name="prod">   
		       <option value='<bean:write name="prod" property="codigo"/>'>
					<bean:write name="prod" property="descripcion"/>
			   </option>
		    </logic:notEmpty>   
       </logic:iterate>
	</select>
	
	</logic:notEmpty>
	
	</td>
 <tr>
 <tr>
 	<td align="center" >
 	<img onclick="fncAceptar();" style="cursor: pointer;" src="<%=request.getContextPath()%>/img/botones/btn_aceptar.gif" name="Aceptar" width="85" height="19"  border="0" id="Aceptar" />
 	</td>
 </tr>
 <tr>
 <td>
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
 </td>
 </tr>
 
 </table>

 
</html:form>
</body>
</html:html>