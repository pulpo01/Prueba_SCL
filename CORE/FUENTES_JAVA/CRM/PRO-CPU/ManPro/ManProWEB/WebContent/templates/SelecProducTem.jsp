<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<html:html>
<head>
<script language="JavaScript" src="pages/js/efectos.js" type="text/javascript"></script>
<script language="JavaScript" src="pages/js/navegaAction.js" type="text/javascript"></script>
<script language="JavaScript" src="pages/js/popUpLc.js" type="text/javascript"></script>
<script language="JavaScript" src="js/productosLC.js" type="text/javascript"></script>
<script language="JavaScript" src="img/botones/presiona.js" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">

//(+)EV 20/03/09
var listaCodigosProdPorDefecto = new Array(); 
var listaCantidadProdPorDefecto = new Array(); 
var indice = 0;

 <logic:iterate id="prodDef" name="Abonado" property="productoContratados">  
      listaCodigosProdPorDefecto[indice]="<bean:write name='prodDef' property='codigo'/>"
      listaCantidadProdPorDefecto[indice]="<bean:write name='prodDef' property='cantidadDesplegado'/>"
      indice++;
 </logic:iterate>
//(-)EV 20/03/09


	function descripcionTipo(cod){		
		if (cod=='PFRC'){
			document.write('Frecuentes');
			return true;
		}
		if (cod=='PAFN'){
			document.write('Afines');
			return true;
		}
		if (cod=='PMOD'){
			document.write('Pasa Módulos');
			return true;
		}
		if (cod=='PADC'){
			document.write('Plan Adicional');
			return true;
		}
		if (cod=='ABNO'){
			document.write('Bono Altamira');
			return true;
		}	
		if (cod=='ALST'){
			document.write('Lista Altamira');
			return true;
		}
		if (cod=='PACK'){
			document.write('Paquete');
			return true;
		}
		
	}
	
	function descripcionTipoCobro(cod){
		if (cod=='V'){
			//document.write('Vencido');
			document.write('V');
			return true;
		}
		else if (cod=='A'){
				//document.write('Adelantado');
				document.write('A');
				return true;
		}
		else if (cod=='VA'){
				//document.write('Vencido/Adelantado');
				document.write('VA');
				return true;
		}else{
			document.write('');
			return true;
		}
		
	
	}
</script>

<link href="css/mas.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Planes Adicionales del abonado :.</title>

</head>

<body onLoad="cargarRestricciones();">



<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="PorDefecto" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="Disponibles" /></td></tr>  
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>
</body>


</html:html>