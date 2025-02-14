/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.DatosDireccionClienteINDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleDireccionDTO;
import com.tmmas.scl.wsportal.common.dto.DetallePlanTarifarioDTO;
import com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DireccionPorClienteDTO;
import com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO;
import com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO;
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
import com.tmmas.scl.wsportal.common.dto.ResgistroAtencionDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.service.servicios.WSPortalSrv;
import com.tmmas.scl.wsportal.service.servicios.auditoria.AuditoriaSrv;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="LlenadoFacade"	
 *           description="An EJB named LlenadoFacade"
 *           display-name="LlenadoFacade"
 *           jndi-name="LlenadoFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 		
 * @generated
 */

public abstract class LlenadoFacadeBean implements javax.ejb.SessionBean
{
	private static final String CLAVE_DES_ERROR = "DES.ERR_SAC.2000";

	private static final String CLAVE_COD_ERROR = "COD.ERR_SAC.2000";

	private static final String CLAVE_CONFIGURACION_LOG = "WSPortalEJB.archivo.config.log4j";

	private static final String PROPERTIES_EXTERNO = "WSPortalEJB.properties";

	private static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/WSPortalEJB.properties";

	private static Logger logger = Logger.getLogger(LlenadoFacadeBean.class);

	private static final String MENSAJE_INICIO_LOG = "Inicio";

	private static final String MENSAJE_FIN_LOG = "Fin";

	private static CompositeConfiguration config = UtilProperty
			.getConfiguration(PROPERTIES_EXTERNO, PROPERTIES_INTERNO);

	private static String COD_ERROR = config.getString(CLAVE_COD_ERROR);

	private static String DES_ERROR = config.getString(CLAVE_DES_ERROR);

	private static final String CONFIGURACION_LOG = config.getString(CLAVE_CONFIGURACION_LOG);

	private WSPortalSrv wsPortalSrv = new WSPortalSrv();

	private AuditoriaSrv auditoriaSrv = new AuditoriaSrv();

