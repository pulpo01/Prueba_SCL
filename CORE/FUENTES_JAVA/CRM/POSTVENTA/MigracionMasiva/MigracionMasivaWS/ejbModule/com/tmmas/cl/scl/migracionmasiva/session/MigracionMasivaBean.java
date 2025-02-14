/**
 * 
 */
package com.tmmas.cl.scl.migracionmasiva.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.migraciomasiva.srv.MigracionSrv;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosEntradaDTO;
import com.tmmas.cl.scl.migracionmasiva.dto.WSDatosSalidaDTO;
import com.tmmas.cl.scl.migracionmasiva.helper.LoggerHelper;
import com.tmmas.cl.scl.migracionmasiva.validaciones.Validaciones;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="MigracionMasiva"	
 *           description="An EJB named MigracionMasiva"
 *           display-name="MigracionMasiva"
 *           jndi-name="MigracionMasiva"
 *           type="Stateless" 
 *           transaction-type="Container"
 *           view-type="remote"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class MigracionMasivaBean implements javax.ejb.SessionBean {

	MigracionSrv migSrv= new MigracionSrv();
	private CompositeConfiguration config;

	
	 private final LoggerHelper logger = LoggerHelper.getInstance();
	 private final String nombreClase = this.getClass().getName();
	 

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

	}

	/**
	 * 
	 */
	public MigracionMasivaBean() {
		System.out.println("MigracionMasivaBean(): Start");
		logger.debug("MigracionMasivaBean():Start",nombreClase);
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
	public WSDatosSalidaDTO insertoDatosMigracion(WSDatosEntradaDTO datosDTO) throws GeneralException{
		logger.debug("insertoDatosMigracion():Start",nombreClase);
		
		Validaciones validaciones= new Validaciones();
		WSDatosSalidaDTO resp=null;
		try{
			System.out.println("1");
			resp=validaciones.validaciones(datosDTO);
			if(resp!=null){
				return resp;
			}
			System.out.println("2");
			
		resp=migSrv.insertoDatosMigracion(datosDTO);
		System.out.println("3");
		}catch(GeneralException e){
			logger.debug("Error GeneralException",nombreClase);
			throw e;
		}catch(Exception ex){
			ex.getStackTrace();
			logger.debug("Error Exception: "+ex.getMessage(),nombreClase);
		}
		logger.debug("insertoDatosMigracion():End",nombreClase);
		return resp;
	}
	
}
