package com.tmmas.IC.RecepcionRespuestas;


import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.tmmas.IC.Utils.ClassSocket;
import com.tmmas.IC.Utils.LecturaParametros;
import com.tmmas.IC.Utils.Utilidades;

/**
 *
 * @author Juan Ramos
 * @version $Revision$
 */

public class Receptor extends Thread {
//--->>> Variables Privadas de la Clase
/**
 * Field mSocket
 */			
    private ClassSocket   	mSocket = null;
/**
 * Field comTimeOut
 */	    
	private String        	comTimeOut;
/**
 * Field mParam
 */		
	private LecturaParametros mParam;
/**
 * Field conexionActual
 */		
	private Connection    	conexionActual;
/**
 * Field statementActual
 */		
	private Statement       statementActual;
/**
 * Field BD
 */		
	private ServicioBD   	BD = new ServicioBD();
/**
 * Field recordSet
 */		
	private ResultSet     	recordSet;
/**
 * Field mTabProcesadores
 */		
	private Vector 			mTabProcesadores;
/**
 * Field mGrupo
 */			
	private ThreadGroup 	mGrupo;
/**
 * Field numConexion
 */		
	private int numConexion;
/**
 * Field log
 */			
	private static Logger log = Logger.getLogger(Receptor.class.getName());

/**
* Field strErrorBD
 */
	public String strErrorBD = "";
	
	public RecepcionRespuestas RR = new RecepcionRespuestas();
	
//------------------------------------------------------------------------------------------//
//  Primer Constructor                                                   		    		//	
//------------------------------------------------------------------------------------------//
 /**
 * Constructor for FrontEndThread
 * @param pSocket ClassSocket
 * @param pParam FrontEndParam
 * @param pConexiones ClassSocket[]
 * @param pNomInstanciaFrontEnd String
 */
public Receptor(ThreadGroup pGrupo, ClassSocket pSocket,LecturaParametros pParam, Vector pTabProcesadores) {
		super("Receptor");
		mSocket 	= pSocket;
		mParam      = pParam;
		mTabProcesadores = pTabProcesadores;
		mGrupo = pGrupo;
	}
//------------------------------------------------------------------------------------------//
//  Metodo principal  RUN                                                		    		//	
//------------------------------------------------------------------------------------------//
 /**
 * Method run
 * @see java.lang.Runnable#run()
 */
	public void run() {
		InputStream      in	  = null;
		OutputStream     out  = null;
		DataInputStream  din  = null;
		DataOutputStream dout = null;
		try {
//--->>> Validación de la Conexión a la BD 
			if (!conectaBaseDatos()) {
				mSocket.close();
				return;
			}
			in   = mSocket.getInputStream();
			out  = mSocket.getOutputStream();
			din  = new DataInputStream( in );
			dout = new DataOutputStream( out );

//--->>> Validación del Cliente por la Conexión 
			if (!validaConexion()) {
				mSocket.close();
				cierraConeccionBD();
				return;
			}

//		mSocket.setSoTimeout(numTimeOutPlat);

		log.info("Atendiendo al Cliente : [" + mSocket.getRemoteSocketAddress() + "] con la conexion [" + (numConexion) + "]");
	
//--->>> Ciclo para escuchar las peticiones del Cliente
			String strComando = "";  
			String strSalida  = ""; 
			revisaPermiso();
			while (!mSocket.isClosed()) {
				strComando = new String(din.readLine());
				
//--->>> Revisa si el monitor está corriendo, sino lo ejecuta
				if (!RecepcionRespuestas.monitor.isAlive()) {
					RecepcionRespuestas.creaMonitor();
				}
				
//--->>> Llamada al procesamiento de la peticion entrante
				if (procesaInformacion(strComando))
				    dout.write("STATUS=OK,SUBERROR=;".getBytes());
				
			}			
//---->>> Cierre de la conexion  						
	} catch (IOException e) {
				strErrorBD = e.getMessage();
				if(RR.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
				}
				log.warn("Cierre Atencion de Cliente [" + mSocket.getRemoteSocketAddress() +  "] : --->>> [" + e.getMessage() + "] <<<---  Con la conexion [" + numConexion + "]");
				mSocket.close(); 
		} catch (Exception e2) {
				strErrorBD = e2.getMessage();
				if(RR.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
				}
				log.warn("Error en Atencion de Cliente [" + mSocket.getRemoteSocketAddress() +  "] : --->>> [" + e2.getMessage() + "] <<<---  Con la conexion [" + numConexion + "]");
				log.error("Stack Trace:",e2);
				mSocket.close();
		}
		finally {
			try {
				din.close();
				dout.close();
				in.close();
				out.close();
			} catch (IOException e) {}
			if (!mSocket.isClosed()) mSocket.close();
			cierraConeccionBD();
		}
	}

//------------------------------------------------------------------------------------------//
//  Metodo principal del Procesamiento                                  		    		//	
//------------------------------------------------------------------------------------------//
 /**
 * Method procesaInformacion
 * @param strComando String
 * @return boolean
 * @throws SQLException
 */
	private boolean procesaInformacion(String strComando)
	throws SQLException {
		try {
			Procesador procesador;
			int secuencia;
			do {
				synchronized (mTabProcesadores) {				
					for(int i=0;i<mTabProcesadores.size();i++){
						if (mTabProcesadores.elementAt(i) != null) {
							procesador = (Procesador)mTabProcesadores.elementAt(i);
							if (procesador.datos.size() < mParam.numPromedioNotificaciones) {
								log.debug("El procesador "+ procesador.id + " tiene " + procesador.datos.size() + " mensajes pendientes, se le asigna nuevo: " + strComando);
								secuencia = procesador.nuevoMid();
								long codProc = Long.decode("1" + Utilidades.formatNum(procesador.index + 1,"000") +  Utilidades.formatNum(secuencia,"000")).longValue();
								BD.putNotificacion(conexionActual,codProc,strComando);
								TypeNotificacion notif = new TypeNotificacion();
								notif.codProc      = codProc;
								notif.mensaje      = strComando;
								notif.numSecuencia = secuencia; 
								notif.tipoMensaje  = TypeNotificacion.MENSAJE_NOTIFICACION;
								procesador.datos.addElement(notif);
								return(true);
							}
						}
					}
				}
				//log.warn("No hay procesadores diponibles, se espera 1 décima de segundos");
				sleep(10);
			}while(true);
    	} catch (Exception e) {
    			strErrorBD = e.getMessage();
    			if(RR.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
				}
			log.error(" Error en procesar Informacion del Cliente [" + mSocket.getRemoteSocketAddress() +  "] : --->>> [" + e.getMessage() + "] <<<---");
			log.error("trace",e);
 			return(false);
    	}
	}

//------------------------------------------------------------------------------------------//
//  Metodo para Abrir una sesión de Oracle exclusiva para el cliente                        //
//------------------------------------------------------------------------------------------//
/**
 * Method conectaBaseDatos
 * @return boolean
 * @throws SQLException
 */
private boolean conectaBaseDatos() 
	throws SQLException {
		try {
//--->>> Conexión con la Base de Datos			
			conexionActual = BD.conectaBaseDatos(mParam.nomHostDB,  mParam.numPuertoDb,mParam.instanciaDb,
												 mParam.usuarioDb, mParam.usuariopDb);
			statementActual = BD.creaStatementConsulta(conexionActual);
			if (conexionActual == null) {
				mSocket.close();
				log.error("No se ha podido establecer la conexión con la Base de Datos ");
				return(false);		
			}
			return(true);
		} catch (SQLException e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}
			log.error("No se ha podido establecer la conexión con la Base de Datos " + e.getMessage());
			log.error("StackTrace:",e);
			return(false);
		}		
	}

