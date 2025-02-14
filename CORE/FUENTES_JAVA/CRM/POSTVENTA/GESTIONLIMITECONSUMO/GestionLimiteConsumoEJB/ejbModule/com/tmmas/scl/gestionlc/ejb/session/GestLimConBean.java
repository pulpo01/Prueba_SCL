/**
 * 
 */
package com.tmmas.scl.gestionlc.ejb.session;

import java.rmi.RemoteException;
import java.util.Hashtable;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.rmi.PortableRemoteObject;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.GaVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioEquipoNuevoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacade;
import com.tmmas.scl.frameworkooss.bean.ejb.session.FrmkOOSSFacadeHome;
import com.tmmas.scl.gestionlc.common.dto.ws.CargaAbonoLimiteConsumoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorAbonoOutDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorInDTO;
import com.tmmas.scl.gestionlc.common.dto.ws.IndicadorVtaExternaVendedorOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.common.helper.GlobalProperties;
import com.tmmas.scl.gestionlc.ejb.common.GestionLimiteConsumoAbstractBean;
import com.tmmas.scl.gestionlc.srv.GestionLimiteConsumoSrv;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;


/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="GestLimCon"	
 *           description="An EJB named GestLimCon"
 *           display-name="GestLimCon"
 *           jndi-name="GestLimCon"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class GestLimConBean extends GestionLimiteConsumoAbstractBean implements javax.ejb.SessionBean {

	private GlobalProperties global = GlobalProperties.getInstance();
	
	GestionLimiteConsumoSrv gestionLimiteConsumoSrv = new GestionLimiteConsumoSrv();
	
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
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado) throws GestionLimiteConsumoException{
		
		AbonadoDTO resultado = null;
		
		try{
					
			loggerDebug("obtenerDatosAbonado():start");
			resultado = gestionLimiteConsumoSrv.obtenerDatosAbonado(abonado);
			loggerDebug("obtenerDatosAbonado():end");
			
		} catch(CusIntManException e){
			loggerError(e);
			throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
		} catch (Exception e) {
			loggerError(e);
			throw new GestionLimiteConsumoException(e);
		}
		return resultado;
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
   public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planTarifarioDTO) throws GestionLimiteConsumoException{
       
       PlanTarifarioDTO resultado = null;
       
       try{
                   
           loggerDebug("getCategoriaPlanTarifario():start");
           resultado = gestionLimiteConsumoSrv.getCategoriaPlanTarifario(planTarifarioDTO);
           loggerDebug("getCategoriaPlanTarifario():end");
           
       } catch(GeneralException e){
           loggerError(e);
           throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
       } catch (Exception e) {
           loggerError(e);
           throw new GestionLimiteConsumoException(e);
       }
       return resultado;
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
	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws GestionLimiteConsumoException{
		
		UsuarioSistemaDTO resultado = null;
		
		try{
					
			loggerDebug("obtenerInformacionUsuario():start");
			resultado = gestionLimiteConsumoSrv.obtenerInformacionUsuario(usuarioSistema);
			loggerDebug("obtenerInformacionUsuario():end");
			
		} catch(AplicationException e){
			loggerError(e);
			throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
		} catch (Exception e) {
			loggerError(e);
			throw new GestionLimiteConsumoException(e);
		}
		
		return resultado;
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
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws GestionLimiteConsumoException{
		
		ClienteDTO resultado = null;
		
		try{
				
			loggerDebug("obtenerDatosCliente():start");
			resultado = gestionLimiteConsumoSrv.obtenerDatosCliente(cliente);
			loggerDebug("obtenerDatosCliente():end");
			
		} catch(CusIntManException e){
			loggerError(e);
			throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
			
		} catch (Exception e) {
			loggerError(e);
			throw new GestionLimiteConsumoException(e);
		}
		
		return resultado;
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
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO UsuarioAbonado) throws GestionLimiteConsumoException{
		
		UsuarioAbonadoDTO resultado = null;
		
		try{
				
			loggerDebug("obtenerDatosUsuarioAbonado():start");
			resultado = gestionLimiteConsumoSrv.obtenerDatosUsuarioAbonado(UsuarioAbonado);
			loggerDebug("obtenerDatosUsuarioAbonado():end");
			
		} catch(CusIntManException e){
			loggerError(e);
			throw new GestionLimiteConsumoException(e.getCodigo(), Integer.valueOf(String.valueOf(e.getCodigoEvento())).intValue(), e.getDescripcionEvento());
			
		} catch (Exception e) {
			loggerError(e);
			throw new GestionLimiteConsumoException(e);
		}
		
		return resultado;
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
	 * 
	 */
	public IndicadorAbonoOutDTO obtieneIndicadorAbono(IndicadorAbonoInDTO pIndicadorAbonoInDTO){
		
		IndicadorAbonoOutDTO result= null;
				
		loggerDebug("obtieneIndicadorAbono():start");
		
		try {
			
			result = gestionLimiteConsumoSrv.obtieneIndicadorAbono(pIndicadorAbonoInDTO);
			

		} catch (GestionLimiteConsumoException e) {
			
			loggerError(e);
			
			e.printStackTrace();
			
			result = new IndicadorAbonoOutDTO();
			
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
			context.setRollbackOnly();
			
		}catch(Exception ex){
			
			loggerError(ex);
			
			ex.printStackTrace();
			
			result = new IndicadorAbonoOutDTO();
			
//			result.setIEvento();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

			context.setRollbackOnly();
		}
		
		loggerDebug("obtieneIndicadorAbono():end");
		
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
	 * 
	 */
	public IndicadorVtaExternaVendedorOutDTO obtieneIndicadorVtaExternaVendedor(IndicadorVtaExternaVendedorInDTO pIndicadorVtaExternaVendedorInDTO){
		
		IndicadorVtaExternaVendedorOutDTO result= null;
				
		loggerDebug("obtieneIndicadorVtaExternaVendedor():start");
		
		try {
			
			result = gestionLimiteConsumoSrv.obtieneIndicadorVtaExternaVendedor(pIndicadorVtaExternaVendedorInDTO);
			
		} catch (GestionLimiteConsumoException e) {
			
			loggerError(e);
			
			e.printStackTrace();
			
			result = new IndicadorVtaExternaVendedorOutDTO();
			
			result.setIEvento(e.getCodigoEvento());
			result.setStrCodError(e.getCodigo());
			result.setStrDesError(e.getDescripcionEvento());
			
			context.setRollbackOnly();
			
		}catch(Exception ex){
			
			loggerError(ex);
			
			ex.printStackTrace();
			
			result = new IndicadorVtaExternaVendedorOutDTO();
			
//			result.setIEvento();
			result.setStrCodError("ERR.0001");
			result.setStrDesError(global.getValor("ERR.0001"));

			context.setRollbackOnly();
		}
		
		loggerDebug("obtieneIndicadorVtaExternaVendedor():end");
		
		return result;
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

	/**
	 * 
	 */
	public GestLimConBean() {
		// TODO Auto-generated constructor stub
	}
}
