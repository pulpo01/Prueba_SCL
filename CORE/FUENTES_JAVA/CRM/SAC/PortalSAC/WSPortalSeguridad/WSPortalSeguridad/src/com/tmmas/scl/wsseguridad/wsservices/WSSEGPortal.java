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

import javax.naming.Context;

import org.apache.axis2.axis2userguide.WSReposicionVoluntariaServicioCelStub;
import org.apache.axis2.axis2userguide.WSServCambioPlaPostPagoIndividualStub;
import org.apache.axis2.axis2userguide.WSServicioCargosStub;
import org.apache.axis2.axis2userguide.WSSuspensionVoluntariaServicioCelStub;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.scl.wsfranquicias.common.dto.CargaAnulacionSiniestroDTO;
import com.tmmas.scl.wsfranquicias.common.dto.EjecucionAjusteCExcepcionCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.EjecucionAjusteCReversionCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.EjecucionAnulacionSiniestroDTO;
import com.tmmas.scl.wsfranquicias.common.dto.OOSSFase2DTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.CargaCambioDatosClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.EjecucionCambioDatosClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaCambioPlanPostPagoIndividualDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaReposicionSrvCelDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaServicioCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.CargaSuspensionSrvCelDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionCambioPlanPostPagoIndividualDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionReposicionSrvCelDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionServicioCargosDTO;
import com.tmmas.scl.wsfranquicias.common.dto.xsd.EjecucionSuspensionSrvCelDTO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.BloqueSuspensionesActivasVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.CargosVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.CausasSuspensionVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.PlanTarifarioVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.ServicioSuspensionVO;
import com.tmmas.scl.wsfranquicias.webservices.CargaServicioCargosDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargaServicioCargosResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioPlanPostPagoIndividualDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioPlanPostPagoIndividualResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarReposicionSrvCelularDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarReposicionSrvCelularResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarSuspensionSrvCelularDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargarSuspensionSrvCelularResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecucionServicioCargosDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecucionServicioCargosResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioPlanPostPagoIndividualDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioPlanPostPagoIndividualResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarReposicionSrvCelularDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarReposicionSrvCelularResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarSuspensionSrvCelularDocument;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarSuspensionSrvCelularResponseDocument;
import com.tmmas.scl.wsfranquicias.webservices.CargaServicioCargosDocument.CargaServicioCargos;
import com.tmmas.scl.wsfranquicias.webservices.CargarCambioPlanPostPagoIndividualDocument.CargarCambioPlanPostPagoIndividual;
import com.tmmas.scl.wsfranquicias.webservices.CargarReposicionSrvCelularDocument.CargarReposicionSrvCelular;
import com.tmmas.scl.wsfranquicias.webservices.CargarSuspensionSrvCelularDocument.CargarSuspensionSrvCelular;
import com.tmmas.scl.wsfranquicias.webservices.EjecucionServicioCargosDocument.EjecucionServicioCargos;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarCambioPlanPostPagoIndividualDocument.EjecutarCambioPlanPostPagoIndividual;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarReposicionSrvCelularDocument.EjecutarReposicionSrvCelular;
import com.tmmas.scl.wsfranquicias.webservices.EjecutarSuspensionSrvCelularDocument.EjecutarSuspensionSrvCelular;
import com.tmmas.scl.wsportal.common.dto.DetallePlanTarifarioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCambiosPlanTarifDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoGruposDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoNumerosFrecuentesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO;
import com.tmmas.scl.wsportal.common.dto.MenuDTO;
import com.tmmas.scl.wsportal.common.dto.ResgistroAtencionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsseguridad.autenticacion.EditorUsuarios;
import com.tmmas.scl.wsseguridad.dto.CargaAjusteCExcepcionCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.CargaAjusteCReversionCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.CargaCambioDatosClienteSACDTO;
import com.tmmas.scl.wsseguridad.dto.CargaCambioNumFrecuentesSACDTO;
import com.tmmas.scl.wsseguridad.dto.CargaOSGenericaDTO;
import com.tmmas.scl.wsseguridad.dto.ConsultarOrdenServicioSACDTO;
import com.tmmas.scl.wsseguridad.dto.DireccionSACDTO;
import com.tmmas.scl.wsseguridad.dto.EjecucionAjusteCExcepcionCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.EjecucionAjusteCReversionCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.EjecucionCambioDatosClienteSACDTO;
import com.tmmas.scl.wsseguridad.dto.EjecucionCambioNumFrecuentesSACDTO;
import com.tmmas.scl.wsseguridad.dto.FiltroDetDocAjusteCCargosSACDTO;
import com.tmmas.scl.wsseguridad.dto.ListadoDireccionesSACDTO;
import com.tmmas.scl.wsseguridad.dto.ListadoOrdenesServicioSACDTO;
import com.tmmas.scl.wsseguridad.dto.RealizarBloqueoRoboSACINDTO;
import com.tmmas.scl.wsseguridad.dto.RealizarBloqueoRoboSACOUTDTO;
import com.tmmas.scl.wsseguridad.validacion.Validacion;

public final class WSSEGPortal extends ClienteFranquicias
{
	private static Logger logger = Logger.getLogger(WSSEGPortal.class);

	private static final String CLAVE_URL_WS_SERVICIO_CARGOS = "ws.servicio.cargos";

	private static final String CLAVE_URL_WS_CONSULTA_ORDEN_SERVICIO = "ws.consulta.orden.servicio";

	private static final String CLAVE_URL_WS_SERV_CAMBIO_PLAPOSTPAGO_INDIVIDUAL = "ws.serv.cambio.plapostpago.individual";

	private static final String CLAVE_URL_WS_REPOSICION_VOLUNTARIA_SERVICIO_CEL = "ws.reposicion.voluntaria.servicio.cel";

	private static final String CLAVE_URL_WS_SUSPENSION_VOLUNTARIA_SERVICIO_CEL = "ws.suspension.voluntaria.servicio.cel";

	private static final String CLAVE_URL_WS_CAMBIO_DATOS_CLIENTE = "ws.cambio.datos.cliente";

