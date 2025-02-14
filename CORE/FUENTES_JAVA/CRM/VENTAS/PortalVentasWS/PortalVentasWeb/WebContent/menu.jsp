<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="totalMenusActivosUsuario" value="${sessionScope.totalMenusActivosUsuario}" />
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.struts.util.*"%>
<jsp:useBean id="paramGlobal" scope="session"
	class="com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO" />
<html:html>
<!-- <html xmlns="http://www.w3.org/1999/xhtml">-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>TM-mAs - Portal Ventas</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/flashobject.js"></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JMenuAJAX.js'></script>
<style type="text/css">
      <!--
      body {
	     background-color: #f7f8f3;
      }
      .style1 {color: #003366}
      -->
   </style>
<script>
   var codVendedorSolVenta = "";
	
	
	window.onbeforeunload = ExitCheck;
	window.onunload = ExitMenu;
	   
	function ExitCheck() {  
	///control de cerrar la ventana///
	 if ( (document.getElementById("divMenu").style["display"]=="") && (totalMenusActivosUsuario > 0) ){
		 ExitCheck = false
		 return "Si decide continuar, abandonar\u00E1 la p\u00E1gina pudiendo perder los \u00FAltimos cambios";
	 }else{
	 	 ExitCheck = true
	 }
	}

	function ExitMenu() {
		if (codVendedorSolVenta != "") {
			JMenuAJAX.desbloqueaVendedor(codVendedorSolVenta, fncDummy);
		}
	}
	
	function fncDummy() {
	}
	
	window.history.forward(1);
	  
	var totalMenusActivosUsuario="<c:out value="${totalMenusActivosUsuario}"/>";
	   
   	var flgVenta = false; //true:bloquea los menues

   	function fncBloqueaVenta(){   	
   		if (flgVenta){
   			return false;
   		}else{ 	
   			flgVenta = true;
   		}	
   		
   		fncActDesacMenu(true);
   		return true;
   	}
   	
   	function fncActDesacMenu(flgDesactivar){
   		if (document.getElementById("mnInicio")!=null)
	   		document.getElementById("mnInicio").disabled=flgDesactivar;
	   	if (document.getElementById("mnAlta")!=null)
	   		document.getElementById("mnAlta").disabled=flgDesactivar;
	   	if (document.getElementById("mnSolicitud")!=null)
	   		document.getElementById("mnSolicitud").disabled=flgDesactivar;
	   	if (document.getElementById("mnConsulta")!=null)
	   		document.getElementById("mnConsulta").disabled=flgDesactivar;  
	   	if (document.getElementById("mnFormalizar")!=null)
	   		document.getElementById("mnFormalizar").disabled=flgDesactivar;
	   	if (document.getElementById("mnDocumentos")!=null)
	   		document.getElementById("mnDocumentos").disabled=flgDesactivar;
	   	if (document.getElementById("mnConsultaCargosInst")!=null)
	   		document.getElementById("mnConsultaCargosInst").disabled=flgDesactivar;    
	   	/*P-CSR-11002 JLGN 06-06-2011
	   	if (document.getElementById("mnEvaluacion")!=null)
	   		document.getElementById("mnEvaluacion").disabled=flgDesactivar;    
	   	if (document.getElementById("mnMisPendientesEval")!=null)
	   		document.getElementById("mnMisPendientesEval").disabled=flgDesactivar;*/  	   		 	
	   	if (document.getElementById("mnDesbloqueo")!=null)
	   		document.getElementById("mnDesbloqueo").disabled=flgDesactivar;
	   	/* P-CSR-11002 JLGN 06-06-2011*/
	   	if (document.getElementById("mnMisPendientesInst")!=null)
	   		document.getElementById("mnMisPendientesInst").disabled=flgDesactivar;
	   	if (document.getElementById("mnCierreSesion")!=null)
	   		document.getElementById("mnCierreSesion").disabled=flgDesactivar;  	   			
   		if (document.getElementById("mnAsocDocumentos") != null)
   			document.getElementById("mnAsocDocumentos").disabled = flgDesactivar; 
   		if (document.getElementById("mnPasilloLDI") != null)
   			document.getElementById("mnPasilloLDI").disabled = flgDesactivar;
		if (document.getElementById("mnOverride") != null)
   			document.getElementById("mnOverride").disabled = flgDesactivar;
		if (document.getElementById("mnScoring") != null)
   			document.getElementById("mnScoring").disabled = flgDesactivar;
		if (document.getElementById("mnReportesScoring") != null)
   			document.getElementById("mnReportesScoring").disabled = flgDesactivar;
   		
   		if (!flgDesactivar) flgVenta = false;
   	}
   	
   	function fncValidaMenu(){
   		var retorno= false;
   		if (!flgVenta) retorno= true;
   		else					retorno= false;
   		
   		return retorno;
   	}
   	
   	function fncOcultaMenu(){
		document.getElementById("divMenu").style["display"] = "none";
   	}
   
   	function fncCargaVendedorSolVenta(codVendedor){
	   	codVendedorSolVenta  = codVendedor;
   	}
   
   </script>
</head>
<body onload="history.go(+1);">
<html:form action="InicioAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<bean:define id="menuInicio" name="menuInicioDTO" scope="session"
		type="com.tmmas.cl.scl.portalventas.web.dto.MenuInicioDTO" />
	<bean:define id="codMenuAltaCliente" name="InicioForm" property="codMenuAltaCliente"
		type="java.lang.String" />
	<bean:define id="codMenuSolicitudVenta" name="InicioForm" property="codMenuSolicitudVenta"
		type="java.lang.String" />
	<bean:define id="codMenuConsultaVenta" name="InicioForm" property="codMenuConsultaVenta"
		type="java.lang.String" />
	<bean:define id="codMenuFormalizarVenta" name="InicioForm" property="codMenuFormalizarVenta"
		type="java.lang.String" />
	<bean:define id="codMenuAsociacionDocumentos" name="InicioForm"
		property="codMenuAsociacionDocumentos" type="java.lang.String" />
	<bean:define id="codMenuImpresionDocumentos" name="InicioForm"
		property="codMenuImpresionDocumentos" type="java.lang.String" />
	<bean:define id="codMenuCargosInstalacion" name="InicioForm" property="codMenuCargosInstalacion"
		type="java.lang.String" />
	<bean:define id="codMenuEvaluacionSolicitud" name="InicioForm"
		property="codMenuEvaluacionSolicitud" type="java.lang.String" />
	<bean:define id="codMisPendientesCredito" name="InicioForm" property="codMisPendientesCredito"
		type="java.lang.String" />
	<bean:define id="codMenuDesbloqueoTM" name="InicioForm" property="codMenuDesbloqueoTM"
		type="java.lang.String" />
	<bean:define id="codMenuMisPendientes" name="InicioForm" property="codMenuMisPendientes"
		type="java.lang.String" />
	<bean:define id="codMenuPasilloLDI" name="InicioForm" property="codMenuPasilloLDI"
		type="java.lang.String" />
	<bean:define id="codMenuOverride" name="InicioForm" property="codMenuOverride"
		type="java.lang.String" />
	<bean:define id="codMenuScoring" name="InicioForm" property="codMenuScoring"
		type="java.lang.String" />
	<bean:define id="codMenuReporteScoring" name="InicioForm" property="codMenuReporteScoring"
		type="java.lang.String" />
		
	<html:errors bundle="errors" />
	<table width="98%" align="center" bgcolor="#FFFFFF">
		<tr>
			<td width="100%" valign="top">
			<table width="100%" border="0" cellspacing="0">
				<%
			   String version = paramGlobal!=null && paramGlobal.getVersionSistema()!=null ?paramGlobal.getVersionSistema():"";
			   String usuario = paramGlobal!=null && paramGlobal.getCodUsuario()!=null ?paramGlobal.getCodUsuario():"";  
			   String operadora = paramGlobal!=null && paramGlobal.getCodOperadora()!=null ?paramGlobal.getCodOperadora():"";  
			   %>
				<tr>
					<td colspan="2" valign="bottom"><span class="style1"> <!-- permite cargar un swf externo atraves de un js -->
					</span>
					<div class="style1" id="flashcontent"></div>
					<span class="style1"> <script type="text/javascript">
                       var fo = new FlashObject("img/bars.swf", "menu", "950", "125", "7", "#ffffff");
	                   fo.addParam("scale", "exactfit");
	                   fo.addParam("menu", "false");
	                   fo.write("flashcontent");
	                   document.onkeydown = function(){
                          if(window.event && window.event.keyCode == 8)
	                      {
	                         window.event.keyCode = 505;
                          }
                       }
	                </script> <img src="img/px_cafe.jpg" width="1" alt=" " height="2" /></span></td>
				</tr>
				<tr>
					<td height="14" bgcolor="#78B454" class="texto_intro_blanco"><img src="img/px_trans.jpg"
						alt="  " width="1" height="1" /></td>
					<!-- <td height="14" bgcolor="#78B454" class="textobarraverde"><strong>Usuario:</strong> <%=usuario%><strong>
					Operadora:</strong> <%=operadora%> <strong>Versi&oacute;n:</strong><%=version%></td> -->
					<td height="14" bgcolor="#78B454" class="textobarraverde"><strong>Usuario:</strong> <%=usuario%><strong>
					Versi&oacute;n:</strong><%=version%></td>
				</tr>
				<tr>
					<td width="17%" valign="top" bgcolor="#EBE9DC"><img src="img/px_trans.jpg" alt="  "
						width="1" height="4" /><br />
					<div id="divMenu">
					<table width="100%" border="0" cellpadding="1" cellspacing="2">
						<!-- (+) AREA VENTAS -->
						<logic:greaterThan name="menuInicio" property="totalAreaVentas" value="0">
							<tr>
								<td class="titformularios" colspan="2">&nbsp;Area de Ventas</td>
							</tr>
							<tr>
								<td width="15%">&nbsp;</td>
								<td width="85%">
								<table cellpadding="3" cellspacing="4">
									<!-- Inicio Inc.179734 10-02-2012 JLGN
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaVentas"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuAltaCliente %>">
											<tr>
												<td><a class="linkmenu" href="BuscaCuentaAction.do?opcion=inicio"
													target="contenido" onclick="return fncValidaMenu();" id="mnAlta">Alta de Cliente</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
									Fin Inc.179734 10-02-2012 JLGN -->
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaVentas"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuSolicitudVenta %>">
											<tr>
												<!--  <td><a class="linkmenu" href="DatosVentaAction.do?opcion=inicio" P-CSR-11002 JLGN 16-05-2011-->
												<td><a class="linkmenu" href="DatosVentaAction.do?opcion=inicio2"
													 target="contenido" onclick="return fncBloqueaVenta();" id="mnSolicitud">Solicitud
												de Venta</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaVentas"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuConsultaVenta %>">
											<tr>
												<td><a class="linkmenu" href="ConsultaVentasVendedorAction.do?opcion=inicioVenta"
													target="contenido" onclick="return fncValidaMenu();" id="mnConsulta">Consulta
												Ventas</a></td>
											</tr>
										</logic:equal>
										<logic:equal name="menuUsuario" value="<%= codMenuOverride %>">
											<tr>
												<td>
													<a class="linkmenu" href="ConsultaVentasVendedorAction.do?opcion=inicioOverrideSolicitud"
													target="contenido" onclick="" id="mnOverride">Override Solicitud</a>
												</td>
											</tr>
										</logic:equal>
										<logic:equal name="menuUsuario" value="<%= codMenuScoring %>">
											<tr>
												<td>
													<a class="linkmenu" href="GestionScoringAction.do?opcion=inicio" target="contenido" onclick="" id="mnScoring">Gesti&oacute;n Scoring</a>
												</td>
											</tr>
										</logic:equal>
										<logic:equal name="menuUsuario" value="<%= codMenuReporteScoring %>">
											<tr>
												<td>
													<a class="linkmenu" href="GestionScoringAction.do?opcion=inicioReportes" target="contenido" onclick="" id="mnReportesScoring">Reportes Scoring</a>
												</td>
											</tr>
										</logic:equal>
									</logic:iterate>
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaVentas"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuFormalizarVenta %>">
											<tr>
												<td><a class="linkmenu"
													href="ConsultaVentasVendedorAction.do?opcion=inicioPreVenta" target="contenido"
													onclick="return fncValidaMenu();" id="mnFormalizar">Formalizar Venta</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaVentas"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuAsociacionDocumentos %>">
											<tr>
												<td><a class="linkmenu"
													href="ConsultaVentasVendedorAction.do?opcion=inicioAsociacionDocumentos" target="contenido"
													onclick="return fncValidaMenu();" id="mnAsocDocumentos">Asociaci&oacute;n de Documentos</a>
												</td>
											</tr>
										</logic:equal>
									</logic:iterate>
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaVentas"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuImpresionDocumentos %>">
											<tr>
												<td><a class="linkmenu"
													href="ConsultaVentasVendedorAction.do?opcion=inicioDocumentos" target="contenido"
													onclick="return fncValidaMenu();" id="mnDocumentos">Impresi&oacute;n de Documentos</a>
												</td>
											</tr>
										</logic:equal>
									</logic:iterate>
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaVentas"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuCargosInstalacion %>">
											<tr>
												<td><a class="linkmenu"
													href="ConsultaVentasVendedorAction.do?opcion=inicioCargosInst" target="contenido"
													onclick="return fncValidaMenu();" id="mnConsultaCargosInst">Gesti&oacute;n
												Instalaci&oacute;n</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
								</table>
								</td>
							</tr>
						</logic:greaterThan>
						<!-- (-) AREA VENTAS -->
						<!-- (+) AREA CREDITO -->
						<!-- P-CSR-11002 JLGN 25-05-2011 
						<logic:greaterThan name="menuInicio" property="totalAreaCredito" value="0">
							<tr>
								<td class="titformularios" colspan="2">&nbsp;Area de Cr&eacute;dito</td>
							</tr>
							<tr>
								<td width="15%">&nbsp;</td>
								<td width="85%">
								<table cellpadding="3" cellspacing="4">
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaCredito"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuEvaluacionSolicitud %>">
											<tr>
												<td><a class="linkmenu"
													href="ConsultaVentasVendedorAction.do?opcion=inicioEvaluacionSolicitud"
													target="contenido" onclick="return fncValidaMenu();" id="mnEvaluacion">Evaluaci&oacute;n
												Solicitud</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaCredito"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMisPendientesCredito %>">
											<tr>
												<td><a class="linkmenu"
													href="ConsultaVentasVendedorAction.do?opcion=inicioMisPendientesEval"
													target="contenido" onclick="return fncValidaMenu();" id="mnMisPendientesEval">Mis
												Pendientes</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
								</table>
								</td>
							</tr>
						</logic:greaterThan>
						-->
						<!-- (-) AREA CREDITO -->
						<!-- (+) AREA ACTIVACIONES-->
						<logic:greaterThan name="menuInicio" property="totalAreaActivaciones" value="0">
							<tr>
								<td class="titformularios" colspan="2">&nbsp;Area de Activaciones</td>
							</tr>
							<tr>
								<td width="15%">&nbsp;</td>
								<td width="85%">
								<table cellpadding="3" cellspacing="4">
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaActivaciones"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuDesbloqueoTM %>">
											<tr>
												<td><a class="linkmenu"
													href="ConsultaVentasVendedorAction.do?opcion=inicioDesbloqueo" target="contenido"
													onclick="return fncValidaMenu();" id="mnDesbloqueo">Desbloqueo</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
								</table>
								</td>
							</tr>
						</logic:greaterThan>
						<!-- (-) AREA ACTIVACIONES -->
						<!-- (+) AREA INSTALACION-->
						<!-- Inicio P-CSR-11002 JLGN 25-05-2011 -->
						<logic:greaterThan name="menuInicio" property="totalAreaInstalacion" value="0">
							<tr>
								<td class="titformularios" colspan="2">&nbsp;Area de Instalaci&oacute;n</td>
							</tr>
							<tr>
								<td width="15%">&nbsp;</td>
								<td width="85%">
								<table cellpadding="3" cellspacing="4">
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaInstalacion"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuMisPendientes %>">
											<tr>
												<td><a class="linkmenu"
													href="ConsultaVentasVendedorAction.do?opcion=inicioMisPendientesInst"
													target="contenido" onclick="return fncValidaMenu();" id="mnMisPendientesInst">Mis
												Pendientes</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
								</table>
								</td>
							</tr>
						</logic:greaterThan>
						<!-- Fin  P-CSR-11002 JLGN 25-05-2011 -->
						<!-- (-) AREA INSTALACION -->
						<!-- (+) AREA LDI -->
							<logic:greaterThan name="menuInicio" property="totalAreaLDI" value="0">
							<tr>
								<td class="titformularios" colspan="2">&nbsp;Area LDI</td>
							</tr>
							<tr>
								<td width="15%">&nbsp;</td>
								<td width="85%">
								<table cellpadding="3" cellspacing="4">
									<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaLDI"
										type="java.lang.String">
										<logic:equal name="menuUsuario" value="<%= codMenuPasilloLDI %>">
											<tr>
												<td><a class="linkmenu" href="ClienteCarrierPasilloLDIAction.do?opcion=inicio"
													target="contenido" onclick="return fncValidaMenu();" id="mnPasilloLDI">Pasillo LDI</a></td>
											</tr>
										</logic:equal>
									</logic:iterate>
								</table>
								</td>
							</tr>
						</logic:greaterThan>
						
						<!-- (-) AREA LDI -->
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td colspan="2"><a class="linkmenu" href="InicioAction.do?opcion=cierre"
								onclick="return fncValidaMenu();" id="mnCierreSesion">&nbsp;Cierre de Sesi&oacute;n</a></td>
						</tr>
				
					</table>
					</div>
					<p class="titmenucafe">&nbsp;</p>
					</td>
					<td width="85%"><iframe src="iframe_portada.jsp" id="contenido" name="contenido"
						width="100%" height="710" frameborder="0" style="overflow-x:false" scrolling="auto">
					</iframe></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td class="footer">Optimizado para resoluci&oacute;n de 1024x768 / IE 5.0 + / Copyright
			&copy; 2010: TM-mAs.</td>
		</tr>
	</table>
</html:form>
</body>
</html:html>
