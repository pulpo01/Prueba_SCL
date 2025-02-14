/**
 * 2008 - Proyecto: ServiciosSCLFranquiciasWSWEB
 */
package com.tmmas.scl.wsventaenlace.delegate;

import javax.jms.JMSException;
import javax.jms.ObjectMessage;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueReceiver;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.naming.InitialContext;
import javax.naming.NamingException;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSFase2DTO;


public class ConsultaOrdenServicio {
	//private FranquiciasLoggerHelper logger = FranquiciasLoggerHelper.getInstance();
	private GlobalProperties global = GlobalProperties.getInstance();
	private final Logger logger = Logger.getLogger(this.getClass());
	
	public ConsultaOrdenServicio(){
		
	}
	public OOSSFase2DTO consultarOrdenServicio(OOSSFase2DTO oossdto) {
		InitialContext jndiContext;
		logger.info("consultarOrdenServicio:start();");
		OOSSFase2DTO oossdtoRespuesta = new OOSSFase2DTO();
		try {
			jndiContext = new InitialContext();
			QueueConnectionFactory queueConnectionFactory = (QueueConnectionFactory)jndiContext.lookup(global.getValorExterno("GE.jndi.connection.factory"));
			
			QueueConnection queueConnection = queueConnectionFactory.createQueueConnection();
			QueueSession queueSession = queueConnection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
			
			Queue queue2 = (Queue) jndiContext.lookup(global.getValorExterno("GE.jndi.queue.respuesta"));
			
			String selector = "JMSCorrelationID = '"+oossdto.getNumTransaccion()+"'";
			QueueReceiver receiver = queueSession.createReceiver(queue2, selector);
			
			queueConnection.start();
			
			logger.debug("Recibiendo respuesta");

			ObjectMessage respuesta = (ObjectMessage)receiver.receive(1000);
			if(respuesta!=null){
				logger.debug("JMSCorrelationID: "+respuesta.getJMSCorrelationID());
				oossdto = (OOSSFase2DTO) respuesta.getObject();
				if(oossdto!=null){
					logger.debug("CodError: "+oossdto.getCodError());
					logger.debug("DesError: "+oossdto.getDesError());
					logger.debug("OOSS: "+oossdto.getNroOOSS());
					oossdtoRespuesta.setCodError(oossdto.getCodError());
					oossdtoRespuesta.setDesError(oossdto.getDesError());
					oossdtoRespuesta.setNroOOSS(oossdto.getNroOOSS());
					logger.debug("Respuesta encontrada");
				}else{
					oossdtoRespuesta.setCodError("ERR.0464");
					oossdtoRespuesta.setDesError(global.getValor("ERR.0464"));
					logger.debug("Respuesta no valida");
				}
			}else{
				oossdtoRespuesta.setCodError("ERR.0465");
				oossdtoRespuesta.setDesError(global.getValor("ERR.0465"));
				logger.debug("Respuesta no encontrada");
			}
			queueConnection.close();
		} catch (NamingException e) {
			e.printStackTrace();
			oossdtoRespuesta.setCodError("ERR.0466");
			oossdtoRespuesta.setDesError(global.getValor("ERR.0466"));
		} catch (JMSException e) {
			e.printStackTrace();
			oossdtoRespuesta.setCodError("ERR.0466");
			oossdtoRespuesta.setDesError(global.getValor("ERR.0465"));
		} catch (SecurityException e) {
			e.printStackTrace();
			oossdtoRespuesta.setCodError("ERR.0466");
			oossdtoRespuesta.setDesError(global.getValor("ERR.0465"));
		} catch (IllegalStateException e) {
			e.printStackTrace();
			oossdtoRespuesta.setCodError("ERR.0466");
			oossdtoRespuesta.setDesError(global.getValor("ERR.0465"));
		}
		logger.info("consultarOrdenServicio:end();");
		return oossdtoRespuesta;
	}
}
