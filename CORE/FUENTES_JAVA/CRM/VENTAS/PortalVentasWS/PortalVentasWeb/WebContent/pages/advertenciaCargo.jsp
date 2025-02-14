
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script>
 	window.history.forward(1);
</script>
</head>

    <body onload="history.go(+1);" onkeydown="validarTeclas();">
    	<center>

		      <table width="100%">
		        <tr>
		         <td class="amarillo" >
			        <h2>
		              <IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="center">
		              Mensaje de advertencia para autorizaci&oacute;n de descuento
		              &nbsp;
		            </h2>
		         </td>   
		        </tr>
		      </table>
		      <p><p><p>
		      
		      <table width="80%">
		        <tr>
		          <td class="verde" align="center" style="font-size:10pt">
			          	 El valor del descuento ingresado&nbsp; no est&aacute;  autorizado.<br>
			          	 Debe realizar una solicitud a su supervisor, quien <br>
			          	 deber&aacute; autorizarlos antes de que el sistema acepte <br>
			          	 este monto.<br>   
		          </td>   
		        </tr>
		      </table>
			  <p><p><p>	      
		      
		      <table> 
		        <tr>
			      <td align="center">
						<input type="button" name="btnAceptar" value="ACEPTAR" onclick="Javascript:window.close();" style="width:120px;color:black">			      
				  </td>
		        </tr>
		      </table> 

    	 </center>
    </body>
</html>