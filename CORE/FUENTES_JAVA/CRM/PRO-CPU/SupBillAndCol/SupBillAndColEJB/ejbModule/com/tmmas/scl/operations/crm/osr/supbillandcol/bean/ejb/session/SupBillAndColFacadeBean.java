/**
 * 
 */
package com.tmmas.scl.operations.crm.osr.supbillandcol.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.osr.supbillandcol.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.osr.supbillandcol.common.exception.SupBillAndColException;
import com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc.GestionCargosSrvFactory;
import com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc.interfaces.GestionCargosSrvFactoryIF;
import com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc.interfaces.GestionCargosSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="SupBillAndColFacade"	
 *           description="An EJB named SupBillAndColFacade"
 *           display-name="SupBillAndColFacade"
 *           jndi-name="SupBillAndColFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class SupBillAndColFacadeBean implements javax.ejb.SessionBean 
{
	private static final long serialVersionUID = 1L;
	private SessionContext context = null;	
	private final Logger logger = Logger.getLogger(SupBillAndColFacadeBean.class);	
	private Global global = Global.getInstance();
	
	private GestionCargosSrvFactoryIF factorySrv1=new GestionCargosSrvFactory();
	private GestionCargosSrvIF		  service1=factorySrv1.getApplicationService1();

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
	public CargoListDTO  obtenerDescuentos(CargoListDTO cargoList) throws SupBillAndColException
	{
		CargoListDTO resultado = null;
		try{
			logger.debug("obtenerDescuentos():start");
			resultado = service1.obtenerDescuentos(cargoList);
			logger.debug("obtenerDescuentos():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupBillAndColException(e);
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
	public CargoListDTO  obtenerCargosProductos(ProductoOfertadoListDTO prodOfeProdList) throws SupBillAndColException
	{
		CargoListDTO resultado = null;
		try{
			logger.debug("obtenerCargosProductos():start");
			resultado = service1.obtenerCargosProductos(prodOfeProdList);
			logger.debug("obtenerCargosProductos():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupBillAndColException(e);
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
		// TODO Auto-generated method stub
			this.context=arg0;
	}

	/**
	 * 
	 */
	public SupBillAndColFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
