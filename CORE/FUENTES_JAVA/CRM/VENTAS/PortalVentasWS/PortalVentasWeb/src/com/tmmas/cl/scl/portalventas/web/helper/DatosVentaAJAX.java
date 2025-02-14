package com.tmmas.cl.scl.portalventas.web.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ModalidadPagoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ContratoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ContratoAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoBusquedaVendedorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoValorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.VendedorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;

public class DatosVentaAJAX {
	private final Logger logger = Logger.getLogger(DatosVentaAJAX.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	/*
	 * Carga la lista de distribuidores dependiendo de la oficina y del tipo comisionista seleccionado
	 */
	public RetornoListaAjaxDTO obtenerDistribuidores(String codOficina, String codTipoComisionista) {
		logger.debug("obtenerDistribuidores:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		VendedorAjaxDTO[] listaRetorno = null;
		VendedorDTO[] listaDistribuidores = null;
		try {
			VendedorDTO vendedorDTO = new VendedorDTO();
			vendedorDTO.setCodigoOficina(codOficina);
			vendedorDTO.setCodTipComisionista(codTipoComisionista);
			logger.debug("codOficina=" + codOficina);
			logger.debug("codTipoComisionista=" + codTipoComisionista);
			listaDistribuidores = delegate.getListadoVendedores(vendedorDTO);

			listaRetorno = new VendedorAjaxDTO[listaDistribuidores.length];
			for (int i = 0; i < listaDistribuidores.length; i++) {
				VendedorAjaxDTO vendedor = new VendedorAjaxDTO();
				vendedor.setCodigoVendedor(listaDistribuidores[i].getCodigoVendedor());
				vendedor.setNombreVendedor(listaDistribuidores[i].getNombreVendedor());
				listaRetorno[i] = vendedor;
			}

		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener distribuidores " + mensaje);
		}
		retorno.setLista(listaRetorno);
		logger.debug("obtenerDistribuidores:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de vendedores dependiendo del codigo distribuidor seleccionado
	 */
	public RetornoListaAjaxDTO obtenerVendedores(String codVendedor) {
		logger.debug("obtenerVendedores:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		VendedorAjaxDTO[] listaRetorno = null;
		VendedorDTO[] listaVendedores = null;
		try {
			VendedorDTO vendedorDTO = new VendedorDTO();
			vendedorDTO.setCodigoVendedor(codVendedor);
			listaVendedores = delegate.getListadoVendedoresDealer(vendedorDTO);

			listaRetorno = new VendedorAjaxDTO[listaVendedores.length];
			for (int i = 0; i < listaVendedores.length; i++) {
				VendedorAjaxDTO vendedor = new VendedorAjaxDTO();
				vendedor.setCodigoVendedor(String.valueOf(listaVendedores[i].getCodigoVendedorDealer()));
				vendedor.setNombreVendedor(listaVendedores[i].getNombreDealer());
				listaRetorno[i] = vendedor;
			}

		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener vendedores " + mensaje);
		}
		retorno.setLista(listaRetorno);
		logger.debug("obtenerVendedores:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de tipos de contrato dependiendo del tipo de cliente seleccionado Lista :
	 * codigoTipoContrato,descripcionTipoContrato
	 */
	public RetornoListaAjaxDTO obtenerTiposContrato(String codTipoCliente) {
		logger.debug("obtenerTiposContrato:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		ContratoAjaxDTO[] listaRetorno = null;
		ContratoDTO[] listaTiposContrato = null;
		try {
			ContratoDTO contratoDTO = new ContratoDTO();
			contratoDTO.setTipoCliente(codTipoCliente);
			listaTiposContrato = delegate.getListadoTipoContrato(contratoDTO);

			listaRetorno = new ContratoAjaxDTO[listaTiposContrato.length];
			for (int i = 0; i < listaTiposContrato.length; i++) {
				ContratoAjaxDTO contrato = new ContratoAjaxDTO();
				contrato.setCodigoTipoContrato(listaTiposContrato[i].getCodigoTipoContrato());
				contrato.setDescripcionTipoContrato(listaTiposContrato[i].getDescripcionTipoContrato());
				listaRetorno[i] = contrato;
			}

		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener tipos contrato " + mensaje);
		}
		retorno.setLista(listaRetorno);
		logger.debug("obtenerTiposContrato:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de periodos dependiendo del tipo de contrato Lista : String
	 */
	public RetornoListaAjaxDTO obtenerPeriodo(String codTipoContrato) {
		logger.debug("obtenerPeriodo:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		ContratoDTO contratoDTO = new ContratoDTO();
		String[] listaPeriodo = null;
		try {

			contratoDTO.setCodigoTipoContrato(codTipoContrato);
			contratoDTO = delegate.getListadoNumeroMesesContrato(contratoDTO);
			int total = contratoDTO.getNumeroMesesContrato().size();
			listaPeriodo = new String[total];
			for (int i = 0; i < total; i++) {
				listaPeriodo[i] = (String) contratoDTO.getNumeroMesesContrato().get(i);
			}
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener periodo " + mensaje);
		}
		retorno.setLista(listaPeriodo);
		logger.debug("obtenerPeriodo:fin()");
		return retorno;
	}

	/*
	 * Carga la lista de modalidad de venta Lista : codigoModalidadPago,descripcionModalidadPago
	 */
	public RetornoListaAjaxDTO obtenerModalidadVenta(String codTipoContrato, String periodo, String codVendedor,
			String CodTipoCliente) {
		logger.debug("obtenerModalidadVenta:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		ModalidadPagoDTO[] listaModalidadPago = null;
		try {
			ModalidadPagoDTO modalidad = new ModalidadPagoDTO();
			modalidad.setTipoContrato(codTipoContrato);
			modalidad.setMeses(periodo);
			String user = ((ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal")).getCodUsuario();
			modalidad.setUsuarioArchivo(user);
			modalidad.setVendedorArchivo(codVendedor);
			modalidad.setCodTipoCliente(CodTipoCliente);
			listaModalidadPago = delegate.getListadoModalidadPago(modalidad);

			// Asignar Valores de modalidades
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				datosVentaForm.setListaModalidadPago(listaModalidadPago);
			}
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener modalidad pago " + mensaje);
		}
		retorno.setLista(listaModalidadPago);
		logger.debug("obtenerModalidadVenta:fin()");
		return retorno;
	}

	// Obtiene el ind_Cuotas de acuerdo a la modalidad
	public RetornoValorAjaxDTO obtenerIndCuotas(String codModventa) {
		logger.debug("obtenerIndCuotas:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		try {

			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				ModalidadPagoDTO[] Modalidades = datosVentaForm.getListaModalidadPago();
				for (int i = 0; i < Modalidades.length; i++) {
					if (Modalidades[i].getCodigoModalidadPago().equals(codModventa)) {
						logger.debug("Modalidades.IndVtaExterna" + Modalidades[i].getIndicadorCuotas());
						retorno.setResultado(String.valueOf(Modalidades[i].getIndicadorCuotas()));
						break;
					}
				}
			}
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener indicador de cuotas para la modalidad " + mensaje);
		}

		logger.debug("obtenerIndCuotas:fin()");
		return retorno;
	}

	/*
	 * Obtiene si tipo comisionista es interno o externo
	 */
	public RetornoValorAjaxDTO obtenerIndVtaExterna(String codTipoComisionista) {
		logger.debug("obtenerIndVtaExterna:inicio()");
		logger.debug("codTipoComisionista [" + codTipoComisionista + "]");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		try {
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				VendedorDTO[] vendedores = datosVentaForm.getArrayTipoComisionista();
				for (int i = 0; i < vendedores.length; i++) {
					if (vendedores[i].getCodTipComisionista().equals(codTipoComisionista)) {
						logger.debug("tipoComisionista.IndVtaExterna" + vendedores[i].getIndVtaExterna());
						retorno.setResultado(String.valueOf(vendedores[i].getIndVtaExterna()));
						break;
					}
				}
			}

		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener indicador venta externa " + mensaje);
		}

		logger.debug("obtenerIndVtaExterna:fin()");
		return retorno;
	}

	public RetornoValorAjaxDTO bloqueaDesbloqueaVendedor(String codVendedor, String accion) {
		logger.info("bloqueaDesbloqueaVendedor:inicio()");
		logger.debug("accion: " + accion);
		VendedorDTO entrada = new VendedorDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		try {
			entrada.setCodigoVendedor(codVendedor);
			entrada.setCodigoAccionBloqueo(accion);
			delegate.bloqueaDesbloqueaVendedor(entrada);
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " Ocurrio un error en Desbloqueo-Bloqueo Vendedor" : e
					.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
			logger.debug(mensaje);
		}

		logger.info("bloqueaDesbloqueaVendedor:fin()");
		return retorno;
	}

	/**
	 * @param codVendedor
	 * @return RetornoValorAjaxDTO Si el vendedor existe, no está bloqueado y no está en Lista Negra no se retorna nada.
	 *         En caso contrario, el objeto de retorno llevará codigo y mensaje de error.
	 */
	public RetornoValorAjaxDTO obtieneEstadoVendedor(String codVendedor) {
		logger.info("obtieneEstadoVendedor, inicio");
		logger.debug("codVendedor [" + codVendedor + "]");
		VendedorDTO entrada = new VendedorDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		try {
			entrada.setCodigoVendedor(codVendedor);
			if (!delegate.verificaEstadoVendedor(entrada)) {// true o false
				throw new VentasException("4", 0, "Vendedor bloqueado o no vigente");
			}
		}
		catch (VentasException e) {
			logger.error("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			logger.error("e.getCodigo() [" + e.getCodigo() + "]");
			logger.error("e.getDescripcionEvento() [" + e.getDescripcionEvento() + "]");
			if (e.getCodigo().trim().equals("4")) {
				retorno.setCodError(e.getCodigo());
				retorno.setMsgError(e.getDescripcionEvento());
			}
		}
		try {
			delegate.validaVendedorLN(codVendedor).booleanValue(); // true o error
		}
		catch (VentasException e) {
			logger.error("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			logger.error("e.getCodigo() [" + e.getCodigo() + "]");
			logger.error("e.getDescripcionEvento() [" + e.getDescripcionEvento() + "]");
			if (e.getCodigo().trim().equals("4")) {
				retorno.setCodError(e.getCodigo());
				retorno.setMsgError(global.getValor("mensaje.listas.negras.venta.vendedor"));
			}
		}
		logger.debug("retorno.getCodError() [" + retorno.getCodError() + "]");
		logger.debug("retorno.getMsgError() [" + retorno.getMsgError() + "]");
		logger.info("obtieneEstadoVendedor, fin");
		return retorno;
	}

	public void limpiaClienteFacturable() {
		logger.debug("limpiaClienteFacturable:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		if (sesion != null)
			sesion.removeAttribute("ClienteFacturaForm");
		logger.debug("limpiaClienteFacturable:fin()");
	}

	public RetornoBusquedaVendedorAjaxDTO busquedaVendedor(String codVendedor, String tipoVendedor) {
		logger.debug("RetornoBusquedaVendedorAjaxDTO:inicio()");
		logger.debug("codVendedor [" + codVendedor + "]");
		logger.debug("tipoVendedor [" + tipoVendedor + "]");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoBusquedaVendedorAjaxDTO retorno = new RetornoBusquedaVendedorAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		try {
			VendedorDTO vendedor = new VendedorDTO();
			vendedor.setCodigoVendedor(codVendedor);
			vendedor.setCodCanal(tipoVendedor);

			vendedor = delegate.buscarVendedor(vendedor);

			retorno.setCodigoOficina(vendedor.getCodigoOficina());
			retorno.setCodigoTipComis(vendedor.getCodTipComisionista());
			retorno.setCodigoDistribuidor(vendedor.getCodigoVendedor());
			retorno.setCodigoVendedor(String.valueOf(vendedor.getCodigoVendedorDealer()));

		}
		catch (VentasException e) {
			logger.debug("[VentasException]");
			String mensaje = e.getDescripcionEvento() == null ? " Ocurrio un error al buscar vendedor" : e
					.getDescripcionEvento();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}
		catch (Exception e) {
			logger.debug("[Exception]");
			String mensaje = e.getMessage() == null ? " Ocurrio un error al buscar vendedor" : e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}

		logger.debug("RetornoBusquedaVendedorAjaxDTO:fin()");
		return retorno;
	}

	private boolean validarSesion(HttpSession sesion) {
		if (sesion == null)
			return false;
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO) sesion.getAttribute("paramGlobal");
		if (sessionData == null)
			return false;
		return true;
	}

	/**
	 * @author mwn40031
	 * @param codVendedorDealer
	 * @return
	 */
	public RetornoValorAjaxDTO validaVendedorDealerLN(String codVendedorDealer) {
		logger.info("Inicio");
		logger.debug("codVendedorDealer: " + codVendedorDealer);
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		try {
			logger.debug("Valida listas negras vendedor dealer...");
			delegate.validaVendedorDealerLN(codVendedorDealer);
			logger.debug("...listas negras vendedor dealer OK.");
		}
		catch (VentasException e) {
			logger.error("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			if (e.getCodigo().trim().equals("4")) {
				retorno.setCodError(e.getCodigo());
				String mensaje = global.getValor("mensaje.listas.negras.venta.vendedor.dealer");
				retorno.setMsgError(mensaje);
			}
		}
		logger.info("Fin");
		return retorno;
	}

}
