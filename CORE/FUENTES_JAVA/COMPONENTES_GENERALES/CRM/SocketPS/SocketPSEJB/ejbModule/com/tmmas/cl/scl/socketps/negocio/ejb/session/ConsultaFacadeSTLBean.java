/**
 * 
 */
package com.tmmas.cl.scl.socketps.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.scl.socketps.common.dto.ConsultaBolsasDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaListaDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaPlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.ListasDTO;
import com.tmmas.cl.scl.socketps.common.dto.PlanDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.cl.scl.socketps.common.exception.SocketPSException;
import com.tmmas.cl.scl.socketps.negocio.ejb.helper.Global;
import com.tmmas.cl.scl.socketps.service.servicios.ConsultaSrvFactory;
import com.tmmas.cl.scl.socketps.service.servicios.interfaces.ConsultaSrvFactoryIT;
import com.tmmas.cl.scl.socketps.service.servicios.interfaces.ConsultaSrvIT;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ConsultaFacadeSTL"	
 *           description="An EJB named ConsultaFacadeSTL"
 *           display-name="ConsultaFacadeSTL"
 *           jndi-name="ConsultaFacadeSTL"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class ConsultaFacadeSTLBean implements javax.ejb.SessionBean {

	private static final long serialVersionUID = 1L;
	private SessionContext context = null;
	private ConsultaSrvFactoryIT consultaFactorySrv = new ConsultaSrvFactory();
	private ConsultaSrvIT consultaSrv = consultaFactorySrv.getApplicationServiceConsulta();
	
	private final Logger logger = Logger.getLogger(ConsultaFacadeSTLBean.class);

	private Global global = Global.getInstance();	
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
	public ListasDTO consultaLista(ConsultaListaDTO consultaLista) throws SocketPSException, RemoteException {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
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
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);	
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
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		SaldoDTO saldo;
		try {
			logger.debug("consultaSaldo():start --------SocketPSEJBEAR.ear CREADO 14/09/2009 10:45 : PV--------");		
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
	public SaldoDTO consultaBolsas(ConsultaBolsasDTO consultaBolsas) throws SocketPSException, RemoteException {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);		
		SaldoDTO saldo;
		try {
			logger.debug("consultaBolsas():start");		
			saldo = consultaSrv.consultaBolsas(consultaBolsas);
			logger.debug("consultaBolsas():end");
		} catch (SocketPSException e) {
			logger.debug("SocketPSException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SocketPSException(e);
		}	
		return saldo;
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
		this.context = arg0;

	}

	/**
	 * 
	 */
	public ConsultaFacadeSTLBean() {
		// TODO Auto-generated constructor stub
	}
}
