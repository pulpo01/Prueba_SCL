package com.tmmas.cl.scl.altacliente.presentacion.action;

import java.rmi.RemoteException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.altacliente.presentacion.delegate.AltaClienteDelegate;
import com.tmmas.cl.scl.altacliente.presentacion.form.BuscaCuentaForm;
import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.exception.AltaClienteException;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class BuscaCuentaAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(BuscaCuentaAction.class);

	private Global global = Global.getInstance();

	AltaClienteDelegate delegate = AltaClienteDelegate.getInstance();

	public ActionForward inicio(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		BuscaCuentaForm buscaCuentaForm = (BuscaCuentaForm) form;
		buscaCuentaForm.setModuloOrigen(global.getValor("modulo.web.altacliente")); 
		logger.trace("buscaCuentaForm.getModuloOrigen(): " + buscaCuentaForm.getModuloOrigen());
		inicializar(request, buscaCuentaForm);
		logger.info("Fin");

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

	public ActionForward inicioVenta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		BuscaCuentaForm buscaCuentaForm = (BuscaCuentaForm) form;
		buscaCuentaForm.setModuloOrigen(global.getValor("modulo.web.solicitudventa"));
		logger.trace("buscaCuentaForm.getModuloOrigen(): " + buscaCuentaForm.getModuloOrigen());
		inicializar(request, buscaCuentaForm);
		
		//P-CSR-11002 09/05/2011 JLGN
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
		//Fin P-CSR-11002 09/05/2011 JLGN

		//P-CSR-11002 JLGN 28-07-2011
		request.getSession().setAttribute("flagLimCred", "false");
		
		logger.info("Fin");
		
		return mapping.findForward("inicio");
	}

	public ActionForward buscarCuentas(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("buscarCuentas, inicio");
		logger.info("buscarCuentas, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward aceptarAlta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptarAlta, inicio");
		request.getSession(false).removeAttribute("listaCuentas");
		logger.info("aceptarAlta, fin");
		
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
		//Fin P-CSR-11002 12/04/2011 JLGN
		//Inicio P-CSR-11002 09-05-2011 JLGN
		request.getSession().setAttribute("flagDataBuro", "false");
		request.getSession().setAttribute("flagOKBuro", "false");
		request.getSession().setAttribute("botonPass", "false");
		//Fin P-CSR-11002 09-05-2011 JLGN
		//P-CSR-11002 JLGN 28-07-2011
		request.getSession().setAttribute("flagLimCred", "false");
		
		return mapping.findForward("aceptarAlta");
	}
	
	public ActionForward aceptarVenta(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("aceptarVenta, inicio");
		request.getSession(false).removeAttribute("listaCuentas");
		logger.info("aceptarVenta, fin");
		
		//Inicio P-CSR-11002 12/04/2011 JLGN
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
		//Fin P-CSR-11002 12/04/2011 JLGN
		//Inicio P-CSR-11002 09-05-2011 JLGN
		request.getSession().setAttribute("flagDataBuro", "false");
		request.getSession().setAttribute("flagOKBuro", "false");
		request.getSession().setAttribute("botonPass", "false");
		//Fin P-CSR-11002 09-05-2011 JLGN
		return mapping.findForward("aceptarVenta");
	}

	public ActionForward cancelar(ActionMapping mapping, ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		logger.info("Inicio");
		String forward = "cancelar";
		BuscaCuentaForm buscaCuentaForm = (BuscaCuentaForm) form;
		if (buscaCuentaForm.getModuloOrigen().equals(global.getValor("modulo.web.solicitudventa"))) {
			forward = "cancelarDatosVenta";
		}
		logger.info("Fin");
		return mapping.findForward(forward);
	}

	private void inicializar(HttpServletRequest request, BuscaCuentaForm buscaCuentaForm) throws AltaClienteException,
			RemoteException {
		// Limpia formulario
		buscaCuentaForm.setCodCriterioBusqueda(null);
		buscaCuentaForm.setCodCuentaSel(null);
		buscaCuentaForm.setCodTipoCuenta(null);
		buscaCuentaForm.setCodTipoCuentaEmpresa(null);
		buscaCuentaForm.setCodTipoCuentaSel(null);
		buscaCuentaForm.setCodTipoIdentificacion(null);
		buscaCuentaForm.setLargoNumCelular(null);
		buscaCuentaForm.setNombreCuenta(null);
		buscaCuentaForm.setNombreResponsable(null);
		buscaCuentaForm.setNumeroDocumento(null);
		buscaCuentaForm.setSeleccionCuenta(null);
		buscaCuentaForm.setTelefonoContacto(null);
		buscaCuentaForm.setTxtFiltro(null);
		request.getSession(false).removeAttribute("listaCuentas");
		String codigoModuloGE = null;
		String valoresTipoCuenta = null;
		String descripcionesTipoCuenta = null;
		codigoModuloGE = global.getValor("codigo.modulo.GE");
		valoresTipoCuenta = global.getValor("tipo.cuenta.valor");
		descripcionesTipoCuenta = global.getValor("tipo.cuenta.descripcion");
		logger.debug("codigo.modulo.GE: " + codigoModuloGE);
		logger.debug("tipo.cuenta.valor: " + valoresTipoCuenta);
		logger.debug("tipo.cuenta.descripcion: " + descripcionesTipoCuenta);
		String[] v = valoresTipoCuenta.split(",");
		String[] d = descripcionesTipoCuenta.split(",");
		DatosGeneralesDTO[] arrayTipoCuenta = new DatosGeneralesDTO[v.length];
		logger.debug("Valores: " + v.length);
		for (int i = 0; i < arrayTipoCuenta.length; i++) {
			DatosGeneralesDTO generalesDTO = new DatosGeneralesDTO();
			generalesDTO.setCodigoValor(v[i]);
			logger.debug("Valor: " + v[i]);
			generalesDTO.setDescripcionValor(d[i]);
			logger.debug("Descripcion: " + d[i]);
			arrayTipoCuenta[i] = generalesDTO;
		}
		buscaCuentaForm.setArrayTipoCuenta(arrayTipoCuenta);
		IdentificadorCivilComDTO[] arrayIdentificadores = delegate.getTipoIdentificadoresCiviles();
		buscaCuentaForm.setArrayIdentificadorCuenta(arrayIdentificadores);

		ParametrosGeneralesDTO parametrosLargoCelular = new ParametrosGeneralesDTO();
		parametrosLargoCelular.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosLargoCelular.setCodigomodulo(codigoModuloGE);
		parametrosLargoCelular.setNombreparametro(global.getValor("parametro.largo_n_celular"));
		String largoNumCelular = "15";
		try {
			parametrosLargoCelular = delegate.getParametroGeneral(parametrosLargoCelular);
			largoNumCelular = parametrosLargoCelular.getValorparametro();
		}
		catch (Exception e) {
		}
		buscaCuentaForm.setLargoNumCelular(largoNumCelular);
		buscaCuentaForm.setCodTipoCuentaEmpresa(global.getValor("tipo.cuenta.empresa"));
		buscaCuentaForm.setCodModuloSolicitudVenta(global.getValor("modulo.web.solicitudventa"));
	}
}
