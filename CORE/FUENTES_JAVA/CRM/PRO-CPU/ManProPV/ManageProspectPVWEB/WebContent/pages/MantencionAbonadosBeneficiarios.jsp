<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Telefónica Móviles .: Mantención de Abonados Beneficiarios :.</title>
<link href="/abonadoBeneficiario/css/mas.css" rel="stylesheet" type="text/css" />
<script language="javaScript" src="abonadoBeneficiario/botones/presiona.js" type="text/javascript"></script>
<script language="javascript" src="abonadoBeneficiario/js/toolsgrilla.js" type="text/javascript"></script>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style2 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; text-decoration: none; color: #666666; text-align: left; vertical-align: top; padding-left: 2px; border: 1px none #CCCCCC; background-color: #FFFFFF;}
-->
</style>
<script type="text/JavaScript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function obtieneAboBenPorNumCelularRecarga()
{
	try
	{
		JOrdServAboBenef.obtieneAboBenPorNumCelularRecarga(getAbonadosLista);
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En obtieneAboBenPorNumCelularRecarga()");
	}
}

function obtieneAbonadosBeneficiariosPorNumCelular()
{
	try
	{
		document.getElementById("numCelularAbonado").disabled="disabled";
		var numCelular=document.getElementById("numCelularAbonado").value;
		document.getElementById("numCelularAbonado").value="";
		var listaCelular =new Array();
		listaCelulares=eval("document.ManAboBeneForm.listaEncolarNumCelular");
		var isValid=2;
		var itemCel=0;
		isValid=validaNumeroLetraVacio(numCelular);
		
		if (isValid==2){
		     if (listaCelulares!=null){  
			     if (listaCelulares.value==null){
					for(i=0;i<listaCelulares.length;i++){
						if (listaCelulares[i].value==numCelular){
							document.getElementById("mensajes").innerHTML = "Número celular: "+numCelular+", se encuentra en Lista.";
							isValid=5;
							break;
						}
					}
			     }
			     else{
			     	if (listaCelulares.value==numCelular){
						document.getElementById("mensajes").innerHTML = "Número celular: "+numCelular+", se encuentra en Lista.";
						isValid=5;
					}
			     }
		     }
		}	 
		if (isValid==0){
			document.getElementById("mensajes").innerHTML = "Ingrese número celular";
		}
		if (isValid==1){
		 	isValid=false;
		 	document.getElementById("mensajes").innerHTML = "Ingrese sólo números";
		}
		if (isValid==2){
		    document.getElementById("mensajes").innerHTML = "";
			JOrdServAboBenef.obtieneAbonadosBeneficiariosPorNumCelular(numCelular,getAbonadosLista);
		}
		document.getElementById("numCelularAbonado").disabled="";	
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En obtieneAbonadosBeneficiariosPorNumCelular()");
	}
}

