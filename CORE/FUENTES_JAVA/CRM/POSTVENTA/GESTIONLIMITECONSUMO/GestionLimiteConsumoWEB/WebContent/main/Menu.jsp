<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<%@page import="java.util.HashMap"%>

<%
long time = new java.util.Date().getTime();
String confUsoCarpeta = "../configuracion/MostrarFlagUsoCarpetaAction.do?timestamp=" + time;
String mantenedorParam = "../mantenedorparametro/MostrarMantenerParametroAction.do?timestamp=" + time;
String menuMantenedorArticulo = "../mantenedorarticulo/MostrarMenuCargarArticulosAction.do?timestamp=" + time;
String buscarDescuentosCliente = "../consultas/MostrarDescuentosClienteAction.do?timestamp=" + time;
String buscarDescuentosCarpeta = "../descuentoscarpeta/MostrarDescuentosCarpetaAction.do?timestamp=" + time;
String buscarDescuentosArticulo = "../consultas/MostrarDescuentosArticuloAction.do?timestamp=" + time;
String buscarSubsidioArticulo = "../consultas/MostrarSubsidioArticuloAction.do?timestamp=" + time;
String buscarModificacionesServicio = "../consultas/MostrarModificacionesServicioAction.do?timestamp=" + time;

String menuIndPlanTarifario = "../mantenedorindicadores/MostrarActualizarIndicadoresPlanTarifarioAction.do?timestamp=" + time;
String menuIndPlanAdicional =  "../mantenedorindicadores/MostrarActualizarIndicadoresPlanAdicionalAction.do?timestamp=" + time;
//String menuIndServSuplementario = "../mantenedorindicadores/MostrarMenuIndicadorServicioSuplementarioAction.do?timestamp=" + time;
String menuIndServSuplementario = "../mantenedorindicadores/MostrarActualizarIndicadoresServicioSuplementarioAction.do?timestamp=" + time;
String crearRango = "../administrarrango/MostrarCrearRangoAction.do?timestamp=" + time;
String modifElimRango = "../administrarrango/MostrarModificarEliminarRangoAction.do?timestamp=" + time;
String asociarPlanesServ = "../administrarrango/MostrarAsociarPlanesServiciosAction.do?timestamp=" + time;
String copiarRango = "../administrarrango/MostrarCopiarRangoAction.do?timestamp=" + time;
String menuCrearCarpeta = "../administrarcarpeta/MostrarMenuCrearCarpetaAction.do?timestamp=" + time;
String copiarCarpeta = "../administrarcarpeta/MostrarCopiarCarpetaAction.do?timestamp=" + time;
String publicarCarpeta = "../administrarcarpeta/MostrarPublicarCarpetaAction.do?timestamp=" + time;
String consultarCarpeta = "../administrarcarpeta/MostrarConsultarCarpetaAction.do?timestamp=" + time;
String cargarDatosSimulacion = "../operarcarpetas/MostrarCarpetasSimulacionDefinitivaAction.do?timestamp=" + time;
String mostrarModificarCarpeta = "../administrarcarpeta/MostrarCambiarEstadoCarpetaAction.do?timestamp" + time;
String mostrarRestriccionArticulo = "../administrarcarpeta/MostarRestriccionArticuloAction.do?timestamp" + time;
String obtenerDatosSimulacion = "../operarcarpetas/MostrarCarpetasSimulacionAction.do?timestamp=" + time;
String modificarCarpeta = "../administrarcarpeta/MostrarCarpetaAction.do?timestamp=" + time;
String mostrarMigrarCarpeta = "../operarcarpetas/MostrarMigrarCarpetaComercialAction.do?timestamp=" + time;

String cargarArticulos = "../mantenedorarticulo/MostrarCargarArticulosAction.do?timestamp=" + time;
String mantenedorPrecio = "../mantenedorarticulo/MostrarMantenerPrecioBaseAction.do?timestamp=" + time;
String mantenedorArticulo = "../mantenedorarticulo/MostrarMantenerArticuloAction.do?timestamp=" + time;
String cargarPrecioBase = "../mantenedorarticulo/MostrarCargarPrecioBaseAction.do?timestamp=" + time;

String copiarCarpetaEnBaseAsiMisma = "../administrarcarpeta/MostrarCopiarCarpetaAction.do?timestamp=" + time;
String crearOtraCopiaCarpetaDesdeCero= "../administrarcarpeta/MostrarCopiarOtraCarpetaAction.do?timestamp="+time;
String crearCarpeta_new="../administrarcarpeta/MostrarCrearCarpetaDesdeCeroAction.do?timestamp="+time;

String salir = "../main/Logout.jsp?timestamp=" + time;

