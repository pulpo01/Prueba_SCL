/**
 * 
 */
package com.tmmas.scl.gestionlc.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import com.tmmas.scl.gestionlc.common.dto.UsuarioDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeguimientoSiniestroInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeguimientoSiniestroOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeleccionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaSeleccionEquipoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaCierreRestitucionInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaCierreRestitucionOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaRestitucionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.EjecutaRestitucionEquipoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboCuotasInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboCuotasOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboModalidadInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaCboModalidadOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaListSeriesInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.RecargaListSeriesOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.ejb.common.GestionLimiteConsumoAbstractBean;
import com.tmmas.scl.gestionlc.srv.RestitucionEquipoSrv;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="RestitucionEquipo"	
 *           description="An EJB named Foo"
 *           display-name="RestitucionEquipo"
 *           jndi-name="RestitucionEquipo"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class RestitucionEquipoBean extends GestionLimiteConsumoAbstractBean implements javax.ejb.SessionBean {

	RestitucionEquipoSrv restitucionEquipoSrv = new RestitucionEquipoSrv();
	
	private GlobalProperties global = GlobalProperties.getInstance();
	
	private SessionContext context = null;
	
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
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CargaSeguimientoSiniestroOutDTO cargarSeguimientoSiniestro(CargaSeguimientoSiniestroInDTO cargaInDTO) {
		CargaSeguimientoSiniestroOutDTO result = null;
		try {
			loggerDebug(" Inicio cargarSeguimientoSiniestro");
			
			result = restitucionEquipoSrv.cargarSeguimientoSiniestro(cargaInDTO);
			
			loggerDebug(" Fin cargarSeguimientoSiniestro");
		} catch (GestionLimiteConsumoException e) {
			e.printStackTrace();
			result = new CargaSeguimientoSiniestroOutDTO();
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
		}catch(Exception ex){
			ex.printStackTrace();
			result = new CargaSeguimientoSiniestroOutDTO();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

		}
		return result;		
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CargaRestitucionEquipoOutDTO cargarRestitucionEquipo(CargaRestitucionEquipoInDTO inDTO) {
		CargaRestitucionEquipoOutDTO result = null;
		try {
			loggerDebug(" Inicio ejecutarRestitucionEquipo");
			
			result = restitucionEquipoSrv.cargarRestitucionEquipo(inDTO);
			
			loggerDebug(" Fin ejecutarRestitucionEquipo");
		} catch (GestionLimiteConsumoException e) {
			e.printStackTrace();
			result = new CargaRestitucionEquipoOutDTO();
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
		}catch(Exception ex){
			ex.printStackTrace();
			result = new CargaRestitucionEquipoOutDTO();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

		}
		return result;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RecargaCboModalidadOutDTO recargarCboModalidad(RecargaCboModalidadInDTO inDTO) {
		RecargaCboModalidadOutDTO result = null;
		try {
			loggerDebug(" Inicio recargarCboModalidad");
			
			result = restitucionEquipoSrv.recargarCboModalidad(inDTO);
			
			loggerDebug(" Fin recargarCboModalidad");
		} catch (GestionLimiteConsumoException e) {
			e.printStackTrace();
			result = new RecargaCboModalidadOutDTO();
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
		}catch(Exception ex){
			ex.printStackTrace();
			result = new RecargaCboModalidadOutDTO();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

		}
		return result;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RecargaCboCuotasOutDTO recargarCboCuotas(RecargaCboCuotasInDTO inDTO) {
		RecargaCboCuotasOutDTO result = null;
		try {
			loggerDebug(" Inicio recargarCboCuotas");
			
			result = restitucionEquipoSrv.recargarCboCuotas(inDTO);
			
			loggerDebug(" Fin recargarCboCuotas");
		} catch (GestionLimiteConsumoException e) {
			e.printStackTrace();
			result = new RecargaCboCuotasOutDTO();
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
		}catch(Exception ex){
			ex.printStackTrace();
			result = new RecargaCboCuotasOutDTO();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

		}
		return result;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public CargaSeleccionEquipoOutDTO cargarSeleccionEquipo(CargaSeleccionEquipoInDTO cargaInDTO) {
		CargaSeleccionEquipoOutDTO result = null;
		try {
			loggerDebug(" Inicio cargarSeguimientoSiniestro");
			
			result = restitucionEquipoSrv.cargarSeleccionEquipo(cargaInDTO);
			
			loggerDebug(" Fin cargarSeguimientoSiniestro");
		} catch (GestionLimiteConsumoException e) {
			e.printStackTrace();
			result = new CargaSeleccionEquipoOutDTO();
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
		}catch(Exception ex){
			ex.printStackTrace();
			result = new CargaSeleccionEquipoOutDTO();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

		}
		return result;		
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RecargaListSeriesOutDTO recargaListSeries(RecargaListSeriesInDTO inDTO) {
		RecargaListSeriesOutDTO result = null;
		try {
			loggerDebug(" Inicio recargaListSeries");
			
			result = restitucionEquipoSrv.recargaListSeries(inDTO);
			
			loggerDebug(" Fin recargaListSeries");
		} catch (GestionLimiteConsumoException e) {
			e.printStackTrace();
			result = new RecargaListSeriesOutDTO();
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
		}catch(Exception ex){
			ex.printStackTrace();
			result = new RecargaListSeriesOutDTO();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

		}
		return result;
	}

	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public EjecutaRestitucionEquipoOutDTO ejecutarRestitucionEquipo(EjecutaRestitucionEquipoInDTO inDTO) {
		EjecutaRestitucionEquipoOutDTO result = null;
		try {
			loggerDebug(" Inicio ejecutarRestitucionEquipo");
			
			result = restitucionEquipoSrv.ejecutarRestitucionEquipo(inDTO);
			
			loggerDebug(" Fin ejecutarRestitucionEquipo");
		} catch (GestionLimiteConsumoException e) {
			
			loggerError(e);
			e.printStackTrace();
			result = new EjecutaRestitucionEquipoOutDTO();
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
			context.setRollbackOnly();
			
		}catch(Exception ex){
			
			loggerError(ex);
			
			ex.printStackTrace();
			result = new EjecutaRestitucionEquipoOutDTO();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

			context.setRollbackOnly();
		}
		return result;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public EjecutaCierreRestitucionOutDTO ejecutarCierreRestitucion(EjecutaCierreRestitucionInDTO inDTO) {
		EjecutaCierreRestitucionOutDTO result = null;
		try {
			loggerDebug(" Inicio ejecutarCierreRestitucion");
			
			result = restitucionEquipoSrv.ejecutarCierreOOSS(inDTO);
			
			loggerDebug(" Fin ejecutarCierreRestitucion");
		} catch (GestionLimiteConsumoException e) {
			
			loggerError(e);
			
			e.printStackTrace();
			result = new EjecutaCierreRestitucionOutDTO();
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
			context.setRollbackOnly();
			
		}catch(Exception ex){
			
			loggerError(ex);
			
			ex.printStackTrace();
			result = new EjecutaCierreRestitucionOutDTO();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

			context.setRollbackOnly();
			
		}
		return result;
	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @throws GestionLimiteConsumoException, Exception 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void rollbackReservaSerie(Long lonNumTransaccion) throws GestionLimiteConsumoException, Exception {
		
		try {
			loggerDebug(" Inicio rollbackReservaSerie");
			
			restitucionEquipoSrv.rollbackReservaSerie(lonNumTransaccion);
			
			loggerDebug(" Fin rollbackReservaSerie");
			
		} catch (GestionLimiteConsumoException e) {
			e.printStackTrace();

			context.setRollbackOnly();
			
			throw e;
			
		}catch(Exception ex){
			ex.printStackTrace();

			context.setRollbackOnly();
			
			throw ex;
		}

	}
	
	/** 
	 *
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * @ejb.transaction type="Required"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public void desbloquearVendedor(UsuarioDTO inDTO){
		
		System.out.println("Entra a RestitucionEquipoBean");
		try {
			loggerDebug(" Inicio desbloqueaVendedor");
			
			restitucionEquipoSrv.desbloqueaVendedor(inDTO);
			
			loggerDebug(" Fin desbloqueaVendedor");
		} catch (GestionLimiteConsumoException e) {
			e.printStackTrace();
			
		}catch(Exception ex){
			ex.printStackTrace();

		}
	}
	
	/**
	 * 
	 */
	public RestitucionEquipoBean() {
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

	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {

		this.context=arg0;
		
	}
}
