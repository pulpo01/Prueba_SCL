<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>



<table width="100%" border="0">
  <tr class="textcaminohormigas">
    <td colspan="2" >Contrataci&oacute;n de Planes Adicionales/Selecci&oacute;n nivel Contrataci&oacute;n </td>
  </tr>
  <tr>
    <td ><img src="img/green_arrow.gif" width="15" height="15" /> <span class="textoTitulo">Contrataci&oacute;n Planes Adicionales</span></td>
  </tr>
  <tr>
    <td width="868" align="left">&nbsp;</td>
  </tr>
  
 <!-- (+)lista tipos de comportamiento -->
<tr><td >
  <table width="100%" border="0" align="left">
    <tr>
      <td align="left" class="textoSubTitulo">Seleccione Tipo de Comportamiento</td>
    </tr>
  <tr>
    <td align="left">
		  <table id="tablaAbonados" width="50%" border="0" cellpadding="0" cellspacing="2">
		  <tr>
			<td width="20%" class="textoColumnaTabla">Todos <html:checkbox onclick ="checkearDescheckear(this);" name="ClienteForm" property="checkTodos"  /></td>    
		    <td width="80%" class="textoColumnaTabla">Tipo Comportamiento</td>
		  </tr>
		  	<logic:present name="tiposCompList" scope="session">
			   <bean:define id="tiposComp" name="tiposCompList" scope="session"/>
			     <logic:notEmpty name="tiposComp" property="tipoComportamientoList">
			       <bean:define id="tipoComportamientoList" name="tiposComp" type="com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoDTO[]" property="tipoComportamientoList"/>
				   <logic:iterate id="tipoComportamiento" name="tipoComportamientoList"  type="com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoDTO">
			         <tr>
				        <td class="textoFilasTabla" > 
					        <div align="center">
					          <html:multibox onclick="validaCheck(this)" name="ClienteForm" property="listaTiposCom">
					        	<bean:write name="tipoComportamiento" property="tipoComportamiento"/>
					          </html:multibox> 	
					         </div>	          
				        </td>
				   		<td class="textoFilasTabla">
				   			<bean:write name="tipoComportamiento" property="tipoComportamiento"/> - <bean:write name="tipoComportamiento" property="descComportamiento"/> 
				   		</td> 
				     </tr>
			       </logic:iterate>
			     </logic:notEmpty>
		 	</logic:present>
		  </table>
 	</td>
 </tr>
</table>
</td></tr>
<tr><td>&nbsp;</td></tr>
<!-- (-)lista tipos de comportamiento -->
 
  
  <tr>
    <td>    
    <table width="100%" border="0">
      <tr>
        <td  class="textoSubTitulo">Nivel de Contrataci&oacute;n</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td width="57%">
        
        <table border="0" cellpadding="0" cellspacing="0"  width="100%">
          <tr>
            <td width="3%"  class="amarillo"><span class="style21 style1"><img src="img/black_arrow.gif" width="7" height="7" /></span></td>
            <td width="12%"  class="valorCampoSeleccionable">Cliente</td>
            <td width="85%" >
            <input type="hidden" name="porCliente" id="porCliente" value="0"/> 
            <bean:write name="ClienteVTA" property="nombre"/> 
            <bean:write name="ClienteVTA" property="apellidoPaterno"/> 
            <bean:write name="ClienteVTA" property="apellidoMaterno"/> - <bean:write name="ClienteVTA" property="idCliente"/>
            
              <logic:present name="EnableCliente" scope="session">
              <!-- INICIO VMB 18112010 INC 155400 -->
	            	<!--span onclick="desplegarPorCliente();" style="cursor:pointer;" class="verde">Contratar Planes Adicionales nivel Cliente </span-->
            	<span name="btnContratPACliente"  
            			  id="btnContratPACliente"
            			  onclick="contrataPlanesObligatorios=false;desplegarPorCliente();" style="cursor:pointer;" class="verde">Contratar Planes Adicionales nivel Cliente </span>
            	<!-- FIN VMB 18112010 INC 155400 -->
              </logic:present>
            
            </td>
          </tr>
          <tr>
            <td  class="amarillo">&nbsp;</td>
            <td  class="valorCampoSeleccionable">&nbsp;</td>
            <td >&nbsp;</td>
          </tr>
          <tr>
            <td  class="amarillo"><img src="img/black_arrow.gif" width="7" height="7" /></td>
            <td  class="valorCampoSeleccionable">L&iacute;neas</td>
            <td >&nbsp;</td>
          </tr>
        </table>
        
        </td>
        <td width="43%">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
