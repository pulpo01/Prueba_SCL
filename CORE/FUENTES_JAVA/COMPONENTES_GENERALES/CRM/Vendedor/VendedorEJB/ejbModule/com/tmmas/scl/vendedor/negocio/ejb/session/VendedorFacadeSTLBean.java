/**
 * 
 */
package com.tmmas.scl.vendedor.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.vendedor.dto.ConfiguracionVendedorCPUDTO;
import com.tmmas.scl.vendedor.dto.UsuarioSistemaDTO;
import com.tmmas.scl.vendedor.dto.UsuarioVendedorDTO;
import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.vendedor.exception.VendedorException;
import com.tmmas.scl.vendedor.negocio.ejb.session.dao.VendedorDAO;
import com.tmmas.scl.vendedor.negocio.ejb.session.helper.Global;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="VendedorFacadeSTL"	
 *           description="An EJB named VendedorFacadeSTL"
 *           display-name="VendedorFacadeSTL"
 *           jndi-name="VendedorFacadeSTL"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class VendedorFacadeSTLBean implements javax.ejb.SessionBean {

	private static final long serialVersionUID = 1L;
	private VendedorDAO vendedorDAO = new VendedorDAO();
	private final Logger logger = Logger.getLogger(VendedorFacadeSTLBean.class);
	private Global global = Global.getInstance();
	private SessionContext context = null;

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
	 * Recupera la informacion del vendedor
	 * @param vendedor
	 * @return
	 * @throws VendedorException
	 */	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public VendedorDTO recuperarInformacionVendedor(VendedorDTO vendedor) throws VendedorException  {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("recuperarInformacionVendedor():start");		
		VendedorDTO resultado = vendedorDAO.recuperarInformacionVendedor(vendedor);
		logger.debug("recuperarInformacionVendedor():end");
		return resultado;
	}
	
	/**
	 * Guarda la informacion del vendedor
	 * @param vendedor
	 * @throws VendedorException
	 */	
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public void registrarInformacionVendedor(VendedorDTO vendedor) throws VendedorException {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("registrarInformacionVendedor():start");		
		try {
			logger.debug("registrarInformacionVendedor:antes");
			vendedorDAO.registrarInformacionVendedor(vendedor);
			logger.debug("registrarInformacionVendedor:despues");
		} catch (VendedorException e) {
			logger.debug("VendedorException", e);
			context.setRollbackOnly();
			throw e;
		}
		logger.debug("registrarInformacionVendedor():end");
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
	public ConfiguracionVendedorCPUDTO  recuperarConfiguracionVendedorCPU(ConfiguracionVendedorCPUDTO config) throws VendedorException {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("recuperarConfiguracionVendedorCPU():start VSN 080709 OC");	
		ConfiguracionVendedorCPUDTO resultado = null;
		try {
			logger.debug("recuperarConfiguracionVendedorCPU:antes");
			resultado = vendedorDAO.recuperarConfiguracionVendedorCPU(config);
			logger.debug("recuperarConfiguracionVendedorCPU:despues");
		} catch (VendedorException e) {
			logger.debug("VendedorException", e);
			context.setRollbackOnly();
			throw e;
		}
		logger.debug("recuperarConfiguracionVendedorCPU():end");	
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
	public UsuarioVendedorDTO  obtenerInformacionUsuarioVendedor(UsuarioSistemaDTO usuarioSistema) throws VendedorException {
		String log = global.getValor("negocio.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("obtenerInformacionUsuarioVendedor():start");	
		UsuarioVendedorDTO resultado = null;
		try {
			logger.debug("obtenerInformacionUsuarioVendedor:antes");
			resultado = vendedorDAO.obtenerInformacionUsuarioVendedor(usuarioSistema);
			logger.debug("obtenerInformacionUsuarioVendedor:despues");
		} catch (VendedorException e) {
			logger.debug("VendedorException", e);
			context.setRollbackOnly();
			throw e;
		}
		logger.debug("obtenerInformacionUsuarioVendedor():end");	
		return resultado;
	}	
	/**
	 * 
	 */
	public VendedorFacadeSTLBean() {
		// TODO Auto-generated constructor stub
	}

	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}

	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}

	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub
		
	}

	public void setSessionContext(SessionContext arg0) throws EJBException, RemoteException {
		context = arg0;
		
	}
}
