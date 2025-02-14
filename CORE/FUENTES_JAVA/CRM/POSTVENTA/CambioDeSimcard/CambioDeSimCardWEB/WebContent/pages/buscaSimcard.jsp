

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/cambioSimCard/css/mas.css" rel="stylesheet" type="text/css" />
<script>	
	
	function onlyInteger(e) {
		var key = window.event ? e.keyCode : e.which;
		var keychar = String.fromCharCode(key);
		reg = /^\d$/;
		return reg.test(keychar);
	}

	
	function fncInicio(){
		document.body.style.cursor="default";
		var numeroSerieSel = document.getElementById("numeroSerieSel");
		var codProcedencia = document.getElementById("codProcedencia");
		if (numeroSerieSel.value!="" && codProcedencia.value!=""){
			if (codProcedencia.value=="1"){//EXTERNA
				document.getElementById("txtFiltro").value  = numeroSerieSel.value;
			}
		}
		
		var rdSerieSel = document.getElementById("rdSerieSel");
		if (rdSerieSel!=null){
			//document.getElementById("divResultadoBusqueda").style["display"] = "";
		}

		var codProcedencia = document.getElementById("codProcedencia");
		
		if (codProcedencia.value==""){ //opcion Seleccione
			document.getElementById("divFiltroBodega").style["display"] = "none";
			document.getElementById("divFiltroArticulo").style["display"] = "none";			
		  	document.getElementById("divFiltroNumero").style["display"] = "none";
  			document.getElementById("codCriterioBusqueda").selectedIndex = 0;		  	
		    document.getElementById("codCriterioBusqueda").disabled = true;		
			document.getElementById("divBtnBusqueda").style["display"] = "none";		    	
		}
		else if (codProcedencia.value=="1"){//EXTERNA
			document.getElementById("divFiltroBodega").style["display"] = "none";
			document.getElementById("divFiltroArticulo").style["display"] = "";			
		  	document.getElementById("divFiltroNumero").style["display"] = "";
  			document.getElementById("codCriterioBusqueda").selectedIndex = 0;
		    document.getElementById("codCriterioBusqueda").disabled = true;
			document.getElementById("divBtnBusqueda").style["display"] = "none";		    			    
		    
		    if (document.getElementById("flgEquipoFijo").value=="1"){
   			    document.getElementById("txtFiltro").value="0";
			    document.getElementById("txtFiltro").disabled = true;
			    document.getElementById("codProcedencia").disabled=true;
		    }	    
		}else{
		    document.getElementById("codCriterioBusqueda").disabled = false;
		}
		
		//limpia serie seleccionada	anteriormente por pantalla
		document.getElementById("numeroSerieSel").value ="";
		
		fncMostrarFiltros();
		
		document.forms[0].txtFiltro.onpaste = function() { return false;}; //fncOnPasteValidaNumero()
	}

	//se usa en evento onpaste para validar pegado de valores numericos
	function fncOnPasteValidaNumero(){
			var txt = clipboardData.getData("Text");
			var numPaste = parseInt(txt);
			
			if (isNaN(numPaste)) { 
				return false; 
		        }
		        else{
				clipboardData.setData("Text", numPaste+"");
				return true;
			}
	}
		
	function fncActDesacControlesProcedencia(){
		//limpia serie seleccionada	anteriormente
		document.getElementById("numeroSerieSel").value ="";
		document.getElementById("txtFiltro").value = "";
			
		var codProcedencia = document.getElementById("codProcedencia");
		if (codProcedencia.value==""){ //opcion Seleccione
			document.getElementById("divFiltroBodega").style["display"] = "none";
			document.getElementById("divFiltroArticulo").style["display"] = "none";			
		  	document.getElementById("divFiltroNumero").style["display"] = "none";
  			document.getElementById("codCriterioBusqueda").selectedIndex = 0;		  	
		    document.getElementById("codCriterioBusqueda").disabled = true;		
			document.getElementById("divBtnBusqueda").style["display"] = "none";		    
		}
		else if (codProcedencia.value=="1"){//EXTERNA
			document.getElementById("divFiltroBodega").style["display"] = "none";
			document.getElementById("divFiltroArticulo").style["display"] = "";			
		  	document.getElementById("divFiltroNumero").style["display"] = "";
		  	//document.getElementById("divResultadoBusqueda").style["display"] = "none";
			document.getElementById("codCriterioBusqueda").selectedIndex = 0;
		    document.getElementById("codCriterioBusqueda").disabled = true;
   			document.getElementById("codArticulo").selectedIndex = 0;
			document.getElementById("divBtnBusqueda").style["display"] = "none";		    			    
		}else{
			document.getElementById("divFiltroArticulo").style["display"] = "none";	
			document.getElementById("divFiltroNumero").style["display"] = "none";
		    document.getElementById("codCriterioBusqueda").disabled = false;
		}
	}
	
	function fncMostrarFiltros(){
		 var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		 
 		 if (!document.getElementById("codCriterioBusqueda").disabled){
			  if (codCriterioBusqueda.value=="" ){
				  document.getElementById("divFiltroBodega").style["display"] = "none";
				  document.getElementById("divFiltroArticulo").style["display"] = "none";					  
	  			  document.getElementById("divFiltroNumero").style["display"] = "none";
				  document.getElementById("divBtnBusqueda").style["display"] = "none";
			  }
			  else if (codCriterioBusqueda.value=="TE" || codCriterioBusqueda.value=="SE"){
			  	document.getElementById("divFiltroBodega").style["display"] = "none";
				document.getElementById("divFiltroArticulo").style["display"] = "none";				  	
			  	document.getElementById("divFiltroNumero").style["display"] = "";
			  	document.getElementById("txtFiltro").value = "";
  				document.getElementById("divBtnBusqueda").style["display"] = "";
			  }
			  else if (codCriterioBusqueda.value=="BO"){
				document.getElementById("divFiltroNumero").style["display"] = "none";		  
				document.getElementById("divFiltroBodega").style["display"] = "";
				document.getElementById("divFiltroArticulo").style["display"] = "";
				document.getElementById("divBtnBusqueda").style["display"] = "none";
			  }
		}
	}  
	
	function fncBuscar(){			
		
		var codProcedencia = document.getElementById("codProcedencia");
		
		if (codProcedencia.value=="0"){
			var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
			var linkOrigen = document.getElementById("linkOrigen");
			
	
			if (codCriterioBusqueda.value==""){
				alert("Debe Ingresar Criterio de B\u00FAsqueda");
				return false;
			}	
			
			if (codCriterioBusqueda.value == "BO"){
				var codBodega = document.getElementById("codBodega");
				var codArticulo = document.getElementById("codArticulo");
				if (codBodega.value ==""){
					//alert("Debe Ingresar Bodega");
					return false;
				}
				if (codArticulo.value==""){
					//alert("Debe Ingresar Articulo")
					return false;
				}
				document.body.style.cursor="wait";
				document.getElementById("opcion").value = "obtenerSeriesBodega";
			}else{
				var filtro = document.getElementById("txtFiltro"); 				
				var telefono = null;
				var serie = null;
				var criterio = ""
				if (codCriterioBusqueda.value == "TE"){
					criterio = "Tel\u00E9fono";
					telefono = filtro.value;
				}else{
					criterio = "Serie";
					serie = filtro.value; 	
				}
	
				if (filtro.value == ""){
					alert("Debe Ingresar "+criterio);
					return false;
				}
				document.getElementById("opcion").value = "obtenerSeries";										
			}						
			
		}
			
			
		   	document.forms[0].submit();
	}
	
	function fncResultadoObtenerSeries(data){
	
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}		        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	    }//fin if (data!=null)
	    
		document.getElementById("numeroSerieSel").value = "";	    
		document.getElementById("opcion").value = "buscarSerie";
	   	document.forms[0].submit();	   
	    document.body.style.cursor="default";			   
	}
	
	function fncValidaSerieExterna(numSerie)
	{
	  var tipoProcedencia =document.getElementById("codProcedencia").value;
	  var serie =document.getElementById("txtFiltro").value;
	  if (tipoProcedencia=="1")
	  {
	      JBuscaSeriesAJAX.validaSerieExterna(serie,fncResultadoValidaSerieExterna);			  
	  }
	  else{
	      var linkOrigen = document.getElementById("linkOrigen");
		
	    if (linkOrigen.value == "EQUIPO"){
		  	  document.getElementById("opcion").value = "aceptarEquipo";
		}
		document.getElementById("codProcedencia").disabled=false;
	   	document.forms[0].submit();     
	  }
	}

	function fncSeleccionaSerie(numSerie){
		document.getElementById("numeroSerieSel").value = numSerie.value;
	}
	
	function fncAceptar(){
		if (document.getElementById("numeroSerieSel").value==null || document.getElementById("numeroSerieSel").value==""){			
	 	 	alert("Debe seleccionar una serie");
		 	return;
		}
		var ret = document.getElementById("numeroSerieSel").value;				 
		window.returnValue = ret;  	 		 		 
	    window.close();
	} 	
	
	function fncCancelar(){
		document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
	}
	
	function fncVolver(){
	
		if (confirm("¿Desea volver al men\u00FA?")){
			var win = parent
			win.fncActDesacMenu(false);
		
		  	document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}	
	
	// Muestra mensajes de error
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}	
	
	function fncInvocarPaginaExpiraSesion(){
    	document.forms[0].submit();
	}	
