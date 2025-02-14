/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/09/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.SolicitudAutDescuentoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class SolicitudAutDescuentoAction extends BaseAction {
	private final Logger logger = Logger.getLogger(CargaPdfAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private final String SIGUIENTE = "control";
	private final String ANTERIOR = "control";

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		HttpSession session = request.getSession(false);
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		
		SolicitudAutDescuentoForm  solicitudAutDescuentoForm = (SolicitudAutDescuentoForm)form;
		
		if (!solicitudAutDescuentoForm.isFlgIniciado()){
			solicitudAutDescuentoForm.setFlgIniciado(true);
			String estadoSolicitudPendiente = global.getValor("estado.solicitud.pendiente");
			String estadoSolicitudAutorizada = global.getValor("estado.solicitud.autorizada");
			String estadoSolicitudCancelada = global.getValor("estado.solicitud.cancelada");
			solicitudAutDescuentoForm.setEstadoSolicitudPendiente(estadoSolicitudPendiente);
			solicitudAutDescuentoForm.setEstadoSolicitudAutorizada(estadoSolicitudAutorizada);
			solicitudAutDescuentoForm.setEstadoSolicitudCancelada(estadoSolicitudCancelada);
			solicitudAutDescuentoForm.setNumAutorizacion("");
			solicitudAutDescuentoForm.setEstadoSolicitud("");
			solicitudAutDescuentoForm.setEstadoSolicitudGlosa("");
		}
		
		if (solicitudAutDescuentoForm.getAccion().equalsIgnoreCase("Solicitar")){
			solicitudAutDescuentoForm.setAccion(" ");
		    RegistroSolicitudListDTO registro = new RegistroSolicitudListDTO();
		    RespuestaSolicitudDTO respuesta = new RespuestaSolicitudDTO();
		    registro = (RegistroSolicitudListDTO)session.getAttribute("RegistroSolicitudListDTO");
		    
		    UsuarioDTO usuario = new UsuarioDTO();
	        usuario.setNombre(sessionData.getUsuario());
	        logger.debug("obtenerVendedor():antes");
	        usuario = delegate.obtenerVendedor(usuario);


		    
		    TablaCargosDTO[] tablaCargosDTO = null;
		    tablaCargosDTO = cargosForm.getTablaCargos();
		    RegistroSolicitudListDTO listaSol = new RegistroSolicitudListDTO();
		    RegistroSolicitudDTO[] lista = new RegistroSolicitudDTO[tablaCargosDTO.length];
		    
		    for(int i = 0; i<tablaCargosDTO.length;i++){
		    	lista[i]= new RegistroSolicitudDTO();
		    	
		    	logger.debug("NumVenta[" + cargosForm.getNumVenta() + "]");
		    	if(usuario.getCodOficina()!=null)
		    		logger.debug("CodOficina[" + usuario.getCodOficina() + "]");
		    	logger.debug("Codigo[" + usuario.getCodigo() + "]");
		    	if(tablaCargosDTO[i].getCantidad()!=null)
		    		logger.debug("Cantidad[" + tablaCargosDTO[i].getCantidad() + "]");
		    	if(tablaCargosDTO[i].getImporteTotalOriginal()!=null)
		    		logger.debug("ImporteTotalOriginal[" + tablaCargosDTO[i].getImporteTotalOriginal() + "]");
		    	logger.debug("CodCliente[" + sessionData.getCliente().getCodCliente() + "]");
		    	if(cargosForm.getCbModPago()!=null)
		    		logger.debug("CbModPago[" + cargosForm.getCbModPago() + "]");
		    	if(usuario.getNombre()!=null)
		    		logger.debug("Nombre[" + usuario.getNombre() + "]");
		    	if(tablaCargosDTO[i].getCodConcepto()!=null)
		    		logger.debug("CodConcepto[" + tablaCargosDTO[i].getCodConcepto() + "]");
		    	    	
		    	
		    	lista[i].setNumeroVenta(cargosForm.getNumVenta());
		    	lista[i].setCodigoOficina(usuario.getCodOficina());
		    	lista[i].setCodigoVendedor(usuario.getCodigo());
		    	lista[i].setNumeroUnidades(Long.valueOf(tablaCargosDTO[i].getCantidad()).longValue());
		    	lista[i].setPrecioOrigen(Float.parseFloat(tablaCargosDTO[i].getImporteTotalOriginal()));
		    	lista[i].setIndicadorTipoVenta(1);
		    	lista[i].setCodigoCliente(sessionData.getCliente().getCodCliente());
		    	lista[i].setCodigoModalidadVenta(Integer.parseInt(cargosForm.getCbModPago()));
		    	lista[i].setNombreUsuarioVenta(usuario.getNombre());
		    	lista[i].setCodigoConcepto(Integer.parseInt(tablaCargosDTO[i].getCodConcepto()));
		    	lista[i].setImporteCargo(Float.parseFloat(tablaCargosDTO[i].getImporteTotalOriginal()));
		    	
		    	lista[i].setNumeroSerie(""); 
		    	if(tablaCargosDTO[i].getCodConceptoDescuento()!=null&&
		    			((tablaCargosDTO[i].getDescuentoUnitarioMan()!=null&&
		    			!tablaCargosDTO[i].getDescuentoUnitarioMan().equalsIgnoreCase(""))||
		    					(tablaCargosDTO[i].getDescuentoUnitarioAut()!=null&&
		    					!tablaCargosDTO[i].getDescuentoUnitarioAut().equalsIgnoreCase("")))){
		    		lista[i].setCodigoConceptoDescuento(Integer.parseInt(tablaCargosDTO[i].getCodConceptoDescuento()));
		    	}else{
		    		lista[i].setCodigoConceptoDescuento(0);
		    	}
		    	lista[i].setValorDescuento((Float.parseFloat(tablaCargosDTO[i].getSaldo())-Float.parseFloat(tablaCargosDTO[i].getImporteTotal()))*-1);
		    	lista[i].setTipoDescuento(1);
		    }
		    
		    listaSol.setSolicitudes(lista);
		    registro = listaSol;
		    if(registro != null){
				respuesta = delegate.solicitarAprobacionDescuento(registro);
				long numAutorizacion = respuesta.getNumeroAutorizacion();
				logger.debug("numAutorizacion:"+numAutorizacion);
				solicitudAutDescuentoForm.setNumAutorizacion(String.valueOf(numAutorizacion));
				solicitudAutDescuentoForm.setEstadoSolicitud(solicitudAutDescuentoForm.getEstadoSolicitudPendiente());
				solicitudAutDescuentoForm.setEstadoSolicitudGlosa(global.getValor("desc.estado.solicitud.PD"));
		    }
		}
		
		if (solicitudAutDescuentoForm.getAccion().equalsIgnoreCase("ConsultarEstado")){
			solicitudAutDescuentoForm.setAccion(" ");
			RegistroSolicitudDTO registro = new RegistroSolicitudDTO();
			registro.setNumeroAutorizacion(Long.parseLong(solicitudAutDescuentoForm.getNumAutorizacion()));
			registro = delegate.consultarEstadoSolicitud(registro);
			
			String glosaEstado = " ";
			if (registro.getCodigoEstado().equals(solicitudAutDescuentoForm.getEstadoSolicitudPendiente())){
				glosaEstado = global.getValor("desc.estado.solicitud.PD");
			}
			else if (registro.getCodigoEstado().equals(solicitudAutDescuentoForm.getEstadoSolicitudAutorizada())){
				glosaEstado = global.getValor("desc.estado.solicitud.AU");
			}
			else if (registro.getCodigoEstado().equals(solicitudAutDescuentoForm.getEstadoSolicitudCancelada())){
				glosaEstado = global.getValor("desc.estado.solicitud.CA");
			}
			solicitudAutDescuentoForm.setEstadoSolicitud(registro.getCodigoEstado());
			solicitudAutDescuentoForm.setEstadoSolicitudGlosa(glosaEstado);
		}
		
		session.setAttribute("ultimaPagina","SolicDescuento");
		
		
		
		if(solicitudAutDescuentoForm.getAccion().equalsIgnoreCase("Siguiente")){
			solicitudAutDescuentoForm.setAccion("");
			session.setAttribute("accionAutDesc","Siguiente");
			return mapping.findForward(SIGUIENTE);
		}
		
		if(solicitudAutDescuentoForm.getAccion().equalsIgnoreCase("Anterior")){
			solicitudAutDescuentoForm.setAccion("");
			if(cargosForm.getNumVenta()!=0&&solicitudAutDescuentoForm.getNumAutorizacion()!=null&&!solicitudAutDescuentoForm.getNumAutorizacion().equalsIgnoreCase("")){
				RegistroSolicitudDTO registro = new RegistroSolicitudDTO();
				registro.setNumeroVenta(cargosForm.getNumVenta());
				registro.setNumeroAutorizacion(Long.valueOf(solicitudAutDescuentoForm.getNumAutorizacion()).longValue());
				delegate.eliminarSolicitud(registro);
			}
			
			session.setAttribute("accionAutDesc","Atras");
			return mapping.findForward(ANTERIOR);
		}
		
		logger.debug("execute():fin");
		return mapping.findForward("solicitudAut");
	}

}