function getAbonadosLista(data)
{
	try
	{
		var abonBenef=new Array();
		var listaAbonadosIterate=new Array();
		abonBenef=data;  
   		var tablaBody=document.getElementById("listAbonadosBenf");
   		var fila;
   		var columna; 
   		var isExistNumeroCel=true;
   		var items = eval("document.ManAboBeneForm.listaNumAbonados");
   		listaAbonadosIterate=eval("document.ManAboBeneForm.listaNumAbonados");
   		var numLista;
   		numLista= items==null?0:items.length!=null?items.length:1;
   		if (abonBenef+"" == "undefined" || abonBenef+"" == "null" || abonBenef+"" == "") {
			isExistNumeroCel=false;
		}
   		
	   	if (isExistNumeroCel){	
	   		for(i=0;i<abonBenef.length;i++)	 {
	   			numLista++;
	   	 	    
	   	 		colorFila=(i%2==0)?"#FFFFFF":"#F8F8F3";
	     		fila=crearFila();   
	     		fila.bgColor=colorFila;  
			    columna=crearColumna();
			    columna.bgColor=colorFila;
			    columna.align="center";
			    columna.innerHTML=numLista;
			    agregarColumnaAFila(fila,columna);     
			    
			    columna=crearColumna();
			    columna.bgColor=colorFila;
			    columna.align="center";
			    agregarColumnaAFila(fila,columna);
			    columna.innerHTML=abonBenef[i]['numCelular'];
			    
			    columna=crearColumna();
			    columna.bgColor=colorFila;
			    columna.align="left";
			    agregarColumnaAFila(fila,columna);
			    columna.innerHTML=abonBenef[i]['nombre'];
			    
			    columna=crearColumna();
			    columna.bgColor=colorFila;
			    columna.align="center";
			    agregarColumnaAFila(fila,columna);
			    columna.innerHTML=abonBenef[i]['numAbonado'];
			    
			    columna=crearColumna();
			    columna.bgColor=colorFila;
			    columna.align="center";
			    agregarColumnaAFila(fila,columna);
			    var g='<input type="checkbox" name="listaNumAbonados" value="'+abonBenef[i]['numAbonado']+'">';
			    g=g+'<input type="hidden" name="listaEncolar" value="'+abonBenef[i]['numAbonado']+'"/>';
			    g=g+'<input type="hidden" name="listaEncolarNombre" value="'+abonBenef[i]['nombre']+'"/>';
			    g=g+'<input type="hidden" name="listaEncolarNumCelular" value="'+abonBenef[i]['numCelular']+'"/>';
			    g=g+'<input type="hidden" name="listaEncolarTipoComportamiento" value="'+abonBenef[i]['tipo_Comportamiento']+'"/>';
			    
			    g=g+'<input type="hidden" name="listaEncolarFecInicioVigencia" value="'+abonBenef[i]['fec_Inicio_Vigencia']+'"/>';
			    
			    g=g+'<input type="hidden" name="listaEncolarFecTerminoVigencia" value="'+abonBenef[i]['fec_Termino_Vigencia']+'"/>';
			    columna.innerHTML=g;
			    agregarFilaATabla(tablaBody,fila); 
			    if (abonBenef.length==0){
	   				document.getElementById("mensajes").innerHTML = "Número celular no asociado a ningún abonado";
	   			}//fin if
		     } //fin for  
	   	}//fin if
	   	else{
	     	document.getElementById("mensajes").innerHTML = "Número celular no asociado a ningún abonado";
	   	}
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En getAbonadosLista()");
	}

}
	
	function eliminarSeleccionados(){
		var listaAbonadosIterate=new Array();
		var listaAbonadosIterateEliminados=new Array();
		var n =new Array();
		listaAbonadosIterate=eval("document.ManAboBeneForm.listaNumAbonados");
		listaAbonadosIterateEliminados=eval("document.ManAboBeneForm.listaNumAbonadosEliminados");
		
		var tablaBody=document.getElementById("listAbonadosBenf");
		var isNull=listaAbonadosIterate;
		var isNullValue;
		var cont=0;
		if (isNull!=null){
		    document.getElementById("mensajes").innerHTML = "";
			isNullValue=listaAbonadosIterate.value;
			if (isNullValue==null){
		        for(i=listaAbonadosIterate.length-1;i>-1;i--)	 {
				   		if (listaAbonadosIterate[i].checked){
				   				listaAbonadosIterate[i].checked=false;
				   				quitarFilaDeTabla(tablaBody,i); 
		   		   	    }
				 }
				
				 var tablaBody=document.getElementById("listAbonadosBenf"); 
				 var fila;
				 var columna =new Array(); 
				 
				 for(i=0;i<listaAbonadosIterate.length;i++)	 {
				 	fila=tablaBody.getElementsByTagName("tr").item(i);
   					columna=fila.getElementsByTagName("td");
   					
   					for(j=0;j<columna.length;j++){
   					     columna[0].innerHTML=i+1;
   					}
   				}
				 
			}
			else{
				if (listaAbonadosIterate.checked){
		   		    	quitarFilaDeTabla(tablaBody,0); 
		   		    
		   		    } 
			}
			
				 
		}
		else{
			document.getElementById("mensajes").innerHTML = "No existen Registros a eliminar";
		}
	}
	
	function checkout(){
		var listaAbonadosIterate=new Array();
		try
		{
			listaAbonadosIterate=eval("document.ManAboBeneForm.listaNumAbonados");
			var check=("document.selAll");
			var isNull=listaAbonadosIterate;
			if (isNull==null){
				check.disabled=true;
			}
			else{
				check.disabled=false;
			}
		}
		catch(e)
		{
			alert(e.name + " - "+e.message+" En checkout()");
		}

	}
	

	
//-->
	
	</script>
