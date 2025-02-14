/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsseguridad.wsservices;

import org.apache.axis2.axis2userguide.WSAbonoLimiteConsumoServicioSuplementarioStub;
import org.apache.axis2.axis2userguide.WSAbonoLimiteConsumoStub;
import org.apache.axis2.axis2userguide.WSAnulacionSiniestroStub;
import org.apache.axis2.axis2userguide.WSCambioEquipoGSMStub;
import org.apache.axis2.axis2userguide.WSCambioSIMCardStub;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.scl.wsfranquicias.common.dto.CargaAjusteCExcepcionCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.CargaAjusteCReversionCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.EjecucionAjusteCExcepcionCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.EjecucionAjusteCReversionCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.FiltroDetDocAjusteCExcepcionCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.FiltroDetDocAjusteCReversionCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambionumerosfrecuentes.CargaCambioNumFrecuentesDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambionumerosfrecuentes.EjecucionCambioNumFrecuentesDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaAbonoLimConDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaAbonoLimiteConsumoServicioSuplementarioDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaAnulacionSiniestroDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaCambioEquipoGSMDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaCambioSIMCardDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionAbonoLimConDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionAbonoLimiteConsumoServicioSuplementarioDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionAnulacionSiniestroDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionCambioEquipoGSMDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionCambioSIMCardDTO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.DetalleAjusteVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.BloqueArticulosVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.BloqueUsosVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.CausasCambioVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.CausasPagoVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.NotaCreditoVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.NotaDebitoVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.OrigenPagoVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.SiniestrosVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.TiposContratosVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.TiposTerminalesVO;
import com.tmmas.scl.wsfranquicias.webservices.CargaAbonoLimiteConsumoServicioSuplementarioDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargaAbonoLimiteConsumoServicioSuplementarioResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarAbonoLimiteConsumoDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarAbonoLimiteConsumoResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarAnulacionSiniestroDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarAnulacionSiniestroResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioEquipoGSMDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioEquipoGSMResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioSIMCardDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioSIMCardResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecucionAbonoLimiteConsumoServicioSuplementarioDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecucionAbonoLimiteConsumoServicioSuplementarioResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarAbonoLimiteConsumoDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarAbonoLimiteConsumoResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarAnulacionSiniestroDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarAnulacionSiniestroResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioEquipoGSMDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioEquipoGSMResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioSIMCardDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioSIMCardResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargaAbonoLimiteConsumoServicioSuplementarioDocument.CargaAbonoLimiteConsumoServicioSuplementario;
import com.tmmas.scl.wsfranquicias.webservices.CargarAbonoLimiteConsumoDocument.CargarAbonoLimiteConsumo;
import com.tmmas.scl.wsfranquicias.webservices.CargarAnulacionSiniestroDocument.CargarAnulacionSiniestro;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioEquipoGSMDocument.CargarCambioEquipoGSM;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioSIMCardDocument.CargarCambioSIMCard;
import com.tmmas.scl.wsfranquicias.webservices.EjecucionAbonoLimiteConsumoServicioSuplementarioDocument.EjecucionAbonoLimiteConsumoServicioSuplementario;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarAbonoLimiteConsumoDocument.EjecutarAbonoLimiteConsumo;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarAnulacionSiniestroDocument.EjecutarAnulacionSiniestro;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioEquipoGSMDocument.EjecutarCambioEquipoGSM;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioSIMCardDocument.EjecutarCambioSIMCard;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsseguridad.dto.CargaAjusteCExcepcionCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.CargaAjusteCReversionCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.CargaCambioNumFrecuentesSACDTO;
import com.tmmas.scl.wsseguridad.dto.DetalleAjusteSACVO;
import com.tmmas.scl.wsseguridad.dto.DetalleDocumentoSACVO;
import com.tmmas.scl.wsseguridad.dto.EjecucionAjusteCExcepcionCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.EjecucionAjusteCReversionCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.EjecucionCambioNumFrecuentesSACDTO;
import com.tmmas.scl.wsseguridad.dto.FiltroDetDocAjusteCCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.FoliosFacturasSACVO;

public class ClienteFranquicias extends ClienteCRMAssurance
{

	private static Logger logger = Logger.getLogger(ClienteFranquicias.class);

	private static final String CLAVE_URL_WS_CAMBIO_NUM_FRECUENTES = "ws.cambio.num.frecuentes";

	private static final String CLAVE_URL_WS_CAMBIO_SIMCARD_GSM = "ws.cambio.simcard.GSM";

	private static final String CLAVE_URL_WS_CAMBIO_EQUIPO_GSM = "ws.cambio.equipo.GSM";

	private static final String CLAVE_URL_WS_AJUSTE_CREVERSION_CARGOS = "ws.ajuste.creversion.cargos";

	private static final String CLAVE_URL_WS_AJUSTE_CEXCEPCION_CARGOS = "ws.ajuste.cexcepcion.cargos";

	private static final String CLAVE_URL_WS_ABONO_LIMITE_CONSUMO = "ws.abono.limite.consumo";

	private static final String CLAVE_URL_WS_ABONO_LIMITE_CONSUMO_SERVICIO_SUPLEMENTARIO = "ws.abono.limite.consumo.servicio.suplementario";

	private static final String CLAVE_CAMBIO_SIMCARD_GSM_COD_MOD_VENTA = "ws.cambio.simcard.GSM.codModVenta";

	private static final String CLAVE_URL_WS_ANULACION_SINIESTRO = "ws.anulacion.siniestro";

