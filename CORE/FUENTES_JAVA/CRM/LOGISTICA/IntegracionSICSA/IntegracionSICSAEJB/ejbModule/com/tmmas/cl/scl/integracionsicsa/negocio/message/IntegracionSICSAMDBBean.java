/**
 * 
 */
package com.tmmas.cl.scl.integracionsicsa.negocio.message;

import javax.jms.ObjectMessage;

import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosCorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.VentaInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.srv.GeneralSRV;
import com.tmmas.cl.scl.integracionsicsa.srv.SerieVendidaTercerosSRV;

/**
 * La clase IntegracionSICSAMDBBean representa el bean que gestiona los mensajes
 * de la cola de entrada en la ejecuci&oacute;n de los servicios.
 * El m&eacute;todo onMessage es llamado al activarse el bean.
 * 
 * <!-- begin-xdoclet-definition -->
 * @ejb.bean name="IntegracionSICSAMDB"    
 *     destination-type="javax.jms.Queue"
 *     
 *     transaction-type="Container"
 *
 *  @ejb.transaction type="Required"
 *  
 * @weblogic:pool initial-beans-in-free-pool="1"
 *     max-beans-in-free-pool="1"
 *
 * @weblogic:message-driven destination-jndi-name="IntegracionSICSAQueue"
 *     connection-factory-jndi-name="IntegracionSICSACF"
 *
 * @weblogic:transaction-descriptor trans-timeout-seconds = "2000"
 *
 * <!-- end-xdoclet-definition -->
 * @generated
 * 
 * @author	Hugo Olivares
 * @version	1.0, 03/09/2011
 **/

