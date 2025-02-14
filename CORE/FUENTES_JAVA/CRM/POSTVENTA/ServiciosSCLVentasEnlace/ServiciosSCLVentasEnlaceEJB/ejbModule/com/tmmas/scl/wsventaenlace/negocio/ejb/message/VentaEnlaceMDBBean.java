/*
 * @(#)VentaEnlaceMDBBean.java 2008
 *
 * Copyright 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 */

package com.tmmas.scl.wsventaenlace.negocio.ejb.message;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.naming.InitialContext;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.service.servicios.AsociaDesasociaRangoSrv;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSFase2DTO;

/**
 * La clase VentaEnlaceMDBBean representa el bean que gestiona los mensajes de la cola de entrada en la ejecuci&oacute;n de una orden de servicio. El m&eacute;todo onMessage es llamado al activarse el bean.
 * 
 * <!-- begin-xdoclet-definition -->
 * 
 * @ejb.bean name="VentaEnlaceMDB" acknowledge-mode="Auto-acknowledge" destination-type="javax.jms.Queue"
 * 
 * transaction-type="Container"
 * 
 * @ejb.transaction type="Required"
 * 
 * @weblogic:pool initial-beans-in-free-pool="3" max-beans-in-free-pool="6"
 * 
 * @weblogic:message-driven destination-jndi-name="VentaEnlaceQueue" connection-factory-jndi-name="VentaEnlaceCF"
 * 
 * @weblogic:transaction-descriptor trans-timeout-seconds = "240"
 * 
 * <!-- end-xdoclet-definition -->
 * @generated
 * 
 * @author Ricardo Quezada
 * @version 1.0, 01/07/2008
 */

public class VentaEnlaceMDBBean implements javax.ejb.MessageDrivenBean, javax.jms.MessageListener {
	/**
	 * 
	 */
	private static final long serialVersionUID = -4949873382158770297L;

	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final static String nomClase = VentaEnlaceMDBBean.class.getName();

	private GlobalProperties global = GlobalProperties.getInstance();

	/**
	 * <!-- begin-user-doc --> <!-- end-user-doc --> The context for the message-driven bean, set by the EJB container.
	 * 
	 * @generated
	 */
	private javax.ejb.MessageDrivenContext messageContext = null;

	/**
	 * Required method for container to set context.
	 * 
	 * @generated
	 */
	public void setMessageDrivenContext(javax.ejb.MessageDrivenContext messageContext) throws javax.ejb.EJBException {
		this.messageContext = messageContext;
	}

	/**
	 * Required creation method for message-driven beans.
	 * 
	 * <!-- begin-user-doc --> <!-- end-user-doc -->
	 * 
	 * <!-- begin-xdoclet-definition -->
	 * 
	 * @ejb.create-method <!-- end-xdoclet-definition -->
	 * @generated
	 */
	public void ejbCreate() {
		// no specific action required for message-driven beans
	}

	/**
	 * Required removal method for message-driven beans. <!-- begin-user-doc --> <!-- end-user-doc -->
	 * 
	 * @generated
	 */
	public void ejbRemove() {
		messageContext = null;
	}

	/**
	 * This method implements the business logic for the EJB.
	 * 
	 * <p>
	 * Make sure that the business logic accounts for asynchronous message processing. For example, it cannot be assumed that the EJB receives messages in the order they were sent by the client. Instance pooling within the container means that messages are not received or processed in a sequential order, although individual onMessage() calls to a given message-driven bean instance are serialized.
	 * 
	 * <p>
	 * The <code>onMessage()</code> method is required, and must take a single parameter of type javax.jms.Message. The throws clause (if used) must not include an application exception. Must not be declared as final or static.
	 * 
	 * <!-- begin-user-doc --> <!-- end-user-doc -->
	 * 
	 * @generated
	 */
	public void onMessage(Message message) {
		int peticion;
		OOSSFase2DTO oossdto = null;
		String codError = null;
		String desError = null;

		try {
			peticion = message.getIntProperty("servicio");
			logger.debug("Servicio: " + peticion, nomClase);

			if (message instanceof ObjectMessage) {
				ObjectMessage objectMessage = (ObjectMessage) message;
				oossdto = (OOSSFase2DTO) objectMessage.getObject();
				codError = oossdto.getCodError();
				desError = oossdto.getDesError();
				oossdto.setCodError(null);
				oossdto.setDesError(null);

				if (oossdto != null) {
					switch (peticion) {
					case 0:
						oossdto = ejecucionAsociaRango(oossdto);

						logger.debug("MDB: " + oossdto, nomClase);

						break;

					case 1:
						// oossdto = ejecucionAnulaBajaVpn(oossdto);
						break;

					case 2:
						// oossdto = ejecutarBajaLineasVPNDTO(oossdto);
						break;

					default:
						break;
					}

					if (oossdto != null) {
						if (oossdto.getCodError() != null)
							throw new ServicioVentasEnlaceException();

						if (oossdto.getCodError() == null) {
							oossdto.setCodError(codError);
							oossdto.setDesError(desError);
						}
					}
				}
			}
		} catch (Throwable e) {
			e.printStackTrace();
			logger.error("Error en la ejecucion del servicio, realizando rollback", nomClase);
			messageContext.setRollbackOnly();
		}

		enviarRespuesta(oossdto);
	}

