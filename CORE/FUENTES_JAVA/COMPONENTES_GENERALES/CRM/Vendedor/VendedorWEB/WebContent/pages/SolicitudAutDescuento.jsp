<%@ taglib uri="/tags/struts-html" prefix="html" %>

<html:hidden name="SolicitudAutDescuentoForm" property="estadoSolicitud"/>
<html:hidden name="SolicitudAutDescuentoForm" property="estadoSolicitudPendiente"/>
<html:hidden name="SolicitudAutDescuentoForm" property="estadoSolicitudAutorizada"/>
<html:hidden name="SolicitudAutDescuentoForm" property="estadoSolicitudCancelada"/>
<html:hidden name="SolicitudAutDescuentoForm" property="accion"/>
<html:hidden name="SolicitudAutDescuentoForm" property="flgIniciado"/>
<table width="100%" border="0" >
  <tr>
     <td class="mensajeError"><div id="mensajes"></div></td>
  </tr> 
</table>
<table width="100%" border="0">
  <tr>
     <td colspan="5" align="left" class="textoSubTitulo">Solicitud de Aprobaci&oacute;n de Descuento </td>
  </tr>
  <tr>
    <td width="18%">&nbsp;</td>
    <td width="12%">&nbsp;</td>
    <td width="17%">&nbsp;</td>
    <td width="18%">&nbsp;</td>
    <td width="35%">&nbsp;</td>
  </tr>     
  <tr>
     <td colspan="5"><p class="style1">El monto de descuento aprobado para Ud. est&aacute; fuera de los l&iacute;mites autorizados,<br />
      si desea realizar el descuento presione &ldquo;SOLICITAR&rdquo;. </p>
      <p class="style1">Para saber si ha sido aprobada su solicitud presione el bot&oacute;n &ldquo;CONSULTAR&rdquo;.</p>
      <p class="style1">Si desea modificar los descuentos presione el bot&oacute;n &ldquo;ANTERIOR&rdquo;.<br />
      Si desea salir de la aplicaci&oacute;n presione el bot&oacute;n &ldquo;SALIR&rdquo;.</p>
     </td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><span class="style6">Autorizaci&oacute;n N&uacute;mero</span></td>
    <td>
    	<html:text  tabindex="1" name="SolicitudAutDescuentoForm" property="numAutorizacion" readonly="true"/>
    </td>
    <td> 
	    <a href="#"><img src="botones/btn_solicitar.gif"  border="0" id="solicitar"  name="solicitar" alt="Solicitar Descuento"
		onmouseover="sobreElBoton('solicitar','botones/btn_solicitar_roll.gif')" onmouseout="sobreElBoton('solicitar','botones/btn_solicitar.gif')" onclick="enviar('Solicitar');"/></a>
	</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td><span class="style6">Estado</span></td>
    <td>
       	<html:text  tabindex="2" name="SolicitudAutDescuentoForm" property="estadoSolicitudGlosa" readonly="true"/>
    </td>
    <td>
    	<a href="#"><img src="botones/btn_consultar.gif"  border="0" id="consultar"  name="consultar" alt="Consultar Estado de Solicitud"
		onmouseover="sobreElBoton('consultar','botones/btn_consultar_roll.gif')" onmouseout="sobreElBoton('consultar','botones/btn_consultar.gif')" onclick="enviar('ConsultarEstado');"/></a>
	</td>
  </tr>
  <tr>
	<td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>        
</table>