HashMap menus = (HashMap)request.getSession().getAttribute("MENUS");

if(menus == null){
	menus = new HashMap();
}

%>


<html>
<head>
<title>
Carpetas Comerciales
</title>

<link href="../styles/mas.css?timestamp=<%=time %>" rel="stylesheet" type="text/css" />
<script language="JavaScript" type="text/javascript" src="../scripts/jScript.js?timestamp=<%=time%>"></script>
<script language="JavaScript" type="text/javascript" src="../scripts/funciones.js"></script>
<script language="JavaScript" type="text/javascript">
var arrTablas = new Array("tbMantenedores","tbConfiguracion","tbAdministrarRango","tbAdministrarCarpetasComerciales","tbOperarCarpetasComerciales","tbConsultas");

function desplegarMenu(idObject){
	
	var objeto = document.getElementById(idObject);
	
	if(objeto.style.display == 'none'){
	
		objeto.style.display = "";
	
	}else{
	
		objeto.style.display = "none";
	
	}

}
</script>

</head>
<body bgcolor="#ffffff">
<table width="210" align="right" valign ="top" border="0" bordercolor="#2d2c65" cellpadding="1" cellspacing="1">

<!--------------------------------------------------------------------------------------------->
		<tr>
			<td id="tbPadreMantenedores" class="menupadreimg">
				<a style="color:#FFFFFF" href="javascript:Despliega('tbMantenedores')" title="Mantenedores"
					onMouseMove="javascript:Colorear('tbPadreMantenedores', '#7A8B01');"
					onMouseOut="javascript:Colorear('tbPadreMantenedores', '#8EC135');">Mantenedores</a>
			</td>
		</tr>
		<tr id="tbMantenedores" style="DISPLAY:none">
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#2d2c65">
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbMantenerArticulo" class="menuhijo">
							<a style="color:#FFFFFF" href="javascript:desplegarMenu('tbMantenedoresArticulo')" title="Mantener Artículo"
								onMouseMove="javascript:Colorear('tbMantenerArticulo', '#7C7C7C');"
								onMouseOut="javascript:Colorear('tbMantenerArticulo', '#B4B4B4');">Mantener Art&iacute;culo </a>
						</td>
					</tr>
					<tr id="tbMantenedoresArticulo" style="DISPLAY:none;">
						<td>
							<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#2d2c65">
								<tr>
									<td id="tbMantenerArticuloIndividual" class="menusubhijo">
										<%if(menus.containsKey("01") && menus.containsKey("01/1")){ System.out.println(" existe 01/1");%>
										<a style="color:#FFFFFF" 
										   href="<%=response.encodeURL(mantenedorArticulo) %>" 
										   target="display" 
										   title="Mantener Artículo" 
										   onMouseMove="javascript:Colorear('tbMantenerArticuloIndividual', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbMantenerArticuloIndividual', '#B4B4B4');">Mantener Art&iacute;culo</a>
										<%}else{ System.out.println(" no existe 01/1");%>   
										<a style="color: #CCC" 
										   href="#" 
										   title="Mantener Artículo" 
										   onMouseMove="javascript:Colorear('tbMantenerArticuloIndividual', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbMantenerArticuloIndividual', '#B4B4B4');">Mantener Art&iacute;culo</a>
										<%} %>
									</td>
								</tr>
								<tr>
									<td id="tbMantenerPrecioBaseArticulo" class="menusubhijo">
									<%if(menus.containsKey("01") && menus.containsKey("01/2")){ System.out.println(" existe 01/2");%>
									<a style="color:#FFFFFF" 
									   href="<%=response.encodeURL(mantenedorPrecio) %>" 
									   target="display" 
									   title="Mantener Precio Base Artículos" 
									   onMouseMove="javascript:Colorear('tbMantenerPrecioBaseArticulo', '#7C7C7C');"	
									   onMouseOut="javascript:Colorear('tbMantenerPrecioBaseArticulo', '#B4B4B4');">
									Mantener Precios Base Art&iacute;culos</a>
									<%}else{ System.out.println(" no existe 01/2");%>
									<a style="color: #CCC" 
									   href="#" 
									   title="Mantener Precio Base Artículos" 
									   onMouseMove="javascript:Colorear('tbMantenerPrecioBaseArticulo', '#7C7C7C');"	
									   onMouseOut="javascript:Colorear('tbMantenerPrecioBaseArticulo', '#B4B4B4');">
									Mantener Precios Base Art&iacute;culos</a>
									<%} %>
									</td>
								</tr>
								<tr>
									<td id="tbCargaMasivaArticulos" class="menusubhijo">
										<%if(menus.containsKey("01") && menus.containsKey("01/3")){ System.out.println(" existe 01/3");%>
										<a style="color:#FFFFFF" 
										   href="<%=response.encodeURL(cargarArticulos) %>" 
										   target="display" 
										   title="Carga Masiva de Artículos" 
										   onMouseMove="javascript:Colorear('tbCargaMasivaArticulos', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbCargaMasivaArticulos', '#B4B4B4');">
										   Carga Masiva de Art&iacute;culos</a>
										<%}else{ System.out.println(" no existe 01/3");%>   
										<a style="color: #CCC" 
										   href="#" 
										   title="Carga Masiva de Artículos" 
										   onMouseMove="javascript:Colorear('tbCargaMasivaArticulos', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbCargaMasivaArticulos', '#B4B4B4');">
										   Carga Masiva de Art&iacute;culos</a>
										<%} %>
									</td>
								</tr>
								<tr>
									<td id="tbCargaMasivaPrecioBase" class="menusubhijo">
									<%if(menus.containsKey("01") && menus.containsKey("01/4")){ System.out.println(" existe 01/4");%>
										<a style="color:#FFFFFF" 
										   href="<%=response.encodeURL(cargarPrecioBase) %>" 
										   target="display" 
										   title="Carga Masiva de Precio Base" 
										   onMouseMove="javascript:Colorear('tbCargaMasivaPrecioBase', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbCargaMasivaPrecioBase', '#B4B4B4');">
										   Carga Masiva de Precios Base</a>
									<%}else{ System.out.println(" no existe 01/4");%>
										<a style="color: #CCC" 
										   href="#" 
										   title="Carga Masiva de Precio Base" 
										   onMouseMove="javascript:Colorear('tbCargaMasivaPrecioBase', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbCargaMasivaPrecioBase', '#B4B4B4');">
										   Carga Masiva de Precios Base</a>
									<%} %>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<%if(menus.containsKey("02")){ System.out.println(" existe 02");%>
						<td id="tbMantenerIndicadorPlanTarifario" class="menuhijo">
								<a style="color:#FFFFFF" href="<%=response.encodeURL(menuIndPlanTarifario) %>" target="display" title="Mantener Indicador Plan Tarifario"
									onMouseMove="javascript:Colorear('tbMantenerIndicadorPlanTarifario', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbMantenerIndicadorPlanTarifario', '#B4B4B4');">Mantener Indicador Plan Tarifario </a>
						</td>
						<%}else{ System.out.println(" no existe 02");%>
						<td id="tbMantenerIndicadorPlanTarifario" class="menuhijo">
								<a style="color: #CCC" href="#" title="Mantener Indicador Plan Tarifario">Mantener Indicador Plan Tarifario </a>
						</td>
						<%} %>
					</tr>
					<tr>
						<%if(menus.containsKey("03")){ System.out.println(" existe 03");%>
						<td id="tbMantenerIndicadorPlanAdicional" class="menuhijo">
								<a style="color:#FFFFFF" href="<%=response.encodeURL(menuIndPlanAdicional) %>" target="display" title="Mantener Indicador Plan Adicional"
									onMouseMove="javascript:Colorear('tbMantenerIndicadorPlanAdicional', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbMantenerIndicadorPlanAdicional', '#B4B4B4');">Mantener Indicador Plan Adicional </a>
						</td>
						<%}else{ System.out.println(" no existe 03");%>
						<td id="tbMantenerIndicadorPlanAdicional" class="menuhijo">
								<a style="color: #CCC" href="#" title="Mantener Indicador Plan Adicional">Mantener Indicador Plan Adicional </a>
						</td>
						<%} %>
					</tr>
					<tr>
						<%if(menus.containsKey("04")){ System.out.println(" existe 04");%>						
						<td id="tbMantenerIndicadorServicioSuplementario" class="menuhijo">
								<a style="color:#FFFFFF" href="<%=response.encodeURL(menuIndServSuplementario) %>" target="display" title="Mantener Indicador Servicio Suplementario"
									onMouseMove="javascript:Colorear('tbMantenerIndicadorServicioSuplementario', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbMantenerIndicadorServicioSuplementario', '#B4B4B4');">Mantener Indicador Servicio Suplementario </a>
						</td>
						<%}else{ System.out.println(" no existe 04");%>
						<td id="tbMantenerIndicadorServicioSuplementario" class="menuhijo">
								<a style="color: #CCC" href="#" title="Mantener Indicador Servicio Suplementario">Mantener Indicador Servicio Suplementario </a>
						</td>
						<%} %>
					</tr>
					<tr>
						<%if(menus.containsKey("05")){ System.out.println(" existe 05");%>						
						<td id="tbMantenerParametros" class="menuhijo">
							<a style="color:#FFFFFF" href="<%=response.encodeURL(mantenedorParam)%>" target="display" title="Mantenedor de Parámetros"
								onMouseMove="javascript:Colorear('tbMantenerParametros', '#7C7C7C');"
								onMouseOut="javascript:Colorear('tbMantenerParametros', '#B4B4B4');">Mantenedor de Par&aacute;metros</a>
						</td>
						<%}else{ System.out.println(" no existe 05");%>
						<td id="tbMantenerParametros" class="menuhijo">
							<a style="color: #CCC" href="#" title="Mantenedor de Parámetros">Mantenedor de Par&aacute;metros</a>
						</td>
						<%} %>
					</tr>					
				 <!--------------------------------------------------------------------------------------------------->
				</table>
			</td>
		</tr>
		<!-------------------------------------------------------------------------------------------------->


		<!-------------------------------------------------------------------------------------------------->
		<tr>
			<td id="tbPadreConfiguracion" class="menupadreimg">
				<a style="color:#FFFFFF" href="javascript:Despliega('tbConfiguracion')" title="Configuración"
					onMouseMove="javascript:Colorear('tbPadreConfiguracion', '#7A8B01');"
					onMouseOut="javascript:Colorear('tbPadreConfiguracion', '#8EC135');">Configuraci&oacute;n</a>			</td>
		</tr>
		<tr id="tbConfiguracion" style="DISPLAY:none">
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#2d2c65">
					<!--------------------------------------------------------------------------------------------------->
					
					<tr>
						<td id="tbUsoCarpetasComerciales" bgcolor="#00005A" class="menuhijo">
						<%if(menus.containsKey("06/1")){ System.out.println(" existe 06/1");%>
							<a style="color:#FFFFFF" href="<%=response.encodeURL(confUsoCarpeta)%>" target="display" title="Uso de Carpetas Comerciales"
								onMouseMove="javascript:Colorear('tbUsoCarpetasComerciales', '#7C7C7C');"
								onMouseOut="javascript:Colorear('tbUsoCarpetasComerciales', '#B4B4B4');">Uso de Carpetas Comerciales  </a>
						<%}else{ System.out.println(" no existe 06/1");%>
							<a style="color: #CCC" href="#" title="Uso de Carpetas Comerciales">Uso de Carpetas Comerciales  </a>
						<%} %>
						</td>
					</tr>

          <!--------------------------------------------------------------------------------------------------->
				</table>
			</td>
		</tr>
		<!-------------------------------------------------------------------------------------------------->


		<!--------------------------------------------------------------------------------------------->
		<tr>
			<td id="tbPadreAdministrarRango" class="menupadreimg">
				<a style="color:#FFFFFF" href="javascript:Despliega('tbAdministrarRango')" title="Administrar Rangos"
					onMouseMove="javascript:Colorear('tbPadreAdministrarRango', '#7A8B01');"
					onMouseOut="javascript:Colorear('tbPadreAdministrarRango', '#8EC135');"> Administrar Rangos</a>			</td>
		</tr>
		<tr id="tbAdministrarRango" style="DISPLAY:none">
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#2d2c65" >
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbCrearRango" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("07/1")){ System.out.println(" existe 07/1");%>	
								<a style="color:#FFFFFF" href="<%=response.encodeURL(crearRango)%>" target="display" title="Crear Rango"
									onMouseMove="javascript:Colorear('tbCrearRango', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbCrearRango', '#B4B4B4');">Crear Rango</a>
							<%}else{System.out.println(" no existe 07/1");%>
								<a style="color: #CCC" href="#" title="Crear Rango">Crear Rango</a>
							<%} %>
						</td>
					</tr>
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbEliminarModificarRango" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("07/2")){ System.out.println(" existe 07/2");%>		
								<a style="color:#FFFFFF" href="<%=response.encodeURL(modifElimRango)%>" target="display" title="Modificar y Eliminar Rango"
									onMouseMove="javascript:Colorear('tbEliminarModificarRango', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbEliminarModificarRango', '#B4B4B4');">Modificar y Eliminar Rango</a>
							<%}else{ System.out.println(" no existe 07/2");%>
								<a style="color: #CCC" href="#" title="Modificar y Eliminar Rango">Modificar y Eliminar Rango</a>
							<%} %>
						</td>
					</tr>
					<tr>
						<td id="tbAsociarServicioPlanes" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("07/3")){ System.out.println(" existe 07/3");%>
								<a style="color:#FFFFFF" href="<%=response.encodeURL(asociarPlanesServ)%>" target="display" title="Asociar Servicio o Planes"
									onMouseMove="javascript:Colorear('tbAsociarServicioPlanes', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbAsociarServicioPlanes', '#B4B4B4');">Asociar Servicio o Planes</a>
							<%}else{ System.out.println(" existe 07/3");%>
								<a style="color: #CCC" href="#" title="Asociar Servicio o Planes">Asociar Servicio o Planes</a>
							<%} %>
						</td>
					</tr>
					<tr>
						<td id="tbCopiarRango" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("07/4")){ System.out.println(" existe 07/4");%>
								<a style="color:#FFFFFF" href="<%=response.encodeURL(copiarRango)%>" target="display" title="Copiar Rango"
									onMouseMove="javascript:Colorear('tbCopiarRango', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbCopiarRango', '#B4B4B4');">Copiar Rango</a>
							<%}else{ System.out.println(" no existe 07/4");%>
								<a style="color: #CCC" href="#" title="Copiar Rango">Copiar Rango</a>
							<%} %>
						</td>
					</tr>									
          <!--------------------------------------------------------------------------------------------------->
				</table>
			</td>
		</tr>
		<!------------------------------------------------------------------------------------------------>

		<tr>
			<td id="tbPadreAdministrarCarpetasComerciales" class="menupadreimg">
				<a style="color:#FFFFFF" href="javascript:Despliega('tbAdministrarCarpetasComerciales')" title="Administrar Carpetas Comerciales"
					onMouseMove="javascript:Colorear('tbPadreAdministrarCarpetasComerciales', '#7A8B01');"
					onMouseOut="javascript:Colorear('tbPadreAdministrarCarpetasComerciales', '#8EC135');"> Administrar Carpetas Comerciales</a>			</td>
		</tr>
		<tr id="tbAdministrarCarpetasComerciales" style="DISPLAY:none">
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#2d2c65" >
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbCrearCarpetasComerciales" bgcolor="#00005A" class="menuhijo">
							<a style="color:#FFFFFF" href="javascript:desplegarMenu('tbCreacionCarpetas')" title="Crear Carpetas Comerciales"
								onMouseMove="javascript:Colorear('tbCrearCarpetasComerciales', '#7C7C7C');"
								onMouseOut="javascript:Colorear('tbCrearCarpetasComerciales', '#B4B4B4');">Crear Carpetas Comerciales</a>
						</td>
					</tr>
					<tr id="tbCreacionCarpetas" style="DISPLAY:none;">
						<td>
							<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#2d2c65">
								<tr>
									<td id="tbCrearCarpetaCero" class="menusubhijo">
										<%if(menus.containsKey("08") && menus.containsKey("08/1") && menus.containsKey("08/1/1")){ System.out.println(" existe 08/1/1");%>
										<a style="color:#FFFFFF" 
										   href="<%=response.encodeURL(crearCarpeta_new) %>" 
										   target="display" 
										   title="Crear Carpeta desde cero" 
										   onMouseMove="javascript:Colorear('tbCrearCarpetaCero', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbCrearCarpetaCero', '#B4B4B4');">
										   Crear Carpeta desde cero</a>
										<%}else{ System.out.println(" no existe 08/1/1");%>   
										<a style="color: #CCC" 
										   href="#" 
										   title="Crear Carpeta desde cero" 
										   onMouseMove="javascript:Colorear('tbMantenerArticuloIndividual', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbMantenerArticuloIndividual', '#B4B4B4');">
										   Crear Carpeta desde cero</a>
										<%} %>
									</td>
								</tr>
								<tr>
									<td id="tbCrearCarpetaEnSiMisma" class="menusubhijo">
									<%if(menus.containsKey("08") && menus.containsKey("08/1") && menus.containsKey("08/1/2")){ System.out.println(" existe 08/1/2");%>
									<a style="color:#FFFFFF" 
									   href="<%=response.encodeURL(copiarCarpetaEnBaseAsiMisma) %>" 
									   target="display" 
									   title="Crear Carpeta en base a si misma" 
									   onMouseMove="javascript:Colorear('tbCrearCarpetaEnSiMisma', '#7C7C7C');"	
									   onMouseOut="javascript:Colorear('tbCrearCarpetaEnSiMisma', '#B4B4B4');">
									Crear Carpeta en base a si misma</a>
									<%}else{ System.out.println(" no existe 08/1/2");%>
									<a style="color: #CCC" 
									   href="#" 
									   title="Crear Carpeta en base a si misma" 
									   onMouseMove="javascript:Colorear('tbCrearCarpetaEnSiMisma', '#7C7C7C');"	
									   onMouseOut="javascript:Colorear('tbCrearCarpetaEnSiMisma', '#B4B4B4');">
									Crear Carpeta en base a si misma</a>
									<%} %>
									</td>
								</tr>
								<tr>
									<td id="tbCrearCarpetaEnCopia" class="menusubhijo">
										<%if(menus.containsKey("08") && menus.containsKey("08/1") && menus.containsKey("08/1/3")){ System.out.println(" existe 08/1/3");%>
										<a style="color:#FFFFFF" 
										   href="<%=response.encodeURL(crearOtraCopiaCarpetaDesdeCero) %>" 
										   target="display" 
										   title="Crear Carpeta en base a una copia" 
										   onMouseMove="javascript:Colorear('tbCrearCarpetaEnCopia', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbCrearCarpetaEnCopia', '#B4B4B4');">
										   Crear Carpeta en base a una copia</a>
										<%}else{ System.out.println(" no existe 08/1/3");%>   
										<a style="color: #CCC" 
										   href="#" 
										   title="Crear Carpeta en base a una copia" 
										   onMouseMove="javascript:Colorear('tbCrearCarpetaEnCopia', '#7C7C7C');"	
										   onMouseOut="javascript:Colorear('tbCrearCarpetaEnCopia', '#B4B4B4');">
										   Crear Carpeta en base a una copia</a>
										<%} %>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbAsignarRestriccionArticulos" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("08/2")){ System.out.println(" existe 08/2");%>	
								<a style="color:#FFFFFF" href="<%=response.encodeURL(mostrarRestriccionArticulo)%>" target="display" title="Asignar Restricciones de artículos por rango"
									onMouseMove="javascript:Colorear('tbAsignarRestriccionArticulos', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbAsignarRestriccionArticulos', '#B4B4B4');">Asignar Restricci&oacute;n de art&iacute;culo por Rango</a>
							<%}else{ System.out.println("no existe 08/2");%>
								<a style="color: #CCC" href="#" title="Asignar Restricciones de artículos por rango">Asignar Restricci&oacute;n de art&iacute;culo por Rango</a>
							<%} %>
						</td>
					</tr>
					<tr>
						<td id="tbCambiarEstadoCarpeta" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("08/3")){ System.out.println(" existe 08/3");%>		
								<a style="color:#FFFFFF" href="<%=response.encodeURL(mostrarModificarCarpeta) %>" target="display" title="Asociar Servicio o Planes"
									onMouseMove="javascript:Colorear('tbCambiarEstadoCarpeta', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbCambiarEstadoCarpeta', '#B4B4B4');">Cambiar Estado de la Carpeta </a>
							<%}else{ System.out.println("no existe 08/3");%>
								<a style="color: #CCC" href="#" title="Asociar Servicio o Planes">Cambiar Estado de la Carpeta </a>
							<%} %>
						</td>
					</tr>
					<tr>
						<td id="tbModificarCarpeta" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("08/4")){ System.out.println(" existe 08/4");%>						
								<a style="color:#FFFFFF" href="<%=response.encodeURL(modificarCarpeta) %>" target="display" title="Modificar Carpeta"
									onMouseMove="javascript:Colorear('tbModificarCarpeta', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbModificarCarpeta', '#B4B4B4');">Modificar Carpeta</a>
							<%}else{ System.out.println("no existe 08/4");%>
								<a style="color: #CCC" href="#" title="Modificar Carpeta">Modificar Carpeta</a>
							<%} %>
						</td>
					</tr>	
					<tr>
						<td id="tbConsultarCarpeta" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("08/5")){ System.out.println(" existe 08/5");%>							
								<a style="color:#FFFFFF" href="<%=response.encodeURL(consultarCarpeta) %>" target="display" title="Consultar Carpeta"
									onMouseMove="javascript:Colorear('tbConsultarCarpeta', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbConsultarCarpeta', '#B4B4B4');">Consultar Carpeta</a>
							<%}else{ System.out.println("no existe 08/5");%>
								<a style="color: #CCC" href="#" title="Consultar Carpeta">Consultar Carpeta</a>
							<%} %>
						</td>
					</tr>									
          <!--------------------------------------------------------------------------------------------------->
				</table>
			</td>
		</tr>