</script>
</head>

<body  class="body" onload="fncInicio();">
<html:form method="POST" action="/BuscaSimcardAction.do">
<html:hidden property="opcion" value="inicio"/>
<html:hidden property="linkOrigen"/>
<html:hidden property="numeroSerieSel"/>
<html:hidden property="flgEquipoFijo"/>
<html:hidden property="codArticuloKIT"/>

      <table width="80%">
        <tr>
         <td class="textoSubTitulo">
	       <IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">B&uacute;squeda Series&nbsp;
         </td>            
        </tr>
      </table>
	  <P>
		<table width="100%" border="0" >
		  <tr >
		     <td class="mensajeError"><div id="mensajes" class="mensajeError"></div></td>
		  </tr> 
		</table>	  
	  <P>
	  
<table width="90%">


<html:hidden property="codProcedencia"/>	 
<tr><td width="100%">
      <table width="100%">	  
      <tr>
	      <td width="15%">&nbsp;</td>
          <td align="left" width="25%">Buscar una serie por</td>
          <td align="left" width="50%">
			  <html:select name="BuscaSimcardForm" property="codCriterioBusqueda" style="width:300px;" onchange="ocultarMensajeError();fncMostrarFiltros();"> 
				<html:option value="">- Seleccione -</html:option>
				<!-- 
				<html:option value="TE">TELEFONO</html:option>
				 -->
				<html:option value="SE">SERIE</html:option>
				<html:option value="BO">BODEGA</html:option>				
	          </html:select>	
      	  </td>
		  <td width="25%">&nbsp;</td>      	  
      </tr>
      

	        
      </table>
 </td></tr>
 
 <tr><td> 
    <div id="divFiltroBodega" style="display:inline;">    
    <table width="100%">    
     <tr>  
	      <td width="15%">&nbsp;</td>
          <td width="25%" align="left">Bodega</td>   
          <td align="left" width="50%">
			  <html:select name="BuscaSimcardForm" property="codBodega" style="width:300px;" onchange="ocultarMensajeError();fncBuscar();" > 
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="BuscaSimcardForm" property="arrayBodegas">
	              <html:optionsCollection property="arrayBodegas" value="cod_bodega" label="des_bodega"/>
	          	</logic:notEmpty>   
	          </html:select>
          </td>             
          <td width="25%">&nbsp;</td>      
	 </tr>
	</table>
	</div>
 </td></tr>
 
 <tr><td> 
    <div id="divFiltroArticulo" style="display:none">    
    <table width="100%"> 
     <tr>  
	      <td width="15%">&nbsp;</td>
          <td width="25%" align="left">Art&iacute;culo</td>   
          <td align="left" width="50%">
			  <html:select name="BuscaSimcardForm" property="codArticulo" style="width:300px;" onchange="ocultarMensajeError();fncBuscar();" > 
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="BuscaSimcardForm" property="arrayArticulos">
	              <html:optionsCollection property="arrayArticulos" value="codArticulo" label="desArticulo"/>
	          	</logic:notEmpty>  				
	          </html:select>			
          </td>             
          <td width="25%">&nbsp;</td>      
	 </tr>	
	 </table> 
     </div>
 </td></tr>
 
 <tr><td>
    <div id="divFiltroNumero" style="display:none">    
    <table width="100%">  
     <tr><td colspan="4">&nbsp;</td></tr>
     <tr>  
	      <td width="15%">&nbsp;</td>
          <td width="25%">&nbsp;</td>   
          <td align="left" width="35%">
			<html:text name="BuscaSimcardForm" property="txtFiltro" size="35" maxlength="25" onkeypress="return onlyInteger(event);" onchange="ocultarMensajeError();" />          
          </td>             
          <td width="25%">&nbsp;</td>      
	 </tr>
	</table>
    </div>      
 </td></tr>
 
 <tr><td> 
	<table width="100%">    
     <tr>
	      <td width="15%">&nbsp;</td>
          <td width="25%">&nbsp;</td>   
          <td width="35%">&nbsp;</td>             
          <td align="left" width="25%">
			<div id="divBtnBusqueda" style="display:none">          
			<html:button  value="BUSCAR" style="width:120px;color:black" property="btnBuscar" onclick="ocultarMensajeError();fncBuscar();"/>          
			</div>
          </td>  
     </tr>     
    </table> 
 </td></tr>   
     <tr>
	     <td colspan="4">
	      <HR noshade>
	    </td>
	 </tr>    
     <tr align="center">
	     <td colspan="4" align="center">	     
	     <logic:notEmpty name="BuscaSimcardForm" property="serieAjaxDTOs">
	    <table width="100%"> 
	    <tr>
	    	<td width="100%" valign="top" align="center">Series</td>
	    </tr>
     	<tr>  
          <td width="100%"align="left">	          
			<display:table  id="series" name="listaSeries" scope="session" pagesize="20" requestURI=""  width="100%" >
				<display:column title = "Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla" width="5%">
					<input type="radio" name="rdSerieSel" onclick="fncSeleccionaSerie(this);" value="<bean:write name="series" property="numSerie"/>">
				</display:column>
				<display:column property="numSerie" title = "N&uacute;mero Serie" headerClass="textoColumnaTabla" width="30%"/>
				<display:column align="center" property="numTelefono" title = "N&uacute;mero Celular" headerClass="textoColumnaTabla" width="30%"/>
				<display:column property="fecha" title = "Fecha" headerClass="textoColumnaTabla" width="30%"/>
			</display:table>	          		
          </td>                   
	 </tr>	
	 </table> 
	 </logic:notEmpty>
	 <logic:empty name="BuscaSimcardForm" property="serieAjaxDTOs">
	 	<logic:notEmpty name="BuscaSimcardForm" property="mensaje">
	 		<center><p><bean:write name="BuscaSimcardForm" property="mensaje"/></p></center>
	 	</logic:notEmpty>  
	 </logic:empty>
	    </td>
	 </tr>  	 
 </table> 

    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr><td>&nbsp;</td></tr>    
      <tr><td>&nbsp;</td></tr>    
      <tr>
        <td width="50%" align="left">
        </td>
        <td align="right" width="25%">
			<html:button  value="ACEPTAR" style="width:120px;color:black" property="btnAceptar" onclick="ocultarMensajeError();fncAceptar();"/>
        </td>        
        <td align="right" width="25%">
        	<html:button  value="CANCELAR" style="width:120px;color:black" property="btnCancelar" onclick="javascript:window.close();"/>
        </td>

        
      </tr>
    </TABLE> 
</html:form>

</body>
</html:html>