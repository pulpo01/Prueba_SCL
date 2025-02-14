/*
 * @(#)Sender.java 2008
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

package com.tmmas.scl.wsventaenlace.sender;

/**
 * La clase Sender contiene la implementaci&oacute;n del envio de mensajes a una cola.
 *
 * @author   Ricardo Quezada
 * @version 1.0, 07/07/2008
 * @cambio  Versión Inicial
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

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSFase2DTO;



public class Sender {
	private ObjectMessage message;
	private QueueSender queueSender;
	private QueueConnection queueConnection;
	private QueueSession queueSession;
	private GlobalProperties globalProperties = GlobalProperties.getInstance();
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final static String nomClase = Sender.class.getName();
	public Sender() throws ServicioVentasEnlaceException {
		init();
	}
	private void init() throws ServicioVentasEnlaceException{
		try {
			InitialContext jndiContext = getInitialContext();
			QueueConnectionFactory queueConnectionFactory = (QueueConnectionFactory)jndiContext.lookup(globalProperties.getValorExterno("GE.jndi.connection.factory"));
			Queue queue = (Queue) jndiContext.lookup(globalProperties.getValorExterno("GE.jndi.queue.envio"));
			queueConnection = queueConnectionFactory.createQueueConnection();
			queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			queueSender = queueSession.createSender(queue);
			message = queueSession.createObjectMessage();
		} catch (NamingException e) {
			e.printStackTrace();
			logger.error(e, nomClase);
			throw new ServicioVentasEnlaceException("ERR.0004", 4, globalProperties.getValor("ERR.0004"));
		} catch (JMSException e) {
			e.printStackTrace();
			logger.error(e, nomClase);
			throw new ServicioVentasEnlaceException("ERR.0004", 4, globalProperties.getValor("ERR.0004"));
		}
	}
	
	public InitialContext getInitialContext() throws NamingException{
		return new InitialContext();
	}
	
	public void send(OOSSFase2DTO oossdto) throws ServicioVentasEnlaceException {
		String jmsCorrelationID = oossdto.getNumTransaccion();
		
		try {
			message.setJMSCorrelationID(jmsCorrelationID);
			message.setIntProperty("servicio", oossdto.getServicio());
			message.setObject(oossdto);
			queueSender.send(message);
			
			logger.info("Mensaje enviado",nomClase);
			logger.info("JMSCorrelationID: "+message.getJMSCorrelationID(),nomClase);
		} catch (JMSException e) {
			e.printStackTrace();
			logger.error(e, nomClase);
			throw new ServicioVentasEnlaceException("ERR.0004", 4, globalProperties.getValor("ERR.0004"));
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
	
}