	public LlenadoFacadeBean()
	{

	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoAbonadosDTO abonadosXCelular(Long numCelular) throws PortalSACException
	{
		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.abonadosXCelular(numCelular);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoAbonadosDTO abonadosXCliente(Long codCliente) throws PortalSACException
	{

		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.abonadosXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoAjustesDTO ajustesXCodCliente(Long codCliente, Long codTipDocum) throws PortalSACException
	{

		ListadoAjustesDTO r = new ListadoAjustesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.ajustesXCodCliente(codCliente, codTipDocum);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public void auditar(String codEvento, String nomUsuarioSCL, Long numCelular, Long numAbonado, Long codCliente,
			Long codCuenta) throws PortalSACException
	{
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			auditoriaSrv.auditar(codEvento, nomUsuarioSCL, numCelular, numAbonado, codCliente, codCuenta);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoBeneficiosDTO beneficiosXClienteAbonado(Long codCliente, Long numAbonado) throws PortalSACException
	{
		ListadoBeneficiosDTO r = new ListadoBeneficiosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.beneficiosXClienteAbonado(codCliente, numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoCambiosPlanTarifDTO cambiosPlanCliente(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.cambiosPlanCliente(numOS);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPospago(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.cambiosPlanAbonadoPospago(numOS);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPrepago(Long numOS) throws PortalSACException
	{
		ListadoCambiosPlanTarifDTO r = new ListadoCambiosPlanTarifDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.cambiosPlanAbonadoPrepago(numOS);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public MenuDTO cargaValidaOSUsuario(String usuario) throws PortalSACException
	{
		MenuDTO r = new MenuDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.cargaValidaOSUsuario(usuario);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoCuentasCorrientesDTO ccXCodCliente(Long codCliente) throws PortalSACException
	{

		ListadoCuentasCorrientesDTO r = new ListadoCuentasCorrientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.ccXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoClientesDTO clientesXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoClientesDTO r = new ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.clientesXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoClientesDTO clientesXCuenta(Long codCuenta) throws PortalSACException
	{
		ListadoClientesDTO r = new ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.clientesXCuenta(codCuenta);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoClientesDTO clientesXNombre(String nombre) throws PortalSACException
	{

		ListadoClientesDTO r = new ListadoClientesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.clientesXNombre(nombre);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 * 
	 */
	public ListadoConsultasDTO consultasXCodGrupo(String codGrupo, String codPrograma, String numVersion)
			throws PortalSACException
	{
		ListadoConsultasDTO r = new ListadoConsultasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.consultasXCodGrupo(codGrupo, codPrograma, numVersion);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoCuentasDTO cuentasXCodigo(Long codCuenta) throws PortalSACException
	{
		ListadoCuentasDTO r = new ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.cuentasXCodigo(codCuenta);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoCuentasDTO cuentasXNombre(String descCuenta) throws PortalSACException
	{

		ListadoCuentasDTO r = new ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.cuentasXNombre(descCuenta);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoCuentasDTO cuentasXNumIdent(String numIdent) throws PortalSACException
	{
		ListadoCuentasDTO r = new ListadoCuentasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.cuentasXNumIdent(numIdent);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public EquipoSimcardDetalleDTO detalleEquipoSimcardXNumAbonado(Long numAbonado) throws PortalSACException
	{
		EquipoSimcardDetalleDTO r = null;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.detalleEquipoSimcardXNumAbonado(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoDetalleLlamadosDTO detalleLlamadas(Long codCliente, Long numAbonado, Long codCiclo, String tipoLlamada)
			throws PortalSACException
	{

		ListadoDetalleLlamadosDTO r = new ListadoDetalleLlamadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.detalleLlamadas(codCliente, numAbonado, codCiclo, tipoLlamada);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public DetallePlanTarifarioDTO detallePlanTarifario(String codPlanTarifario) throws PortalSACException
	{
		DetallePlanTarifarioDTO r = new DetallePlanTarifarioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.detallePlanTarifario(codPlanTarifario);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoDireccionesDTO direccionesXCodCliente(Long codCliente) throws PortalSACException
	{

		ListadoDireccionesDTO r = new ListadoDireccionesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.direccionesXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException
	{

	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public void ejbCreate()
	{

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException
	{

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException
	{

	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 * 
	 */
	public Boolean esPrimerLogin(String nomUsuario) throws PortalSACException
	{
		Boolean r = Boolean.FALSE;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.esPrimerLogin(nomUsuario);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoFacturasDTO facturasXCodCliente(Long codCliente) throws PortalSACException
	{

		ListadoFacturasDTO r = new ListadoFacturasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.facturasXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public DetalleAbonadoDTO getDetalleAbonado(Long numAbonado) throws PortalSACException
	{

		DetalleAbonadoDTO r = new DetalleAbonadoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDetalleAbonado(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public DetalleClienteDTO getDetalleCliente(Long codCliente) throws PortalSACException
	{

		DetalleClienteDTO r = new DetalleClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDetalleCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public DetalleCuentaDTO getDetalleCuenta(Long codCuenta) throws PortalSACException
	{
		DetalleCuentaDTO r = null;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDetalleCuenta(codCuenta);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public DetalleDireccionDTO getDetalleDireccion(Long codDireccion, String codTipDireccion) throws PortalSACException
	{

		DetalleDireccionDTO r = new DetalleDireccionDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDetalleDireccion(codDireccion, codTipDireccion);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que obtiene los campos que seran desplegados como direccion
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoCamposDireccionDTO obtenerCamposDireccion() throws PortalSACException
	{

		ListadoCamposDireccionDTO r = new ListadoCamposDireccionDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerCamposDireccion();
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	/** 
	 * Metodo que obtiene los datos de la direccion de un cliente
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public DireccionPorClienteDTO obtenerDatosDireccionCliente(DatosDireccionClienteINDTO pIn) throws PortalSACException
	{

		DireccionPorClienteDTO r = new DireccionPorClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerDatosDireccionCliente(pIn);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public DeudaClienteDTO getDeudaCliente(Long codCliente) throws PortalSACException
	{
		DeudaClienteDTO r = new DeudaClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDeudaCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoDocCtaCteClienteDTO getDocsAjustesCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{

		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDocsAjustesCliente(codCliente, fecInicio, fecFin);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;

	} // getDocsAjustesCliente

	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoDocCtaCteClienteDTO getDocsCtaCteCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDocsCtaCteCliente(codCliente, fecInicio, fecFin);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoDocCtaCteClienteDTO getDocsFactCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDocsFactCliente(codCliente, fecInicio, fecFin);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;

	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoDocCtaCteClienteDTO getDocsPagosCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.getDocsPagosCliente(codCliente, fecInicio, fecFin);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 * 
	 */
	public ListadoGruposDTO gruposXNomUsuario(String nomUsuario) throws PortalSACException
	{
		ListadoGruposDTO r = new ListadoGruposDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.gruposXNomUsuario(nomUsuario);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	// ---------------------------------------------------------------------------------

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoLimiteConsumoDTO limiteConsumoXClienteAbonado(Long codCliente, Long numAbonado)
			throws PortalSACException
	{
		ListadoLimiteConsumoDTO r = new ListadoLimiteConsumoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.limiteConsumoXClienteAbonado(codCliente, numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoNumerosFrecuentesDTO numerosFrecuentesXPlan(Long numAbonado) throws PortalSACException
	{

		ListadoNumerosFrecuentesDTO r = new ListadoNumerosFrecuentesDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.numerosFrecuentesXPlan(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXCodCliente(Long codCliente) throws PortalSACException
	{

		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.oossEjecutadasXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXCodCuenta(Long codCuenta) throws PortalSACException
	{

		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.oossEjecutadasXCodCuenta(codCuenta);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXNumAbonado(Long numAbonado) throws PortalSACException
	{

		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.oossEjecutadasXNumAbonado(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoPagosLimiteConsumoDTO pagoLimiteConsumoXClienteAbonado(Long codCliente, Long numAbonado)
			throws PortalSACException
	{
		ListadoPagosLimiteConsumoDTO r = new ListadoPagosLimiteConsumoDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.pagoLimiteConsumoXClienteAbonado(codCliente, numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoPagosDTO pagosXCodCliente(Long codCliente) throws PortalSACException
	{

		ListadoPagosDTO r = new ListadoPagosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.pagosXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoProductosDTO planesXCodCliente(Long codCliente) throws PortalSACException
	{

		ListadoProductosDTO r = new ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.planesXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;

	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoProductosDTO planesXNumAbonado(Long numAbonado) throws PortalSACException
	{

		ListadoProductosDTO r = new ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.planesXNumAbonado(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	private PortalSACException procesarExcepcion(Exception e)
	{
		PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
				COD_ERROR, DES_ERROR, e);
		return pe;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoProductosDTO productosXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoProductosDTO r = new ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.productosXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;

	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoProductosDTO productosXNumAbonado(Long numAbonado) throws PortalSACException
	{

		ListadoProductosDTO r = new ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.productosXNumAbonado(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoServSuplementariosDTO servSumplemetariosXAbonado(Long numAbonado) throws PortalSACException
	{
		ListadoServSuplementariosDTO r = new ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.servSumplemetariosXAbonado(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException, RemoteException
	{

	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoProductosDTO ssXCodCliente(Long codCliente) throws PortalSACException
	{

		ListadoProductosDTO r = new ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.ssXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;

	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoServSuplementariosDTO ssXDefectoXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoServSuplementariosDTO r = new ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.ssXDefectoXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoServSuplementariosDTO ssXDefectoXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ListadoServSuplementariosDTO r = new ListadoServSuplementariosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.ssXDefectoXNumAbonado(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoProductosDTO ssXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ListadoProductosDTO r = new ListadoProductosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.ssXNumAbonado(numAbonado);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;

	}

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoUmtsAbonadosDTO umtsAbonadosXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoUmtsAbonadosDTO r = new ListadoUmtsAbonadosDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.umtsAbonadosXCodCliente(codCliente);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoOrdenesAgendadasDTO obtenerOoSsAgendadas(Long numDato, Integer tipoDato) throws PortalSACException
	{

		ListadoOrdenesAgendadasDTO r = new ListadoOrdenesAgendadasDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerOoSsAgendadas(numDato, tipoDato);
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public Boolean consultaOoSsProceso(String nomUsuario) throws PortalSACException{

		Boolean r = false;
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.consultaOoSsProceso(nomUsuario);
		}catch (Exception e){
			
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoOrdenesProcesoDTO obtenerOoSsProceso(String nomUsuario) throws PortalSACException{
		
	ListadoOrdenesProcesoDTO r = new ListadoOrdenesProcesoDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerOoSsProceso(nomUsuario);
		}catch (Exception e){
			
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public AbonadoDTO obtenerDatosAbonado(Long numAbonado) throws PortalSACException{

		AbonadoDTO r = new AbonadoDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerDatosAbonado(numAbonado);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListaAtencionClienteDTO consultaAtencion() throws PortalSACException{

		ListaAtencionClienteDTO r = new ListaAtencionClienteDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.consultaAtencion();
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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

	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ResulTransaccionDTO ingresoAtencion(ResgistroAtencionDTO resgistroAtencionDTO) throws PortalSACException{

		ResulTransaccionDTO r = new ResulTransaccionDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.ingresoAtencion(resgistroAtencionDTO);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoAbonadosDTO obtenerListDatosAbonados(Long codCliente) throws PortalSACException{

		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerListDatosAbonados(codCliente);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	/** 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * 
	 */
	public ListadoAbonadosDTO consultaCuenta(Long codCuenta) throws PortalSACException{

		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.consultaCuenta(codCuenta);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-029 Ver OOSS Act/Des ejecutadas por Abonados/Clientes
	 * Developer: Jorge González
	 * Fecha: 02/08/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: servSuplXOOSS
	 * Descripcion: Obtiene los SS por el numero de OOSS seleccionado
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoServSuplxOOSSDTO servSuplXOOSS(Long numOOSS) throws PortalSACException{

		ListadoServSuplxOOSSDTO r = new ListadoServSuplxOOSSDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.servSuplXOOSS(numOOSS);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-004 Agregar Comentario de OOSS Aviso de Siniestro
	 * Requisito: RSis_003 
	 * Caso de uso: CU-005 Agregar Comentario de OOSS Reversión de Cargos
	 * Requisito: RSis_003 
	 * Caso de uso: CU-006 Agregar Comentario de OOSS Ajuste por Excepción
	 * Developer: Gabriel Moraga L.
	 * Fecha: 04/08/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: AbonadoDTO
	 * Descripcion: Inserta un comentario
	 * throws: PortalSACException
	 * 
	 */
	
	public ResulTransaccionDTO insertComentario(String comentario, Long numOoss ) throws PortalSACException{

		ResulTransaccionDTO r = new ResulTransaccionDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.insertComentario(comentario, numOoss);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	public MuestraURLDTO solicitaUrlDominioPuerto(String strCodOrdenServ) throws PortalSACException{
		MuestraURLDTO r = new MuestraURLDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.solicitaUrlDominioPuerto(strCodOrdenServ);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	 * Descripcion: Inserta un comentario en la tabla PV_IORSERV
	 * throws: PortalSACException
	 * 
	 */
	
	public ResulTransaccionDTO insertComentarioPvIorserv(String comentario, Long numOoss ) throws PortalSACException{

		ResulTransaccionDTO r = new ResulTransaccionDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.insertComentarioPvIorserv(comentario, numOoss);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	public ListadoReporteCamEquiGenDTO obtenerReporteCambioEquiGene(String fechaDesde, String fechaHasta, String codCausalCam) throws PortalSACException{

		ListadoReporteCamEquiGenDTO r = new ListadoReporteCamEquiGenDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerReporteCambioEquiGene(fechaDesde, fechaHasta, codCausalCam);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	public ListadoReporteIngrStatusEquiDTO obtenerReporteIngrStatusEqui(String fechaDesde, String fechaHasta) throws PortalSACException{

		ListadoReporteIngrStatusEquiDTO r = new ListadoReporteIngrStatusEquiDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerReporteIngrStatusEqui(fechaDesde, fechaHasta);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	public ListadoReportePresEquiIntDTO obtenerReportePresEquiInt(String fechaDesde, String fechaHasta) throws PortalSACException{

		ListadoReportePresEquiIntDTO r = new ListadoReportePresEquiIntDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerReportePresEquiInt(fechaDesde, fechaHasta);
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
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
	
	public ListaCausalCambioDTO obtenerCausalCambio() throws PortalSACException{

		ListaCausalCambioDTO r = new ListaCausalCambioDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerCausalCambio();
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
	/*
	 * Obtiene el flag y dominio para kiosco
	 * throws: PortalSACException
	 * 
	 */	
	public ParametrosKioscoDTO obtenerParametroKiosco() throws PortalSACException{

		ParametrosKioscoDTO r = null;
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			r = wsPortalSrv.obtenerParametroKiosco();
		}
		catch (Exception e){
			PortalSACException pe = procesarExcepcion(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
	
}