	static PortalSACException procesarException(Throwable e)
	{
		PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
				config.getString("COD.ERR_SAC.4002"), config.getString("DES.ERR_SAC.4002"), e);
		return pe;
	}

	/** Auditado */
	public CargaCambioNumFrecuentesSACDTO cargaNumFrecuentes(Long numAbonado, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		CargaCambioNumFrecuentesSACDTO r = null;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, numAbonado, null, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);

			CargaCambioNumFrecuentesDTO dto = new CargaCambioNumFrecuentesDTO();
			dto.setNumAbonado(numAbonado);
			dto.setNomUsuarioSCL(nomUsuarioSCL);
			dto.setNroOOSS(1);
			String urlWS = config.getString(CLAVE_URL_WS_CAMBIO_NUM_FRECUENTES);
			Object[] args = new Object[] { dto };
			dto = (CargaCambioNumFrecuentesDTO) WSSEGPortal.invocarMetodoWeb(args, "cargaNumFrecuentes", urlWS,
					"urn:cargaNumFrecuentes", dto.getClass(), ESPACIO_NOMBRES_FRANQUICIAS);

			if (dto == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("CodError: " + dto.getCodError());
				logger.debug("DesError: " + dto.getDesError());
				logger.debug("NumTransaccion: " + dto.getNumTransaccion());
			}
			r = new CargaCambioNumFrecuentesSACDTO(dto);
		}
		catch (Throwable e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			return new CargaCambioNumFrecuentesSACDTO(pe);
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.CargaAbonoLimConDTO cargarAbonoLimiteConsumo(Long codSujeto,
			String tipoAbono, String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaAbonoLimConDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaAbonoLimConDTO();
		CargarAbonoLimiteConsumoResponseDocument response = null;
		CargaAbonoLimConDTO cargaDTO = CargaAbonoLimConDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			/** Auditoría */
			if (tipoAbono.equals("A"))
			{
				WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, codSujeto, null, null,
						ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);
			}
			if (tipoAbono.equals("C"))
			{
				WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, null, codSujeto, null,
						ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);
			}
			String urlWS = config.getString(CLAVE_URL_WS_ABONO_LIMITE_CONSUMO);
			logger.debug("urlWS [" + urlWS + "]");
			WSAbonoLimiteConsumoStub stub = new WSAbonoLimiteConsumoStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			CargarAbonoLimiteConsumoDocument cargarAbonoLimiteConsumoDocument = CargarAbonoLimiteConsumoDocument.Factory
					.newInstance();
			CargarAbonoLimiteConsumo cargarAbonoLimiteConsumoReq = cargarAbonoLimiteConsumoDocument
					.addNewCargarAbonoLimiteConsumo();
			CargaAbonoLimConDTO dto = CargaAbonoLimConDTO.Factory.newInstance();

			logger.debug("codSujeto.longValue(): " + codSujeto.longValue());
			dto.setCodSujeto(codSujeto.longValue());

			logger.debug("nomUsuarioSCL: " + nomUsuarioSCL);
			dto.setNomUsuarioSCL(nomUsuarioSCL);

			logger.debug("tipoAbono: " + tipoAbono);
			dto.setTipoAbono(tipoAbono);

			cargarAbonoLimiteConsumoReq.setCargaAbonoLimConDTO(dto);
			cargarAbonoLimiteConsumoDocument.setCargarAbonoLimiteConsumo(cargarAbonoLimiteConsumoReq);
			response = stub.cargarAbonoLimiteConsumo(cargarAbonoLimiteConsumoDocument);
			logger.debug("cargarAbonoLimiteConsumoDocument: " + cargarAbonoLimiteConsumoDocument);
			cargaDTO = response.getCargarAbonoLimiteConsumoResponse().getReturn();

			logger.debug("cargaDTO.getCodLimCon(): " + cargaDTO.getCodLimCon());
			r.setCodLimCon(cargaDTO.getCodLimCon());

			logger.debug("codSujeto.longValue(): " + codSujeto.longValue());
			r.setCodSujeto(codSujeto.longValue());

			logger.debug("cargaDTO.getCodUmbral(): " + cargaDTO.getCodUmbral());
			r.setCodUmbral(cargaDTO.getCodUmbral());

			logger.debug("cargaDTO.getDesLimCon(): " + cargaDTO.getDesLimCon());
			r.setDesLimCon(cargaDTO.getDesLimCon());

			logger.debug("cargaDTO.getDesUmbral(): " + cargaDTO.getDesUmbral());
			r.setDesUmbral(cargaDTO.getDesUmbral());

			logger.debug("cargaDTO.getMontoLimCon(): " + cargaDTO.getMontoLimCon());
			r.setMontoLimCon(cargaDTO.getMontoLimCon());

			logger.debug("cargaDTO.getNivelConsumo(): " + cargaDTO.getNivelConsumo());
			r.setNivelConsumo(cargaDTO.getNivelConsumo());

			logger.debug("cargaDTO.getNombreCliente(): " + cargaDTO.getNombreCliente());
			r.setNombreCliente(cargaDTO.getNombreCliente());

			r.setNomUsuarioSCL(nomUsuarioSCL);

			logger.debug("cargaDTO.getNumTerminal(): " + cargaDTO.getNumTerminal());
			r.setNumTerminal(cargaDTO.getNumTerminal());

			logger.debug("cargaDTO.getNumTransaccion(): " + cargaDTO.getNumTransaccion());
			r.setNumTransaccion(cargaDTO.getNumTransaccion());

			logger.debug("cargaDTO.getTipoAbono(): " + cargaDTO.getTipoAbono());
			r.setTipoAbono(cargaDTO.getTipoAbono());

			logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
			r.setCodError(cargaDTO.getCodError());

			logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());
			r.setDesError(cargaDTO.getDesError());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.debug("codError: " + r.getCodError());
		logger.debug("desError: " + r.getDesError());
		logger.debug("numTransaccion: " + r.getNumTransaccion());
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.CargaAbonoLimiteConsumoServicioSuplementarioDTO cargarAbonoLimiteConsumoSS(
			Long codSujeto, String tipoAbono, String tipoOOSS, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaAbonoLimiteConsumoServicioSuplementarioDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaAbonoLimiteConsumoServicioSuplementarioDTO();
		CargaAbonoLimiteConsumoServicioSuplementarioResponseDocument response = null;
		CargaAbonoLimiteConsumoServicioSuplementarioDTO cargaDTO = CargaAbonoLimiteConsumoServicioSuplementarioDTO.Factory
				.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			/** Auditoría */
			if (tipoAbono.equals("A"))
			{
				WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, codSujeto, null, null,
						ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);
			}
			if (tipoAbono.equals("C"))
			{
				WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, null, codSujeto, null,
						ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);
			}
			String urlWS = config.getString(CLAVE_URL_WS_ABONO_LIMITE_CONSUMO_SERVICIO_SUPLEMENTARIO);

			WSAbonoLimiteConsumoServicioSuplementarioStub stub = new WSAbonoLimiteConsumoServicioSuplementarioStub(
					urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			CargaAbonoLimiteConsumoServicioSuplementarioDocument cargaAbonoLimiteConsumoServicioSuplementarioDocument = CargaAbonoLimiteConsumoServicioSuplementarioDocument.Factory
					.newInstance();
			CargaAbonoLimiteConsumoServicioSuplementario cargarAbonoLimiteConsumoSSReq = cargaAbonoLimiteConsumoServicioSuplementarioDocument
					.addNewCargaAbonoLimiteConsumoServicioSuplementario();
			CargaAbonoLimiteConsumoServicioSuplementarioDTO entrada = CargaAbonoLimiteConsumoServicioSuplementarioDTO.Factory
					.newInstance();
			entrada.setCodSujeto(codSujeto.longValue());
			entrada.setNomUsuarioSCL(nomUsuarioSCL);
			entrada.setTipoOOSS(tipoOOSS);
			cargarAbonoLimiteConsumoSSReq.setCargaAbonoLimiteConsumoServicioSuplementarioDTO(entrada);
			cargaAbonoLimiteConsumoServicioSuplementarioDocument
					.setCargaAbonoLimiteConsumoServicioSuplementario(cargarAbonoLimiteConsumoSSReq);
			logger.debug("cargarAbonoLimiteConsumoSSReq: " + cargarAbonoLimiteConsumoSSReq);
			response = stub
					.cargaAbonoLimiteConsumoServicioSuplementario(cargaAbonoLimiteConsumoServicioSuplementarioDocument);
			logger.debug("cargaAbonoLimiteConsumoServicioSuplementarioDocument: "
					+ cargaAbonoLimiteConsumoServicioSuplementarioDocument);
			cargaDTO = response.getCargaAbonoLimiteConsumoServicioSuplementarioResponse().getReturn();
			logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
			logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());
			r.setCodSujeto(codSujeto.longValue());
			r.setNombreCliente(cargaDTO.getNombreCliente());
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNumTransaccion(cargaDTO.getNumTransaccion());
			r.setCodError(cargaDTO.getCodError());
			r.setDesError(cargaDTO.getDesError());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.debug("codError: " + r.getCodError());
		logger.debug("desError: " + r.getDesError());
		logger.debug("numTransaccion: " + r.getNumTransaccion());
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/**
	 * @param codCliente
	 * @param nomUsuarioSCL
	 * @param pwd
	 * @param codEvento
	 * @return
	 * @throws PortalSACException
	 * 
	 * Método Auditado
	 */
	public CargaAjusteCExcepcionCargosSACDTO cargarAjusteCExcepcionCargos(Long codCliente, String nomUsuarioSCL,
			String pwd, String codEvento) throws PortalSACException
	{
		CargaAjusteCExcepcionCargosSACDTO r = new CargaAjusteCExcepcionCargosSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, null, codCliente, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);
			CargaAjusteCExcepcionCargosDTO cargaDTO = new CargaAjusteCExcepcionCargosDTO();
			cargaDTO.setCodCliente(codCliente.longValue());
			cargaDTO.setNomUsuarioSCL(nomUsuarioSCL);
			cargaDTO.setPassword(pwd);
			String urlWS = config.getString(CLAVE_URL_WS_AJUSTE_CEXCEPCION_CARGOS);

			Object[] args = new Object[] { cargaDTO };
			Class tipoRetorno = cargaDTO.getClass();

			final String metodo = "cargarAjusteCExcepcionCargos";
			final String accion = "urn:cargarAjusteCExcepcionCargos";

			cargaDTO = (CargaAjusteCExcepcionCargosDTO) WSSEGPortal.invocarMetodoWeb(args, metodo, urlWS, accion,
					tipoRetorno, ESPACIO_NOMBRES_FRANQUICIAS);
			if (cargaDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
				logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());
			}
			logger.debug("cargaDTO: " + cargaDTO);
			// Obtengo el arreglo causas de pago
			if (cargaDTO.getArrayCausasPagoVO() != null && cargaDTO.getArrayCausasPagoVO().length > 0)
			{
				CausasPagoVO[] arrayCausasPago = new CausasPagoVO[cargaDTO.getArrayCausasPagoVO().length];
				for (int i = 0; i < cargaDTO.getArrayCausasPagoVO().length; i++)
				{
					arrayCausasPago[i] = new CausasPagoVO();
					arrayCausasPago[i].setCodCauPago(cargaDTO.getArrayCausasPagoVO()[i].getCodCauPago());
					arrayCausasPago[i].setDesCauPago(cargaDTO.getArrayCausasPagoVO()[i].getDesCauPago());
				}
				r.setArrayCausasPagoVO(arrayCausasPago);
			}
			// Obtengo el arreglo folios facturas
			if (cargaDTO.getArrayFoliosFacturasVO() != null && cargaDTO.getArrayFoliosFacturasVO().length > 0)
			{
				FoliosFacturasSACVO[] arrayFoliosFactura = new FoliosFacturasSACVO[cargaDTO.getArrayFoliosFacturasVO().length];
				for (int i = 0; i < cargaDTO.getArrayFoliosFacturasVO().length; i++)
				{
					arrayFoliosFactura[i] = new FoliosFacturasSACVO();
					arrayFoliosFactura[i].setCodCentrEmi(cargaDTO.getArrayFoliosFacturasVO()[i].getCodCentrEmi());
					arrayFoliosFactura[i].setCodTipDocum(cargaDTO.getArrayFoliosFacturasVO()[i].getCodTipDocum());
					arrayFoliosFactura[i].setCodVendedor(cargaDTO.getArrayFoliosFacturasVO()[i].getCodVendedor());
					arrayFoliosFactura[i].setDesAbreviada(cargaDTO.getArrayFoliosFacturasVO()[i].getDesAbreviada());
					arrayFoliosFactura[i].setFecEfectividad(cargaDTO.getArrayFoliosFacturasVO()[i].getFecEfectividad());
					arrayFoliosFactura[i].setFecVencimiento(cargaDTO.getArrayFoliosFacturasVO()[i].getFecVencimiento());
					arrayFoliosFactura[i].setIndContado(cargaDTO.getArrayFoliosFacturasVO()[i].getIndContado());
					arrayFoliosFactura[i].setLetra(cargaDTO.getArrayFoliosFacturasVO()[i].getLetra());
					arrayFoliosFactura[i].setMonto(cargaDTO.getArrayFoliosFacturasVO()[i].getMonto());
					arrayFoliosFactura[i].setNroFolio(cargaDTO.getArrayFoliosFacturasVO()[i].getNroFolio());
					arrayFoliosFactura[i].setNroSecuencia(cargaDTO.getArrayFoliosFacturasVO()[i].getNroSecuencia());
					arrayFoliosFactura[i].setNumVenta(cargaDTO.getArrayFoliosFacturasVO()[i].getNumVenta());
					arrayFoliosFactura[i].setPrefPlaza(cargaDTO.getArrayFoliosFacturasVO()[i].getPrefPlaza());
				}
				r.setArrayFoliosFacturasVO(arrayFoliosFactura);
			}
			// Obtengo el arreglo notas debito
			if (cargaDTO.getArrayOrigenPagoVO() != null && cargaDTO.getArrayOrigenPagoVO().length > 0)
			{
				OrigenPagoVO[] arrayOrigenPago = new OrigenPagoVO[cargaDTO.getArrayOrigenPagoVO().length];
				for (int i = 0; i < cargaDTO.getArrayOrigenPagoVO().length; i++)
				{
					arrayOrigenPago[i] = new OrigenPagoVO();
					arrayOrigenPago[i].setCodOriPago(cargaDTO.getArrayOrigenPagoVO()[i].getCodOriPago());
					arrayOrigenPago[i].setDesOriPago(cargaDTO.getArrayOrigenPagoVO()[i].getDesOriPago());
				}
				r.setArrayOrigenPagoVO(arrayOrigenPago);
			}
			// Obtengo el arreglo notas credito
			if (cargaDTO.getArrayNotaCreditoVO() != null && cargaDTO.getArrayNotaCreditoVO().length > 0)
			{
				NotaCreditoVO[] arrayNotasCredito = new NotaCreditoVO[cargaDTO.getArrayNotaCreditoVO().length];
				for (int i = 0; i < cargaDTO.getArrayNotaCreditoVO().length; i++)
				{
					arrayNotasCredito[i] = new NotaCreditoVO();
					arrayNotasCredito[i].setCodNC(cargaDTO.getArrayNotaCreditoVO()[i].getCodNC());
					arrayNotasCredito[i].setDesNC(cargaDTO.getArrayNotaCreditoVO()[i].getDesNC());
				}
				r.setArrayNotaCreditoVO(arrayNotasCredito);
			}
			r.setCodCliente(codCliente.longValue());
			r.setNombreCliente(cargaDTO.getNombreCliente());
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setPassword(cargaDTO.getPassword());
			r.setSaldoCliente(cargaDTO.getSaldoCliente());
			r.setNumTransaccion(cargaDTO.getNumTransaccion());
			r.setCodError(cargaDTO.getCodError());
			r.setDesError(cargaDTO.getDesError());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** Auditado */
	public CargaAjusteCReversionCargosSACDTO cargarAjusteCReversionCargos(Long codCliente, String nomUsuarioSCL,
			String pwd, String codEvento) throws PortalSACException
	{
		CargaAjusteCReversionCargosSACDTO r = new CargaAjusteCReversionCargosSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, null, codCliente, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);

			CargaAjusteCReversionCargosDTO cargaDTO = new CargaAjusteCReversionCargosDTO();
			cargaDTO.setCodCliente(codCliente.longValue());
			cargaDTO.setNomUsuarioSCL(nomUsuarioSCL);
			cargaDTO.setPassword(pwd);

			String urlWS = config.getString(CLAVE_URL_WS_AJUSTE_CREVERSION_CARGOS);

			Object[] args = new Object[] { cargaDTO };
			Class tipoRetorno = cargaDTO.getClass();

			final String metodo = "cargarAjusteCReversionCargos";
			final String accion = "urn:cargarAjusteCReversionCargos";

			cargaDTO = (CargaAjusteCReversionCargosDTO) WSSEGPortal.invocarMetodoWeb(args, metodo, urlWS, accion,
					tipoRetorno, ESPACIO_NOMBRES_FRANQUICIAS);

			if (cargaDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
				logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());
			}

			logger.debug("cargaDTO : " + cargaDTO);

			// Obtengo el arreglo causas de pago
			if (cargaDTO.getArrayCausasPagoVO() != null && cargaDTO.getArrayCausasPagoVO().length > 0)
			{
				CausasPagoVO[] arrayCausasPago = new CausasPagoVO[cargaDTO.getArrayCausasPagoVO().length];
				for (int i = 0; i < cargaDTO.getArrayCausasPagoVO().length; i++)
				{
					arrayCausasPago[i] = new CausasPagoVO();
					arrayCausasPago[i].setCodCauPago(cargaDTO.getArrayCausasPagoVO()[i].getCodCauPago());
					arrayCausasPago[i].setDesCauPago(cargaDTO.getArrayCausasPagoVO()[i].getDesCauPago());
				}
				r.setArrayCausasPagoVO(arrayCausasPago);
			}

			// Obtengo el arreglo folios facturas
			if (cargaDTO.getArrayFoliosFacturasVO() != null && cargaDTO.getArrayFoliosFacturasVO().length > 0)
			{
				FoliosFacturasSACVO[] arrayFoliosFactura = new FoliosFacturasSACVO[cargaDTO.getArrayFoliosFacturasVO().length];
				for (int i = 0; i < cargaDTO.getArrayFoliosFacturasVO().length; i++)
				{
					arrayFoliosFactura[i] = new FoliosFacturasSACVO();
					arrayFoliosFactura[i].setCodCentrEmi(cargaDTO.getArrayFoliosFacturasVO()[i].getCodCentrEmi());
					arrayFoliosFactura[i].setCodTipDocum(cargaDTO.getArrayFoliosFacturasVO()[i].getCodTipDocum());
					arrayFoliosFactura[i].setCodVendedor(cargaDTO.getArrayFoliosFacturasVO()[i].getCodVendedor());
					arrayFoliosFactura[i].setDesAbreviada(cargaDTO.getArrayFoliosFacturasVO()[i].getDesAbreviada());
					arrayFoliosFactura[i].setFecEfectividad(cargaDTO.getArrayFoliosFacturasVO()[i].getFecEfectividad());
					arrayFoliosFactura[i].setFecVencimiento(cargaDTO.getArrayFoliosFacturasVO()[i].getFecVencimiento());
					arrayFoliosFactura[i].setIndContado(cargaDTO.getArrayFoliosFacturasVO()[i].getIndContado());
					arrayFoliosFactura[i].setLetra(cargaDTO.getArrayFoliosFacturasVO()[i].getLetra());
					arrayFoliosFactura[i].setMonto(cargaDTO.getArrayFoliosFacturasVO()[i].getMonto());
					arrayFoliosFactura[i].setNroFolio(cargaDTO.getArrayFoliosFacturasVO()[i].getNroFolio());
					arrayFoliosFactura[i].setNroSecuencia(cargaDTO.getArrayFoliosFacturasVO()[i].getNroSecuencia());
					arrayFoliosFactura[i].setNumVenta(cargaDTO.getArrayFoliosFacturasVO()[i].getNumVenta());
					arrayFoliosFactura[i].setPrefPlaza(cargaDTO.getArrayFoliosFacturasVO()[i].getPrefPlaza());
				}
				r.setArrayFoliosFacturasVO(arrayFoliosFactura);
			}

			// Obtengo el arreglo notas debito
			if (cargaDTO.getArrayNotaDebitoVO() != null && cargaDTO.getArrayNotaDebitoVO().length > 0)
			{
				NotaDebitoVO[] arrayNotasDebito = new NotaDebitoVO[cargaDTO.getArrayNotaDebitoVO().length];
				for (int i = 0; i < cargaDTO.getArrayNotaDebitoVO().length; i++)
				{
					arrayNotasDebito[i] = new NotaDebitoVO();
					arrayNotasDebito[i].setCodND(cargaDTO.getArrayNotaDebitoVO()[i].getCodND());
					arrayNotasDebito[i].setDesND(cargaDTO.getArrayNotaDebitoVO()[i].getDesND());
				}
				r.setArrayNotaDebitoVO(arrayNotasDebito);
			}

			// Obtengo el arreglo notas debito
			if (cargaDTO.getArrayOrigenPagoVO() != null && cargaDTO.getArrayOrigenPagoVO().length > 0)
			{
				OrigenPagoVO[] arrayOrigenPago = new OrigenPagoVO[cargaDTO.getArrayOrigenPagoVO().length];
				for (int i = 0; i < cargaDTO.getArrayOrigenPagoVO().length; i++)
				{
					arrayOrigenPago[i] = new OrigenPagoVO();
					arrayOrigenPago[i].setCodOriPago(cargaDTO.getArrayOrigenPagoVO()[i].getCodOriPago());
					arrayOrigenPago[i].setDesOriPago(cargaDTO.getArrayOrigenPagoVO()[i].getDesOriPago());
				}
				r.setArrayOrigenPagoVO(arrayOrigenPago);
			}

			r.setCodCliente(codCliente.longValue());
			r.setNombreCliente(cargaDTO.getNombreCliente());
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setPassword(cargaDTO.getPassword());
			r.setSaldoCliente(cargaDTO.getSaldoCliente());
			r.setNumTransaccion(cargaDTO.getNumTransaccion());
			r.setCodError(cargaDTO.getCodError());
			r.setDesError(cargaDTO.getDesError());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.CargaAnulacionSiniestroDTO cargarAnulacionSiniestro(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaAnulacionSiniestroDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaAnulacionSiniestroDTO();
		CargarAnulacionSiniestroResponseDocument response = null;
		CargaAnulacionSiniestroDTO cargaDTO = CargaAnulacionSiniestroDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, numAbonado, null, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);

			String urlWS = config.getString(CLAVE_URL_WS_ANULACION_SINIESTRO);

			WSAnulacionSiniestroStub stub = new WSAnulacionSiniestroStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);

			CargarAnulacionSiniestroDocument cargarAnulacionSiniestroDocument = CargarAnulacionSiniestroDocument.Factory
					.newInstance();
			CargarAnulacionSiniestro cargarAnulacionSiniestroReq = cargarAnulacionSiniestroDocument
					.addNewCargarAnulacionSiniestro();
			CargaAnulacionSiniestroDTO entrada = CargaAnulacionSiniestroDTO.Factory.newInstance();
			entrada.setNumAbonado(numAbonado.longValue());
			entrada.setNomUsuarioSCL(nomUsuarioSCL);
			cargarAnulacionSiniestroReq.setCargaAnulacionSiniestroDTO(entrada);
			cargarAnulacionSiniestroDocument.setCargarAnulacionSiniestro(cargarAnulacionSiniestroReq);
			logger.debug("cargarAnulacionSiniestro(Long, String, String) - cargarAnulacionSiniestro1: "
					+ cargarAnulacionSiniestroDocument);

			response = stub.cargarAnulacionSiniestro(cargarAnulacionSiniestroDocument);
			logger.debug("cargarAnulacionSiniestro(Long, String, String) - cargarAnulacionSiniestro2: "
					+ cargarAnulacionSiniestroDocument);

			cargaDTO = response.getCargarAnulacionSiniestroResponse().getReturn();

			logger.debug("cargarAnulacionSiniestro(Long, String, String) - cargarAnulacionSiniestro3");
			// Obtengo el arreglo siniestros
			if (cargaDTO.getArraySiniestrosVOArray() != null && cargaDTO.getArraySiniestrosVOArray().length > 0)
			{
				SiniestrosVO[] arraySiniestros = new SiniestrosVO[cargaDTO.getArraySiniestrosVOArray().length];
				for (int i = 0; i < cargaDTO.getArraySiniestrosVOArray().length; i++)
				{
					arraySiniestros[i] = new SiniestrosVO();
					arraySiniestros[i].setCodCausa(cargaDTO.getArraySiniestrosVOArray()[i].getCodCausa());
					arraySiniestros[i].setDesCausa(cargaDTO.getArraySiniestrosVOArray()[i].getDesCausa());
					arraySiniestros[i].setDesEstado(cargaDTO.getArraySiniestrosVOArray()[i].getDesEstado());
					arraySiniestros[i].setDesTipTerminal(cargaDTO.getArraySiniestrosVOArray()[i].getDesTipTerminal());
					arraySiniestros[i].setFecFormalizacion(cargaDTO.getArraySiniestrosVOArray()[i]
							.getFecFormalizacion());
					arraySiniestros[i].setFecSiniestro(cargaDTO.getArraySiniestrosVOArray()[i].getFecSiniestro());
					arraySiniestros[i].setNumConstancia(cargaDTO.getArraySiniestrosVOArray()[i].getNumConstancia());
					arraySiniestros[i].setNumSiniestro(cargaDTO.getArraySiniestrosVOArray()[i].getNumSiniestro());
					arraySiniestros[i].setObservacion(cargaDTO.getArraySiniestrosVOArray()[i].getObservacion());
				}
				r.setArraySiniestrosVO(arraySiniestros);
			}
			r.setCodError(cargaDTO.getCodError());
			r.setDesError(cargaDTO.getDesError());
			logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
			logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setNumAbonado(numAbonado.longValue());
			r.setNumCelular(cargaDTO.getNumCelular());
			r.setNumTransaccion(cargaDTO.getNumTransaccion());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.CargaCambioEquipoGSMDTO cargarCambioEquipoGSM(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaCambioEquipoGSMDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaCambioEquipoGSMDTO();
		CargarCambioEquipoGSMResponseDocument response = null;
		CargaCambioEquipoGSMDTO cargaDTO = CargaCambioEquipoGSMDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, numAbonado, null, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);
			String urlWS = config.getString(CLAVE_URL_WS_CAMBIO_EQUIPO_GSM);

			WSCambioEquipoGSMStub stub = new WSCambioEquipoGSMStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			CargarCambioEquipoGSMDocument cargarCambioEquipoGSMDocument = CargarCambioEquipoGSMDocument.Factory
					.newInstance();
			CargarCambioEquipoGSM cargarCambioEquipoGSMReq = cargarCambioEquipoGSMDocument
					.addNewCargarCambioEquipoGSM();
			CargaCambioEquipoGSMDTO entrada = CargaCambioEquipoGSMDTO.Factory.newInstance();
			entrada.setNomUsuarioSCL(nomUsuarioSCL);
			entrada.setNumAbonado(numAbonado.longValue());
			cargarCambioEquipoGSMReq.setCargaCambioEquipoGSMDTO(entrada);
			cargarCambioEquipoGSMDocument.setCargarCambioEquipoGSM(cargarCambioEquipoGSMReq);
			response = stub.cargarCambioEquipoGSM(cargarCambioEquipoGSMDocument);
			logger.debug("cargarCambioEquipoGSMDocument: " + cargarCambioEquipoGSMDocument);
			cargaDTO = response.getCargarCambioEquipoGSMResponse().getReturn();
			logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
			logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());
			// Obtengo el arreglo articulos
			if (cargaDTO.getArrayBloqueArticulosVOArray() != null
					&& cargaDTO.getArrayBloqueArticulosVOArray().length > 0)
			{
				BloqueArticulosVO[] arrayBloqueArticulos = new BloqueArticulosVO[cargaDTO
						.getArrayBloqueArticulosVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayBloqueArticulosVOArray().length; i++)
				{
					arrayBloqueArticulos[i] = new BloqueArticulosVO();
					final com.tmmas.scl.wsfranquicias.common.vo.firma.xsd.BloqueArticulosVO articuloVO = cargaDTO
							.getArrayBloqueArticulosVOArray()[i];
					arrayBloqueArticulos[i].setCodArt(articuloVO.getCodArt());
					arrayBloqueArticulos[i].setDesArt(articuloVO.getDesArt());
					logger.debug("articuloVO.getCodArt(): " + articuloVO.getCodArt() + ", articuloVO.getDesArt(): "
							+ articuloVO.getDesArt());
				}
				r.setArrayBloqueArticulosVO(arrayBloqueArticulos);
			}

			// Obtengo el arreglo usos
			if (cargaDTO.getArrayBloqueUsosVOArray() != null && cargaDTO.getArrayBloqueUsosVOArray().length > 0)
			{
				BloqueUsosVO[] arrayBloqueUsos = new BloqueUsosVO[cargaDTO.getArrayBloqueUsosVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayBloqueUsosVOArray().length; i++)
				{
					arrayBloqueUsos[i] = new BloqueUsosVO();
					arrayBloqueUsos[i].setCodUso(cargaDTO.getArrayBloqueUsosVOArray()[i].getCodUso());
					arrayBloqueUsos[i].setDesUso(cargaDTO.getArrayBloqueUsosVOArray()[i].getDesUso());
				}
				r.setArrayBloqueUsosVO(arrayBloqueUsos);
			}

			// Obtengo el arreglo de causas de cambio
			if (cargaDTO.getArrayCausasCambioVOArray() != null && cargaDTO.getArrayCausasCambioVOArray().length > 0)
			{
				CausasCambioVO[] arrayBloqueCausas = new CausasCambioVO[cargaDTO.getArrayCausasCambioVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayCausasCambioVOArray().length; i++)
				{
					arrayBloqueCausas[i] = new CausasCambioVO();
					arrayBloqueCausas[i].setCodCauCambio(cargaDTO.getArrayCausasCambioVOArray()[i].getCodCauCambio());
					arrayBloqueCausas[i].setDesCauCambio(cargaDTO.getArrayCausasCambioVOArray()[i].getDesCauCambio());
				}
				r.setArrayCausasCambioVO(arrayBloqueCausas);
			}

			r.setCodModVenta(cargaDTO.getCodModVenta());
			r.setDesEquipo(cargaDTO.getDesEquipo());
			r.setDesIndPropiedad(cargaDTO.getDesIndPropiedad());
			r.setDesModVenta(cargaDTO.getDesModVenta());
			r.setDesProcedEqui(cargaDTO.getDesProcedEqui());
			r.setDesTipContrato(cargaDTO.getDesTipContrato());
			r.setDesTipTerminal(cargaDTO.getDesTipTerminal());
			r.setDesUso(cargaDTO.getDesUso());
			r.setNombreUsuario(cargaDTO.getNombreUsuario());
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setNumAbonado(numAbonado.longValue());
			r.setNumCelular(cargaDTO.getNumCelular());
			r.setNumSerie(cargaDTO.getNumSerie());
			r.setNumSerieMec(cargaDTO.getNumSerieMec());

			r.setNumTransaccion(cargaDTO.getNumTransaccion());
			r.setCodError(cargaDTO.getCodError());
			r.setDesError(cargaDTO.getDesError());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.debug("codError: " + r.getCodError());
		logger.debug("desError: " + r.getDesError());
		logger.debug("numTransaccion: " + r.getNumTransaccion());
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.CargaCambioSIMCardDTO cargarCambioSIMCard(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaCambioSIMCardDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaCambioSIMCardDTO();
		CargarCambioSIMCardResponseDocument response = null;
		CargaCambioSIMCardDTO cargaDTO = CargaCambioSIMCardDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, numAbonado, null, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);

			String urlWS = config.getString(CLAVE_URL_WS_CAMBIO_SIMCARD_GSM);

			WSCambioSIMCardStub stub = new WSCambioSIMCardStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);

			CargarCambioSIMCardDocument cargarCambioSimcardDocument = CargarCambioSIMCardDocument.Factory.newInstance();
			CargarCambioSIMCard cargarCambioSimcardReq = cargarCambioSimcardDocument.addNewCargarCambioSIMCard();
			CargaCambioSIMCardDTO entrada = CargaCambioSIMCardDTO.Factory.newInstance();
			entrada.setNomUsuarioSCL(nomUsuarioSCL);
			entrada.setNumAbonado(numAbonado.longValue());

			cargarCambioSimcardReq.setCargaCambioSIMCardDTO(entrada);
			cargarCambioSimcardDocument.setCargarCambioSIMCard(cargarCambioSimcardReq);
			response = stub.cargarCambioSIMCard(cargarCambioSimcardDocument);
			logger.debug("cargarCambioSimcardDocument: " + cargarCambioSimcardDocument);
			cargaDTO = response.getCargarCambioSIMCardResponse().getReturn();
			logger.debug("cargaDTO.getNombreUsuario():" + cargaDTO.getNombreUsuario());
			logger.debug("cargaDTO.getNomUsuarioSCL():" + cargaDTO.getNomUsuarioSCL());
			logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
			logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());

			// Obtengo el arreglo usos
			if (cargaDTO.getArrayBloqueUsosVOArray() != null && cargaDTO.getArrayBloqueUsosVOArray().length > 0)
			{
				BloqueUsosVO[] arrayBloqueUsos = new BloqueUsosVO[cargaDTO.getArrayBloqueUsosVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayBloqueUsosVOArray().length; i++)
				{
					arrayBloqueUsos[i] = new BloqueUsosVO();
					arrayBloqueUsos[i].setCodUso(cargaDTO.getArrayBloqueUsosVOArray()[i].getCodUso());
					arrayBloqueUsos[i].setDesUso(cargaDTO.getArrayBloqueUsosVOArray()[i].getDesUso());
				}
				r.setArrayBloqueUsosVO(arrayBloqueUsos);
			}
			// Obtengo el arreglo de causas de cambio
			if (cargaDTO.getArrayCausasCambioVOArray() != null && cargaDTO.getArrayCausasCambioVOArray().length > 0)
			{
				CausasCambioVO[] arrayBloqueCausas = new CausasCambioVO[cargaDTO.getArrayCausasCambioVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayCausasCambioVOArray().length; i++)
				{
					arrayBloqueCausas[i] = new CausasCambioVO();
					arrayBloqueCausas[i].setCodCauCambio(cargaDTO.getArrayCausasCambioVOArray()[i].getCodCauCambio());
					arrayBloqueCausas[i].setDesCauCambio(cargaDTO.getArrayCausasCambioVOArray()[i].getDesCauCambio());
				}
				r.setArrayCausasCambioVO(arrayBloqueCausas);
			}
			// Obtengo el arreglo de tipos contrato
			if (cargaDTO.getArrayTiposContratosVOArray() != null && cargaDTO.getArrayTiposContratosVOArray().length > 0)
			{
				TiposContratosVO[] arrayTiposContrato = new TiposContratosVO[cargaDTO.getArrayTiposContratosVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayTiposContratosVOArray().length; i++)
				{
					arrayTiposContrato[i] = new TiposContratosVO();
					arrayTiposContrato[i].setCodTipContrato(cargaDTO.getArrayTiposContratosVOArray()[i]
							.getCodTipContrato());
					arrayTiposContrato[i].setDesTipContrato(cargaDTO.getArrayTiposContratosVOArray()[i]
							.getDesTipContrato());
					arrayTiposContrato[i].setVigContrato(cargaDTO.getArrayTiposContratosVOArray()[i].getVigContrato());
				}
				r.setArrayTiposContratosVO(arrayTiposContrato);
			}
			// Obtengo el arreglo de tipos terminales
			if (cargaDTO.getArrayTiposTerminalesVOArray() != null
					&& cargaDTO.getArrayTiposTerminalesVOArray().length > 0)
			{
				TiposTerminalesVO[] arrayTiposTerminales = new TiposTerminalesVO[cargaDTO
						.getArrayTiposTerminalesVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayTiposTerminalesVOArray().length; i++)
				{
					arrayTiposTerminales[i] = new TiposTerminalesVO();
					arrayTiposTerminales[i].setCodTipTerminal(cargaDTO.getArrayTiposTerminalesVOArray()[i]
							.getCodTipTerminal());
					arrayTiposTerminales[i].setDesTipTerminal(cargaDTO.getArrayTiposTerminalesVOArray()[i]
							.getDesTipTerminal());
				}
				r.setArrayTiposTerminalesVO(arrayTiposTerminales);
			}
			r.setCodModVenta(cargaDTO.getCodModVenta());
			r.setCodTec(cargaDTO.getCodTec());
			r.setDesEquipo(cargaDTO.getDesEquipo());
			r.setDesIndPropiedad(cargaDTO.getDesIndPropiedad());
			r.setDesModVenta(cargaDTO.getDesModVenta());
			r.setDesProcedEqui(cargaDTO.getDesProcedEqui());
			r.setDesTipTerminal(cargaDTO.getDesTipTerminal());
			r.setDesUso(cargaDTO.getDesUso());
			r.setIndProcedencia(cargaDTO.getIndProcedencia());
			r.setNombreUsuario(cargaDTO.getNombreUsuario());
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setNumAbonado(numAbonado.longValue());
			r.setNumSerie(cargaDTO.getNumSerie());
			r.setNumTransaccion(cargaDTO.getNumTransaccion());
			r.setCodError(cargaDTO.getCodError());
			r.setDesError(cargaDTO.getDesError());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.debug("codError: " + r.getCodError());
		logger.debug("desError: " + r.getDesError());
		logger.debug("numTransaccion: " + r.getNumTransaccion());
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** No Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimConDTO ejecutarAbonoLimiteConsumo(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimConDTO entrada) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimConDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimConDTO();
		EjecutarAbonoLimiteConsumoResponseDocument response = null;
		EjecucionAbonoLimConDTO ejecucionDTO = EjecucionAbonoLimConDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			String urlWS = config.getString(CLAVE_URL_WS_ABONO_LIMITE_CONSUMO);

			WSAbonoLimiteConsumoStub stub = new WSAbonoLimiteConsumoStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);

			EjecutarAbonoLimiteConsumoDocument ejecutarAbonoLimiteConsumoDocument = EjecutarAbonoLimiteConsumoDocument.Factory
					.newInstance();
			EjecutarAbonoLimiteConsumo ejecutarAbonoLimiteConsumoReq = ejecutarAbonoLimiteConsumoDocument
					.addNewEjecutarAbonoLimiteConsumo();
			EjecucionAbonoLimConDTO dto = EjecucionAbonoLimConDTO.Factory.newInstance();

			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			dto.setComentario(entrada.getComentario());
			dto.setMontoAbono(entrada.getMontoAbono());
			dto.setCodError(entrada.getCodError());
			dto.setDesError(entrada.getDesError());

			ejecutarAbonoLimiteConsumoReq.setEjecucionAbonoLimConDTO(dto);
			ejecutarAbonoLimiteConsumoDocument.setEjecutarAbonoLimiteConsumo(ejecutarAbonoLimiteConsumoReq);
			response = stub.ejecutarAbonoLimiteConsumo(ejecutarAbonoLimiteConsumoDocument);
			logger.debug("ejecutarAbonoLimiteConsumoDocument: " + ejecutarAbonoLimiteConsumoDocument);

			ejecucionDTO = response.getEjecutarAbonoLimiteConsumoResponse().getReturn();
			r.setNomUsuarioSCL(ejecucionDTO.getNomUsuarioSCL());

			logger.debug("ejecucionDTO.getCodError(): " + ejecucionDTO.getCodError());
			r.setCodError(ejecucionDTO.getCodError());
			logger.debug("ejecucionDTO.getDesError(): " + ejecucionDTO.getDesError());
			r.setDesError(ejecucionDTO.getDesError());

			logger.debug("ejecucionDTO.getNroOOSS(): " + ejecucionDTO.getNroOOSS());
			r.setNroOOSS(ejecucionDTO.getNroOOSS());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** No Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimiteConsumoServicioSuplementarioDTO ejecutarAbonoLimiteConsumoSS(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimiteConsumoServicioSuplementarioDTO entrada)
			throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimiteConsumoServicioSuplementarioDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimiteConsumoServicioSuplementarioDTO();
		EjecucionAbonoLimiteConsumoServicioSuplementarioResponseDocument response = null;
		EjecucionAbonoLimiteConsumoServicioSuplementarioDTO ejecucionDTO = EjecucionAbonoLimiteConsumoServicioSuplementarioDTO.Factory
				.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			String urlWS = config.getString(CLAVE_URL_WS_ABONO_LIMITE_CONSUMO_SERVICIO_SUPLEMENTARIO);

			WSAbonoLimiteConsumoServicioSuplementarioStub stub = new WSAbonoLimiteConsumoServicioSuplementarioStub(
					urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);

			EjecucionAbonoLimiteConsumoServicioSuplementarioDocument ejecutarAbonoLimiteConsumoDocument = EjecucionAbonoLimiteConsumoServicioSuplementarioDocument.Factory
					.newInstance();

			EjecucionAbonoLimiteConsumoServicioSuplementario ejecutarAbonoLimiteConsumoReq = ejecutarAbonoLimiteConsumoDocument
					.addNewEjecucionAbonoLimiteConsumoServicioSuplementario();

			EjecucionAbonoLimiteConsumoServicioSuplementarioDTO dto = EjecucionAbonoLimiteConsumoServicioSuplementarioDTO.Factory
					.newInstance();

			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			dto.setComentario(entrada.getComentario());
			dto.setCodError(entrada.getCodError());
			dto.setDesError(entrada.getDesError());

			ejecutarAbonoLimiteConsumoReq.setEjecucionAbonoLimiteConsumoServicioSuplementarioDTO(dto);
			ejecutarAbonoLimiteConsumoDocument
					.setEjecucionAbonoLimiteConsumoServicioSuplementario(ejecutarAbonoLimiteConsumoReq);
			logger.debug("ejecutarAbonoLimiteConsumoDocument: " + ejecutarAbonoLimiteConsumoDocument);
			response = stub.ejecucionAbonoLimiteConsumoServicioSuplementario(ejecutarAbonoLimiteConsumoDocument);
			ejecucionDTO = response.getEjecucionAbonoLimiteConsumoServicioSuplementarioResponse().getReturn();

			r.setNomUsuarioSCL(ejecucionDTO.getNomUsuarioSCL());
			logger.debug("ejecucionDTO.getCodError(): " + ejecucionDTO.getCodError());
			r.setCodError(ejecucionDTO.getCodError());
			logger.debug("ejecucionDTO.getDesError(): " + ejecucionDTO.getDesError());
			r.setDesError(ejecucionDTO.getDesError());
			logger.debug("ejecucionDTO.getNroOOSS(): " + ejecucionDTO.getNroOOSS());
			r.setNroOOSS(ejecucionDTO.getNroOOSS());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/**
	 * @param entrada
	 * @return
	 * @throws PortalSACException
	 *             No Auditado
	 */
	public EjecucionAjusteCExcepcionCargosDTO ejecutarAjusteCExcepcionCargos(
			EjecucionAjusteCExcepcionCargosSACDTO entrada) throws PortalSACException
	{
		EjecucionAjusteCExcepcionCargosDTO r = new EjecucionAjusteCExcepcionCargosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			EjecucionAjusteCExcepcionCargosDTO ejecucionDTO = new EjecucionAjusteCExcepcionCargosDTO();

			logger.debug("entrada.getCodCauPago(): " + entrada.getCodCauPago());
			ejecucionDTO.setCodCauPago(entrada.getCodCauPago());
			logger.debug("entrada.getCodOriPago(): " + entrada.getCodOriPago());
			ejecucionDTO.setCodOriPago(entrada.getCodOriPago());
			logger.debug("entrada.getMontoTotalAjuste(): " + entrada.getMontoTotalAjuste());
			ejecucionDTO.setMontoTotalAjuste(entrada.getMontoTotalAjuste());
			logger.debug("entrada.getCodNC(): " + entrada.getCodNC());
			ejecucionDTO.setCodNC(entrada.getCodNC());
			logger.debug("entrada.getDesNC(): " + entrada.getDesNC());
			ejecucionDTO.setDesNC(entrada.getDesNC());
			logger.debug("entrada.getObservacion(): " + entrada.getObservacion());
			ejecucionDTO.setObservacion(entrada.getObservacion());
			logger.debug("entrada.getTipoAjuste(): " + entrada.getTipoAjuste());
			ejecucionDTO.setTipoAjuste(entrada.getTipoAjuste());
			logger.debug("entrada.getNomUsuarioSCL(): " + entrada.getNomUsuarioSCL());
			ejecucionDTO.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			logger.debug("entrada.getNroOOSS(): " + entrada.getNroOOSS());
			ejecucionDTO.setNroOOSS(entrada.getNroOOSS());
			logger.debug("entrada.getNumTransaccion(): " + entrada.getNumTransaccion());
			ejecucionDTO.setNumTransaccion(entrada.getNumTransaccion());

			if (entrada.getArrayDetalleAjusteSACVO() != null)
			{
				final DetalleAjusteSACVO[] arrayDetalleAjusteSACVO = entrada.getArrayDetalleAjusteSACVO();
				final int l = arrayDetalleAjusteSACVO.length;
				DetalleAjusteVO[] arrayDetalleAjusteVO = new DetalleAjusteVO[l];

				for (int i = 0; i < l; i++)
				{
					DetalleAjusteSACVO sacVO = arrayDetalleAjusteSACVO[i];
					DetalleAjusteVO vo = new DetalleAjusteVO();

					vo.setCodCentrEmi(sacVO.getCodCentrEmi());
					logger.debug("getCodCentrEmi(): " + vo.getCodCentrEmi());

					vo.setCodProducto(sacVO.getCodProducto());
					logger.debug("getCodProducto(): " + vo.getCodProducto());

					vo.setCodTipDocum(sacVO.getCodTipDocum());
					logger.debug("getCodTipDocum(): " + vo.getCodTipDocum());

					vo.setCodVendedor(sacVO.getCodVendedor());
					logger.debug("getCodVendedor(): " + vo.getCodVendedor());

					vo.setImporteConcepto(sacVO.getImporteConcepto());
					logger.debug("getImporteConcepto(): " + vo.getImporteConcepto());

					vo.setLetra(sacVO.getLetra());
					logger.debug("getLetra(): " + vo.getLetra());

					vo.setMonto(sacVO.getMonto());
					logger.debug("getMonto(): " + vo.getMonto());

					vo.setNroSecuencia(sacVO.getNroSecuencia());
					logger.debug("getNroSecuencia(): " + vo.getNroSecuencia());

					vo.setNumAbonado(sacVO.getNumAbonado());
					logger.debug("getNumAbonado(): " + vo.getNumAbonado());

					arrayDetalleAjusteVO[i] = vo;
				}
				ejecucionDTO.setArrayDetalleAjusteVO(arrayDetalleAjusteVO);
			}

			String urlWS = config.getString(CLAVE_URL_WS_AJUSTE_CEXCEPCION_CARGOS);

			Object[] args = new Object[] { ejecucionDTO };
			Class tipoRetorno = ejecucionDTO.getClass();

			final String metodo = "ejecutarAjusteCExcepcionCargos";
			final String accion = "urn:ejecutarAjusteCExcepcionCargos";

			ejecucionDTO = (EjecucionAjusteCExcepcionCargosDTO) WSSEGPortal.invocarMetodoWeb(args, metodo, urlWS,
					accion, tipoRetorno, ESPACIO_NOMBRES_FRANQUICIAS);

			if (ejecucionDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("ejecucionDTO.getCodError(): " + ejecucionDTO.getCodError());
				logger.debug("ejecucionDTO.getDesError(): " + ejecucionDTO.getDesError());
			}
			logger.debug("ejecucionDTO: " + ejecucionDTO);
			r.setNumTransaccion(ejecucionDTO.getNumTransaccion());
			r.setCodError(ejecucionDTO.getCodError());
			r.setDesError(ejecucionDTO.getDesError());
			r.setNroOOSS(ejecucionDTO.getNroOOSS());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/**
	 * @param entrada
	 * @return
	 * @throws PortalSACException
	 *             No Auditado
	 */
	public EjecucionAjusteCReversionCargosDTO ejecutarAjusteCReversionCargos(
			EjecucionAjusteCReversionCargosSACDTO entrada) throws PortalSACException
	{
		EjecucionAjusteCReversionCargosDTO r = new EjecucionAjusteCReversionCargosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			EjecucionAjusteCReversionCargosDTO ejecucionDTO = new EjecucionAjusteCReversionCargosDTO();

			logger.debug("entrada.getCodCauPago(): " + entrada.getCodCauPago());
			ejecucionDTO.setCodCauPago(entrada.getCodCauPago());
			logger.debug("entrada.getCodND(): " + entrada.getCodND());
			ejecucionDTO.setCodND(entrada.getCodND());
			logger.debug("entrada.getCodOriPago(): " + entrada.getCodOriPago());
			ejecucionDTO.setCodOriPago(entrada.getCodOriPago());
			logger.debug("entrada.getDesND(): " + entrada.getDesND());
			ejecucionDTO.setDesND(entrada.getDesND());
			logger.debug("entrada.getFecVencimiento(): " + entrada.getFecVencimiento());
			ejecucionDTO.setFecVencimiento(entrada.getFecVencimiento());
			logger.debug("entrada.getMontoTotalAjuste(): " + entrada.getMontoTotalAjuste());
			ejecucionDTO.setMontoTotalAjuste(entrada.getMontoTotalAjuste());
			logger.debug("entrada.getObservacion(): " + entrada.getObservacion());
			ejecucionDTO.setObservacion(entrada.getObservacion());
			logger.debug("entrada.getNomUsuarioSCL(): " + entrada.getNomUsuarioSCL());
			ejecucionDTO.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			logger.debug("entrada.getNroOOSS(): " + entrada.getNroOOSS());
			ejecucionDTO.setNroOOSS(entrada.getNroOOSS());
			logger.debug("entrada.getNumTransaccion(): " + entrada.getNumTransaccion());
			ejecucionDTO.setNumTransaccion(entrada.getNumTransaccion());
			logger.debug("entrada.getTipoAjuste(): " + entrada.getTipoAjuste());
			ejecucionDTO.setTipoAjuste(entrada.getTipoAjuste());

			if (entrada.getArrayDetalleAjusteSACVO() != null)
			{
				final DetalleAjusteSACVO[] arrayDetalleAjusteSACVO = entrada.getArrayDetalleAjusteSACVO();
				final int l = arrayDetalleAjusteSACVO.length;
				DetalleAjusteVO[] arrayDetalleAjusteVO = new DetalleAjusteVO[l];

				for (int i = 0; i < l; i++)
				{
					DetalleAjusteSACVO sacVO = arrayDetalleAjusteSACVO[i];
					DetalleAjusteVO vo = new DetalleAjusteVO();

					vo.setCodCentrEmi(sacVO.getCodCentrEmi());
					logger.debug("getCodCentrEmi(): " + vo.getCodCentrEmi());

					vo.setCodProducto(sacVO.getCodProducto());
					logger.debug("getCodProducto(): " + vo.getCodProducto());

					vo.setCodTipDocum(sacVO.getCodTipDocum());
					logger.debug("getCodTipDocum(): " + vo.getCodTipDocum());

					vo.setCodVendedor(sacVO.getCodVendedor());
					logger.debug("getCodVendedor(): " + vo.getCodVendedor());

					vo.setImporteConcepto(sacVO.getImporteConcepto());
					logger.debug("getImporteConcepto(): " + vo.getImporteConcepto());

					vo.setLetra(sacVO.getLetra());
					logger.debug("getLetra(): " + vo.getLetra());

					vo.setMonto(sacVO.getMonto());
					logger.debug("getMonto(): " + vo.getMonto());

					vo.setNroSecuencia(sacVO.getNroSecuencia());
					logger.debug("getNroSecuencia(): " + vo.getNroSecuencia());

					vo.setNumAbonado(sacVO.getNumAbonado());
					logger.debug("getNumAbonado(): " + vo.getNumAbonado());

					arrayDetalleAjusteVO[i] = vo;
				}
				ejecucionDTO.setArrayDetalleAjusteVO(arrayDetalleAjusteVO);
			}

			String urlWS = config.getString(CLAVE_URL_WS_AJUSTE_CREVERSION_CARGOS);

			Object[] args = new Object[] { ejecucionDTO };
			Class tipoRetorno = ejecucionDTO.getClass();

			final String metodo = "ejecutarAjusteCReversionCargos";
			final String accion = "urn:ejecutarAjusteCReversionCargos";

			ejecucionDTO = (EjecucionAjusteCReversionCargosDTO) WSSEGPortal.invocarMetodoWeb(args, metodo, urlWS,
					accion, tipoRetorno, ESPACIO_NOMBRES_FRANQUICIAS);

			if (ejecucionDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("ejecucionDTO.getCodError(): " + ejecucionDTO.getCodError());
				logger.debug("ejecucionDTO.getDesError(): " + ejecucionDTO.getDesError());
			}
			logger.debug("ejecucionDTO: " + ejecucionDTO);
			r.setNumTransaccion(ejecucionDTO.getNumTransaccion());
			r.setCodError(ejecucionDTO.getCodError());
			r.setDesError(ejecucionDTO.getDesError());
			r.setNroOOSS(ejecucionDTO.getNroOOSS());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** No Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionAnulacionSiniestroDTO ejecutarAnulacionSiniestro(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionAnulacionSiniestroDTO entrada) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionAnulacionSiniestroDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionAnulacionSiniestroDTO();
		EjecutarAnulacionSiniestroResponseDocument response = null;
		EjecucionAnulacionSiniestroDTO ejecucionDTO = EjecucionAnulacionSiniestroDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			String urlWS = config.getString(CLAVE_URL_WS_ANULACION_SINIESTRO);
			WSAnulacionSiniestroStub stub = new WSAnulacionSiniestroStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			EjecutarAnulacionSiniestroDocument ejecutarAnulacionSiniestroDocument = EjecutarAnulacionSiniestroDocument.Factory
					.newInstance();
			EjecutarAnulacionSiniestro ejecutarAnulacionSiniestroReq = ejecutarAnulacionSiniestroDocument
					.addNewEjecutarAnulacionSiniestro();
			EjecucionAnulacionSiniestroDTO dto = EjecucionAnulacionSiniestroDTO.Factory.newInstance();
			dto.setComentario(entrada.getComentario());
			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNroOOSS(entrada.getNroOOSS());
			dto.setNumConstancia(entrada.getNumConstancia());
			dto.setNumSiniestro(entrada.getNumSiniestro());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			dto.setObservacion(entrada.getObservacion());
			ejecutarAnulacionSiniestroReq.setEjecucionAnulacionSiniestroDTO(dto);
			ejecutarAnulacionSiniestroDocument.setEjecutarAnulacionSiniestro(ejecutarAnulacionSiniestroReq);
			logger.debug("ejecutarAnulacionSiniestroDocument: " + ejecutarAnulacionSiniestroDocument);
			response = stub.ejecutarAnulacionSiniestro(ejecutarAnulacionSiniestroDocument);
			ejecucionDTO = response.getEjecutarAnulacionSiniestroResponse().getReturn();
			r.setNomUsuarioSCL(entrada.getNomUsuarioSCL());

			logger.debug("ejecucionDTO.getCodError(): " + ejecucionDTO.getCodError());
			r.setCodError(ejecucionDTO.getCodError());
			logger.debug("ejecucionDTO.getDesError(): " + ejecucionDTO.getDesError());
			r.setDesError(ejecucionDTO.getDesError());
			logger.debug("ejecucionDTO.getNroOOSS(): " + ejecucionDTO.getNroOOSS());
			r.setNroOOSS(ejecucionDTO.getNroOOSS());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.debug("codError: " + r.getCodError());
		logger.debug("desError: " + r.getDesError());
		logger.debug("numTransaccion: " + r.getNumTransaccion());
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** No Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioEquipoGSMDTO ejecutarCambioEquipoGSM(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioEquipoGSMDTO entrada) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioEquipoGSMDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioEquipoGSMDTO();
		EjecutarCambioEquipoGSMResponseDocument response = null;
		EjecucionCambioEquipoGSMDTO ejecucionDTO = EjecucionCambioEquipoGSMDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			String urlWS = config.getString(CLAVE_URL_WS_CAMBIO_EQUIPO_GSM);
			WSCambioEquipoGSMStub stub = new WSCambioEquipoGSMStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			EjecutarCambioEquipoGSMDocument ejecutarCambioEquipoGSMDocument = EjecutarCambioEquipoGSMDocument.Factory
					.newInstance();
			EjecutarCambioEquipoGSM ejecutarCambioEquipoGSMReq = ejecutarCambioEquipoGSMDocument
					.addNewEjecutarCambioEquipoGSM();
			EjecucionCambioEquipoGSMDTO dto = EjecucionCambioEquipoGSMDTO.Factory.newInstance();

			dto.setCodArt(entrada.getCodArt());
			dto.setCodCauCambio(entrada.getCodCauCambio());
			dto.setCodTipTerminal(entrada.getCodTipTerminal());
			dto.setCodUso(entrada.getCodUso());
			dto.setComentario(entrada.getComentario());
			if (entrada.getILargoSerie() != null)
			{
				dto.setILargoSerie(entrada.getILargoSerie());
			}
			else
			{
				dto.setILargoSerie(entrada.getNumSerie().length() + "");
			}
			dto.setIndProcedencia(entrada.getIndProcedencia());
			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNroOOSS(entrada.getNroOOSS());
			dto.setNumSerie(entrada.getNumSerie());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			ejecutarCambioEquipoGSMReq.setEjecucionCambioEquipoGSMDTO(dto);
			ejecutarCambioEquipoGSMDocument.setEjecutarCambioEquipoGSM(ejecutarCambioEquipoGSMReq);
			response = stub.ejecutarCambioEquipoGSM(ejecutarCambioEquipoGSMDocument);
			logger.debug("ejecutarCambioEquipoGSMDocument: " + ejecutarCambioEquipoGSMDocument);
			ejecucionDTO = response.getEjecutarCambioEquipoGSMResponse().getReturn();
			logger.debug("ejecucionDTO.getCodError(): " + ejecucionDTO.getCodError());
			r.setCodError(ejecucionDTO.getCodError());
			logger.debug("ejecucionDTO.getDesError(): " + ejecucionDTO.getDesError());
			r.setDesError(ejecucionDTO.getDesError());
			r.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			logger.debug("ejecucionDTO.getNroOOSS(): " + ejecucionDTO.getNroOOSS());
			r.setNroOOSS(ejecucionDTO.getNroOOSS());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.debug("codError: " + r.getCodError());
		logger.debug("desError: " + r.getDesError());
		logger.debug("numTransaccion: " + r.getNumTransaccion());
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** No Auditado */
	public EjecucionCambioNumFrecuentesSACDTO ejecutarCambioNumFrecuente(EjecucionCambioNumFrecuentesSACDTO entrada)
			throws PortalSACException
	{
		EjecucionCambioNumFrecuentesSACDTO r = new EjecucionCambioNumFrecuentesSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			EjecucionCambioNumFrecuentesDTO ejecucionDTO = new EjecucionCambioNumFrecuentesDTO();

			logger.debug(entrada.toString());

			ejecucionDTO.setComentario(entrada.getComentario());
			ejecucionDTO.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			ejecucionDTO.setNumAbonado(entrada.getNumAbonado());
			ejecucionDTO.setNumTransaccion(entrada.getNumTransaccion());

			ejecucionDTO.setCodError(entrada.getCodError());
			ejecucionDTO.setDesError(entrada.getDesError());
			ejecucionDTO.setNroOOSS(entrada.getNroOOSS());

			ejecucionDTO.setBloqueNumFrecuentePlanTarifarioEliminar(entrada
					.getBloqueNumFrecuentePlanTarifarioEliminar());

			ejecucionDTO.setBloqueNumFrecuentePlanTarifarioInsertar(entrada
					.getBloqueNumFrecuentePlanTarifarioInsertar());

			String urlWS = config.getString(CLAVE_URL_WS_CAMBIO_NUM_FRECUENTES);

			Object[] args = new Object[] { ejecucionDTO };
			Class tipoRetorno = ejecucionDTO.getClass();

			ejecucionDTO = (EjecucionCambioNumFrecuentesDTO) WSSEGPortal.invocarMetodoWeb(args,
					"ejecutarCambioNumFrecuente", urlWS, "urn:ejecutarCambioNumFrecuente", tipoRetorno,
					ESPACIO_NOMBRES_FRANQUICIAS);

			if (ejecucionDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("CodError: " + ejecucionDTO.getCodError());
				r.setCodError(ejecucionDTO.getCodError());
				logger.debug("DesError: " + ejecucionDTO.getDesError());
				r.setDesError(ejecucionDTO.getDesError());
				logger.debug("NroOOSS: " + ejecucionDTO.getNroOOSS());
				r.setNroOOSS(ejecucionDTO.getNroOOSS());
			}
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** No Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioSIMCardDTO ejecutarCambioSIMCard(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioSIMCardDTO entrada) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioSIMCardDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioSIMCardDTO();
		EjecutarCambioSIMCardResponseDocument response = null;
		EjecucionCambioSIMCardDTO ejecucionDTO = EjecucionCambioSIMCardDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			String urlWS = config.getString(CLAVE_URL_WS_CAMBIO_SIMCARD_GSM);
			logger.debug("urlWS: " + urlWS);

			WSCambioSIMCardStub stub = new WSCambioSIMCardStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);

			EjecutarCambioSIMCardDocument ejecutarCambioSimcardDocument = EjecutarCambioSIMCardDocument.Factory
					.newInstance();

			EjecutarCambioSIMCard ejecutarCambioSimcardReq = ejecutarCambioSimcardDocument
					.addNewEjecutarCambioSIMCard();
			EjecucionCambioSIMCardDTO dto = EjecucionCambioSIMCardDTO.Factory.newInstance();

			dto.setCodCauCambio(entrada.getCodCauCambio());
			dto.setCodUso(entrada.getCodUso());
			dto.setComentario(entrada.getComentario());
			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNroOOSS(entrada.getNroOOSS());
			dto.setNumSerie(entrada.getNumSerie());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			dto.setTipTerminal(entrada.getTipTerminal());

			String codModVenta = config.getString(CLAVE_CAMBIO_SIMCARD_GSM_COD_MOD_VENTA);
			logger.debug("codModVenta: " + codModVenta);

			dto.setCodModVenta(new Long(codModVenta).longValue());

			ejecutarCambioSimcardReq.setEjecucionCambioSIMCardDTO(dto);
			ejecutarCambioSimcardDocument.setEjecutarCambioSIMCard(ejecutarCambioSimcardReq);
			response = stub.ejecutarCambioSIMCard(ejecutarCambioSimcardDocument);
			logger.debug("ejecutarCambioSimcardDocument: " + ejecutarCambioSimcardDocument);

			ejecucionDTO = response.getEjecutarCambioSIMCardResponse().getReturn();
			logger.debug("ejecucionDTO.getCodError(): " + ejecucionDTO.getCodError());
			r.setCodError(ejecucionDTO.getCodError());
			logger.debug("ejecucionDTO.getDesError(): " + ejecucionDTO.getDesError());
			r.setDesError(ejecucionDTO.getDesError());
			r.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			logger.debug("ejecucionDTO.getNroOOSS(): " + ejecucionDTO.getNroOOSS());
			r.setNroOOSS(ejecucionDTO.getNroOOSS());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.debug("codError: " + r.getCodError());
		logger.debug("desError: " + r.getDesError());
		logger.debug("numTransaccion: " + r.getNumTransaccion());
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** No Auditado */
	public FiltroDetDocAjusteCCargosSACDTO filtrarDetDocAjusteCExcepcionCargos(FiltroDetDocAjusteCCargosSACDTO entrada)
			throws PortalSACException
	{
		FiltroDetDocAjusteCCargosSACDTO r = new FiltroDetDocAjusteCCargosSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			FiltroDetDocAjusteCExcepcionCargosDTO filtroDTO = new FiltroDetDocAjusteCExcepcionCargosDTO();
			filtroDTO.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			filtroDTO.setNumTransaccion(entrada.getNumTransaccion());
			filtroDTO.setCodCentrEmi(entrada.getCodCentrEmi());
			filtroDTO.setCodTipDocum(entrada.getCodTipDocum());
			filtroDTO.setCodVendedor(entrada.getCodVendedor());
			filtroDTO.setLetra(entrada.getLetra());
			filtroDTO.setNroSecuencia(entrada.getNroSecuencia());
			filtroDTO.setNroOOSS(1);

			String urlWS = config.getString(CLAVE_URL_WS_AJUSTE_CEXCEPCION_CARGOS);

			Object[] args = new Object[] { filtroDTO };
			Class tipoRetorno = filtroDTO.getClass();

			final String metodo = "filtrarDetDocAjusteCExcepcionCargos";
			final String accion = "urn:filtrarDetDocAjusteCExcepcionCargos";
			filtroDTO = (FiltroDetDocAjusteCExcepcionCargosDTO) WSSEGPortal.invocarMetodoWeb(args, metodo, urlWS,
					accion, tipoRetorno, ESPACIO_NOMBRES_FRANQUICIAS);

			if (filtroDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("filtroDTO.getCodError(): " + filtroDTO.getCodError());
				logger.debug("filtroDTO.getDesError(): " + filtroDTO.getDesError());
			}
			logger.debug("filtroDTO: " + filtroDTO);

			// Obtengo el arreglo causas de pago
			if (filtroDTO.getArrayDetalleDocumentoVO() != null && filtroDTO.getArrayDetalleDocumentoVO().length > 0)
			{
				DetalleDocumentoSACVO[] arrayDetalleDocumento = new DetalleDocumentoSACVO[filtroDTO
						.getArrayDetalleDocumentoVO().length];
				for (int i = 0; i < filtroDTO.getArrayDetalleDocumentoVO().length; i++)
				{
					arrayDetalleDocumento[i] = new DetalleDocumentoSACVO();
					arrayDetalleDocumento[i].setCodCentrEmi(filtroDTO.getArrayDetalleDocumentoVO()[i].getCodCentrEmi());
					arrayDetalleDocumento[i].setCodProducto(filtroDTO.getArrayDetalleDocumentoVO()[i].getCodProducto());
					arrayDetalleDocumento[i].setCodTipDocum(filtroDTO.getArrayDetalleDocumentoVO()[i].getCodTipDocum());
					arrayDetalleDocumento[i].setCodVendedor(filtroDTO.getArrayDetalleDocumentoVO()[i].getCodVendedor());
					arrayDetalleDocumento[i].setDesProducto(filtroDTO.getArrayDetalleDocumentoVO()[i].getDesProducto());
					arrayDetalleDocumento[i].setIndContado(filtroDTO.getArrayDetalleDocumentoVO()[i].getIndContado());
					arrayDetalleDocumento[i].setLetra(filtroDTO.getArrayDetalleDocumentoVO()[i].getLetra());
					arrayDetalleDocumento[i].setMonto(filtroDTO.getArrayDetalleDocumentoVO()[i].getMonto());
					arrayDetalleDocumento[i].setNroSecuencia(filtroDTO.getArrayDetalleDocumentoVO()[i]
							.getNroSecuencia());
					arrayDetalleDocumento[i].setNumAbonado(filtroDTO.getArrayDetalleDocumentoVO()[i].getNumAbonado());
				}
				r.setArrayDetalleDocumentoVO(arrayDetalleDocumento);
			}
			logger.debug("filtroDTO.getNumTransaccion(): " + filtroDTO.getNumTransaccion());
			r.setNumTransaccion(filtroDTO.getNumTransaccion());

			logger.debug("filtroDTO.getCodError(): " + filtroDTO.getCodError());
			r.setCodError(filtroDTO.getCodError());

			logger.debug("filtroDTO.getDesError(): " + filtroDTO.getDesError());
			r.setDesError(filtroDTO.getDesError());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** No Auditado */
	public FiltroDetDocAjusteCCargosSACDTO filtrarDetDocAjusteCReversionCargos(FiltroDetDocAjusteCCargosSACDTO entrada)
			throws PortalSACException
	{
		FiltroDetDocAjusteCCargosSACDTO r = new FiltroDetDocAjusteCCargosSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			FiltroDetDocAjusteCReversionCargosDTO filtroDTO = new FiltroDetDocAjusteCReversionCargosDTO();
			filtroDTO.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			filtroDTO.setNumTransaccion(entrada.getNumTransaccion());
			filtroDTO.setCodCentrEmi(entrada.getCodCentrEmi());
			filtroDTO.setCodTipDocum(entrada.getCodTipDocum());
			filtroDTO.setCodVendedor(entrada.getCodVendedor());
			filtroDTO.setLetra(entrada.getLetra());
			filtroDTO.setNroSecuencia(entrada.getNroSecuencia());
			filtroDTO.setNroOOSS(1);
			String urlWS = config.getString(CLAVE_URL_WS_AJUSTE_CREVERSION_CARGOS);

			Object[] args = new Object[] { filtroDTO };
			Class tipoRetorno = filtroDTO.getClass();

			final String metodo = "filtrarDetDocAjusteCReversionCargos";
			final String accion = "urn:filtrarDetDocAjusteCReversionCargos";
			filtroDTO = (FiltroDetDocAjusteCReversionCargosDTO) WSSEGPortal.invocarMetodoWeb(args, metodo, urlWS,
					accion, tipoRetorno, ESPACIO_NOMBRES_FRANQUICIAS);
			if (filtroDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("filtroDTO.getCodError(): " + filtroDTO.getCodError());
				logger.debug("filtroDTO.getDesError(): " + filtroDTO.getDesError());
			}
			logger.debug("filtroDTO: " + filtroDTO);

			// Obtengo el arreglo causas de pago
			if (filtroDTO.getArrayDetalleDocumentoVO() != null && filtroDTO.getArrayDetalleDocumentoVO().length > 0)
			{
				DetalleDocumentoSACVO[] arrayDetalleDocumento = new DetalleDocumentoSACVO[filtroDTO
						.getArrayDetalleDocumentoVO().length];
				for (int i = 0; i < filtroDTO.getArrayDetalleDocumentoVO().length; i++)
				{
					arrayDetalleDocumento[i] = new DetalleDocumentoSACVO();
					arrayDetalleDocumento[i].setCodCentrEmi(filtroDTO.getArrayDetalleDocumentoVO()[i].getCodCentrEmi());
					arrayDetalleDocumento[i].setCodProducto(filtroDTO.getArrayDetalleDocumentoVO()[i].getCodProducto());
					arrayDetalleDocumento[i].setCodTipDocum(filtroDTO.getArrayDetalleDocumentoVO()[i].getCodTipDocum());
					arrayDetalleDocumento[i].setCodVendedor(filtroDTO.getArrayDetalleDocumentoVO()[i].getCodVendedor());
					arrayDetalleDocumento[i].setDesProducto(filtroDTO.getArrayDetalleDocumentoVO()[i].getDesProducto());
					arrayDetalleDocumento[i].setIndContado(filtroDTO.getArrayDetalleDocumentoVO()[i].getIndContado());
					arrayDetalleDocumento[i].setLetra(filtroDTO.getArrayDetalleDocumentoVO()[i].getLetra());
					arrayDetalleDocumento[i].setMonto(filtroDTO.getArrayDetalleDocumentoVO()[i].getMonto());
					arrayDetalleDocumento[i].setNroSecuencia(filtroDTO.getArrayDetalleDocumentoVO()[i]
							.getNroSecuencia());
					arrayDetalleDocumento[i].setNumAbonado(filtroDTO.getArrayDetalleDocumentoVO()[i].getNumAbonado());
				}
				r.setArrayDetalleDocumentoVO(arrayDetalleDocumento);
			}
			logger.debug("filtroDTO.getNumTransaccion(): " + filtroDTO.getNumTransaccion());
			r.setNumTransaccion(filtroDTO.getNumTransaccion());

			logger.debug("filtroDTO.getCodError(): " + filtroDTO.getCodError());
			r.setCodError(filtroDTO.getCodError());

			logger.debug("filtroDTO.getDesError(): " + filtroDTO.getDesError());
			r.setDesError(filtroDTO.getDesError());
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

}
