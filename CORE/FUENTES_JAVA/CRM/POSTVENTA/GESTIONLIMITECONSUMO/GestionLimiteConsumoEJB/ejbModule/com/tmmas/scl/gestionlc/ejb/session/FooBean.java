/**
 * 
 */
package com.tmmas.scl.gestionlc.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.FooOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.ejb.common.GestionLimiteConsumoAbstractBean;
import com.tmmas.scl.gestionlc.srv.GestionLimiteConsumoSrv;
import com.tmmas.scl.gestionlc.srv.RestitucionEquipoSrv;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="Foo"	
 *           description="An EJB named Foo"
 *           display-name="Foo"
 *           jndi-name="Foo"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class FooBean extends GestionLimiteConsumoAbstractBean implements javax.ejb.SessionBean {

	GestionLimiteConsumoSrv fooSrv = new GestionLimiteConsumoSrv();
	RestitucionEquipoSrv restitucionEquipoSrv = new RestitucionEquipoSrv();
	
	private GlobalProperties global = GlobalProperties.getInstance();
	
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
	public CargaRestitucionEquipoOutDTO cargarRestitucionEquipo(CargaRestitucionEquipoInDTO cargaInDTO) {
		
		CargaRestitucionEquipoOutDTO result = null;
		try {
		
			loggerDebug(" Inicio cargarRestitucionEquipo");
			
			result = restitucionEquipoSrv.cargarRestitucionEquipo(cargaInDTO);
			
			loggerDebug(" Fin cargarRestitucionEquipo");
			
		} catch (GestionLimiteConsumoException e) {
			
			e.printStackTrace();
			
			result = new CargaRestitucionEquipoOutDTO();
			
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
		}catch(Exception ex){
			
			ex.printStackTrace();
			
			result = new CargaRestitucionEquipoOutDTO();
			
//			result.setIEvento();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

		}
		
		return result;
		
	}

	/**
	 * 
	 */
	public FooBean() {
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
		// TODO Auto-generated method stub
		
	}
}