</head><body onload="MM_preloadImages('botones/btn_eliminar_roll.gif');checkout()">
<form name="${ManAboBeneForm}" > 
    <html:hidden property="condicH" />
	<tr>
     	<td class="mensajeError" align="center"><div id="mensajes"></div></td>
  	</tr>
  <tr>
    <td colspan="3"><table width="100%" border="0" cellpadding="0" cellspacing="2">
      <tr>
        <td width="100%" colspan="4" align="left" >&nbsp;</td>
      </tr>
      <tr>
        <td colspan="4" align="left" ><h2 class="textoSubTitulo"> Abonados Beneficiarios</h2></td>
      </tr>

      <tr>
        <td colspan="4" align="left"><table border="0" cellpadding="0" cellspacing="0"  width="100%">
          <tr>
            <td width="11%" class="campoInformativo">N&uacute;mero Celular</td>
            <td width="1%" class="campoInformativo">:</td>
            <td width="88%" class="valorCampoInformativo"><c:out value="${Abonado.numCelular}"/></td>
          </tr>
        </table></td>
      </tr>

      <tr>
        <td colspan="4">&nbsp;</td>
      </tr>
      <tr>
        <td height="23" colspan="4"><img src="img/black_arrow.gif" alt="  " width="7" height="7" />N&deg; Celular Beneficiario &nbsp;
        	<input type="text" id ="numCelularAbonado" name="numCelularAbonado" onkeypress="return acceptNum(event)"/>
          <a ><img src="botones/btn_ingresar.gif" alt="Ingresar" name="Image100"  border="0" align="absmiddle" id="Image100" onmouseover="sobreElBoton('Image100','botones/btn_ingresar_roll.gif')" onmouseout="sobreElBoton('Image100','botones/btn_ingresar.gif')" 
          			onclick="obtieneAbonadosBeneficiariosPorNumCelular(numCelularAbonado);"/></a>		</td>
	  </tr>
      <tr>
        <td colspan="4">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="4"><table width="100%" border="0">
          <tr>
            <td width="10%">&nbsp;</td>
            <td width="15%">&nbsp;</td>
            <td width="50%">&nbsp;</td>
            <td width="15%">&nbsp;</td>
            <input type="hidden" id="btnSiguiente" name="btnSiguiente" />
            <td width="10%">
			<a ><img src="botones/btn_eliminar.gif" alt="Eliminar" name="Image101"  border="0" align="absmiddle" id="Image101" onmouseover="sobreElBoton('Image101','botones/btn_eliminar_roll.gif')" onmouseout="sobreElBoton('Image101','botones/btn_eliminar.gif')" onclick="eliminarSeleccionados()"/></a>
			</td>
          </tr>
          <tr class="textoColumnaTabla">
          <td>Nº</td>
            <td>N&uacute;mero Celular </td>
            <td>Nombre</td>
            <td>N&uacute;mero Abonado </td>
            <td >Seleccionar
            	<input type="checkbox" onclick ="checkearDescheckear(this);" name="selAll"/>
            </td>
          </tr>
          <tbody id="listAbonadosBenf">	
          <% /*<logic:notEmpty name="ManAboBeneForm" property="abonadosDTO" scope="session"> 
	         <logic:iterate indexId="n" id="abonadoBeneficiarioDTO" name="ManAboBeneForm" property="abonadosDTO">
	          <tr>
	           <td align="center" id="item">*/%><%//= n.intValue()+1%><% /*</td>
	            <td align="center" ><bean:write name="abonadoBeneficiarioDTO" property="numCelular"/></td>
	            <td ><bean:write name="abonadoBeneficiarioDTO" property="nombre"/></td>
	            <td align="center"><bean:write name="abonadoBeneficiarioDTO" property="num_Abonado_Beneficiario"/></td>
	            <td><div align="center">
	            	<html:multibox name="ManAboBeneForm" property="listaNumAbonados">
	            		<fmt:formatNumber value="${abonadoBeneficiarioDTO.num_Abonado_Beneficiario}" type="number" groupingUsed="false"/>
	            	</html:multibox>
	            </div></td>

	          </tr>
	         </logic:iterate>
	       </logic:notEmpty>  
	      */%> 
          <logic:notEmpty name="ManAboBeneForm" property="abonadosListadosDTO" scope="session"> 
	         <logic:iterate indexId="n" id="abonadoBeneficiarioDTO" name="ManAboBeneForm" property="abonadosListadosDTO">
	          <tr>
	           <td align="center" id="item"> <%= n.intValue()+1%></td>
	            <td align="center" ><bean:write name="abonadoBeneficiarioDTO" property="numCelular"/></td>
	            <td ><bean:write name="abonadoBeneficiarioDTO" property="nombre"/></td>
	            <td align="center"><bean:write name="abonadoBeneficiarioDTO" property="num_Abonado_Beneficiario"/></td>
	            <td><div align="center">
	            	<html:multibox name="ManAboBeneForm" property="listaNumAbonados">
	            		<fmt:formatNumber value="${abonadoBeneficiarioDTO.num_Abonado_Beneficiario}" type="number" groupingUsed="false"/>
	            	</html:multibox>
	            	<input type="hidden" id="listaEncolar" name="listaEncolar" value="<c:out value="${abonadoBeneficiarioDTO.num_Abonado_Beneficiario}"/>"/>
	            	<input type="hidden" id="listaEncolarNombre" name="listaEncolarNombre" value="<c:out value="${abonadoBeneficiarioDTO.nombre}"/>"/>
	            	<input type="hidden" id="listaEncolarNumCelular" name="listaEncolarNumCelular" value="<c:out value="${abonadoBeneficiarioDTO.numCelular}"/>"/>
	            	<input type="hidden" id="listaEncolarTipoComportamiento" name="listaEncolarTipoComportamiento" value="<c:out value="${abonadoBeneficiarioDTO.tipo_Comportamiento}"/>"/>
	            	<input type="hidden" id="listaEncolarFecInicioVigencia" name="listaEncolarFecInicioVigencia" value="<c:out value="${abonadoBeneficiarioDTO.fec_Inicio_Vigencia}"/>"/>
	            	<input type="hidden" id="listaEncolarFecTerminoVigencia" name="listaEncolarFecTerminoVigencia" value="<c:out value="${abonadoBeneficiarioDTO.fec_Termino_Vigencia}"/>"/>
	            </div></td>

	          </tr>

	         </logic:iterate>
	       </logic:notEmpty> 	        
        </tbody> 
    </table>   
   </td>
</tr>
</form>
</body>
</html>
<%//<script language="JavaScript" type="text/javascript">obtieneAboBenPorNumCelularRecarga();</script>%>
