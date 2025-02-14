<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@page import="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Redestribución Unidades Libres Cliente :.</title>
<link href="css/CustomerOrder.css" rel="stylesheet" type="text/css">
<script language="javascript" type="text/javascript" src="include/lib.js">
</script>
<script language="javascript" type="text/javascript"> 
	function validaVacio(){
		if(isNotEmpty(document.forms[0].comentarios)) { 
			document.forms[0].accionCommentaries.value='finalizar';
			document.forms[0].submit();			
		}else{
			alert("Debe Ingresar un Comentario");		
		}
	}

</script>

</head>
<body>
<div align="center"><html:errors bundle="errors" /> 
	<html:form action="/CommentariesAction">
	<html:hidden property="accionCommentaries"/>
	<table class="tablaInformacion" >
		<tr>
			<td  colspan="8" align="left" class="amarillo"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Informaci&oacute;n del Cliente</strong></td>
		</tr>	
		<tr>
			<td align="left">
				<table border="0" cellpadding="0" cellspacing="0" class="bordeTablasCero">
					<jsp:include page="/datosGenerales.jsp" flush="true"></jsp:include>
				</table>
			</td>
		</tr>
        <tr>		
			<td>
				<p>&nbsp;</p>
			</td>			    
		</tr>			
        <tr>
			<td align="right">
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>                  
					    <td width="50%" colspan="8" align="left" class="amarillo" >
					      <img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /><strong>Comentario Orden de Servicio</strong>
					    </td>					
						<td width="50%" border="0" align="right" class="fondoFilaBlanco">
							<html:button styleClass="fondoFilaPlomo" value="Finalizar" property="nada" onclick="validaVacio();" />
					    </td>				                    
					</tr>					            
				</table>    
			</td>
		</tr>
		<tr>
			<td>
				<p>&nbsp;</p>
			</td>			    
	    </tr>
	    <tr>
			<td colspan="8" class="textcaminohormigas" align="left">
 				Comentarios
 			</td>				           
	    </tr>
		<tr>
			<td>				        
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>
                    	<td width="100%"> 
                        	<html:textarea property="comentarios" rows="10" cols="175"/>
                        </td>
				    </tr>									    
			    </table>
			</td>
		</tr>				    
		<tr>
			<td>
				<p>&nbsp;</p>
			</td>
		</tr>
        <tr>
			<td td align="right">
				<table border="0" cellspacing="1" cellpadding="2" width="100%">
					<tr>  										                
						<td width="100%" border="0" align="right" class=fondoFilaBlanco>
							<html:button styleClass="fondoFilaPlomo" value="Finalizar" property="nada" onclick="validaVacio();" />
					    </td>				                    
					</tr>					            
				</table>    
			</td>
		</tr>					  
	</table>			
	</html:form>
</div>
</body>
</html>				    			        
