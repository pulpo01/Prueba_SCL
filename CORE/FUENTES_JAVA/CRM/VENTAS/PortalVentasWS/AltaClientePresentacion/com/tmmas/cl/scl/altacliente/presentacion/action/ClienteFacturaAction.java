package com.tmmas.cl.scl.altacliente.presentacion.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.form.ClienteFacturaForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.DatosEmpresaForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;

public class ClienteFacturaAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(ClienteFacturaAction.class);
	private Global global = Global.getInstance();
	
	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();	
	
	public ActionForward inicioAlta(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("inicioAlta,inicio");
		ClienteFacturaForm clienteFacturaForm = (ClienteFacturaForm)form;
		clienteFacturaForm.setModuloOrigen(global.getValor("modulo.web.altacliente"));
		
		inicializar(request,clienteFacturaForm);
		logger.info("inicioAlta,fin");		
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		return mapping.findForward("inicio");
	}
	
	public ActionForward inicioVenta(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("inicioVenta,inicio");
		ClienteFacturaForm clienteFacturaForm = (ClienteFacturaForm)form;
		clienteFacturaForm.setModuloOrigen(global.getValor("modulo.web.solicitudventa"));
		
		inicializar(request,clienteFacturaForm);
		logger.info("inicioVenta,fin");		
		
		//P-CSR-11002 12/04/2011 JLGN
		logger.debug("RA-11002");
		String cedulaIdentidad = global.getValorExterno("modulo.web.cedula.identidad");
		logger.debug("cedulaIdentidad: "+ cedulaIdentidad);
		request.getSession().setAttribute("cedulaIdentidad", cedulaIdentidad);
		
		String cedulaJuridica = global.getValorExterno("modulo.web.cedula.juridica");
		logger.debug("cedulaJuridica: "+ cedulaJuridica);
		request.getSession().setAttribute("cedulaJuridica", cedulaJuridica);
		
		String cedulaOtras = global.getValorExterno("modulo.web.cedula.otras");
		logger.debug("cedulaOtras: "+ cedulaOtras);
		request.getSession().setAttribute("cedulaOtras", cedulaOtras);
		
		return mapping.findForward("inicio");
	}
	
	public ActionForward aceptar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("aceptar,inicio");
		String forward ="aceptarAlta";
		ClienteFacturaForm clienteFacturaForm = (ClienteFacturaForm)form;
		HttpSession sesion =  request.getSession(false);
		
		if (clienteFacturaForm.getModuloOrigen().equals(global.getValor("modulo.web.solicitudventa"))){
			forward = "aceptarVenta";
		}
		
		sesion.removeAttribute("clienteFacturaFormInicio");
		logger.info("aceptar,fin");
		return mapping.findForward(forward);
	}
	
	public ActionForward cancelar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.info("cancelar,inicio");
		String forward ="cancelarAlta";
		ClienteFacturaForm clienteFacturaForm = (ClienteFacturaForm)form;
		HttpSession sesion =  request.getSession(false);
		
		if (clienteFacturaForm.getModuloOrigen().equals(global.getValor("modulo.web.solicitudventa"))){
			forward = "cancelarVenta";
		}
		
		ClienteFacturaForm clienteFacturaFormInicio = (ClienteFacturaForm)sesion.getAttribute("clienteFacturaFormInicio");
		//vuelve a setear datos originales
		clienteFacturaForm.setApellido1ClienteFactura(clienteFacturaFormInicio.getApellido1ClienteFactura());
		clienteFacturaForm.setApellido2ClienteFactura(clienteFacturaFormInicio.getApellido2ClienteFactura());
		clienteFacturaForm.setNombreClienteFactura(clienteFacturaFormInicio.getNombreClienteFactura());
		clienteFacturaForm.setNumeroIdentClienteFactura(clienteFacturaFormInicio.getNumeroIdentClienteFactura());
		clienteFacturaForm.setTipoIdentClienteFactura(clienteFacturaFormInicio.getTipoIdentClienteFactura());
		sesion.removeAttribute("clienteFacturaFormInicio");
		
		logger.info("cancelar,fin");
		return mapping.findForward(forward);
	}
	
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("irAMenu, inicio");
		logger.debug("irAMenu, fin");
		
		return mapping.findForward("irAMenu");
	}	
	
	private void inicializar(HttpServletRequest request,
			ClienteFacturaForm clienteFacturaForm) throws Exception {
		HttpSession sesion =  request.getSession(false);
		
		//Tipo identificacion
		if (clienteFacturaForm.getArrayIdentificadorCliente()==null){
			IdentificadorCivilComDTO[] arrayIdentificadores = delegate.getTipoIdentificadoresCiviles();
			clienteFacturaForm.setArrayIdentificadorCliente(arrayIdentificadores);
		}
		
		clienteFacturaForm.setCodModuloSolicitudVenta(global.getValor("modulo.web.solicitudventa"));
		
		//guarda formulario inicial
		ClienteFacturaForm clienteFacturaFormInicio = new ClienteFacturaForm();
		clienteFacturaFormInicio.setApellido1ClienteFactura(clienteFacturaForm.getApellido1ClienteFactura());
		clienteFacturaFormInicio.setApellido2ClienteFactura(clienteFacturaForm.getApellido2ClienteFactura());
		clienteFacturaFormInicio.setNombreClienteFactura(clienteFacturaForm.getNombreClienteFactura());
		clienteFacturaFormInicio.setNumeroIdentClienteFactura(clienteFacturaForm.getNumeroIdentClienteFactura());
		clienteFacturaFormInicio.setTipoIdentClienteFactura(clienteFacturaForm.getTipoIdentClienteFactura());
		sesion.setAttribute("clienteFacturaFormInicio", clienteFacturaFormInicio);
	}
}
