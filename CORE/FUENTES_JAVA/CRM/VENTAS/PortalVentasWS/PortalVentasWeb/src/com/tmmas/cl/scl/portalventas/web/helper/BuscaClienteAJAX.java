package com.tmmas.cl.scl.portalventas.web.helper;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidacionAjaxDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.NumeroIdentificacionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.FolioDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.ClienteAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.dto.RetornoValorAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DatosVentaForm;

public class BuscaClienteAJAX {
	private final Logger logger = Logger.getLogger(BuscaClienteAJAX.class);

	private Global global = Global.getInstance();

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	/*
	 * Carga la lista de clientes
	 */
	public RetornoListaAjaxDTO obtenerClientes(String codCliente, String codTipoIdentificacion,
			String numIdentificacion, String tipoCliente, String telefonoCliente, String nombres,
			String primerApellido, String segundoApellido, String nombreEmpresa) {
		logger.debug("obtenerClientes:inicio()");
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		ClienteAjaxDTO[] listaRetorno = null;
		ClienteDTO[] listaClientes = null;
		try {
			BusquedaClienteDTO paramBusquedaDTO = new BusquedaClienteDTO();
			paramBusquedaDTO.setCodCliente(codCliente);
			paramBusquedaDTO.setCodTipoIdentificacion(codTipoIdentificacion);
			paramBusquedaDTO.setNumIdentificacion(numIdentificacion);
			paramBusquedaDTO.setCodTipoCliente(tipoCliente);
			paramBusquedaDTO.setNumTelefono(telefonoCliente);
			paramBusquedaDTO.setNombreCliente(nombres);
			paramBusquedaDTO.setPrimerApellido(primerApellido);
			paramBusquedaDTO.setSegundoApellido(segundoApellido);
			paramBusquedaDTO.setNombreEmpresa(nombreEmpresa);
			listaClientes = delegate.getDatosCliente(paramBusquedaDTO);

			listaRetorno = new ClienteAjaxDTO[listaClientes.length];
			for (int i = 0; i < listaClientes.length; i++) {
				ClienteAjaxDTO cliente = new ClienteAjaxDTO();
				final ClienteDTO clienteDTO = listaClientes[i];
				cliente.setCodigoCliente(clienteDTO.getCodigoCliente());
				cliente.setCodigoTipoIdentificacion(clienteDTO.getCodigoTipoIdentificacion());
				cliente.setNumeroIdentificacion(clienteDTO.getNumeroIdentificacion());
				cliente.setTipoCliente(clienteDTO.getTipoCliente());
				cliente.setGlsTipoCliente(clienteDTO.getGlsTipoCliente());
				cliente.setNombreCliente(clienteDTO.getNombreCliente());
				cliente.setNombreApellido1(clienteDTO.getNombreApellido1());
				cliente.setNombreApellido2(clienteDTO.getNombreApellido2());
				cliente.setNumeroTelefono1(clienteDTO.getNumeroTelefono1());
				cliente.setDireccionEMail(clienteDTO.getDireccionEMail());
				cliente.setFechaNacimiento(clienteDTO.getFechaNacimiento());
				cliente.setCodCrediticia(clienteDTO.getCodCrediticia());
				cliente.setMontoPreAutorizado(clienteDTO.getMontoPreAutorizado());
				cliente.setCodCalificacion(clienteDTO.getCodCalificacion());
				cliente.setDescripcionColor(clienteDTO.getDescripcionColor());
				cliente.setDescripcionSegmento(clienteDTO.getDescripcionSegmento());
				cliente.setDesTipoIdentificacion(clienteDTO.getDescripcionTipoIdentificacion());

				listaRetorno[i] = cliente;
			}

			sesion.setAttribute("listaClientes", listaRetorno);

		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? "Ocurrio un error al obtener clientes " : e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}
		retorno.setLista(listaRetorno);
		logger.debug("obtenerClientes:fin()");
		return retorno;
	}

