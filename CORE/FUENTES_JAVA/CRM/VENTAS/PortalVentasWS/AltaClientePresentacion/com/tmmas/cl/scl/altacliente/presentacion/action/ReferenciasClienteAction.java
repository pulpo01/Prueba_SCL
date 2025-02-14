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
import com.tmmas.cl.scl.altacliente.presentacion.form.AltaClienteInicioForm;
import com.tmmas.cl.scl.altacliente.presentacion.form.ReferenciasClienteForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioReferenciaClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;

public class ReferenciasClienteAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(ReferenciasClienteAction.class);

	private Global global = Global.getInstance();

	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("inicio, inicio");
		ReferenciasClienteForm f = (ReferenciasClienteForm) form;
		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(global.getValor("codigo.modulo.GE"));
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		final String codTipoClienteEmpresa = global.getValor("tipo.cliente.empresa");
		logger.debug("codTipoClienteEmpresa [" + codTipoClienteEmpresa + "]");
		f.setCodTipoClienteEmpresa(codTipoClienteEmpresa);
		parametrosLargoCelular = delegate.getParametroGeneral(parametrosLargoCelular);
		f.setLargoNumCelular(parametrosLargoCelular.getValorparametro());
		f.setNumReferencia("0");
		f.setNombreReferencia("");
		f.setPrimerApellido("");
		f.setSegundoApellido("");
		f.setTelefonoReferenciaFijo("");
		f.setTelefonoReferenciaMovil("");
		f.setMaximoReferencias(global.getValor("cantidad.maxima.referencias"));
		HttpSession sesion = request.getSession(false);
		AltaClienteInicioForm aForm = (AltaClienteInicioForm) sesion.getAttribute("AltaClienteInicioForm");
		if (aForm != null) {
			f.setArrayRefCliente(aForm.getArrayRefClienteAlta());
			f.setCodTipoCliente(aForm.getTipoCliente());
			logger.debug("f.getCodTipoCliente() [" + f.getCodTipoCliente() + "]");
		}
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward actualizarListaReferencias(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("actualizarListaReferencias, inicio");

		ReferenciasClienteForm referenciasClienteForm = (ReferenciasClienteForm) form;
		String numReferencia = referenciasClienteForm.getNumReferencia();

		if (numReferencia.equals("0")) {// agregar a lista
			int totalLista = 0;
			int numRef = 0;
			if (referenciasClienteForm.getArrayRefCliente() == null
					|| referenciasClienteForm.getArrayRefCliente().length == 0) {
				numRef = 1;
			}
			else {
				totalLista = referenciasClienteForm.getArrayRefCliente().length;
				numRef = totalLista + 1;
			}

			FormularioReferenciaClienteDTO refNueva = new FormularioReferenciaClienteDTO();
			refNueva.setNombreReferencia(referenciasClienteForm.getNombreReferencia());
			refNueva.setPrimerApellido(referenciasClienteForm.getPrimerApellido());
			refNueva.setSegundoApellido(referenciasClienteForm.getSegundoApellido());
			refNueva.setTelefonoReferenciaFijo(referenciasClienteForm.getTelefonoReferenciaFijo());
			refNueva.setTelefonoReferenciaMovil(referenciasClienteForm.getTelefonoReferenciaMovil());
			refNueva.setNumReferencia(String.valueOf(numRef));

			FormularioReferenciaClienteDTO[] arrayRefClienteNuevo = new FormularioReferenciaClienteDTO[totalLista + 1];
			for (int i = 0; i < totalLista; i++)
				arrayRefClienteNuevo[i] = referenciasClienteForm.getArrayRefCliente()[i];

			int posUltFila = totalLista;
			arrayRefClienteNuevo[posUltFila] = refNueva;
			referenciasClienteForm.setArrayRefCliente(arrayRefClienteNuevo);

		}
		else {// modificar
			for (int i = 0; i < referenciasClienteForm.getArrayRefCliente().length; i++) {
				FormularioReferenciaClienteDTO ref = referenciasClienteForm.getArrayRefCliente()[i];
				if (ref.getNumReferencia().equals(numReferencia)) {
					ref.setNombreReferencia(referenciasClienteForm.getNombreReferencia());
					ref.setPrimerApellido(referenciasClienteForm.getPrimerApellido());
					ref.setSegundoApellido(referenciasClienteForm.getSegundoApellido());
					ref.setTelefonoReferenciaFijo(referenciasClienteForm.getTelefonoReferenciaFijo());
					ref.setTelefonoReferenciaMovil(referenciasClienteForm.getTelefonoReferenciaMovil());
				}
			}
		}

		// limpia campos
		referenciasClienteForm.setNumReferencia("0");
		referenciasClienteForm.setNombreReferencia("");
		referenciasClienteForm.setPrimerApellido("");
		referenciasClienteForm.setSegundoApellido("");
		referenciasClienteForm.setTelefonoReferenciaFijo("");
		referenciasClienteForm.setTelefonoReferenciaMovil("");
		logger.info("actualizarListaReferencias, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward eliminarReferencia(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("eliminarReferencia");

		ReferenciasClienteForm referenciasClienteForm = (ReferenciasClienteForm) form;
		String numReferencia = referenciasClienteForm.getNumReferencia();

		int totalLista = referenciasClienteForm.getArrayRefCliente().length;
		int totalNuevaLista = totalLista - 1;
		FormularioReferenciaClienteDTO[] arrayRefClienteNuevo = new FormularioReferenciaClienteDTO[(totalNuevaLista)];
		int correlativo = 1;
		int indiceNuevaLista = 0;
		for (int i = 0; i < totalLista; i++) {
			if (!referenciasClienteForm.getArrayRefCliente()[i].getNumReferencia().equals(numReferencia)) {
				arrayRefClienteNuevo[indiceNuevaLista] = referenciasClienteForm.getArrayRefCliente()[i];
				arrayRefClienteNuevo[indiceNuevaLista].setNumReferencia(String.valueOf(correlativo));
				indiceNuevaLista++;
				correlativo++;
			}
		}

		referenciasClienteForm.setArrayRefCliente(arrayRefClienteNuevo);
		// limpia campos
		referenciasClienteForm.setNumReferencia("0");
		referenciasClienteForm.setNombreReferencia("");
		referenciasClienteForm.setPrimerApellido("");
		referenciasClienteForm.setSegundoApellido("");
		referenciasClienteForm.setTelefonoReferenciaFijo("");
		referenciasClienteForm.setTelefonoReferenciaMovil("");

		logger.info("eliminarReferencia");
		return mapping.findForward("inicio");
	}

	public ActionForward aceptar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptar");
		ReferenciasClienteForm f = (ReferenciasClienteForm) form;
		HttpSession sesion = request.getSession(false);

		AltaClienteInicioForm AltaClienteInicioForm = (AltaClienteInicioForm) sesion
				.getAttribute("AltaClienteInicioForm");
		if (AltaClienteInicioForm != null) {
			AltaClienteInicioForm.setArrayRefClienteAlta(f.getArrayRefCliente());
		}

		logger.info("aceptar");
		return mapping.findForward("aceptar");
	}

	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("cancelar");
		ReferenciasClienteForm referenciasClienteForm = (ReferenciasClienteForm) form;
		referenciasClienteForm.setArrayRefCliente(null);
		logger.info("cancelar");
		return mapping.findForward("cancelar");
	}

}
