/**
 * 
 */
package com.tmmas.scl.operations.crm.f.sel.negsal.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.f.sel.negsal.interfaces.GestionPresupuestoSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.sel.negsal.interfaces.GestionPresupuestoSrvIF;
import com.tmmas.scl.operations.crm.f.sel.negsal.srv.GestionPresupuestoSrvFactory;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="NegSalFacade"	
 *           description="An EJB named NegSalFacade"
 *           display-name="NegSalFacade"
 *           jndi-name="NegSalFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class NegSalFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	
	private final Logger logger = Logger.getLogger(NegSalFacadeBean.class);
	
	private Global global = Global.getInstance();
	
	// Instancia el factory
	GestionPresupuestoSrvFactoryIF factorySrv1 = new GestionPresupuestoSrvFactory();

	// Obtiene el application service
	GestionPresupuestoSrvIF service1 = factorySrv1.getApplicationService1();	
	
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
     * Este método es responsable del registro de una venta.
	 * @param venta objeto del tipo IngresoVentaDTO donde se definen los diversos atributos necesarios para el registro de la venta.
	 *        Código del cliente, número de contrato, código de vendedor, etc.
	 * @return RetornoDTO. Objeto que contiene el código de error de la operación y la descripción del código de error. 
	 * 		   Si el código es 0 la operación se efectuó con éxito. 
	 * @throws NegSalException 
 	 * @see com.tmmas.scl.operations.crm.f.sel.negsal.interfaces.GestionPresupuestoSrvIF;
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO registrarVenta(IngresoVentaDTO venta) throws NegSalException{
		RetornoDTO resultado = null;
		try{
					
			logger.debug("registrarVenta():start");
			resultado = service1.registrarVenta(venta);
			logger.debug("registrarVenta():end");
		} catch(NegSalException e){
			logger.debug("NegSalException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new NegSalException(e);
		}
		return resultado;		
		
	}

	
	/** 
	 * Este método es responsable de generar a partir de un objeto VentaDTO una oferta comercial.
	 * @param venta objeto VentaDTO que contiene la información del Cliente (ClienteDTO), el código del vendedor y el resto de los
	 * 		  atributos que identifican la Venta.
	 * @throws NegSalException 
 	 * @see com.tmmas.scl.operations.crm.f.sel.negsal.interfaces.GestionPresupuestoSrvIF;
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public OfertaComercialDTO generarOfertaComercial(VentaDTO venta) throws NegSalException{
		OfertaComercialDTO resultado = null;
		try{
					
			logger.debug("generarOfertaComercial():start");
			NegSalUtils negSalUtils = NegSalUtils.getInstance();
			resultado = negSalUtils.generarOfertaComercial(venta);
			logger.debug("generarOfertaComercial():end");
		} catch(NegSalException e){
			logger.debug("NegSalException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new NegSalException(e);
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
	public NegSalFacadeBean() {
		// TODO Auto-generated constructor stub
	}
}
