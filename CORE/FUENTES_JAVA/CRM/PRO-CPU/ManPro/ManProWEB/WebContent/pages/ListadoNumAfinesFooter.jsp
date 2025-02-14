<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script language="javascript">
function eliminarFormulario(){
 
 document.getElementById("eliminar").value="E";
 enviarFormulario2();
}
function enviarFormulario2()
  {
    document.forms[0].action="<%=request.getContextPath()%>/ClienElimAfinesAction.do";
    document.forms[0].submit();
  }
  
</script> 
</head>
<body>
  <tr>
      <td colspan="6"><table width="100%" border="0">
        <tr>
          <td width="6%">&nbsp;</td>
          <td width="13%"><strong><img src="img/botones/btn_eliminar.gif" name="eliminar" id="eliminar" onclick="eliminarFormulario();" width="85" height="19" id="eliminar" 	onmouseover="sobreElBoton('eliminar','img/botones/btn_eliminar_roll.gif')" onmouseout="sobreElBoton('eliminar','img/botones/btn_eliminar.gif')" /></strong></td>
          <input type="hidden"  name="eliminar" id="eliminar" value="0" />
          <td width="63%"><div align="right">
          <img 
          	src="img/botones/btn_aceptar.gif"  
          	name="Aceptar" 
          	width="85" 
          	height="19"  
          	border="0" id="Aceptar" 
          	alt="siguiente"
          	onclick="guardarAProducto();"
			onmouseover="sobreElBoton('Aceptar','img/botones/btn_aceptar_roll.gif')" 
			onmouseout="sobreElBoton('Aceptar','img/botones/btn_aceptar.gif')" 
		 />
		 <input 
		 	name="cancelarAfines" 
		 	type="hidden" 
		 	id="cancelarAfines"  
		 	value=""
		 />
		 	
 		</td>
           <td width="18%" align="right">&nbsp;</td></tr>
      </table></td>
    </tr>
  </table>
  <table width="100%" border="0">
  <tr>
    <td width="25%">&nbsp;</td>
    <td width="25%">&nbsp;</td>
    <td width="50%" align="right">&nbsp;</td>
  </tr>
</table>
</body>
</html>