	static PortalSACException procesarException(Throwable e)
	{
		PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
				config.getString("COD.ERR_SAC.4000"), config.getString("DES.ERR_SAC.4000"), e);
		return pe;
	}

	/** Auditado */
	public CargaOSGenericaDTO cargaOSGenericaAbonado(Long numAbonado, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		CargaOSGenericaDTO r = new CargaOSGenericaDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			logger.debug("numAbonado: " + numAbonado);
			logger.debug("nomUsuarioSCL: " + nomUsuarioSCL);
			logger.debug("codEvento: " + codEvento);

			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, numAbonado, null, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);
		}
		catch (Throwable e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			return new CargaOSGenericaDTO(pe);
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	public WSSEGPortal()
	{

	}

	public ListadoAbonadosDTO abonadosXCelular(Long numCelular) throws PortalSACException
	{
		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { numCelular };
			r = (ListadoAbonadosDTO) WSSEGPortal.invocarMetodoWeb(args, "abonadosXCelular", URL_SERVICIOS_PORTAL,
					"urn:abonadosXCelular", ListadoAbonadosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public ListadoAbonadosDTO abonadosXCliente(Long codCliente) throws PortalSACException
	{
		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente };
			r = (ListadoAbonadosDTO) WSSEGPortal.invocarMetodoWeb(args, "abonadosXCliente", URL_SERVICIOS_PORTAL,
					"urn:abonadosXCliente", ListadoAbonadosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoAjustesDTO ajustesXCodCliente(Long codCliente)
			throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoAjustesDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoAjustesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoAjustesDTO) WSSEGPortal.invocarMetodoWeb(args,
					"ccXCodCliente", URL_SERVICIOS_PORTAL, "urn:ccXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoAjustesDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoBeneficiosDTO beneficiosXClienteAbonado(Long codCliente,
			Long numAbonado, String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoBeneficiosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoBeneficiosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, numAbonado, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoBeneficiosDTO) WSSEGPortal.invocarMetodoWeb(args,
					"beneficiosXClienteAbonado", URL_SERVICIOS_PORTAL, "urn:beneficiosXClienteAbonado",
					com.tmmas.scl.wsportal.common.dto.ListadoBeneficiosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public ConsultarOrdenServicioSACDTO cambiarDireccionCliente(DireccionSACDTO dto) throws PortalSACException
	{
		return super.cambiarDireccionCliente(dto);
	}

	public ListadoOrdenesServicioSACDTO cambiarDireccionesCliente(ListadoDireccionesSACDTO dto)
			throws PortalSACException
	{
		return super.cambiarDireccionesCliente(dto);
	}

	public final boolean cambiarPassword(String usuario, String passwordActual, String passwordNueva)
	{
		boolean r = false;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Context ctx = obtenerContexto();
			EditorUsuarios editor = new EditorUsuarios(ctx);
			logger.debug("Cambio password usuario [" + usuario + "]");
			r = editor.cambiarPassword(usuario, passwordActual, passwordNueva);
			logger.debug("Realizado exitosamente");
		}
		catch (Throwable e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/**
	 * @param numOS
	 * @return
	 * @throws PortalSACException
	 */
	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPospago(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numOS };
			r = (ListadoCambiosPlanTarifDTO) WSSEGPortal.invocarMetodoWeb(args, "cambiosPlanAbonadoPospago",
					URL_SERVICIOS_PORTAL, "urn:cambiosPlanAbonadoPospago", ListadoCambiosPlanTarifDTO.class,
					ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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
	 * @param numOS
	 * @return
	 * @throws PortalSACException
	 */
	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPrepago(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numOS };
			r = (ListadoCambiosPlanTarifDTO) WSSEGPortal.invocarMetodoWeb(args, "cambiosPlanAbonadoPrepago",
					URL_SERVICIOS_PORTAL, "urn:cambiosPlanAbonadoPrepago", ListadoCambiosPlanTarifDTO.class,
					ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public ListadoCambiosPlanTarifDTO cambiosPlanCliente(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numOS };
			r = (ListadoCambiosPlanTarifDTO) WSSEGPortal.invocarMetodoWeb(args, "cambiosPlanCliente",
					URL_SERVICIOS_PORTAL, "urn:cambiosPlanCliente", ListadoCambiosPlanTarifDTO.class,
					ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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
	public CargaCambioDatosClienteSACDTO cargaCambioDatosCliente(Long codCliente, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		CargaCambioDatosClienteSACDTO r = new CargaCambioDatosClienteSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, null, codCliente, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);
			CargaCambioDatosClienteDTO cargaDTO = new CargaCambioDatosClienteDTO();
			cargaDTO.setNomUsuarioSCL(nomUsuarioSCL);
			cargaDTO.setCodCliente(codCliente);
			cargaDTO.setNroOOSS(1);
			cargaDTO.setCodNpi(1);
			cargaDTO.setCodCatImpositiva(1);
			String urlWS = config.getString(CLAVE_URL_WS_CAMBIO_DATOS_CLIENTE);
			logger.debug("URL Servicio Web: " + urlWS);
			Object[] args = new Object[] { cargaDTO };
			Class tipoRetorno = cargaDTO.getClass();
			cargaDTO = (CargaCambioDatosClienteDTO) WSSEGPortal.invocarMetodoWeb(args, "cargaCambioDatosCliente",
					urlWS, "urn:cargaCambioDatosCliente", tipoRetorno, ESPACIO_NOMBRES_FRANQUICIAS);
			if (cargaDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("cargaDTO.getCodError() " + cargaDTO.getCodError());
				logger.debug("cargaDTO.getDesError() - " + cargaDTO.getDesError());
			}
			logger.debug("cargaDTO : " + cargaDTO);
			r.setApellido1(cargaDTO.getApellido1());
			r.setApellido2(cargaDTO.getApellido2());
			r.setCodActividad(cargaDTO.getCodActividad());
			r.setCodBanco(cargaDTO.getCodBanco());
			r.setCodBancoTarjeta(cargaDTO.getCodBancoTarjeta());
			r.setCodCatImpositiva(cargaDTO.getCodCatImpositiva());
			r.setCodCliente(cargaDTO.getCodCliente());
			r.setCodCuenta(cargaDTO.getCodCuenta());
			r.setCodIdioma(cargaDTO.getCodIdioma());
			r.setCodNpi(cargaDTO.getCodNpi());
			r.setCodOficina(cargaDTO.getCodOficina());
			r.setCodPais(cargaDTO.getCodPais());
			r.setCodPinCliente(cargaDTO.getCodPinCliente());
			r.setCodSisPago(cargaDTO.getCodSisPago());
			r.setCodSucursal(cargaDTO.getCodSucursal());
			r.setCodTipIdent(cargaDTO.getCodTipIdent());
			r.setCodTipIdent2(cargaDTO.getCodTipIdent2());
			r.setCodTipIdentTrib(cargaDTO.getCodTipIdentTrib());
			r.setCodTipTarjeta(cargaDTO.getCodTipTarjeta());
			r.setDesCuenta(cargaDTO.getDesCuenta());
			r.setDesIdioma(cargaDTO.getDesIdioma());
			r.setDesIndDebito(cargaDTO.getDesIndDebito());
			r.setDesNpi(cargaDTO.getDesNpi());
			r.setDesSisPago(cargaDTO.getDesSisPago());
			r.setDesTipIdent(cargaDTO.getDesTipIdent());
			r.setDesTipIdent2(cargaDTO.getDesTipIdent2());
			r.setDesTipIdentTrib(cargaDTO.getDesTipIdentTrib());
			r.setEmail(cargaDTO.getEmail());
			r.setIndTraspaso(cargaDTO.getIndTraspaso());
			r.setLimPago(cargaDTO.getLimPago());
			r.setNomBanco(cargaDTO.getNomBanco());
			r.setNomBancoTarjeta(cargaDTO.getNomBancoTarjeta());
			r.setNomCliente(cargaDTO.getNomCliente());
			r.setNomSucursal(cargaDTO.getNomSucursal());
			r.setNomTipTarjeta(cargaDTO.getNomTipTarjeta());
			r.setNomUsuarioSCL(cargaDTO.getNomUsuarioSCL());
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setNumCuentaCte(cargaDTO.getNumCuentaCte());
			r.setNumFax(cargaDTO.getNumFax());
			r.setNumIdent(cargaDTO.getNumIdent());
			r.setNumIdent2(cargaDTO.getNumIdent2());
			r.setNumIdentTrib(cargaDTO.getNumIdentTrib());
			r.setNumTarjeta(cargaDTO.getNumTarjeta());
			r.setNumTelefono(cargaDTO.getNumTelefono());
			r.setNumTelefono2(cargaDTO.getNumTelefono2());
			r.setNumTransaccion(cargaDTO.getNumTransaccion());
			r.setTipoCuentaCte(cargaDTO.getTipoCuentaCte());
			r.setVencTarjeta(cargaDTO.getVencTarjeta());
			r.setCargaCambioDatosBancariosDTO(cargaDTO.getCargaCambioDatosBancariosDTO());
			r.setCargaCambioDatosGeneralesClienteDTO(cargaDTO.getCargaCambioDatosGeneralesClienteDTO());
			r.setCargaCambioDatosPersonalesClienteDTO(cargaDTO.getCargaCambioDatosPersonalesClienteDTO());
			r.setCargaCambioDatosTributariosClienteDTO(cargaDTO.getCargaCambioDatosTributariosClienteDTO());
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

	public CargaCambioNumFrecuentesSACDTO cargaNumFrecuentes(Long numAbonado, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		return super.cargaNumFrecuentes(numAbonado, nomUsuarioSCL, codEvento);
	}

	public com.tmmas.scl.wsfranquicias.common.dto.CargaAbonoLimConDTO cargarAbonoLimiteConsumo(Long codSujeto,
			String tipoAbono, String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		return super.cargarAbonoLimiteConsumo(codSujeto, tipoAbono, nomUsuarioSCL, codEvento);
	}

	public com.tmmas.scl.wsfranquicias.common.dto.CargaAbonoLimiteConsumoServicioSuplementarioDTO cargarAbonoLimiteConsumoSS(
			Long codSujeto, String tipoAbono, String tipoOOSS, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		return super.cargarAbonoLimiteConsumoSS(codSujeto, tipoAbono, tipoOOSS, nomUsuarioSCL, codEvento);
	}

	public CargaAjusteCExcepcionCargosSACDTO cargarAjusteCExcepcionCargos(Long codCliente, String nomUsuarioSCL,
			String pwd, String codEvento) throws PortalSACException
	{
		return super.cargarAjusteCExcepcionCargos(codCliente, nomUsuarioSCL, pwd, codEvento);
	}

	public CargaAjusteCReversionCargosSACDTO cargarAjusteCReversionCargos(Long codCliente, String nomUsuarioSCL,
			String pwd, String codEvento) throws PortalSACException
	{
		return super.cargarAjusteCReversionCargos(codCliente, nomUsuarioSCL, pwd, codEvento);
	}

	public CargaAnulacionSiniestroDTO cargarAnulacionSiniestro(Long numAbonado, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		return super.cargarAnulacionSiniestro(numAbonado, nomUsuarioSCL, codEvento);
	}

	public com.tmmas.scl.wsfranquicias.common.dto.CargaCambioEquipoGSMDTO cargarCambioEquipoGSM(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		return super.cargarCambioEquipoGSM(numAbonado, nomUsuarioSCL, codEvento);
	}

	/** Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.CargaCambioPlanPostPagoIndividualDTO cargarCambioPlanPostPagoIndividual(
			Long numAbonado, String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaCambioPlanPostPagoIndividualDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaCambioPlanPostPagoIndividualDTO();
		CargarCambioPlanPostPagoIndividualResponseDocument response = null;
		CargaCambioPlanPostPagoIndividualDTO cargaDTO = CargaCambioPlanPostPagoIndividualDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, numAbonado, null, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);

			String urlWS = config.getString(CLAVE_URL_WS_SERV_CAMBIO_PLAPOSTPAGO_INDIVIDUAL);

			WSServCambioPlaPostPagoIndividualStub stub = new WSServCambioPlaPostPagoIndividualStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);

			CargarCambioPlanPostPagoIndividualDocument cargarCambioPlanPostPagoIndividualDocument = CargarCambioPlanPostPagoIndividualDocument.Factory
					.newInstance();
			CargarCambioPlanPostPagoIndividual cargarCambioPlanPostPagoIndividualReq = cargarCambioPlanPostPagoIndividualDocument
					.addNewCargarCambioPlanPostPagoIndividual();
			CargaCambioPlanPostPagoIndividualDTO entrada = CargaCambioPlanPostPagoIndividualDTO.Factory.newInstance();
			entrada.setNomUsuarioSCL(nomUsuarioSCL);
			entrada.setNumAbonado(numAbonado.longValue());

			cargarCambioPlanPostPagoIndividualReq.setCargaCambioPlanPostPagoIndividualDTO(entrada);
			cargarCambioPlanPostPagoIndividualDocument
					.setCargarCambioPlanPostPagoIndividual(cargarCambioPlanPostPagoIndividualReq);
			logger
					.debug("cargarCambioPlanPostPagoIndividual(Long, String, String) - cargarCambioPlanPostPagoIndividual1: "
							+ cargarCambioPlanPostPagoIndividualReq);
			response = stub.cargarCambioPlanPostPagoIndividual(cargarCambioPlanPostPagoIndividualDocument);
			logger
					.debug("cargarCambioPlanPostPagoIndividual(Long, String, String) - cargarCambioPlanPostPagoIndividual2: "
							+ cargarCambioPlanPostPagoIndividualDocument);
			cargaDTO = response.getCargarCambioPlanPostPagoIndividualResponse().getReturn();

			logger
					.debug("cargarCambioPlanPostPagoIndividual(Long, String, String) - cargarCambioPlanPostPagoIndividual cargaDTO.getCodError(): "
							+ cargaDTO.getCodError());
			logger
					.debug("cargarCambioPlanPostPagoIndividual(Long, String, String) - cargarCambioPlanPostPagoIndividual cargaDTO.getDesError(): "
							+ cargaDTO.getDesError());

			// Obtengo el arreglo plan tarifario
			if (cargaDTO.getArrayPlanTarifarioVOArray() != null && cargaDTO.getArrayPlanTarifarioVOArray().length > 0)
			{
				PlanTarifarioVO[] arrayPlanTarifario = new PlanTarifarioVO[cargaDTO.getArrayPlanTarifarioVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayPlanTarifarioVOArray().length; i++)
				{
					arrayPlanTarifario[i] = new PlanTarifarioVO();
					arrayPlanTarifario[i].setCodCargoBasico(cargaDTO.getArrayPlanTarifarioVOArray()[i]
							.getCodCargoBasico());
					arrayPlanTarifario[i].setCodPlanTarif(cargaDTO.getArrayPlanTarifarioVOArray()[i].getCodPlanTarif());
					arrayPlanTarifario[i].setDesCargoBasico(cargaDTO.getArrayPlanTarifarioVOArray()[i]
							.getDesCargoBasico());
					arrayPlanTarifario[i].setDesPlanTarif(cargaDTO.getArrayPlanTarifarioVOArray()[i].getDesPlanTarif());
					arrayPlanTarifario[i].setValorCargoBasico(cargaDTO.getArrayPlanTarifarioVOArray()[i]
							.getValorCargoBasico());

				}
				r.setArrayPlanTarifarioVO(arrayPlanTarifario);
			}

			r.setAplicaNumeroFrecuente(cargaDTO.getAplicaNumeroFrecuente());
			r.setDesCargoBasico(cargaDTO.getDesCargoBasico());
			r.setDesCargoBasicoProxCiclo(cargaDTO.getDesCargoBasicoProxCiclo());
			r.setDesLimConActual(cargaDTO.getDesLimConActual());
			r.setDesLimConProximo(cargaDTO.getDesLimConProximo());
			r.setDesPlanTarif(cargaDTO.getDesPlanTarif());
			r.setDesPlanTarifProxCiclo(cargaDTO.getDesPlanTarifProxCiclo());
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setNumAbonado(numAbonado.longValue());
			r.setNumeroCelular(cargaDTO.getNumeroCelular());

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

	public com.tmmas.scl.wsfranquicias.common.dto.CargaCambioSIMCardDTO cargarCambioSIMCard(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		return super.cargarCambioSIMCard(numAbonado, nomUsuarioSCL, codEvento);
	}

	/** Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.CargaReposicionSrvCelDTO cargarReposicionSrvCelular(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaReposicionSrvCelDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaReposicionSrvCelDTO();
		CargarReposicionSrvCelularResponseDocument response = null;
		CargaReposicionSrvCelDTO cargaDTO = CargaReposicionSrvCelDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			/** Auditoría */
			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, numAbonado, null, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);

			String urlWS = config.getString(CLAVE_URL_WS_REPOSICION_VOLUNTARIA_SERVICIO_CEL);

			WSReposicionVoluntariaServicioCelStub stub = new WSReposicionVoluntariaServicioCelStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			CargarReposicionSrvCelularDocument cargarReposicionSrvCelularDocument = CargarReposicionSrvCelularDocument.Factory
					.newInstance();
			CargarReposicionSrvCelular cargarReposicionSrvCelularReq = cargarReposicionSrvCelularDocument
					.addNewCargarReposicionSrvCelular();
			CargaReposicionSrvCelDTO entrada = CargaReposicionSrvCelDTO.Factory.newInstance();
			entrada.setNomUsuarioSCL(nomUsuarioSCL);
			entrada.setNumAbonado(numAbonado.longValue());
			cargarReposicionSrvCelularReq.setCargaReposicionSrvCelDTO(entrada);
			cargarReposicionSrvCelularDocument.setCargarReposicionSrvCelular(cargarReposicionSrvCelularReq);
			logger.debug("cargarReposicionSrvCelular1: " + cargarReposicionSrvCelularReq);
			response = stub.cargarReposicionSrvCelular(cargarReposicionSrvCelularDocument);
			logger.debug("cargarReposicionSrvCelular2: " + cargarReposicionSrvCelularDocument);
			cargaDTO = response.getCargarReposicionSrvCelularResponse().getReturn();
			logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
			logger.debug(" cargaDTO.getDesError(): " + cargaDTO.getDesError());

			// Obtengo el arreglo de bloques de suspensiones activas
			if (cargaDTO.getArrayBloqueSuspensionesActivasVOArray() != null
					&& cargaDTO.getArrayBloqueSuspensionesActivasVOArray().length > 0)
			{
				BloqueSuspensionesActivasVO[] arrayBloqueSuspensionesActivasVO = new BloqueSuspensionesActivasVO[cargaDTO
						.getArrayBloqueSuspensionesActivasVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayBloqueSuspensionesActivasVOArray().length; i++)
				{
					arrayBloqueSuspensionesActivasVO[i] = new BloqueSuspensionesActivasVO();
					arrayBloqueSuspensionesActivasVO[i].setCodCargoBasico(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getCodCargoBasico());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getCodCargoBasico() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getCodCargoBasico());
					arrayBloqueSuspensionesActivasVO[i].setCodNivelSrvSupl(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getCodNivelSrvSupl());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getCodNivelSrvSupl() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getCodNivelSrvSupl());
					arrayBloqueSuspensionesActivasVO[i].setCodNR(cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i]
							.getCodNR());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getCodNR() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getCodNR());
					arrayBloqueSuspensionesActivasVO[i].setCodSrvSupl(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getCodSrvSupl());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getCodSrvSupl() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getCodSrvSupl());
					arrayBloqueSuspensionesActivasVO[i].setCodSrvSusp(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getCodSrvSusp());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getCodSrvSusp() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getCodSrvSusp());
					arrayBloqueSuspensionesActivasVO[i].setDesNivelSrvSupl(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getDesNivelSrvSupl());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getDesNivelSrvSupl() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getDesNivelSrvSupl());
					arrayBloqueSuspensionesActivasVO[i].setDesSrvSupl(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getDesSrvSupl());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getDesSrvSupl() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getDesSrvSupl());
					arrayBloqueSuspensionesActivasVO[i].setDesSrvSusp(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getDesSrvSusp());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getDesSrvSusp() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getDesSrvSusp());
					arrayBloqueSuspensionesActivasVO[i].setTipoSuspension(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getTipoSuspension());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getTipoSuspension() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getTipoSuspension());
					arrayBloqueSuspensionesActivasVO[i].setNivelReha(cargaDTO
							.getArrayBloqueSuspensionesActivasVOArray()[i].getNivelReha());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getNivelReha() :"
							+ cargaDTO.getArrayBloqueSuspensionesActivasVOArray()[i].getNivelReha());
				}
				r.setArrayBloqueSuspensionesActivasVO(arrayBloqueSuspensionesActivasVO);
			}
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setNumAbonado(numAbonado.longValue());
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
	public com.tmmas.scl.wsfranquicias.common.dto.CargaSuspensionSrvCelDTO cargarSuspensionSrvCelular(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaSuspensionSrvCelDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaSuspensionSrvCelDTO();
		CargarSuspensionSrvCelularResponseDocument response = null;
		CargaSuspensionSrvCelDTO cargaDTO = CargaSuspensionSrvCelDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			WSSEGPortal.invocarMetodoWebAuditoria(codEvento, nomUsuarioSCL, null, numAbonado, null, null,
					ESPACIO_NOMBRES_PORTAL, URL_SERVICIOS_PORTAL);

			String urlWS = config.getString(CLAVE_URL_WS_SUSPENSION_VOLUNTARIA_SERVICIO_CEL);

			WSSuspensionVoluntariaServicioCelStub stub = new WSSuspensionVoluntariaServicioCelStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);

			CargarSuspensionSrvCelularDocument cargarSuspensionSrvCelularDocument = CargarSuspensionSrvCelularDocument.Factory
					.newInstance();
			CargarSuspensionSrvCelular cargarSuspensionSrvCelularReq = cargarSuspensionSrvCelularDocument
					.addNewCargarSuspensionSrvCelular();
			CargaSuspensionSrvCelDTO entrada = CargaSuspensionSrvCelDTO.Factory.newInstance();
			entrada.setNomUsuarioSCL(nomUsuarioSCL);
			entrada.setNumAbonado(numAbonado.longValue());
			cargarSuspensionSrvCelularReq.setCargaSuspensionSrvCelDTO(entrada);
			cargarSuspensionSrvCelularDocument.setCargarSuspensionSrvCelular(cargarSuspensionSrvCelularReq);
			response = stub.cargarSuspensionSrvCelular(cargarSuspensionSrvCelularDocument);
			logger.debug("cargarSuspensionSrvCelularDocument: " + cargarSuspensionSrvCelularDocument);
			cargaDTO = response.getCargarSuspensionSrvCelularResponse().getReturn();
			logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
			logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());

			// Obtengo el arreglo de causas de suspension
			if (cargaDTO.getArrayCausasSuspensionVOArray() != null
					&& cargaDTO.getArrayCausasSuspensionVOArray().length > 0)
			{
				CausasSuspensionVO[] arrayCausasSuspension = new CausasSuspensionVO[cargaDTO
						.getArrayCausasSuspensionVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayCausasSuspensionVOArray().length; i++)
				{
					arrayCausasSuspension[i] = new CausasSuspensionVO();
					arrayCausasSuspension[i].setCodCauSusp(cargaDTO.getArrayCausasSuspensionVOArray()[i]
							.getCodCauSusp());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getCodCauSusp():"
							+ cargaDTO.getArrayCausasSuspensionVOArray()[i].getCodCauSusp());
					arrayCausasSuspension[i].setDesCauSusp(cargaDTO.getArrayCausasSuspensionVOArray()[i]
							.getDesCauSusp());
					logger.debug("cargaDTO.getArrayCausasSuspensionVOArray()[i].getDesCauSusp() :"
							+ cargaDTO.getArrayCausasSuspensionVOArray()[i].getDesCauSusp());
				}
				r.setArrayCausasSuspensionVO(arrayCausasSuspension);
			}

			// Obtengo el arreglo de servicios de suspension
			if (cargaDTO.getArrayServicioSuspensionVOArray() != null
					&& cargaDTO.getArrayServicioSuspensionVOArray().length > 0)
			{
				ServicioSuspensionVO[] arrayServiciosSuspension = new ServicioSuspensionVO[cargaDTO
						.getArrayServicioSuspensionVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayServicioSuspensionVOArray().length; i++)
				{
					arrayServiciosSuspension[i] = new ServicioSuspensionVO();
					arrayServiciosSuspension[i].setCodSrvSusp(cargaDTO.getArrayServicioSuspensionVOArray()[i]
							.getCodSrvSusp());
					arrayServiciosSuspension[i].setDesSrvSusp(cargaDTO.getArrayServicioSuspensionVOArray()[i]
							.getDesSrvSusp());
				}
				r.setArrayServicioSuspensionVO(arrayServiciosSuspension);
			}
			r.setIndBloqueoCausaSuspension(cargaDTO.getIndBloqueoCausaSuspension());
			r.setNombreCliente(cargaDTO.getNombreCliente());
			r.setNomUsuarioSCL(nomUsuarioSCL);
			r.setNroOOSS(cargaDTO.getNroOOSS());
			r.setNumAbonado(numAbonado.longValue());
			r.setNumeroCelular(cargaDTO.getNumeroCelular());
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
	public com.tmmas.scl.wsfranquicias.common.dto.CargaServicioCargosDTO cargaServicioCargos(
			com.tmmas.scl.wsfranquicias.common.dto.CargaServicioCargosDTO entrada, String ventaSimcard)
			throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.CargaServicioCargosDTO r = new com.tmmas.scl.wsfranquicias.common.dto.CargaServicioCargosDTO();
		CargaServicioCargosResponseDocument response = null;
		CargaServicioCargosDTO cargaDTO = CargaServicioCargosDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			String urlWS = config.getString(CLAVE_URL_WS_SERVICIO_CARGOS);
			WSServicioCargosStub stub = new WSServicioCargosStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			CargaServicioCargosDocument cargaServicioCargosDocument = CargaServicioCargosDocument.Factory.newInstance();
			CargaServicioCargos cargaServicioCargosReq = cargaServicioCargosDocument.addNewCargaServicioCargos();
			CargaServicioCargosDTO dto = CargaServicioCargosDTO.Factory.newInstance();
			dto.setNumAbonado(entrada.getNumAbonado());
			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setVentaSimCard(Boolean.valueOf(ventaSimcard).booleanValue());
			dto.setCodAntiSerie(entrada.getCodAntiSerie());
			dto.setCodArticulo(entrada.getCodArticulo());
			dto.setCodStockSim(entrada.getCodStockSim());
			dto.setCodArticuloSim(entrada.getCodArticuloSim());
			dto.setCodUsoLineaSim(entrada.getCodUsoLineaSim());
			dto.setCodEstadoSim(entrada.getCodEstadoSim());
			dto.setCodModVenta(entrada.getCodModVenta());
			dto.setIndFacturaCiclo(entrada.getIndFacturaCiclo());
			dto.setNroOOSS(entrada.getNroOOSS());
			cargaServicioCargosReq.setCargaServicioCargosDTO(dto);
			cargaServicioCargosDocument.setCargaServicioCargos(cargaServicioCargosReq);
			logger.debug("cargaServicioCargosReq: " + cargaServicioCargosReq);
			response = stub.cargaServicioCargos(cargaServicioCargosDocument);
			logger.debug("cargaServicioCargosDocument: " + cargaServicioCargosDocument);
			cargaDTO = response.getCargaServicioCargosResponse().getReturn();
			logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
			logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());
			// Obtengo el arreglo causas de pago
			if (cargaDTO.getArrayCargosVOArray() != null && cargaDTO.getArrayCargosVOArray().length > 0)
			{
				CargosVO[] arrayCargos = new CargosVO[cargaDTO.getArrayCargosVOArray().length];
				for (int i = 0; i < cargaDTO.getArrayCargosVOArray().length; i++)
				{
					arrayCargos[i] = new CargosVO();
					arrayCargos[i].setCodArticulo(cargaDTO.getArrayCargosVOArray()[i].getCodArticulo());
					arrayCargos[i].setCodBodega(cargaDTO.getArrayCargosVOArray()[i].getCodBodega());
					arrayCargos[i].setCodConcDto(cargaDTO.getArrayCargosVOArray()[i].getCodConcDto());
					arrayCargos[i].setCodConcepto(cargaDTO.getArrayCargosVOArray()[i].getCodConcepto());
					arrayCargos[i].setCodMoneda(cargaDTO.getArrayCargosVOArray()[i].getCodMoneda());
					arrayCargos[i].setDesMoneda(cargaDTO.getArrayCargosVOArray()[i].getDesMoneda());
					arrayCargos[i].setDesServicio(cargaDTO.getArrayCargosVOArray()[i].getDesServicio());
					arrayCargos[i].setImpTarifa(cargaDTO.getArrayCargosVOArray()[i].getImpTarifa());
					arrayCargos[i].setIndAutManCarg(cargaDTO.getArrayCargosVOArray()[i].getIndAutManCarg());
					arrayCargos[i].setIndCargoEquipo(cargaDTO.getArrayCargosVOArray()[i].getIndCargoEquipo());
					arrayCargos[i].setIndCargoOcasional(cargaDTO.getArrayCargosVOArray()[i].getIndCargoOcasional());
					arrayCargos[i].setIndEquipo(cargaDTO.getArrayCargosVOArray()[i].getIndEquipo());
					arrayCargos[i].setNumSerie(cargaDTO.getArrayCargosVOArray()[i].getNumSerie());
					arrayCargos[i].setNumUnidades(cargaDTO.getArrayCargosVOArray()[i].getNumUnidades());
					arrayCargos[i].setTipoDto(cargaDTO.getArrayCargosVOArray()[i].getTipoDto());
					arrayCargos[i].setValDto(cargaDTO.getArrayCargosVOArray()[i].getValDto());
					arrayCargos[i].setValMax(cargaDTO.getArrayCargosVOArray()[i].getValMax());
					arrayCargos[i].setValMin(cargaDTO.getArrayCargosVOArray()[i].getValMin());
				}
				r.setArrayCargosVO(arrayCargos);
			}
			r.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
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

	public MenuDTO cargaValidaOSUsuario(String usuario) throws PortalSACException
	{
		MenuDTO r = new MenuDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { usuario };
			r = (MenuDTO) WSSEGPortal.invocarMetodoWeb(args, "cargaValidaOSUsuario", URL_SERVICIOS_PORTAL,
					"urn:cargaValidaOSUsuario", MenuDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO ccXCodCliente(Long codCliente,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { codCliente, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO) WSSEGPortal.invocarMetodoWeb(args,
					"ccXCodCliente", URL_SERVICIOS_PORTAL, "urn:ccXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	} // ccXCodCliente

	public com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO clientesXCodCliente(Long codCliente)
			throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { codCliente };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO) WSSEGPortal.invocarMetodoWeb(args,
					"clientesXCodCliente", URL_SERVICIOS_PORTAL, "urn:clientesXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO clientesXCuenta(Long codCuenta)
			throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCuenta };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO) WSSEGPortal.invocarMetodoWeb(args,
					"clientesXCuenta", URL_SERVICIOS_PORTAL, "urn:clientesXCuenta",
					com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO clientesXNombre(String nombre)
			throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { nombre };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO) WSSEGPortal.invocarMetodoWeb(args,
					"clientesXNombre", URL_SERVICIOS_PORTAL, "urn:clientesXNombre",
					com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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
	public ConsultarOrdenServicioSACDTO consultaOrdenServicio(Long codOOSS, String numTransaccion, String nomUsuarioSCL)
			throws PortalSACException
	{
		ConsultarOrdenServicioSACDTO r = new ConsultarOrdenServicioSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			OOSSFase2DTO cargaDTO = new OOSSFase2DTO();
			logger.debug("nomUsuarioSCL: " + nomUsuarioSCL);
			cargaDTO.setNomUsuarioSCL(nomUsuarioSCL);
			logger.debug("numTransaccion: " + numTransaccion);
			cargaDTO.setNumTransaccion(numTransaccion);
			if (codOOSS != null)
			{
				logger.debug("codOOSS.intValue(): " + codOOSS.intValue());
				cargaDTO.setServicio(codOOSS.intValue());
			}
			String urlWS = config.getString(CLAVE_URL_WS_CONSULTA_ORDEN_SERVICIO);
			Object[] args = new Object[] { cargaDTO };
			Class tipoRetorno = cargaDTO.getClass();

			cargaDTO = (OOSSFase2DTO) WSSEGPortal.invocarMetodoWeb(args, "consultarOrdenServicio", urlWS,
					"urn:consultarOrdenServicio", tipoRetorno, ESPACIO_NOMBRES_FRANQUICIAS);

			if (cargaDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("cargaDTO.getCodError(): " + cargaDTO.getCodError());
				r.setCodError(cargaDTO.getCodError());

				logger.debug("cargaDTO.getDesError(): " + cargaDTO.getDesError());
				r.setDesError(cargaDTO.getDesError());

				logger.debug("cargaDTO.getNumTransaccion(): " + cargaDTO.getNumTransaccion());
				r.setNumTransaccion(cargaDTO.getNumTransaccion());

				logger.debug("cargaDTO.getNroOOSS(): " + cargaDTO.getNroOOSS());
				r.setNroOOSS(cargaDTO.getNroOOSS());
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

	/** No auditado */
	public com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO consultasXCodGrupo(String codGrupo,
			String codPrograma, String numVersion) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO r = new ListadoConsultasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codGrupo, codPrograma, numVersion };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO) WSSEGPortal.invocarMetodoWeb(args,
					"consultasXCodGrupo", URL_SERVICIOS_PORTAL, "urn:consultasXCodGrupo",
					com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public final boolean crearUsuario(String usuario, String password, String passwordConfirmada)
	{
		boolean r = false;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Context ctx = obtenerContexto();
			EditorUsuarios editor = new EditorUsuarios(ctx);
			logger.debug("Creación usuario [" + usuario + "]");
			r = editor.crearUsuario(usuario, password, passwordConfirmada);
			logger.debug("Realizada exitosamente");
		}
		catch (Throwable e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	public com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO cuentasXCodigo(Long codCuenta) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { codCuenta };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO) WSSEGPortal.invocarMetodoWeb(args,
					"cuentasXCodigo", URL_SERVICIOS_PORTAL, "urn:cuentasXCodigo",
					com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	/** No auditado */
	public com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO cuentasXNombre(String descCuenta)
			throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { descCuenta };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO) WSSEGPortal.invocarMetodoWeb(args,
					"cuentasXNombre", URL_SERVICIOS_PORTAL, "urn:cuentasXNombre",
					com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO cuentasXNumIdent(String numIdent)
			throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numIdent };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO) WSSEGPortal.invocarMetodoWeb(args,
					"cuentasXNumIdent", URL_SERVICIOS_PORTAL, "urn:cuentasXNumIdent",
					com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public String decirHelloWorld()
	{
		return "Hello, World!";
	}

	public com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO detalleLlamadas(Long codCliente,
			Long numAbonado, Long codCiclo, String tipoLlamada) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, numAbonado, codCiclo, tipoLlamada };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO) WSSEGPortal.invocarMetodoWeb(args,
					"detalleLlamadas", URL_SERVICIOS_PORTAL, "urn:detalleLlamadas",
					com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public DetallePlanTarifarioDTO detallePlanTarifario(String codPlanTarifario) throws PortalSACException
	{
		DetallePlanTarifarioDTO r = null;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codPlanTarifario };
			r = (DetallePlanTarifarioDTO) WSSEGPortal.invocarMetodoWeb(args, "detallePlanTarifario",
					URL_SERVICIOS_PORTAL, "urn:detallePlanTarifario", DetallePlanTarifarioDTO.class,
					ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
		}
		catch (java.lang.Exception e)
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

	public com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO obtenerCamposDireccion() throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO) WSSEGPortal.invocarMetodoWeb(args,
					"obtenerCamposDireccion", URL_SERVICIOS_PORTAL, "urn:obtenerCamposDireccion",
					com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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
	
	public com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO obtenerDatosDireccionCliente(com.tmmas.scl.wsportal.common.dto.DatosDireccionClienteINDTO pIn) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO r = new com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] {pIn};
			r = (com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO) WSSEGPortal.invocarMetodoWeb(args,
					"obtenerDatosDireccionCliente", URL_SERVICIOS_PORTAL, "obtenerDatosDireccionCliente",
					com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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
	
	public com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO direccionesXCodCliente(Long codCliente,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { codCliente, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO) WSSEGPortal.invocarMetodoWeb(args,
					"direccionesXCodCliente", URL_SERVICIOS_PORTAL, "urn:direccionesXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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
	public EjecucionCambioDatosClienteSACDTO ejecucionCambioDatosCliente(EjecucionCambioDatosClienteSACDTO entrada)
			throws PortalSACException
	{
		EjecucionCambioDatosClienteSACDTO r = new EjecucionCambioDatosClienteSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			String urlWS = config.getString(CLAVE_URL_WS_CAMBIO_DATOS_CLIENTE);

			EjecucionCambioDatosClienteDTO ejecucionDTO = new EjecucionCambioDatosClienteDTO();

			ejecucionDTO.setComentario(entrada.getComentario());
			ejecucionDTO.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			ejecucionDTO.setNumTransaccion(entrada.getNumTransaccion());
			ejecucionDTO.setEjecucionCambioDatosBancariosDTO(entrada.getEjecucionCambioDatosBancariosDTO());
			ejecucionDTO.setEjecucionCambioDatosGeneralesClienteDTO(entrada
					.getEjecucionCambioDatosGeneralesClienteDTO());
			ejecucionDTO.setEjecucionCambioDatosIdentificacionClienteDTO(entrada
					.getEjecucionCambioDatosIdentificacionClienteDTO());
			ejecucionDTO.setEjecucionCambioDatosPersonalesClienteDTO(entrada
					.getEjecucionCambioDatosPersonalesClienteDTO());
			ejecucionDTO.setEjecucionCambioDatosTributariosClienteDTO(entrada
					.getEjecucionCambioDatosTributariosClienteDTO());

			Object[] args = new Object[] { ejecucionDTO };
			Class tipoRetorno = ejecucionDTO.getClass();
			ejecucionDTO = (EjecucionCambioDatosClienteDTO) WSSEGPortal.invocarMetodoWeb(args,
					"ejecucionCambioDatosCliente", urlWS, "urn:ejecucionCambioDatosCliente", tipoRetorno,
					ESPACIO_NOMBRES_FRANQUICIAS);
			if (ejecucionDTO == null)
			{
				logger.debug("Retorno NULO!");
			}
			else
			{
				logger.debug("ejecucionDTO.getNomUsuarioSCL(): " + ejecucionDTO.getNomUsuarioSCL());
				r.setNomUsuarioSCL(ejecucionDTO.getNomUsuarioSCL());
				logger.debug("ejecucionDTO.getNumTransaccion(): " + ejecucionDTO.getNumTransaccion());
				r.setNumTransaccion(ejecucionDTO.getNumTransaccion());
				logger.debug("ejecucionDTO.getCodError() " + ejecucionDTO.getCodError());
				r.setCodError(ejecucionDTO.getCodError());
				logger.debug("ejecucionDTO.getDesError() " + ejecucionDTO.getDesError());
				r.setDesError(ejecucionDTO.getDesError());
				logger.debug("ejecucionDTO.getNroOOSS(): " + ejecucionDTO.getNroOOSS());
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
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionServicioCargosDTO ejecucionServicioCargos(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionServicioCargosDTO entrada) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionServicioCargosDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionServicioCargosDTO();
		EjecucionServicioCargosResponseDocument response = null;
		EjecucionServicioCargosDTO ejecucionDTO = EjecucionServicioCargosDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			String urlWS = config.getString(CLAVE_URL_WS_SERVICIO_CARGOS);
			WSServicioCargosStub stub = new WSServicioCargosStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			EjecucionServicioCargosDocument ejecucionServicioCargosDocument = EjecucionServicioCargosDocument.Factory
					.newInstance();
			EjecucionServicioCargos ejecucionServicioCargosReq = ejecucionServicioCargosDocument
					.addNewEjecucionServicioCargos();
			EjecucionServicioCargosDTO dto = EjecucionServicioCargosDTO.Factory.newInstance();
			dto.setIndContado(entrada.getIndContado().longValue());
			dto.setIndCuota(entrada.getIndCuota().longValue());
			dto.setMesGarantia(entrada.getMesGarantia().longValue());
			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNomUsuaSupervisor(entrada.getNomUsuaSupervisor());
			dto.setNumCargo(entrada.getNumCargo().longValue());
			dto.setPasswordSupervisor(entrada.getPasswordSupervisor());
			dto.setTipPantalla(entrada.getTipPantalla().longValue());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			ejecucionServicioCargosReq.setEjecucionServicioCargosDTO(dto);
			ejecucionServicioCargosDocument.setEjecucionServicioCargos(ejecucionServicioCargosReq);
			response = stub.ejecucionServicioCargos(ejecucionServicioCargosDocument);
			logger.debug("ejecucionServicioCargosDocument: " + ejecucionServicioCargosDocument);
			ejecucionDTO = response.getEjecucionServicioCargosResponse().getReturn();
			logger.debug("ejecucionDTO.getCodError(): " + ejecucionDTO.getCodError());
			r.setCodError(ejecucionDTO.getCodError());
			logger.debug("ejecucionDTO.getDesError(): " + ejecucionDTO.getDesError());
			r.setDesError(ejecucionDTO.getDesError());
			r.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
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

	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimConDTO ejecutarAbonoLimiteConsumo(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimConDTO entrada) throws PortalSACException
	{

		return super.ejecutarAbonoLimiteConsumo(entrada);
	}

	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimiteConsumoServicioSuplementarioDTO ejecutarAbonoLimiteConsumoSS(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionAbonoLimiteConsumoServicioSuplementarioDTO entrada)
			throws PortalSACException
	{
		return super.ejecutarAbonoLimiteConsumoSS(entrada);
	}

	public EjecucionAjusteCExcepcionCargosDTO ejecutarAjusteCExcepcionCargos(
			EjecucionAjusteCExcepcionCargosSACDTO entrada) throws PortalSACException
	{
		return super.ejecutarAjusteCExcepcionCargos(entrada);
	}

	public EjecucionAjusteCReversionCargosDTO ejecutarAjusteCReversionCargos(
			EjecucionAjusteCReversionCargosSACDTO entrada) throws PortalSACException
	{
		return super.ejecutarAjusteCReversionCargos(entrada);
	}

	public EjecucionAnulacionSiniestroDTO ejecutarAnulacionSiniestro(EjecucionAnulacionSiniestroDTO entrada)
			throws PortalSACException
	{
		return super.ejecutarAnulacionSiniestro(entrada);
	}

	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioEquipoGSMDTO ejecutarCambioEquipoGSM(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioEquipoGSMDTO entrada) throws PortalSACException
	{
		return super.ejecutarCambioEquipoGSM(entrada);
	}

	public EjecucionCambioNumFrecuentesSACDTO ejecutarCambioNumFrecuente(EjecucionCambioNumFrecuentesSACDTO entrada)
			throws PortalSACException
	{
		return super.ejecutarCambioNumFrecuente(entrada);
	}

	/** No Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioPlanPostPagoIndividualDTO ejecutarCambioPlanPostPagoIndividual(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioPlanPostPagoIndividualDTO entrada)
			throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioPlanPostPagoIndividualDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioPlanPostPagoIndividualDTO();
		EjecutarCambioPlanPostPagoIndividualResponseDocument response = null;
		EjecucionCambioPlanPostPagoIndividualDTO ejecucionDTO = EjecucionCambioPlanPostPagoIndividualDTO.Factory
				.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			String urlWS = config.getString(CLAVE_URL_WS_SERV_CAMBIO_PLAPOSTPAGO_INDIVIDUAL);
			WSServCambioPlaPostPagoIndividualStub stub = new WSServCambioPlaPostPagoIndividualStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			EjecutarCambioPlanPostPagoIndividualDocument ejecutarCambioPlaPostPagoIndividualDocument = EjecutarCambioPlanPostPagoIndividualDocument.Factory
					.newInstance();

			EjecutarCambioPlanPostPagoIndividual ejecutarCambioPlanPostPagoIndividualReq = ejecutarCambioPlaPostPagoIndividualDocument
					.addNewEjecutarCambioPlanPostPagoIndividual();
			EjecucionCambioPlanPostPagoIndividualDTO dto = EjecucionCambioPlanPostPagoIndividualDTO.Factory
					.newInstance();
			dto.setCodPlanTarifNuevo(entrada.getCodPlanTarifNuevo());
			dto.setComentario(entrada.getComentario());
			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNroOOSS(entrada.getNroOOSS());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			ejecutarCambioPlanPostPagoIndividualReq.setEjecucionCambioPlanPostPagoIndividualDTO(dto);
			ejecutarCambioPlaPostPagoIndividualDocument
					.setEjecutarCambioPlanPostPagoIndividual(ejecutarCambioPlanPostPagoIndividualReq);
			response = stub.ejecutarCambioPlanPostPagoIndividual(ejecutarCambioPlaPostPagoIndividualDocument);
			logger.debug("ejecutarCambioPlaPostPagoIndividualDocument: " + ejecutarCambioPlaPostPagoIndividualDocument);
			ejecucionDTO = response.getEjecutarCambioPlanPostPagoIndividualResponse().getReturn();
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

	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioSIMCardDTO ejecutarCambioSIMCard(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionCambioSIMCardDTO entrada) throws PortalSACException
	{
		return super.ejecutarCambioSIMCard(entrada);
	}

	/** No Auditado */
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionReposicionSrvCelDTO ejecutarReposicionSrvCelular(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionReposicionSrvCelDTO entrada) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionReposicionSrvCelDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionReposicionSrvCelDTO();
		EjecutarReposicionSrvCelularResponseDocument response = null;
		EjecucionReposicionSrvCelDTO ejecucionDTO = EjecucionReposicionSrvCelDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			String urlWS = config.getString(CLAVE_URL_WS_REPOSICION_VOLUNTARIA_SERVICIO_CEL);
			WSReposicionVoluntariaServicioCelStub stub = new WSReposicionVoluntariaServicioCelStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			EjecutarReposicionSrvCelularDocument ejecutarReposicionSrvCelularDocument = EjecutarReposicionSrvCelularDocument.Factory
					.newInstance();
			EjecutarReposicionSrvCelular ejecutarReposicionSrvCelularReq = ejecutarReposicionSrvCelularDocument
					.addNewEjecutarReposicionSrvCelular();
			EjecucionReposicionSrvCelDTO dto = EjecucionReposicionSrvCelDTO.Factory.newInstance();
			dto.setComentario(entrada.getComentario());
			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNroOOSS(entrada.getNroOOSS());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			ejecutarReposicionSrvCelularReq.setEjecucionReposicionSrvCelDTO(dto);
			ejecutarReposicionSrvCelularDocument.setEjecutarReposicionSrvCelular(ejecutarReposicionSrvCelularReq);
			response = stub.ejecutarReposicionSrvCelular(ejecutarReposicionSrvCelularDocument);
			logger.debug("ejecutarReposicionSrvCelularDocument: " + ejecutarReposicionSrvCelularDocument);
			ejecucionDTO = response.getEjecutarReposicionSrvCelularResponse().getReturn();
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
	public com.tmmas.scl.wsfranquicias.common.dto.EjecucionSuspensionSrvCelDTO ejecutarSuspensionSrvCelular(
			com.tmmas.scl.wsfranquicias.common.dto.EjecucionSuspensionSrvCelDTO entrada) throws PortalSACException
	{
		com.tmmas.scl.wsfranquicias.common.dto.EjecucionSuspensionSrvCelDTO r = new com.tmmas.scl.wsfranquicias.common.dto.EjecucionSuspensionSrvCelDTO();
		EjecutarSuspensionSrvCelularResponseDocument response = null;
		EjecucionSuspensionSrvCelDTO ejecucionDTO = EjecucionSuspensionSrvCelDTO.Factory.newInstance();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			String urlWS = config.getString(CLAVE_URL_WS_SUSPENSION_VOLUNTARIA_SERVICIO_CEL);
			WSSuspensionVoluntariaServicioCelStub stub = new WSSuspensionVoluntariaServicioCelStub(urlWS);
			stub._getServiceClient().getOptions().setTimeOutInMilliSeconds(600000);
			EjecutarSuspensionSrvCelularDocument ejecutarSuspensionSrvCelularDocument = EjecutarSuspensionSrvCelularDocument.Factory
					.newInstance();
			EjecutarSuspensionSrvCelular ejecutarSuspensionSrvCelularReq = ejecutarSuspensionSrvCelularDocument
					.addNewEjecutarSuspensionSrvCelular();
			EjecucionSuspensionSrvCelDTO dto = EjecucionSuspensionSrvCelDTO.Factory.newInstance();
			dto.setComentario(entrada.getComentario());
			dto.setNomUsuarioSCL(entrada.getNomUsuarioSCL());
			dto.setNroOOSS(entrada.getNroOOSS());
			dto.setNumTransaccion(entrada.getNumTransaccion());
			dto.setCodCauSusp(entrada.getCodCauSusp());
			ejecutarSuspensionSrvCelularReq.setEjecucionSuspensionSrvCelDTO(dto);
			ejecutarSuspensionSrvCelularDocument.setEjecutarSuspensionSrvCelular(ejecutarSuspensionSrvCelularReq);
			response = stub.ejecutarSuspensionSrvCelular(ejecutarSuspensionSrvCelularDocument);
			logger.debug("ejecutarSuspensionSrvCelularDocument: " + ejecutarSuspensionSrvCelularDocument);
			ejecucionDTO = response.getEjecutarSuspensionSrvCelularResponse().getReturn();
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

	public Boolean esPrimerLogin(String nomUsuario) throws PortalSACException
	{
		Boolean r = Boolean.FALSE;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { nomUsuario };
			r = (Boolean) WSSEGPortal.invocarMetodoWeb(args, "esPrimerLogin", URL_SERVICIOS_PORTAL,
					"urn:esPrimerLogin", Boolean.class, ESPACIO_NOMBRES_PORTAL);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	public com.tmmas.scl.wsportal.common.dto.ListadoFacturasDTO facturasXCodCliente(Long codCliente,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoFacturasDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoFacturasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoFacturasDTO) WSSEGPortal.invocarMetodoWeb(args,
					"facturasXCodCliente", URL_SERVICIOS_PORTAL, "urn:facturasXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoFacturasDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public FiltroDetDocAjusteCCargosSACDTO filtrarDetDocAjusteCExcepcionCargos(FiltroDetDocAjusteCCargosSACDTO entrada)
			throws PortalSACException
	{
		return super.filtrarDetDocAjusteCExcepcionCargos(entrada);
	}

	public FiltroDetDocAjusteCCargosSACDTO filtrarDetDocAjusteCReversionCargos(FiltroDetDocAjusteCCargosSACDTO entrada)
			throws PortalSACException
	{
		return super.filtrarDetDocAjusteCReversionCargos(entrada);
	}

	public com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO getDetalleAbonado(Long numAbonado, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO r = new com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numAbonado, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO) WSSEGPortal.invocarMetodoWeb(args,
					"detalleAbonado", URL_SERVICIOS_PORTAL, "urn:detalleAbonado",
					com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO getDetalleCliente(Long codCliente, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO r = new com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO) WSSEGPortal.invocarMetodoWeb(args,
					"detalleCliente", URL_SERVICIOS_PORTAL, "urn:detalleCliente",
					com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO getDetalleCuenta(Long codCuenta, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO r = new com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO();
		try
		{
			Object[] args = new Object[] { codCuenta, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO) WSSEGPortal.invocarMetodoWeb(args,
					"detalleCuenta", URL_SERVICIOS_PORTAL, "urn:detalleCuenta",
					com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO getDetalleDireccion(Long codDireccion,
			String codTipDireccion) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO r = new com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codDireccion, codTipDireccion };
			r = (com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO) WSSEGPortal.invocarMetodoWeb(args,
					"detalleDireccion", URL_SERVICIOS_PORTAL, "urn:detalleDireccion",
					com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO getDetalleEquipo(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO r = new com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numAbonado, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO) WSSEGPortal.invocarMetodoWeb(args,
					"detalleEquipoSimcardXNumAbonado", URL_SERVICIOS_PORTAL, "urn:detalleEquipoSimcardXNumAbonado",
					com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO getDeudaCliente(Long codCliente) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO r = new com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente };
			r = (com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO) WSSEGPortal.invocarMetodoWeb(args,
					"getDeudaCliente", URL_SERVICIOS_PORTAL, "urn:getDeudaCliente",
					com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO getDocsAjustesCliente(
			com.tmmas.scl.wsportal.common.dto.GetDocsClienteINDTO obj) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { obj };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO) WSSEGPortal.invocarMetodoWeb(args,
					"getDocsAjustesCliente", URL_SERVICIOS_PORTAL, "urn:getDocsAjustesCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO getDocsCtaCteCliente(
			com.tmmas.scl.wsportal.common.dto.GetDocsClienteINDTO obj, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { obj, nomUsuarioSCL, codEvento };

			r = (com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO) WSSEGPortal.invocarMetodoWeb(args,
					"getDocsCtaCteCliente", URL_SERVICIOS_PORTAL, "urn:getDocsCtaCteCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO getDocsFactCliente(
			com.tmmas.scl.wsportal.common.dto.GetDocsClienteINDTO obj) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { obj };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO) WSSEGPortal.invocarMetodoWeb(args,
					"getDocsFactCliente", URL_SERVICIOS_PORTAL, "urn:getDocsFactCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO.class, ESPACIO_NOMBRES_PORTAL);

			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO getDocsPagosCliente(
			com.tmmas.scl.wsportal.common.dto.GetDocsClienteINDTO obj) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { obj };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO) WSSEGPortal.invocarMetodoWeb(args,
					"getDocsPagosCliente", URL_SERVICIOS_PORTAL, "urn:getDocsPagosCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	/** No auditado */
	public ListadoGruposDTO gruposXNomUsuario(String nomUsuario) throws PortalSACException
	{
		ListadoGruposDTO r = new ListadoGruposDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { nomUsuario };
			r = (ListadoGruposDTO) WSSEGPortal.invocarMetodoWeb(args, "gruposXNomUsuario", URL_SERVICIOS_PORTAL,
					"urn:gruposXNomUsuario", ListadoGruposDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO limiteConsumoXClienteAbonado(Long codCliente,
			Long numAbonado, String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, numAbonado, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO) WSSEGPortal.invocarMetodoWeb(args,
					"limiteConsumoXClienteAbonado", URL_SERVICIOS_PORTAL, "urn:limiteConsumoXClienteAbonado",
					com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public ListadoNumerosFrecuentesDTO numerosFrecuentesXPlan(Long numAbonado) throws PortalSACException
	{
		ListadoNumerosFrecuentesDTO r = new ListadoNumerosFrecuentesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numAbonado };
			r = (ListadoNumerosFrecuentesDTO) WSSEGPortal.invocarMetodoWeb(args, "numerosFrecuentesXPlan",
					URL_SERVICIOS_PORTAL, "urn:numerosFrecuentesXPlan", ListadoNumerosFrecuentesDTO.class,
					ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO oossEjecutadasXCodCliente(Long codCliente,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO) WSSEGPortal.invocarMetodoWeb(args,
					"oossEjecutadasXCodCliente", URL_SERVICIOS_PORTAL, "urn:oossEjecutadasXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO oossEjecutadasXCodCuenta(Long codCuenta,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCuenta, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO) WSSEGPortal.invocarMetodoWeb(args,
					"oossEjecutadasXCodCuenta", URL_SERVICIOS_PORTAL, "urn:oossEjecutadasXCodCuenta",
					com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO oossEjecutadasXNumAbonado(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numAbonado, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO) WSSEGPortal.invocarMetodoWeb(args,
					"oossEjecutadasXNumAbonado", URL_SERVICIOS_PORTAL, "urn:oossEjecutadasXNumAbonado",
					com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO pagoLimiteConsumoXClienteAbonado(
			Long codCliente, Long numAbonado, String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, numAbonado, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO) WSSEGPortal.invocarMetodoWeb(args,
					"pagoLimiteConsumoXClienteAbonado", URL_SERVICIOS_PORTAL, "urn:pagoLimiteConsumoXClienteAbonado",
					com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoPagosDTO pagosXCodCliente(Long codCliente, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoPagosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoPagosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoPagosDTO) WSSEGPortal.invocarMetodoWeb(args,
					"pagosXCodCliente", URL_SERVICIOS_PORTAL, "urn:pagosXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoPagosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO productosXCodCliente(Long codCliente,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO) WSSEGPortal.invocarMetodoWeb(args,
					"productosXCodCliente", URL_SERVICIOS_PORTAL, "urn:productosXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO productosXNumAbonado(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { numAbonado, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO) WSSEGPortal.invocarMetodoWeb(args,
					"productosXNumAbonado", URL_SERVICIOS_PORTAL, "urn:productosXNumAbonado",
					com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public RealizarBloqueoRoboSACOUTDTO realizarBloqueoRobo(RealizarBloqueoRoboSACINDTO dto) throws PortalSACException
	{
		return super.realizarBloqueoRobo(dto);
	}

	public com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO servSumplemetariosXAbonado(Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numAbonado, nomUsuarioSCL, codEvento };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO) WSSEGPortal.invocarMetodoWeb(args,
					"servSumplemetariosXAbonado", URL_SERVICIOS_PORTAL, "urn:servSumplemetariosXAbonado",
					com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public ListadoServSuplementariosDTO ssXDefectoXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoServSuplementariosDTO r = new ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente };
			r = (ListadoServSuplementariosDTO) WSSEGPortal.invocarMetodoWeb(args, "ssXDefectoXCodCliente",
					URL_SERVICIOS_PORTAL, "urn:ssXDefectoXCodCliente", ListadoServSuplementariosDTO.class,
					ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public ListadoServSuplementariosDTO ssXDefectoXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ListadoServSuplementariosDTO r = new ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numAbonado };
			r = (ListadoServSuplementariosDTO) WSSEGPortal.invocarMetodoWeb(args, "ssXDefectoXNumAbonado",
					URL_SERVICIOS_PORTAL, "urn:ssXDefectoXNumAbonado", ListadoServSuplementariosDTO.class,
					ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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

	public com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO umtsAbonadosXCodCliente(Long codCliente)
			throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { codCliente };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO) WSSEGPortal.invocarMetodoWeb(args,
					"umtsAbonadosXCodCliente", URL_SERVICIOS_PORTAL, "urn:umtsAbonadosXCodCliente",
					com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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
	
	public com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO obtenerOoSsAgendadas(Long numDato, Integer tipoDato) throws PortalSACException{
		
		com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(numDato) && !val.datosNotNull(tipoDato) ){
			r.setCodError("1001");
			r.setDesError("Faltan datos de entrada");
			return r;
		}
		
		if(!val.validaNumero(numDato) && !val.validaNumero(tipoDato) ){
			r.setCodError("1002");
			r.setDesError("Uno o mas de los dato de entrada no cumple con el tipo de dato");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numDato, tipoDato };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO) WSSEGPortal.invocarMetodoWeb(args,"obtenerOoSsAgendadas", URL_SERVICIOS_PORTAL,
					"urn:obtenerOoSsAgendadas",com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}

	public com.tmmas.scl.wsportal.common.dto.ListadoServSuplxOOSSDTO servSuplXOOSS(Long numOOSS) throws PortalSACException{
		
		com.tmmas.scl.wsportal.common.dto.ListadoServSuplxOOSSDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoServSuplxOOSSDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(numOOSS)){
			r.setCodError("1001");
			r.setDesError("Faltan datos de entrada");
			return r;
		}
		
		if(!val.validaNumero(numOOSS)){
			r.setCodError("1002");
			r.setDesError("Uno o mas de los dato de entrada no cumple con el tipo de dato");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numOOSS };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoServSuplxOOSSDTO) WSSEGPortal.invocarMetodoWeb(args,"servSuplXOOSS", URL_SERVICIOS_PORTAL,
					"urn:servSuplXOOSS",com.tmmas.scl.wsportal.common.dto.ListadoServSuplxOOSSDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	public java.lang.Boolean consultaOoSsProceso(String nomUsuario) throws PortalSACException{	
		
		java.lang.Boolean r = false;
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(nomUsuario)){
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { nomUsuario };
			r = (java.lang.Boolean) WSSEGPortal.invocarMetodoWeb(args,"consultaOoSsProceso", URL_SERVICIOS_PORTAL,
					"urn:consultaOoSsProceso",java.lang.Boolean.class, ESPACIO_NOMBRES_PORTAL);
			//logger.debug("codError [" + r.getCodError() + "]");
			//logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			//r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	public com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO obtenerOoSsProceso(java.lang.String nomUsuario) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(nomUsuario)){
			r.setCodError("1001");
			r.setDesError("Faltan datos de entrada");
			return r;
		}

		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { nomUsuario };
			r = (com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO) WSSEGPortal.invocarMetodoWeb(args,"obtenerOoSsProceso", URL_SERVICIOS_PORTAL,
					"urn:obtenerOoSsProceso",com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: AbonadoDTO
	 * Descripcion: Obtiene los datos de un abonado
	 * throws: PortalSACException
	 * 
	 */
	
	public com.tmmas.scl.wsportal.common.dto.AbonadoDTO obtenerDatosAbonado(Long numAbonado) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.AbonadoDTO r = new com.tmmas.scl.wsportal.common.dto.AbonadoDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(numAbonado)){
			return r;
		}
		
		if(!val.validaNumero(numAbonado)){
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] { numAbonado };
			r = (com.tmmas.scl.wsportal.common.dto.AbonadoDTO) WSSEGPortal.invocarMetodoWeb(args,"obtenerDatosAbonado", URL_SERVICIOS_PORTAL_MEJORA,
					"urn:obtenerDatosAbonado",com.tmmas.scl.wsportal.common.dto.AbonadoDTO.class, ESPACIO_NOMBRES_PORTAL);
			//logger.debug("codError [" + r.getCodError() + "]");
			//logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			//r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaAtencion
	 * Return: ListaAtencionClienteDTO
	 * Descripcion: Obtiene las atenciones de los clientes
	 * throws: PortalSACException
	 * 
	 */
	
	public com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO consultaAtencion() throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO r = new com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO();

		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {};
			r = (com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO) WSSEGPortal.invocarMetodoWeb(args,"consultaAtencion", URL_SERVICIOS_PORTAL_MEJORA,
					"urn:consultaAtencion",com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: IngresoAtencion
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta una gestion de atencion
	 * throws: PortalSACException
	 * 
	 */
	
	public com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO ingresoAtencion(ResgistroAtencionDTO resgistroAtencionDTO) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO r = new com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(    !val.datosNotNull(resgistroAtencionDTO.getCodAtencion()) && !val.datosNotNull(resgistroAtencionDTO.getFechaFin()) 
			&& !val.datosNotNull(resgistroAtencionDTO.getFechaIni()) && !val.datosNotNull(resgistroAtencionDTO.getNomUsua())
			&& !val.datosNotNull(resgistroAtencionDTO.getNumAbonado()) ){
			r.setCodRetorno(Long.valueOf("1001"));
			r.setMenRetorno("Faltan datos de entrada");
			return r;
		}
		
		if(!val.validaNumero(resgistroAtencionDTO.getNumAbonado())){
			r.setCodRetorno(Long.valueOf("1002"));
			r.setMenRetorno("Uno o mas de los dato de entrada no cumple con el tipo de dato");
			return r;
		}
		
		if(!val.valForFecCompl(resgistroAtencionDTO.getFechaIni()) && !val.valForFecCompl(resgistroAtencionDTO.getFechaFin()) ){
			r.setCodRetorno(Long.valueOf("1003"));
			r.setMenRetorno("Uno o mas de las fechas ingresadas no cumple con el formato DD-MM-YYYY ");
			return r;
		}
		
		if(!val.valFecIniFinCompl(resgistroAtencionDTO.getFechaIni(), resgistroAtencionDTO.getFechaFin()) ){
			r.setCodRetorno(Long.valueOf("1004"));
			r.setMenRetorno("La fecha hasta debe ser igual o superior a la fecha desde");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {resgistroAtencionDTO};
			r = (com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO) WSSEGPortal.invocarMetodoWeb(args,"ingresoAtencion", URL_SERVICIOS_PORTAL_MEJORA,
					"urn:ingresoAtencion",com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO.class, ESPACIO_NOMBRES_PORTAL);
			//logger.debug("codError [" + r.getCodError() + "]");
			//logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			//r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario 
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerListDatosAbonados
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los datos de de los abonados asociados a un cliente
	 * throws: PortalSACException
	 * 
	 */
	
	public com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO obtenerListDatosAbonados(Long codCliente) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(codCliente)){
			r.setCodError("1001");
			r.setDesError("Faltan datos de entrada");
			return r;
		}
		
		if(!val.validaNumero(codCliente)){
			r.setCodError("1002");
			r.setDesError("Uno o mas de los dato de entrada no cumple con el tipo de dato");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {codCliente};
			r = (com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO) WSSEGPortal.invocarMetodoWeb(args,"obtenerListDatosAbonados", URL_SERVICIOS_PORTAL_MEJORA,
					"urn:obtenerListDatosAbonados",com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaCuenta
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los abonados asociados a una cuenta
	 * throws: PortalSACException
	 * 
	 */

	public com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO consultaCuenta(Long codCuenta) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(codCuenta)){
			r.setCodError("1001");
			r.setDesError("Faltan datos de entrada");
			return r;
		}
		
		if(!val.validaNumero(codCuenta)){
			r.setCodError("1002");
			r.setDesError("Uno o mas de los dato de entrada no cumple con el tipo de dato");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {codCuenta};
			r = (com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO) WSSEGPortal.invocarMetodoWeb(args,"consultaCuenta", URL_SERVICIOS_PORTAL_MEJORA,
					"urn:consultaCuenta",com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-005 Agregar Comentario de OOSS Reversión de Cargos
	 * Requisito: RSis_003 
	 * Caso de uso: CU-006 Agregar Comentario de OOSS Ajuste por Excepción
	 * Developer: Gabriel Moraga L.
	 * Fecha: 04/08/2010
	 * Metodo: insertComentario
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta un comentario
	 * throws: PortalSACException
	 * 
	 */

	public com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO insertComentario(String comentario, Long numOoss ) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO r = new com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(comentario) && !val.datosNotNull(numOoss)){
			r.setCodRetorno(Long.valueOf("1001"));
			r.setMenRetorno("Faltan datos de entrada");
			return r;
		}
		
		if(!val.validaNumero(numOoss)){
			r.setCodRetorno(Long.valueOf("1002"));
			r.setMenRetorno("Uno o mas de los dato de entrada no cumple con el tipo de dato");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {comentario, numOoss};
			r = (com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO) WSSEGPortal.invocarMetodoWeb(args,"insertComentario", URL_SERVICIOS_PORTAL,
					"urn:insertComentario",com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodRetorno() + "]");
			logger.debug("desError [" + r.getMenRetorno() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			r.setMenRetorno(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-004 Agregar Comentario de OOSS Aviso de Siniestro
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/08/2010
	 * Metodo: insertComentarioPvIorserv
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta un comentario
	 * throws: PortalSACException
	 * 
	 */

	public com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO insertComentarioPvIorserv(String comentario, Long numOoss ) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO r = new com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(comentario) && !val.datosNotNull(numOoss)){
			r.setCodRetorno(Long.valueOf("1001"));
			r.setMenRetorno("Faltan datos de entrada");
			return r;
		}
		
		if(!val.validaNumero(numOoss)){
			r.setCodRetorno(Long.valueOf("1002"));
			r.setMenRetorno("Uno o mas de los dato de entrada no cumple con el tipo de dato");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {comentario, numOoss};
			r = (com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO) WSSEGPortal.invocarMetodoWeb(args,"insertComentarioPvIorserv", URL_SERVICIOS_PORTAL,
					"urn:insertComentarioPvIorserv",com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodRetorno() + "]");
			logger.debug("desError [" + r.getMenRetorno() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			r.setMenRetorno(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 -F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-045 Generar Reporte de cambios de equipo generados
	 * Developer: Gabriel Moraga L.
	 * Fecha: 24/08/2010
	 * Metodo: obtenerReporteCambioEquiGene
	 * Return: ListadoReporteCamEquiGenDTO
	 * Descripcion: Obtiene informacion por rango de fechas y causal de cambio de equipo
	 * throws: PortalSACException
	 * 
	 */
	
	public com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO obtenerReporteCambioEquiGene(String fechaDesde, String fechaHasta, String codCausalCam) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(    !val.datosNotNull(fechaDesde) && !val.datosNotNull(fechaHasta) && !val.datosNotNull(codCausalCam) ){
			r.setCodError("1001");
			r.setDesError("Faltan datos de entrada");
			return r;
		}
		
		if(!val.validaFormatoFecha(fechaDesde) && !val.validaFormatoFecha(fechaHasta) ){
			r.setCodError("1003");
			r.setDesError("Uno o mas de las fechas ingresadas no cumple con el formato DD-MM-YYYY ");
			return r;
		}
		
		if(!val.validaFechaIniFin(fechaDesde, fechaHasta) ){
			r.setCodError("1004");
			r.setDesError("La fecha hasta debe ser igual o superior a la fecha desde");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {fechaDesde, fechaHasta, codCausalCam};
			r = (com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO) WSSEGPortal.invocarMetodoWeb(args,"obtenerReporteCambioEquiGene", URL_SERVICIOS_PORTAL,
					"urn:obtenerReporteCambioEquiGene",com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 - F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-046 Generar Reporte de ingreso de equipos y status del equipo
	 * Developer: Gabriel Moraga L.
	 * Fecha: 25/08/2010
	 * Metodo: obtenerReporteIngrStatusEqui
	 * Return: ListadoReporteIngrStatusEquiDTO
	 * Descripcion: Obtiene informacion por rango de fechas
	 * throws: PortalSACException
	 * 
	 */

	public com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO obtenerReporteIngrStatusEqui(String fechaDesde, String fechaHasta) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(    !val.datosNotNull(fechaDesde) && !val.datosNotNull(fechaHasta) ){
			r.setCodError("1001");
			r.setDesError("Faltan datos de entrada");
			return r;
		}

		if(!val.validaFormatoFecha(fechaDesde) && !val.validaFormatoFecha(fechaHasta) ){
			r.setCodError("1003");
			r.setDesError("Uno o mas de las fechas ingresadas no cumple con el formato DD-MM-YYYY ");
			return r;
		}
		
		if(!val.validaFechaIniFin(fechaDesde, fechaHasta) ){
			r.setCodError("1004");
			r.setDesError("La fecha hasta debe ser igual o superior a la fecha desde");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {fechaDesde, fechaHasta};
			r = (com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO) WSSEGPortal.invocarMetodoWeb(args,"obtenerReporteIngrStatusEqui", URL_SERVICIOS_PORTAL,
					"urn:obtenerReporteIngrStatusEqui",com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 - F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-047 Generar Reporte de préstamos de equipos internos
	 * Developer: Gabriel Moraga L.
	 * Fecha: 25/08/2010
	 * Metodo: obtenerReportePresEquiInt
	 * Return: ListadoReportePresEquiIntDTO
	 * Descripcion: Obtiene informacion por rango de fechas
	 * throws: PortalSACException
	 * 
	 */
	
	public com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO obtenerReportePresEquiInt(String fechaDesde, String fechaHasta) throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO r = new com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(    !val.datosNotNull(fechaDesde) && !val.datosNotNull(fechaHasta) ){
			r.setCodError("1001");
			r.setDesError("Faltan datos de entrada");
			return r;
		}

		if(!val.validaFormatoFecha(fechaDesde) && !val.validaFormatoFecha(fechaHasta) ){
			r.setCodError("1003");
			r.setDesError("Uno o mas de las fechas ingresadas no cumple con el formato DD-MM-YYYY ");
			return r;
		}
		
		if(!val.validaFechaIniFin(fechaDesde, fechaHasta) ){
			r.setCodError("1004");
			r.setDesError("La fecha hasta debe ser igual o superior a la fecha desde");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {fechaDesde, fechaHasta};
			r = (com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO) WSSEGPortal.invocarMetodoWeb(args,"obtenerReportePresEquiInt", URL_SERVICIOS_PORTAL,
					"urn:obtenerReportePresEquiInt",com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008 -F2
	 * Requisito: RSis-023 Generación de Reportes STP
	 * Caso de uso: CU-STP-045 Generar Reporte de cambios de equipo generados
	 * Developer: Gabriel Moraga L.
	 * Fecha: 27/08/2010
	 * Metodo: obtenerCausalCambio
	 * Return: ListaCausalCambioDTO
	 * Descripcion: Obtiene las causales de cambio
	 * throws: PortalSACException
	 * 
	 */

	public com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO obtenerCausalCambio() throws PortalSACException{	
		
		com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO r = new com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {};
			r = (com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO) WSSEGPortal.invocarMetodoWeb(args,"obtenerCausalCambio", URL_SERVICIOS_PORTAL,
					"urn:obtenerCausalCambio",com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	
	/*
	 * Proyecto: P-CSR-11003 Mejoras al Portal SAC y Evolución Gestor Posventa P-CSR-11003
	 * Requisito: RSis_003 
	 * Developer: Rafael Aguero Vega.
	 * Fecha: 21/03/2011
	 * Metodo: solicitaUrlDominioPuerto
	 * Return: MuestraURLDTO
	 * Descripcion: ingresa el Codigo de orden de servicio y Solicitar URL con Dominio y Puerto
	 * throws: PortalSACException
	 * 
	 */
	
	public com.tmmas.scl.wsportal.common.dto.MuestraURLDTO solicitaUrlDominioPuerto (String strCodOrdenServ) throws PortalSACException{
		
		com.tmmas.scl.wsportal.common.dto.MuestraURLDTO r = new com.tmmas.scl.wsportal.common.dto.MuestraURLDTO();
		
		/*
		 * Validar datos de entrada
		 */
		
		Validacion val = new Validacion();
		
		if(!val.datosNotNull(strCodOrdenServ)){
			r.setCodRetorno(Long.valueOf("1001"));
			r.setMenRetorno("Faltan datos de entrada");
			return r;
		}
		
		/*
		 * Validar datos de entrada
		 */
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			Object[] args = new Object[] {strCodOrdenServ};
			r = (com.tmmas.scl.wsportal.common.dto.MuestraURLDTO) WSSEGPortal.invocarMetodoWeb(args,"solicitaUrlDominioPuerto", URL_SERVICIOS_PORTAL,
					"urn:solicitaUrlDominioPuerto",com.tmmas.scl.wsportal.common.dto.MuestraURLDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodRetorno() + "]");
			logger.debug("desError [" + r.getMenRetorno() + "]");
			
		}catch (Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			r.setMenRetorno(pe.getMessage());
			return r;
		}
		
		logger.info(MENSAJE_FIN_LOG);
		return r;
	
	}
	
	public com.tmmas.scl.wsportal.common.dto.ParametrosKioscoDTO obtenerParametroKiosco() throws PortalSACException
	{
		com.tmmas.scl.wsportal.common.dto.ParametrosKioscoDTO r = new com.tmmas.scl.wsportal.common.dto.ParametrosKioscoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);

			Object[] args = new Object[] { };
			r = (com.tmmas.scl.wsportal.common.dto.ParametrosKioscoDTO) WSSEGPortal.invocarMetodoWeb(args,
					"obtenerParametroKiosco", URL_SERVICIOS_PORTAL, "urn:obtenerParametroKiosco",
					com.tmmas.scl.wsportal.common.dto.ParametrosKioscoDTO.class, ESPACIO_NOMBRES_PORTAL);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
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