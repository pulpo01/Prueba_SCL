package com.tmmas.cl.scl.direccion.presentacion.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.direccion.presentacion.delegate.DireccionDelegate;
import com.tmmas.cl.scl.direccion.presentacion.form.DireccionForm;
import com.tmmas.cl.scl.direccion.presentacion.helper.Global;


public class DireccionAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(DireccionAction.class);
	private Global global = Global.getInstance();
	
	DireccionDelegate delegate = DireccionDelegate.getInstance();
	
	public ActionForward aceptar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("aceptar, inicio");
		String  forward = "cargarDireccionAlta";
		
		DireccionForm direccionForm = (DireccionForm) form;
		FormularioDireccionDTO direccionAux = new FormularioDireccionDTO();
		
		direccionAux.setCOD_REGION(direccionForm.getCOD_REGION());
		direccionAux.setCOD_PROVINCIA(direccionForm.getCOD_PROVINCIA());
		direccionAux.setCOD_CIUDAD(direccionForm.getCOD_CIUDAD());
		direccionAux.setCOD_COMUNA(direccionForm.getCOD_COMUNA());
		direccionAux.setCOD_TIPOCALLE(direccionForm.getCOD_TIPOCALLE());
		direccionAux.setNOM_CALLE(direccionForm.getNOM_CALLE());
		direccionAux.setNUM_CALLE(direccionForm.getNUM_CALLE());
		direccionAux.setOBS_DIRECCION(direccionForm.getOBS_DIRECCION());
		direccionAux.setZIP(direccionForm.getZIP());
		direccionAux.setDES_DIREC1(direccionForm.getDES_DIREC1());
		direccionAux.setDescripcionCOD_REGION(direccionForm.getDescripcionCOD_REGION());
		direccionAux.setDescripcionCOD_PROVINCIA(direccionForm.getDescripcionCOD_PROVINCIA());
		direccionAux.setDescripcionCOD_CIUDAD(direccionForm.getDescripcionCOD_CIUDAD());
		direccionAux.setDescripcionCOD_COMUNA(direccionForm.getDescripcionCOD_COMUNA());
		direccionAux.setDescripcionCOD_TIPOCALLE(direccionForm.getDescripcionCOD_TIPOCALLE());
		direccionAux.setDescripcionZIP(direccionForm.getDescripcionZIP());
		direccionAux.setTipoDireccion(direccionForm.getTipoDireccion());
		direccionAux.setDES_DIREC2(direccionForm.getDES_DIREC2());
		
		logger.debug("moduloOrigen[: " + direccionForm.getModuloOrigen() + "]");		
		
		//Deja información de dirección en sesion
		request.getSession(false).setAttribute("FormularioDireccionDTO", direccionAux);
		
		if (direccionForm.getModuloOrigen().trim().equals(global.getValor("modulo.web.solicitudventa").trim())){
			forward = "cargarDireccionVenta";
		}
		else if (direccionForm.getModuloOrigen().trim().equals(global.getValor("modulo.web.pasillo.ldi").trim()))	{
			forward = "cargarDireccionPasilloLDI";
		}else if (direccionForm.getModuloOrigen().trim().equals(global.getValor("modulo.web.scoring").trim()))	{
			forward = "cargarDireccionVentaScoring";
		}
		
		logger.debug("forward: " + forward);
		logger.info("aceptar, fin");
		return mapping.findForward(forward);
	}
	
	public ActionForward cancelar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("cancelar, inicio");
		String  forward = "cancelarAlta";
		
		DireccionForm direccionForm = (DireccionForm) form;
		
		String moduloOrigen = direccionForm.getModuloOrigen();
		logger.debug("direccionForm.getModuloOrigen(): " + moduloOrigen);
		
		if (moduloOrigen != null)
		{
			if (moduloOrigen.equals(global.getValor("modulo.web.solicitudventa"))){
				forward = "cancelarVenta";
			}
			
			if (moduloOrigen.equals(global.getValor("modulo.web.pasillo.ldi"))){
				forward = "cancelarClienteCarrierPasilloLDI";
			}
			
			if (direccionForm.getModuloOrigen().trim().equals(global.getValor("modulo.web.scoring").trim()))	{
				forward = "cancelarScoring";
			}
		}
		logger.info("cancelar, fin");
		return mapping.findForward(forward);
	}

	public ActionForward cargarDireccionPersonal(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("cargarDireccionPersonal, inicio");
		
		FormularioDireccionDTO direccionPersonalForm = (FormularioDireccionDTO)request.getSession(false).getAttribute("FormularioDireccionDTOSeleccionado");
		
		inicializar(form, direccionPersonalForm,request, "PERS",
				global.getValor("descripcion.tipo.direccion.PERS"), global.getValor("modulo.web.altacliente"));
		
		logger.info("cargarDireccionPersonal, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward cargarDireccionFacturacion(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("cargarDireccionFacturacion, inicio");
		
		FormularioDireccionDTO direccionFacturacionForm = (FormularioDireccionDTO)request.getSession(false).getAttribute("FormularioDireccionDTOSeleccionado");
		
		inicializar(form, direccionFacturacionForm,request, "FACT",
				global.getValor("descripcion.tipo.direccion.FACT"), global.getValor("modulo.web.altacliente"));
		
		logger.info("cargarDireccionFacturacion, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward inicioDireccionFacturacionPasilloLDI(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("inicioDireccionFacturacionPasilloLDI, inicio");
		FormularioDireccionDTO direccionFacturacionDTO = (FormularioDireccionDTO)request.getSession(false).getAttribute("FormularioDireccionDTOSeleccionado");
		String moduloPasilloLDI = global.getValor("modulo.web.pasillo.ldi");
		logger.debug("moduloPasilloLDI: "+ moduloPasilloLDI);
		String descFACT = global.getValor("descripcion.tipo.direccion.FACT");
		logger.debug("descFACT: "+ descFACT);
		inicializar(form, direccionFacturacionDTO, request, "FACT", descFACT, moduloPasilloLDI);
		logger.info("inicioDireccionFacturacionPasilloLDI, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward cargarDireccionCorrespondencia(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("cargarDireccionCorrespondencia, inicio");

		FormularioDireccionDTO direccionCorrespondenciaForm = (FormularioDireccionDTO)request.getSession(false).getAttribute("FormularioDireccionDTOSeleccionado");

		inicializar(form, direccionCorrespondenciaForm, request, "CORR",
				global.getValor("descripcion.tipo.direccion.CORR"), global.getValor("modulo.web.altacliente"));
		logger.info("cargarDireccionCorrespondencia, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward cargarDireccionPersonalUsuario(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("cargarDireccionPersonalUsuario, inicio");
		
		FormularioDireccionDTO direccionPersonalUsuario = (FormularioDireccionDTO)request.getSession(false).getAttribute("FormularioDireccionDTOSeleccionado");
		String codModuloOrigen = (String)request.getSession(false).getAttribute("CodModuloOrigen");
	
		inicializar(form, direccionPersonalUsuario, request, "PERS_USU",
				global.getValor("descripcion.tipo.direccion.PERS"), codModuloOrigen); //Modulo de origen correspondiente a solicitud de venta / scoring
		
		logger.info("cargarDireccionPersonalUsuario, fin");
		return mapping.findForward("inicio");
	}
	
	public ActionForward cargarDireccionInstalacionUsuario(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		logger.info("cargarDireccionInstalacionUsuario, inicio");

		FormularioDireccionDTO direccionInstalacionUsuario = (FormularioDireccionDTO)request.getSession(false).getAttribute("FormularioDireccionDTOSeleccionado");
		String codModuloOrigen = (String)request.getSession(false).getAttribute("CodModuloOrigen");
		
		inicializar(form, direccionInstalacionUsuario, request, "INST_USU",
				global.getValor("descripcion.tipo.direccion.INST"), codModuloOrigen);//Modulo de origen correspondiente a solicitud de venta / scoring
	
		logger.info("cargarDireccionInstalacionUsuario, fin");
		return mapping.findForward("inicio");
	}	
	
	private void inicializar(ActionForm form, FormularioDireccionDTO direccionAux, HttpServletRequest request,
			 String tipoDireccion, String descripcionDireccion, String moduloOrigen) throws Exception{
		logger.info("inicializar, inicio");
		DireccionForm direccionForm = (DireccionForm) form;
		
		request.getSession().removeAttribute("FormularioDireccionDTO");
		request.getSession().removeAttribute("FormularioDireccionDTOSeleccionado");
		
		direccionForm.setTipoDireccion(tipoDireccion);
		direccionForm.setDescripcionTipoDireccion(descripcionDireccion);
		direccionForm.setModuloOrigen(moduloOrigen);
		
		DireccionDTO direccionDTO = null;
		direccionDTO = delegate.getDatosDireccion(direccionDTO);
		request.getSession().setAttribute("direccionDTO", direccionDTO);
		
		if (direccionAux==null){
			direccionForm.setCOD_REGION("");
			direccionForm.setCOD_PROVINCIA("");
			direccionForm.setCOD_CIUDAD("");
			direccionForm.setCOD_COMUNA("");
			direccionForm.setCOD_TIPOCALLE("");
			direccionForm.setNOM_CALLE("");
			direccionForm.setNUM_CALLE("");
			direccionForm.setOBS_DIRECCION("");
			direccionForm.setZIP("");
			direccionForm.setDES_DIREC1("");
			direccionForm.setDES_DIREC2("");
		}else{
			direccionForm.setCOD_REGION(direccionAux.getCOD_REGION().trim());
			direccionForm.setCOD_PROVINCIA(direccionAux.getCOD_PROVINCIA().trim());
			direccionForm.setCOD_CIUDAD(direccionAux.getCOD_CIUDAD().trim());
			direccionForm.setCOD_COMUNA(direccionAux.getCOD_COMUNA().trim());
			direccionForm.setCOD_TIPOCALLE(direccionAux.getCOD_TIPOCALLE().trim());
			direccionForm.setNOM_CALLE(direccionAux.getNOM_CALLE().trim());
			direccionForm.setNUM_CALLE(direccionAux.getNUM_CALLE().trim());
			direccionForm.setOBS_DIRECCION(direccionAux.getOBS_DIRECCION().trim());
			direccionForm.setZIP(direccionAux.getZIP().trim());
			direccionForm.setDES_DIREC1(direccionAux.getDES_DIREC1().trim());
			direccionForm.setDES_DIREC2(direccionAux.getDES_DIREC2().trim());
		}

		direccionForm.setCodModuloSolicitudVenta(global.getValor("modulo.web.solicitudventa"));
		
		logger.info("inicializar, fin");
	}
	
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("irAMenu, inicio");
		logger.debug("irAMenu, fin");
		
		return mapping.findForward("irAMenu");
	}	
}
