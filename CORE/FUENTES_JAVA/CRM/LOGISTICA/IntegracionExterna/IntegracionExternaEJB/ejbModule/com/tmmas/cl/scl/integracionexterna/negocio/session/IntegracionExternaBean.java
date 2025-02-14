/**
 * 
 */
package com.tmmas.cl.scl.integracionexterna.negocio.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionexterna.srv.TraspasoMasivoSRV;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="IntegracionExterna"	
 *           description="An EJB named IntegracionExterna"
 *           display-name="IntegracionExterna"
 *           jndi-name="IntegracionExterna"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public abstract class IntegracionExternaBean implements javax.ejb.SessionBean {
	
	private final LoggerHelper logger = LoggerHelper.getInstance();	
	private TraspasoMasivoSRV traspasoMasivoSRV;

	/** 
	 * <!-- begin-xdoclet-definition --> 
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 */
	private static final long serialVersionUID = 1L;

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
	public IntegracionExternaBean() {
		// TODO Auto-generated constructor stub
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean method stub
	 */
	public void insertaTraspasoOP(String numTraspaso, String numSecuencia, String codEstado) throws IntegracionExternaException, Exception{
		loggerDebug("insertaTraspasoOP: inicio");
		loggerDebug("numTraspaso: "+ numTraspaso);
		loggerDebug("numSecuencia: "+ numSecuencia);
		loggerDebug("codEstado: "+ codEstado);
		try{
			traspasoMasivoSRV = new TraspasoMasivoSRV();
			traspasoMasivoSRV.insertaTraspasoOP(numTraspaso, numSecuencia, codEstado);
		}catch(IntegracionExternaException e){
			loggerDebug("IntegracionExternaException: " + e.getLocalizedMessage());
			loggerDebug("IntegracionExternaException: " + e);
            throw e;
		}catch(Exception e){
			loggerDebug("Exception: " + e.getLocalizedMessage());
			loggerDebug("Exception: " + e);
            throw e;
		}
		
		loggerDebug("insertaTraspasoOP: fin");
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean method stub
	 */
	public boolean validaTraspOP(String numSecuencia) throws IntegracionExternaException, Exception{
		loggerDebug("validaTraspOP: inicio");
		traspasoMasivoSRV = new TraspasoMasivoSRV();
		boolean resultado = traspasoMasivoSRV.validaTraspOP(numSecuencia);
		loggerDebug("validaTraspOP: fin");
		return resultado;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean method stub
	 */
	public void actualizaTraspasoOP(String numTraspaso, String numSecuencia, String codEstado) throws IntegracionExternaException, Exception{
		loggerDebug("actualizaTraspasoOP: inicio");
		traspasoMasivoSRV = new TraspasoMasivoSRV();
		traspasoMasivoSRV.actualizaTraspasoOP(numTraspaso, numSecuencia, codEstado);
		loggerDebug("actualizaTraspasoOP: fin");
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean method stub
	 */
	public SalidaConsultaTraspasoDTO consultaEstadoTraspOP(String numSecuencia) throws IntegracionExternaException, Exception{
		loggerDebug("consultaEstadoTraspOP: Inicio");
		traspasoMasivoSRV = new TraspasoMasivoSRV();
		SalidaConsultaTraspasoDTO respuesta = traspasoMasivoSRV.consultaEstadoTraspOP(numSecuencia);
		loggerDebug("consultaEstadoTraspOP: Fin");
		return respuesta;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean method stub
	 */
	public boolean validaBodegaDTS(String codCliente, String codBodega) throws IntegracionExternaException, Exception{
		loggerDebug("validaBodegaDTS: inicio");
		traspasoMasivoSRV = new TraspasoMasivoSRV();
		boolean resultado = traspasoMasivoSRV.validaBodegaDTS(codCliente, codBodega);
		loggerDebug("validaBodegaDTS: fin");
		return resultado;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean method stub
	 */
	public String consultaParametros(String nomParametro, String codModulo, String codProducto) throws IntegracionExternaException, Exception{
		loggerDebug("consultaParametros: inicio");
		traspasoMasivoSRV = new TraspasoMasivoSRV();
		String resultado = traspasoMasivoSRV.consultaParametros(nomParametro, codModulo, codProducto);
		loggerDebug("consultaParametros: fin");
		return resultado;
	}
	
	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="both"
	 * @ejb.transaction type="Required" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean method stub
	 */
	public void eliminaTraspasoMasivo(String nomTraspasoMasivo) throws IntegracionExternaException{
		loggerDebug("eliminaTraspasoMasivo: inicio");
		traspasoMasivoSRV = new TraspasoMasivoSRV();
		traspasoMasivoSRV.eliminaTraspasoMasivo(nomTraspasoMasivo);
		loggerDebug("eliminaTraspasoMasivo: fin");
	}
	
	// Metodos utulitarios de la clase
	public void loggerDebug(String mensaje) {
		logger.debug(mensaje, this.getClass().getName());
	}

	public void loggerInfo(String mensaje) {
		logger.info(mensaje, this.getClass().getName());
	}

	public void loggerError(String mensaje) {
		logger.error(mensaje, this.getClass().getName());
	}
}
