<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<table width="100%" border="0">
	<tr>
		<td class="barraarriba" width="92%">
			<logic:present name="usuario" scope="session">Usuario: <bean:write name="usuario" scope="session"/></logic:present>&nbsp;
			<logic:present name="operadora">Operadora: <bean:write name="operadora"/></logic:present>
		</td>
	</tr>
	<tr>
    	<td class="mensajeError" align="center"><div id="mensajes"></div></td>
	</tr>
	<tr height="10">
		<td width="4%" align="center">
			<span style="color:red;font-weight: bold;font-size: 11px;font-family: Verdana, Arial, Helvetica, sans-serif;">
				<logic:present name="error" scope="session">
					<bean:write name="error"/>
				</logic:present>
			</span>
			<span id="identMsg" style="color:red;font-weight: bold;font-size: 11px;font-family: Verdana, Arial, Helvetica, sans-serif;"></span>
		</td>
	</tr>
	<tr height="10">
		 <td width="4%" align="center">
		 	<table width="100%" border="0">
		  		<tr>
					<td align="left" class="textoTitulo">
						<img src="images/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>Facturaci&oacute;n Diferenciada
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td class="textcaminohormigas">Ingreso de informaci&oacute;n</td>
	</tr>
</table>
<table border ="0" width="100%">
	<tr>
		<td width="15%"><b>Cliente Contratante</b></td>
		<td width="2%" >:</td>
	  <logic:present name="clienteDT.getNomCliente()" scope="session"> 
		<td><font face="arial" size="1"><bean:write name="clienteDT.getNomCliente()" scope="session"/></font></td>
	  </logic:present>		
		<td width="10%"><b>Operacion</b></td>
		<td width="2%" >:</td>		
		<td>
		   <select name="operacion" id="operacion" onchange="limpiaMensajeError();">
              <logic:present name="listaOperacion" scope="session"> 
	           	<logic:iterate id="dto" name="listaOperacion" type="com.tmmas.scl.doblecuenta.form.FacturacionDTO" scope="session">
					<option value="<bean:write name='dto' property='codigoOperacion'/>"> <bean:write name="dto" property="descripOperacion"/> </option>
				</logic:iterate>
			 </logic:present>				
		    </select>
		</td>		
	</tr>
	<tr>
		<td width="10%"><b>Modalidad</b></td>
		<td width="2%" >:</td>		
		<td>
		 <select name="modalidad" id="modalidad" onchange="limpiaMensajeError();">
              <logic:present name="listaModalidad" scope="session"> 
	           	<logic:iterate id="dto" name="listaModalidad" type="com.tmmas.scl.doblecuenta.form.FacturacionDTO" scope="session">
					<option value="<bean:write name='dto' property='codigoModalidad'/>"> <bean:write name="dto" property="descModalidad"/> </option>
				</logic:iterate>
			 </logic:present>				
		    </select>
		</td>		
		<td width="10%"><b>Tipo Valor</b></td>
		<td width="2%" >:</td>		
		<td>
		 <select name="tipoValor" id="tipoValor" onchange="limpiaMensajeError();">
              <logic:present name="listaTipoValor" scope="session"> 
	           	<logic:iterate id="dto" name="listaTipoValor" type="com.tmmas.scl.doblecuenta.form.FacturacionDTO" scope="session">
					<option value="<bean:write name='dto' property='codigoTipoValor'/>"> <bean:write name="dto" property="descTipoValor"/> </option>
				</logic:iterate>
			 </logic:present>				
		    </select>
		</td>		
	</tr>
	<tr>
		<td width="10%"><b>Concepto Facturable</b></td>
		<td width="2%" >:</td>		
		<td>
        <select name="concepto" id="concepto" onchange="limpiaMensajeError();">
              <logic:present name="listaConcepto" scope="session"> 
	           	<logic:iterate id="dto" name="listaConcepto" type="com.tmmas.scl.doblecuenta.commonapp.dto.ConceptoDTO" scope="session">
					<option value="<bean:write name='dto' property='codConceptoOrig'/>"> <bean:write name="dto" property="descripcion"/> </option>
				</logic:iterate>
			 </logic:present>				
		    </select>
		</td>		
		<td width="10%"><b>Valor</b></td>
		<td width="2%" >:</td>		
		<td><input type="Text" name="valor" size="8" value="" id="valor" onblur="limpiaMensajeError();" onblur="extractNumber(this,2,false);" onkeyup="extractNumber(this,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);"></td>		
	</tr>
	<tr>
		<td width="10%" >&nbsp;</td>
		<td width="2%" >&nbsp;</td>		
		<td colspan="4">
	<table border ="0" width="500">
		<tr>
			<td><font face="arial" size="2"  class="textoSubTitulo"><b>Abonado</b></font></td>
			<td>&nbsp;</td>		
			<td><font face="arial" size="2"  class="textoSubTitulo"><b>Cliente Asociado</b></font></td>				
		</tr>
		<tr>
		    <td>
		 	  <select name="abonado" id="abonado" multiple size="5">
                <logic:present name="listaAbonadosCargada" scope="session"> 
	            	<logic:iterate id="dto" name="listaAbonadosCargada" type="com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO" scope="session">
					  <option value="<bean:write name='dto' property='numAbonado'/>"> 
					  <bean:write name="dto" property="numCelular"/>-
					  <bean:write name="dto" property="nomUsuario"/>
					  <bean:write name="dto" property="nomApellido1"/>
					  <bean:write name="dto" property="nomApellido2"/> </option>
				    </logic:iterate>
			    </logic:present>				
		       </select>
		     <img src="<%=request.getContextPath()%>/images/buscar.gif" border="0" alt="buscarAbon"  id="buscarAbon"  onclick="buscarAbonado();">
			</td>
			    	<td align="center">
					   <img src="<%=request.getContextPath()%>/botones/btn_asociar.gif" id="asociar" border="0" alt="asociar"  onclick="asociarDatos();">
					   <input name="asociarDat" type="hidden" id="asociarDat"  value="" />
					</td>				
		   <td>
		   
		  
			  <select name="clienteAsociado" id="clienteAsociado" size="5">
                <logic:present name="listaClienteAsociaCargada" scope="session"> 
                 <logic:iterate id="dto" name="listaClienteAsociaCargada" type="com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO" scope="session">
					  <option value="<bean:write name='dto' property='codCliente'/>"> <bean:write name="dto" property="nomCliente"/> <bean:write name="dto" property="nomApeClien1"/>
					  <bean:write name="dto" property="nomApeClien2"/>
					   </option>
				</logic:iterate>
			   </logic:present>
			   </select> 		
				<img src="<%=request.getContextPath()%>/images/buscar.gif" border="0" alt="buscarCli" id="buscarCli" onclick="buscarCliente();">
			</td>
		</tr>
		<tr>
			<td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/bot_move_previous.gif" border="0" alt="move_previousAbon"><img src="<%=request.getContextPath()%>/images/bot_move_first.gif" border="0" alt="move_firstAbon"><img src="<%=request.getContextPath()%>/images/bot_move_last.gif" border="0" alt="move_lastAbon"><img src="<%=request.getContextPath()%>/images/bot_move_next.gif" border="0" alt="move_nextAbon"></td>
			<td>&nbsp;</td>		
			<td>&nbsp;&nbsp;&nbsp;&nbsp;<img src="<%=request.getContextPath()%>/images/bot_move_previous.gif" border="0" alt="move_previousCli"><img src="<%=request.getContextPath()%>/images/bot_move_first.gif" border="0" alt="move_fistCli"><img src="<%=request.getContextPath()%>/images/bot_move_last.gif" border="0" alt="move_lastCli"><img src="<%=request.getContextPath()%>/images/bot_move_next.gif" border="0" alt="move_nextCli"></td>
			</tr>
	</table>
		
		</td>		
	</tr>
<input name="descripOperacion" type="hidden" id="descripOperacion"  value="" />	
<input name="descModalidad" type="hidden" id="descModalidad"  value="" />
<input name="descConcepto" type="hidden" id="descConcepto"  value="" />
<input name="descTipoValor" type="hidden" id="descTipoValor"  value="" />
<input name="descAbonado" type="hidden" id="descAbonado"  value="" />
<input name="descClienAsociado" type="hidden" id="descClienAsociado"  value="" />	
<input name="activarChec" type="hidden" id="activarChec"  value="" />
</table>
<br>