	public RetornoValidacionAjaxDTO validarIdentificador(String tipoIdentif, String numIdentif) {
		logger.debug("validarIdentificador:inicio()");
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		NumeroIdentificacionDTO param = new NumeroIdentificacionDTO();
		retorno.setValido(true);
		try {
			param.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			param.setCorrelativo(Long.valueOf(global.getValor("param.identificador.correlativo")));
			param.setTipoIdentif(tipoIdentif);
			param.setNumIdentif(numIdentif);
			param = delegate.validarIdentificador(param);
			retorno.setIdentificadorFormateado(param.getFormatoNIT());
		}
		catch (Exception e) {
			retorno.setValido(false);
		}
		logger.debug("validarIdentificador:fin()");
		return retorno;
	}

	public RetornoValidacionAjaxDTO ValidaFolio(String codCliente) {
		logger.debug("ValidaFolio:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValidacionAjaxDTO retorno = new RetornoValidacionAjaxDTO();

		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		FolioDTO entrada = new FolioDTO();
		try {
			if (sesion.getAttribute("DatosVentaForm") != null) {
				DatosVentaForm datosVentaForm = (DatosVentaForm) sesion.getAttribute("DatosVentaForm");
				entrada.setCodOficina(datosVentaForm.getCodOficina());
			}
			entrada.setCodCliente(new Long(codCliente).longValue());
			delegate.getFolio(entrada);
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " " : ", " + e.getMessage();
			retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al validar folio" + mensaje);
		}
		logger.debug("ValidaFolio:fin()");
		return retorno;
	}

	/**
	 * @author JIB
	 * @param codCliente
	 * @return
	 */
	public RetornoValorAjaxDTO validaClienteLN(String codCliente) {
		logger.info("Inicio");
		logger.debug("codCliente: " + codCliente);
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		try {
			logger.debug("Valida listas negras cliente...");
			delegate.validaClienteLN(codCliente);
			logger.debug("...listas negras cliente OK.");
		}
		catch (VentasException e) {
			logger.error("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			if (e.getCodigo().trim().equals("4")) {
				retorno.setCodError(e.getCodigo());
				String mensaje = global.getValor("mensaje.listas.negras.venta.cliente");
				retorno.setMsgError(mensaje);
			}
		}
		catch (Exception ex) {
			logger.error("Exception [" + StackTraceUtl.getStackTrace(ex) + "]");
			retorno.setCodError("1");
			retorno.setMsgError(ex.getLocalizedMessage());
		}
		logger.info("Fin");
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
	 * @author JIB
	 * @param codCliente
	 * @return
	 */
	public RetornoValorAjaxDTO verificaClientePasilloLDI(String codCliente) {
		logger.info("verificaClientePasilloLDI, Inicio");
		logger.debug("codCliente: " + codCliente);
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoValorAjaxDTO retorno = new RetornoValorAjaxDTO();
		if (!validarSesion(sesion)) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		try {
			final String codPrestacionCarrier = global.getValor("cod_prestacion.carrier");
			logger.debug("codPrestacionCarrier [" + codPrestacionCarrier + "]");
			final boolean esClienteCarrier = delegate.verificaPrestacionCliente(new Long(codCliente),
					codPrestacionCarrier);
			logger.debug("esClienteCarrier [" + esClienteCarrier + "]");
			if (esClienteCarrier) { // No se admiten clientes LDI para solicitudes de venta
				throw new VentasException(global.getValor("mensaje.solicitud.cliente.carrier.no.aplica"));
			}
		}
		catch (VentasException e) {
			logger.error("VentasException [" + StackTraceUtl.getStackTrace(e) + "]");
			retorno.setCodError("2");
			retorno.setMsgError(e.getMessage());
		}
		catch (Exception ex) {
			logger.error("Exception [" + StackTraceUtl.getStackTrace(ex) + "]");
			retorno.setCodError("1");
			retorno.setMsgError(ex.getLocalizedMessage());
		}
		logger.info("verificaClientePasilloLDI, Fin");
		return retorno;
	}
}