<!---------------------------------------------------------------------------------------------------------------->

		<tr>
			<td id="tbPadreOperarCarpetasComerciales" class="menupadreimg">
				<a style="color:#FFFFFF" href="javascript:Despliega('tbOperarCarpetasComerciales')" title="Operar Carpetas Comerciales"
					onMouseMove="javascript:Colorear('tbPadreOperarCarpetasComerciales', '#7A8B01');"
					onMouseOut="javascript:Colorear('tbPadreOperarCarpetasComerciales', '#8EC135');"> Operar Carpetas Comerciales</a>			</td>
		</tr>
		<tr id="tbOperarCarpetasComerciales" style="DISPLAY:none">
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#2d2c65" >
					<!--------------------------------------------------------------------------------------------------->
					<!-- tr>
						<td id="tbCopiarCarpetasComerciales" bgcolor="#00005A" class="menuhijo">
								<a style="color:#FFFFFF" href="<%//=response.encodeURL(copiarCarpeta)%>" target="display" title="Copiar Carpetas Comerciales"
									onMouseMove="javascript:Colorear('tbCopiarCarpetasComerciales', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbCopiarCarpetasComerciales', '#B4B4B4');">Copiar Carpetas Comerciales</a>
						</td>
					</tr-->
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbPublicarCarpetasComerciales" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("09/1")){ System.out.println(" existe 09/1");%>
								<a style="color:#FFFFFF" href="<%=response.encodeURL(publicarCarpeta) %>" target="display" title="Publicar Carpetas Comerciales"
									onMouseMove="javascript:Colorear('tbPublicarCarpetasComerciales', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbPublicarCarpetasComerciales', '#B4B4B4');">Publicar Carpetas Comerciales</a>
							<%}else{ System.out.println("no existe 09/1");%>
								<a style="color: #CCC" href="#" title="Publicar Carpetas Comerciales">Publicar Carpetas Comerciales</a>
							<%} %>
						</td>
					</tr>
          <!--------------------------------------------------------------------------------------------------->

					<tr>
						<td id="tbMigrarCarpetasComerciales" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("09/2")){ System.out.println(" existe 09/2");%>
								<a style="color:#FFFFFF" href="<%=response.encodeURL(mostrarMigrarCarpeta) %>" target="display" title="Migrar Carpetas Comerciales"
									onMouseMove="javascript:Colorear('tbMigrarCarpetasComerciales', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbMigrarCarpetasComerciales', '#B4B4B4');">Migrar Carpetas Comerciales</a>
							<%}else{ System.out.println("no existe 09/2");%>
								<a style="color: #CCC" href="#" title="Migrar Carpetas Comerciales">Migrar Carpetas Comerciales</a>
							<%} %>
							
						</td>
					</tr>
          <!--------------------------------------------------------------------------------------------------->

					<tr>
						<td id="tbObtenerSimulacionCarpetasComerciales" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("09/3")){ System.out.println(" existe 09/3");%>	
								<a style="color:#FFFFFF" href="<%=response.encodeRedirectURL(obtenerDatosSimulacion) %>" target="display" title="Obtener Datos para Simulación de Carpetas"
									onMouseMove="javascript:Colorear('tbObtenerSimulacionCarpetasComerciales', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbObtenerSimulacionCarpetasComerciales', '#B4B4B4');">Obtener Datos para Simulaci&oacute;n  de Carpetas</a>
									
							<%}else{ System.out.println("no existe 09/3");%>
								<a style="color: #CCC" href="#" title="Obtener Datos para Simulación de Carpetas">Obtener Datos para Simulaci&oacute;n  de Carpetas</a>
							<%} %>
						</td>
					</tr>
          <!--------------------------------------------------------------------------------------------------->
		  
					<tr>
						<td id="tbCargarSimulacionDefinitiva" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("09/4")){ System.out.println(" existe 09/4");%>		
								<a style="color:#FFFFFF" href="<%=response.encodeRedirectURL(cargarDatosSimulacion) %>" target="display" title="Obtener Datos para Simulación de Carpetas"
									onMouseMove="javascript:Colorear('tbCargarSimulacionDefinitiva', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbCargarSimulacionDefinitiva', '#B4B4B4');">Cargar Datos de Simulaci&oacute;n Definitiva</a>
							<%}else{ System.out.println("no existe 09/4");%>
								<a style="color: #CCC" href="#" title="Obtener Datos para Simulación de Carpetas">Cargar Datos de Simulaci&oacute;n Definitiva</a>
							<%} %>
						</td>
					</tr>
          <!--------------------------------------------------------------------------------------------------->		  

				</table>
			</td>
		</tr>


