/**
 * Copyright © 2011 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 * 
 * 
 **/
package com.tmmas.cl.scl.integracionexterna.srv;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.tmmas.cl.scl.integracionexterna.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionexterna.common.helper.LoggerHelper;


public class IntegracionExternaSRV {

    private final LoggerHelper logger = LoggerHelper.getInstance();
    private GlobalProperties global = GlobalProperties.getInstance();

    private String remitenteMail;
    private String destinosMail;
    private String ipSMTP;

    public void loggerDebug(String mensaje) {
        logger.debug(mensaje, this.getClass().getName());
    }

    public void loggerInfo(String mensaje) {
        logger.info(mensaje, this.getClass().getName());
    }

    public String getRemitenteMail() {
		return remitenteMail;
	}

	public void setRemitenteMail(String remitenteMail) {
		this.remitenteMail = remitenteMail;
	}

	public String getDestinosMail() {
		return destinosMail;
	}

	public void setDestinosMail(String destinosMail) {
		this.destinosMail = destinosMail;
	}

	public String getIpSMTP() {
		return ipSMTP;
	}

	public void setIpSMTP(String ipSMTP) {
		this.ipSMTP = ipSMTP;
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
    
    public void enviarCorreo(String subject, String texto) throws Exception{
		Properties propCorreo = null;
		MimeMessage message = null;
		String[] mailDestinos = null;
		String mailDestino;
		try{
			propCorreo = new Properties();	
			// Nombre del host de correo
			loggerDebug("IP: "+ipSMTP);
			propCorreo.put("mail.smtp.host",ipSMTP);
			// TLS si está disponible
			propCorreo.setProperty("mail.smtp.starttls.enable", "true");
			// Puerto de gmail para envio de correos
			propCorreo.setProperty("mail.smtp.port",global.getValorExterno("GE.puerto.mail"));
			loggerDebug("remitenteMail: "+global.getValorExterno("GE.puerto.mail"));
			// Nombre del usuario
			propCorreo.setProperty("mail.smtp.user",remitenteMail);
			loggerDebug("remitenteMail: "+remitenteMail);
			// Si requiere o no usuario y password para conectarse.
			propCorreo.setProperty("mail.smtp.auth", "false");
			
			mailDestino = destinosMail;
			loggerDebug("mailDestinos: "+ mailDestino);
			String[] mailDestinAux = null;
			
			if(mailDestino.indexOf(",") != 1){
				mailDestinAux = mailDestino.split(",");
			}else{
				mailDestinAux = new String[1];
				mailDestinAux[0] = mailDestino;
			}
			mailDestinos = mailDestinAux;
			
			Session session = Session.getDefaultInstance(propCorreo);
			// Para obtener un log de salida más extenso
			session.setDebug(true);
			
			message = new MimeMessage(session);
			
			// Quien envia el correo
			message.setFrom(new InternetAddress(remitenteMail));
			
			// A quien va dirigido
			InternetAddress address[] = new InternetAddress[mailDestinos.length];			
			for( int i = 0; i != mailDestinos.length; i++ ) {
	            address[i] = new InternetAddress ( mailDestinos[i] );
	        } 			
			message.setRecipients (Message.RecipientType.TO, address);

			message.setSubject(subject);
			message.setContent(texto,"text/html");
			Transport t = session.getTransport("smtp");
			
			// Aqui usuario y password de gmail
			try{
				t.connect();
				t.sendMessage(message,message.getAllRecipients());
				t.close();
			}catch (MessagingException e){
				loggerDebug("No se envio correo");
				loggerDebug("Error Correo: ["+e+"]");
				t.close();
				e.printStackTrace();
			}
		}catch(Exception e){
			e.printStackTrace();	
			loggerDebug("Error Correo: ["+e+"]");
		}		
	}
}
