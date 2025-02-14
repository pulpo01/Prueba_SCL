/**
 * 
 */
package com.tmmas.scl.wsventaenlace.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.service.servicios.AsociaDesasociaRangoSrv;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!-- begin-xdoclet-definition -->
 * 
 * @ejb.bean name="AsociaRangoFacade" description="An EJB named AsociaRangoFacade" display-name="AsociaRangoFacade" jndi-name="AsociaRangoFacade" type="Stateless" transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition -->
 * @generated
 */

public abstract class AsociaRangoFacadeBean implements javax.ejb.SessionBean {
	private AsociaDesasociaRangoSrv asociaRangoSrv = new AsociaDesasociaRangoSrv();
	private static LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private SessionContext context = null;

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.create-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 * //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException, RemoteException {
		context = arg0;
	}

	/**
	 * 
	 */
	public AsociaRangoFacadeBean() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @throws ServicioVentasEnlaceException
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 */
	public OOSSDTO cargaGenericaDatos(OOSSDTO oOSSDTO) throws ServicioVentasEnlaceException {
		logger.info("comenzando...", this.getClass().getName());

		try {
			oOSSDTO = asociaRangoSrv.cargaGenericaDatos(oOSSDTO);
		} catch (Throwable e) {
			logger.error(e, this.getClass().getName());

			if (!(e instanceof ServicioVentasEnlaceException))
				throw new ServicioVentasEnlaceException(e);
			else
				throw (ServicioVentasEnlaceException) e;
		}

		logger.info("cargaGenericaDatos():end", nombreClase);

		return oOSSDTO;
	}
}
