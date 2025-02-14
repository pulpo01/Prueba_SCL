/**
 * 
 */
package com.tmmas.cl.scl.integracionsicsa.negocio.message;

import javax.jms.ObjectMessage;

import com.tmmas.cl.scl.integracionsicsa.common.dto.DatosCorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.EntradaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.PedidoInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.srv.GeneralSRV;
import com.tmmas.cl.scl.integracionsicsa.srv.PedidoSRV;


/**
 * La clase IntegracionSICSAMDBBean representa el bean que gestiona los mensajes
 * de la cola de entrada en la ejecuci&oacute;n de los servicios.
 * El m&eacute;todo onMessage es llamado al activarse el bean.
 * 
 * <!-- begin-xdoclet-definition -->
 * @ejb.bean name="PedidoSICSAMDB"    
 *     destination-type="javax.jms.Queue"
 *     
 *     transaction-type="Container"
 *
 *  @ejb.transaction type="Required"
 *  
 * @weblogic:pool initial-beans-in-free-pool="1"
 *     max-beans-in-free-pool="1"
 *
 * @weblogic:message-driven destination-jndi-name="PedidoSICSAQueue"
 *     connection-factory-jndi-name="IntegracionSICSACF"
 *
 * @weblogic:transaction-descriptor trans-timeout-seconds = "2000"
 *
 * <!-- end-xdoclet-definition -->
 * @generated
 * 
 * 
 **/

public class PedidoSICSAMDBBean implements javax.ejb.MessageDrivenBean,
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
		loggerDebug("Se inicia onMessage PedidoSICSAMDBBean: " + message);
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
						registraSeries(inDTO);
					default:
						break;
					}
				}
			}
		}catch (Throwable e) {
			e.printStackTrace();
			//loggerError("Error en la ejecucion del servicio, realizando rollback");
			//messageContext.setRollbackOnly();
		}
		loggerDebug("Finaliza:" + message);
	}

	/**
	 * 
	 */
	public PedidoSICSAMDBBean() {
		// TODO Auto-generated constructor stub
	}
	
	private void registraSeries(EntradaIntegracionSICSADTO inDTO) throws IntegracionSICSAException, Exception{
		PedidoSRV pedidoSRV = new PedidoSRV();
		String subject = null;
		String texto = null;
		try{
			PedidoInDTO pedidoInDTO = (PedidoInDTO)inDTO;
			pedidoSRV.registraSeries(pedidoInDTO);	
			//Si la Serie Fue Ingresada con Exito se Envia Correo con una Notificacion de Exito
			loggerError("Se envia correo de Exito");
			subject = global.getValor("mail.subject.pedido.final").replace("[nP]", pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
			texto = global.getValor("mail.html.antes") + global.getValor("mail.correo.pedido.final").replace("[nP]",pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido())+
					global.getValor("mail.html.despues");
			loggerDebug(texto);				
			enviarCorreo(subject, texto);
			loggerError("Despues de Enviar Correo Exitoso");
			
		}catch(IntegracionSICSAException e){
			loggerError("Error en la ejecucion del servicio");
			if(e.getCodigo().equals("ERR.0002")){
				PedidoInDTO pedidoInDTO = (PedidoInDTO)inDTO;
				//Series quedaron con error en la tabla NP_VALIDACION_SERIES_TO
				//Se obtiene Listado con las series que estan con error y el tipo de error con el cual quedo registrado
				SerieErrorDTO[] serieErrorDTO = null;				
				serieErrorDTO = pedidoSRV.obtieneSeriesErroneas(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				//Se Insertan datos en la tabla temporal NP_VAL_SERIES_TEMP_TO P-CSR-11017 JLGN
				pedidoSRV.InsertaSeriePedidoTemp(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				//Elimina pedido de la tabla NPT_VALIDACION_SERIES_TO P-CSR-11017 JLGN
				pedidoSRV.borrarSeriePedido(pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				
				StringBuffer mensajeError = new StringBuffer("");
				
				for (int i = 0; i <= serieErrorDTO.length - 1; i++) {
					mensajeError.append("<br>&nbsp &nbsp &nbsp &nbsp - Serie  <b>[" + serieErrorDTO[i].getNumSerie()
							+ "]</b> tiene el siguiente Error: <b>" + serieErrorDTO[i].getDesErrorSerie()+"</b>");					
				}			
				//Se envia Correo con el Listado de Error 
				loggerError("Antes de Enviar Correo con Error");				
				subject = global.getValor("mail.subject.pedido.error").replace("[nP]", pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.pedidos.erroneos").replace("[nP]",pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido())+
						mensajeError.toString()+global.getValor("mail.despues.pedido.error")+global.getValor("mail.html.despues");
				loggerDebug(texto);				
				enviarCorreo(subject, texto);
				loggerError("Despues de Enviar Correo con Error");
			}else{
				//Otro Tipo de Error
				loggerError("Antes de Enviar Correo con Error");
				PedidoInDTO pedidoInDTO = (PedidoInDTO)inDTO;
				subject = global.getValor("mail.subject.pedido.error").replace("[nP]", pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido());
				texto = global.getValor("mail.html.antes") + global.getValor("mail.antes.pedido.error").replace("[nP]",pedidoInDTO.getPedidoEncabezadoDTO().getCodPedido()).replace("[dError]", e.getDescripcionEvento())+
						global.getValor("mail.despues.pedido.error")+global.getValor("mail.html.despues");
				loggerDebug(texto);				
				enviarCorreo(subject, texto);
				loggerError("Despues de Enviar Correo con Error");
			}		
		}	
	}
	
	private void enviarCorreo(String subject, String texto)throws Exception {
		GeneralSRV generalSRV = new GeneralSRV();
		PedidoSRV pedidoSRV = new PedidoSRV();
		DatosCorreoDTO correoDTO = generalSRV.getDatosCorreo(global.getValor("mail.pedido.correos"));
		pedidoSRV.setIpSMTP(correoDTO.getIpSmtp());
		pedidoSRV.setRemitenteMail(correoDTO.getRemitenteMail());
		pedidoSRV.setDestinosMail(correoDTO.getDestinosMail());		
		pedidoSRV.enviarCorreo(subject, texto);		
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
