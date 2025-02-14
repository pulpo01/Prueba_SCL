/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 29/11/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.cl.scl.frameworkcargos.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.helper.Global;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.srv.gcc.GestionCargosRegistrarSrvFactory;
import com.tmmas.cl.scl.frameworkcargos.srv.gcc.interfaces.GestionCargosRegistrarSrvFactoryIF;
import com.tmmas.cl.scl.frameworkcargos.srv.gcc.interfaces.GestionCargosRegistrarSrvIF;
import com.tmmas.cl.scl.frameworkcargos.srv.gcd.GestionCargosDescuentosSrvFactory;
import com.tmmas.cl.scl.frameworkcargos.srv.gcd.interfaces.GestionCargosDescuentosSrvFactoryIF;
import com.tmmas.cl.scl.frameworkcargos.srv.gcd.interfaces.GestionCargosDescuentosSrvIF;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaListaDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaPlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.ListasDTO;
import com.tmmas.cl.scl.socketps.common.dto.PlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.cl.scl.socketps.common.exception.SocketPSException;
import com.tmmas.cl.scl.socketps.service.servicios.ConsultaSrvFactory;
import com.tmmas.cl.scl.socketps.service.servicios.interfaces.ConsultaSrvFactoryIT;
import com.tmmas.cl.scl.socketps.service.servicios.interfaces.ConsultaSrvIT;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosEjecucionFacturacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioEquipoNuevoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="FrmkCargosFacade"	
 *           description="An EJB named FrmkCargosFacade"
 *           display-name="FrmkCargosFacade"
 *           jndi-name="FrmkCargosFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class FrmkCargosFacadeBean implements javax.ejb.SessionBean {

	private final Logger logger = Logger.getLogger(FrmkCargosFacadeBean.class);
	private Global global = Global.getInstance();
	private SessionContext context=null;
	
//	Instancia el factory
	GestionCargosDescuentosSrvFactoryIF factorySrv1 = new GestionCargosDescuentosSrvFactory();
	GestionCargosRegistrarSrvFactoryIF gestionCargosRegistrarSrvFactoryIF = new GestionCargosRegistrarSrvFactory();
	
	//Obtiene el application service
	GestionCargosDescuentosSrvIF service1 = factorySrv1.getApplicationService1();
	GestionCargosRegistrarSrvIF srv = gestionCargosRegistrarSrvFactoryIF.getApplicationService1();
	
	private ConsultaSrvFactoryIT consultaFactorySrv = new ConsultaSrvFactory();
	private ConsultaSrvIT consultaSrv = consultaFactorySrv.getApplicationServiceConsulta();	
	
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
		this.context=arg0;
	}

	/**
	 * 
	 */
	public FrmkCargosFacadeBean() {
		// TODO Auto-generated constructor stub
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
	public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)throws FrmkCargosException {
		
		ObtencionCargosDTO resultado = null;
			
			try{
					
				logger.debug("obtenerCargos():start");
				resultado = service1.obtenerCargos(parametros);
				logger.debug("obtenerCargos():end");
			} catch(FrmkCargosException e){
				logger.debug("FrmkCargosException[", e);
				context.setRollbackOnly();
				throw e;
			} catch (Exception e) {
				logger.debug("Exception[", e);
				throw new FrmkCargosException(e);
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
	
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO cargos) throws FrmkCargosException{
		
		ResultadoRegCargosDTO retValue = null;
		try{
			
			logger.debug("registrarCargos():start");
			retValue = srv.parametrosRegistrarCargos(cargos);
			logger.debug("registrarCargos():end");
		} catch(FrmkCargosException e){
			logger.debug("ProyectoException[", e);
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
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
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws FrmkCargosException{
		RetornoDTO retorno;
		logger.debug("Inicio:registraCargosBatch()");
		try {
			retorno = srv.registraCargosBatch(registro);
		} catch (FrmkCargosException e) {
			context.setRollbackOnly();
			throw new FrmkCargosException(e.getMessage(),e.getCause());
		}
		logger.debug("Fin:registraCargosBatch()");
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
	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO resultadoObtenerCargos) throws FrmkCargosException{
		
		RegCargosDTO retValue = null;
		try{
			logger.debug("construirRegistroCargos():start");
			retValue = srv.construirRegistroCargos(resultadoObtenerCargos);
			logger.debug("construirRegistroCargos():end");
		} catch(FrmkCargosException e){
			logger.debug("FrmkCargosException[", e);
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
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
	public void cierreVenta(GaVentasDTO gaVentasDTO) throws FrmkCargosException{
		try{
			logger.debug("cierreVenta():start");
			srv.cierreVenta(gaVentasDTO);
			logger.debug("cierreVenta():end");
		} catch(FrmkCargosException e){
			logger.debug("FrmkCargosException[", e);
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
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
	public ListasDTO consultaLista(ConsultaListaDTO consultaLista) throws SocketPSException, RemoteException {
		
		ListasDTO lista;
		try {
			logger.debug("consultaLista():start");
			lista = consultaSrv.consultaLista(consultaLista);
			logger.debug("consultaLista():end");
		} catch (SocketPSException e) {
			logger.debug("SocketPSException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SocketPSException(e);
		}		
		return lista;
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
	public PlanDTO consultaPlan(ConsultaPlanDTO consultaPlan) throws SocketPSException, RemoteException {
		
		PlanDTO plan;
		try {
			logger.debug("consultaPlan():start");
			plan = consultaSrv.consultaPlan(consultaPlan);
			logger.debug("consultaPlan():end");
		} catch (SocketPSException e) {
			logger.debug("SocketPSException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SocketPSException(e);
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
	public SaldoDTO consultaSaldo(ConsultaSaldoDTO consultaSaldo) throws SocketPSException, RemoteException {
		
		SaldoDTO saldo;
		try {
			logger.debug("consultaSaldo():start");		
			saldo = consultaSrv.consultaSaldo(consultaSaldo);
			logger.debug("consultaSaldo():end");
		} catch (SocketPSException e) {
			logger.debug("SocketPSException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SocketPSException(e);
		}	
		return saldo;
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
	
	public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO terminalDTO)throws GeneralException,RemoteException{
		logger.debug("getRecPrecioEquipoActual: start");
		PrecioTerminalDTO  precioTerminalDTO=null;
		try{
			
			precioTerminalDTO=service1.getRecPrecioEquipoActual(terminalDTO);
			logger.debug("getRecPrecioEquipoActual: end");
		}catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw (e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		
		logger.debug("getRecPrecioEquipoActual: end");
		return precioTerminalDTO;
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
	public PrecioTerminalDTO getRecPrecioEquipoNuevo(PrecioEquipoNuevoDTO precioEquipoNuevoDTO)throws GeneralException,RemoteException{
		
		logger.debug("getRecPrecioEquipoNuevo: start");
		
		PrecioTerminalDTO  precioTerminalDTO=null;
		
		try{
			
			precioTerminalDTO=service1.getRecPrecioEquipoNuevo(precioEquipoNuevoDTO);
			logger.debug("getRecPrecioEquipoActual: end");
			
		}catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw (e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}	
		
		logger.debug("getRecPrecioEquipoNuevo: end");
		return precioTerminalDTO;
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
	public void actualizaFacturacion(ParametrosEjecucionFacturacionDTO parametrosEjecucion) throws FrmkCargosException{	
		try {
			logger.debug("actualizaFacturacion():start");		
			srv.actualizaFacturacion(parametrosEjecucion);
			logger.debug("actualizaFacturacion():end");
		} catch (FrmkCargosException e) {
			logger.debug("FrmkCargosException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
	}
		
}
