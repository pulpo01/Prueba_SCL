package com.tmmas.cl.scl.portalventas.web.helper;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoListaAjaxDTO;
import com.tmmas.cl.scl.altacliente.presentacion.dto.RetornoValidaTarjetaDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.TarjetaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.BusquedaSolScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.VentasException;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.SolicitudScoringAjaxDTO;

public class SolicitudScoringAJAX {

	private final Logger logger = Logger.getLogger(SolicitudScoringAJAX.class);

	private PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();

	public RetornoListaAjaxDTO obtenerSolicitudesScoring(String numSolScoring, String codVendedor, String codOficina,
			String codCliente, String fechaDesde, String fechaHasta, String codEstadoSolicitud) {
		logger.debug("obtenerSolicitudesScoring:inicio()");

		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();

		if (!SessionHelper.validarSesion(WebContextFactory.get().getHttpServletRequest().getSession(false))) {
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}

		SolicitudScoringAjaxDTO[] listaRetorno = null;
		ScoreClienteDTO[] listaSolicitudes = null;
		try {
			if (numSolScoring.trim().equals(""))	numSolScoring = "0";
			if (codVendedor.trim().equals(""))  	codVendedor = "0";
			if (codOficina.trim().equals(""))		codOficina = "0";
			if (codCliente.trim().equals(""))		codCliente = "0";
			if (codEstadoSolicitud.equals(""))		codEstadoSolicitud = "0";

			BusquedaSolScoringDTO busquedaSolScoringDTO = new BusquedaSolScoringDTO();
			busquedaSolScoringDTO.setNroSolicitud(new Long(numSolScoring));
			busquedaSolScoringDTO.setCodigoVendedor(new Long(codVendedor));
			busquedaSolScoringDTO.setCodCliente(new Long(codCliente));
			busquedaSolScoringDTO.setCodOficina(codOficina);
			busquedaSolScoringDTO.setFechaDesde(fechaDesde);
			busquedaSolScoringDTO.setFechaHasta(fechaHasta);
			busquedaSolScoringDTO.setCodEstadoSolicitud(codEstadoSolicitud);

			listaSolicitudes = delegate.getSolicitudesScoring(busquedaSolScoringDTO);

			if (listaSolicitudes != null) {
				listaRetorno = new SolicitudScoringAjaxDTO[listaSolicitudes.length];
				for (int i = 0; i < listaSolicitudes.length; i++) {
					SolicitudScoringAjaxDTO solicitud = new SolicitudScoringAjaxDTO();
					solicitud.setNroSolScoring(String.valueOf(listaSolicitudes[i].getNumSolScoring()));
					solicitud.setFechaCreacion(listaSolicitudes[i].getFecha_creacion());
					solicitud.setNombreCliente(listaSolicitudes[i].getPrimer_apellido() + " "
							+ listaSolicitudes[i].getSegundo_apellido() + " " + listaSolicitudes[i].getPrimer_nombre()
							+ " " + listaSolicitudes[i].getSegundo_nombre());
					solicitud.setNombreVendedor(listaSolicitudes[i].getDatosGeneralesScoringDTO().getNombreVendedor());
					solicitud.setNombreDealer(listaSolicitudes[i].getDatosGeneralesScoringDTO().getNombreVendealer());
					solicitud.setCodOficina(listaSolicitudes[i].getDatosGeneralesScoringDTO().getCodOficina());
					solicitud.setCodDistribuidor(String.valueOf(listaSolicitudes[i].getDatosGeneralesScoringDTO()
							.getCodVendedor()));
					solicitud.setCodCliente(String.valueOf(listaSolicitudes[i].getCodCliente()));
					solicitud.setNit(listaSolicitudes[i].getNit());
					solicitud.setCodModVenta(String.valueOf(listaSolicitudes[i].getDatosGeneralesScoringDTO()
							.getCodModVenta()));
					solicitud.setCodTipoContrato(listaSolicitudes[i].getDatosGeneralesScoringDTO().getCodTipContrato());
					solicitud.setCodCuota(listaSolicitudes[i].getDatosGeneralesScoringDTO().getCodCuota());
					solicitud.setCodVendedor(String.valueOf(listaSolicitudes[i].getDatosGeneralesScoringDTO()
							.getCodVendedorDealer()));
					solicitud.setCodTipoComisionista(String.valueOf(listaSolicitudes[i].getDatosGeneralesScoringDTO()
							.getCodTipComis()));
					solicitud.setCodEstado(listaSolicitudes[i].getEstadoActualDTO().getCodEstado());
					solicitud.setDesEstado(listaSolicitudes[i].getEstadoActualDTO().getDesEstado());

					listaRetorno[i] = solicitud;
				}
			}

			WebContextFactory.get().getHttpServletRequest().getSession(false).setAttribute("listaSolicitudes", listaRetorno);

		}
		catch (VentasException e) {
			String mensaje = e.getDescripcionEvento() == null ? " Ocurrio un error al obtener solicitudes scoring" : e
					.getDescripcionEvento();
			logger.debug("[VentasException]" + mensaje);
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}
		catch (Exception e) {
			String mensaje = e.getMessage() == null ? " Ocurrio un error al obtener solicitudes scoring" : e
					.getMessage();
			logger.debug("[Exception]" + mensaje);
			retorno.setCodError("1");
			retorno.setMsgError(mensaje);
		}
		retorno.setLista(listaRetorno);
		logger.debug("obtenerSolicitudesScoring:fin()");
		return retorno;
	}

	/**
	 * @author JIB
	 * @param numTarjeta
	 * @param tipTarjeta
	 * @return
	 */
	public RetornoValidaTarjetaDTO validarTarjeta(String numTarjeta, String tipTarjeta) {
		logger.info("validarTarjeta, inicio");
		logger.debug("numTarjeta [" + numTarjeta + "]");
		logger.debug("tipTarjeta [" + tipTarjeta + "]");
		RetornoValidaTarjetaDTO r = new RetornoValidaTarjetaDTO();
		if (!SessionHelper.validarSesion(WebContextFactory.get().getHttpServletRequest().getSession(false))) {
			r.setCodError("-100");
			r.setMsgError("Su sesión ha expirado");
			r.setValido(false);
			return r;
		}
		try {
			r.setValido(true);
			TarjetaDTO tarjetaDTO = new TarjetaDTO();
			tarjetaDTO.setNumTarjeta(numTarjeta);
			tarjetaDTO.setTipoTarjeta(tipTarjeta);
			tarjetaDTO = delegate.validarTarjeta(tarjetaDTO);
		}
		catch (VentasException e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			r.setValido(false);
			logger.error("e.getCodigo() ["+ e.getCodigo() + "]");
			logger.error("e.getDescripcionEvento() ["+ e.getDescripcionEvento() + "]");
			final String codigo = e.getCodigo();
			r.setCodError(codigo);
			if (codigo.equals("514")) {	
				r.setMsgError("N° de Tarjeta no válido");
			}
			else {
				r.setMsgError(Utilidades.capitalizar(e.getDescripcionEvento()));
			}
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			r.setValido(false);
			r.setCodError("-200");
			r.setMsgError("Ocurrió un error al validar tarjeta");
		}
		logger.info("validarTarjeta, fin");
		logger.debug("r.toString() [" + r.toString() + "]");
		return r;
	}

}
