/**
 * 
 */
package com.tmmas.cl.scl.gestiondecliente.negocio.ejb.session;

import java.rmi.RemoteException;
import java.util.ArrayList;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionInDTO;
import com.tmmas.cl.scl.commonapp.dto.WsBeneficioPromocionOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsCunetaAltaDeLineaOutDTO;
import com.tmmas.cl.scl.commonapp.dto.WsRegistraCampanaByPInDTO;
import com.tmmas.cl.scl.gestionDeVendedores.srv.GestionDeVendedoresSRV;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoActivoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.AbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ArticuloDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CantidadStockSerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CargosSimcarPrepagoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.GaEquipAboserDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ImeiWSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.OutAbonadoPortadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReglaCompatibilidadSSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ReservaOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SSuplementariosDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ServicioSuplementarioDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ValidacionServicioSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WSSolicitudBajaAbonadoOutDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsAgregaEliminaSSInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.WsParamDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.service.servicios.GestionDeAbonadosSrv;
import com.tmmas.cl.scl.gestiondeclientes.service.servicios.GestionDeClientesSrv;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.AnulacionVentaRetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ArticuloResDesInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.BodegaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CausalDescuentoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CeldaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionCuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ContratoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaComDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CuentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DatosGeneralesVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DireccionCentralDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DocumentoFacturacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.FaMensProcesoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GaVentasDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.GeModVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.HomeLineaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.OficinaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.PagosUltimosMesesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosAnulacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroFacturacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RegistroVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SumaPrecioPlanesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SucursalBancoDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.UsuarioDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ValorClasificacionDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WSValidarTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloImeiOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloResDesOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsArticuloVendedorOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsBancoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCuentaIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListConsultaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsMotivosDeDescuentoManualInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsCicloFactInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsClienteIdentInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsContratoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInfoComercialClienteDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsInformacionLineaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsLinkDocumentoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListBancoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCicloFactOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListClienteIdentOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListCuotaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListModalidadPagoOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListadoCausalesVentasOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTarjetaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoComisionistaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsListTipoPlanTarifarioOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsNumeroSerieOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsOficinaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsPlanTarifarioInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsValTarjetaInDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.WsVendedorStockInDTO;
import com.tmmas.cl.scl.gestiondefacturacion.service.servicios.GestionDeFacturacionSrv;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoAsincDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.EstadoCivilDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.OcupacionDTO;
import com.tmmas.cl.scl.parametrosgenerales.businessobject.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.WsRespuestaImasDDTO;
import com.tmmas.cl.scl.spnsclwscommon.quiosco.dto.WsStructuraAccesorioDTO;
import com.tmmas.scl.serviciospostventasiga.service.servicios.MigracionPrepagoAPostpagoSrv;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionDTO;
import com.tmmas.scl.serviciospostventasiga.transport.MigracionPrepagoPostpagoDTO;
import com.tmmas.scl.serviciospostventasiga.transport.ResultadoValidacionDatosMigracionDTO;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="GestionDeCliente"	
 *           description="An EJB named GestionDeCliente"
 *           display-name="GestionDeCliente"
 *           jndi-name="GestionDeCliente"
 *           type="Stateless" 
 *           transaction-type="Container"
 *            
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class GestionDeClienteBean implements javax.ejb.SessionBean {

	private static final long serialVersionUID = 1L;

	private GestionDeClientesSrv srv = new GestionDeClientesSrv();
	private GestionDeVendedoresSRV vendedoresSRV =new GestionDeVendedoresSRV();
	private GestionDeFacturacionSrv facturacionSRV =new GestionDeFacturacionSrv();
	private GestionDeAbonadosSrv abonadoSRV =new GestionDeAbonadosSrv();
	private MigracionPrepagoAPostpagoSrv migracionUsuario = new MigracionPrepagoAPostpagoSrv();


	private SessionContext context = null;

	private CompositeConfiguration config;
	
	private final Logger logger = Logger
	.getLogger(GestionDeClienteBean.class);

	/**
	 * 
	 */
	public GestionDeClienteBean() {
		System.out.println("GestionDeClienteBean(): Start");
		config = UtilProperty.getConfiguration("GestionDeClientesEJB.properties","com/tmmas/cl/scl/gestiondecliente/negocio/ejb/properties/GestionDeClienteBean.properties");
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));	
		logger.debug("GestionDeClienteBean():End");
	}		

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public String pruebaGestionDeCliente()
	{		
		return "OK";
	}	

	


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public String foo(String param) {
		return null;
	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/* (non-Javadoc)
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
	RemoteException {
		// TODO Auto-generated method stub
		this.context=arg0;

	}

	/********************************************************************/
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO getVendedor(VendedorDTO vendedorDTO) throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getVendedor:start");
			vendedorDTO=vendedoresSRV.getVendedor(vendedorDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getVendedor:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return vendedorDTO;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO[] getTipoComisionista()throws GeneralException{
		VendedorDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GestionDeClienteBean: getTipoComisionista:start");
			retValue=vendedoresSRV.getTipoComisionista();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getTipoComisionista:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OficinaDTO[] getOficina()throws GeneralException{
		OficinaDTO[] retValue =null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GestionDeClienteBean: getOficina:start");
			retValue=vendedoresSRV.getOficina();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GestionDeClienteBean: getOficina:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO[] getVendedoresPorOficina(VendedorDTO vendedorDTO) throws GeneralException{
		VendedorDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			retValue=vendedoresSRV.getVendedoresPorOficina(vendedorDTO);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsArticuloVendedorOutDTO[] getArticulosPorVendedor(WsVendedorStockInDTO vendedorStockDTO) throws GeneralException{
		WsArticuloVendedorOutDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			retValue=vendedoresSRV.getArticulosPorVendedor(vendedorStockDTO);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsArticuloImeiOutDTO getArticuloPorImei(WsArticuloImeiInDTO inWSLstNumSerieDTO) throws GeneralException{
		WsArticuloImeiOutDTO retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			retValue=vendedoresSRV.getArticuloPorImei(inWSLstNumSerieDTO);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OficinaDTO[] getOficinasPorVendedor(VendedorDTO vendedorDTO)throws GeneralException{
		OficinaDTO[]retValue=null; 
		//RSIS-011
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			retValue=vendedoresSRV.getOficinasPorVendedor(vendedorDTO);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO[] getListadoVendedoresXOficinaEIndicador(VendedorDTO vendedorDTO) throws GeneralException{
		VendedorDTO[]retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			retValue=vendedoresSRV.getListadoVendedoresXOficinaEIndicador(vendedorDTO);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO[] getListadoVendedoresXTipo(VendedorDTO vendedorDTO) throws GeneralException{
		VendedorDTO[] retValue = null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			retValue=vendedoresSRV.getListadoVendedoresXTipo(vendedorDTO);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListadoCausalesVentasOutDTO getListadoMotivosDescuentosManuales(String CodigoUso) throws GeneralException{
		WsListadoCausalesVentasOutDTO retValue=null; 
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			retValue=vendedoresSRV.getListadoMotivosDescuentosManuales(CodigoUso);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaDTO[] getSubCuentaPorCodCliente(ClienteDTO clienteDTO) throws GeneralException{
		CuentaDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getSubCuentaPorCodCliente:start");
			retValue=srv.getSubCuentaPorCodCliente(clienteDTO);
			logger.debug("GestionDeClienteBean: getSubCuentaPorCodCliente:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsContratoOutDTO[] getListVigenciasContratos() throws GeneralException{
		WsContratoOutDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListVigenciasContratos:start");
			retValue=srv.getListVigenciasContratos();

			logger.debug("GestionDeClienteBean: getListVigenciasContratos:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GeModVentaDTO[] getListModalidadVenta() throws GeneralException{
		GeModVentaDTO[] retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListModalidadVenta:start");
			retValue=srv.getListModalidadVenta();

			logger.debug("GestionDeClienteBean: getListModalidadVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListTarjetaOutDTO getListadoTarjetas() throws GeneralException{
		WsListTarjetaOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoTarjetas:start");
			retValue=srv.getListadoTarjetas();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoTarjetas:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListModalidadPagoOutDTO getListadoModalidadPago() throws GeneralException{
		WsListModalidadPagoOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoModalidadPago:start");
			retValue=srv.getListadoModalidadPago();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoModalidadPago:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListBancoOutDTO getListadoBancosPAC(WsBancoInDTO wsBancoInDTO) throws GeneralException{
		WsListBancoOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoBancosPAC:start");
			logger.debug("wsBancoInDTO.getIndPAC ["+wsBancoInDTO.getIndPAC()+"]");
			retValue=srv.getListadoBancosPAC(wsBancoInDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoBancosPAC:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListCuotaOutDTO getListadoCuotas() throws GeneralException{
		WsListCuotaOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoCuotas:start");
			retValue=srv.getListadoCuotas();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoCuotas:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListCicloFactOutDTO getListadoCiclosPostPago(WsCicloFactInDTO cicloFactDTO) throws GeneralException{
		WsListCicloFactOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoCiclosPostPago:start");
			retValue=facturacionSRV.getListadoCiclosPostPago(cicloFactDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoCiclosPostPago:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListPlanTarifarioOutDTO getListadoPlanesTarifarios(WsPlanTarifarioInDTO inWSLstPlanTarifDTO)throws GeneralException{
		WsListPlanTarifarioOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoPlanesTarifarios:start");
			retValue=srv.getListadoPlanesTarifarios(inWSLstPlanTarifDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoPlanesTarifarios:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListTipoPlanTarifarioOutDTO getListadoTiposPlanesTarifarios()throws GeneralException{
		WsListTipoPlanTarifarioOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoTiposPlanesTarifarios:start");
			retValue=srv.getListadoTiposPlanesTarifarios();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoTiposPlanesTarifarios:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListClienteIdentOutDTO getListadoClientesXIdentificacion(WsClienteIdentInDTO cliente)throws GeneralException{
		WsListClienteIdentOutDTO retValue=null;
		try{
			logger.debug("GestionDeClienteBean: getListadoClientesXIdentificacion:start");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			retValue=srv.getListadoClientesXIdentificacion(cliente);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoClientesXIdentificacion:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListTipoComisionistaOutDTO getListadoComisionistasXOficina(WsOficinaInDTO wsOficinaInDTO) throws GeneralException{
		WsListTipoComisionistaOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoComisionistasXOficina:start");
			retValue=vendedoresSRV.getListadoComisionistasXOficina(wsOficinaInDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoComisionistasXOficina:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsArticuloResDesOutDTO reservaDesreserva(ArticuloResDesInDTO articuloDTO) throws GeneralException{
		WsArticuloResDesOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: reservaDesreserva:start");
			retValue=vendedoresSRV.reservaDesreserva(articuloDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: reservaDesreserva:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoActivoDTO[] getAbonadosActivosCliente(Long codCliente) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		//RSIS -015
		AbonadoActivoDTO[] retValue=null;
		try{			
			logger.debug("SpnSclWSBean: listAbonadosActivosCliente:start");
			retValue= srv.getAbonadosActivosCliente(codCliente);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("SpnSclWSBean: listAbonadosActivosCliente:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OutAbonadoPortadoDTO setDesMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		OutAbonadoPortadoDTO retValue=null;
		try{
			logger.debug("Inicio:setDesMarcaAbonadoPortado()");
			retValue=abonadoSRV.setDesMarcaAbonadoPortado(abonadoPortadoDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:setDesMarcaAbonadoPortado()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OutAbonadoPortadoDTO setMarcaAbonadoPortado(AbonadoPortadoDTO abonadoPortadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		OutAbonadoPortadoDTO retValue=null;
		try{
			logger.debug("Inicio:setMarcaAbonadoPortado()");
			retValue=abonadoSRV.setMarcaAbonadoPortado(abonadoPortadoDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:setMarcaAbonadoPortado()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  RetornoDTO getInformacionPrecio(ArticuloDTO articuloDTO, WsParamDescuentoDTO calculoDescuentos) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		RetornoDTO retValue= new RetornoDTO();
		ParametrosDescuentoDTO entrada = new ParametrosDescuentoDTO();
		DocumentoFacturacionDTO datos = new DocumentoFacturacionDTO();
		RegistroFacturacionDTO registro = new RegistroFacturacionDTO();
		ClienteDTO cliente = new ClienteDTO();
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		ContratoDTO  contrato = new ContratoDTO();
		ArticuloDTO articulo = new ArticuloDTO();
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();

		try{

			if (calculoDescuentos.getCodigoCliente() == null  || calculoDescuentos.getCodigoCliente().equals("0")) {
				datos.setPromedioFacturado(0);
			}else{

				cliente.setCodigoCliente(calculoDescuentos.getCodigoCliente());
				cliente = srv.getclientes(cliente);

				datos.setCodigoCliente(cliente.getCodigoCliente());
				datos.setIndiceCiclo(String.valueOf(cliente.getCodigoCiclo()));
				datos.setNumeroMeses(Integer.parseInt(config.getString("numero.meses.faturable")));

				datos = facturacionSRV.getPromedioDocumentosFacturados(datos);			
			}

			registro.setValorPromedio(datos.getPromedioFacturado());
			registro = facturacionSRV.getCodigoPromedioFacturado(registro);


			planTarifario.setCodigoPlanTarifario(calculoDescuentos.getCodPlanTarifario());
			planTarifario.setCodigoProducto("1");
			planTarifario.setCodigoTecnologia("GSM");

			planTarifario = srv.getPlanTarifario(planTarifario);

			entrada.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());

			planTarifario= srv.getCategoriaPlanTarifario(planTarifario);

			contrato.setCodigoTipoContrato(calculoDescuentos.getCodigoContratoNuevo());				
			contrato = srv.getTipcontrato(contrato);

			entrada.setCodigoCliente(calculoDescuentos.getCodigoCliente());
			entrada.setCodigoContratoNuevo(calculoDescuentos.getCodigoContratoNuevo());
			entrada.setNumeroMesesContrato(contrato.getNumeroMeses());

			articulo.setCodigo(articuloDTO.getCodigo() );
			articulo = this.getArticulo(articulo);



			parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.GA"));
			parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.clasedescuento"));
			parametrosGeneralesDTO = srv.getParametroGeneral(parametrosGeneralesDTO);

			logger.debug("articuloDTO.getCodigoUso() ["+articuloDTO.getCodigoUso()+"]");	
			if(articuloDTO.getCodigoUso() == 3){
				entrada.setCodigoOperacion("VP");
			}else{
				entrada.setCodigoOperacion("VE");
			}
			entrada.setTipoContrato(contrato.getCodigoTipoContrato());                  
			entrada.setNumeroMesesContrato(contrato.getNumeroMeses());               
			entrada.setCodigoAntiguedad("01");   // para las ventas el aboando no tiene antiguedad             
			entrada.setCodigoPromedioFacturable(String.valueOf(registro.getCodigoPromedio()));
			entrada.setEquipoEstado("B");

			entrada.setNumeroMesesNuevo(String.valueOf(contrato.getNumeroMeses()));
			entrada.setCodigoArticulo(String.valueOf(articulo.getCodigo()));                
			entrada.setClaseDescuento(parametrosGeneralesDTO.getValorparametro());         


			if(articuloDTO.getTipoStock() == 2){
				entrada.setIndiceVentaExterna("0");
			}else{
				entrada.setIndiceVentaExterna("1");
			}



			entrada.setCodigoVendedor(calculoDescuentos.getCodigoVendedor());
			entrada.setCodigoCausaDescuento(calculoDescuentos.getCodigoCausaDescuento());
			entrada.setCodigoCategoria(planTarifario.getCodigoCategoria());
			entrada.setCodigoModalidadVenta(calculoDescuentos.getCodigoModalidadVenta());

			entrada.setConcepto(String.valueOf( articulo.getCodigoConceptoArticulo()));
			entrada.setClaseDescuentoArticulo(config.getString("parametro.clasedescuento.articulo"));



			logger.debug("Inicio:getInformacionPrecio()");


			retValue=facturacionSRV.getInformacionPrecio(articuloDTO, entrada);
			logger.debug("Fin:getInformacionPrecio()");






		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("e.getCodigo() ["+e.getCodigo()+"]");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsNumeroSerieOutDTO getInformacionBodegaArticuloSerie(WsNumeroSerieInDTO wsNumeroSerieInDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		WsNumeroSerieOutDTO retValue=null;
		try{
			logger.debug("Inicio:getInformacionBodegaArticuloSerie()");
			retValue=abonadoSRV.getInformacionBodegaArticuloSerie(wsNumeroSerieInDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getInformacionBodegaArticuloSerie()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}
	


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		PlanTarifarioDTO resultado = null;
		logger.debug("Inicio:getPlanTarifario()");
		try{
			resultado = srv.getPlanTarifario(entrada);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getPlanTarifario()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return resultado;
	}



	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public WsLinkDocumentoOutDTO getLinkFactura(WsLinkDocumentoInDTO wsLinkDocumentoInDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		//RSIS 032
		WsLinkDocumentoOutDTO retValue=null;
		try{
			logger.debug("SpnSclWSBean: getLinkFactura:start");
			retValue= srv.getLinkFactura(wsLinkDocumentoInDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("SpnSclWSBean: getLinkFactura:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PagosUltimosMesesDTO[] getRecPagosClie(ClienteDTO clienteDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		PagosUltimosMesesDTO[] retValue=null;
		try{
			logger.debug("getRecPagosClie:start");
			retValue= srv.getRecPagosClie(clienteDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("getRecPagosClie:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsInfoComercialClienteDTO[] getDatosCredCliente(ClienteDTO clienteDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		//RSIS - 036
		WsInfoComercialClienteDTO[] retValue=null;
		try{
			logger.debug("getDatosCredCliente:start");
			retValue= srv.getDatosCredCliente(clienteDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("getDatosCredCliente:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsInformacionLineaOutDTO getInformacionLinea(WsInformacionLineaInDTO wsInformacionLineaInDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		WsInformacionLineaOutDTO retValue=new WsInformacionLineaOutDTO();
		try{
			logger.debug("getInformacionLinea:start");
			retValue=abonadoSRV.getInformacionLinea(wsInformacionLineaInDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("getInformacionLinea:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SimcardSNPNDTO getSimcard(SimcardSNPNDTO entrada)
	throws GeneralException{
		SimcardSNPNDTO resultado=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:getSimcard()");
			resultado = srv.getSimcard(entrada); 
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getSimcard()");
		return resultado;
	}//fin getSimcard		

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public DatosGeneralesVentaDTO[] creacionLineas(DatosGeneralesVentaDTO[] datosGeneralesVenta)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		DatosGeneralesVentaDTO[] resultados=null;
		DatosGeneralesVentaDTO   resultado=null;
		ArrayList lineas = new ArrayList();
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:creacionLineas()");
			for (int i=0; i<datosGeneralesVenta.length;i++){
				resultado = abonadoSRV.creacionLineas(datosGeneralesVenta[i]); 
				UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
				lineas.add(resultado);
			}

			resultados = ((DatosGeneralesVentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lineas.toArray(), DatosGeneralesVentaDTO.class));

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			
			logger.debug("GeneralException GestionDeClienteBean");			
			logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
			logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:creacionLineas()");
		return resultados;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public long getSecuenciaVenta()throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		long resultado;
		logger.debug("Inicio:getSecuenciaVenta()");
		try{
			resultado = srv.getSecuenciaVenta();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getSecuenciaVenta()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:creacionLineas()");
		return resultado;
	}



	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public AbonadoDTO getAbonadoPorNumCelular(AbonadoDTO abonadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		AbonadoDTO retValue=null;
		try{
			logger.debug("Inicio: getAbonadoPorNumCelular:start");
			retValue=abonadoSRV.getAbonadoPorNumCelular(abonadoDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: getAbonadoPorNumCelular:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getAbonadoPorNumCelular()");
		return retValue;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ContratoDTO getListadoNumeroMesesContrato(ContratoDTO contrato) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getListadoNumeroMesesContrato():start");
			contrato = srv.getListadoNumeroMesesContrato(contrato);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("getListadoNumeroMesesContrato():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return contrato;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	

	public ClienteDTO getPlanComercial(ClienteDTO clienteDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getPlanComercial():start");
			clienteDTO = srv.getPlanComercial(clienteDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("getPlanComercial():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return clienteDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	

	public ClienteDTO getCategoriaTributariaCliente(ClienteDTO clienteDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getCategoriaTributariaCliente():start");
			clienteDTO = srv.getCategoriaTributariaCliente(clienteDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("getCategoriaTributariaCliente():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return clienteDTO;
	}
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public ArticuloDTO setReservaSerie(ArticuloDTO articuloDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("Inicio: setReservaSerie:start");
			abonadoSRV.setReservaSerie(articuloDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: setReservaSerie:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return articuloDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TerminalSNPNDTO getTerminal(TerminalSNPNDTO terminalDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("Inicio: getTerminal:start");
			terminalDTO=abonadoSRV.getTerminal(terminalDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: getTerminal:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return terminalDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SimcardSNPNDTO getTerminal(SimcardSNPNDTO simcardSNPNDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("Inicio: getTerminal:start");
			simcardSNPNDTO=abonadoSRV.getSimcard(simcardSNPNDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: getTerminal:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return simcardSNPNDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public RegistroVentaDTO getSecuencia(RegistroVentaDTO registroVentaDTO) throws GeneralException {
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getSecuenciaTransacabo():start");
			registroVentaDTO = srv.getSecuencia(registroVentaDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("getSecuenciaTransacabo():end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return registroVentaDTO;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public ArticuloDTO setActualizaStock(ArticuloDTO articuloDTO)throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio: setActualizaStock:start");			
			articuloDTO  = abonadoSRV.reservaSerie(articuloDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: setActualizaStock:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return articuloDTO;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public ArticuloDTO ActualizaStock(ArticuloDTO articuloDTO)throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio: ActualizaStock:start");
			articuloDTO  = abonadoSRV.ActualizaStock(articuloDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: ActualizaStock:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("ActualizaStock - GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return articuloDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO setUpdateAbonadoNumImei(AbonadoDTO abonadoDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		RetornoDTO retValue=null;
		try{
			logger.debug("Inicio: setUpdateAbonadoNumImei:start");
			retValue=abonadoSRV.setUpdateAbonadoNumImei(abonadoDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: setUpdateAbonadoNumImei:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO creaVenta(GaVentasDTO gaVentasDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		RetornoDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio: creaVenta:start");
			vendedoresSRV.insertVenta(gaVentasDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: creaVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}	


	/** 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AnulacionVentaRetornoDTO setAnulacionVenta(AnulacionVentaRetornoDTO anulacionVentaDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		logger.debug("setAnulacionVenta - START");
		logger.debug("antes - WsRespuestaImasDDTO");
		WsRespuestaImasDDTO WsRespuestaImasD = new WsRespuestaImasDDTO();
		logger.debug("antes - WsRespuestaImasDDTO");
		RetornoDTO retValue=new RetornoDTO();
		ArrayList listaerrores = new ArrayList();

		String sNombreMethodo=this.getClass().getName();
		ArrayList listaErrores = new ArrayList();
		try{
			logger.debug(sNombreMethodo+"setAnulacionVenta");
			//TODO se obtiene estado del abonado el cual debe corresponder a AIP
			AbonadoDTO abonadoDTO=new AbonadoDTO();
			abonadoDTO.setNumCelular(anulacionVentaDTO.getNumCelular());
			abonadoDTO=abonadoSRV.getAbonadoPorNumCelular(abonadoDTO);
			String codSituacion=abonadoDTO.getCodSituacion();


			if (!config.getString("codigo.situacion.AIP").equals(codSituacion)){
				WsRespuestaImasD = new WsRespuestaImasDDTO();
				logger.debug("Error - 12312 - "+config.getString("codigo.error.2600"));
				WsRespuestaImasD.setCodigoError("12312");				
				WsRespuestaImasD.setDescripcionErro(config.getString("codigo.error.2600"));
				listaerrores.add(WsRespuestaImasD);
			}

			UsuarioDTO usuarioDTO=new UsuarioDTO();
			usuarioDTO.setNombre(anulacionVentaDTO.getUsuario());
			retValue=srv.getConsultaUsuario(usuarioDTO);

			if (!"1".equals(retValue.getCodError())){												
				WsRespuestaImasD = new WsRespuestaImasDDTO();
				logger.debug("Error - 12313 - "+config.getString("codigo.error.2610"));
				WsRespuestaImasD.setCodigoError("12313");				
				WsRespuestaImasD.setDescripcionErro(config.getString("codigo.error.2610"));
				listaerrores.add(WsRespuestaImasD);
			}
//			TODO Sistema verifica que el código de causa de baja informado existe en SCL.
			String codCausaBaja=anulacionVentaDTO.getCodCausaBaja();//--> falta validacion

			if (!srv.isExisteCodCausaBaja(codCausaBaja)){
				WsRespuestaImasD = new WsRespuestaImasDDTO();
				logger.debug("Error - 12314 - "+config.getString("codigo.error.2620"));
				WsRespuestaImasD.setCodigoError("12314");				
				WsRespuestaImasD.setDescripcionErro(config.getString("codigo.error.2620"));
				listaerrores.add(WsRespuestaImasD);

			}


			if (listaerrores.toArray().length  > 0){
				anulacionVentaDTO.setListaerrores(listaerrores);
			}else{
				ParametrosAnulacionVentaDTO parametrosAnulacionVentaDTO = new ParametrosAnulacionVentaDTO();
				parametrosAnulacionVentaDTO.setCodCliente(abonadoDTO.getCodCliente());
				parametrosAnulacionVentaDTO.setNumAbonado(abonadoDTO.getNumAbonado());

				String tipAbonado=abonadoDTO.getCodUso().equals("3")?"PR":"PO";

				parametrosAnulacionVentaDTO.setTipAbonado(tipAbonado);
				parametrosAnulacionVentaDTO.setClaseServ(abonadoDTO.getClaseServicio());
				parametrosAnulacionVentaDTO.setCodCausaBaja(anulacionVentaDTO.getCodCausaBaja());
				parametrosAnulacionVentaDTO.setCodActabo("AN");
				parametrosAnulacionVentaDTO.setUsuario(anulacionVentaDTO.getUsuario());
				parametrosAnulacionVentaDTO.setMnd(abonadoDTO.getNumCelular());
				parametrosAnulacionVentaDTO.setUso(Long.parseLong(abonadoDTO.getCodUso()));

				retValue=srv.setAnulacionVenta(parametrosAnulacionVentaDTO);
			}





			logger.debug(sNombreMethodo+"setAnulacionVenta");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return anulacionVentaDTO;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void grabaEstadoAsinc(EstadoAsincDTO EstadoAsinc)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("Inicio: grabaEstadoAsinc:start");
			srv.grabaEstadoAsinc(EstadoAsinc);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: grabaEstadoAsinc:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
	}



	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void grabaEstadoAsincSinSPNID(EstadoAsincDTO EstadoAsinc)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("Inicio: grabaEstadoAsincSinSPNID:start");
			srv.grabaEstadoAsincSinSPNID(EstadoAsinc);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin: grabaEstadoAsinc:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
	}	


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void provisionandoLinea(GaVentasDTO parametros)
	throws GeneralException
	{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		logger.debug("Inicio:provisionandoLinea");
		try {
			srv.provisionandoLinea(parametros);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:provisionandoLinea");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:provisionandoLinea");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:provisionandoLinea");

	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoDTO[] getListaAbonadosVenta(RegistroVentaDTO entrada)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		AbonadoDTO[] resultado= null;
		logger.debug("Inicio:getListaAbonadosVenta");
		try {
			resultado = srv.getListaAbonadosVenta(entrada);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getListaAbonadosVenta");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getListaAbonadosVenta");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getListaAbonadosVenta");
		return resultado;
	}	


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GaVentasDTO procesosPreCierre(GaVentasDTO entrada)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		logger.debug("procesosPreCierre:start");
		GaVentasDTO resultado;
		try {
			resultado = srv.procesosPreCierre(entrada);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:procesosPreCierre");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:procesosPreCierre");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("procesosPreCierre:end");
		return resultado;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void cierreVenta(GaVentasDTO entrada)
	throws GeneralException{
		logger.debug("cierreVenta:start");
		GaVentasDTO resultado;
		try {
			srv.cierreVenta(entrada);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:cierreVenta");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:cierreVenta");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("cierreVenta:end");
	}



	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GaVentasDTO getVenta(GaVentasDTO gaVentasDTO)
	throws GeneralException{
		logger.debug("getVenta:start");
		try {
			gaVentasDTO = srv.getVenta(gaVentasDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getVenta");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getVenta");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getVenta:end");
		return gaVentasDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void updateVentas(GaVentasDTO gaVentasDTO)
	throws GeneralException{
		logger.debug("getVenta:start");
		try {
			srv.updateVentas(gaVentasDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getVenta");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getVenta");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getVenta:end");
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WSValidarTarjetaOutDTO  validarTarjeta(WsValTarjetaInDTO  valTarjeta)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		logger.debug("Inicio:validarTarjeta");
		WSValidarTarjetaOutDTO resultado = new WSValidarTarjetaOutDTO();
		try {
			resultado = srv.validarTarjeta(valTarjeta);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Fin:validarTarjeta");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Fin:validarTarjeta");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:validarTarjeta");
		return resultado;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void  updateEquipoAboser (AbonadoDTO  abonadoDTO)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		logger.debug("Inicio:validarTarjeta");
		try {
			abonadoSRV.actualizaEquipAboSer(abonadoDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Fin:validarTarjeta");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Fin:validarTarjeta");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:validarTarjeta");
		//return resultado;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void updateAboVendealer(String numAbonado) throws GeneralException{		
		try{
			logger.debug(" updateAboVendealer:start");
			abonadoSRV.updateAboVendealer(numAbonado);
			logger.debug(" updateAboVendealer:end");						
		}catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Fin:updateAboVendealer");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;		
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Fin:updateAboVendealer");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);		
		}
	}	
	

	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public ArticuloDTO getArticulo(ArticuloDTO articuloDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("Inicio: getArticulo:start");
			articuloDTO=abonadoSRV.getArticulo(articuloDTO);
			logger.debug("Fin: getArticulo:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getArticulo()");
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return articuloDTO;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public ContratoDTO obtenerContratoNuevo() throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		ContratoDTO Contrato=null;
		try{
			logger.debug("Inicio: getArticulo:start");
			Contrato=srv.obtenerContratoNuevo();
			logger.debug("Fin: getArticulo:end");
		}
		catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:obtenerContratoNuevo()");
		}catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return Contrato;
	}	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public void getUpdateGaVentaEscB(GaVentasDTO gaVentasDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getUpdateGaVentaEscB:start");
			srv.getUpdateGaVentaEscB(gaVentasDTO);			
			logger.debug("getVenta:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getUpdateGaVentaEscB:end");
	}

	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */

	public RetornoDTO setObservacionFactura(FaMensProcesoDTO faMensProcesoDTO)throws GeneralException{ 
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		RetornoDTO retValue;
		try{
			logger.debug("setObservacionFactura:start");
			retValue = srv.setObservacionFactura(faMensProcesoDTO);			
			logger.debug("setObservacionFactura:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("setObservacionFactura:end");
		return retValue;
	}
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */


	public ArticuloDTO[] getListArticuloPorCodigo(ArticuloDTO articuloDTO)throws GeneralException{
		ArticuloDTO[] retValue=null;

		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getListArticuloPorCodigo:start");
			retValue = abonadoSRV.getListArticuloPorCodigo(articuloDTO);			
			logger.debug("getListArticuloPorCodigo:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListArticuloPorCodigo:end");
		return retValue;
	}


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ArrayList validaIdentificador(CuentaComDTO cuentaCom, ArrayList listaerrores)throws GeneralException{    	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("validaIdentificador:start");
			listaerrores = srv.validaIdentificador(cuentaCom,listaerrores);			
			logger.debug("validaIdentificador:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListArticuloPorCodigo:end");	
		return listaerrores;
	}	






	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CentralDTO[] getListadoCentrales(CeldaDTO entrada) throws GeneralException{    	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		CentralDTO[] resultado = null;
		try{
			logger.debug("getListadoCentrales:start");
			resultado = srv.getListadoCentrales(entrada);			
			logger.debug("getListadoCentrales:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListadoCentrales:end");	
		return resultado;
	}		


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public WsMotivosDeDescuentoManualInDTO[] getListMotivosDeDescuentoManual(CausalDescuentoDTO causalDescuentoDTO) 
	throws GeneralException{   	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		WsMotivosDeDescuentoManualInDTO[] resultado = null;
		try{
			logger.debug("getListMotivosDeDescuentoManual:start");
			resultado = srv.getListMotivosDeDescuentoManual(causalDescuentoDTO);			
			logger.debug("getListMotivosDeDescuentoManual:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListMotivosDeDescuentoManual:end");	
		return resultado;
	}	









	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void insDocumentoMotivo(CausalDescuentoDTO entrada)
	throws GeneralException{  	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

		try{
			logger.debug("insDocumentoMotivo:start");
			srv.insDocumentoMotivo(entrada);			
			logger.debug("insDocumentoMotivo:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("insDocumentoMotivo:end");	
	}	


	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public String validaRangoTerminal(TerminalSNPNDTO TerminalSNPNDTO)  throws GeneralException{    	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		String resultado = null;
		try{
			logger.debug("validaRangoTerminal:start");
			resultado = srv.validaRangoTerminal(TerminalSNPNDTO);			
			logger.debug("validaRangoTerminal:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getListadoCentrales:end");	
		return resultado;
	}		


	

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public BodegaDTO[] getBodegasPorVendedor(String codigoVendedor) throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		BodegaDTO[] resultado = null;
		try{
			logger.debug("getBodegasPorVendedor:start");
			resultado = srv.getBodegasPorVendedor(codigoVendedor);			
			logger.debug("getBodegasPorVendedor:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getBodegasPorVendedor:end");	
		return resultado;
	}			



	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public SSuplementariosDTO[] getSSincluidosEnPlan(String codigoPlanTarifario) 
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		SSuplementariosDTO[] resultado = null;
		try{
			logger.debug("getSSincluidosEnPlan:start");
			logger.debug("INCIDENCIA 163741 GDO 11-02-2011");
			resultado = abonadoSRV.getSSincluidosEnPlan(codigoPlanTarifario);			
			logger.debug("INCIDENCIA 163741 GDO 11-02-2011");
			logger.debug("getSSincluidosEnPlan:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getSSincluidosEnPlan:end");	
		return resultado;
	}				 



	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public SSuplementariosDTO[] getSSOpcionalesAlPlan(String codigoPlanTarifario, String codigoArticulo, String codigCentral)
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		SSuplementariosDTO[] resultado = null;
		try{
			logger.debug("getSSOpcionalesAlPlan:start");
			resultado = abonadoSRV.getSSOpcionalesAlPlan(codigoPlanTarifario,codigoArticulo, codigCentral);			
			logger.debug("getSSOpcionalesAlPlan:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getSSOpcionalesAlPlan:end");	
		return resultado;
	}		 



	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ValidacionServicioSDTO getValidacionAgregaServicio(SSuplementariosDTO[] sSuplementariosCont, SSuplementariosDTO sSuplementariosVal)
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		ValidacionServicioSDTO resultado = null;
		try{
			logger.debug("getValidacionAgregaServicio:start");
			resultado = abonadoSRV.getValidacionAgregaServicio(sSuplementariosCont,sSuplementariosVal);			
			logger.debug("getValidacionAgregaServicio:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getValidacionAgregaServicio:end");	
		return resultado;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ValidacionServicioSDTO getValidacionEliminaServicio(SSuplementariosDTO[] sSuplementariosCont, SSuplementariosDTO sSuplementariosVal)
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		ValidacionServicioSDTO resultado = null;
		try{
			logger.debug("getValidacionEliminaServicio:start");
			resultado = abonadoSRV.getValidacionEliminaServicio(sSuplementariosCont,sSuplementariosVal);			
			logger.debug("getValidacionEliminaServicio:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getValidacionEliminaServicio:end");	
		return resultado;
	}	



	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void setAgregaSS(AbonadoDTO abonado, WsAgregaEliminaSSInDTO[] sSuplementarios) 
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("setAgregaSS:start");
			abonadoSRV.setAgregaSS(abonado,sSuplementarios);			
			logger.debug("setAgregaSS:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");		
			context.setRollbackOnly();
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("setAgregaSS:end");	
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void setEliminarSS(AbonadoDTO abonado, WsAgregaEliminaSSInDTO[] sSuplementarios)
	throws GeneralException{	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("setEliminarSS:start");
			abonadoSRV.setEliminarSS(abonado,sSuplementarios);			
			logger.debug("setEliminarSS:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("setEliminarSS:end");			
	}	 


	






		


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public SerieDTO reservaSerie(SerieDTO serie)
	throws GeneralException{

		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		SerieDTO retorno = null;
		try{
			logger.debug("reservaSerie:start");
			retorno = srv.reservaSerie(serie);			
			logger.debug("reservaSerie:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("reservaSerie:end");	
		return retorno;
	}	 				


	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public SerieDTO desReservaSerie(SerieDTO serie)
	throws GeneralException{

		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		SerieDTO retorno = null;
		try{
			logger.debug("desReservaSerie:start");
			retorno = srv.desReservaSerie(serie);			
			logger.debug("desReservaSerie:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			context.setRollbackOnly();
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			context.setRollbackOnly();
			throw new GeneralException(e);
		}
		logger.debug("desReservaSerie:end");	
		return retorno;
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ContratoDTO getTipcontrato(ContratoDTO contrato) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getTipcontrato:start");
			contrato = srv.getTipcontrato(contrato);		
			logger.debug("getTipcontrato:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getclientes:end");
		return contrato;

	}    	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public WsCuentaIdentOutDTO validaCuentaNumeroIdentificacion(WsCuentaIdentInDTO cuenta) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		WsCuentaIdentOutDTO Cuentaout = null;
		try{
			logger.debug("validaCuentaNumeroIdentificacion:start");
			Cuentaout = srv.validaCuentaNumeroIdentificacion(cuenta);		
			logger.debug("getTipcontrato:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("validaCuentaNumeroIdentificacion:end");
		return Cuentaout;

	}  
	
	//---------------------------- NUEVO ----------------------------------------------------
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaComDTO AltaCuentaSubCuenta(CuentaComDTO cuentaCom)
	throws GeneralException{	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		logger.debug("crearCliente():start");  				
		try{
	
			cuentaCom = srv.AltaCuentaSubCuenta(cuentaCom);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("crearCliente():end");
		return cuentaCom;

	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CuentaComDTO AltaCliente(CuentaComDTO cuentaCom) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("AltaCliente():start");  		
		try{
					
			cuentaCom = srv.AltaCliente(cuentaCom);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}

		logger.debug("crearCliente():end"); 
		return cuentaCom;
	}	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public CuentaComDTO getcliente(CuentaComDTO cuenta) 
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getclientes:start");
			cuenta = srv.getcliente(cuenta);	
			
			logger.debug("cuentaCom.getClienteComDTO().getCodigoPlanTarifario() ["+cuenta.getClienteComDTO().getPlanTarifario());
			logger.debug("getclientes:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getclientes:end");
		return cuenta;

	}	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CantidadStockSerieDTO getCantidadStockSerie(CantidadStockSerieDTO cantidadStockSerieDTO) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getCantidadStockSerie():start");  		
		try{
					
			cantidadStockSerieDTO=srv.getCantidadStockSerie(cantidadStockSerieDTO);
			logger.debug("cantidad stock: " + cantidadStockSerieDTO.getCantidadStock());
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getCantidadStockSerie():end"); 
		return cantidadStockSerieDTO;
		}
	
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ReglaCompatibilidadSSDTO[] getReglasCompatibilidadSS() 
	throws GeneralException{
		ReglaCompatibilidadSSDTO[] reglaCompatibilidadSSDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getReglasCompatibilidadSS():start");  		
		try{
					
			reglaCompatibilidadSSDTOs=abonadoSRV.getReglasCompatibilidadSS();
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getReglasCompatibilidadSS():end");
		return reglaCompatibilidadSSDTOs;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteDTO[] getListCategImpositivas() 
	throws GeneralException{
		ClienteDTO[] clienteDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getListCategImpositivas():start");  		
		try{
					
			clienteDTOs=srv.getListCategImpositivas();
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getListCategImpositivas():end");
		return clienteDTOs;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DatosGeneralesDTO[] getListActividades()  
	throws GeneralException{
		DatosGeneralesDTO[] datosGeneralesDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getListActividades():start");  		
		try{
			
			datosGeneralesDTOs=srv.getListActividades();
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getListActividades():end");
		return datosGeneralesDTOs;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OcupacionDTO[] getListaOcupaciones()  
	throws GeneralException{
		OcupacionDTO[] ocupacionDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getListaOcupaciones():start");  		
		try{
			
			ocupacionDTOs=srv.getListaOcupaciones();
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getListaOcupaciones():end");
		return ocupacionDTOs;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SucursalBancoDTO[] getSucursalesBanco(SucursalBancoDTO sucursalBancoDTO) 
	throws GeneralException{
		SucursalBancoDTO[] sucursalBancoDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getSucursalesBanco():start");  		
		try{
			
			sucursalBancoDTOs=srv.getSucursalesBanco(sucursalBancoDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getSucursalesBanco():end");
		return sucursalBancoDTOs;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClasificacionCuentaDTO[] getClasificacionCuenta() 
	throws GeneralException{
		ClasificacionCuentaDTO[]  clasificacionCuentaDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getClasificacionCuenta():start");  		
		try{
			
			clasificacionCuentaDTOs = srv.getClasificacionCuenta();
			logger.debug("codigo clase cuenta"+ clasificacionCuentaDTOs[1].getCodClasCuenta());
			logger.debug("descripcion clase cuenta"+ clasificacionCuentaDTOs[1].getDesClasCuenta());
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getClasificacionCuenta():end");
		return clasificacionCuentaDTOs;
	}

	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public HomeLineaDTO[] getHomeLinea(DireccionCentralDTO direccionCentralDTO)
	throws GeneralException{
		HomeLineaDTO[]  homeLineaDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getHomeLinea():start");  		
		try{
			
			homeLineaDTOs=srv.getHomeLinea(direccionCentralDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getHomeLinea():end");
		return homeLineaDTOs;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonado(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO)throws GeneralException{		
		logger.debug("solicitaBajaAbonado():start");
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{
			solicitaBajaAbonadoOut=abonadoSRV.solicitaBajaAbonado(solicitudBajaAbonadoDTO);
		} catch (GeneralException e) {		
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		return solicitaBajaAbonadoOut;
	}
		
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public EstadoCivilDTO[] getListaEstadoCivil() throws GeneralException{
		EstadoCivilDTO[] estadoCivilDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getListaEstadoCivil():start");  		
		try{
			
			estadoCivilDTOs = srv.getListaEstadoCivil();
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getListaEstadoCivil():end");
		return estadoCivilDTOs;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public EstadoDTO[] getListaEstados() throws GeneralException{
		EstadoDTO[] estadoDTOs = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getListaEstados():start");  		
		try{
			
			estadoDTOs = srv.getListaEstados();
			
			logger.debug("variable retorno estado: "+ estadoDTOs[1].getCodigoEstado());
			logger.debug("variable retorno descripcion estado: "+ estadoDTOs[1].getDescripcionEstado());
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getListaEstados():end");
		return estadoDTOs;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListConsultaPlanTarifarioOutDTO getConsultaPlanesTarifarios(WsConsultaPlanTarifarioInDTO consultaPlanTarifarioIn)throws GeneralException{
		WsListConsultaPlanTarifarioOutDTO retValue=null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoPlanesTarifarios:start");
			retValue=srv.getConsultaPlanesTarifarios(consultaPlanTarifarioIn);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoPlanesTarifarios:end");

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoPrepago(WSSolicitudBajaAbonadoDTO solicitudBajaAbonadoDTO)throws GeneralException{		
		logger.debug("solicitaBajaAbonado():start");  	
		WSSolicitudBajaAbonadoOutDTO solicitaBajaAbonadoOut = new WSSolicitudBajaAbonadoOutDTO();
		try{
			solicitaBajaAbonadoOut=abonadoSRV.solicitaBajaAbonadoPrepago(solicitudBajaAbonadoDTO);
		} catch (GeneralException e) {		
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		return solicitaBajaAbonadoOut;
	}	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ReservaOutDTO solicitaReserva(ReservaDTO solicitaReservaDTO)throws GeneralException{
		logger.debug("solicitaReserva():start");  	
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();
		try{
			solicitaReservaOutDTO = abonadoSRV.solicitaReserva(solicitaReservaDTO);
		} catch (GeneralException e) {		
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		return solicitaReservaOutDTO;
	}	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ReservaOutDTO solicitaDesreserva(ReservaDTO solicitaReservaDTO)throws GeneralException{
		logger.debug("solicitaReserva():start");  	
		ReservaOutDTO solicitaReservaOutDTO = new ReservaOutDTO();
		try{
			solicitaReservaOutDTO = abonadoSRV.solicitaDesreserva(solicitaReservaDTO);
		} catch (GeneralException e) {		
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		return solicitaReservaOutDTO;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void ActualizaSituacionAbonado(GaVentasDTO gaVentasDTO, String codigoSituacion)
	throws GeneralException{
		logger.debug("ActualizaSituacionAbonado:start");
		try {
			abonadoSRV.ActualizaSituacionAbonado(gaVentasDTO, codigoSituacion);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:ActualizaSituacionAbonado");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:ActualizaSituacionAbonado");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("ActualizaSituacionAbonado:end");
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void validaExisteSSAbondo(WsAgregaEliminaSSInDTO[] sSuplemenAgregar, WsAgregaEliminaSSInDTO[] sSuplemenEliminar, long numAbonado)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("validaExisteSSAbondo:start");
			abonadoSRV.validaExisteSSAbondo(sSuplemenAgregar, sSuplemenEliminar, numAbonado);		
			logger.debug("validaExisteSSAbondo:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("validaExisteSSAbondo:end");
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CentralDTO getCentralTecnologia(CentralDTO central) 
	throws GeneralException{   	    	
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		try{
			logger.debug("getCentralTecnologia:start");
			central = srv.getCentralTecnologia(central);			
			logger.debug("getCentralTecnologia:end");
		} catch (GeneralException e) {
			logger.debug("DescripcionEvento ["+e.getDescripcionEvento()+"]");
			logger.debug("DescripcionEvento ["+e.getCodigo()+"]");
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");			
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getCentralTecnologia:end");	
		return central;
	}
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public DatosGeneralesVentaDTO[] creacionLineasCDMA(DatosGeneralesVentaDTO[] datosGeneralesVenta)
	throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		DatosGeneralesVentaDTO[] resultados=null;
		DatosGeneralesVentaDTO   resultado=null;
		ArrayList lineas = new ArrayList();
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:creacionLineas()");
			for (int i=0; i<datosGeneralesVenta.length;i++){
				resultado = abonadoSRV.creacionLineasGrupoCDMA(datosGeneralesVenta[i]); 
				UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
				lineas.add(resultado);
			}

			resultados = ((DatosGeneralesVentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lineas.toArray(), DatosGeneralesVentaDTO.class));

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:creacionLineas()");
		return resultados;
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CuentaComDTO validacionLineaGrupoCDMA(CuentaComDTO cuentaComDTO) throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:validacionLineaGrupoCDMA()");
			cuentaComDTO = srv.validacionLineaGrupoCDMA(cuentaComDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:validacionLineaGrupoCDMA()");
			return cuentaComDTO;
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CuentaComDTO validacionLineaGrupoGSM(CuentaComDTO cuentaComDTO) throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:validacionLinea()");
			cuentaComDTO = srv.validacionLineaGrupoGSM(cuentaComDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:validacionLinea()");
			return cuentaComDTO;
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));

			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void setNumeracionSimPortada(SimcardSNPNDTO simcardSNPNDTO)throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:setNumeracionSimPortada()");
			abonadoSRV.setNumeracionSimPortada(simcardSNPNDTO);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:setNumeracionSimPortada()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public void setAceptacionVenta(GaVentasDTO entrada) 
	throws GeneralException{		
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:setAceptacionVenta()");
			abonadoSRV.setAceptacionVenta(entrada);			
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:setAceptacionVenta()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void getPlanTarifarioClienteEMP(PlanTarifarioDTO planEntrada) throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
		logger.debug("Inicio:getPlanTarifario()");
		try{
			srv.getPlanTarifarioClienteEMP(planEntrada);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:getPlanTarifario()");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void setNumeracionTerminalPortada(TerminalSNPNDTO terminal) throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:setNumeracionTerminalPortada()");
			abonadoSRV.setNumeracionTerminalPortada(terminal);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:setNumeracionTerminalPortada()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}	
	
	/**
	*  <!-- begin-xdoclet-definition -->
	* @throws IntegracionSIGAException, SQLException
	* @ejb.interface-method view-type="both"
	* @ejb.transaction
	* type="Required"
	* <!-- end-xdoclet-definition -->
	* @generated
	*
	*/
	public MigracionPrepagoPostpagoDTO migraPrepagoAPostpago(MigracionDTO migracionDTO)
	throws GeneralException
	{   
		MigracionPrepagoPostpagoDTO ejecucion;
		
		ejecucion = migracionUsuario.migraPrepagoAPostpago(migracionDTO);
		
		if(ejecucion.getCodError() != null && !ejecucion.getCodError().equals("0")){
			context.setRollbackOnly();
		}
		return ejecucion;
	}
	
	
	/**
	*  <!-- begin-xdoclet-definition -->
	* @ejb.interface-method view-type="both"
	* @ejb.transaction
	* type="Required"
	* <!-- end-xdoclet-definition -->
	* @generated
	*
	*/
	public ResultadoValidacionDatosMigracionDTO validaDatos(MigracionDTO datosMigracionClienteDTO) 
	throws GeneralException
	{   	
		ResultadoValidacionDatosMigracionDTO resultado = new ResultadoValidacionDatosMigracionDTO();
		
		try {
			resultado = migracionUsuario.validaDatos(datosMigracionClienteDTO);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return resultado;
			
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void udpEmpresa(CuentaComDTO cuenta) 
	throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:udpEmpresa()");
			srv.udpEmpresa(cuenta);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:udpEmpresa()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}	
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SumaPrecioPlanesDTO getSumaPrecioPlanesXAntiguedad(SumaPrecioPlanesDTO sumaPrecioPlanesDTO)throws GeneralException{
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getSumaPrecioPlanesXAntiguedad():start");  		
		try{
					
			sumaPrecioPlanesDTO = srv.getSumaPrecioPlanesXAntiguedad(sumaPrecioPlanesDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getSumaPrecioPlanesXAntiguedad():end"); 
		return sumaPrecioPlanesDTO;
	}
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void ValidaUsuarioSCL(String nomUsuario)throws GeneralException{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:ValidaUsuarioSCL()");
			srv.ValidaUsuarioSCL(nomUsuario);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:ValidaUsuarioSCL()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void registraAltaAsincrono(WsCunetaAltaDeLineaOutDTO cunetaAltaDeLineaOut, String id_transaccion) 
	throws GeneralException
	{
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:registraAltaAsincrono()");
			abonadoSRV.registraAltaAsincrono(cunetaAltaDeLineaOut, id_transaccion);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:registraAltaAsincrono()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public WsCunetaAltaDeLineaOutDTO recuperarAltaAsincrono(String id_transaccion) 
	throws GeneralException
	{
		WsCunetaAltaDeLineaOutDTO CunetaAltaDeLineaOut = new WsCunetaAltaDeLineaOutDTO();
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:recuperarAltaAsincrono()");
			CunetaAltaDeLineaOut = abonadoSRV.recuperarAltaAsincrono(id_transaccion);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:recuperarAltaAsincrono()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
		return CunetaAltaDeLineaOut;
	}		
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public WsBeneficioPromocionOutDTO[] recCampanaBeneficio(WsBeneficioPromocionInDTO beneficioPromocion) 
	throws GeneralException
	{		
		WsBeneficioPromocionOutDTO[] retorno = null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:recCampanaBeneficio()");
			retorno = abonadoSRV.recCampanaBeneficio(beneficioPromocion);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:recCampanaBeneficio()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
		return retorno;
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void registraCampanaBeneficio(WsRegistraCampanaByPInDTO registraCampanaByPIn) 
	throws GeneralException
	{				
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Inicio:registraCampanaBeneficio()");
			abonadoSRV.registraCampanaBeneficio(registraCampanaByPIn);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:registraCampanaBeneficio()");			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}				
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void udpInterfazDeFacturación(GaVentasDTO gaVentas)
	throws GeneralException{
		
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GestionDeClienteBean: udpInterfazDeFacturación:start");
			srv.udpInterfazDeFacturación(gaVentas);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: udpInterfazDeFacturación:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		
	}	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setSalidaDefAccesorios(WsStructuraAccesorioDTO[] accesorios, String usuario, String proceso, String codVendedor)
	throws GeneralException{		 
		SerieDTO serie = null;
		try{
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GestionDeClienteBean: setSalidaDefAccesorios:start");
				
			if (accesorios != null) {
				for(int i=0; i< accesorios.length; i++ ){
					
					logger.debug("accesorios["+i+"].getNumeroSerie()["+accesorios[i].getNumeroSerie()+"]");
					if(accesorios[i].getNumeroSerie() != null && !accesorios[i].getNumeroSerie().equals("")){
						serie = new SerieDTO();
						serie.setNumSerie(accesorios[i].getNumeroSerie());
						serie.setNomUsuario(usuario);
						serie.setNumPorceso(proceso);
						srv.salidaDefinitivaSerie(serie);
				 	}else{
				 		//INICIO CSR-11002
				 		logger.debug("BODEGA_ARTICULO: " + accesorios[i].getCodBodega());
				 		//FIN CSR-11002
				 		srv.SalidaDefArticulo(accesorios[i].getCodigoArticulo(),usuario, proceso, codVendedor, Integer.parseInt( accesorios[i].getCantidad()), accesorios[i].getCodBodega());
				 	}
				}							
			}
			
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: setSalidaDefAccesorios:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}	
		
//	Inicio Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void cancelaVenta(GaVentasDTO gaVentasDTO)
	throws GeneralException{
		logger.debug("cancelaVenta:start");
		logger.debug("Incidencia 143860");
		try {
			abonadoSRV.cancelaVenta(gaVentasDTO);
		}catch(GeneralException e){
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:cancelaVenta");
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Fin:cancelaVenta");
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("cancelaVenta:end");
	}	
//	Fin Incidencia 143860 [ACP Soporte Ventas 05-10-2010]
		
//INICIO CSR-11002	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CategoriaCambioDTO[] getCategoriasCambio() throws GeneralException
	{
		logger.debug("getCategoriasCambio():start");
		CategoriaCambioDTO[] resultado;
		try
		{
			logger.debug("Inicio:getCategoriasCambio()");
			resultado = srv.getCategoriasCambio();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getCategoriasCambio:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getCategoriasCambio():start");
		return resultado;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void insCategoriaCambioCliente(CategoriaCambioClienteDTO categCambioCliente) throws GeneralException
	{
		logger.debug("insCategoriaCambioCliente():start");
		try
		{
			logger.debug("Inicio:insCategoriaCambioCliente()");
			srv.insCategoriaCambioCliente(categCambioCliente);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: insCategoriaCambioCliente:end");
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("insCategoriaCambioCliente():start");
	}
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ValorClasificacionDTO[] getCrediticia() throws GeneralException{
		
		ValorClasificacionDTO[] result = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getCrediticia():start");  		
		try{
			
			result=srv.getCrediticia();
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getSucursalesBanco():end");
		
		return result;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClasificacionDTO[] getClasificaciones() throws GeneralException{
		
		ClasificacionDTO[] result = null;
		UtilLog.setLog(config.getString("GestionDeClienteBean.log"));		
		logger.debug("getClasificaciones():start");  		
		try{
			
			result=srv.getClasificaciones();
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));			
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;

		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");	
			throw  new GeneralException(e);
		}
		logger.debug("getClasificaciones():end");
		
		return result;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListTipoPagoOutDTO getListadoTipoPago() throws GeneralException {
		WsListTipoPagoOutDTO retValue = null;
		try {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoTipoPago:start");
			retValue = srv.getListadoTipoPago();
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoTipoPago:end");
		}
		catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug((new StringBuilder()).append("log error[").append(log).append("]").toString());
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug((new StringBuilder()).append("log error[").append(log).append("]").toString());
			throw new GeneralException(e);
		}
		return retValue;
	}
	
//	FIN CSR-11002	
	
	//JLGN PT
	/** 
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @throws FrameworkException 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public WsListPlanTarifarioOutDTO getListadoPlanTarifario() throws GeneralException {
		WsListPlanTarifarioOutDTO retValue = null;
		ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
		String tipProducto = null;
		String tipPlan = null;
		String codTipPrestacion = null;
		int indRenova;
		String codCalificacion = null;
		try {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoPlanTarifario:start");
			
			tipProducto = config.getString("planTarif.tipProducto");
			tipPlan = config.getString("planTarif.tipoPlan");
			codTipPrestacion = config.getString("planTarif.codTipPrestacion");
			indRenova = 0;
			
			parametrosGeneralesDTO.setCodigomodulo(config.getString("codigo.modulo.GE"));
			parametrosGeneralesDTO.setCodigoproducto(config.getString("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(config.getString("parametro.calificacion"));
			parametrosGeneralesDTO = srv.getParametroGeneral(parametrosGeneralesDTO);
			
			codCalificacion = parametrosGeneralesDTO.getValorparametro();
			
			retValue = srv.getListadoPlanTarifario(tipProducto, tipPlan, codTipPrestacion, indRenova, codCalificacion);
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GestionDeClienteBean: getListadoTipoPago:end");
		}
		catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug((new StringBuilder()).append("log error[").append(log).append("]").toString());
			throw e;
		}
		catch (Exception e) {
			UtilLog.setLog(config.getString("GestionDeClienteBean.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug((new StringBuilder()).append("log error[").append(log).append("]").toString());
			throw new GeneralException(e);
		}
		return retValue;
	}
	
}




