/**
 * 
 */
package com.tmmas.gte.pagoonlineejb.session;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionContext;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;

/**
 *
 * <!-- begin-user-doc -->
 * A generated session bean
 * <!-- end-user-doc -->
 * *
 * <!-- begin-xdoclet-definition --> 
 * @ejb.bean name="PagoOnLineFacade"	
 *           description="An EJB named PagoOnLineFacade"
 *           display-name="PagoOnLineFacade"
 *           jndi-name="PagoOnLineFacade"
 *           type="Stateless" 
 *           transaction-type="Container"
 * 
 * <!-- end-xdoclet-definition --> 
 * @generated
 */

public class PagoOnLineFacadeBean implements javax.ejb.SessionBean {
	private static final long serialVersionUID = 1L;
	private CompositeConfiguration config;
	private static Logger logger = Logger.getLogger(PagoOnLineFacadeBean.class);
	
	
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
	 */
	public PagoOnLineFacadeBean() {
		config = UtilProperty.getConfiguration("PagoOnLine.properties", "com/tmmas/gte/pagoonlineejb/properties/PagoOnLineEJB.properties");
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
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO aplicarPagoOnLine(com.tmmas.gte.pagoonlinecommon.dto.PagoDTO inParam0) throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException {
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO respuesta = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaPagoDTO();
		com.tmmas.gte.pagoonlineservice.srv.PagoOnLineService pagoService = new com.tmmas.gte.pagoonlineservice.srv.PagoOnLineServiceImpl();
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO resp = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();
		
		UtilLog.setLog(config.getString("PagoOnLineEJB.log"));
		
		try{
		
			logger.debug("aplicaPagoOnLine():start");			
			if (!(inParam0.getTipoOperacion().equals(config.getString("tipOperacionIN")))){				
				resp.setCodigoError(-1);
				resp.setMensajeError("Tipo de Operacion Incorrecto");
				resp.setNumeroEvento("0");				
				respuesta.setStatus(config.getString("statusError"));
				respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
				respuesta.setRespuesta(resp);
				return respuesta;	
			}
			if ((inParam0.getMontoChequeBanco() + inParam0.getMontoChequeOtroBanco() + inParam0.getMontoEfectivo() + inParam0.getMontoTarjetaCredito() + inParam0.getMontoTarjetaDebito()) == 0){
				resp.setCodigoError(-1);
				resp.setMensajeError("No viene Monto del Pago");
				resp.setNumeroEvento("0");
				respuesta.setStatus(config.getString("statusError"));
				respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
				respuesta.setRespuesta(resp);				
				return respuesta;									
			}
			if (inParam0.getMontoTotalOperacion() != (inParam0.getMontoChequeBanco() + inParam0.getMontoChequeOtroBanco() + inParam0.getMontoEfectivo() + inParam0.getMontoTarjetaCredito() + inParam0.getMontoTarjetaDebito())) {
				resp.setCodigoError(-1);
				resp.setMensajeError("Total Operacion Incorrecto");
				resp.setNumeroEvento("0");
				respuesta.setStatus(config.getString("statusError"));
				respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
				respuesta.setRespuesta(resp);				
				return respuesta;					
			}
			
			if (inParam0.getMontoTotalOperacion() <= 0) {
				resp.setCodigoError(-1);
				resp.setMensajeError("Total Operacion Incorrecto");
				resp.setNumeroEvento("0");
				respuesta.setStatus(config.getString("statusError"));
				respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
				respuesta.setRespuesta(resp);				
				return respuesta;					
			}
			
			if (!(inParam0.getBancoTarjetaDebito().equals(""))) {
				if (inParam0.getMontoTarjetaDebito()<=0) {
					resp.setCodigoError(-1);
					resp.setMensajeError("Falta ingresar Monto Tarjeta de Debito");
					resp.setNumeroEvento("0");
					respuesta.setStatus(config.getString("statusError"));
					respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
					respuesta.setRespuesta(resp);				
					return respuesta;
				} 
			}else {
				if (inParam0.getMontoTarjetaDebito()>0){
					resp.setCodigoError(-1);
					resp.setMensajeError("Falta ingresar Banco de Tarjeta de Debito");
					resp.setNumeroEvento("0");
					respuesta.setStatus(config.getString("statusError"));
					respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
					respuesta.setRespuesta(resp);				
					return respuesta;					
				}
			}
			
			if (!(inParam0.getTipTarjeta().equals(""))) {
				if (inParam0.getNumTarjeta().equals("")){
					resp.setCodigoError(-1);
					resp.setMensajeError("Falta ingresar Numero de Tarjeta de Credito");
					resp.setNumeroEvento("0");
					respuesta.setStatus(config.getString("statusError"));
					respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
					respuesta.setRespuesta(resp);				
					return respuesta;					
				}
				if (inParam0.getNumAutorizacion().equals("")){
					resp.setCodigoError(-1);
					resp.setMensajeError("Falta ingresar Numero de Autorizacion");
					resp.setNumeroEvento("0");
					respuesta.setStatus(config.getString("statusError"));
					respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
					respuesta.setRespuesta(resp);				
					return respuesta;						
				}
				
				if (inParam0.getMontoTarjetaCredito()<=0){
					resp.setMensajeError("Falta ingresar Monto Tarjeta de Credito");
					resp.setNumeroEvento("0");
					respuesta.setStatus(config.getString("statusError"));
					respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
					respuesta.setRespuesta(resp);				
					return respuesta;					
				}
			} else {
				if (!(inParam0.getNumTarjeta().equals(""))){
					resp.setCodigoError(-1);
					resp.setMensajeError("Falta ingresar Datos de Tarjeta de Credito");
					resp.setNumeroEvento("0");
					respuesta.setStatus(config.getString("statusError"));
					respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
					respuesta.setRespuesta(resp);				
					return respuesta;					
				}
				if (!(inParam0.getNumAutorizacion().equals(""))){
					resp.setCodigoError(-1);
					resp.setMensajeError("Falta ingresar Datos de Tarjeta de Credito");
					resp.setNumeroEvento("0");
					respuesta.setStatus(config.getString("statusError"));
					respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
					respuesta.setRespuesta(resp);				
					return respuesta;						
				}				
				if (inParam0.getMontoTarjetaCredito()>0){
					resp.setMensajeError("Falta ingresar Datos Tarjeta de Credito");
					resp.setNumeroEvento("0");
					respuesta.setStatus(config.getString("statusError"));
					respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
					respuesta.setRespuesta(resp);				
					return respuesta;					
				}
			}
			respuesta = pagoService.aplicaPagoOnLine(inParam0);
			respuesta.setTipoOperacion(config.getString("tipOperacionOUT"));
			if (respuesta.getRespuesta().getCodigoError()!=0){
				respuesta.setStatus(config.getString("statusError"));
			}else{
				respuesta.setStatus(config.getString("statusOK"));
			}
			logger.debug("aplicaPagoOnLine():end");
		} catch (com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException(e);
		}		
		return respuesta;		
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
	public com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO reversarPagoOnLine(com.tmmas.gte.pagoonlinecommon.dto.ReversaDTO inParam0) throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException {
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO respuesta = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaReversaDTO();
		com.tmmas.gte.pagoonlineservice.srv.PagoOnLineService reversaService = new com.tmmas.gte.pagoonlineservice.srv.PagoOnLineServiceImpl();
		com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO resp = new com.tmmas.gte.pagoonlinecommon.dto.RespuestaDTO();
		
		UtilLog.setLog(config.getString("PagoOnLineEJB.log"));
		
		try{
		
			logger.debug("reversarPagoOnLine():start");			
			if (!(inParam0.getTipoOperacion().equals(config.getString("tipOperacionReversaIN")))){				
				resp.setCodigoError(-1);
				resp.setMensajeError("Tipo de Operacion Incorrecto");
				resp.setNumeroEvento("0");				
				respuesta.setStatus(config.getString("statusErrorReversa"));
				respuesta.setTipoOperacion(config.getString("tipOperacionReversaOUT"));
				respuesta.setRespuesta(resp);
				return respuesta;	
			}
			if (inParam0.getMontoTotalOperacion() <= 0) {
				resp.setCodigoError(-1);
				resp.setMensajeError("Monto Operacion Incorrecto");
				resp.setNumeroEvento("0");
				respuesta.setStatus(config.getString("statusErrorReversa"));
				respuesta.setTipoOperacion(config.getString("tipOperacionReversaOUT"));
				respuesta.setRespuesta(resp);				
				return respuesta;					
			}
						
			respuesta = reversaService.reversarPagoOnLine(inParam0);
			respuesta.setTipoOperacion(config.getString("tipOperacionReversaOUT"));
			if (respuesta.getRespuesta().getCodigoError()!=0){
				respuesta.setStatus(config.getString("statusErrorReversa"));
			}else{
				respuesta.setStatus(config.getString("statusOK"));
			}
			logger.debug("reversaPagoOnLine():end");
		} catch (com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException e) {
			logger.debug("ProyectoException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException(e);
		}		
		return respuesta;		
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

	}

}
