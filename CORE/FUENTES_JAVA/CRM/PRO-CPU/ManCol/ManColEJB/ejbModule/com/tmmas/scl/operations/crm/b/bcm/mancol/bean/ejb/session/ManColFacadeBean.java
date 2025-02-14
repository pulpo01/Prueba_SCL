/**
 * 
 */
package com.tmmas.scl.operations.crm.b.bcm.mancol.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.operations.crm.b.bcm.mancol.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.b.bcm.mancol.common.exception.ManColException;
import com.tmmas.scl.operations.crm.b.bcm.mancol.srv.GestionRecopilacionInformacionSrvFactory;
import com.tmmas.scl.operations.crm.b.bcm.mancol.srv.interfaces.GestionRecopilacionInformacionSrvFactoryIF;
import com.tmmas.scl.operations.crm.b.bcm.mancol.srv.interfaces.GestionRecopilacionInformacionSrvIF;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="ManColFacade"	
 *           description="An EJB named ManColFacade"
 *           display-name="ManColFacade"
 *           jndi-name="ManColFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class ManColFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	private final Logger logger = Logger.getLogger(ManColFacadeBean.class);
	private Global global = Global.getInstance();
	
	//Instancia el factory
	GestionRecopilacionInformacionSrvFactoryIF factorySrv1 = new GestionRecopilacionInformacionSrvFactory();
	
	//Obtiene el application service
	GestionRecopilacionInformacionSrvIF service1 = factorySrv1.getApplicationService1();
	
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

	/** 
	 * Obtiene los tipos de documentos
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public DocumentoListDTO obtenerTiposDocumentos(BusquedaTiposDocumentoDTO param) throws ManColException{
		DocumentoListDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerTiposDocumentos():start");
			resultado = service1.obtenerTiposDocumentos(param);
			logger.debug("obtenerTiposDocumentos():end");
		} catch(ManColException e){
			logger.debug("ManColException[", e);
			throw new ManColException(e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManColException(e);
		}
	return resultado;
	}

	/** 
	 * Obtiene lista de formas de pago 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public FormaPagoListDTO obtenerFormasPago(BusquedaFormasPagoDTO param) throws ManColException{
		FormaPagoListDTO resultado = null;
		
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log ;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerFormasPago():start");
			resultado = service1.obtenerFormasPago(param );
			logger.debug("obtenerFormasPago():end");
		} catch(ManColException e){
			logger.debug("ManColException[", e);
			throw new ManColException(e);
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManColException(e);
		}
		return resultado;		
	}
	
	/** 
	 * Obtiene numero de cuotas 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CuotasProductoDTO[] obtenerCuotasProducto() throws ManColException{
		String log = global.getValor("negocio.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerCuotasProducto():start");
		
		CuotasProductoDTO[] cuotasProducto = null;
		
		try{
			cuotasProducto = service1.obtenerCuotasProducto();
		} catch(ManColException e){
			logger.debug("ManColException[", e);
			throw new ManColException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManColException(e);
		}
		logger.debug("obtenerCuotasProducto():end");
		return cuotasProducto;		
	}
	
	/** 
	 * Obtiene numero de cuotas 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public int obtenerInfoAtl(CuentaPersonalDTO cuentaPersonalDTO) throws ManColException{
		int retorno = 0;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerInfoAtl():start");
			
			retorno = service1.obtenerInfoAtl(cuentaPersonalDTO);
			logger.debug("obtenerInfoAtl():end");
		} catch(ManColException e){
			logger.debug("ManColException[", e);
			throw new ManColException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManColException(e);
		}
		
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

	}

	/**
	 * 
	 */
	public ManColFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
