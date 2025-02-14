<%@ taglib uri="../WEB-INF/tld/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="../WEB-INF/tld/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="../WEB-INF/tld/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="../WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="../WEB-INF/tld/struts-html.tld" prefix="html" %>


<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Telefónica Móviles</title>
	<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DireccionesAJAX.js'></script>

	<script>
		function getProvincias() {
  	      var region = $("region"); 
	      arrayProvincias = DireccionesAJAX.getProvincias(region.value,displayProvincias);
	      var tablaZipCode =  '<bean:write name="DireccionesActionForm" property="tablaZipCode"/>';
	      if (tablaZipCode == 'GE_REGIONES'){
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
	  	}
	  	function getComunas() {
  	      var region = $("region"); 
  	      var provincia = $("provincia"); 
  	      var ciudad = $("ciudad");
	      arrayComunas = DireccionesAJAX.getComunas(region.value,provincia.value,ciudad.value,displayComunas);
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


	  	function getCodigosPostales(codigoZona) {
	      arrayCodigosPostales = DireccionesAJAX.getCodigosPostales(codigoZona,displayCodigosPostales);
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
		      } else if (comunaObligatorio.value = '1' && (comuna.value == '' || comuna.value == '-1')){
			alert ('Debe ingresar ' + comunaCaption.value);
		      } else if (zipObligatorio.value = '1' && (zip.value == '' || zip.value == '-1')){
			alert ('Debe ingresar ' + zipCaption.value);
		      } else if (casillaObligatorio.value == ''){
			alert ('Debe ingresar ' + casillaCaption.value);
		      } else if (observacionObligatorio.value == ''){
			alert ('Debe ingresar ' + observacionCaption.value);
		      }else{
		    regionDescripcion.value = region.options[region.selectedIndex].text;
		    provinciaDescripcion.value = provincia.options[provincia.selectedIndex].text;
		    ciudadDescripcion.value = ciudad.options[ciudad.selectedIndex].text;
		    comunaDescripcion.value = comuna.options[comuna.selectedIndex].text;
		    zipDescripcion.value = zip.options[zip.selectedIndex].text;
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

    <html:form action="DireccionesAction.do" target="_self">
    <html:hidden property="codigoDireccion"/>
    <html:hidden property="tipoDireccion"/>
    <html:hidden property="accion"/>
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
     
     <TABLE align="center" width="90%" border=0>
        <tr>
           <bean:define id="tipoCalleDTO" name="DireccionesActionForm" property="tipoCalleDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="tipoCalleDTO" property="caption"/>
  		  </td>
  		  <td>
		    <html:select  tabindex="1" name="DireccionesActionForm" property="tipoCalle" style="width:270px;" >
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
          	<html:text  tabindex="2" name="DireccionesActionForm" property="nombreCalle" size="51"
             maxlength="<%=String.valueOf(nombreCalleDTO.getLargoMaximo())%>"/>	      	
          </td>
        </tr>
        
        <tr>
          <bean:define id="numeroCalleDTO" name="DireccionesActionForm" property="numeroCalleDireccionDTO" 
          type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
          	<bean:write name="numeroCalleDTO" property="caption"/>
  		  </td>
          <td>
            <html:text  tabindex="3" name="DireccionesActionForm" property="numeroCalle" size="51" 
            maxlength="<%=String.valueOf(numeroCalleDTO.getLargoMaximo())%>"/>	      	
          </td>
        </tr>

        <tr>
          <bean:define id="numeroPisoDTO" name="DireccionesActionForm" property="numeroPisoDireccionDTO" 
          type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="numeroPisoDTO" property="caption"/>
  		  </td>
          <td>
          	<html:text  tabindex="4" name="DireccionesActionForm" property="numeroPiso" size="51" 
          	maxlength="<%=String.valueOf(numeroPisoDTO.getLargoMaximo())%>"/>	
          </td>
        </tr>
        
        <tr>
           <bean:define id="regionDTO" name="DireccionesActionForm" property="regionDireccionDTO"
            type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="regionDTO" property="caption"/>
  		  </td>
  		  <td>
		    <html:select  tabindex="5" name="DireccionesActionForm" property="region" style="width:270px;" onchange="getProvincias();">
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
		    <html:select  tabindex="6" name="DireccionesActionForm" property="provincia" style="width:270px;" onchange="getCiudades();">
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
		    <html:select  tabindex="7" name="DireccionesActionForm" property="ciudad" style="width:270px;" onchange="getComunas();">
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
		    <html:select  tabindex="8" name="DireccionesActionForm" property="comuna" style="width:270px;" onchange="getZipComuna();">
    		    <html:option value="-1">&nbsp;</html:option>
    		    <logic:notEmpty name="DireccionesActionForm" property="arrayComuna">
		          <html:optionsCollection property="arrayComuna" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
		    </html:select>
		  </td>
        </tr> 
        <tr>
           <bean:define id="zipDTO" name="DireccionesActionForm" property="zipDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="zipDTO" property="caption"/>
  		  </td>
  		  <td>
		    <html:select  tabindex="9" name="DireccionesActionForm" property="zip" style="width:270px;">
    		    <html:option value="-1">&nbsp;</html:option>
    		    <logic:notEmpty name="DireccionesActionForm" property="arrayZip">
		          <html:optionsCollection property="arrayZip" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
		    </html:select>
		  </td>
        </tr>   

        <tr>
           <bean:define id="casillaDTO" name="DireccionesActionForm" property="casillaDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="casillaDTO" property="caption"/>
            
  		  </td>
  		  <td>
    		<html:text  tabindex="10" name="DireccionesActionForm" property="casilla" size="51" 
			maxlength="<%=String.valueOf(casillaDTO.getLargoMaximo())%>"/>	
		    
		  <td>
        </tr>   
          
        <tr>
           <bean:define id="observacionDTO" name="DireccionesActionForm" property="observacionDireccionDTO" 
           type = "com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO"/>
          <td>
            <bean:write name="observacionDTO" property="caption"/>
            
  		  </td>
  		  <td>
    		<html:text  tabindex="11" name="DireccionesActionForm" property="observacion" size="51" 
			maxlength="<%=String.valueOf(observacionDTO.getLargoMaximo())%>"/>	
		    
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
        <td width="25%" align="right">
            <!--<html:button  value="ACEPTAR" style="width:120px;color:black" property="nada" onclick="accion.value='grabar'; A();grabar();"/>-->
            <html:button   tabindex="12" value="ACEPTAR" style="width:120px;color:black" property="nada" onclick="grabar();"/>
            <html:button   tabindex="13" value="CANCELAR" style="width:120px;color:black" property="nada" onclick="javascript:history.back();"/>
        </td>
      </tr>
     </TABLE>

    </html:form>
</body>

</html>
        
