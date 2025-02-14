/**
 * 
 */
package com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session;

import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.GeSegUsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.GeSegUsuarioListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LimiteLineasDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.MorosidadClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ObtencionLineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CITIPORSERVDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CantSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaCambioPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DireccionOficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OperadoraLocalDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PenalizacionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PrestacionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RangoAntiguedadDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ServCuentaSegDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.helper.AuditoriaDTODAO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.helper.ProcesoAsincronoDAO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaResponseDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaServicioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GaAbocelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.NombreCamposDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionSecuenciasDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtenerCampos;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProcesoProductoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RespuestaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.LimiteConsumoAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanCicloDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ServicioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ParamCargosAbonadoCeroDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu.GestionAnulaOOSSSrvFactory;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu.interfaces.GestionAnulaOOSSSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.anu.interfaces.GestionAnulaOOSSSrvIF;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord.GestionApoyoOrdenServicioSrvFactory;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord.interfaces.GestionApoyoOrdenServicioSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord.interfaces.GestionApoyoOrdenServicioSrvIF;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.GestionParametrosGeneralesSrvFactory;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.interfaces.GestionParametrosGeneralesSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.interfaces.GestionParametrosGeneralesSrvIF;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SupOrdHanFacade"	
 *           description="An EJB named SupOrdHanFacade"
 *           display-name="SupOrdHanFacade"
 *           jndi-name="SupOrdHanFacade"
 *           type="Stateless" 
 *
 *           transaction-type="Container"
 *   
 *  @ejb.transaction="Supports"
 *  
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class SupOrdHanFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	
	private final Logger logger = Logger.getLogger(SupOrdHanFacadeBean.class);
	
	private Global global = Global.getInstance();
	
	// Instancia el factory
	GestionApoyoOrdenServicioSrvFactoryIF factorySrv1 = new GestionApoyoOrdenServicioSrvFactory();
	GestionAnulaOOSSSrvFactoryIF factorySrv2 = new GestionAnulaOOSSSrvFactory();
	GestionParametrosGeneralesSrvFactoryIF factorySrv3 = new GestionParametrosGeneralesSrvFactory();
	
	// Obtiene el application service
	GestionApoyoOrdenServicioSrvIF service1 = factorySrv1.getApplicationService1();
	GestionAnulaOOSSSrvIF service2 = factorySrv2.getApplicationService1();
	GestionParametrosGeneralesSrvIF service3 = factorySrv3.getApplicationService1();
	
	
	/** 
	 *  Obtener Texto Carta
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws SupOrdHanException{
		CartaGeneralDTO retorno = null;
		try{
			logger.debug("obtenerTextoCarta():start");
			retorno = service1.obtenerTextoCarta(cartaGeneral);
			logger.debug("obtenerTextoCarta():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
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
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}

	/** 
	 *  Anula bolsa dinamica
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO anularCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("anularCargoBolsaDinamica():start");
			resultado = service1.anularCargoBolsaDinamica(bolsa);
			logger.debug("anularCargoBolsaDinamica():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Obtiene el cargo actual
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CargoClienteDTO obtenerCargoBasicoActual(CargoClienteDTO cliente) throws SupOrdHanException{	
		CargoClienteDTO cargo = null;
		try{
			
			logger.debug("obtenerCargoBasicoActual():start");
			cargo = service1.obtenerCargoBasicoActual(cliente);
			logger.debug("obtenerCargoBasicoActual():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return cargo;		
	}	
	
	/** 
	 * Valida tipo de plan tarifario
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarTipoPlanCliente(ClienteDTO cliente) throws SupOrdHanException{	
		
		RetornoDTO retorno = null;
		try{
			logger.debug("validarTipoPlanCliente():start");
			retorno = service1.validarTipoPlanCliente(cliente);
			logger.debug("validarTipoPlanCliente():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	/** 
	 *  Anula solicitud en Proceso producto de un cambio de ciclo
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public IOOSSDTO anulaOossPendPlan(IOOSSDTO ordenServicio) throws SupOrdHanException{
		IOOSSDTO resultado = null;
		try{
			logger.debug("anulaOossPendPlan():start");
			resultado = service2.anulaOossPendPlan(ordenServicio);
			logger.debug("anulaOossPendPlan():end");
		} catch(SupOrdHanException e){
			this.context.setRollbackOnly();
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			this.context.setRollbackOnly();
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Anula solicitud en Proceso producto de un cambio de ciclo
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public IOOSSDTO anulaOossPendPlan(IOOSSDTO[] ordenServicioArr) throws SupOrdHanException{
		IOOSSDTO resultado = null;
		try{
			logger.debug("anulaOossPendPlan():start");
			IOOSSDTO ordenServicio = null;
			for(int i=0;i<ordenServicioArr.length;i++)
			{
				ordenServicio = ordenServicioArr[i];
				resultado = service2.anulaOossPendPlan(ordenServicio);
			}
			logger.debug("anulaOossPendPlan():end");
		} catch(SupOrdHanException e){
			this.context.setRollbackOnly();
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			this.context.setRollbackOnly();
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}

	/** 
	 *  Obtiene informacion de la orden de servicio
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ConversionListDTO obtenerConversionOOSS(ConversionDTO param) throws SupOrdHanException{
		ConversionListDTO resultado = null;
		try{
			logger.debug("obtenerConversionOOSS():start");
			resultado = service3.obtenerConversionOOSS(param);
			logger.debug("obtenerConversionOOSS():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Obtiene datos cambio de plan
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoDTO obtenerDatosCambPlanServ(AbonadoDTO abonado) throws SupOrdHanException{
		AbonadoDTO resultado = null;
		try{
			logger.debug("obtenerDatosCambPlanServ():start");
			resultado = service1.obtenerDatosCambPlanServ(abonado);
			logger.debug("obtenerDatosCambPlanServ():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Obtiene numero de secuencia
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws SupOrdHanException{
		SecuenciaDTO resultado = null;
		try{
			logger.debug("obtenerSecuencia():start");
			resultado = service3.obtenerSecuencia(secuencia);
			logger.debug("obtenerSecuencia():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Obtiene valor de parametro general
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws SupOrdHanException{
		ParametroDTO resultado = null;
		try{
			logger.debug("obtenerParametroGeneral():start");
			resultado = service3.obtenerParametroGeneral(param);
			logger.debug("obtenerParametroGeneral():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Obtiene valor de parametro simple
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametroDTO obtenerParametrosSimples(ParametroDTO param) throws SupOrdHanException{
		ParametroDTO resultado = null;
		try{
			logger.debug("obtenerParametrosSimples():start");
			resultado = service3.obtenerParametrosSimples(param);
			logger.debug("obtenerParametrosSimples():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 *  Obtiene valor de parametro simple
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public TipIdentListDTO obtenerTiposDeIdentidad() throws SupOrdHanException{
		TipIdentListDTO resultado = null;
		try{
			logger.debug("obtenerParametrosSimples():start");
			resultado = service3.obtenerTiposDeIdentidad();
			logger.debug("obtenerParametrosSimples():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 *  Actualiza GA_ABOCEL
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarAboCtaSeg(GaAbocelDTO abonado) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("actualizarAboCtaSeg():start");
			resultado = service1.actualizarAboCtaSeg(abonado);
			logger.debug("actualizarAboCtaSeg():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Inserta en GA_ABOCEL
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO migrarAbonado(GaAbocelDTO abonado) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("migrarAbonado():start");
			resultado = service1.migrarAbonado(abonado);
			logger.debug("migrarAbonado():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 *  Obtiene campo fec_cumplan de GA_ABOCEL
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GaAbocelDTO obtenerFecCumPlan(GaAbocelDTO abonado) throws SupOrdHanException{
		GaAbocelDTO resultado = null;
		try{
			logger.debug("obtenerFecCumPlan():start");
			resultado = service1.obtenerFecCumPlan(abonado);
			logger.debug("obtenerFecCumPlan():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	/** 
	 *  Obtener codActAbo homologo
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ConvertActAboDTO obtenerConverActAbo(ConvertActAboDTO param) throws SupOrdHanException{
		ConvertActAboDTO resultado = null;
		try{
			logger.debug("obtenerConverActAbo():start");
			resultado = service1.obtenerConverActAbo(param);
			logger.debug("obtenerConverActAbo():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	/** 
	 *  Valida servicios duplicados
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarServiciosDuplicados(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("validarServiciosDuplicados():start");
			resultado = service1.validarServiciosDuplicados(abonado);
			logger.debug("validarServiciosDuplicados():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	/** 
	 *  Actualiza baja en GA_SERVSUPLABO
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO bajaSSPrepago(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("bajaSSPrepago():start");
			resultado = service1.bajaSSPrepago(abonado);
			logger.debug("bajaSSPrepago():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	/** 
	 *  Actualiza baja en GA_INTARCEL
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO bajaRegTarif(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("bajaRegTarif():start");
			resultado = service1.bajaRegTarif(abonado);
			logger.debug("bajaRegTarif():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	/** 
	 *  Obtiene grupo nivel de GA_SERVSUPLABO
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ServicioDTO obtenerGrupoNivelContratado(AbonadoDTO abonado) throws SupOrdHanException{
		ServicioDTO resultado = null;
		try{
			logger.debug("obtenerGrupoNivelContratado():start");
			resultado = service1.obtenerGrupoNivelContratado(abonado);
			logger.debug("obtenerGrupoNivelContratado():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	/** 
	 *  Obtener causa baja
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CausaBajaListDTO obtenerCausaBaja() throws SupOrdHanException{
		CausaBajaListDTO resultado = null;
		try{
			logger.debug("obtenerCausaBaja():start");
			resultado = service1.obtenerCausaBaja();
			logger.debug("obtenerCausaBaja():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
		
	}
	/** 
	 *  Obtiene ciclo de plan freedom
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanCicloDTO obtenerCicloFreedom(PlanCicloDTO plan) throws SupOrdHanException{
		PlanCicloDTO resultado = null;
		try{
			logger.debug("obtenerCicloFreedom():start");
			resultado = service1.obtenerCicloFreedom(plan);
			logger.debug("obtenerCicloFreedom():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 *  Actualiza comentario
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarComentPvIorserv(IOOSSDTO os) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("actualizarComentPvIorserv():start");
			resultado = service3.actualizarComentPvIorserv(os);
			logger.debug("actualizarComentPvIorserv():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 *  Valida portabilidad
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarPortabilidad(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("validarPortabilidad():start");
			resultado = service3.validarPortabilidad(abonado);
			logger.debug("validarPortabilidad():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}

	/** 
	 *  Valida portabilidad
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametroListDTO obtenerParametrosGenerales() throws SupOrdHanException{
		ParametroListDTO resultado = null;
		try{
			logger.debug("obtenerParametrosGenerales():start");
			resultado = service3.obtenerParametrosGenerales();
			logger.debug("obtenerParametrosGenerales():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 * Inserta registro en GA_TRANSACABO
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO insertarTransacabo(SecuenciaDTO secuencia) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("insertarTransacabo():start");
			resultado = service1.insertarTransacabo(secuencia);
			logger.debug("insertarTransacabo():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 * Inserta registro en GA_TRANSACABO
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioDTO obtenerCategPlan(PlanTarifarioDTO plan) throws SupOrdHanException{
		PlanTarifarioDTO resultado = null;
		try{
			logger.debug("obtenerCategPlan():start");
			resultado = service1.obtenerCategPlan(plan);
			logger.debug("obtenerCategPlan():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 * Obtiene plan comercial
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws SupOrdHanException{
		ClienteDTO resultado = null;
		try{
			logger.debug("obtenerPlanComercial():start");
			resultado = service1.obtenerPlanComercial(cliente);
			logger.debug("obtenerPlanComercial():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 * Obtiene valor calculado cliente
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteDTO obtenerValorCalculado(ClienteDTO cliente) throws SupOrdHanException{
		ClienteDTO resultado = null;
		try{
			logger.debug("obtenerValorCalculado():start");
			resultado = service1.obtenerValorCalculado(cliente);
			logger.debug("obtenerValorCalculado():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 *  Edita los datos de un proceso en ejecucion y guarda el DTO de entrada de forma binaria
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO inscribeProceso(ParametroSerializableDTO parametro) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("inscribeProceso():start");			
			resultado=ProcesoAsincronoDAO.getInstance().inscribeProceso(parametro);			
			logger.debug("inscribeProceso():end");
		} catch (Exception e) {
			this.context.setRollbackOnly();
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Edita los datos de un proceso en ejecucion y guarda el DTO de entrada de forma binaria
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ParametroSerializableDTO nuevoProceso(ParametroSerializableDTO parametro) throws SupOrdHanException
	{		
		try
		{
			logger.debug("nuevoProceso():start");			
			parametro=ProcesoAsincronoDAO.getInstance().nuevoProceso(parametro);		
			
			logger.debug("nuevoProceso():end");
		}
		catch (Exception e) 
		{
			this.context.setRollbackOnly();
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return parametro;		
	}
	
	
	/** 
	 *  Obtiene codigo vendedor
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws SupOrdHanException{
		UsuarioDTO resultado = null;
		try{
			logger.debug("obtenerVendedor():start");
			resultado = service1.obtenerVendedor(usuario);
			logger.debug("obtenerVendedor():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Obtiene ruta de factura
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws SupOrdHanException{
		ArchivoFacturaDTO resultado = null;
		try{
			logger.debug("obtenerRutaFactura():start");
			resultado = service1.obtenerRutaFactura(factura);
			logger.debug("obtenerRutaFactura():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 *  Obtiene información de descuentos para vendedor
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws SupOrdHanException{
		DescuentoVendedorDTO resultado = null;
		try{
			logger.debug("obtenerDescuentoVendedor():start");
			resultado = service1.obtenerDescuentoVendedor(vendedor);
			logger.debug("obtenerDescuentoVendedor():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 *  Obtiene información de penalizacion
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public PenalizacionDTO obtenerPenalizacion(PenalizacionDTO param) throws SupOrdHanException{
		PenalizacionDTO resultado = null;
		try{
			logger.debug("obtenerPenalizacion():start");
			resultado = service1.obtenerPenalizacion(param);
			logger.debug("obtenerPenalizacion():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/*
	/** 
	 *  Obtiene direccion de oficina de vendedor
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DireccionOficinaDTO obtenerDireccionOficina(String codOficina) throws SupOrdHanException{
		DireccionOficinaDTO resultado = null;
		try{
			logger.debug("obtenerDireccionOficina():start");
			resultado = service1.obtenerDireccionOficina(codOficina);
			logger.debug("obtenerDireccionOficina():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;			
	}
	
	/** 
	 *  Obtiene rango de antiguedad
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public RangoAntiguedadDTO obtenerRangoAntiguedad(RangoAntiguedadDTO param) throws SupOrdHanException{
		RangoAntiguedadDTO resultado = null;
		try{
			logger.debug("obtenerRangoAntiguedad():start");
			resultado = service1.obtenerRangoAntiguedad(param);
			logger.debug("obtenerRangoAntiguedad():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 *  Obtiene codigo de vendedor raiz
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public Integer obtenerVendedorRaiz(Integer codVendedor) throws SupOrdHanException{
		Integer resultado = null;
		try{
			logger.debug("obtenerVendedorRaiz():start");
			resultado = service1.obtenerVendedorRaiz(codVendedor);
			logger.debug("obtenerVendedorRaiz():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 *  Obtiene codigo de operadora
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public String obtenerOperadora(Long codCliente) throws SupOrdHanException{
		String resultado = null;
		try{
			logger.debug("obtenerOperadora():start");
			resultado = service1.obtenerOperadora(codCliente);
			logger.debug("obtenerOperadora():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 *  Obtiene clase de servicio
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public ServCuentaSegDTO tratarServCtaSeg(ServCuentaSegDTO param) throws SupOrdHanException{
		ServCuentaSegDTO resultado = null;
		try{
			logger.debug("tratarServCtaSeg():start");
			resultado = service1.tratarServCtaSeg(param);
			logger.debug("tratarServCtaSeg():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 * Valida registrar mov.controlada
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registrarMovControlada(AbonadoDTO abonado) throws SupOrdHanException{	
		
		RetornoDTO retorno = null;
		try{
			logger.debug("registrarMovControlada():start");
			retorno = service1.registrarMovControlada(abonado);
			logger.debug("registrarMovControlada():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	/** 
	 * Valida registrar mov.controlada
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws SupOrdHanException{	
		
		ContratoDTO retorno = null;
		try{
			logger.debug("obtenerTipoContrato():start");
			retorno = service1.obtenerTipoContrato(contrato);
			logger.debug("obtenerTipoContrato():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}	
	
	/** 
	 * Obtener modalidad de pago
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws SupOrdHanException{
		ModalidadPagoDTO retorno = null;
		try{
			logger.debug("obtenerModalidadPago():start");
			retorno = service1.obtenerModalidadPago(modalidad);
			logger.debug("obtenerModalidadPago():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
	}
	
	/** 
	 * Obtiene información de vendedor
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws SupOrdHanException{
		VendedorDTO retorno = null;
		try{
			logger.debug("obtenerVendedor():start");
			retorno = service1.obtenerVendedor(vendedor);
			logger.debug("obtenerVendedor():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	/** 
	 * Crea estructura de integración con Producto-CPU
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public IntegraProdCPUDTO [] creaEstructuraProdCPU(IntegraProdCPUDTO integraProdCPUDTO, IntegraProdCPUDTO [] integraProdCPUDTOList) throws SupOrdHanException{	
		
		IntegraProdCPUDTO [] retorno = null;
		try{
			logger.debug("creaEstructuraProdCPU():start");
			
			List listaIntegra = new ArrayList();
			for(int i = 0; i<(integraProdCPUDTOList==null?0:integraProdCPUDTOList.length);i++){
				listaIntegra.add(integraProdCPUDTOList[i]);
			}
			listaIntegra.add(integraProdCPUDTO);
			retorno = new IntegraProdCPUDTO[listaIntegra.size()];
			for(int x = 0;x<listaIntegra.size();x++){
				retorno[x] = (IntegraProdCPUDTO)listaIntegra.get(x);
			}
			logger.debug("creaEstructuraProdCPU():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	
	/** 
	 * Obtiene numero de lineas del cliente
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public LineasClienteDTO obtenerCantidadLineasCliente(LineasClienteDTO cliente) throws SupOrdHanException{
		LineasClienteDTO retorno = null;
		try{
			logger.debug("obtenerCantidadLineasCliente():start");
			retorno = service1.obtenerCantidadLineasCliente(cliente);
			logger.debug("obtenerCantidadLineasCliente():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}

	/** 
	 * Obtiene morosidad del cliente
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public MorosidadClienteDTO obtenerMorosidadCliente(MorosidadClienteDTO cliente) throws SupOrdHanException{
		MorosidadClienteDTO retorno = null;
		try{
			logger.debug("obtenerMorosidadCliente():start");
			retorno = service1.obtenerMorosidadCliente(cliente);
			logger.debug("obtenerMorosidadCliente():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;				
	}

	/** 
	 * Obtiene codigo modalidad de venta
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public AbonadoDTO obtenerCodigoModalidad(AbonadoDTO abonado) throws SupOrdHanException{
		AbonadoDTO retorno = null;
		try{
			logger.debug("obtenerCodigoModalidad():start");
			retorno = service1.obtenerCodigoModalidad(abonado);
			logger.debug("obtenerCodigoModalidad():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;				
	}
	
	
	/** 
	 * Obtiene el Limite de Lineas
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public LimiteLineasDTO obtenerLimiteLineas(ObtencionLineasClienteDTO lineas) throws SupOrdHanException{
		LimiteLineasDTO retorno = null;
		try{
			logger.debug("obtenerLimiteLineas():start");
			retorno = service1.obtenerLimiteLineas(lineas);
			logger.debug("obtenerLimiteLineas():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
	}
	
	/** 
	 * Valida situacion cliente
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarSituaCliEmp(ClienteDTO cliente) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try{
			logger.debug("validarSituaCliEmp():start");
			retorno = service1.validarSituaCliEmp(cliente);
			logger.debug("validarSituaCliEmp():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
	}
	
	/** 
	 * Valida si el cliente pertenece a NPW 
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarClienteNPW(ClienteDTO cliente) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try{
			logger.debug("validarClienteNPW():start");
			retorno = service1.validarClienteNPW(cliente);
			logger.debug("validarClienteNPW():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
	}
	
	
	/** 
	 * Obtener plan tarifario 
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioDTO obtenerPlanTarifario(PlanTarifarioDTO plan) throws SupOrdHanException{

		try{
			logger.debug("obtenerPlanTarifario():start");
			plan = service1.obtenerPlanTarifario(plan);
			logger.debug("obtenerPlanTarifario():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return plan;		
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

	public RetornoDTO validarOriDesUso(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try{
			logger.debug("validarOriDesUso():start");
			retorno = service1.validarOriDesUso(abonado);
			logger.debug("validarOriDesUso():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
		
	}

	/** 
	 * Inserta registro en GA_CONTCTA
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO insertarContratoCuenta(GaAbocelDTO contratoCuenta) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try{
			logger.debug("insertarContratoCuenta():start");
			retorno = service1.insertarContratoCuenta(contratoCuenta);
			logger.debug("insertarContratoCuenta():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;
	}
	

	/** 
	 * Valida lista negra
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validaListaNegra (AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try{
			logger.debug("validaListaNegra():start");
			retorno = service1.validaListaNegra(abonado);
			logger.debug("validaListaNegra():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;
	}
	
	/** 
	 * Inserta en ga_ventas
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO insertarGaVenta(IngresoVentaDTO venta) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try{
			logger.debug("insertarGaVenta():start");
			retorno = service1.insertarGaVenta(venta);
			logger.debug("insertarGaVenta():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;
	}
	
	/** 
	 * 
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarSolicitudesBaja(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validarSolicitudesBaja():start");
			retorno = service1.validarSolicitudesBaja(abonado);
			logger.debug("validarSolicitudesBaja():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	/** 
	 * 
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GeSegUsuarioListDTO obtenerUsuariosPorCodVendedor(AbonadoDTO abonadoDTO) throws SupOrdHanException {
		GeSegUsuarioListDTO retValue = null;
		try {
			logger.debug("obtenerUsuariosPorCodVendedor():start");
			retValue = service3.obtenerUsuariosPorCodVendedorNumVenta(abonadoDTO);
			logger.debug("obtenerUsuariosPorCodVendedor():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retValue;	
	}
	
	
	/** 
	 * 
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GeSegUsuarioListDTO obtenerUsuariosPorCodVendedor(GeSegUsuarioDTO geSegUsuarioDTO) throws SupOrdHanException {
		GeSegUsuarioListDTO retValue = null;
		try {
			logger.debug("obtenerUsuariosPorCodVendedor():start");
			retValue = service3.obtenerUsuariosPorCodVendedorNumVenta(geSegUsuarioDTO);
			logger.debug("obtenerUsuariosPorCodVendedor():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retValue;	
	}
	/** 
	 * 
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO getUsuariosPorNumVenta(String numVenta) throws SupOrdHanException {
		RetornoDTO retValue = null;
		try {
			logger.debug("getUsuariosPorNumVenta():start");
			retValue = service3.getUsuariosPorNumVenta(numVenta);
			logger.debug("getUsuariosPorNumVenta():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retValue;	
	}
	
	/** 
	 * 
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarReversa(OrdenServicioDTO ordenServicioDto) throws SupOrdHanException {
		RetornoDTO retorno = null;
		try {
			logger.debug("validarReversa():start");
			retorno = service1.validarReversa(ordenServicioDto);
			logger.debug("validarReversa():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
	}
	
	/** 
	 * 
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO validarNumPer(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validarNumPer():start");
			retorno = service1.validarNumPer(abonado);
			logger.debug("validarNumPer():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	/** 
	 * 
	 * RetornoDTO
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarUsoIntarcel(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarUsoIntarcel():start");
			retorno = service1.actualizarUsoIntarcel(abonado);
			logger.debug("actualizarUsoIntarcel():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public int validarCarta(OrdenServicioDTO ordenServicio) throws SupOrdHanException{
		int canReg=0;
		try {
			
			logger.debug("validarCarta():start");
			canReg = service1.validarCarta(ordenServicio);
			logger.debug("validarCarta():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return canReg;			
	}
	
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SecuenciaDTO[] obtenerNumeroDeSecuencias(CantSecuenciaDTO param) throws SupOrdHanException{
		SecuenciaDTO[] secuencias = null;
		try {
			logger.debug("obtenerNumeroDeSecuencias():start");
			secuencias  = service1.obtenerNumeroDeSecuencias(param);
			logger.debug("obtenerNumeroDeSecuencias():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return secuencias;			
	}
	
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  OficinaDTO obtenerDatosOficina(OficinaDTO param) throws SupOrdHanException{
		OficinaDTO retorno = null;
		try {
			logger.debug("obtenerDatosOficina():start");
			retorno = service1.obtenerDatosOficina(param);
			logger.debug("obtenerDatosOficina():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public AbonadoSecuenciaDTO[] obtenerSecuenciasAbonados(ObtencionSecuenciasDTO param) throws SupOrdHanException{
		AbonadoSecuenciaDTO[] retorno = null;
		try {
			logger.debug("obtenerSecuenciasAbonados():start");
			retorno = service1.obtenerSecuenciasAbonados(param);
			logger.debug("obtenerSecuenciasAbonados():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public GedCodigosListDTO obtenerListaGedCodigos(GedCodigosDTO gedCodigosDTO) throws SupOrdHanException{
		GedCodigosListDTO retorno = null;
		try {
			logger.debug("obtenerListaGedCodigos():start");
			retorno = service3.obtenerListaGedCodigos(gedCodigosDTO);
			logger.debug("obtenerListaGedCodigos():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	//INI COL; 72181; AVC 17-12-08--------------->71897
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO getValidacionAbonadoCero(ParamCargosAbonadoCeroDTO param)throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getValidacionAbonadoCero():start");
			retorno = service1.getValidacionAbonadoCero(param);
			logger.debug("getValidacionAbonadoCero():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	//FIN COL; 72181; AVC 17-12-08
	/** 
	 * 
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public  CITIPORSERVDTO obtenerTiporserv(CITIPORSERVDTO param) throws SupOrdHanException{
		CITIPORSERVDTO retorno = null;
		try {
			logger.debug("obtenerTiporserv():start");
			retorno = service1.obtenerTiporserv(param);
			logger.debug("obtenerTiporserv():end");
		} catch (SupOrdHanException e) {
			logger.debug("SupOrdHanException[", e);
			throw (e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	/** 
	 *  Obtener Prestaciones
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PrestacionListDTO obtenerPrestaciones() throws SupOrdHanException{
		PrestacionListDTO resultado = null;
		try{
			logger.debug("obtenerPrestaciones():start");
			resultado = service1.obtenerPrestaciones();
			logger.debug("obtenerPrestaciones():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
		
	}
	
	/** 
	 *  Obtener Causas de Cambio de Plan
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CausaCambioPlanListDTO obtenerCausasCambioPlan() throws SupOrdHanException{
		CausaCambioPlanListDTO resultado = null;
		try{
			logger.debug("obtenerCausasCambioPlan():start");
			resultado = service1.obtenerCausasCambioPlan();
			logger.debug("obtenerCausasCambioPlan():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 *  Obtener operadora local
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public OperadoraLocalDTO obtenerOperadoraLocal() throws SupOrdHanException{
		OperadoraLocalDTO resultado = null;
		try{
			logger.debug("obtenerOperadoraLocal():start");
			resultado = service1.obtenerOperadoraLocal();
			logger.debug("obtenerOperadoraLocal():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 *  Obtiene limites de consumos para el plan tarifario
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioDTO[] obtenerLimitesPlan(PlanTarifarioDTO planTarifario) throws SupOrdHanException{
		PlanTarifarioDTO[] resultado = null;
		try{
			logger.debug("obtenerLimitesPlan():start");
			resultado = service1.obtenerLimitesPlan(planTarifario);
			logger.debug("obtenerLimitesPlan():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
	
	/** 
	 *  Actualiza limite de consumo para el plan tarifario
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizaLimiteConsumoPlan(PlanTarifarioDTO planTarifario)	throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("actualizaLimiteConsumoPlan():start");
			resultado = service1.actualizaLimiteConsumoPlan(planTarifario);
			logger.debug("actualizaLimiteConsumoPlan():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/** 
	 *  Corrige limite consumo ingresado en las tablas ga_limite_cliabo_to y ga_abocel por el metodo
	 *  actualizarLimiteConsumo 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizarLimiteConsumoFinal(LimiteConsumoAbonadoDTO entrada)	throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("actualizarLimiteConsumoFinal():start");
			resultado = service1.actualizarLimiteConsumoFinal(entrada);
			logger.debug("actualizarLimiteConsumoFinal():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}

	/** 
	 *  Extrae la Fecha y Hora d ela Base De Datos
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction
	 *   type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public Date obtenerFechaBaseDeDatos() throws SupOrdHanException {
		
		DatosGeneralesBOFactoryIT factoryBO = new DatosGeneralesBOFactory();
		DatosGeneralesBOIT datosGeneralesBO = factoryBO.getBusinessObject1();
		
		//especProducto.getTipoComportamiento()
		logger.debug("obtenerFechaTerminoVigencia():inicio");
		Date fechaHoraBaseDatos = null;
		
		try {
			fechaHoraBaseDatos = new java.util.Date((datosGeneralesBO.obtenerFechaHoraBaseDatos()).getTime());
		} catch (Exception e) {
			
			e.printStackTrace();
			throw new SupOrdHanException(e);
		}
		/*DD-MM-YYYY HH24:MI:SS formato inicial que no se puede recibir en un Timestamp por lo que se cambió al siguiente:
		YYYY-MM-DD HH24:MI:SS*/ //yyyy-mm-dd hh:mm:ss.fffffffff <-- public static Timestamp valueOf(String s)
		//Date fechaInicioVigencia = Formatting.getFecha(fechaHoraBaseDatos.toString(),"dd-MM-yyyy");//yyyy.MM.dd
		
		logger.debug("obtenerFechaTerminoVigencia fechaHoraBaseDatos --->["+fechaHoraBaseDatos+"]");
		return fechaHoraBaseDatos; 
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

	/** 
	 *
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		// TODO Auto-generated method stub
		this.context=arg0;
	}

	/**
	 * 
	 */
	public SupOrdHanFacadeBean() {
		// TODO Auto-generated constructor stub
	}
	/** 
	 *  Actualiza proceso encolado
	 *  
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction
	 *   type="RequiresNew"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizaProceso(ProcesoProductoDTO proceso) throws SupOrdHanException{
		RetornoDTO resultado = null;
		try{
			logger.debug("actualizaProceso():start");			
			resultado=ProcesoAsincronoDAO.getInstance().actualizaProceso(proceso);			
			logger.debug("actualizaProceso():end");
		} catch (Exception e) {
			this.context.setRollbackOnly();
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;		
	}
	
	/**
	 * Realiza validaciones Funcionales con los datos ingresados en la DTO de Auditoria
	 * @ejb.interface-method view-type="remote"
	 */
	
	public RespuestaDTO validacionesFuncionalesAuditoria(AuditoriaDTO auditoriaDTO)throws SupOrdHanException{
		RespuestaDTO respuestaDTO = null;
		try{
			logger.debug("validacionesFuncionalesAuditoria():start");
			respuestaDTO=AuditoriaDTODAO.getInstance().validarAplicacion(auditoriaDTO);
			
			if (respuestaDTO.getCodigoError()==0)
			{
				respuestaDTO=AuditoriaDTODAO.getInstance().consultarPuntoAcceso(auditoriaDTO);
				if (respuestaDTO.getCodigoError()==0)
				{
					respuestaDTO=AuditoriaDTODAO.getInstance().validarServicio(auditoriaDTO);
					if (respuestaDTO.getCodigoError()==0)
					{
						respuestaDTO=AuditoriaDTODAO.getInstance().validarNombreUsuario(auditoriaDTO);
					}
				}
			}
			logger.debug("validacionesFuncionalesAuditoria():end");
		} catch (Exception e) {
			this.context.setRollbackOnly();
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuestaDTO;		
	}
	
	/**
	 * Realiza la inserción en la tabla de auditoria, así como los parametros (servicios).
	 * @ejb.interface-method view-type="remote"
	 * 
	 * @param auditoriaDTO
	 * @return
	 * @throws SupOrdHanException
	 */
	
	public AuditoriaResponseDTO insertAuditoria(AuditoriaDTO auditoriaDTO)throws SupOrdHanException{
	AuditoriaResponseDTO auditoriaResponseDTO = null;
	try{
		logger.debug("insertAuditoria():start");
		auditoriaResponseDTO=AuditoriaDTODAO.getInstance().insertarAuditoria(auditoriaDTO);
		boolean okTransaccionAuditoria=auditoriaResponseDTO.getRespuesta()!=null?auditoriaResponseDTO.getRespuesta().getCodigoError()==0?true:false:false;
		
		if (okTransaccionAuditoria)
		{
			AuditoriaServicioDTO auditoriaServicioDTO = new AuditoriaServicioDTO();
			auditoriaServicioDTO.setCodAuditoria(auditoriaResponseDTO.getCodAuditoria());
			auditoriaServicioDTO.setNombreUsuario(auditoriaDTO.getNombreUsuario());
			// Inicio de Obtención de Nombres de Campos del DTO de Entrada
			logger.info("ObtenerCampos.getAttributes:start()");
    		logger.info("ObtenerCampos.getAttributes:antes()");
    		ArrayList campos = ObtenerCampos.getAttributes(auditoriaDTO.getClass(),auditoriaDTO);
			logger.info("ObtenerCampos.getAttributes:despues()");
    		logger.info("ObtenerCampos.getAttributes:end()");
    		// Fin de Obtención de Nombres de Campos del DTO de Entrada
	        Iterator  i = campos.iterator();
	        //Recorrido del ArraylList(obtencion de nombres de Campos) 
	        while(i.hasNext())
	        {	
		        	NombreCamposDTO valorcampos = (NombreCamposDTO)i.next();
		        	
		        		auditoriaServicioDTO.setNomParametro(valorcampos.getNombreCampo());
		        		auditoriaServicioDTO.setValParametro(valorcampos.getValorCampo());
		        		logger.info("insertarServicios:start()");
		        		logger.info("insertarServicios:antes()");
		        		RespuestaDTO servicio = AuditoriaDTODAO.getInstance().insertarServicios(auditoriaServicioDTO);
		        		logger.info("insertarServicios:despues()");
		        		logger.info("insertarServicios:end()");
						if (servicio != null &&  servicio.getCodigoError()!=0  )
						{
							auditoriaResponseDTO.setRespuesta(servicio);
							break;
						}
		       }
		}
		
		
		logger.debug("insertAuditoria():end");
	} catch (Exception e) {
		this.context.setRollbackOnly();
		logger.debug("Exception[", e);
		throw new SupOrdHanException(e);
	}
	return auditoriaResponseDTO;		
}
/** 
	 *  Obtiene indCompartido de plan tarifario
	 *  actualizarLimiteConsumo 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public PlanTarifarioDTO obtenerDatosPlanTarifario(String codPlanTarif) throws SupOrdHanException{
		PlanTarifarioDTO resultado = null;
		try{
			logger.debug("obtenerDatosPlanTarifario():start");
			resultado = service1.obtenerDatosPlanTarifario(codPlanTarif);
			logger.debug("obtenerDatosPlanTarifario():end");
		} catch(SupOrdHanException e){
			logger.debug("SupOrdHanException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return resultado;	
	}
}