//------------------------------------------------------------------------------------------//
//  Metodo para cerrar la conexión con la Base de Datos                 		    		//	
//------------------------------------------------------------------------------------------//
/**
* Method cierraConeccionBD
*  
*/
	private void cierraConeccionBD() {
		try{
			if(conexionActual!=null) {
				statementActual.close(); 
				conexionActual.close(); 
			}
		}catch(SQLException e){
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}
			log.warn("No pude liberar coneccion de Base de Datos, se libera por el GC");
			log.warn("StackTrace:",e);
		}
	}

//------------------------------------------------------------------------------------------//
//  Metodo para validar la conexion del cliente por distintos criterios 		    		//	
//------------------------------------------------------------------------------------------//
	/**
 * Method validaConexion
 * @return boolean
 * @throws SQLException
 */
private boolean validaConexion() throws SQLException {
		try {
//	--->>> Revisión de Máximo de Conexiones Globales
			if ( mGrupo.activeCount() > mParam.numMaximoClientes) {
				log.warn(" Se ha llegado al límite de conexiones: [" + mParam.numMaximoClientes + "]");
				log.warn(" El cliente: " + mSocket.getRemoteSocketAddress()  + " Es rechazado");
				return(false);
			} 
//--->>> Revisión de Ip y segmento Ip Acreditadas.			
			if (!mParam.isIpAcreditada(mSocket.getRemoteSocketAddress().toString()) ) {
				log.warn(" La IP : " + mSocket.getRemoteSocketAddress() + " no esta acreditada");
				return(false);
			}
			return(true);
		} catch (Exception e) {
			log.error("Error en validacion del cliente [" + mSocket.getRemoteSocketAddress() +  "] : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);
			return(false);
		}
	}		

/**
 * Method revisaPermiso
 *  
 */
	private synchronized void revisaPermiso() throws Exception {
		try {
			do {
				Thread.sleep(1000);
			} while (Monitor.ejecutandoPendientes);
		} catch(Exception e){
			e.printStackTrace();
		}
	}


 } //--->>> Fin de la Clase

// ******************************************************************************************
// ** Información de Versionado *************************************************************
// ******************************************************************************************
// ** Pieza                                               : 
// **  %ARCHIVE%
// ** Identificador en PVCS                               : 
// **  %PID%
// ** Producto                                            : 
// **  %PP%
// ** Revisión                                            : 
// **  %PR%
// ** Autor de la Revisión                                :          
// **  %AUTHOR%
// ** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : 
// **  %PS%
// ** Fecha de Creación de la Revisión                    : 
// **  %DATE% 
// ** Worksets ******************************************************************************
// ** %PIRW%
// ** Historia ******************************************************************************
// ** %PL%
// ******************************************************************************************


