/**
 * 
 */
package com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.common.exception.ManCusBilException;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv.GestionCargosRegistrarSrvFactory;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv.interfaces.GestionCargosRegistrarSrvFactoryIF;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv.interfaces.GestionCargosRegistrarSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ManCusBilFacade"	
 *           description="An EJB named ManCusBilFacade"
 *           display-name="ManCusBilFacade"
 *           jndi-name="ManCusBilFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class ManCusBilFacadeBean implements javax.ejb.SessionBean {
	
	private SessionContext context=null;
	
	private final  Logger logger = Logger.getLogger(ManCusBilFacadeBean.class);
	
	private Global global=Global.getInstance();
	
	//Instancia el factory
	GestionCargosRegistrarSrvFactoryIF gestionCargosRegistrarSrvFactoryIF = new GestionCargosRegistrarSrvFactory();

	//Obtiene el application service
	GestionCargosRegistrarSrvIF srv = gestionCargosRegistrarSrvFactoryIF.getApplicationService1();
	
	
	
	
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
	
	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO resultadoObtenerCargos) throws ManCusBilException{
		
		RegCargosDTO retValue = null;
		try{
				
			logger.debug("construirRegistroCargos():start");
			retValue = srv.construirRegistroCargos(resultadoObtenerCargos);
			logger.debug("construirRegistroCargos():end");
		} catch(ManCusBilException e){
			logger.debug("ManCusBilException[", e);
			context.setRollbackOnly();
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManCusBilException(e);
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
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws ManCusBilException{
		RetornoDTO retorno;
		logger.debug("Inicio:registraCargosBatch()");
		try {
			retorno = srv.registraCargosBatch(registro);
		} catch (ManCusBilException e) {
			throw new ManCusBilException(e.getMessage(),e.getCause());
		}
		logger.debug("Fin:registraCargosBatch()");
		return retorno;
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

	/**
	 * 
	 */
	public ManCusBilFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
