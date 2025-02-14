<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<title>Telef&oacute;nica M&oacute;viles: Portal Ventas</title>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>

<script type="text/JavaScript">
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

function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}

function verificaEnter(){
	if (document.getElementById("mensajes")!=null){
		document.getElementById("mensajes").innerHTML = ""; 
	}
	var strName = new String (event.srcElement.name);
	keyASCII = window.event.keyCode;
	if( keyASCII == 13 ){
	  if (strName == 'usuario'){
	    LoginActionForm.clave.focus(); 
	  } else {
		enviar();
	  } 
	}
}

/*
function inicializar(){
	LoginActionForm.usuario.focus();
}*/
</script>

<script>
//Inicio P-CSR-11002 JLGN 09-05-2011
function fncInicio(){
var flagInicio = document.getElementById("flagInicio");
if(document.getElementById("flagInicio").value == ""){
	document.getElementById("opcion").value = "inicioLogin";
	document.forms[0].submit();
	}
}
//Fin P-CSR-11002 JLGN 09-05-2011
</script>

<script type="text/javascript" src="js/flashobject.js"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<style type="text/css">
body {
	background-color: #173B87;
}
</style>
</head>

<body onload="fncInicio();MM_preloadImages('img/btn_ingresar_roll.gif');">
<p>&nbsp;</p>

<html:form method="POST" action="LoginAction.do">
<html:hidden property="opcion" value="inicioLogin" styleId="opcion"/>
<html:hidden property="flagInicio" styleId="flagInicio"/>
<html:errors bundle="errors"/>
<script type="text/javascript">
	function enviar() {
		if (document.getElementById("mensajes")!=null){
			document.getElementById("mensajes").innerHTML = ""; 
		}
		document.getElementById("opcion").value = "executeLogin";
		document.forms[0].submit();
	}
</script>       

<table width="633"  border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="163A86">
  <tr>
    <td  class="emes"><table>
      <tr>
        <td class="lineapunteadablanca" colspan="2" ><h1>Portal Ventas</h1>
        	<bean:write name="nomOperador"/> <!-- P-CSR-11002 JLGN 04-04-2011 -->	    	     
		<br />
		</td>
      </tr>
    </table></td>
    <td width="220" class="lineablancaancho">
		<!-- permite cargar un swf externo atraves de un js -->
	<div id="flashcontent">	</div>
	<script type="text/javascript">
	
	   var fo = new FlashObject("img/intro1.swf", "menu", "220", "290", "7", "#163A86");
	   fo.addParam("scale", "exactfit");
	   fo.addParam("menu", "false");
	   fo.write("flashcontent");
	</script>	</td>
    <td  class="emes2"  valign="top"><table width="197"  cellpadding="3" cellspacing="3">
      <tr>
        <td width="50" height="29">&nbsp;</td>
        <td  colspan="2" align="right" valign="middle"><img src="img/loguin.gif" alt="Login" width="71" height="21" />&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3" class="textointroblanco">Ingrese su nombre de usuario y su clave </td>
        </tr>
      <tr>
        <td class="textointroblanco">Usuario</td>
        <td colspan="2"  class="cajas">
             <html:text name="LoginActionForm" property="usuario" styleId="usuario" size="20" maxlength="20" onkeypress="verificaEnter();" style="text-transform: uppercase;" onblur="upperCase(this)" />
             <script>
              LoginActionForm.usuario.focus();
             </script>
        </td>
      </tr>
      <tr>
        <td class="textointroblanco">Clave</td>
        <td colspan="2" >
        	<html:password name="LoginActionForm" property="clave" styleId="clave" size="20" maxlength="20" onkeypress="verificaEnter();" style="text-transform: uppercase;" onblur="upperCase(this)" />
        </td>
      </tr>
      <tr>
        <td colspan="3"><img src="img/px_blanco.gif" alt="  " width="90%" height="1" /></td>
      </tr>
      
      <logic:present name="mensajeErrorLogin">
      <tr>
       <td colspan="3"  class="mensajeError">
       <div id="mensajes" align="left">
       	<img src="img/btn_elim_cruz.gif" alt="  "  height="11"/>&nbsp;&nbsp;<bean:write name="mensajeErrorLogin"/>
       	</div>
       </td>
      </tr>
      </logic:present>

      <tr>
        <td >&nbsp;</td>
        <td width="55">&nbsp;</td>
        <td width="60"><a href="javascript:enviar()" onmouseover="MM_swapImage('Image9','','img/btn_ingresar_roll.gif',1)" onmouseout="MM_swapImgRestore()"><img src="img/btn_ingresar.gif" alt="Ingresar" name="Image9" width="58" height="13" border="0"  id="Image9" /></a></td>
      </tr>
    </table>	
   </td>
  </tr>
  <tr>
    <td height="31" ><span class="textointroblanco">Copyright &copy; 2010: TM-mAs. </span>
      <br /><br /><a href="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash&amp;promoid=BIOW" target="_blank"><img
        src="http://www.w3.org/Icons/valid-xhtml10"
        alt="Valid XHTML 1.0 Transitional" height="31" width="88" border="0"/><img src="http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif" alt="/get_flash_player" width="88" height="31" border="0" /><br />
    </a></td>
    <td colspan="2" class="textointroblanco" >&nbsp;</td>
  </tr>
</table>

</html:form>
</body>
</html:html>

