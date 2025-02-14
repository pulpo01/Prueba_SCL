package com.tmmas.cl.scl.portalventas.web.action;

import java.rmi.RemoteException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.BuscaClienteForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class BuscaClienteAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(BuscaClienteAction.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public ActionForward inicioVenta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		BuscaClienteForm buscaClienteForm = (BuscaClienteForm) form;
		buscaClienteForm.setModuloOrigen(global.getValor("modulo.web.solicitudventa"));
		inicializar(request, buscaClienteForm);
		logger.info("inicio, fin");

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

	public ActionForward inicioConsulta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		BuscaClienteForm buscaClienteForm = (BuscaClienteForm) form;
		buscaClienteForm.setModuloOrigen(global.getValor("modulo.web.consultaventa"));
		inicializar(request, buscaClienteForm);
		logger.info("inicio, fin");
		
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

	public ActionForward inicioScoring(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		BuscaClienteForm buscaClienteForm = (BuscaClienteForm) form;
		buscaClienteForm.setModuloOrigen(global.getValor("modulo.web.scoring"));
		inicializar(request, buscaClienteForm);
		logger.info("inicio, fin");
		
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

	public ActionForward buscarClientes(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("buscarClientes, inicio");
		BuscaClienteForm f = (BuscaClienteForm) form;
		f.setMensajeError("");
		logger.info("buscarClientes, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward aceptar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptar, inicio");
		BuscaClienteForm f = (BuscaClienteForm) form;
		ClienteAjaxDTO clienteSel = new ClienteAjaxDTO();
		HttpSession sesion = request.getSession(false);
		ClienteAjaxDTO[] listaClientes = (ClienteAjaxDTO[]) sesion.getAttribute("listaClientes");

		if (listaClientes != null) {
			// buscar clienteSeleccionado
			for (int i = 0; i < listaClientes.length; i++) {
				final ClienteAjaxDTO clienteAjaxDTO = listaClientes[i];
				if (clienteAjaxDTO.getCodigoCliente().equals(f.getCodClienteSel())) {
					clienteSel.setTipoCliente(clienteAjaxDTO.getTipoCliente());
					clienteSel.setGlsTipoCliente(clienteAjaxDTO.getGlsTipoCliente());
					clienteSel.setCodigoCliente(clienteAjaxDTO.getCodigoCliente());
					clienteSel.setCodCrediticia(clienteAjaxDTO.getCodCrediticia());
					clienteSel.setMontoPreAutorizado(clienteAjaxDTO.getMontoPreAutorizado());
					clienteSel.setCodigoTipoIdentificacion(clienteAjaxDTO.getCodigoTipoIdentificacion());
					clienteSel.setNumeroIdentificacion(clienteAjaxDTO.getNumeroIdentificacion());
					clienteSel.setNombreCliente(clienteAjaxDTO.getNombreCliente());
					clienteSel.setNombreApellido1(clienteAjaxDTO.getNombreApellido1());
					clienteSel.setNombreApellido2(clienteAjaxDTO.getNombreApellido2());
					clienteSel.setNumeroTelefono1(clienteAjaxDTO.getNumeroTelefono1());
					clienteSel.setCodCalificacion(clienteAjaxDTO.getCodCalificacion());
					clienteSel.setDescripcionColor(clienteAjaxDTO.getDescripcionColor());
					clienteSel.setDescripcionSegmento(clienteAjaxDTO.getDescripcionSegmento());
					clienteSel.setDesTipoIdentificacion(clienteAjaxDTO.getDesTipoIdentificacion());
					break;
				}// fin if
			}// fin for
		}// fin if (listaClientes!=null){

		sesion.removeAttribute("listaClientes");
		sesion.setAttribute("clienteSel", clienteSel);

		String forward = "aceptarConsulta";
		if (f.getModuloOrigen().equals(global.getValor("modulo.web.solicitudventa"))) {
			forward = "aceptarVenta";
		}
		else if (f.getModuloOrigen().equals(global.getValor("modulo.web.scoring"))) {
			forward = "aceptarScoring";
		}
		logger.debug("forward [" + forward + "]");
		logger.info("aceptar, fin");
		return mapping.findForward(forward);
	}

	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("cancelar, inicio");
		String forward = "cancelarConsulta";
		BuscaClienteForm buscaClienteForm = (BuscaClienteForm) form;
		if (buscaClienteForm.getModuloOrigen().equals(global.getValor("modulo.web.solicitudventa"))) {
			forward = "cancelarVenta";
		}
		if (buscaClienteForm.getModuloOrigen().equals(global.getValor("modulo.web.scoring"))) {
			forward = "cancelarScoring";
		}
		// limpia pantalla
		HttpSession sesion = request.getSession(false);
		sesion.removeAttribute("listaClientes");
		buscaClienteForm.setCodClienteSel("");
		buscaClienteForm.setCodTipoCliente("");
		buscaClienteForm.setCodCriterioBusqueda("");
		logger.debug("cancelar, fin");
		return mapping.findForward(forward);
	}

	public ActionForward irAMenu(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.debug("irAMenu, inicio");
		logger.debug("irAMenu, fin");
		return mapping.findForward("irAMenu");
	}

	private void inicializar(HttpServletRequest request, BuscaClienteForm buscaClienteForm)
			throws AltaClienteException, RemoteException {
		// (+)-- Carga de listas --
		// Tipo de Clientes
		if (buscaClienteForm.getArrayTipoCliente() == null) {
			DatosGeneralesDTO datosGenerales = new DatosGeneralesDTO();
			datosGenerales.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			datosGenerales.setTabla(global.getValor("tabla.clientes"));
			datosGenerales.setColumna(global.getValor("columna.tipo.cliente"));
			DatosGeneralesDTO[] arrayTipoCliente = delegate.getListCodigo(datosGenerales);
			buscaClienteForm.setArrayTipoCliente(arrayTipoCliente);
		}
		// Tipo identificacion
		if (buscaClienteForm.getArrayIdentificadorCliente() == null) {
			IdentificadorCivilComDTO[] arrayIdentificadores = delegate.getTipoIdentificadoresCiviles();
			buscaClienteForm.setArrayIdentificadorCliente(arrayIdentificadores);
		}
		// (-)-- Carga de listas --

		// Actualiza cliente ya ingresado
		HttpSession sesion = request.getSession(false);
		if (sesion.getAttribute("clienteSel") != null) {
			ClienteAjaxDTO clienteSel = (ClienteAjaxDTO) sesion.getAttribute("clienteSel");
			buscaClienteForm.setCodTipoClienteSel(clienteSel.getTipoCliente());
			buscaClienteForm.setCodClienteSel(clienteSel.getCodigoCliente());
		}
		buscaClienteForm.setCodModuloSolicitudVenta(global.getValor("modulo.web.solicitudventa"));
		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		String largoNumCelular = "15"; //Por defecto
		try {
			parametrosLargoCelular = delegate.getParametroGeneral(parametrosLargoCelular);
			largoNumCelular = parametrosLargoCelular.getValorparametro();
		}
		catch (Exception e) {
		}
		buscaClienteForm.setLargoNumCelular(largoNumCelular);
		buscaClienteForm.setCodTipoClienteEmpresa(global.getValor("tipo.cliente.empresa"));
	}
}
