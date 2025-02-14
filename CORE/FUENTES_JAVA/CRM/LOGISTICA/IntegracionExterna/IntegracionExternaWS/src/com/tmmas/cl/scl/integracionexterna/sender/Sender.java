package com.tmmas.cl.scl.integracionexterna.sender;

/**
 * La clase Sender contiene la implementaci&oacute;n del envio de mensajes a una cola.
 *
 */
import javax.jms.JMSException;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import com.tmmas.cl.scl.integracionexterna.common.dto.ws.EntradaIntegracionExternaDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionexterna.common.helper.LoggerHelper;

public class Sender {
	private ObjectMessage message;
	private QueueSender queueSender;
	private QueueConnection queueConnection;
	private QueueSession queueSession;
	private GlobalProperties global = GlobalProperties.getInstance();
	//private final Logger logger = Logger.getLogger(this.getClass());
	private final LoggerHelper logger = LoggerHelper.getInstance();
	public Sender() throws IntegracionExternaException {
		init();
	}
	private void init() throws IntegracionExternaException{
		try {
			InitialContext jndiContext = getInitialContext();
			QueueConnectionFactory queueConnectionFactory = (QueueConnectionFactory)jndiContext.lookup(global.getValorExterno("GE.jndi.connection.factory"));
			Queue queue = (Queue) jndiContext.lookup(global.getValorExterno("GE.jndi.queue.envio"));
			queueConnection = queueConnectionFactory.createQueueConnection();
			queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			queueSender = queueSession.createSender(queue);
			message = queueSession.createObjectMessage();
		} catch (NamingException e) {
			e.printStackTrace();
			loggerError(e.getMessage());
			throw new IntegracionExternaException("ERR.0004", 211, global.getValor("ERR.0004"));
		} catch (JMSException e) {
			e.printStackTrace();
			loggerError(e.getMessage());
			throw new IntegracionExternaException("ERR.0004", 211, global.getValor("ERR.0004"));
		}
	}
	
	public InitialContext getInitialContext() throws NamingException{
		return new InitialContext();
	}
	
	public void send(EntradaIntegracionExternaDTO dto, String numOperacion, int numServicio) throws IntegracionExternaException {
		String jmsCorrelationID = numOperacion;
		
		try {
			message.setJMSCorrelationID(jmsCorrelationID);
			message.setIntProperty("servicio", numServicio);
			message.setObject(dto);
			queueSender.send(message);
			
			loggerInfo("Mensaje enviado");
			loggerInfo("JMSCorrelationID: "+message.getJMSCorrelationID());
		} catch (JMSException e) {
			e.printStackTrace();
			loggerError(e.getMessage());
			throw new IntegracionExternaException("ERR.0004", 211, global.getValor("ERR.0004"));
		} finally {
				try {
					queueSender.close();
				} catch (JMSException e) {
					e.printStackTrace();
				}
				try {
					queueSession.close();
				} catch (JMSException e) {
					e.printStackTrace();
				}
				try {
					queueConnection.close();
				} catch (JMSException e) {
					e.printStackTrace();
				}
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
	
}
