<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean"	prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Telefónica Móviles .: Mantención de Abonados s :.</title>
<link href="/abonadoVetado/css/mas.css" rel="stylesheet" type="text/css" />
<script language="javaScript" src="abonadoVetado/botones/presiona.js" type="text/javascript"></script>
<script language="javascript" src="abonadoVetado/js/toolsgrilla.js" type="text/javascript"></script>
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
	
 var vetados= new Array();
	var indice=0;
 <logic:iterate id="vetado" name="listaNumAbonadosVetados" type="java.lang.String">
    vetados[indice]="<bean:write name='vetado'/>";
    indice++;
 </logic:iterate>
	 

	
 window.onload = function() {
 valoresDefaultCarga();
  var  todosChk=eval("document.ManAboVetaForm.listaNumAbonadosCheck");
 
  if (todosChk.value != null){
     if (todosChk[0]==vetadosBD[0]) {
          todosChk.checked = true;
      }
   }
   else{
       
   		for(var i=0;i<todosChk.length;i++){
   				if (buscaCheck(todosChk[i].value)){
   				    	todosChk[i].checked = true;
   				}
   		}
   }
}

function buscaCheck(listaVet){
  
  for(var i=0;i<vetados.length;i++){
     if (listaVet==vetados[i]){
  		    return true;
  		 }
  }
  
  return false;

}


 function getAbonadosLista(data){
		var abonBenef=new Array();
		var listaAbonadosIterate=new Array();
		abonBenef=data;  
   		var tablaBody=document.getElementById("listAbonadosBenf");
   		var fila;
   		var columna; 
   		var items = eval("document.ManAboVetaForm.listaNumAbonados");
   		listaAbonadosIterate=eval("document.ManAboVetaForm.listaNumAbonados");
   		var numLista;
   		numLista= items==null?0:items.length!=null?items.length:1;
   		 
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
   		}
	        
   		}
	}
	
	
	
	function checkout(){
		
		var listaAbonadosIterate=new Array();
		listaAbonadosIterate=eval("document.ManAboVetaForm.listaNumAbonadosCheck");
		var check=("document.selAll");
		var isNull=listaAbonadosIterate;
		if (isNull==null){
			check.disabled=true;
		}
		else{
			check.disabled=false;
		}
	}
	

	
//-->
	
	</script>
</head><body onload="MM_preloadImages('botones/btn_eliminar_roll.gif');checkout()">
<form name="${ManAboVetaForm}" > 
	<tr>
	
     	<td class="mensajeError" align="center"><div id="mensajes"></div></td>
  	</tr>
  <tr>
    <td colspan="3"><table width="100%" border="0" cellpadding="0" cellspacing="2">
      <tr>
        <td width="100%" colspan="4" align="left" >&nbsp;</td>
      </tr>
      <tr>
        <td colspan="4" align="left" ><h2 class="textoSubTitulo"> Abonados</h2></td>
      </tr>
      <tr>
        <td colspan="4">
        <table width="100%" border="0">
        	<tr>
        		<td width="10%">&nbsp;</td>
        		<td width="15%">&nbsp;</td>
        		<td width="60%">&nbsp;</td>
        		<td width="15%">&nbsp;</td>
        		<input type="hidden" id="btnSiguiente" name="btnSiguiente" />
        		
        	</tr>
        	<tr class="textoColumnaTabla">
        		<td>Nº</td>
        		<td> </td>
        		<td>Nombre</td>
        		<td>N&uacute;mero Abonado </td>
        		
        	</tr>
        	<tbody id="listAbonadosVeta" >
        	<logic:notEmpty name="ManAboVetaForm" property="abonadosVetadosDTO" scope="session"> 
        		<logic:iterate indexId="n" id="abonadoDTO" name="ManAboVetaForm" property="abonadosVetadosDTO">
        			<tr>
        				<td align="center" id="item"> <%= n.intValue()+1%></td>
        				<td align="center" >
        				<html:multibox name="ManAboVetaForm" property="listaNumAbonadosCheck">
            				<fmt:formatNumber value="${abonadoDTO.numAbonado}" type="number" groupingUsed="false"/>
            			</html:multibox>
            			<td ><bean:write name="abonadoDTO" property="nombre"/></td>
        				<td align="center"><bean:write name="abonadoDTO" property="numAbonado"/></td>
        				
        			</tr>
        		</logic:iterate>
        	</logic:notEmpty>	
        	</tbody> 
        </table>
              </td>
  </tr>


</body>
</html>
