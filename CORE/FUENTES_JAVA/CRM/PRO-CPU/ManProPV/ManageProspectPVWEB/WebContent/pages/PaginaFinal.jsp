<%@ taglib uri="/tags/struts-html" prefix="html"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Telefónica Móviles .: Cambio de Plan Unificado :.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>



<script language="javascript">

function registrarOS()
  {
    document.forms[0].action="<%=request.getContextPath()%>/RegistrarAction.do";
    alert("Registrar el Plan");
    document.forms[0].submit();
  	
  }  
  
</script>

</head>
<body>
<html:form action="/CambiarPlanAction.do">
<table width="100%" border="0">
  <tr>
    <td width="25%">&nbsp;</td>
    <td width="25%">&nbsp;</td>
    <td width="50%" align="right">
	<img style="cursor: pointer;" src="botones/btn_anterior.gif" alt="Anterior" border="0" id="Anterior" 
	onmouseover="sobreElBoton('Anterior','botones/btn_anterior_roll.gif')"  onmouseout="sobreElBoton('Anterior','botones/btn_anterior.gif')"/>
	<img style="cursor: pointer;" src="botones/btn_finalizar.gif" name="Finalizar2" width="85" height="19"  border="0" id="Finalizar"  alt="Finalizar" 
	onmouseover="sobreElBoton('Finalizar','botones/btn_finalizar_roll.gif')" onmouseout="sobreElBoton('Finalizar','botones/btn_finalizar.gif')" onclick="registrarOS();"/> 
	<img style="cursor: pointer;" src="botones/btn_salir.gif" alt="Salir" border="0" id="Salir" onmouseover="sobreElBoton('Salir','botones/btn_salir_roll.gif')"  
	onmouseout="sobreElBoton('Salir','botones/btn_salir.gif')" onclick="salir();" /></td>
  </tr>
</table> 
</html:form>
</body>
</html>