<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/tld/c-rt.tld" prefix="c" %>

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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JNumerosFrecuentesAJAX.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/numerosFrec.js' ></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/controlTimeOut.js' language='JavaScript'></script>
<c:set var="cantMaxNrosFrecuentes" value="${sessionScope.cantMaxNrosFrecuentes}"></c:set>
<c:set var="maximoNumFijos" value="${sessionScope.maximoNumFijos}"></c:set>
<c:set var="maximoNumMoviles" value="${sessionScope.maximoNumMoviles}"></c:set>

<%!String colorFila = null;%>
<%
int indice = 1;
int indiceNumReg = 0;
%>
<script>
var maximoNumFijos = "<c:out value="${maximoNumFijos}"/>" ;
var maximoNumMoviles = "<c:out value="${maximoNumMoviles}"/>" ;
var cantMaxNrosFrecuentes = "<c:out value="${cantMaxNrosFrecuentes}"/>" ;

<logic:present name="arrTipos" scope="session">
<bean:define id="arrTiposNum" name="arrTipos" type="java.util.ArrayList"/>
<logic:iterate id="tipoNumFrec" name="arrTiposNum"  type="java.lang.String">
	numTipos[indice]="<bean:write name='tipoNumFrec'/>";
	indice++;
</logic:iterate>
</logic:present>

var indiceNumReg = 0;


	function fncAgregar(){
		ocultaMensajeErr();
		var numero = trim(document.getElementById('nuevoNumFrec').value);
		if(!validaNumero(document.getElementById('nuevoNumFrec'))) {
			return;
		}
		for(i=0;i<arrayNumerosFrecuentesCPU.length;i++) {
			if(arrayNumerosFrecuentesCPU[i] == numero) {
				muestraMensajeErr("El número ingresado "+numero+"  ya existe");
				return true;
			}
		}

		obtenerTipoNumero(numero);	
	}
	
	function fncAceptar(){
		document.getElementById("opcion").value = "aceptar";
	    document.forms[0].submit();
	}	
</script>
</head>

<body >
<html:form method="POST" action="/NumerosFrecuentesAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>

      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Ingreso N&uacute;meros Frecuentes
         </td>            
        </tr>
      </table>
	  <P>
	  <P>
	  
<table width="100%" border="0" >
	<tr>
	   <td class="mensajeError"><div id="mensajes"></div></td>
	</tr> 
</table>
	  
<table width="650" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<table width="100%" cellspacing="0" cellpadding="0">
			<tr>
				<td width="6%" height="25" valign="middle"><div align="right"></div></td>
        		<td width="29%" valign="middle"><span class="campoSeleccionable">Nuevo n&uacute;mero frecuente</span></td>
        		<td width="21%" valign="middle"><span class="campoSeleccionable">
          		<input type="text" name="textfield" id="nuevoNumFrec" maxlength="16" onkeypress="javascript: esnumero(this);"/>
        		</span>
        		</td>
        		<td width="44%" valign="middle">
	        		<html:button  value="AGREGAR" style="width:120px;color:black" styleId="btnAgregar" property="btnAgregar" onclick="fncAgregar();"/>
	           </div>
				</td>
      		</tr>
    	</table>
    	</td>
  </tr>
</table>
<br />

