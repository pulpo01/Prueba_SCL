/**
 * 
 */
package com.tmmas.cl.scl.integracionsicsa.negocio.message;

import javax.jms.ObjectMessage;

import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosCorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.LineaErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.srv.GeneralSRV;
import com.tmmas.cl.scl.integracionsicsa.srv.TraspasoSRV;
 
/**
 * La clase IntegracionSICSAMDBBean representa el bean que gestiona los mensajes
 * de la cola de entrada en la ejecuci&oacute;n de los servicios.
 * El m&eacute;todo onMessage es llamado al activarse el bean.
 * 
 * <!-- begin-xdoclet-definition -->
 * @ejb.bean name="TraspasoSeriesMDB"    
 *     destination-type="javax.jms.Queue"
 *     
 *     transaction-type="Container"
 *
 *  @ejb.transaction type="Required"
 *  
 * @weblogic:pool initial-beans-in-free-pool="1"
 *     max-beans-in-free-pool="1"
 *
 * @weblogic:message-driven destination-jndi-name="TraspasoSerieQueue"
 *     connection-factory-jndi-name="IntegracionSICSACF"
 *
 * @weblogic:transaction-descriptor trans-timeout-seconds = "3000"
 *
 * <!-- end-xdoclet-definition -->
 * @generated
 * 
 * 
 **/
