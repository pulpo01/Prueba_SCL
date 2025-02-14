<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>


<html>
	<head>
	<base target="_self"></base>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Telefónica Móviles</title>
	<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DireccionesAJAX.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/js/controlTimeOut.js' language='JavaScript'></script>

	<script>
		function getProvincias() {
  	      var region = $("region"); 
	      arrayProvincias = DireccionesAJAX.getProvincias(region.value,displayProvincias);
	      var tablaZipCode =  '<bean:write name="DireccionesActionForm" property="tablaZipCode"/>';
	      if (tablaZipCode == 'GE_REGIONES' ){
	         getCodigosPostales(region.value); 
	      }
	  	}
	  	function displayProvincias(arrayProvincias){
		  var data = [{ codigo:'-1', descripcion:'' }];
		  DWRUtil.removeAllOptions("provincia");
		  DWRUtil.addOptions("provincia",data,"codigo","descripcion");
		  DWRUtil.addOptions("provincia",arrayProvincias,"codigo","descripcion");
	  	}
	  	function getCiudades() {
	  	  var region = $("region"); 
  	      var provincia = $("provincia"); 
	      arrayCiudades = DireccionesAJAX.getCiudades(region.value,provincia.value,displayCiudades);
	      var tablaZipCode =  '<bean:write name="DireccionesActionForm" property="tablaZipCode"/>';
	      if (tablaZipCode == 'GE_PROVINCIAS'){
	         getCodigosPostales(provincia.value); 
	      }
	  	}
	  	
	  	function displayCiudades(arrayCiudades){
     	  var data = [{ codigo:'-1', descripcion:'' }];
		  DWRUtil.removeAllOptions("ciudad");
		  DWRUtil.addOptions("ciudad",data,"codigo","descripcion");
		  DWRUtil.addOptions("ciudad",arrayCiudades,"codigo","descripcion");
	  	  var descripcionCiudadComputecSel =  '<bean:write name="DireccionesActionForm" property="descripcionCiudadComputecSel"/>';
	  	  var ciudad = $("ciudad");
	  	  if (descripcionCiudadComputecSel!=''){
		  	for(index = 0; index<ciudad.length; index++) {
	           if(ciudad[index].text == descripcionCiudadComputecSel){
	             ciudad.selectedIndex = index;
	           }  
	        }
	  	  }
	  	  
	  	  
	  	}
	  	
	  	
	  	function getComunas() {
  	      var region = $("region"); 
  	      var provincia = $("provincia"); 
  	      var ciudad = $("ciudad");
	      arrayComunas = DireccionesAJAX.getComunas(region.value,provincia.value,ciudad.value,displayComunas);
	      var tablaZipCode =  '<bean:write name="DireccionesActionForm" property="tablaZipCode"/>';
	      if (tablaZipCode == 'GE_CIUDADES'){
	       getCodigosPostales(ciudad.value); 
	      }
	  	}

	  	function displayComunas(arrayComunas){
	  	  var data = [{ codigo:'-1', descripcion:'' }];
		  DWRUtil.removeAllOptions("comuna");
		  DWRUtil.addOptions("comuna",data,"codigo","descripcion");
		  DWRUtil.addOptions("comuna",arrayComunas,"codigo","descripcion");
	  	}

	  	function getZipComuna() {
	  	  var tablaZipCode =  '<bean:write name="DireccionesActionForm" property="tablaZipCode"/>';
	      var comuna = $("comuna");
	      if (tablaZipCode == 'GE_COMUNAS'){
	         getCodigosPostales(comuna.value); 
	      }
	  	}


	  	function getCodigosPostales(codigoZona){
	  	  var zip = $("zip");
	  	  if (zip!=null){
	        arrayCodigosPostales = DireccionesAJAX.getCodigosPostales(codigoZona,displayCodigosPostales);
	      }
	  	}

	  	function displayCodigosPostales(arrayCodigosPostales){
	  	  var data = [{ codigo:'-1', descripcion:'' }];
		  DWRUtil.removeAllOptions("zip");
		  DWRUtil.addOptions("zip",data,"codigo","descripcion");
		  DWRUtil.addOptions("zip",arrayCodigosPostales,"codigo","descripcion");
	  	}


	  	function cerrar(){
		 setTimeout("window.close()", 2000);
	  	}
	  	
	  	function enviarAceptar(){
	  	  var pagina = '<bean:write name="DireccionesActionForm" property="pagina" />';

	  	  if (pagina == 'paginaDirecciones'){
	  	     grabar();
	  	  }
	  	  else if (pagina == 'paginaComputec'){
			 var direccionComputec = $("direccionComputec");
	  	     if (direccionComputec.selectedIndex!=-1){
		  	    var accion =$("accion");
		  	    accion.value = 'cargarDireccion';
		  	    DireccionesActionForm.submit();
	  	     }else{
				alert("Debe seleccionar un elemento de la \n lista de direcciones computec");
				direccionComputec.focus();	  	     
	  	     }
	  	     
	  	  }
	  	}
	  	
	  	function enviarCancelar(){
	  	  var pagina = '<bean:write name="DireccionesActionForm" property="pagina" />';
	  	  var accion = $("accion");

	  	  if (pagina == 'paginaDirecciones'){ 
	  	    accion.value = 'regresarAltaCliente';
	  	  }
	  	  else if (pagina == 'paginaComputec'){
	  	  	accion.value = 'direcciones';
	  	  }
    	  DireccionesActionForm.submit();
	  	}

	  	
	  	function grabar() {
  	      var tipoCalle = $("tipoCalle");
  	      var nombreCalle = $("nombreCalle");
  	      var numeroCalle = $("numeroCalle");
  	      var numeroPiso = $("numeroPiso");
  	      var region = $("region");
  	      var provincia = $("provincia");
  	      var ciudad = $("ciudad");
  	      var comuna = $("comuna");
  	      var zip = $("zip");
	      var observacion = $("observacion");
	      var tipoCalleObligatorio = $("tipoCalleObligatorio");
  	      var nombreCalleObligatorio = $("nombreCalleObligatorio");
  	      var numeroCalleObligatorio = $("numeroCalleObligatorio");
  	      var numeroPisoObligatorio = $("numeroPisoObligatorio");
  	      var regionObligatorio = $("regionObligatorio");
  	      var provinciaObligatorio = $("provinciaObligatorio");
  	      var ciudadObligatorio = $("ciudadObligatorio");
  	      var comunaObligatorio = $("comunaObligatorio");
  	      var zipObligatorio = $("zipObligatorio");
	      var observacionObligatorio = $("observacionObligatorio");
   	      var casillaObligatorio = $("casillaObligatorio");
	      var tipoCalleCaption = $("tipoCalleCaption");
	      var nombreCalleCaption = $("nombreCalleCaption");
  	      var numeroCalleCaption = $("numeroCalleCaption");
  	      var numeroPisoCaption = $("numeroPisoCaption");
  	      var regionCaption = $("regionCaption");
  	      var provinciaCaption = $("provinciaCaption");
  	      var ciudadCaption = $("ciudadCaption");
  	      var comunaCaption = $("comunaCaption");
  	      var casillaCaption = $("casillaCaption");
  	      var zipCaption = $("zipCaption");
	      var observacionCaption = $("observacionCaption");
	      var regionDescripcion = $("regionDescripcion");
	      var provinciaDescripcion = $("provinciaDescripcion");
	      var ciudadDescripcion = $("ciudadDescripcion");
	      var comunaDescripcion = $("comunaDescripcion");
	      var zipDescripcion = $("zipDescripcion");
		  var casillaDescripcion = $("casillaDescripcion");
		  var tipoCalleDescripcion = $("tipoCalleDescripcion");
		  

	      var formulario = $("DireccionesActionForm");
	      var tipoDireccion =$("tipoDireccion");
	      var accion =$("accion");
	      if (nombreCalleObligatorio.value == '1' && nombreCalle.value==''){
			alert ('Debe ingresar ' + nombreCalleCaption.value);
		      } else if (tipoCalleObligatorio.value = '1' && (tipoCalle.value == '' || tipoCalle.value == '-1')){
			alert ('Debe ingresar ' + tipoCalleCaption.value);
		      } else if (numeroCalleObligatorio.value == '1'  && numeroCalle.value==''){
			alert ('Debe ingresar ' + numeroCalleCaption.value);
		      } else if (numeroPisoObligatorio.value == '1' &&  numeroPiso.value==''){
			alert ('Debe ingresar ' + numeroPisoCaption.value);
		      } else if (regionObligatorio.value = '1' && (region.value == '' || region.value == '-1')){
			alert ('Debe ingresar ' + regionCaption.value);
		      } else if (provinciaObligatorio.value = '1' && (provincia.value == '' || provincia.value == '-1')){
			alert ('Debe ingresar ' + provinciaCaption.value);
		      } else if (ciudadObligatorio.value = '1' && (ciudad.value == '' || ciudad.value == '-1')){
			alert ('Debe ingresar ' + ciudadCaption.value);
		      } 
		    else if (comunaObligatorio.value == '1' && (comuna.value == '' || comuna.value == '-1')){
			  alert ('Debe ingresar ' + comunaCaption.value);
		    } 
		    else if (zip!=null && zipObligatorio.value == '1' && (zip.value == '' || zip.value == '-1')){
			  alert ('Debe ingresar ' + zipCaption.value);
		    } 
		    else if (casillaObligatorio.value == '1'){
			  alert ('Debe ingresar ' + casillaCaption.value);
		    } 
		    else if (observacionObligatorio.value == '1'){
			  alert ('Debe ingresar ' + observacionCaption.value);
		    }
		    else  {
			  regionDescripcion.value = region.options[region.selectedIndex].text;
			  provinciaDescripcion.value = provincia.options[provincia.selectedIndex].text;
			  ciudadDescripcion.value = ciudad.options[ciudad.selectedIndex].text;
			  comunaDescripcion.value = comuna.options[comuna.selectedIndex].text;
			  if (zip!=null) zipDescripcion.value = zip.options[zip.selectedIndex].text;
			  tipoCalleDescripcion.value = tipoCalle.options[tipoCalle.selectedIndex].text;
			    
			  if (tipoDireccion.value == '4')
	    		accion.value='grabarDireccionCuenta';
			  else
		    	 accion.value='grabarDireccion';
		   	
		   	  	
		   	  formulario.submit();
	       }
	  }
	  
	</script>
	</head>