<table width="650" cellpadding="0" cellspacing="0">
  <tr>
    <td width="650">
	
	<table width="500" cellpadding="0" cellspacing="0">
                <tr>
                <logic:present name="arrTipos" scope="session">
		        <bean:define id="arrTiposNumTab" name="arrTipos" type="java.util.ArrayList"/>
                <% 
                	int cantidadTipos = arrTiposNumTab.size();
                	
                %>
                <logic:iterate indexId="countTip" id="tipoNumFrec" name="arrTiposNumTab"  type="java.lang.String">
                
                 <%
					int idTab = -1;
                    idTab = countTip.intValue()+1;
                 	if (countTip.intValue() == 0) 
                 	{
                 		%>
                 		<td class="tab_activada" id="bkg_<%=idTab%>"> 
				        <div align="center" onclick="tabActivaNF('tab_<%=idTab%>',<%=cantidadTipos%>)" id="tex_<%=idTab%>" class="tabActivo"><bean:write name="tipoNumFrec"/></div></td>
                 		<%
					} else {
						if (countTip.intValue() > 4){%></tr><tr><%}%>
                 		
                 		<td class="tab_desactivada" id="bkg_<%=idTab%>"> 
				        <div align="center" onclick="tabActivaNF('tab_<%=idTab %>',<%=cantidadTipos %>)" id="tex_<%=idTab%>" class="tabActivo"><bean:write name="tipoNumFrec"/></div></td>
                 		<%
					}
				%>
               	</logic:iterate>
		        </logic:present>
		           <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr> 
                	

               <tr>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                  <td bgcolor="#9AC453"><img src="img/tabuNo.gif" width="130" height="1" /></td>
                </tr>
    </table>	
  </td></tr>
  
  <tr><td>
   <table width="650" height="0%" border="1" cellpadding="0" cellspacing="0" bordercolor="#9AC453">
    <tr>
     <td width="646" height="100%">
		<logic:present name="numerosFrecuentesList" scope="session">
		<logic:iterate  indexId="countTipos" id="numerosFrecuentes" name="numerosFrecuentesList"  type="com.tmmas.cl.scl.commonbusinessentities.dto.NumeroFrecuenteTipoListDTO"> 
		<bean:define id="numeroFrecuenteArrTip" name="numerosFrecuentes" type="com.tmmas.cl.scl.commonbusinessentities.dto.NumeroFrecuenteDTO[]"  property="numFrecuentesIngresadosList"/>

			    <table width="646" border="0" cellpadding="0" cellspacing="0" id="tab_<%=countTipos.intValue()+1%>">
			    <form name="<bean:write name="numerosFrecuentes" property="tipo"/>">
		        <tr class="textoColumnaTabla" id="trNumFr<%=countTipos.intValue()+1%>">
		          <td width="178" align="center"><input title="Seleccionar Todos" id="checkSelAll" name="checkbox5233" type="checkbox" value="checkbox"  onclick="MarcarCS(this.form,this)"/></td>
		          <td width="153" align="center"><bean:write name="numerosFrecuentes" property="tipo"/> (Max <bean:write name="numerosFrecuentes" property="cantidadMaxTipo"/>)</td>
		          <td width="315" align="center">N&uacute;mero</td>
		        </tr>
		        <script language="JavaScript" type="text/javascript">
					maxNumTipos[<%=countTipos.intValue()%>] = '<bean:write name="numerosFrecuentes" property="cantidadMaxTipo" />';
				</script>
				
			<logic:present name="numeroFrecuenteArrTip">
			<logic:iterate indexId="countNum" id="numeroFrecuente" name="numeroFrecuenteArrTip" type="com.tmmas.cl.scl.commonbusinessentities.dto.NumeroFrecuenteDTO">
				<%
				colorFila = null;
				
				if ((countNum.intValue() % 2) == 0) {
		   					colorFila = "textoFilasTabla";
				} else {
					colorFila = "textoFilasColorTabla";
				}
				%>	
				<tr class="<%=colorFila%>" id="<bean:write name='numeroFrecuente' property='numero' />">
					<td align="center"><input name="chk<bean:write name='numeroFrecuente' property='numero' />" id="chk<bean:write name='numeroFrecuente' property='numero' />" type="checkbox" 
					    value="<bean:write name='numeroFrecuente' property='numero' />" 
					    onmouseout="delNotShow()" onmouseover="delShow()" /></td>
					<td align="center"><bean:write name="numeroFrecuente" property="tipo" /></td>
					<td align="center"><bean:write name="numeroFrecuente" property="numero" /></td>
				</tr>
				<script language="JavaScript" type="text/javascript">				
				 arrayCodTiposdeNumerosFrecuentes[<%=indiceNumReg%>] = '<bean:write name="numeroFrecuente" property="codTipo" />';
			     arraytiposdeNumerosFrecuentes[<%=indiceNumReg%>] = '<bean:write name="numeroFrecuente" property="tipo" />';
				 arrayNumerosFrecuentesCPU[<%=indiceNumReg%>] = '<bean:write name="numeroFrecuente" property="numero" />';		
				 if (arrayCodTiposdeNumerosFrecuentes[<%=indiceNumReg%>]=="RDF") {
				 	arrayMaximoNumFijos[arrayMaximoNumFijos.length]=arrayMaximoNumFijos.length+1;
				 }else{
				 	arrayMaximoNumMoviles[arrayMaximoNumMoviles.length]=arrayMaximoNumMoviles.length+1;				 
				 }
				</script>
				<%indiceNumReg++; %>
			</logic:iterate>
			</logic:present>
			
			</form>
		   </table>
			<%
		    if(indice == 1 )
			{%>	
				<script language="JavaScript" type="text/javascript">document.getElementById('tab_<%=indice%>').style.display="block";</script>
			<%
			} else {
			%> <script language="JavaScript" type="text/javascript">document.getElementById('tab_<%=indice%>').style.display="none";</script>
			<%
			}
			%>
			<%
			indice++;
			%>
		</logic:iterate>
		</logic:present>
	</td>
	</tr>
</table>

     <P>
     <P>
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr><td>&nbsp;</td></tr>    
      <tr><td>&nbsp;</td></tr>    
      <tr>
        <td width="100%" align="center">
			<html:button  value="ACEPTAR" style="width:120px;color:black" styleId="btnAceptar" property="btnAceptar" onclick="fncAceptar();"/>
        </td>
      </tr>
    </TABLE> 
</html:form>

</body>
</html:html>