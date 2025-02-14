/**
 * 
 */
package com.tmmas.cl.scl.gestiondedirecciones.negocio.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.DireccionNegocioDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDireccionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.PuebloDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO;
import com.tmmas.cl.scl.gestiondedirecciones.service.servicios.GestiondeDireccionesSrv;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="GestionDeDirecciones"	
 *           description="An EJB named GestionDeDirecciones"
 *           display-name="GestionDeDirecciones"
 *           jndi-name="GestionDeDirecciones"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 *  @weblogic.transaction-descriptor trans-timeout-seconds = "60000000" 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class GestionDeDireccionesBean implements javax.ejb.SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private SessionContext context = null;
	private CompositeConfiguration config;
	private final Logger logger = Logger.getLogger(GestionDeDireccionesBean.class);	
	private GestiondeDireccionesSrv srv = new GestiondeDireccionesSrv();
	
	
	public GestionDeDireccionesBean(){				
		System.out.println("GestiondeDireccionesBean(): Start");
		config = UtilProperty.getConfiguration("GestionDeDireccionesEJB.properties","com/tmmas/cl/scl/gestiondedirecciones/negocio/ejb/properties/GestionDeDireccionesBean.properties");
		System.out.println("GestiondeDireccionesBean.log ["+config.getString("GestiondeDireccionesBean.log")+"]");
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));	
		logger.debug("GestiondeDireccionesBean():End");		
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
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("getDatosDireccion():start");
		DireccionDTO direccionDTO2 = null;
		
		try{
			direccionDTO2 = srv.getDatosDireccion(direccionDTO);
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
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
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("getProvincias():start");
		ProvinciaDireccionDTO provinciaDireccionDTO2 = null;
		
		try{
			provinciaDireccionDTO2 = srv.getProvincia(provinciaDireccionDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
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
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("getCiudades():start");
		CiudadDireccionDTO ciudadDireccionDTO2 = null;
		
		try{
			ciudadDireccionDTO2 = srv.getCiudad(ciudadDireccionDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
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
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("getComunas():start");
		ComunaDireccionDTO comunaDireccionDTO2 = null;
		
		try{
			comunaDireccionDTO2 = srv.getComuna(comunaDireccionDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
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
	public DireccionNegocioDTO[] setDireccion(DireccionNegocioDTO[] direccionNegocioDTO) 
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("setDireccion():start");
		try{
			
			direccionNegocioDTO = srv.setDireccion(direccionNegocioDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
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
	public DireccionNegocioDTO setDireccion(DireccionNegocioDTO direccionNegocioDTO) 
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("setDireccion():start");
		try{
			direccionNegocioDTO = srv.setDireccion(direccionNegocioDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
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
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("updDireccion():start");
		try{
			srv.updDireccion(direccionNegocioDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
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
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		DireccionDTO direccionDTO2 = null;
		logger.debug("getDireccionCodigo():start");
		try{
			direccionDTO2 = srv.getDireccionCodigo(direccionDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getDireccionCodigo():end");
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
	public DireccionNegocioDTO getDireccion(DireccionNegocioDTO direccionNegocioDTO) 
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		DireccionNegocioDTO direccionNegocioDTO2 = null;
		logger.debug("getDireccion():start");
		try{
			direccionNegocioDTO2 = srv.getDireccion(direccionNegocioDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("getDireccion():end");
		return direccionNegocioDTO2;

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
	public void eliminaDireccion(DireccionNegocioDTO direccionNegocioDTO) 
	throws GeneralException,RemoteException{
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("eliminaDireccion():start");
		try{
			srv.eliminaDireccion(direccionNegocioDTO);
			
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("eliminaDireccion():end");

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
	public RegionDTO[] getListadoRegiones() throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("Inicio:getCiudad()");
		RegionDTO[] regiones = null;
		try{
			regiones = srv.getListadoRegiones();
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return regiones;
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
	public ProvinciaDTO[] getListadoProvincias(RegionDTO region) throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("Inicio:getCiudad()");
		ProvinciaDTO[] Provincias = null;
		try{
			Provincias = srv.getListadoProvincias(region);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return Provincias;
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
	public CiudadDTO[] getListadoCiudaddes(ProvinciaDTO provincia) throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("Inicio:getCiudad()");
		CiudadDTO[] ciudades = null;
		try{
			ciudades = srv.getListadoCiudaddes(provincia);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return ciudades;
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
	public ComunaSPNDTO[] getListadoComunas(CiudadDTO ciudad) throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("Inicio:getCiudad()");
		ComunaSPNDTO[] comunas = null;
		try{
			comunas = srv.getListadoComunas(ciudad);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getCiudad()");
		return comunas;
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
	public PuebloDTO[] getListadoPueblos(EstadoDTO estado) throws GeneralException{		 
		UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
		logger.debug("Inicio:getPueblos()");
		PuebloDTO[] Pueblos = null;
		try{
			Pueblos = srv.getListadoPueblos(estado);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("GestiondeDireccionesBean.log"));
			context.setRollbackOnly();
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		logger.debug("Fin:getPueblos()");
		return Pueblos;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//-----------------------------------------------------------------------------------------------------------------------------	
	
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
		this.context=arg0;

	}
	
	
}