	private OOSSFase2DTO ejecucionAsociaRango(OOSSFase2DTO oossdto) {
		logger.info("ejecucionAsociaRango():start MDB", nomClase);

		try {
			AsociaDesasociaRangoSrv asociaRangoSrv = new AsociaDesasociaRangoSrv();

			oossdto = (OOSSFase2DTO) asociaRangoSrv.ejecutarOS(oossdto);
		} catch (Throwable e) {
			e.printStackTrace();
		}

		logger.info(":ejecucionAsociaRango():end MDB", nomClase);

		return oossdto;
	}

	private void enviarRespuesta(OOSSFase2DTO oossdto) {
		// envio de respuesta
		if (oossdto == null) {
			System.out.println("OOSSDTO nulo, no se envía respuesta");
			logger.error("OOSSDTO nulo, no se envía respuesta", nomClase);
			return;
		}

		OOSSFase2DTO fase2DTO = null;
		QueueConnection queueConnection = null;
		QueueSession queueSession = null;
		QueueSender queueSender = null;
		try {
			InitialContext jndiContext = new InitialContext();

			QueueConnectionFactory queueConnectionFactory = (QueueConnectionFactory) jndiContext.lookup(global.getValorExterno("GE.jndi.connection.factory"));
			Queue queue = (Queue) jndiContext.lookup(global.getValorExterno("GE.jndi.queue.respuesta"));

			queueConnection = queueConnectionFactory.createQueueConnection();
			// Se debe setear a true, para indicar que la sesión es transaccional
			queueSession = queueConnection.createQueueSession(true, Session.AUTO_ACKNOWLEDGE);
			queueSender = queueSession.createSender(queue);

			fase2DTO = new OOSSFase2DTO();
			fase2DTO.setCodError(oossdto.getCodError());
			fase2DTO.setDesError(oossdto.getDesError());
			fase2DTO.setNroOOSS(oossdto.getNroOOSS());
			fase2DTO.setNumTransaccion(oossdto.getNumTransaccion());
			// mje 1
			ObjectMessage respuesta = queueSession.createObjectMessage();
			respuesta.setJMSCorrelationID(oossdto.getNumTransaccion());
			respuesta.setObject(fase2DTO);
			System.out.println("Enviando mensaje de respuesta");
			logger.debug("Enviando mensaje de respuesta:Transacción: " + respuesta.getJMSCorrelationID(), nomClase);
			logger.debug("Enviando mensaje de respuesta", nomClase);
			queueSender.send(respuesta);
			queueSession.commit();
			logger.debug("Respuesta enviada", nomClase);
			System.out.println("Respuesta enviada");
		} catch (Throwable e) {
			e.printStackTrace();
			logger.error(e, nomClase);
		} finally {
			try {
				if (queueSender != null)
					queueSender.close();
			} catch (JMSException e) {
				e.printStackTrace();
				logger.error("Error al cerrar queueSender", nomClase);
			}
			try {
				if (queueSession != null)
					queueSession.close();
			} catch (JMSException e) {
				e.printStackTrace();
				logger.error("Error al cerrar queueSession", nomClase);
			}
			try {
				if (queueConnection != null)
					queueConnection.close();
			} catch (JMSException e) {
				e.printStackTrace();
				logger.error("Error al cerrar queueConnection", nomClase);
			}
		}
	}

	/**
	 * 
	 */
	public VentaEnlaceMDBBean() {
	}
}
