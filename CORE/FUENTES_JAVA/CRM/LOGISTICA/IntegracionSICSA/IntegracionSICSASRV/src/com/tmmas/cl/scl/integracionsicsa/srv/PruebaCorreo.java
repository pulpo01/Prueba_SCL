package com.tmmas.cl.scl.integracionsicsa.srv;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

class PruebaCorreo {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		try {
			
			
			
			double number = 3.33;
			System.out.println(number);
			
			/*StringBuffer c = new StringBuffer();
			c.append("<!DOCTYPE html PUBLIC "
					+"<html>"
						+"<head>"
						+"<style>"
						+"body {font-family:Verdana, Arial, Helvetica, sans-serif;"
						+"font-size:11px;"
						+"color:#000000;"
						+"}				"		
						+"table { width:100%;"
						+"border:0px;"
						+"border-spacing:1px;"
						+"}						"
						+"table td { padding:2px;"
						+"font-size:9px;"
						+"color:#043795;"
						+"vertical-align:top;"
						+"font-family:Verdana, Arial, Helvetica, sans-serif;"
						+"}"
						+".cabecera { background-color:#ADC4F8;"
						+"width:15%;"
						+"font-weight: bolder;"
						+"}"
						+".cuerpo { background-color:#D7E2FD;"
						+"width:85%;"
						+"}			"			
						+"</"
						+"style>"
						+"</head>"
						+"<body>Estimados,<br><br><br> &nbsp &nbsp Se le informa que el proceso [1] de registro de ventas a externos ha finalizado con exito.<br><br>Saludos Cordiales <br><br> SCL <br><br> <b>Este mail es generado de manera automática, favor no responder. <br>Si es necesario contactar a Movistar Costa Rica</b>"
						+"</body>"
						+"</html>"
						);
			
			enviarCorreo("pruebaKay",c.toString());*/
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	public static void enviarCorreo(String subject, String texto) throws Exception{
		Properties propCorreo = null;
		MimeMessage message = null;
		String[] mailDestinos = null;
		String mailDestino;
		try{
			propCorreo = new Properties();	
			// Nombre del host de correo
			propCorreo.put("mail.smtp.host","10.231.128.86");
			// TLS si está disponible
			propCorreo.setProperty("mail.smtp.starttls.enable", "true");
			// Puerto de gmail para envio de correos
			propCorreo.setProperty("mail.smtp.port","25");
			// Nombre del usuario
			propCorreo.setProperty("mail.smtp.user","prueba@prueba.com");
			// Si requiere o no usuario y password para conectarse.
			propCorreo.setProperty("mail.smtp.auth", "false");
			
			mailDestino = "kvv200@gmail.com,kveraval@everis.com";
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
			message.setFrom(new InternetAddress("prueba@prueba.com"));
			
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
			t.connect();
			t.sendMessage(message,message.getAllRecipients());
			t.close();
		}catch(Exception e){
			e.printStackTrace();			
		}		
	}


}
