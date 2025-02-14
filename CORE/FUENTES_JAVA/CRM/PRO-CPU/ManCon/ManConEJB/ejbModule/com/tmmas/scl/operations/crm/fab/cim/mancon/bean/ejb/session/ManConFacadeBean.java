/**
 * 
 */
package com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.DatosClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.IntegracionInClasificacionDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.PlanEvaluacionRiesgoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoVetadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CalificacionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ConsultaHibridoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.FiltroAbonadosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaFiltroAbonadosDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srv.GestionClienteSrvFactory;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srv.interfaces.GestionClienteSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srv.interfaces.GestionClienteSrvIF;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo.GestionAbonadoSrvFactory;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo.interfaces.GestionAbonadoSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo.interfaces.GestionAbonadoSrvIF;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta.GestionCuentaSrvFactory;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta.interfaces.GestionCuentaSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta.interfaces.GestionCuentaSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ManConFacade"	
 *           description="An EJB named ManConFacade"
 *           display-name="ManConFacade"
 *           jndi-name="ManConFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class ManConFacadeBean implements javax.ejb.SessionBean {
	
	private SessionContext context = null;
	
	private final Logger logger = Logger.getLogger(ManConFacadeBean.class);
	
	private Global global = Global.getInstance();
	
	// Instancia el factory
	GestionClienteSrvFactoryIF factorySrv1 = new GestionClienteSrvFactory();
	GestionAbonadoSrvFactoryIF factorySrv2 = new GestionAbonadoSrvFactory();
	GestionCuentaSrvFactoryIF factorySrv3 = new GestionCuentaSrvFactory();
	
	// Obtiene el application service
	GestionClienteSrvIF service1 = null;	
	GestionAbonadoSrvIF service2 = null;	
	GestionCuentaSrvIF service3 = null;
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.create-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() 
	{
		service1 = factorySrv1.getApplicationService1();	
		service2 = factorySrv2.getApplicationService1();	
		service3 = factorySrv3.getApplicationService1();
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
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws ManConException{
		ClienteDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCliente():start");
			resultado = service1.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public ClienteDTO obtenerDatosCliente(VentaDTO venta) throws ManConException{
		ClienteDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCliente():start");
			resultado = service1.buscarDatosClientePorVenta(venta);
			logger.debug("obtenerDatosCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws ManConException{
		AbonadoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonado():start");
			resultado = service2.obtenerDatosAbonado(abonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public AbonadoDTO obtenerDatosAbonado2(AbonadoDTO abonado) throws ManConException{
		AbonadoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonado():start");
			resultado = service2.obtenerDatosAbonado2(abonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public AbonadoListDTO obtenerListaAbonados(ClienteDTO cliente) throws ManConException{
	
		AbonadoListDTO abonados = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaAbonados():start");
			abonados = service2.obtenerListaAbonados(cliente);
			logger.debug("obtenerListaAbonados():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return abonados;
	}	

	/** 
	 * Obtiene lista de clientes por cuenta
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public ClienteTipoPlanListDTO obtenerDatosClienteCuenta(ClienteDTO cliente) throws ManConException{
		ClienteTipoPlanListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosClienteCuenta():start");
			resultado = service3.obtenerDatosClienteCuenta(cliente);
			logger.debug("obtenerDatosClienteCuenta():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return resultado;
	}	
	
	/** 
	 * Obtiene lista de subcuentas de la cuenta
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public SubCuentaListDTO obtenerSubCuentas(ClienteDTO cliente) throws ManConException{
		SubCuentaListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerSubCuentas():start");
			resultado = service3.obtenerSubCuentas(cliente);
			logger.debug("obtenerSubCuentas():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public ClienteListDTO buscarCliente(NumeroDTO numero) throws ManConException 
	{
		ClienteListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("buscarCliente():start");
			resultado = service1.buscarCliente(numero);
			logger.debug("buscarCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public ClienteListDTO buscarCliente(ClienteDTO cliente) throws ManConException 
	{
		ClienteListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("buscarCliente():start");
			resultado = service1.buscarCliente(cliente);
			logger.debug("buscarCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiarios(AbonadoDTO abonadoDTO)throws ManConException {
	
		AbonadoBeneficiarioListDTO abonados = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneAbonadosBeneficiarios():start");
			abonados = service2.obtieneAbonadosBeneficiarios(abonadoDTO);
			logger.debug("obtieneAbonadosBeneficiarios():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return abonados;
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
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiariosPorNumCelular(AbonadoDTO abonadoDTO)throws ManConException {
	
		AbonadoBeneficiarioListDTO abonados = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():start");
			abonados = service2.obtieneAbonadosBeneficiariosPorNumCelular(abonadoDTO);
			logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return abonados;
	}
	
	
	
	/** 
	 * Consulta hibrido
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO consultaHibrido(ConsultaHibridoDTO consulta) throws ManConException
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaHibrido():start");
			resultado = service2.consultaHibrido(consulta);
			logger.debug("consultaHibrido():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return resultado;
	}
	
	/** 
	 * Consulta hibrido
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO agregaAbonadosBeneficiarios(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO)throws ManConException {
		RetornoDTO retValue = null;
		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertAbonadosBeneficiarios():start");
			retValue = service2.agregaAbonadosBeneficiarios(abonadoBeneficiarioListDTO);
			logger.debug("insertAbonadosBeneficiarios():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		 }
		 return retValue;		
	}
	
	
	/** 
	 * Consulta hibrido
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO eliminaAbonadoBeneficiario(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO)throws ManConException {
		RetornoDTO retValue = null;
		try {
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("deleteAbonadoBeneficiario():start");
			retValue = service2.eliminaAbonadoBeneficiario(abonadoBeneficiarioListDTO);
			logger.debug("deleteAbonadoBeneficiario():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		 catch (Exception e) {
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
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
	public RetornoDTO caducaEliminaAbonadoBeneficiario(AbonadoBeneficiarioListDTO abonadoBeneficiarioList) throws ManConException
	{
		RetornoDTO retValue = null;
		try 
		{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("caducaEliminaAbonadoBeneficiario():start");
			retValue = service2.caducaEliminaAbonadoBeneficiario(abonadoBeneficiarioList);
			logger.debug("caducaEliminaAbonadoBeneficiario():end");
		}
		catch (GeneralException e) 
		{
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) 
		{
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
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
	public AbonadoDTO obtenerNumeroMovimientoAlta(AbonadoDTO abonado) throws ManConException 
	{	
		try 
		{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumeroMovimientoAlta():start");
			abonado = service2.obtenerNumeroMovimientoAlta(abonado);
			logger.debug("obtenerNumeroMovimientoAlta():end");
		}
		catch (GeneralException e) 
		{
			logger.debug("GeneralException[", e);
			throw new ManConException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) 
		{
			 logger.debug("Exception[", e);
			 throw new ManConException(e);
		}
	   return abonado;	
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
	public AbonadoDTO obtenerDatosAbonadoByNumCelular(AbonadoDTO abonado) throws ManConException{
		AbonadoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonadoByNumCelular():start");
			resultado = service2.obtenerDatosAbonadoByNumCelular(abonado);
			logger.debug("obtenerDatosAbonadoByNumCelular():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public AbonadoVetadoListDTO obtieneAbonadosVetados(AbonadoDTO abonadoDTO)throws ManConException {
	
		AbonadoVetadoListDTO abonados = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneAbonadosBeneficiarios():start");
			abonados = service2.obtieneAbonadosVetados(abonadoDTO);
			logger.debug("obtieneAbonadosBeneficiarios():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return abonados;
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
	 public int validaAbonadoBajaProgramada(long numAbonado)throws ManConException {
		 // INICIO RRG 17-02-2009 COL 78551	
		 int abonados;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaAbonadoBajaProgramada():start");
			abonados = service2.validaAbonadoBajaProgramada(numAbonado);
			logger.debug("validaAbonadoBajaProgramada():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return abonados;
		 // INICIO RRG 17-02-2009 COL 78551
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
	public RetornoDTO actualizarAbonadoVetadoTerminoVigencia(AbonadoVetadoListDTO abonadoVetadoDTO)throws ManConException {
	
		RetornoDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarAbonadoVetadoTerminoVigencia():start");
			retValue = service2.actualizarAbonadoVetadoTerminoVigencia(abonadoVetadoDTO);
			logger.debug("actualizarAbonadoVetadoTerminoVigencia():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public RetornoDTO agregarAbonadosVetados(AbonadoVetadoListDTO abonadoVetadoListDTO)throws ManConException {
	
		RetornoDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("agregarAbonadosVetados():start");
			retValue = service2.agregarAbonadosVetados(abonadoVetadoListDTO);
			logger.debug("agregarAbonadosVetados():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public RetornoDTO crearSubCuenta(SubCuentaDTO cuenta) throws ManConException{
	
		RetornoDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("crearSubCuenta():start");
			retValue = service3.crearSubCuenta(cuenta);
			logger.debug("crearSubCuenta():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public CuentaPersonalDTO obtenerNumeroPersonal(CuentaPersonalDTO cuentaPersonalDTO) throws ManConException{
	
		CuentaPersonalDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumeroPersonal():start");
			retValue = service2.obtenerNumeroPersonal(cuentaPersonalDTO);
			logger.debug("obtenerNumeroPersonal():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public int obtenerInfoPer(CuentaPersonalDTO cuentaPersonalDTO) throws ManConException{
	
		int retValue = 0;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerInfoPer():start");
			retValue = service3.obtenerInfoPer(cuentaPersonalDTO);
			logger.debug("obtenerInfoPer():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public int validaPersonal(CuentaPersonalDTO cuentaPersonalDTO) throws ManConException{
	
		int retValue = 0;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaPersonal():start");
			retValue = service3.validaPersonal(cuentaPersonalDTO);
			logger.debug("validaPersonal():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public int validaAtlantida(AbonadoDTO abonado)throws ManConException{
	
		int retValue = 0;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaAtlantida():start");
			retValue = service1.validaAtlantida(abonado);
			logger.debug("validaAtlantida():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public int validaAtlantidaCliente(ClienteDTO cliente)throws ManConException{
	
		int retValue = 0;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaAtlantidaCliente():start");
			retValue = service1.validaAtlantidaCliente(cliente);
			logger.debug("validaAtlantidaCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public ClienteDTO obtenerCliente(CuentaPersonalDTO cuentaPersonalDTO) throws ManConException{
	
		ClienteDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerCliente():start");
			retValue = service1.obtenerCliente(cuentaPersonalDTO);
			logger.debug("obtenerCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public AbonadoListDTO obtenerListaAbonadosFiltrados(FiltroAbonadosDTO filtro) throws ManConException{
	
		AbonadoListDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerListaAbonadosFiltrados():start");
			retValue = service2.obtenerListaAbonadosFiltrados(filtro);
			logger.debug("obtenerListaAbonadosFiltrados():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public RetornoDTO validaFiltroAbonados(ValidaFiltroAbonadosDTO filtro) throws ManConException{
		RetornoDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaFiltroAbonados():start");
			retValue = service2.validaFiltroAbonados(filtro);
			logger.debug("validaFiltroAbonados():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public ClienteDTO obtenerNumAbonadosCliente(ClienteDTO cliente) throws ManConException{
		ClienteDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumAbonadosCliente():start");
			retValue = service1.obtenerNumAbonadosCliente(cliente);
			logger.debug("obtenerNumAbonadosCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public AbonadoDTO obtenerAbonadoEmpresa(ClienteDTO cliente) throws ManConException{
		AbonadoDTO abonado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerAbonadoEmpresa():start");
			abonado = service2.obtenerAbonadoEmpresa(cliente);
			logger.debug("obtenerAbonadoEmpresa():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return abonado;	
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
	public AbonadoListDTO obtieneBloqueAbonados(FiltroAbonadosDTO bloque) throws ManConException{
		AbonadoListDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneBloqueAbonados():start");
			retValue = service2.obtieneBloqueAbonados(bloque);
			logger.debug("obtieneBloqueAbonados():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public RetornoDTO actualizarLineasPorPlan(PlanEvaluacionRiesgoDTO planEval) throws ManConException {
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarLineasPorPlan():start");
			resultado = service1.actualizarLineasPorPlan(planEval);
			logger.debug("actualizarLineasPorPlan():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public Long obtenerNumClientesCuenta(ClienteDTO cliente)throws ManConException{
		Long resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerNumClientesCuenta():start");
			resultado = service3.obtenerNumClientesCuenta(cliente);
			logger.debug("obtenerNumClientesCuenta():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public ClienteListDTO listarClientesCuenta(ClienteDTO cliente)throws ManConException{
		ClienteListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("listarClientesCuenta():start");
			resultado = service3.listarClientesCuenta(cliente);
			logger.debug("listarClientesCuenta():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public DatosClienteDTO obtenerDatosAdicCliente(Long codCliente) throws ManConException{
		DatosClienteDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAdicCliente():start");
			resultado = service1.obtenerDatosAdicCliente(codCliente);
			logger.debug("obtenerDatosAdicCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return resultado;			
	}

	/**
	 * @ejb.interface-method view-type="remote" 
	 */
	public IntegracionInClasificacionDTO consultaClasificacionCliente(IntegracionInClasificacionDTO integracionInClasificacionDTO) throws ManConException
	{
		IntegracionInClasificacionDTO retValue = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("consultaClasificacionCliente():start");
			retValue = service1.consultaClasificacionCliente(integracionInClasificacionDTO);
			logger.debug("consultaClasificacionCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
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
	public ClienteDTO getCliente(ClienteDTO cliente) throws ManConException{
		ClienteDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("getCliente():start");
			resultado = service1.getCliente(cliente);
			logger.debug("getCliente():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return resultado;
	}
	
	/**
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CalificacionAbonadoDTO obtieneCalificacionAbonado(CalificacionAbonadoDTO abonado) throws ManConException{
		CalificacionAbonadoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtieneCalificacionAbonado():start");
			resultado = service2.obtieneCalificacionAbonado(abonado);
			logger.debug("obtieneCalificacionAbonado():end");
		} catch(ManConException e){
			logger.debug("ManConException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManConException(e);
		}
		return resultado;
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
		this.context=arg0;

	}

	/**
	 * 
	 */
	public ManConFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