<body>

    <html:form action="DireccionesAction.do" >
    <html:hidden property="codigoDireccion"/>
    <html:hidden property="tipoDireccion"/>
    <html:hidden property="accion"/>
    <html:hidden property="pagina"/>
    
    <html:hidden property="tipoCalleObligatorio"/>
    <html:hidden property="nombreCalleObligatorio"/>
    <html:hidden property="numeroCalleObligatorio"/>
    <html:hidden property="numeroPisoObligatorio"/>
    <html:hidden property="regionObligatorio"/>
    <html:hidden property="provinciaObligatorio"/>
    <html:hidden property="ciudadObligatorio"/>
    <html:hidden property="comunaObligatorio"/>
    <html:hidden property="observacionObligatorio"/>
    <html:hidden property="casillaObligatorio"/>
    <html:hidden property="zipObligatorio"/>
    <html:hidden property="tipoCalleCaption"/>
    <html:hidden property="nombreCalleCaption"/>
    <html:hidden property="numeroCalleCaption"/>
    <html:hidden property="numeroPisoCaption"/>
    <html:hidden property="regionCaption"/>
    <html:hidden property="provinciaCaption"/>
    <html:hidden property="ciudadCaption"/>
    <html:hidden property="comunaCaption"/>
    <html:hidden property="zipCaption"/>
    <html:hidden property="casillaCaption"/>
    <html:hidden property="observacionCaption"/>
    <html:hidden property="regionDescripcion"/>
    <html:hidden property="provinciaDescripcion"/>
    <html:hidden property="ciudadDescripcion"/>
    <html:hidden property="comunaDescripcion"/>
    <html:hidden property="zipDescripcion"/>
    <html:hidden property="casillaDescripcion"/>
    <html:hidden property="tipoCalleDescripcion"/>

    
      <table width="80%" border=0>
        <tr>
         <td class="textoTitulo" >
              <IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
              <bean:define id="descripcionTipoDireccion" name="DireccionesActionForm" property="descripcionTipoDireccion"/>
              <bean:write name="descripcionTipoDireccion"/>
         </td>   
        </tr>
      </table>
	  <P>
	  <P>
    
    <!--Pagina de Computec--> 

   <logic:equal name="DireccionesActionForm" property="pagina" value="paginaComputec">      
     <TABLE align="center" width="70%" border=0>
        <tr>
          <td align="left" width="50%"><strong>Número de identificacion del Cliente</strong></td>
          <td align="left" width="50%">
			<input type="text" name="numIdentCliente" 
				   size="40" maxlength="20" disabled="disabled" style="text-align:center"
				   value="<bean:write name="DireccionesActionForm" property="numIdentClienteDir"/>" 
			/>
          </td>
        </tr>
	   <P>
        <tr>
          <td><strong>Nombre del Cliente</strong></td>
          <td>
			<input type="text" name="nombreCliente" 
				   size="40" maxlength="20" disabled="disabled" style="text-align:center"
				   value="<bean:write name="DireccionesActionForm" property="nombreClienteDir"/> <bean:write name="DireccionesActionForm" property="primerApellidoClienteDir"/> <bean:write name="DireccionesActionForm" property="segundoApellidoClienteDir"/>" 
			/>
          </td>
       </tr>
	   <P>
	   <P>
	   <P>
	   <tr>
         <td colspan="2"><strong>Direcciones del Cliente</strong></td>
       </tr>

	   <tr>
         <td colspan="2" align="center">
		  <html:select name="DireccionesActionForm" size="3"  property="direccionComputec" style="width:350px;" >
		  	<logic:notEmpty name="DireccionesActionForm" property="arrayDireccionComputec">
				<html:optionsCollection property="arrayDireccionComputec" value="codigo" label="descripcion"/>          	
		    </logic:notEmpty>
          </html:select>
         <td>
       </tr>
       
	 </TABLE>
   </logic:equal> 
   
    <!--Pagina de direcciones--> 
    
    <logic:equal name="DireccionesActionForm" property="pagina" value="paginaDirecciones">     

     <TABLE align="center" width="90%" border=0>
        <tr>
           <bean:define id="tipoCalleDTO" name="DireccionesActionForm" property="tipoCalleDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="tipoCalleDTO" property="caption"/>
  		  </td>
  		  <td>
		    <html:select name="DireccionesActionForm" property="tipoCalle" style="width:270px;" >
    		    <html:option value="-1">&nbsp;</html:option>
    		    <logic:notEmpty name="DireccionesActionForm" property="arrayTipoCalle">
		          <html:optionsCollection property="arrayTipoCalle" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
		    </html:select>
		  </td>
        </tr> 

        <tr>
          <bean:define id="nombreCalleDTO" name="DireccionesActionForm" property="nombreCalleDireccionDTO" 
          type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td width="25%">
          	<bean:write name="nombreCalleDTO" property="caption"/>
  		  </td>
          <td width="70%">
          	<html:text name="DireccionesActionForm" property="nombreCalle" size="51"
             maxlength="<%=String.valueOf(nombreCalleDTO.getLargoMaximo())%>" 
             style="text-transform: uppercase;" onkeyup="upperCase(this);"
             onkeypress="soloCaracteresValidos();"/>	      	
          </td>
        </tr>
        
        <tr>
          <bean:define id="numeroCalleDTO" name="DireccionesActionForm" property="numeroCalleDireccionDTO" 
          type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
          	<bean:write name="numeroCalleDTO" property="caption"/>
  		  </td>
          <td>
            <html:text name="DireccionesActionForm" property="numeroCalle" size="51" 
            maxlength="<%=String.valueOf(numeroCalleDTO.getLargoMaximo())%>" 
            style="text-transform: uppercase;" onkeyup="upperCase(this);"
            onkeypress="soloCaracteresValidos();"/>	      	
          </td>
        </tr>

        <tr>
          <bean:define id="numeroPisoDTO" name="DireccionesActionForm" property="numeroPisoDireccionDTO" 
          type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="numeroPisoDTO" property="caption"/>
  		  </td>
          <td>
          	<html:text name="DireccionesActionForm" property="numeroPiso" size="51" 
          	maxlength="<%=String.valueOf(numeroPisoDTO.getLargoMaximo())%>"
          	style="text-transform: uppercase;" onkeyup="upperCase(this);"
          	onkeypress="soloCaracteresValidos();"/>	
          </td>
        </tr>
        
        <tr>
           <bean:define id="regionDTO" name="DireccionesActionForm" property="regionDireccionDTO"
            type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="regionDTO" property="caption"/>
  		  </td>
  		  <td>
		    <html:select name="DireccionesActionForm" property="region" style="width:270px;" onchange="getProvincias();">
     		    <html:option value="-1">&nbsp;</html:option>
		        <logic:notEmpty name="DireccionesActionForm" property="arrayRegion">
		          <html:optionsCollection property="arrayRegion" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
		    </html:select>
		  </td>
        </tr>   
        <tr>
           <bean:define id="provinciaDTO" name="DireccionesActionForm" property="provinciaDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="provinciaDTO" property="caption"/>
  		  </td>
  		  <td>
		    <html:select name="DireccionesActionForm" property="provincia" style="width:270px;" onchange="getCiudades();">
    		    <html:option value="-1">&nbsp;</html:option>
    		    <logic:notEmpty name="DireccionesActionForm" property="arrayProvincia">
    		      <html:optionsCollection property="arrayProvincia" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
		    </html:select>
		  </td>
        </tr>   
        <tr>
           <bean:define id="ciudadDTO" name="DireccionesActionForm" property="ciudadDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="ciudadDTO" property="caption"/>
  		  </td>
  		  <td>
		    <html:select name="DireccionesActionForm" property="ciudad" style="width:270px;" onchange="getComunas();">
		     <html:option value="-1">&nbsp;</html:option>
    		    <html:option value="-1">&nbsp;</html:option>
		        <logic:notEmpty name="DireccionesActionForm" property="arrayCiudad">
		          <html:optionsCollection property="arrayCiudad" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
		    </html:select>
		  </td>
        </tr>   
        <tr>
           <bean:define id="comunaDTO" name="DireccionesActionForm" property="comunaDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="comunaDTO" property="caption"/>
  		  </td>
  		  <td>
		    <html:select name="DireccionesActionForm" property="comuna" style="width:270px;" onchange="getZipComuna();">
    		    <html:option value="-1">&nbsp;</html:option>
    		    <logic:notEmpty name="DireccionesActionForm" property="arrayComuna">
		          <html:optionsCollection property="arrayComuna" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
		    </html:select>
		  </td>
        </tr> 

        
        <logic:notEmpty name="DireccionesActionForm" property="zipDireccionDTO">
          <bean:define id="zipDTO" name="DireccionesActionForm" property="zipDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <tr>
	          <td>
	            <bean:write name="zipDTO" property="caption"/>
	  		  </td>
	  		  <td>
			    <html:select name="DireccionesActionForm" property="zip" style="width:270px;">
	    		    <html:option value="-1">&nbsp;</html:option>
	    		    <logic:notEmpty name="DireccionesActionForm" property="arrayZip">
			          <html:optionsCollection property="arrayZip" value="codigo" label="descripcion"/>
		          	</logic:notEmpty>
			    </html:select>
			  </td>
          </tr>   
		</logic:notEmpty>

        <logic:notEmpty name="DireccionesActionForm" property="casillaDireccionDTO">
         <bean:define id="casillaDTO" name="DireccionesActionForm" property="casillaDireccionDTO" 
          type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
	       <tr>
	          <td>
	            <bean:write name="casillaDTO" property="caption"/>
	  		  </td>
	  		  <td>
	    		<html:text name="DireccionesActionForm" property="casilla" size="51" 
				maxlength="<%=String.valueOf(casillaDTO.getLargoMaximo())%>"/>	
			  <td>
	        </tr>   
		</logic:notEmpty>
          
        <tr>
           <bean:define id="observacionDTO" name="DireccionesActionForm" property="observacionDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="observacionDTO" property="caption"/>
            
  		  </td>
  		  <td>
    		<html:text name="DireccionesActionForm" property="observacion" size="51" 
			maxlength="<%=String.valueOf(observacionDTO.getLargoMaximo())%>"
			style="text-transform: uppercase;" onkeyup="upperCase(this);"
			onkeypress="soloCaracteresValidos();"/>	
		    
		  <td>
        </tr>   
        <!-- 
         <tr>
          <td>
            <bean:define id="estadoDTO" name="DireccionesActionForm" property="estadoDireccionDTO"/>
            <FONT color="#0000ff"><bean:write name="estadoDTO" property="caption"/> </FONT>
  		  </td>
  		  <td>
		    <html:select name="DireccionesActionForm" property="estado" style="width:120px;">
		        <logic:notEmpty name="DireccionesActionForm" property="arrayEstado">
	              <html:optionsCollection property="arrayEstado" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
		    </html:select>
		  </td>
        </tr>        
        -->     
        
     </TABLE>
     </logic:equal>

     <P>
     <P>
     <P>
     <P>
     <P>
     <P>
     <P>
     <P>
   
     <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td width="25%" align="center">
            <html:button  value="ACEPTAR" style="width:120px;color:black" property="nada" onclick="enviarAceptar();"/>
            <html:button  value="CANCELAR" style="width:120px;color:black" property="nada" onclick="enviarCancelar();"/>
        </td>
      </tr>
     </TABLE>

    </html:form>
</body>

</html>
        
