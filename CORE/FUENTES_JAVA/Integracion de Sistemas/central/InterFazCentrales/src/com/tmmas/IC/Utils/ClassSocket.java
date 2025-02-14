package com.tmmas.IC.Utils;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.Socket;
import java.net.SocketAddress;

import javax.net.ssl.SSLSession;
import javax.net.ssl.SSLSocket;

import org.apache.log4j.Logger;

/**
 *
 * @author mwt00178
 * @version $Revision$
 */
public class ClassSocket {
	/**
	 * Field log
	 */
	private static Logger log = Logger.getLogger(ClassSocket.class.getName());	
	/**
	 * Field SSLsocket
	 */
	private SSLSocket 		SSLsocket;
	/**
	 * Field socket
	 */
	private Socket    		socket;	
	/**
	 * Field tipoSocket
	 */
	public  int             tipoSocket = -1;
	/**
	 * Field tag
	 */
	public  int             tag=0;
	/**
	 * Field SOCKET_NORMAL
	 * (value is 0)
	 */
	public static final int SOCKET_NORMAL = 0;
	/**
	 * Field SOCKET_SSL
	 * (value is 1)
	 */
	public static final int SOCKET_SSL    = 1;	

/**
 * Constructor for ClassSocket
 * Primer constructor, crea un socket normal a partir de un accept
 * @param ss Socket
 */
ClassSocket(Socket ss){
		try {
			socket = ss;
			tipoSocket = SOCKET_NORMAL;
		} catch(Exception e) {
			log.error(" Error al crear el socket : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);
		}
	}

/**
 * Constructor for ClassSocket
 * Segundo constructor, crea un socket SSL a partir de un accept
 * @param ss SSLSocket
 */
ClassSocket(SSLSocket ss){
		try {
			SSLsocket = ss;
			tipoSocket = SOCKET_SSL;
		} catch(Exception e) {
			log.error(" Error al crear el SSLsocket : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);;
		}
	}

/**
 * Method getInputStream
 * Metodo para retornar un InputStream
 * @return InputStream
 */
public InputStream getInputStream() {
		  try {
			  if (tipoSocket == SOCKET_SSL) 
				  return(SSLsocket.getInputStream());
			  else if (tipoSocket == SOCKET_NORMAL)
				  return(socket.getInputStream());
			  else {
				  log.error(" El tipo de Socket no corresponde");
				  return(null);			
			  }
		  } catch (IOException e) {
			  log.error(" Error al crear un getInputStream : --->>> [" + e.getMessage() + "] <<<---");
			  log.error("StackTrace:",e);;
			  return(null);
		  }
	  }
	
/**
 * Method getOutputStream
 * Metodo para retornar un OutputStream
 * @return OutputStream
 */
public OutputStream getOutputStream() {
	  try {
		  if (tipoSocket == SOCKET_SSL) 
			  return(SSLsocket.getOutputStream());
		  else if (tipoSocket == SOCKET_NORMAL)
			  return(socket.getOutputStream());
		  else {
			  log.error(" El tipo de Socket no corresponde");
			  return(null);			
		  }
	  } catch (IOException e) {
		  log.error(" Error al crear un getOutputStream : --->>> [" + e.getMessage() + "] <<<---");
		  log.error("StackTrace:",e);;
		  return(null);
	  }
  }
	
/**
 * Method getRemoteSocketAddress
 * Metodo para retornar un RemoteSocketAddress
 * @return SocketAddress
 */
public SocketAddress getRemoteSocketAddress() {
		try {
			if (tipoSocket == SOCKET_SSL) 
				return(SSLsocket.getRemoteSocketAddress() );
			  
			else if (tipoSocket == SOCKET_NORMAL) 
				return(socket.getRemoteSocketAddress() );
			  
			else {
				log.error(" El tipo de Socket no corresponde" );
				return(null);			
			}
		} catch (Exception e)  {
			log.error(" Error al crear un RemoteSocketAddress : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);;
			return(null);
		}
	}
	
/**
 * Method isClosed
 * Metodo para detectar si el socket está cerrado 
 * @return boolean
 */
public boolean isClosed() {
		try {
			if (tipoSocket == SOCKET_SSL) 
				return(SSLsocket.isClosed());
		  
			else if (tipoSocket == SOCKET_NORMAL) 
				return(socket.isClosed());
		  
			else {
				log.error(" El tipo de Socket no corresponde" );
				return(false);			
			}
		} catch (Exception e)  {
			log.error(" Error al verificar si esta cerrado el socket : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);;
			return(false);
		}
	}

/**
 * Method isConnected
 * Metodo para detectar si el socket está conectado 
 * @return boolean
 */
public boolean isConnected() {
		  try {
			  if (tipoSocket == SOCKET_SSL) 
				  return(SSLsocket.isConnected());
		  
			  else if (tipoSocket == SOCKET_NORMAL) 
				  return(socket.isConnected());
		  
			  else {
				  log.error(" El tipo de Socket no corresponde" );
				  return(false);			
			  }
		  } catch (Exception e)  {
			  log.error(" Error al verificar si esta conectado el socket : --->>> [" + e.getMessage() + "] <<<---");
			  log.error("StackTrace:",e);;
			  return(false);
		  }
	  }

/**
 * Method isBound
 * Metodo para detectar si el socket está Bound
 * @return boolean
 */
public boolean isBound() {
		try {
			if (tipoSocket == SOCKET_SSL) 
				return(SSLsocket.isBound());
	  
			else if (tipoSocket == SOCKET_NORMAL) 
				return(socket.isBound());
	  
			else {
				log.error(" El tipo de Socket no corresponde" );
				return(false);			
			}
		} catch (Exception e)  {
			log.error(" Error al verificar si esta Bound el socket : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);;
			return(false);
		}
	}

/**
 * Method isInputShutdown
 * Metodo para detectar si el socket está InputShutdown
 * @return boolean
 */
public boolean isInputShutdown() {
		try {
			  if (tipoSocket == SOCKET_SSL) 
				  return(SSLsocket.isInputShutdown());
	  
			  else if (tipoSocket == SOCKET_NORMAL) 
				  return(socket.isInputShutdown());
	  
			  else {
				  log.error(" El tipo de Socket no corresponde" );
			  	return(false);			
		  	  }
	  	} catch (Exception e)  {
		  	log.error(" Error al verificar si esta InputShutdown el socket : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);;
			return(false);
		 }
	  }

/**
 * Method isOutputShutdown
 * Metodo para detectar si el socket está OutputShutdown
 * @return boolean
 */
public boolean isOutputShutdown() {
	  try {
			if (tipoSocket == SOCKET_SSL) 
				return(SSLsocket.isOutputShutdown());
  
			else if (tipoSocket == SOCKET_NORMAL) 
				return(socket.isOutputShutdown());
  
			else {
				log.error(" El tipo de Socket no corresponde" );
			  return(false);			
			}
	  } catch (Exception e)  {
		  log.error(" Error al verificar si esta InputShutdown el socket : --->>> [" + e.getMessage() + "] <<<---");
		  log.error("StackTrace:",e);;
		  return(false);
	   }
	}

/**
 * Method getSession
 * Metodo para retornar una sesion SS
 * @return SSLSession
 */
public SSLSession getSession() {
		try {
			  if (tipoSocket == SOCKET_SSL) 
				  return(SSLsocket.getSession());
  			  else {
				  log.error(" El tipo de Socket no corresponde, debe SSL" );
				  return(null);
			  }
		} catch (Exception e)  {
			log.error(" Error al retornar la sesión SSL del socket : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);;
			return(null);
		 }
	  }

/**
 * Method close
 * Metodo para cerrar el socket
 * @return boolean
 */
public boolean close() {
		try {
			if (tipoSocket == SOCKET_SSL) 
				SSLsocket.close();
			else if (tipoSocket == SOCKET_NORMAL)
				socket.close();
			else {
				log.error(" El tipo de Socket no corresponde");
				return(false);			
			}
			return(true);
		} catch (Exception e) {
			log.error(" Error al cerrar Sockect: --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);;
			return(false);
		}
	}

/**
 * Method setSoTimeout
 * Metodo para setear el TimeOut
 * @param timeOut int
 * @return boolean
 */
public boolean setSoTimeout(int timeOut) {
		  try {
			  if (tipoSocket == SOCKET_SSL) 
				  SSLsocket.setSoTimeout(timeOut);
			  else if (tipoSocket == SOCKET_NORMAL)
				  socket.setSoTimeout(timeOut);
			  else {
				  log.error(" El tipo de Socket no corresponde");
				  return(false);			
			  }
			  return(true);
		  } catch (Exception e) {
			  log.error(" Error al setear el time out: --->>> [" + e.getMessage() + "] <<<---");
			  log.error("StackTrace:",e);;
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