public class TraspasoSeriesMDBBean implements javax.ejb.MessageDrivenBean,
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
		loggerDebug("Se inicia onMessage TraspasoSeriesMDBBean: " + message);
		EntradaIntegracionSICSADTO inDTO = null;
		int numServicio;
		try{
			numServicio = message.getIntProperty("servicio");
			loggerDebug("Numero Servicio: "+numServicio);
			if (message instanceof ObjectMessage) {
				ObjectMessage objectMessage = (ObjectMessage) message; 
				inDTO = (EntradaIntegracionSICSADTO)objectMessage.getObject();
				if(null!=inDTO){
					switch(numServicio){
					case 0:
						//Aca se invoca al servicio de Traspaso
						traspasoSeries(inDTO);						
					default:
						break;
					}
				}
			}
		}catch (Throwable e) {
			e.printStackTrace();
			loggerError("ERROR: ");
			loggerError(e.getMessage());
			loggerError("Error en la ejecucion del servicio, realizando rollback");
			messageContext.setRollbackOnly();
		}
		loggerDebug("Finaliza:" + message);
	}

	/**
	 * 
	 */
	public TraspasoSeriesMDBBean() {
		// TODO Auto-generated constructor stub
	}
	
	private void traspasoSeries(EntradaIntegracionSICSADTO inDTO) throws IntegracionSICSAException, Exception{
		TraspasoSRV traspasoSRV = new TraspasoSRV();
		String subject = null;
		String texto = null;
		try{
			EntradaTraspasoDTO traspasoDTO = (EntradaTraspasoDTO)inDTO;
			traspasoSRV.traspasoSeries(traspasoDTO);
			//Si el Traspaso fue ingresado con exito
			loggerError("Se envia correo de Exito");
			subject = global.getValor("mail.subject.traspaso.final").replace("[nP]", traspasoDTO.getNumTraspaso());
			texto = global.getValor("mail.html.antes") + global.getValor("mail.correo.traspaso.final").replace("[nP]",traspasoDTO.getNumTraspaso())+
					global.getValor("mail.html.despues.traspaso");
			loggerDebug(texto);				
			enviarCorreo(subject, texto);
			loggerError("Despues de Enviar Correo Exitoso");
			
		}catch(IntegracionSICSAException e){
			if(e.getCodigo().equals("ERR.0020")){
				EntradaTraspasoDTO traspasoDTO = (EntradaTraspasoDTO)inDTO;
				StringBuffer mensajeError = new StringBuffer("");
				/*Elimina las Series de la tabla AL_SER_TRASPASO*/
				traspasoSRV.elimiSerTraspaso(traspasoDTO.getNumTraspaso());
				/*Elimina las lineas de la tabla AL_LIN_TRASPASO*/
				traspasoSRV.elimiLineaTraspaso(traspasoDTO.getNumTraspaso());
				LineaErrorDTO[] lineaErrorDTO = null;
				lineaErrorDTO = traspasoSRV.obtieneErrorLineaTemp(traspasoDTO.getNumTraspaso());
				for (int i = 0; i <= lineaErrorDTO.length - 1; i++) {
					mensajeError.append("<br>&nbsp &nbsp &nbsp &nbsp - Articulo  <b>[" + lineaErrorDTO[i].getCodArticulo()
							+ "]</b> tiene el siguiente Error: <b>" + lineaErrorDTO[i].getDesErrorLinea()+"</b>, la cantidad ingresada" +
									" = <b>"+ lineaErrorDTO[i].getCantidadIngresada()+"</b>, y la cantidad esperada = <b>"+ lineaErrorDTO[i].getCantidadEsperada()+"</b>");					
				}
				
				SerieErrorDTO[] serieErrorDTO = null;				
				serieErrorDTO = traspasoSRV.obtieneErrorSerieTemp(traspasoDTO.getNumTraspaso());				
								
				for (int i = 0; i <= serieErrorDTO.length - 1; i++) {
					mensajeError.append("<br>&nbsp &nbsp &nbsp &nbsp - Serie  <b>[" + serieErrorDTO[i].getNumSerie()
							+ "]</b> tiene el siguiente Error: <b>" + serieErrorDTO[i].getDesErrorSerie()+"</b>");					
				}			
				//Se envia Correo con el Listado de Error 
				loggerError("Antes de Enviar Correo con Error");				
				subject = global.getValor("mail.subject.traspaso.error").replace("[nP]", traspasoDTO.getNumTraspaso());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.traspaso.erroneos").replace("[nP]",traspasoDTO.getNumTraspaso())+
						mensajeError.toString()+global.getValor("mail.despues.traspaso.error")+global.getValor("mail.html.despues.traspaso");
				loggerDebug(texto);				
				enviarCorreo(subject, texto);
				loggerError("Despues de Enviar Correo con Error");
				//messageContext.setRollbackOnly();
			}else{
				//Otro Tipo de Error
				loggerError("Antes de Enviar Correo con Error");
				EntradaTraspasoDTO traspasoDTO = (EntradaTraspasoDTO)inDTO;
				/*Elimina las Series de la tabla AL_SER_TRASPASO*/
				traspasoSRV.elimiSerTraspaso(traspasoDTO.getNumTraspaso());
				/*Elimina las lineas de la tabla AL_LIN_TRASPASO*/
				traspasoSRV.elimiLineaTraspaso(traspasoDTO.getNumTraspaso());
				subject = global.getValor("mail.subject.traspaso.error").replace("[nP]", traspasoDTO.getNumTraspaso());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.traspaso.error").replace("[nP]",traspasoDTO.getNumTraspaso()).replace("[dError]", e.getDescripcionEvento())+
						global.getValor("mail.despues.traspaso.error")+global.getValor("mail.html.despues.traspaso");
				loggerDebug(texto);				
				enviarCorreo(subject, texto);
				loggerError("Despues de Enviar Correo con Error");
				//messageContext.setRollbackOnly();
			}
			
			throw e;
		}
	}
	
	private void enviarCorreo(String subject, String texto)throws Exception {
		GeneralSRV generalSRV = new GeneralSRV();
		TraspasoSRV traspasoSRV = new TraspasoSRV();
		DatosCorreoDTO correoDTO = generalSRV.getDatosCorreo(global.getValor("mail.traspaso.correos"));
		traspasoSRV.setIpSMTP(correoDTO.getIpSmtp());
		traspasoSRV.setRemitenteMail(correoDTO.getRemitenteMail());
		traspasoSRV.setDestinosMail(correoDTO.getDestinosMail());		
		traspasoSRV.enviarCorreo(subject, texto);		
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
