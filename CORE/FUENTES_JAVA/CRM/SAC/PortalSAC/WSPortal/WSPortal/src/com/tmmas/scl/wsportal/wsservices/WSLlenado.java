/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsportal.wsservices;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.common.dto.AuditoriaDTO;
import com.tmmas.scl.wsportal.common.dto.DatosDireccionClienteINDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.DetallePlanTarifarioDTO;
import com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO;
import com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO;
import com.tmmas.scl.wsportal.common.dto.GetDocsClienteINDTO;
import com.tmmas.scl.wsportal.common.dto.ListaCausalCambioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAjustesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoBeneficiosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCambiosPlanTarifDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCamposDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDireccionesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoFacturasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoGruposDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoNumerosFrecuentesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPagosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReporteCamEquiGenDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReporteIngrStatusEquiDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoReportePresEquiIntDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplxOOSSDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.MenuDTO;
import com.tmmas.scl.wsportal.common.dto.MuestraURLDTO;
import com.tmmas.scl.wsportal.common.dto.ParametrosKioscoDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.locator.ServiceLocator;
import com.tmmas.scl.wsportal.negocio.ejb.session.LlenadoFacade;

public class WSLlenado
{
	private static final String INICIO_LOG = "Inicio";

	private static final String FIN_LOG = "Fin";

	private static final String CLAVE_CONFIGURACION_LOG = "WSPortalWS.archivo.config.log4j";

	public static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/WSPortalWS.properties";

	public static final String PROPERTIES_EXTERNO = "WSPortalWS.properties";

	private static CompositeConfiguration config = UtilProperty
			.getConfiguration(PROPERTIES_EXTERNO, PROPERTIES_INTERNO);

	private static final String CONFIGURACION_LOG = config.getString(CLAVE_CONFIGURACION_LOG);

	private static Logger logger = Logger.getLogger(WSLlenado.class);

	private static String COD_ERROR = config.getString("COD.ERR_SAC.3000");

	private static String DES_ERROR = config.getString("DES.ERR_SAC.3000");

	public WSLlenado()
	{

	}

