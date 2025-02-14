<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<html>
<head>
	<base target="_self"></base>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Telefónica Móviles</title>
	<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />

	<script>
		var filasEncabezado=2;
		var arrayContactos = new Array();
		var filaAModificar = 0;	

		// Si es ingresa en modo de mantenimiento, se genera la matriz y se inserta aqui.
		<%= session.getAttribute("matrizContactos")%>

		// Flag que contiene el valor si ha ingresado en modo mantenimiento
		var flgModificar = "<%= session.getAttribute("flgMantimiento")%>";

		// Codigo de servicio para la creacion de contactos nuevos
		var codServicio = "<%= session.getAttribute("codServicio")%>";
				
		var urlComponenteDirecciones = "<%= session.getAttribute("url.componente.direcciones")%>";

		var icgLargoNumTelefono = "<%= session.getAttribute("icgLargoNumTelefono")%>";

		// Codigos de direccion retornados por el componente para elegir un domicilio
		var arrayCodigos = new Array();
	</script>
	
	<script type='text/javascript' src='<%=request.getContextPath()%>/js/apiContactos.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/js/contactos911.js'></script>
</head>

<body onload="inicio()">

	<table cellpadding=2 cellspacing=2 width="900">
	<tr height="50">
		<td colspan=8>
			<table width="100%">
			<tr>
         		<td class="amarillo" >
	       		<h2><IMG src="/ServSupl911CorreoFaxWEB/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
				Contactos
    			</td>            
	        </tr>
    	  </table>
		</td>
	</tr>

	<html:form action="/Contactos911Action" method="POST">
	<input type=hidden name="contactosTabla" id="contactosTabla">
	<html:hidden property="opcion" value="inicio"/>

	<tr>
		<TD align=left width="80">Nombre Contacto (*)</td>
		<td class="textointroblanco"><input type=text name=nombre maxlength=50 style="text-transform: uppercase;" size=50></td>
		<td width="10">&nbsp;</td>
		<TD align=left width="80">Primer Apellido Contacto (*)</td>
		<td class="textointroblanco"><input type=text name=apellido maxlength=20 style="text-transform: uppercase;" size=25></td>
		<TD width=10>&nbsp;</TD>      
		<TD align=left width="80">Segundo Apellido Contacto</td>
		<td class="textointroblanco"><input type=text name=apellido2 maxlength=20 style="text-transform: uppercase;" size=25></td>		
	</tr>
	<tr>
		<td align="left" ><a href="#" onclick="fncIngresarDireccionPersonal();">Direcci&oacute;n Personal</a> (*)</td>
		<td class="textointroblanco" colspan=7><input type=text name=direccion size=150 readonly="readonly"></td>
	</tr>	
	<tr>
		<td align="left">Telefono Contacto (*)</td>
		<td class="textointroblanco"><input type=text name=telefono maxlength="<%= session.getAttribute("icgLargoNumTelefono")%>" style="text-transform: uppercase;" ></td>
		<td align="left">Parentesco</td>
		<td class="textointroblanco"  colspan=5>
		<select name="parentesco" style="text-transform: uppercase;">
			<option value="">- Seleccione -</option>
			
			<logic:iterate id="parentesco" name="listaParentesco"  type="com.tmmas.cl.scl.ss911correofax.dto.CodigosDTO">
				<option value='<bean:write name="parentesco" property="codigoValor"/>'><bean:write name="parentesco" property="descripcionValor"/></option>
			</logic:iterate>
		</select>
		
		<td align="left"></td>
		<!--  <input type=text name=parentesco style="text-transform: uppercase;" > -->
		
		
		</td>
	</tr>		
	<tr>		
		<td align="left">Placa del vehiculo (*)</td>
		<td class="textointroblanco"><input type=text name=placa maxlength=10 style="text-transform: uppercase;" ></td>
		<td align="left">Color del vehiculo</td>
		<td class="textointroblanco"><input type=text name=color maxlength=30 style="text-transform: uppercase;" ></td>
		<td align="left">Año del vehiculo (*)</td>
		<td class="textointroblanco"  colspan=3><input type=text name=anio maxlength=4></td>

	</tr>
	
	<tr height="50">
		<td colspan=8>
			<input type=button value="AGREGAR" onclick="agregarContacto()" id="btnAgregar">
			<input type=button value="MODIFICAR" onclick="modificarContacto()" id="btnModificar" disabled=true>
		</td>
	</tr>
	</html:form>	
	</table>

	<hr>
	
	<table width="900" id="listaContactos">
	<tr align="center" class="textoColumnaTabla">
		
		<td width="150">Nombre</td>
		<td width="150">Telefono</td>
		<td width="150">Placa</td>
		<td width="150">&nbsp;</td>		
	</tr>
	</table>	

	<table width="900">
	<tr>
		<td colspan=4 align="right">
			<input type=button value="CANCELAR" onclick="cancelar()" id="btnCancelar"  style="width:120px;color:black" >
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type=button value="ACEPTAR" onclick="aceptar()" id="btnAceptar"  style="width:120px;color:black" >
		</td>
	</tr>
	</table>	
	
</body>
</html>