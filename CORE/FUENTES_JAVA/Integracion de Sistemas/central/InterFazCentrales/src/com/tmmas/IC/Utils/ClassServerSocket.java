package com.tmmas.IC.Utils;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.security.KeyStore;
import java.security.SecureRandom;

import javax.net.ssl.KeyManagerFactory;
import javax.net.ssl.SSLContext;
import javax.net.ssl.SSLServerSocket;
import javax.net.ssl.SSLServerSocketFactory;
import javax.net.ssl.SSLSocket;
import javax.net.ssl.TrustManagerFactory;

import org.apache.log4j.Logger;


/**
 *
 * @author mwt00178
 * @version $Revision$ 
 */
public class ClassServerSocket {
	/**
	 * Field log
	 */
	private static Logger log = Logger.getLogger(ClassServerSocket.class.getName());
	/**
	 * Field serSSLSocket
	 */
	private SSLServerSocket serSSLSocket;
	/**
	 * Field serSocket
	 */
	private ServerSocket    serSocket;
	/**
	 * Field tipoSocket
	 */
	private int tipoSocket                = -1;
	
	/**
	 * Field SOCKET_NORMAL
	 * (value is 0)
	 * Value: {@value SOCKET_NORMAL}
	 */
	public static final int SOCKET_NORMAL = 0;
	/**
	 * Field SOCKET_SSL
	 * (value is 1)
	 * Value: {@value SOCKET_SSL}
	 */
	public static final int SOCKET_SSL    = 1;

	
/**
 * Constructor for ClassServerSocket
 * Constructor para inicialización nula del socket
 */
	public ClassServerSocket() {
		serSocket = null;				
	}


/**
 * Constructor for ClassServerSocket
 * Constructor para la creación automática del Socket
 * @param numPuerto int
 * @param nomKeyStore String
 * @param tSocket int
 */
	public ClassServerSocket(int numPuerto, String nomKeyStore, int tSocket) {
		open(numPuerto,nomKeyStore,tSocket);
	}
	
/**
 * Method open
 * Metodo para crear el socket de tipo normal o SSL
 * @param numPuerto int
 * @param nomKeyStore String
 * @param tSocket int
 * @return boolean
 */
	public boolean open(int numPuerto, String nomKeyStore, int tSocket) {
		try {
			tipoSocket = tSocket;
			if (tipoSocket == SOCKET_SSL) {
				serSSLSocket = createServerSocket(numPuerto,nomKeyStore); 
				serSSLSocket.setNeedClientAuth(true);
			} else if (tipoSocket == SOCKET_NORMAL) { 
				serSocket = new ServerSocket(numPuerto);
			} else {
				log.error(" El tipo de Socket no corresponde");
				return(false);			
			}
			return(true);
		}catch (Exception e) {
			log.error(" Error al Crear Sockect: --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);
			return(false);
		}
	  }

/**
 * Method accept
 * Metodo para aceptar una conexión
 * @return ClassSocket
 */
	public ClassSocket accept() {
		try {
			if (tipoSocket == SOCKET_SSL) {
				ClassSocket socket = new ClassSocket((SSLSocket)serSSLSocket.accept());
				return(socket);
			} else if (tipoSocket == SOCKET_NORMAL) {
				ClassSocket socket = new ClassSocket(serSocket.accept());
				return(socket);
			} else {
				log.error(" El tipo de Socket no corresponde");
				return(null);			
			}
		} catch (IOException e) {
			log.error(" Error al aceptar conexión : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);
			return(null);
		}
	}

/**
 * Method createServerSocket
 * Metodo para crear el socket SSL  
 * @param port int El puerto Utilizado.
 * @param nomKeyStore String
 * @return SSLServerSocket
 * @throws Exception
 */
	public SSLServerSocket createServerSocket(int port, String nomKeyStore)
	  throws Exception
	  { 
		  KeyStore    clientKeyStore;
		  KeyStore    serverKeyStore;
		  SSLContext  sslContext;
		  SecureRandom aSecureRandom = new SecureRandom();
		  String KS_PASSWORD = "serverpass";
		  String KEY_PASSWORD = "passppal";

		  try {
			  clientKeyStore = KeyStore.getInstance( "JKS" );
			  clientKeyStore.load( new FileInputStream(nomKeyStore), KS_PASSWORD.toCharArray() );
			  serverKeyStore = KeyStore.getInstance( "JKS" );
			  serverKeyStore.load( new FileInputStream(nomKeyStore), KS_PASSWORD.toCharArray() );
			   
			  TrustManagerFactory tmf = TrustManagerFactory.getInstance( "SUNX509" );
			  tmf.init( clientKeyStore );
			  KeyManagerFactory kmf = KeyManagerFactory.getInstance( "SUNX509" );
			  kmf.init( serverKeyStore, KEY_PASSWORD.toCharArray() );
			  sslContext = SSLContext.getInstance( "TLS" );
			  sslContext.init( kmf.getKeyManagers(), tmf.getTrustManagers(), aSecureRandom );        

			  SSLServerSocketFactory sf = sslContext.getServerSocketFactory();
			 
			  return (SSLServerSocket)sf.createServerSocket(port);
			                           
		  } catch (Exception e) {
			  log.error(" Error al iniciar Socket Seguro (Certificacion): --->>> [" + e.getMessage() + "] <<<---");
			  log.error("StackTrace:",e);
			  return(null);
		  }
	  }

/**
 * Method close
 * Metodo para cerrar el Serversocket
 * @return boolean
 */
	public boolean close() {
		  try {
			  if (tipoSocket == SOCKET_SSL) 
				  serSSLSocket.close();
			  else if (tipoSocket == SOCKET_NORMAL)
				  serSocket.close();
			  else {
				  log.error(" El tipo de Socket no corresponde");
				  return(false);			
			  }
			  return(true);
		  } catch (Exception e) {
			  log.error(" Error al cerrar el ServerSockect: --->>> [" + e.getMessage() + "] <<<---");
			  log.error("StackTrace:",e);
			  return(false);
		  }
	}
}

//******************************************************************************************
//** Información de Versionado *************************************************************
//******************************************************************************************
//** Pieza                                               : 
//**  %ARCHIVE%
//** Identificador en PVCS                               : 
//**  %PID%
//** Producto                                            : 
//**  %PP%
//** Revisión                                            : 
//**  %PR%
//** Autor de la Revisión                                :          
//**  %AUTHOR%
//** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : 
//**  %PS%
//** Fecha de Creación de la Revisión                    : 
//**  %DATE% 
//** Worksets ******************************************************************************
//** %PIRW%
//** Historia ******************************************************************************
//** %PL%
//******************************************************************************************


