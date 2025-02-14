package com.tmmas.cl.scl.integracionsicsa.negocio.session;

import java.rmi.RemoteException;
import java.util.HashMap;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaDevolucionUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaPedidoUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.CorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.GrupoCorreosDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.UsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.PedidoInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaProcesoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.VentaInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.srv.DevolucionSRV;
import com.tmmas.cl.scl.integracionsicsa.srv.GeneralSRV;
import com.tmmas.cl.scl.integracionsicsa.srv.PedidoSRV;
import com.tmmas.cl.scl.integracionsicsa.srv.SerieVendidaTercerosSRV;
import com.tmmas.cl.scl.integracionsicsa.srv.TraspasoSRV;

/**
 * 
 * <!-- begin-user-doc --> A generated session bean <!-- end-user-doc --> * <!--
 * begin-xdoclet-definition -->
 * 
 * @ejb.bean name="IntegracionSICSA" description="An EJB named IntegracionSICSA"
 *           display-name="IntegracionSICSA" jndi-name="IntegracionSICSA"
 *           type="Stateless" transaction-type="Container"
 * 
 *           <!-- end-xdoclet-definition -->
 * @generated
 */
public class IntegracionSICSABean implements javax.ejb.SessionBean {

	private static final long serialVersionUID = 1L;

	private final LoggerHelper logger = LoggerHelper.getInstance();
	private SerieVendidaTercerosSRV serieVendidaTercerosSRV;
	private PedidoSRV pedidoSRV;
	private GeneralSRV generalSRV;
	private TraspasoSRV traspasoSRV;
	private DevolucionSRV devolucionSRV;
	// @Resource
	private SessionContext context;

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.create-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean create stub
	 */
	public void ejbCreate() {
	}

