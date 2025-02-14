/**
 * 
 */
package com.tmmas.cl.scl.direccion.negocio.ejb.session;

import java.rmi.RemoteException;
import java.util.List;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.CodigoPostalDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.DireccionDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.direccion.service.servicios.DireccionSrv;
import com.tmmas.cl.scl.direccioncommon.commonapp.exception.DireccionException;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="DireccionFacadeSTL"	
 *           description="An EJB named DireccionFacadeSTL"
 *           display-name="DireccionFacadeSTL"
 *           jndi-name="DireccionFacadeSTL"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class DireccionFacadeSTLBean implements javax.ejb.SessionBean {
	
private static final long serialVersionUID = 1L;
	
	private DireccionSrv srv = new DireccionSrv();
	private final Logger logger = Logger.getLogger(DireccionFacadeSTLBean.class);
	private SessionContext context = null;
	private CompositeConfiguration config;
	
	
	

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

	public DireccionDTO getDatosDireccion(DireccionDTO direccionDTO)
	throws DireccionException,RemoteException{
		logger.debug("getDatosDireccion():start");
		DireccionDTO direccionDTO2 = null;
		
		try{
			direccionDTO2 = srv.getDatosDireccion(direccionDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getDatosDireccion():end");
		return direccionDTO2;
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

	public ProvinciaDireccionDTO getProvincias(ProvinciaDireccionDTO provinciaDireccionDTO)
	throws DireccionException,RemoteException{
		logger.debug("getProvincias():start");
		ProvinciaDireccionDTO provinciaDireccionDTO2 = null;
		
		try{
			provinciaDireccionDTO2 = srv.getProvincia(provinciaDireccionDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getProvincias():end");
		return provinciaDireccionDTO2;
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
	public CiudadDireccionDTO getCiudades(CiudadDireccionDTO ciudadDireccionDTO)
	throws DireccionException,RemoteException{
		logger.debug("getCiudades():start");
		CiudadDireccionDTO ciudadDireccionDTO2 = null;
		
		try{
			ciudadDireccionDTO2 = srv.getCiudad(ciudadDireccionDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getCiudades():end");
		return ciudadDireccionDTO2;
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
	public ComunaDireccionDTO getComunas(ComunaDireccionDTO comunaDireccionDTO)
	throws DireccionException,RemoteException{
		logger.debug("getComunas():start");
		ComunaDireccionDTO comunaDireccionDTO2 = null;
		
		try{
			comunaDireccionDTO2 = srv.getComuna(comunaDireccionDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getComunas():end");
		return comunaDireccionDTO2;
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
	public CodigoPostalDireccionDTO getCodigosPostales(CodigoPostalDireccionDTO codigoPostalDireccionDTO)
	throws DireccionException,RemoteException{
		logger.debug("getCodigosPostales():start");

		try{
			codigoPostalDireccionDTO = srv.getCodigoPostal(codigoPostalDireccionDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getCodigosPostales():end");
		return codigoPostalDireccionDTO;
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
	public DireccionNegocioDTO setDireccion(DireccionNegocioWebDTO direccionNegocioWebDTO) 
	throws DireccionException,RemoteException{
		logger.debug("setDireccion():start");
		DireccionNegocioDTO direccionNegocioDTO = new DireccionNegocioDTO();
		try{
			direccionNegocioDTO = srv.setDireccion(direccionNegocioWebDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("setDireccion():end");
		return direccionNegocioDTO;

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
	public void updDireccion(DireccionNegocioDTO direccionNegocioDTO) 
	throws DireccionException,RemoteException{
		logger.debug("updDireccion():start");
		try{
			srv.updDireccion(direccionNegocioDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("updDireccion():end");

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
	public DireccionDTO getDireccionCodigo(DireccionDTO direccionDTO) 
	throws DireccionException,RemoteException{
		DireccionDTO direccionDTO2 = null;
		logger.debug("getDireccionCodigo():start");
		try{
			direccionDTO2 = srv.getDireccionCodigo(direccionDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getDireccionCodigo():end");
		return direccionDTO2;

	}
	public DireccionNegocioDTO getDireccion(DireccionNegocioDTO direccionNegocioDTO) 
	throws DireccionException,RemoteException{
		DireccionNegocioDTO direccionNegocioDTO2 = null;
		logger.debug("getDireccion():start");
		try{
			direccionNegocioDTO2 = srv.getDireccion(direccionNegocioDTO);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("getDireccion():end");
		return direccionNegocioDTO2;

	}

	public List llamarServicioDireccionesComputec (ClienteComDTO cliente)
	throws DireccionException, RemoteException {
		List listaDirecciones = null;
		logger.debug("verificaLlamadaServicioExterno():start");
		try{
			listaDirecciones = srv.llamarServicioDireccionesComputec(cliente);
			
		} catch (DireccionException e) {
			logger.debug("DireccionException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new DireccionException(e);
		}
		logger.debug("verificaLlamadaServicioExterno():end");
		return listaDirecciones;

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
	public DireccionFacadeSTLBean() {
		logger.debug("DireccionFacadeSTLBean():Begin");
		config = UtilProperty.getConfigurationfromExternalFile("PortalVentas.properties");
		UtilLog.setLog(config.getString("DireccionEJB.log"));
		logger.debug("DireccionFacadeSTLBean():End");	
	}
}
