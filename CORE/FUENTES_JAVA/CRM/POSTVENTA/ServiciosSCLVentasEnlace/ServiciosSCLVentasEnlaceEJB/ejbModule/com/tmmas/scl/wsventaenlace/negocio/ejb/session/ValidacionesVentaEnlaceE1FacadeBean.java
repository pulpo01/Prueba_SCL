/**
 * 
 */
package com.tmmas.scl.wsventaenlace.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.service.servicios.ValidacionesVentaEnlaceE1Srv;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!-- begin-xdoclet-definition -->
 * 
 * @ejb.bean name="ValidacionesVentaEnlaceE1Facade" description="An EJB named ValidacionesVentaEnlaceE1Facade" display-name="ValidacionesVentaEnlaceE1Facade" jndi-name="ValidacionesVentaEnlaceE1Facade" type="Stateless" transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition -->
 * @generated
 */

public abstract class ValidacionesVentaEnlaceE1FacadeBean implements javax.ejb.SessionBean {
	private LoggerHelper logger = LoggerHelper.getInstance();
	private static final String nombreClase = ValidacionesVentaEnlaceE1FacadeBean.class.getName();
	private ValidacionesVentaEnlaceE1Srv ventaEnlaceE1Srv = new ValidacionesVentaEnlaceE1Srv();
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
	public ValidacionesVentaEnlaceE1FacadeBean() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * Metodo que coordina distintos servicios para la obtención de los datos actuales del cliente informado
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @throws ServicioVentasEnlaceException
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 */
	public OOSSDTO validaAbonadoVPN(OOSSDTO oOSSDTO) throws ServicioVentasEnlaceException {
		logger.info("validaAbonadoVPN():start", nombreClase);
		try {
			oOSSDTO = ventaEnlaceE1Srv.validaAbonadoVPN(oOSSDTO);
		} catch (Throwable e) {
			if (!(e instanceof ServicioVentasEnlaceException)) {
				throw new ServicioVentasEnlaceException(e);
			} else
				throw (ServicioVentasEnlaceException) e;
		}
		logger.info("validaAbonadoVPN():end", nombreClase);
		return oOSSDTO;
	}
}
