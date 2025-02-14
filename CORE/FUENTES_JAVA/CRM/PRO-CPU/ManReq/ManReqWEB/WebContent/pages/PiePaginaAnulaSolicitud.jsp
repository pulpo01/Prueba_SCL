<%@ taglib uri="/tags/struts-html" prefix="html"%>

<html:hidden property="condicH" />

<table width="100%" border="0">
  <tr>
    <td colspan="4" align="left" class="textoSubTitulo"><img src="img/black_arrow.gif" width="7" height="7"/>Condiciones de Atenci&oacute;n</td>
  </tr>
  
  <tr>
    <td width="33%" >
        <html:checkbox onclick ="asignaValorAControl();" name="ListaAnulaSolicitudForm" property="condicionesCK"  />
    	Sin modificar Condiciones Comerciales
	</td>
       
  </tr>
  <tr>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
    <td >&nbsp;</td>
  </tr>   
</table>