public class IntegracionSICSAMDBBean implements javax.ejb.MessageDrivenBean,
		javax.jms.MessageListener {
	
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private GlobalProperties global = GlobalProperties.getInstance();

	/** 
	 * <!-- begin-xdoclet-definition --> 
	 * <!-- end-xdoclet-definition --> 
	 * @generated
	 */
	private static final long serialVersionUID = 1L;

	/** 
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * The context for the message-driven bean, set by the EJB container. 
	 * @generated
	 */
	private javax.ejb.MessageDrivenContext messageContext = null;

	/** 
	 * Required method for container to set context.
	 * @generated 
	 */
	public void setMessageDrivenContext(
			javax.ejb.MessageDrivenContext messageContext)
			throws javax.ejb.EJBException {
		this.messageContext = messageContext;
	}

	/** 
	 * Required creation method for message-driven beans. 
	 *
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 *
	 * <!-- begin-xdoclet-definition -->
	 * @ejb.create-method 
	 * <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public void ejbCreate() {
		//no specific action required for message-driven beans 
	}

	/** 
	 * Required removal method for message-driven beans. 
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void ejbRemove() {
		messageContext = null;
	}

	/** 
	 * This method implements the business logic for the EJB. 
	 * 
	 * <p>Make sure that the business logic accounts for asynchronous message processing. 
	 * For example, it cannot be assumed that the EJB receives messages in the order they were 
	 * sent by the client. Instance pooling within the container means that messages are not 
	 * received or processed in a sequential order, although individual onMessage() calls to 
	 * a given message-driven bean instance are serialized. 
	 * 
	 * <p>The <code>onMessage()</code> method is required, and must take a single parameter 
	 * of type javax.jms.Message. The throws clause (if used) must not include an application 
	 * exception. Must not be declared as final or static. 
	 *
	 * <!-- begin-user-doc -->
	 * <!-- end-user-doc -->
	 * @generated
	 */
	public void onMessage(javax.jms.Message message) {
		loggerDebug("Se inicia onMessage:" + message);
		EntradaIntegracionSICSADTO inDTO = null;
		int numServicio;
		try{
			numServicio=message.getIntProperty("servicio");
			loggerDebug("Servicio: "+numServicio);
			if (message instanceof ObjectMessage) {
				ObjectMessage objectMessage = (ObjectMessage) message; 
				inDTO = (EntradaIntegracionSICSADTO)objectMessage.getObject();
				if(null!=inDTO){
					switch(numServicio){
					case 0:
						registrarLineasSeriesCeltics(inDTO,Integer.parseInt(objectMessage.getJMSCorrelationID()));
						break;
					case 1:
						devolverLineasSeriesCeltics(inDTO,Integer.parseInt(objectMessage.getJMSCorrelationID()));
						break;
					default:
						break;
					}
				}
			}
		}catch (Throwable e) {
			e.printStackTrace();
			loggerError("Error en la ejecucion del servicio, realizando rollback");
			messageContext.setRollbackOnly();
		}
		loggerDebug("Finaliza:" + message);
	}

	/**
	 * 
	 */
	public IntegracionSICSAMDBBean() {
		// TODO Auto-generated constructor stub
	}
	
	
	private void registrarLineasSeriesCeltics(EntradaIntegracionSICSADTO inDTO,int numOperacion) throws IntegracionSICSAException{
		loggerDebug("NUM_OPERACION QUE VIENE DE LA COLA: "+numOperacion);
		SerieVendidaTercerosSRV serieVendidaTercerosSRV = new SerieVendidaTercerosSRV();
		//Rescatar datos para el correo
		try{
	    GeneralSRV generalSRV = new GeneralSRV();
		DatosCorreoDTO correoDTO = generalSRV.getDatosCorreo(getValorInterno("mail.param.correos"));
		serieVendidaTercerosSRV.setIpSMTP(correoDTO.getIpSmtp());
		serieVendidaTercerosSRV.setRemitenteMail(correoDTO.getRemitenteMail());
		serieVendidaTercerosSRV.setDestinosMail(correoDTO.getDestinosMail());
		}catch(IntegracionSICSAException e){
			loggerError("Ocurrió un error al intentar recuperar los datos para enviar correo electronico "+e);
			e.printStackTrace();
		}
		
		
		//TODO Actualizar estado a PROCESANDO
		VentaInDTO ventaInDTO = (VentaInDTO)inDTO;
		serieVendidaTercerosSRV.actualizarEstadoProceso("PROCESANDO", numOperacion);
		try {
			String asunto=getValorInterno("mail.asunto.venta.corriendo").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
			String correo=getValorInterno("mail.correo.venta.corriendo").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
			serieVendidaTercerosSRV.enviarCorreo(asunto,getValorInterno("mail.html.antes")+correo+getValorInterno("mail.html.despues"));
		} catch (Exception e1) {
			loggerError("Ocurrió un error al intentar enviar correo electronico "+e1);
			e1.printStackTrace();
		}
		try{
			serieVendidaTercerosSRV.registrarLineasSeries(ventaInDTO, numOperacion);
			//TODO Actualizar estado a FINALIZADO
			serieVendidaTercerosSRV.actualizarEstadoProceso("FINALIZADO", numOperacion);
			try {
				String asunto=getValorInterno("mail.asunto.venta.final").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
				String correo=getValorInterno("mail.correo.venta.final").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso()).replace("[2]", String.valueOf(ventaInDTO.getSerieDTOs().length));
				serieVendidaTercerosSRV.enviarCorreo(asunto,getValorInterno("mail.html.antes")+correo+getValorInterno("mail.html.despues"));
			} catch (Exception e1) {
				loggerError("Ocurrió un error al intentar enviar correo electronico "+e1);
				e1.printStackTrace();
			}
		}catch(IntegracionSICSAException e){
			//TODO Actualizar estado a ERRONEO
			loggerError("ERROR PROCESANDO LA COLA");
			loggerError(e.getCodigo());
			loggerError(e.getDescripcionEvento());
			serieVendidaTercerosSRV.actualizarEstadoProceso("ERRONEO", numOperacion);
			try {
				String asunto=getValorInterno("mail.asunto.venta.error").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
				String correo=getValorInterno("mail.correo.venta.error").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());;
				serieVendidaTercerosSRV.enviarCorreo(asunto,getValorInterno("mail.html.antes")+correo+e.getDescripcionEvento()+getValorInterno("mail.html.despues"));
			} catch (Exception e1) {
				loggerError("Ocurrió un error al intentar enviar correo electronico "+e1);
				e1.printStackTrace();
			}			
			throw e;
		}
		
		
	}
	
	
	
	private void devolverLineasSeriesCeltics(EntradaIntegracionSICSADTO inDTO,int numOperacion) throws IntegracionSICSAException{
		loggerDebug("NUM_OPERACION QUE VIENE DE LA COLA: "+numOperacion);
		SerieVendidaTercerosSRV serieVendidaTercerosSRV = new SerieVendidaTercerosSRV();
		
		//Rescatar datos para el correo
		try{			
	    GeneralSRV generalSRV = new GeneralSRV();
		DatosCorreoDTO correoDTO = generalSRV.getDatosCorreo(getValorInterno("mail.param.correos"));
		serieVendidaTercerosSRV.setIpSMTP(correoDTO.getIpSmtp());
		serieVendidaTercerosSRV.setRemitenteMail(correoDTO.getRemitenteMail());
		serieVendidaTercerosSRV.setDestinosMail(correoDTO.getDestinosMail());
		}catch(IntegracionSICSAException e){
			loggerError("Ocurrió un error al intentar recuperar los datos para enviar correo electronico "+e);
			e.printStackTrace();
		}
		
		VentaInDTO ventaInDTO = (VentaInDTO)inDTO;
		serieVendidaTercerosSRV.actualizarEstadoProceso("PROCESANDO", numOperacion);
		try {
			String asunto=getValorInterno("mail.asunto.dev.corriendo").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
			String correo=getValorInterno("mail.correo.dev.corriendo").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
			serieVendidaTercerosSRV.enviarCorreo(asunto,getValorInterno("mail.html.antes")+correo+getValorInterno("mail.html.despues"));
		} catch (Exception e1) {
			loggerError("Ocurrió un error al intentar enviar correo electronico "+e1);
			e1.printStackTrace();
		}
		try{
			serieVendidaTercerosSRV.devolverSeries(ventaInDTO, numOperacion);
			//TODO Actualizar estado a FINALIZADO
			serieVendidaTercerosSRV.actualizarEstadoProceso("FINALIZADO", numOperacion);
			try {
				String asunto=getValorInterno("mail.asunto.dev.final").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
				String correo=getValorInterno("mail.correo.dev.final").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso()).replace("[2]", String.valueOf(ventaInDTO.getSerieDTOs().length));
				serieVendidaTercerosSRV.enviarCorreo(asunto,getValorInterno("mail.html.antes")+correo+getValorInterno("mail.html.despues"));
			} catch (Exception e1) {
				loggerError("Ocurrió un error al intentar enviar correo electronico "+e1);
				e1.printStackTrace();
			}
		}catch(IntegracionSICSAException e){
			//TODO Actualizar estado a ERRONEO
			loggerError("ERROR PROCESANDO LA COLA");
			loggerError(e.getCodigo());
			loggerError(e.getDescripcionEvento());
			serieVendidaTercerosSRV.actualizarEstadoProceso("ERRONEO", numOperacion);
			try {
				String asunto=getValorInterno("mail.asunto.dev.error").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
				String correo=getValorInterno("mail.correo.dev.error").replace("[1]",ventaInDTO.getVentaEncabezadoDTO().getNumProceso());
				serieVendidaTercerosSRV.enviarCorreo(asunto,getValorInterno("mail.html.antes")+correo+e.getDescripcionEvento()+getValorInterno("mail.html.despues"));
			} catch (Exception e1) {
				loggerError("Ocurrió un error al intentar enviar correo electronico "+e1);
				e1.printStackTrace();
			}			
			throw e;
		}
		
		
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
	public String getValorInterno(String propertie) {
        return global.getValor(propertie);
    }

    public String getValorExterno(String propertie) {
        return global.getValorExterno(propertie);
    }
}
