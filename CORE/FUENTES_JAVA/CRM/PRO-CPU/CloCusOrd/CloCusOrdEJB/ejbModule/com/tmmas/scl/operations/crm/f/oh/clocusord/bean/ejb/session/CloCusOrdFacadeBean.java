/**
 * 
 */
package com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RegReordPlanDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CartaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaCambioPlanDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EventoNumFrecDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PagoAnticipadoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PlanBatchDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarRenovaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CtaPersonalEmpDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DesactServFreDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaPermanenciaDTO;
//import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO; //77866-INC; COL; AVC; 10-02-2009
import com.tmmas.scl.operations.crm.f.oh.clocusord.bean.ejb.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord.GestionOrdenServicioSrvFactory;
import com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord.interfaces.GestionOrdenServicioSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord.interfaces.GestionOrdenServicioSrvIF;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RegistroColaDTO;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="CloCusOrdFacade"	
 *           description="An EJB named CloCusOrdFacade"
 *           display-name="CloCusOrdFacade"
 *           jndi-name="CloCusOrdFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class CloCusOrdFacadeBean implements javax.ejb.SessionBean {

	private SessionContext context = null;
	
	private final Logger logger = Logger.getLogger(CloCusOrdFacadeBean.class);
	
	private Global global = Global.getInstance();
	
	// Instancia el factory
	GestionOrdenServicioSrvFactoryIF factorySrv1 = new GestionOrdenServicioSrvFactory();

	// Obtiene el application service
	GestionOrdenServicioSrvIF service1 = factorySrv1.getApplicationService1();
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
	 * Registra OOSS a nivel abonado o a nivel cliente
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registraNivelOoss(RegistroNivelOOSSDTO registro) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraNivelOoss():start");
			resultado = service1.registraNivelOoss(registro);
			logger.debug("registraNivelOoss():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;
	}
	

	
	/** 
	 * Registra en batch postventa
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registraCambPlanBatch(PlanBatchDTO param) throws CloCusOrdException{	
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registraCambPlanBatch():start");
			resultado = service1.registraCambPlanBatch(param);
			logger.debug("registraCambPlanBatch():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;
	}		
	
	/** 
	 * Elimina cuenta personal
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO eliminaCuentaPersonal(CuentaPersonalDTO cuenta) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminaCuentaPersonal():start");
			resultado = service1.eliminaCuentaPersonal(cuenta);
			logger.debug("eliminaCuentaPersonal():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;		
	}

	/** 
	 * Elimina el registro de la tabla re_servamist
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO reservaAmist(CuentaPersonalDTO cuenta) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("reservaAmist():start");
			resultado = service1.reservaAmist(cuenta);
			logger.debug("reservaAmist():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;	
	}
	
	/** 
	 * Valida permanencia para optar a un prepago
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public RetornoDTO validaPermanencia(ValidaPermanenciaDTO param) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaPermanencia():start");
			resultado = service1.validaPermanencia(param);
			logger.debug("validaPermanencia():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;		
	}
	
	/** 
	 * Registra orden de servicio en linea
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO registrarOOSSEnLinea (RegistrarOossEnLineaDTO param)throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registrarOOSSEnLinea():start");
			resultado = service1.registrarOOSSEnLinea(param);
			logger.debug("registrarOOSSEnLinea():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;		
	}
	
	
	/** 
	 * Actualiza renovacion
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */
	public RetornoDTO actualizaRenova(RegistrarRenovaDTO param) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizaRenova():start");
			resultado = service1.actualizaRenova(param);
			logger.debug("actualizaRenova():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;		
	}
	
	
	
	/** 
	 * Obtiene solicitudes cambio plan pendiente
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public CambioPlanPendienteListDTO obtenerSolicPendPlan(ClienteDTO cliente) throws CloCusOrdException{
		CambioPlanPendienteListDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerSolicPendPlan():start");
			resultado = service1.obtenerSolicPendPlan(cliente);
			logger.debug("obtenerSolicPendPlan():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;		
	}
		
	/** 
	 * Notifica estado de proceso de la OOSS
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public void validarActivarNumPer(CuentaPersonalDTO cuentaPersonalDTO) throws CloCusOrdException{
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validarActivarNumPer():start");
			service1.validarActivarNumPer(cuentaPersonalDTO);
			logger.debug("validarActivarNumPer():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
				
	}
	
	/** 
	 * Notifica estado de proceso de la OOSS
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */		
	public RetornoDTO validaDesactivaCuentaPersonal(CuentaPersonalDTO cuentaPersonalDTO) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("validaDesactivaCuentaPersonal():start");
			resultado = service1.validaDesactivaCuentaPersonal(cuentaPersonalDTO);
			logger.debug("validaDesactivaCuentaPersonal():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;
	}
	
	/** 
	 * Notifica estado de proceso de la OOSS
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO insertarCarta(CartaDTO carta)throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarCarta():start");
			resultado = service1.insertarCarta(carta);
			logger.debug("insertarCarta():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;	
	}
	
	/** 
	 * Notifica estado de proceso de la OOSS
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CtaPersonalEmpDTO obtenerDatosCtaPersonalCliEmp(CtaPersonalEmpDTO cta) throws CloCusOrdException{
		CtaPersonalEmpDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCtaPersonalCliEmp():start");
			resultado = service1.obtenerDatosCtaPersonalCliEmp(cta);
			logger.debug("obtenerDatosCtaPersonalCliEmp():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
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
		this.context=arg0;
	}

	/**
	 * 
	 */
	public CloCusOrdFacadeBean() {
		// TODO Auto-generated constructor stub
	}
	
	/** 
	 * Inserta números frecuentes programados
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO insertarFrecuentesProgramados(DesactServFreDTO desactServFre) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarFrecuentesProgramados():start");
			resultado = service1.insertarFrecuentesProgramados(desactServFre);
			logger.debug("insertarFrecuentesProgramados():end");
		} 
		catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;	
	}

	/** 
	 * Inserta números frecuentes online
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO insertarFrecuentesOnline (DesactServFreDTO desactServFre) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarFrecuentesOnline():start");
			resultado = service1.insertarFrecuentesOnline(desactServFre);
			logger.debug("insertarFrecuentesOnline():end");
		} 
		catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;	
	}
	
	/** 
	 * Inserta números frecuentes ff online
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO insertarFrecuentesFFOnline (DesactServFreDTO desactServFre) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarFrecuentesOnline():start");
			resultado = service1.insertarFrecuentesFFOnline(desactServFre);
			logger.debug("insertarFrecuentesOnline():end");
		} 
		catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;	
	}
	
	/** 
	 * Registra el cambio de cuotas de un cliente
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO registrarCambioCuotas(RegReordPlanDTO regReordPlanDTO) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("registrarCambioCuotas():start");
			resultado = service1.registrarCambioCuotas(regReordPlanDTO);
			logger.debug("registrarCambioCuotas():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return resultado;	
	}
	
	/** 
	 * Elimina números frecuentes online
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO eliminarFrecuentesOnLine (DesactServFreDTO desactServFre) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarFrecuentesOnLine():start");
			resultado = service1.eliminarFrecuentesOnLine(desactServFre);
			logger.debug("eliminarFrecuentesOnLine():end");
		} 
		catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;	
	}
	
	/** 
	 * Insertar frecuentes ff programados
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO insertarFrecuentesFFProgramados (DesactServFreDTO desactServFre) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("insertarFrecuentesFFProgramados():start");
			resultado = service1.insertarFrecuentesFFProgramados(desactServFre);
			logger.debug("insertarFrecuentesFFProgramados():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;	
	}
	
	/** 
	 * Actualizar Intarcel Abonado
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO actualizarIntarcelAbonado (AbonadoDTO abonado) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("actualizarIntarcelAbonado():start");
			resultado = service1.actualizarIntarcelAbonado(abonado);
			logger.debug("actualizarIntarcelAbonado():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;	
	}
	
	/** 
	 * Registrar Finciclo
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO registrarFinciclo(AbonadoDTO abonado) throws CloCusOrdException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("registrarFinciclo():start");
			resultado = service1.registrarFinciclo(abonado);
			logger.debug("registrarFinciclo():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
			return resultado;	
	}
	
	/** 
	 * Actualizar estado proceso
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public EstadoProcesoOOSSDTO  actualizarEstado(EstadoProcesoOOSSDTO estadoProcesoOOSS) throws CloCusOrdException{
		EstadoProcesoOOSSDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("actualizarEstado():start");
			retorno=service1.actualizarEstado(estadoProcesoOOSS);
			logger.debug("actualizarEstado():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;
			
	}
	
	/** 
	 * Modifica numero personal
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO modificarNumeroPersonal(CuentaPersonalDTO cuenta) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("modificarNumeroPersonal():start");
			retorno=service1.modificarNumeroPersonal(cuenta);
			logger.debug("modificarNumeroPersonal():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}
	
	/** 
	 * Obtiene numero corporativo
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public CuentaPersonalDTO obtieneNumeroCorporativo (CuentaPersonalDTO cuenta)throws CloCusOrdException{
		CuentaPersonalDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("obtieneNumeroCorporativo():start");
			retorno=service1.obtieneNumeroCorporativo(cuenta);
			logger.debug("obtieneNumeroCorporativo():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;		
	}	
	
	/** 
	 * Valida baja atlantida cliente empresa
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO validaBajaAtlEmpresa(ClienteDTO cliente) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("validaBajaAtlEmpresa():start");
			retorno=service1.validaBajaAtlEmpresa(cliente);
			logger.debug("validaBajaAtlEmpresa():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;				
	}
    //77866-INC; COL; AVC; 10-02-2009
	/** 
	 * Inserta datos de la cola en una tabla
	 * 
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *	  
	 */
	public RetornoDTO insertaTablaCola(RegistroColaDTO param)throws CloCusOrdException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);				
			logger.debug("validaBajaAtlEmpresa():start");
			retorno = service1.insertaTablaCola(param);
			logger.debug("validaBajaAtlEmpresa():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		
		return retorno;
	}
	
	//77866-FIN; COL; AVC; 10-02-2009
	

	/** 
	 * Obtener el monto que se le debe cobrar por el uso de la ooss numero frecuente mix9003
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public EventoNumFrecDTO obtenerMontoEvento(EventoNumFrecDTO eventoNumFrecDTO) throws CloCusOrdException{
		EventoNumFrecDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("obtenerMontoEvento():start");
			retorno=service1.obtenerMontoEvento(eventoNumFrecDTO);
			logger.debug("obtenerMontoEvento():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;				
	}
	
	/** 
	 * Insertar un registro por el uso de la ooss cambio de numeros frecuentes
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO insertarEventoNumFrec(EventoNumFrecDTO eventoNumFrecDTO) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("insertarEventoNumFrec():start");
			retorno=service1.insertarEventoNumFrec(eventoNumFrecDTO);
			logger.debug("insertarEventoNumFrec():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;				
	}
	
	/** 
	 * Registrar la Causa de Cambio de Plan
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO regCausaCambioPlan(CausaCambioPlanDTO causaCambioPlan) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("regCausaCambioPlan():start");
			retorno=service1.regCausaCambioPlan(causaCambioPlan);
			logger.debug("regCausaCambioPlan():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;				
	}
	
	/** 
	 * Registrar pago anticipado
	 * <!-- begin-xdoclet-definition --> 
	 * @ejb.interface-method view-type="remote"
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 *
	 * //TODO: Must provide implementation for bean method stub
	 */	
	public RetornoDTO regPagoAnticipado(PagoAnticipadoDTO pagoAnticipado) throws CloCusOrdException{
		RetornoDTO retorno = null;
		try{
			String log = global.getValor("negocio.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);				
			logger.debug("regPagoAnticipado():start");
			retorno=service1.regPagoAnticipado(pagoAnticipado);
			logger.debug("regPagoAnticipado():end");
		} catch(CloCusOrdException e){
			logger.debug("CloCusOrdException[", e);
			throw e;
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CloCusOrdException(e);
		}
		return retorno;				
	}
}