	/**
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.interface-method view-type="remote" <!-- end-xdoclet-definition -->
	 * @generated
	 * 
	 *            //TODO: Must provide implementation for bean method stub
	 */
	public String foo(String param) {
		return null;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbActivate()
	 */
	public void ejbActivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbPassivate()
	 */
	public void ejbPassivate() throws EJBException, RemoteException {
		// TODO Auto-generated method stub
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#ejbRemove()
	 */
	public void ejbRemove() throws EJBException, RemoteException {
		// TODO Auto-generated method stub

	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see javax.ejb.SessionBean#setSessionContext(javax.ejb.SessionContext)
	 */
	public void setSessionContext(SessionContext arg0) throws EJBException,
			RemoteException {
		// TODO Auto-generated method stub
		this.context = arg0;
	}

	/**
	 * 
	 */
	public IntegracionSICSABean() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * Se comenta ya que esto sera por COLAS
	 * 
	 * public void registrarVentaCeltics(VentaInDTO inDTO, int numOperacion)
	 * throws Exception { loggerDebug("inicio registrarVentaCeltics()");
	 * ventaSRV = new SerieVendidaTercerosSRV(); try {
	 * ventaSRV.registrarVentaCeltics(inDTO, numOperacion); } catch
	 * (IntegracionSICSAException e) { loggerError("IntegracionSICSAException: "
	 * + e); loggerError("antes de rollback: "); context.setRollbackOnly();
	 * loggerError("despues de rollback: "); throw e; } catch (Exception e) {
	 * loggerError("Exception: " + e); loggerError("antes de rollback: ");
	 * context.setRollbackOnly(); loggerError("despues de rollback: "); throw e;
	 * } loggerDebug("fin invocandoAltaExportacion()"); }
	 */

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
	public void registraSeries(PedidoInDTO pedidoInDTO) throws Exception {
		loggerDebug("inicio registraSeries()");
		pedidoSRV = new PedidoSRV();
		try {
			pedidoSRV.registraSeries(pedidoInDTO);
		} catch (IntegracionSICSAException e) {
			loggerError("IntegracionSICSAExceptionBean: " + e);
			/*
			 * loggerError("antes de rollback: "); context.setRollbackOnly();
			 * loggerError("despues de rollback: ");
			 */
			throw e;
		} catch (Exception e) {
			loggerError("Exception: " + e);
			/*
			 * loggerError("antes de rollback: "); context.setRollbackOnly();
			 * loggerError("despues de rollback: ");
			 */
			throw e;
		}
		loggerDebug("fin registraSeries()");
		// return respuesta;
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
	public int registrarCabecera(VentaInDTO inDTO) throws Exception {
		loggerDebug("inicio registrarCabecera()");
		int retorno;
		try {
			serieVendidaTercerosSRV = new SerieVendidaTercerosSRV();
			retorno = serieVendidaTercerosSRV.registrarCabecera(inDTO);
		} catch (IntegracionSICSAException e) {
			loggerError("IntegracionSICSAExceptionBean: " + e);
			loggerError("antes de rollback: ");
			context.setRollbackOnly();
			loggerError("despues de rollback: ");
			throw e;
		} catch (Exception e) {
			loggerError("Exception: " + e);
			loggerError("antes de rollback: ");
			context.setRollbackOnly();
			loggerError("despues de rollback: ");
			throw e;
		}
		loggerDebug("fin registrarCabecera()");
		return retorno;
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
	public SalidaConsultaProcesoDTO consultarProceso(String numProceso)
			throws Exception {
		SalidaConsultaProcesoDTO outDTO;
		loggerDebug("consultarProceso: inicio");
		try {
			serieVendidaTercerosSRV = new SerieVendidaTercerosSRV();
			outDTO = serieVendidaTercerosSRV.consultarProceso(numProceso);
		} catch (IntegracionSICSAException e) {
			loggerError("IntegracionSICSAExceptionBean: " + e);
			throw e;
		} catch (Exception e) {
			loggerError("Exception: " + e);
			throw e;
		}
		loggerDebug("consultarProceso: fin");
		return outDTO;
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
	public SalidaConsultaPedidoDTO obtieneEstadoPedido(String codPedido)
			throws Exception {
		SalidaConsultaPedidoDTO outDTO;
		loggerDebug("obtieneEstadoPedido: inicio");
		try {
			pedidoSRV = new PedidoSRV();
			outDTO = pedidoSRV.obtieneEstadoPedido(codPedido);
		} catch (IntegracionSICSAException e) {
			loggerError("IntegracionSICSAExceptionBean: " + e);
			throw e;
		}
		loggerDebug("obtieneEstadoPedido: fin");
		return outDTO;
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
	public UsuarioDTO getDatosUsuario(String codUsuario) throws Exception {
		UsuarioDTO outDTO;
		loggerDebug("getDatosUsuario: inicio");
		try {
			generalSRV = new GeneralSRV();
			outDTO = generalSRV.getDatosUsuario(codUsuario);
		} catch (IntegracionSICSAException e) {
			loggerError("getDatosUsuario: " + e);
			throw e;
		}
		loggerDebug("obtieneEstadoPedido: fin");
		return outDTO;
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
	public ConsultaPedidoUsuarioDTO[] consultarPedidosUsuario(
			String codUsuario, String codPedido, String fecDesde,
			String fecHasta) throws Exception {
		ConsultaPedidoUsuarioDTO[] outDTO;
		loggerDebug("consultarPedidosUsuario: inicio");
		try {
			pedidoSRV = new PedidoSRV();
			outDTO = pedidoSRV.consultarPedidosUsuario(codUsuario, codPedido,
					fecDesde, fecHasta);
		} catch (IntegracionSICSAException e) {
			loggerError("consultarPedidosUsuario: " + e);
			throw e;
		}
		loggerDebug("consultarPedidosUsuario: fin");
		return outDTO;
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
	public HashMap consultarDetallePedidosUsuario(String codPedido,
			HashMap detalles) throws Exception {
		HashMap outDTO;
		loggerDebug("consultarDetallePedidosUsuario: inicio");
		try {
			pedidoSRV = new PedidoSRV();
			outDTO = pedidoSRV.consultarDetallePedidosUsuario(codPedido,
					detalles);
		} catch (IntegracionSICSAException e) {
			loggerError("consultarDetallePedidosUsuario: " + e);
			throw e;
		}
		loggerDebug("consultarDetallePedidosUsuario: fin");
		return outDTO;
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
	public HashMap consultarSeriePedidosUsuario(String codPedido,
			String linProceso, HashMap series) throws Exception {
		HashMap outDTO;
		loggerDebug("consultarSeriePedidosUsuario: inicio");
		try {
			pedidoSRV = new PedidoSRV();
			outDTO = pedidoSRV.consultarSeriePedidosUsuario(codPedido,
					linProceso, series);
		} catch (IntegracionSICSAException e) {
			loggerError("consultarSeriePedidosUsuario: " + e);
			throw e;
		}
		loggerDebug("consultarSeriePedidosUsuario: fin");
		return outDTO;
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
		public void validaTraspaso(EntradaTraspasoDTO traspasoDTO , String codEstado)throws IntegracionSICSAException{
		loggerDebug("validaEstadoTraspaso: inicio");
		traspasoSRV = new TraspasoSRV();
		traspasoSRV.validaTraspaso(traspasoDTO, codEstado);
		loggerDebug("validaEstadoTraspaso: fin");
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
	public void validaPedido(PedidoInDTO pedidoInDTO)throws Exception{
		loggerDebug("validaPedido: inicio");
		pedidoSRV = new PedidoSRV();
		pedidoSRV.validaPedido(pedidoInDTO);
		loggerDebug("validaPedido: fin");
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
		public void insertaEstadoTraspaso(String numTraspaso, String estadoTraspaso)throws IntegracionSICSAException{
		loggerDebug("insertaEstadoTraspaso: inicio");
		traspasoSRV = new TraspasoSRV();
		traspasoSRV.insertaEstadoTraspaso(numTraspaso, estadoTraspaso);
		loggerDebug("insertaEstadoTraspaso: fin");
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
	public SalidaConsultaTraspasoDTO obtieneEstadoTraspaso(String numTraspaso)throws Exception {
		SalidaConsultaTraspasoDTO outDTO;
		loggerDebug("obtieneEstadoTraspaso: inicio");
		try {
			traspasoSRV = new TraspasoSRV();
			outDTO = traspasoSRV.consultaEstadoTraspaso(numTraspaso);
		} catch (IntegracionSICSAException e) {
			loggerError("IntegracionSICSAExceptionBean: " + e);
			throw e;
		}
		loggerDebug("obtieneEstadoTraspaso: fin");
		return outDTO;
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
	public GrupoCorreosDTO[] getGruposCorreos() throws Exception {
		GrupoCorreosDTO[] outDTO;
		loggerDebug("getGruposCorreos: inicio");
		try {
			generalSRV = new GeneralSRV();
			outDTO = generalSRV.getGruposCorreos();
		} catch (IntegracionSICSAException e) {
			loggerError("getGruposCorreos: " + e);
			throw e;
		}
		loggerDebug("getGruposCorreos: fin");
		return outDTO;
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
	public CorreoDTO[] getCorreos(String codGrupo) throws Exception {
		CorreoDTO[] outDTO;
		loggerDebug("getCorreos: inicio");
		try {
			generalSRV = new GeneralSRV();
			outDTO = generalSRV.getCorreos(codGrupo);
		} catch (IntegracionSICSAException e) {
			loggerError("getCorreos: " + e);
			throw e;
		}
		loggerDebug("getCorreos: fin");
		return outDTO;
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
	public void borrarCorreo(String codGrupo, String mail) throws Exception {

		loggerDebug("borrarCorreo: inicio");
		try {
			generalSRV = new GeneralSRV();
			generalSRV.borrarCorreo(codGrupo, mail);
		} catch (IntegracionSICSAException e) {
			loggerError("getCorreos: " + e);
			throw e;
		}
		loggerDebug("borrarCorreo: fin");
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
	public void modificarCorreo(String codGrupo, String antMail,String nueMail, String usuario)
			throws Exception {

		loggerDebug("modificarCorreo: inicio");
		try {
			generalSRV = new GeneralSRV();
			generalSRV.modificarCorreo(codGrupo, antMail,nueMail, usuario);
		} catch (IntegracionSICSAException e) {
			loggerError("getCorreos: " + e);
			throw e;
		}
		loggerDebug("modificarCorreo: fin");
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
	public void insertarCorreo(String codGrupo, String mail, String usuario)
			throws Exception {

		loggerDebug("insertarCorreo: inicio");
		try {
			generalSRV = new GeneralSRV();
			generalSRV.insertarCorreo(codGrupo, mail, usuario);
		} catch (IntegracionSICSAException e) {
			loggerError("getCorreos: " + e);
			throw e;
		}
		loggerDebug("insertarCorreo: fin");
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
	public void limpiarPedido(String codPedido)
			throws Exception {

		loggerDebug("limpiarPedido: inicio");
		try {
			pedidoSRV = new PedidoSRV();
			pedidoSRV.limpiarPedido(codPedido);
		} catch (IntegracionSICSAException e) {
			loggerError("IntegracionSICSAExceptionBean: " + e);
			loggerError("antes de rollback: ");
			context.setRollbackOnly();
			loggerError("despues de rollback: ");
			throw e;
		} catch (Exception e) {
			loggerError("Exception: " + e);
			loggerError("antes de rollback: ");
			context.setRollbackOnly();
			loggerError("despues de rollback: ");
			throw e;
		}
		loggerDebug("limpiarPedido: fin");
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
	public ConsultaDevolucionUsuarioDTO[] consultarDevolucionUsuario(String codUsuario, String codDevolucion, String fecDesde, String fecHasta)
			throws Exception {
		ConsultaDevolucionUsuarioDTO[] consultaDevolucionUsuarioDTOs = null;
		loggerDebug("consultarDevolucionUsuario: inicio");
		try {
			devolucionSRV = new DevolucionSRV();
			consultaDevolucionUsuarioDTOs = devolucionSRV.consultarDevolucionUsuario(codUsuario, codDevolucion, fecDesde, fecHasta);
		} catch (IntegracionSICSAException e) {
			loggerError("Error: " + e);
			throw e;
		}
		loggerDebug("consultarDevolucionUsuario: fin");
		return consultaDevolucionUsuarioDTOs;
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
	public HashMap consultarDetalleDevolucionUsuario(String codDevolucion, HashMap detalles)
			throws Exception {
		HashMap resultado = null;
		loggerDebug("consultarDetalleDevolucionUsuario: inicio");
		try {
			devolucionSRV = new DevolucionSRV();
			resultado = devolucionSRV.consultarDetalleDevolucionUsuario(codDevolucion, detalles);
		} catch (IntegracionSICSAException e) {
			loggerError("Error: " + e);
			throw e;
		}
		loggerDebug("consultarDetalleDevolucionUsuario: fin");
		return resultado;
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