<!------------------------------------ INICIO CONSULTAS --------------------------------------------------------->
		<tr>
			<td id="tbPadreConsultas" class="menupadreimg">
				<a style="color:#FFFFFF" href="javascript:Despliega('tbConsultas')" title="Consultas"
					onMouseMove="javascript:Colorear('tbPadreConsultas', '#7A8B01');"
					onMouseOut="javascript:Colorear('tbPadreConsultas', '#8EC135');">Consultas</a>
			</td>
		</tr>
		<tr id="tbConsultas" style="DISPLAY:none">
			<td>
				<table width="100%" border="0" cellpadding="0" cellspacing="1" bordercolor="#2d2c65">
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbConsultaModificacionesServicio" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("10/1")){ System.out.println("existe 10/1");%>			
								<a style="color:#FFFFFF" href="<%=response.encodeURL(buscarModificacionesServicio) %>" target="display" title="Consultar Modificaciones por Servicio"
									onMouseMove="javascript:Colorear('tbConsultaModificacionesServicio', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbConsultaModificacionesServicio', '#B4B4B4');">Consultar Modificaciones Por Servicio</a>
							<%}else{ System.out.println(" no existe 10/1");%>
								<a style="color: #CCC" href="#" title="Consultar Modificaciones por Servicio">Consultar Modificaciones Por Servicio</a>
							<%} %>
							</td>
						</tr>
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbConsultarDescuentosPorCliente" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("10/2")){ System.out.println(" no existe 10/2");%>	
								<a style="color:#FFFFFF" href="<%=response.encodeURL(buscarDescuentosCliente) %>" target="display" title="Consultar Descuentos por Cliente"
									onMouseMove="javascript:Colorear('tbConsultarDescuentosPorCliente', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbConsultarDescuentosPorCliente', '#B4B4B4');">Consultar Descuentos Por Cliente</a>
							<%}else{ System.out.println(" no existe 10/2");%>
								<a style="color: #CCC" href="#" title="Consultar Descuentos por Cliente">Consultar Descuentos Por Cliente</a>
							<%} %>
						</td>
					</tr>
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbConsultarDescuentosPorCarpeta" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("10/3")){ System.out.println(" no existe 10/3");%>		
								<a style="color:#FFFFFF" href="<%=response.encodeURL(buscarDescuentosCarpeta) %>" target="display" title="Consultar Descuentos por Carpeta"
									onMouseMove="javascript:Colorear('tbConsultarDescuentosPorCarpeta', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbConsultarDescuentosPorCarpeta', '#B4B4B4');">Consultar Descuentos Por Carpeta</a>
							<%}else{ System.out.println(" no existe 10/3");%>
								<a style="color: #CCC" href="#" title="Consultar Descuentos por Carpeta">Consultar Descuentos Por Carpeta</a>
							<%} %>
						</td>
					</tr>
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbConsultarDescuentosArticulosPorServicio" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("10/4")){ System.out.println(" no existe 10/4");%>
								<a style="color:#FFFFFF" href="<%=response.encodeURL(buscarDescuentosArticulo) %>" target="display" title="Consultar Descuentos de Artículos por Servicio"
									onMouseMove="javascript:Colorear('tbConsultarDescuentosArticulosPorServicio', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbConsultarDescuentosArticulosPorServicio', '#B4B4B4');">Consultar Descuentos de Art&iacute;culos por Servicio</a>
							<%}else{ System.out.println(" no existe 10/4");%>	
								<a style="color: #CCC" href="#" title="Consultar Descuentos de Artículos por Servicio">Consultar Descuentos de Art&iacute;culos por Servicio</a>
							<%} %>
						</td>
					</tr>
					<!--------------------------------------------------------------------------------------------------->
					<tr>
						<td id="tbConsultarSubsidiosArticulos" bgcolor="#00005A" class="menuhijo">
							<%if(menus.containsKey("10/5")){ System.out.println(" no existe 10/5");%>	
								<a style="color:#FFFFFF" href="<%=response.encodeURL(buscarSubsidioArticulo) %>" target="display" title="Consultar Subsidios de los Artículos"
									onMouseMove="javascript:Colorear('tbConsultarSubsidiosArticulos', '#7C7C7C');"
									onMouseOut="javascript:Colorear('tbConsultarSubsidiosArticulos', '#B4B4B4');">Consultar Subsidios de los Art&iacute;culos</a>
							<%}else{ System.out.println(" no existe 10/5");%>
								<a style="color: #CCC" href="#" title="Consultar Subsidios de los Artículos">Consultar Subsidios de los Art&iacute;culos</a>
							<%} %>
						</td>
					</tr>
					<!--------------------------------------------------------------------------------------------------->

				</table>
			</td>
		</tr>
		<!------------------------------------------- FIN CONSULTA ----------------------------------------------------->



	<!------------------------------------------- INICIO SALIR ---------------------------------------------------->
	<tr>
		<td id="tbPadreSalir" class="menupadre">
			<a style="color:#FFFFFF" href="<%=response.encodeURL(salir) %>" target="_parent" title="Salir"
				onMouseMove="javascript:Colorear('tbPadreSalir', '#7A8B01');"
				onMouseOut="javascript:Colorear('tbPadreSalir', '#8EC135');">Salir</a>
		</td>
	</tr>
	<!-------------------------------------------- FIN SALIR ------------------------------------------------------>

</table>
</body>
</html>
