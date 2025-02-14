<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

<c:set var="direccion" value="${sessionScope.direccionDTO}"/>

<jsp:include page="/nocache.jsp" flush="true"></jsp:include>




<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JDireccionAJAX.js'></script>
<script>
	window.history.forward(1);
	
	function fncCargaInicial(){
		fncObtenerRegionIni();
		fncObtenerProvinciaIni();
		fncObtenerCiudadIni();
		fncObtenerComunaIni();
		fncObtenerCodigosPostalesIni();
		fncObtenerTipoCalleIni();

		//otros campos que no son listas
		var nomCalle = document.getElementById("NOM_CALLE");//valor en sesion
		var numCalle = document.getElementById("NUM_CALLE");//valor en sesion
		var obsDireccion = document.getElementById("OBS_DIRECCION");//valor en sesion
		var desDirec1 = document.getElementById("DES_DIREC1");//valor en sesion
		var desDirec2 = document.getElementById("DES_DIREC2");//valor en sesion
		
		
		var nomCalleCtr = document.getElementById("control_NOM_CALLE");
		var numCalleCtr = document.getElementById("control_NUM_CALLE");
		var obsDireccionCtr = document.getElementById("control_OBS_DIRECCION");
		var desDirec1Ctr = document.getElementById("control_DES_DIREC1");
		var desDirec2Ctr = document.getElementById("control_DES_DIREC2");
		
				
		if(nomCalleCtr!=null) nomCalleCtr.value = nomCalle.value;
		if(numCalleCtr!=null) numCalleCtr.value = numCalle.value;
		if(obsDireccionCtr!=null) obsDireccionCtr.value = obsDireccion.value;
		if(desDirec1Ctr!=null) desDirec1Ctr.value = desDirec1.value;
		if(desDirec2Ctr!=null) desDirec2Ctr.value = desDirec2.value;	
		//P-CSR-11002 JLGN 14-06-2011
		fncCursorNormal();
		}
	
	function fncOnChangeCMB(campoControl){
		if 		(campoControl =="COD_REGION") 		fncObtenerProvincia();
		else if (campoControl =="COD_PROVINCIA")	fncObtenerCiudad();
		else if (campoControl =="COD_CIUDAD")		{fncObtenerComuna();fncObtenerCodigosPostales();}		
	}
	
	//(+) -------------------carga de combos y datos desde  sesion----------------------l
	//(+)-- carga combo de region --
	function fncObtenerRegionIni() {
		var tipoControl = document.getElementById("tipo_control_COD_REGION");
		if (tipoControl!=null){
			if ( tipoControl.value == "CMB"){
				JDireccionAJAX.obtenerRegion(fncResultadoObtenerRegionIni);
			}else if ( tipoControl.value == "TXT"){//carga valor de sesion
				document.getElementById("control_COD_REGION").value = document.getElementById("COD_REGION").value;
			}
		}
	}
	
	function fncResultadoObtenerRegionIni(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
	        	
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_COD_REGION");
		    DWRUtil.addOptions("control_COD_REGION",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_COD_REGION",listaActualizada,"codigo","descripcion");
		    
		    var codRegion = document.getElementById("COD_REGION");//valor en sesion
			if (codRegion.value!=""){
				var codRegionCtr = document.getElementById("control_COD_REGION");
			    for (index = 0; index< codRegionCtr.length; index++) {
			    	if (codRegionCtr[index].value == codRegion.value){
			        	codRegionCtr.selectedIndex = index;	break;
			    	} 
			    }
			}
	    }//fin if (data!=null)
	}
	//(-)-- carga combo de region --
	
	//(+)-- carga combo tipo calle --
	function fncObtenerTipoCalleIni() {
		var tipoControl = document.getElementById("tipo_control_COD_TIPOCALLE");
		if (tipoControl!=null){
			if ( tipoControl.value == "CMB"){
				JDireccionAJAX.obtenerTipoCalle(fncResultadoObtenerTipoCalleIni);
			}else if ( tipoControl.value == "TXT"){//carga valor de sesion
				document.getElementById("control_COD_TIPOCALLE").value = document.getElementById("COD_TIPOCALLE").value;
			}
		}
	}
	
	function fncResultadoObtenerTipoCalleIni(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_COD_TIPOCALLE");
		    DWRUtil.addOptions("control_COD_TIPOCALLE",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_COD_TIPOCALLE",listaActualizada,"codigo","descripcion");
		    
		    var codTipoCalle = document.getElementById("COD_TIPOCALLE");//valor en sesion
			if (codTipoCalle.value!=""){
				var codTipoCalleCtr = document.getElementById("control_COD_TIPOCALLE");
			    for (index = 0; index< codTipoCalleCtr.length; index++) {
			    	if (codTipoCalleCtr[index].value == codTipoCalle.value){
			        	codTipoCalleCtr.selectedIndex = index;	break;
			    	} 
			    }
			}
	    }//fin if (data!=null)
	}
	//(-)-- carga combo tipo calle --
	
	//(+)-- carga combo de provincia --
	function fncObtenerProvinciaIni() {
		var tipoControl = document.getElementById("tipo_control_COD_PROVINCIA");
		if (tipoControl!=null){
			if (tipoControl.value == "CMB"){
				var codRegion = document.getElementById("COD_REGION");//valor en sesion
				if (codRegion.value!="") { JDireccionAJAX.obtenerProvincias(codRegion.value,fncResultadoObtenerProvinciaIni); }
			}else if ( tipoControl.value == "TXT"){//carga valor de sesion
				document.getElementById("control_COD_PROVINCIA").value = document.getElementById("COD_PROVINCIA").value;
			}
		}
	}
	
	function fncResultadoObtenerProvinciaIni(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_COD_PROVINCIA");
		    DWRUtil.addOptions("control_COD_PROVINCIA",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_COD_PROVINCIA",listaActualizada,"codigo","descripcion");
		    
		    var codProvincia = document.getElementById("COD_PROVINCIA");//valor en sesion
			if (codProvincia.value!=""){
				var codProvinciaCtr = document.getElementById("control_COD_PROVINCIA");
			    for (index = 0; index< codProvinciaCtr.length; index++) {
			    	if (codProvinciaCtr[index].value == codProvincia.value){
			        	codProvinciaCtr.selectedIndex = index;	break;
			    	} 
			    }
			}
	    }//fin if (data!=null)
	}
	//(-)-- carga combo de provincia --
	
	//(+)-- carga combo de ciudad --
	function fncObtenerCiudadIni() {
		var tipoControl = document.getElementById("tipo_control_COD_CIUDAD");
		if (tipoControl!=null){
			if ( tipoControl.value == "CMB"){
				var codRegion = document.getElementById("COD_REGION");//valor en sesion
				var codProvincia = document.getElementById("COD_PROVINCIA");//valor en sesion
	
				if ( codRegion.value!="" && codProvincia.value!="" ){
					JDireccionAJAX.obtenerCiudades(codRegion.value,codProvincia.value,fncResultadoObtenerCiudadIni);
				}
			}else if ( tipoControl.value == "TXT"){//carga valor de sesion
				document.getElementById("control_COD_CIUDAD").value = document.getElementById("COD_CIUDAD").value;
			}
		}

	}
	
	function fncResultadoObtenerCiudadIni(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_COD_CIUDAD");
		    DWRUtil.addOptions("control_COD_CIUDAD",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_COD_CIUDAD",listaActualizada,"codigo","descripcion");
		    
		    var codCiudad = document.getElementById("COD_CIUDAD");//valor en sesion
			if (codCiudad.value!=""){
				var codCiudadCtr = document.getElementById("control_COD_CIUDAD");
			    for (index = 0; index< codCiudadCtr.length; index++) {
			    	if (codCiudadCtr[index].value == codCiudad.value){
			        	codCiudadCtr.selectedIndex = index;	break;
			    	} 
			    }
			}
	    }////fin if (data!=null)
	}	
	//(-)-- carga combo de ciudad --
	
	//(+)-- carga combo de comuna --
	function fncObtenerComunaIni() {
		var tipoControl = document.getElementById("tipo_control_COD_COMUNA");
		if (tipoControl!=null){
			if ( tipoControl.value == "CMB"){
				var codRegion = document.getElementById("COD_REGION");//valor en sesion
				var codProvincia = document.getElementById("COD_PROVINCIA");//valor en sesion
				var codCiudad = document.getElementById("COD_CIUDAD");//valor en sesion
				
				if (  codRegion.value!="" && codProvincia.value!="" && codCiudad.value!=""  ){
					JDireccionAJAX.obtenerComunas(codRegion.value,codProvincia.value,codCiudad.value,fncResultadoObtenerComunaIni);
				}
			}else if ( tipoControl.value == "TXT"){//carga valor de sesion
				document.getElementById("control_COD_COMUNA").value = document.getElementById("COD_COMUNA").value;
			}
		}

	}	
	
	function fncResultadoObtenerComunaIni(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_COD_COMUNA");
		    DWRUtil.addOptions("control_COD_COMUNA",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_COD_COMUNA",listaActualizada,"codigo","descripcion");
		    
		    var codComuna = document.getElementById("COD_COMUNA");//valor en sesion
			if (codComuna.value!=""){
				var codComunaCtr = document.getElementById("control_COD_COMUNA");
			    for (index = 0; index< codComunaCtr.length; index++) {
			    	if (codComunaCtr[index].value == codComuna.value){
			        	codComunaCtr.selectedIndex = index;	break;
			    	} 
			    }
			}
	    }////fin if (data!=null)
	}	
	//(-)-- carga combo de comuna --	
	
	//(+)-- carga combo de codigo postal --
	function fncObtenerCodigosPostalesIni() {
		var tipoControl = document.getElementById("tipo_control_ZIP");
		if (tipoControl!=null){
			if ( tipoControl.value == "CMB"){
				var codCiudad = document.getElementById("COD_CIUDAD");//valor en sesion
				if (codCiudad.value!=""){
					JDireccionAJAX.obtenerCodigosPostales(codCiudad.value,fncResultadoObtenerCodigosPostalesIni);
				}
			}else if ( tipoControl.value == "TXT"){//carga valor de sesion
				document.getElementById("control_ZIP").value = document.getElementById("ZIP").value;
			}
		}
	}
	
	function fncResultadoObtenerCodigosPostalesIni(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_ZIP");
		    DWRUtil.addOptions("control_ZIP",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_ZIP",listaActualizada,"codigo","descripcion");
		    
	   		var zip = document.getElementById("ZIP");//valor en sesion
			if (zip.value!=""){
				var zipCtr = document.getElementById("control_ZIP");
			    for (index = 0; index< zipCtr.length; index++) {
			    	if (zipCtr[index].value == zip.value){
			        	zipCtr.selectedIndex = index;	break;
			    	} 
			    }
			}
	    }////fin if (data!=null)
	}	
	
	//(-) -------------------carga de combos y datos desde  sesion----------------------

	//(+) -------------------carga de combos pagina-------------------------------------
	//(+)-- carga combo de provincia --
	function fncObtenerProvincia() {
		var tipoControl = document.getElementById("tipo_control_COD_PROVINCIA");
		if (tipoControl!=null && tipoControl.value == "CMB"){
			var controlRegion = document.getElementById("control_COD_REGION");

			if (controlRegion !=null && controlRegion.value!=""){
				JDireccionAJAX.obtenerProvincias(controlRegion.value,fncResultadoObtenerProvincia);
			}else{
			
				DWRUtil.removeAllOptions("control_COD_PROVINCIA");
		    	DWRUtil.addOptions("control_COD_PROVINCIA",{'':'- Seleccione -'});
		    	
		    	var tipoControlciu = document.getElementById("tipo_control_COD_CIUDAD");
				if (tipoControlciu!=null && tipoControlciu.value == "CMB"){
						DWRUtil.removeAllOptions("control_COD_CIUDAD");
				    	DWRUtil.addOptions("control_COD_CIUDAD",{'':'- Seleccione -'});
				    	
				    	var tipoControlz = document.getElementById("tipo_control_ZIP");
						if (tipoControlz!=null && tipoControlz.value == "CMB"){
							DWRUtil.removeAllOptions("control_ZIP");
					    	DWRUtil.addOptions("control_ZIP",{'':'- Seleccione -'});
						}
				}
			}//fin else
		}
	}
	
	function fncResultadoObtenerProvincia(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_COD_PROVINCIA");
		    DWRUtil.addOptions("control_COD_PROVINCIA",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_COD_PROVINCIA",listaActualizada,"codigo","descripcion");
		    
	    	var tipoControlciu = document.getElementById("tipo_control_COD_CIUDAD");
			if (tipoControlciu!=null && tipoControlciu.value == "CMB"){
					DWRUtil.removeAllOptions("control_COD_CIUDAD");
			    	DWRUtil.addOptions("control_COD_CIUDAD",{'':'- Seleccione -'});
			    	
			    	var tipoControlz = document.getElementById("tipo_control_ZIP");
					if (tipoControlz!=null && tipoControlz.value == "CMB"){
						DWRUtil.removeAllOptions("control_ZIP");
				    	DWRUtil.addOptions("control_ZIP",{'':'- Seleccione -'});
					}
			}
				
		    
	    }
	}
	//(-)-- carga combo de provincia --
	
	//(+)-- carga combo de ciudad --
	function fncObtenerCiudad() {
		var tipoControl = document.getElementById("tipo_control_COD_CIUDAD");
		if (tipoControl!=null && tipoControl.value == "CMB"){
			var controlProvincia = document.getElementById("control_COD_PROVINCIA");
			var controlRegion = document.getElementById("control_COD_REGION");

			if ( (controlProvincia !=null && controlProvincia.value!="") 
				&& (controlRegion !=null && controlRegion.value!="") ){
				JDireccionAJAX.obtenerCiudades(controlRegion.value,controlProvincia.value,fncResultadoObtenerCiudad);
			}else{
				DWRUtil.removeAllOptions("control_COD_CIUDAD");
		    	DWRUtil.addOptions("control_COD_CIUDAD",{'':'- Seleccione -'});
		    	
		    	var tipoControlz = document.getElementById("tipo_control_ZIP");
				if (tipoControlz!=null && tipoControlz.value == "CMB"){
					DWRUtil.removeAllOptions("control_ZIP");
			    	DWRUtil.addOptions("control_ZIP",{'':'- Seleccione -'});
				}
			}//fin else
		}

	}
	
	function fncResultadoObtenerCiudad(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_COD_CIUDAD");
		    DWRUtil.addOptions("control_COD_CIUDAD",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_COD_CIUDAD",listaActualizada,"codigo","descripcion");
		    
	    	var tipoControlz = document.getElementById("tipo_control_ZIP");
			if (tipoControlz!=null && tipoControlz.value == "CMB"){
				DWRUtil.removeAllOptions("control_ZIP");
		    	DWRUtil.addOptions("control_ZIP",{'':'- Seleccione -'});
			}		    
	    }
	}	
	//(-)-- carga combo de ciudad --
	
	//(+)-- carga combo de comuna --
	function fncObtenerComuna() {
		var tipoControl = document.getElementById("tipo_control_COD_COMUNA");
		if (tipoControl!=null && tipoControl.value == "CMB"){
			var controlCiudad = document.getElementById("control_COD_CIUDAD");
			var controlProvincia = document.getElementById("control_COD_PROVINCIA");
			var controlRegion = document.getElementById("control_COD_REGION");
			
			if ( (controlCiudad != null && controlCiudad.value!="")
				&& (controlProvincia !=null && controlProvincia.value!="") 
				&& (controlRegion !=null && controlRegion.value!="")){
				JDireccionAJAX.obtenerComunas(controlRegion.value,controlProvincia.value,controlCiudad.value,fncResultadoObtenerComuna);
			}else{
				DWRUtil.removeAllOptions("control_COD_COMUNA");
		    	DWRUtil.addOptions("control_COD_COMUNA",{'':'- Seleccione -'});
			}
		}

	}	
	
	function fncResultadoObtenerComuna(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_COD_COMUNA");
		    DWRUtil.addOptions("control_COD_COMUNA",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_COD_COMUNA",listaActualizada,"codigo","descripcion");
	    }
	}	
	//(-)-- carga combo de comuna --	
	
	//(+)-- carga combo de codigo postal --
	function fncObtenerCodigosPostales() {
		var tipoControl = document.getElementById("tipo_control_ZIP");
		if (tipoControl!=null && tipoControl.value == "CMB"){
			var controlCiudad = document.getElementById("control_COD_CIUDAD");
			if ( controlCiudad != null && controlCiudad.value!=""){
				JDireccionAJAX.obtenerCodigosPostales(controlCiudad.value,fncResultadoObtenerCodigosPostales);
			}else{
				DWRUtil.removeAllOptions("control_ZIP");
		    	DWRUtil.addOptions("control_ZIP",{'':'- Seleccione -'});
			}
		}
	}
	
	function fncResultadoObtenerCodigosPostales(data){
		if (data!=null){
			var codError = data["codError"];
			if (codError == "-100"){
		       	fncInvocarPaginaExpiraSesion();
	        	return;
	        }
		
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("control_ZIP");
		    DWRUtil.addOptions("control_ZIP",{'':'- Seleccione -'});
		    DWRUtil.addOptions("control_ZIP",listaActualizada,"codigo","descripcion");
	    }
	}	
	//(-)-- carga combo de codigo postal --
	//(-) -------------------carga de combos pagina-------------------------------------
		
	//(+)-- ACEPTAR --
	function fncAceptar() {
		var codRegion = document.getElementById("control_COD_REGION");
		var codProvincia = document.getElementById("control_COD_PROVINCIA");
		var codCiudad = document.getElementById("control_COD_CIUDAD");
		var codComuna = document.getElementById("control_COD_COMUNA");
		var codTipoCalle = document.getElementById("control_COD_TIPOCALLE");
		var nomCalle = document.getElementById("control_NOM_CALLE");
		var numCalle = document.getElementById("control_NUM_CALLE");
		var obsDireccion =  document.getElementById("control_OBS_DIRECCION");
		var zip	= document.getElementById("control_ZIP");
		var desDirec1	= document.getElementById("control_DES_DIREC1");
		var desDirec2	= document.getElementById("control_DES_DIREC2");
		
		if (codRegion!=null){
			var esObligatorio = document.getElementById("es_obligatorio_COD_REGION");
			var caption		  = document.getElementById("caption_COD_REGION");
			if (esObligatorio.value=="true" && codRegion.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("COD_REGION").value = codRegion.value;	
				document.getElementById("descripcionCOD_REGION").value = codRegion.value;
				if (document.getElementById("tipo_control_COD_REGION").value == "CMB")
					document.getElementById("descripcionCOD_REGION").value = DWRUtil.getText("control_COD_REGION");	
			}
		}
		
		if (codProvincia!=null){
			var esObligatorio = document.getElementById("es_obligatorio_COD_PROVINCIA");
			var caption		  = document.getElementById("caption_COD_PROVINCIA");
			if (esObligatorio.value=="true" && codProvincia.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("COD_PROVINCIA").value = codProvincia.value;	
				document.getElementById("descripcionCOD_PROVINCIA").value = codProvincia.value;
				if (document.getElementById("tipo_control_COD_PROVINCIA").value == "CMB")
					document.getElementById("descripcionCOD_PROVINCIA").value = DWRUtil.getText("control_COD_PROVINCIA");	
				
			}
		}
		
		if (codCiudad!=null){
			var esObligatorio = document.getElementById("es_obligatorio_COD_CIUDAD");
			var caption		  = document.getElementById("caption_COD_CIUDAD");
			if (esObligatorio.value=="true" && codCiudad.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("COD_CIUDAD").value = codCiudad.value;
				document.getElementById("descripcionCOD_CIUDAD").value = codCiudad.value;
				if (document.getElementById("tipo_control_COD_CIUDAD").value == "CMB")
					document.getElementById("descripcionCOD_CIUDAD").value = DWRUtil.getText("control_COD_CIUDAD");	
			}
		}
			
		if (codComuna!=null){
			var esObligatorio = document.getElementById("es_obligatorio_COD_COMUNA");
			var caption		  = document.getElementById("caption_COD_COMUNA");
			if (esObligatorio.value=="true" && codComuna.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("COD_COMUNA").value = codComuna.value;
				document.getElementById("descripcionCOD_COMUNA").value = codComuna.value;
				if (document.getElementById("tipo_control_COD_COMUNA").value == "CMB")
					document.getElementById("descripcionCOD_COMUNA").value = DWRUtil.getText("control_COD_COMUNA");	
			}
		}

		if (codTipoCalle!=null){
			var esObligatorio = document.getElementById("es_obligatorio_COD_TIPOCALLE");
			var caption		  = document.getElementById("caption_COD_TIPOCALLE");
			if (esObligatorio.value=="true" && codTipoCalle.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("COD_TIPOCALLE").value = codTipoCalle.value;
				document.getElementById("descripcionCOD_TIPOCALLE").value = codTipoCalle.value;
				if (document.getElementById("tipo_control_COD_TIPOCALLE").value == "CMB")
					document.getElementById("descripcionCOD_TIPOCALLE").value = DWRUtil.getText("control_COD_TIPOCALLE");	
			}
		}
			
		if (nomCalle!=null){
			var esObligatorio = document.getElementById("es_obligatorio_NOM_CALLE");
			var caption		  = document.getElementById("caption_NOM_CALLE");
			if (esObligatorio.value=="true" && nomCalle.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("NOM_CALLE").value = nomCalle.value;	
			}
		}

		if (numCalle!=null){
			var esObligatorio = document.getElementById("es_obligatorio_NUM_CALLE");
			var caption		  = document.getElementById("caption_NUM_CALLE");
			if (esObligatorio.value=="true" && numCalle.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("NUM_CALLE").value = numCalle.value;	
			}
		}
		
		if (obsDireccion!=null){
			var esObligatorio = document.getElementById("es_obligatorio_OBS_DIRECCION");
			var caption		  = document.getElementById("caption_OBS_DIRECCION");
			if (esObligatorio.value=="true" && obsDireccion.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("OBS_DIRECCION").value = obsDireccion.value;	
			}
		}
			
		if (zip!=null){
			var esObligatorio = document.getElementById("es_obligatorio_ZIP");
			var caption		  = document.getElementById("caption_ZIP");
			if (esObligatorio.value=="true" && zip.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("ZIP").value = zip.value;	
				document.getElementById("descripcionZIP").value = zip.value;
				if (document.getElementById("tipo_control_ZIP").value == "CMB")
					document.getElementById("descripcionZIP").value = DWRUtil.getText("control_ZIP");					
			}
		}
					
		if (desDirec1!=null){
			var esObligatorio = document.getElementById("es_obligatorio_DES_DIREC1");
			var caption		  = document.getElementById("caption_DES_DIREC1");
			if (esObligatorio.value=="true" && desDirec1.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("DES_DIREC1").value = desDirec1.value;	
			}
		}
		
		if (desDirec2!=null){
			var esObligatorio = document.getElementById("es_obligatorio_DES_DIREC2");
			var caption		  = document.getElementById("caption_DES_DIREC2");
			if (esObligatorio.value=="true" && desDirec1.value==""){
				alert("Debe ingresar " + caption.value); return;
			}else{
				document.getElementById("DES_DIREC2").value = desDirec2.value;	
			}
		}
																		
	  	document.getElementById("opcion").value = "aceptar";
    	document.forms[0].submit();
	}
 	//(-)-- ACEPTAR --
 	
 	//(+)-- CANCELAR --
 	function fncCancelar(){
	  	document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
 	}
 	//(-)-- CANCELAR --
 	 	
 	//(+)-- LIMPIAR --
 	function fncLimpiar(){	
		var codRegionCtr = document.getElementById("control_COD_REGION");
		var codProvinciaCtr = document.getElementById("control_COD_PROVINCIA");
		var codCiudadCtr = document.getElementById("control_COD_CIUDAD");
		var codComunaCtr = document.getElementById("control_COD_COMUNA");
		var codTipoCalleCtr = document.getElementById("control_COD_TIPOCALLE");
		var nomCalleCtr = document.getElementById("control_NOM_CALLE");
		var numCalleCtr = document.getElementById("control_NUM_CALLE");
		var obsDireccionCtr =  document.getElementById("control_OBS_DIRECCION");
		var zipCtr	= document.getElementById("control_ZIP");
		var desDirec1Ctr = document.getElementById("control_DES_DIREC1");
		var desDirec2Ctr = document.getElementById("control_DES_DIREC2");
				
		if (codRegionCtr!=null){
			var tipoControl = document.getElementById("tipo_control_COD_REGION");
			if (tipoControl.value == "CMB"){
				for (index = 0; index< codRegionCtr.length; index++) {
			    	if (codRegionCtr[index].value == "") {codRegionCtr.selectedIndex = index;	break; 	} 
			    }
			}
			else{
				 codRegionCtr.value="";
			}
		}
		
		if (codProvinciaCtr!=null){
			var tipoControl = document.getElementById("tipo_control_COD_PROVINCIA");
			if (tipoControl.value == "CMB"){
				DWRUtil.removeAllOptions("control_COD_PROVINCIA");
		    	DWRUtil.addOptions("control_COD_PROVINCIA",{'':'- Seleccione -'});
			}
			else{
				 codProvinciaCtr.value="";
			}
		}		
		
		if (codCiudadCtr!=null){
			var tipoControl = document.getElementById("tipo_control_COD_CIUDAD");
			if (tipoControl.value == "CMB"){
				DWRUtil.removeAllOptions("control_COD_CIUDAD");
		    	DWRUtil.addOptions("control_COD_CIUDAD",{'':'- Seleccione -'});
			}
			else{
				 codCiudadCtr.value="";
			}
		}	
		
		if (codComunaCtr!=null){
			var tipoControl = document.getElementById("tipo_control_COD_COMUNA");
			if (tipoControl.value == "CMB"){
				DWRUtil.removeAllOptions("control_COD_COMUNA");
		    	DWRUtil.addOptions("control_COD_COMUNA",{'':'- Seleccione -'});
			}
			else{
				 codComunaCtr.value="";
			}
		}
			
		if (codTipoCalleCtr!=null){
			var tipoControl = document.getElementById("tipo_control_COD_TIPOCALLE");
			if (tipoControl.value == "CMB"){
				for (index = 0; index< codTipoCalleCtr.length; index++) {
			    	if (codTipoCalleCtr[index].value == "") {codTipoCalleCtr.selectedIndex = index;	break; 	} 
			    }
			}
			else{
				 codTipoCalleCtr.value="";
			}
		}		
		
		if (zipCtr!=null){
			var tipoControl = document.getElementById("tipo_control_ZIP");
			if (tipoControl.value == "CMB"){
				DWRUtil.removeAllOptions("control_ZIP");
		    	DWRUtil.addOptions("control_ZIP",{'':'- Seleccione -'});
			}
			else{
				 zipCtr.value="";
			}
		}	
		
		//otros campos	
		nomCalleCtr.value="";
		numCalleCtr.value="";
		obsDireccionCtr.value="";
		desDirec1Ctr="";
		desDirec2Ctr="";
 	}
 	//(-)-- LIMPIAR --
 	 	 
	function fncVolver(){
	
		if (confirm("¿Desea volver al men\u00FA?")){
			var win = parent
			win.fncActDesacMenu(false);
		
		  	document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}	
	 	 	 		
  	//(+)-- mensajes de error --
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	

	function fncInvocarPaginaExpiraSesion(){
    	document.forms[0].submit();
	}		
  	//(-)-- mensajes de error --	
  	
  	//Inicio P-CSR-11002 JLGN 14-06-2011	
	function fncCursorEspera(){
		//document.body.style.cursor = "[b]wait[/b]";
		document.body.style.cursor='wait';
    }
    function fncCursorNormal(){
		//document.body.style.cursor = "[b]default[/b]";
		document.body.style.cursor='default';
    }	
  	
		
</script>
</head>

<body onload="history.go(+1);fncCargaInicial();" onkeydown="validarTeclas();">
<html:form method="POST" action="/DireccionAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="tipoDireccion" styleId="tipoDireccion"/>
<html:hidden property="COD_REGION" styleId="COD_REGION"/>
<html:hidden property="COD_PROVINCIA" styleId="COD_PROVINCIA"/>
<html:hidden property="COD_CIUDAD" styleId="COD_CIUDAD"/>
<html:hidden property="COD_COMUNA" styleId="COD_COMUNA"/>
<html:hidden property="COD_TIPOCALLE" styleId="COD_TIPOCALLE"/>
<html:hidden property="NOM_CALLE" styleId="NOM_CALLE"/>
<html:hidden property="NUM_CALLE" styleId="NUM_CALLE"/>
<html:hidden property="OBS_DIRECCION" styleId="OBS_DIRECCION"/>
<html:hidden property="ZIP" styleId="ZIP"/>
<html:hidden property="DES_DIREC1" styleId="DES_DIREC1"/>
<html:hidden property="DES_DIREC2" styleId="DES_DIREC2"/>
<html:hidden property="descripcionCOD_REGION" styleId="descripcionCOD_REGION"/>
<html:hidden property="descripcionCOD_PROVINCIA" styleId="descripcionCOD_PROVINCIA"/>
<html:hidden property="descripcionCOD_CIUDAD" styleId="descripcionCOD_CIUDAD"/>
<html:hidden property="descripcionCOD_COMUNA" styleId="descripcionCOD_COMUNA"/>
<html:hidden property="descripcionCOD_TIPOCALLE" styleId="descripcionCOD_TIPOCALLE"/>
<html:hidden property="descripcionZIP" styleId="descripcionZIP"/>
<html:hidden property="moduloOrigen" styleId="moduloOrigen"/>
<html:hidden property="codModuloSolicitudVenta" styleId="codModuloSolicitudVenta"/>

      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
			Direcci&oacute;n       
         </td>            
        </tr>
      </table>
	  <P>
		<table width="100%" border="0" >
		  <tr>
		     <td class="mensajeError"><div id="mensajes" ></div></td>
		  </tr> 
		</table>	  
	  <P>
	  <P>
     
     <%int idConcepto = 1;%>
     <TABLE align="center" width="90%" border=0>
        <tr>
           <td align="left" colspan="2" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
              <bean:define id="descripcionTipoDireccion" name="DireccionForm" property="descripcionTipoDireccion"/>
              <bean:write name="descripcionTipoDireccion"/>
        </td>
	    </tr> 
     
     	<bean:define id="conceptos" name="direccion" type="com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO[]" property="conceptoDireccionDTOs"/>

    	<logic:iterate id="concepto" name="conceptos"  type="com.tmmas.cl.scl.commonbusinessentities.dto.ConceptoDireccionDTO">
    	<tr>
    	<td align="left">
            <bean:write name="concepto" property="caption"/>
			<logic:equal name="concepto" property="obligatoriedad" value="true">(*)</logic:equal>
			
		</td>
		<td align="left">
			<input type="hidden" id="tipo_control_<bean:write name="concepto" property="nombreColumna"/>" value="<bean:write name="concepto" property="tipoControl"/>">
			<input type="hidden" id="es_obligatorio_<bean:write name="concepto" property="nombreColumna"/>" value="<bean:write name="concepto" property="obligatoriedad"/>">						
			<input type="hidden" id="caption_<bean:write name="concepto" property="nombreColumna"/>" value="<bean:write name="concepto" property="caption"/>">						
			
			<bean:define id="tipoControl" name="concepto" property="tipoControl"/>
			<logic:equal name="tipoControl" value="CMB"> 
			
			    <select onchange="ocultarMensajeError();fncOnChangeCMB('<bean:write name="concepto" property="nombreColumna"/>');" id="control_<bean:write name="concepto" property="nombreColumna"/>"  style="width:270px;">
			    <option value="">- Seleccione -</option></select>
			    </select>

			</logic:equal>	
			<logic:equal name="tipoControl" value="TXT"> 
			
				<input type="text" onchange="ocultarMensajeError();" id="control_<bean:write name="concepto" property="nombreColumna"/>" size="51" 
				maxlength="<bean:write name="concepto" property="largoMaximo"/>" 	value=""
				style="text-transform: uppercase;" onblur="upperCase(this);" onkeypress="soloCaracteresValidos();">
				
			</logic:equal>	
		</td>
    	</tr>  
		<%idConcepto++; %>
	    </logic:iterate>
	    
      </TABLE>
     
     
	  
   	 <P>
     <P>
     <P>
     <P>
     <P>
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td align="left" width="25%" >
        </td>
        <td align="left" width="25%" >
        <html:button  value="LIMPIAR" style="width:120px;color:black" property="btnLimpiar" styleId="btnLimpiar" onclick="ocultarMensajeError();fncLimpiar()"/>			
        </td>
        <td align="right" width="25%">
        <html:button  value="CANCELAR" style="width:120px;color:black" property="btnCancelar" styleId="btnCancelar" onclick="fncCursorEspera();ocultarMensajeError();fncCancelar()"/>
        </td>
        <td align="right" width="25%">
        <html:button  value="ACEPTAR" style="width:120px;color:black" property="btnAceptar" styleId="btnAceptar" onclick="fncCursorEspera();ocultarMensajeError();fncAceptar()"/>        

        </td>
      </tr>
    </TABLE> 
    
     <P>    
   <TABLE align="center" width="90%">			
      <tr>
		  <td align="left"><i>(*) :  Dato es obligatorio</i></td>
	  </tr>	   
   </TABLE>    

</html:form>

</body>
</html:html>