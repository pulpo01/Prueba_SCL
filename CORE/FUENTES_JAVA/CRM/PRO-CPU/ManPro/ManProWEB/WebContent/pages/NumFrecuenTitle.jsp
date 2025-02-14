<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

  <table  width="100%" border="0">
    <tr class="textcaminohormigas">
      <td width="882" colspan="2" >Contrataci&oacute;n Planes Adicionales/Personalizaci&oacute;n/Ingresar N&uacute;meros Frecuentes </td>
    </tr> 
    
  <logic:present name="productoContratadoFrecSess" scope="session">
  <bean:define id="productoContratado" name="productoContratadoFrecSess" type="com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoContratadoFrecDTO"/>
  <tr>
    <td colspan= "2" ><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/> <span class="textoTitulo">Personalizaci&oacute;n de N&uacute;meros Frecuentes
    </span></td>
  </tr>
  
  <tr>
    <td><table width="98%" border="0">
      <tr>
        <td>&nbsp;</td>
            <td class="campoInformativo">Cliente</td>
            <td >:</td>
            <td class="valorCampoInformativo" >
	            <bean:write name="ClienteVTA" property="nombre"/> 
	            <bean:write name="ClienteVTA" property="apellidoPaterno"/> 
	            <bean:write name="ClienteVTA" property="apellidoMaterno"/> - <bean:write name="ClienteVTA" property="idCliente"/>
            </td>
			<script>
				var idAbo = "<bean:write name="Abonado" property="idAbonado"/>";
				var nomAbo = "<bean:write name="Abonado" property="nombreAbonado"/>";
				muestraAbonado(idAbo,nomAbo);
			</script>
            </td>
      </tr>
      
      <tr>
        <td width="2%">&nbsp;</td>
        <td width="12%" class="campoInformativo">C&oacute;digo  </td>
        <td width="1%" >:</td>
        <td width="33%" class="valorCampoInformativo"><bean:write name="productoContratado" property="codigo"/></td>
        <%/*
		<td width="18%" class="campoInformativo">Correlativo</td>
        <td width="1%" >:</td>
        <td width="33%" class="valorCampoInformativo"><bean:write name="productoContratado" property="correlativo"/></td>
		*/%>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td class="campoInformativo">Nombre</td>
        <td >:</td>
        <td class="valorCampoInformativo"><bean:write name="productoContratado" property="descripcion"/> </td>
        <td class="campoInformativo">M&aacute;x. n&uacute;meros permitidos </td>
        <td >:</td>
        <td class="valorCampoInformativo"><bean:write name="productoContratado" property="numFrecuentesPermitidos"/></td>
      </tr>
    </table>
   </logic:present>
  </table>
  <table width="100%" border="0" >
  <tr>
     <td class="mensajeError"><div id="mensajes"></div></td>
  </tr> 
  </table>