	public ListadoAbonadosDTO abonadosXCelular(Long numCelular) throws PortalSACException
	{
		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoAbonadosDTO) facade.abonadosXCelular(numCelular);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoAbonadosDTO abonadosXCliente(Long codCliente) throws PortalSACException
	{
		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoAbonadosDTO) facade.abonadosXCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoAjustesDTO ajustesXCodCliente(Long codCliente, Long codTipDocum) throws PortalSACException
	{
		ListadoAjustesDTO r = new ListadoAjustesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoAjustesDTO) facade.ajustesXCodCliente(codCliente, codTipDocum);
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
		logger.info(FIN_LOG);
		return r;
	}
	
	public ListadoBeneficiosDTO beneficiosXClienteAbonado(Long codCliente, Long numAbonado, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		ListadoBeneficiosDTO r = new ListadoBeneficiosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, numAbonado, codCliente, null);
			r = (ListadoBeneficiosDTO) facade.beneficiosXClienteAbonado(codCliente, numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoCambiosPlanTarifDTO cambiosPlanCliente(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoCambiosPlanTarifDTO) facade.cambiosPlanCliente(numOS);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPospago(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoCambiosPlanTarifDTO) facade.cambiosPlanAbonadoPospago(numOS);
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
		logger.info(FIN_LOG);
		return r;
	}
	
	/** Método no auditado */
	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPrepago(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoCambiosPlanTarifDTO) facade.cambiosPlanAbonadoPrepago(numOS);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public MenuDTO cargaValidaOSUsuario(String usuario) throws PortalSACException
	{
		MenuDTO r = new MenuDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (MenuDTO) facade.cargaValidaOSUsuario(usuario);
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
		logger.info(FIN_LOG);
		return r;
	}

	/**Metodo Auditado*/
	public ListadoCuentasCorrientesDTO ccXCodCliente(Long codCliente, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		ListadoCuentasCorrientesDTO r = new ListadoCuentasCorrientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, codCliente, null);
			r = (ListadoCuentasCorrientesDTO) facade.ccXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Metodo No Auditado */
	public ListadoClientesDTO clientesXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoClientesDTO r = new ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoClientesDTO) facade.clientesXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoClientesDTO clientesXCuenta(Long codCuenta) throws PortalSACException
	{
		ListadoClientesDTO r = new ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoClientesDTO) facade.clientesXCuenta(codCuenta);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoClientesDTO clientesXNombre(String nombre) throws PortalSACException
	{
		ListadoClientesDTO r = new ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoClientesDTO) facade.clientesXNombre(nombre);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoConsultasDTO consultasXCodGrupo(String codGrupo, String codPrograma, String numVersion)
			throws PortalSACException
	{
		ListadoConsultasDTO r = new ListadoConsultasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoConsultasDTO) facade.consultasXCodGrupo(codGrupo, codPrograma, numVersion);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoCuentasDTO cuentasXCodigo(Long codCuenta) throws PortalSACException
	{
		ListadoCuentasDTO r = new ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoCuentasDTO) facade.cuentasXCodigo(codCuenta);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoCuentasDTO cuentasXNombre(String descCuenta) throws PortalSACException
	{
		ListadoCuentasDTO r = new ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoCuentasDTO) facade.cuentasXNombre(descCuenta);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoCuentasDTO cuentasXNumIdent(String numIdent) throws PortalSACException
	{
		ListadoCuentasDTO r = new ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoCuentasDTO) facade.cuentasXNumIdent(numIdent);
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
		logger.info(FIN_LOG);
		return r;
	}

	public DetalleAbonadoDTO detalleAbonado(Long numAbonado, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		DetalleAbonadoDTO r = new DetalleAbonadoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, numAbonado, null, null);
			r = (DetalleAbonadoDTO) facade.getDetalleAbonado(numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	public DetalleClienteDTO detalleCliente(Long codCliente, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		DetalleClienteDTO r = new DetalleClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, codCliente, null);
			r = (DetalleClienteDTO) facade.getDetalleCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	public DetalleCuentaDTO detalleCuenta(Long codCuenta, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		DetalleCuentaDTO r = new DetalleCuentaDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, null, codCuenta);
			r = (DetalleCuentaDTO) facade.getDetalleCuenta(codCuenta);
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
		logger.info(FIN_LOG);
		return r;
	}

	public DetalleDireccionDTO detalleDireccion(Long codDireccion, String codTipDireccion) throws PortalSACException
	{
		DetalleDireccionDTO r = new DetalleDireccionDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (DetalleDireccionDTO) facade.getDetalleDireccion(codDireccion, codTipDireccion);
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
		logger.info(FIN_LOG);
		return r;
	}

	public EquipoSimcardDetalleDTO detalleEquipoSimcardXNumAbonado(Long numAbonado, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		EquipoSimcardDetalleDTO r = new EquipoSimcardDetalleDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			logger.debug("numAbonado [" + numAbonado + "]");
			logger.debug("nomUsuarioSCL [" + nomUsuarioSCL + "]");
			logger.debug("codEvento [" + codEvento + "]");
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, numAbonado, null, null);
			r = (EquipoSimcardDetalleDTO) facade.detalleEquipoSimcardXNumAbonado(numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	/**Método no auditado */
	public ListadoDetalleLlamadosDTO detalleLlamadas(Long codCliente, Long numAbonado, Long codCiclo, String tipoLlamada)
			throws PortalSACException
	{
		ListadoDetalleLlamadosDTO r = new ListadoDetalleLlamadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			logger.debug("codCliente [" + codCliente + "]");
			logger.debug("numAbonado [" + numAbonado + "]");
			logger.debug("codCiclo [" + codCiclo + "]");
			logger.debug("tipoLlamada [" + tipoLlamada + "]");
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoDetalleLlamadosDTO) facade.detalleLlamadas(codCliente, numAbonado, codCiclo, tipoLlamada);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public DetallePlanTarifarioDTO detallePlanTarifario(String codPlanTarifario) throws PortalSACException
	{
		DetallePlanTarifarioDTO r = new DetallePlanTarifarioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (DetallePlanTarifarioDTO) facade.detallePlanTarifario(codPlanTarifario);
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
		logger.info(FIN_LOG);
		return r;
	}

	/**Método auditado */
	public ListadoDireccionesDTO direccionesXCodCliente(Long codCliente, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{

		ListadoDireccionesDTO r = new ListadoDireccionesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			logger.debug("codCliente [" + codCliente + "]");
			logger.debug("nomUsuarioSCL [" + nomUsuarioSCL + "]");
			logger.debug("codEvento [" + codEvento + "]");
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, codCliente, null);
			r = (ListadoDireccionesDTO) facade.direccionesXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public Boolean esPrimerLogin(String nomUsuario) throws PortalSACException
	{
		Boolean r = Boolean.FALSE;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = facade.esPrimerLogin(nomUsuario);
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			return r;
		}
		logger.info(FIN_LOG);
		return r;
	}

	/**Método auditado */
	public ListadoFacturasDTO facturasXCodCliente(Long codCliente, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		ListadoFacturasDTO r = new ListadoFacturasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			logger.debug("codCliente [" + codCliente + "]");
			logger.debug("nomUsuarioSCL [" + nomUsuarioSCL + "]");
			logger.debug("codEvento [" + codEvento + "]");
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, codCliente, null);
			r = (ListadoFacturasDTO) facade.facturasXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoCamposDireccionDTO obtenerCamposDireccion() throws PortalSACException
	{
		ListadoCamposDireccionDTO r = new ListadoCamposDireccionDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoCamposDireccionDTO) facade.obtenerCamposDireccion();
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
		logger.info(FIN_LOG);
		return r;
	}
	
	public DireccionPorClienteDTO obtenerDatosDireccionCliente(DatosDireccionClienteINDTO pIn) throws PortalSACException
	{
		DireccionPorClienteDTO r = new DireccionPorClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (DireccionPorClienteDTO) facade.obtenerDatosDireccionCliente(pIn);
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
		logger.info(FIN_LOG);
		return r;
	}
	
	/**Método no auditado */
	public DeudaClienteDTO getDeudaCliente(Long codCliente) throws PortalSACException
	{
		DeudaClienteDTO r = new DeudaClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			logger.debug("codCliente [" + codCliente + "]");
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (DeudaClienteDTO) facade.getDeudaCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoDocCtaCteClienteDTO getDocsAjustesCliente(GetDocsClienteINDTO obj) throws PortalSACException
	{
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoDocCtaCteClienteDTO) facade.getDocsAjustesCliente(obj.getCodCliente(), obj.getFecInicio(), obj
					.getFecFin());
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método Auditado */
	public ListadoDocCtaCteClienteDTO getDocsCtaCteCliente(GetDocsClienteINDTO obj, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);

			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, obj.getCodCliente(), null);
			r = (ListadoDocCtaCteClienteDTO) facade.getDocsCtaCteCliente(obj.getCodCliente(), obj.getFecInicio(), obj
					.getFecFin());
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoDocCtaCteClienteDTO getDocsFactCliente(GetDocsClienteINDTO obj) throws PortalSACException
	{
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoDocCtaCteClienteDTO) facade.getDocsFactCliente(obj.getCodCliente(), obj.getFecInicio(), obj
					.getFecFin());
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoDocCtaCteClienteDTO getDocsPagosCliente(GetDocsClienteINDTO obj) throws PortalSACException
	{
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoDocCtaCteClienteDTO) facade.getDocsPagosCliente(obj.getCodCliente(), obj.getFecInicio(), obj
					.getFecFin());
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoGruposDTO gruposXNomUsuario(String nomUsuario) throws PortalSACException
	{
		ListadoGruposDTO r = new ListadoGruposDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoGruposDTO) facade.gruposXNomUsuario(nomUsuario);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoLimiteConsumoDTO limiteConsumoXClienteAbonado(Long codCliente, Long numAbonado, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		ListadoLimiteConsumoDTO r = new ListadoLimiteConsumoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, numAbonado, codCliente, null);
			r = (ListadoLimiteConsumoDTO) facade.limiteConsumoXClienteAbonado(codCliente, numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoNumerosFrecuentesDTO numerosFrecuentesXPlan(Long numAbonado) throws PortalSACException
	{
		ListadoNumerosFrecuentesDTO r = new ListadoNumerosFrecuentesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoNumerosFrecuentesDTO) facade.numerosFrecuentesXPlan(numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoOrdenesServicioDTO oossEjecutadasXCodCliente(Long codCliente, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, codCliente, null);
			r = (ListadoOrdenesServicioDTO) facade.oossEjecutadasXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoOrdenesServicioDTO oossEjecutadasXCodCuenta(Long codCuenta, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, null, codCuenta);
			r = (ListadoOrdenesServicioDTO) facade.oossEjecutadasXCodCuenta(codCuenta);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoOrdenesServicioDTO oossEjecutadasXNumAbonado(Long numAbonado, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, numAbonado, null, null);
			r = (ListadoOrdenesServicioDTO) facade.oossEjecutadasXNumAbonado(numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Metodo Auditado */
	public ListadoPagosLimiteConsumoDTO pagoLimiteConsumoXClienteAbonado(Long codCliente, Long numAbonado,
			String nomUsuarioSCL, String codEvento) throws PortalSACException
	{
		ListadoPagosLimiteConsumoDTO r = new ListadoPagosLimiteConsumoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, numAbonado, codCliente, null);
			r = (ListadoPagosLimiteConsumoDTO) facade.pagoLimiteConsumoXClienteAbonado(codCliente, numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoPagosDTO pagosXCodCliente(Long codCliente, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		ListadoPagosDTO r = new ListadoPagosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, codCliente, null);
			r = (ListadoPagosDTO) facade.pagosXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	private PortalSACException procesarException(java.lang.Exception e) throws PortalSACException
	{
		PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
				COD_ERROR, DES_ERROR, e);
		return pe;
	}

	/** Método Auditado */
	public ListadoProductosDTO productosXCodCliente(Long codCliente, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		ListadoProductosDTO r = new ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, null, codCliente, null);
			r = facade.productosXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método Auditado */
	public ListadoProductosDTO productosXNumAbonado(Long numAbonado, String nomUsuarioSCL, String codEvento)
			throws PortalSACException
	{
		ListadoProductosDTO r = new ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, numAbonado, null, null);
			r = facade.productosXNumAbonado(numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Metodo Web */
	public void registraAuditoria(AuditoriaDTO dto) throws PortalSACException
	{
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(dto.getCodEvento(), dto.getNomUsuarioSCL(), dto.getNumCelular(), dto.getNumAbonado(), dto
					.getCodCliente(), dto.getCodCuenta());
		}
		catch (java.lang.Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
		}
		logger.info(FIN_LOG);
	}

	/** Metodo Auditado */
	public ListadoServSuplementariosDTO servSumplemetariosXAbonado(Long numAbonado, String nomUsuarioSCL,
			String codEvento) throws PortalSACException
	{
		ListadoServSuplementariosDTO r = new ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			facade.auditar(codEvento, nomUsuarioSCL, null, numAbonado, null, null);
			r = (ListadoServSuplementariosDTO) facade.servSumplemetariosXAbonado(numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoServSuplementariosDTO ssXDefectoXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoServSuplementariosDTO r = new ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoServSuplementariosDTO) facade.ssXDefectoXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoServSuplementariosDTO ssXDefectoXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ListadoServSuplementariosDTO r = new ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoServSuplementariosDTO) facade.ssXDefectoXNumAbonado(numAbonado);
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
		logger.info(FIN_LOG);
		return r;
	}

	/** Método no auditado */
	public ListadoUmtsAbonadosDTO umtsAbonadosXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoUmtsAbonadosDTO r = new ListadoUmtsAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoUmtsAbonadosDTO) facade.umtsAbonadosXCodCliente(codCliente);
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
		logger.info(FIN_LOG);
		return r;
	}
	
	public ListadoOrdenesAgendadasDTO obtenerOoSsAgendadas(Long numDato, Integer tipoDato) throws PortalSACException{
		
		ListadoOrdenesAgendadasDTO r = new ListadoOrdenesAgendadasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListadoOrdenesAgendadasDTO) facade.obtenerOoSsAgendadas(numDato, tipoDato);
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
		logger.info(FIN_LOG);
		return r;
	}
	
	public ListadoServSuplxOOSSDTO servSuplXOOSS(Long numOOSS) throws PortalSACException{
		ListadoServSuplxOOSSDTO r = new ListadoServSuplxOOSSDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ListadoServSuplxOOSSDTO) facade.servSuplXOOSS(numOOSS);
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
		logger.info(FIN_LOG);
		return r;
	}
	
	public Boolean consultaOoSsProceso(String nomUsuario) throws PortalSACException{
		
		Boolean r = false;
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (Boolean) facade.consultaOoSsProceso(nomUsuario);
			//logger.debug("codError [" + r.getCodError() + "]");
			//logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			//r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(FIN_LOG);
		return r;
	}

	public ListadoOrdenesProcesoDTO obtenerOoSsProceso(String nomUsuario) throws PortalSACException{
	
		ListadoOrdenesProcesoDTO r = new ListadoOrdenesProcesoDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListadoOrdenesProcesoDTO) facade.obtenerOoSsProceso(nomUsuario);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
			logger.info(FIN_LOG);
			return r;
		
		}
	
	public ResulTransaccionDTO insertComentario(String comentario, Long numOoss ) throws PortalSACException{
		
		ResulTransaccionDTO r = new ResulTransaccionDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ResulTransaccionDTO) facade.insertComentario(comentario, numOoss);
			logger.debug("codError [" + r.getCodRetorno() + "]");
			logger.debug("desError [" + r.getMenRetorno() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodRetorno(pe.getCodigo());
			r.setMenRetorno(pe.getMessage());
			return r;
		}
			logger.info(FIN_LOG);
			return r;
		
	}
	
	public ResulTransaccionDTO insertComentarioPvIorserv(String comentario, Long numOoss ) throws PortalSACException{
		
		ResulTransaccionDTO r = new ResulTransaccionDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ResulTransaccionDTO) facade.insertComentarioPvIorserv(comentario, numOoss);
			logger.debug("codError [" + r.getCodRetorno() + "]");
			logger.debug("desError [" + r.getMenRetorno() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodRetorno(pe.getCodigo());
			r.setMenRetorno(pe.getMessage());
			return r;
		}
			logger.info(FIN_LOG);
			return r;
		
	}
	
	public MuestraURLDTO solicitaUrlDominioPuerto(String strCodOrdenServ) throws PortalSACException{
		
		MuestraURLDTO r = new MuestraURLDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			
			r = (MuestraURLDTO) facade.solicitaUrlDominioPuerto(strCodOrdenServ);
			//logger.debug("codError [" + r.getCodRetorno() + "]");
			//logger.debug("desError [" + r.getMenRetorno() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodRetorno(pe.getCodigo());
			//r.setMenRetorno(pe.getMessage());
			return r;
		}
			logger.info(FIN_LOG);
			return r;
		
	}
	
	
	
	
	public ListadoReporteCamEquiGenDTO obtenerReporteCambioEquiGene(String fechaDesde, String fechaHasta, String codCausalCam) throws PortalSACException{
		
		ListadoReporteCamEquiGenDTO r = new ListadoReporteCamEquiGenDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListadoReporteCamEquiGenDTO) facade.obtenerReporteCambioEquiGene(fechaDesde, fechaHasta, codCausalCam);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
			logger.info(FIN_LOG);
			return r;
		
	}
	
	public ListadoReporteIngrStatusEquiDTO obtenerReporteIngrStatusEqui(String fechaDesde, String fechaHasta) throws PortalSACException{
		
		ListadoReporteIngrStatusEquiDTO r = new ListadoReporteIngrStatusEquiDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListadoReporteIngrStatusEquiDTO) facade.obtenerReporteIngrStatusEqui(fechaDesde, fechaHasta);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
			logger.info(FIN_LOG);
			return r;
		
	}
	
	public ListadoReportePresEquiIntDTO obtenerReportePresEquiInt(String fechaDesde, String fechaHasta) throws PortalSACException{
		
		ListadoReportePresEquiIntDTO r = new ListadoReportePresEquiIntDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListadoReportePresEquiIntDTO) facade.obtenerReportePresEquiInt(fechaDesde, fechaHasta);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
			logger.info(FIN_LOG);
			return r;
		
	}
	
	public ListaCausalCambioDTO obtenerCausalCambio() throws PortalSACException{
		
		ListaCausalCambioDTO r = new ListaCausalCambioDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListaCausalCambioDTO) facade.obtenerCausalCambio();
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
			logger.info(FIN_LOG);
			return r;
		
	}
	
	public ParametrosKioscoDTO obtenerParametroKiosco() throws PortalSACException
	{
		ParametrosKioscoDTO r = new ParametrosKioscoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			r = (ParametrosKioscoDTO) facade.obtenerParametroKiosco();
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
		logger.info(FIN_LOG);
		return r;
	}
	
}