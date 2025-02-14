package com.tmmas.IC.RecepcionRespuestas;
/**
 * Clase ser ejecutada como Thread desde el Monitor y procesar las Renotificaciones
 * cada cierto tiempo, según lo establecido en el archivo de configuración.
 * @author Juan Ramos
 * @version $Revision$
 */
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.apache.log4j.Logger;

import com.tmmas.IC.Utils.LecturaParametros;


public class ProcesaRenotificaciones extends Thread {
/**
 * Field mParam
 */		  
	private LecturaParametros mParam;
/**
 * Field log
 */		  
	private static Logger log = Logger.getLogger(ProcesaRenotificaciones.class.getName());	
/**
 * Field BD
 */		  
	private ServicioBD	BD = new ServicioBD();
/**
 * Field conexionActual
 */		  
	private Connection  conexionActual;
/**
 * Field statementActual
 */		  
	private Statement   statementActual;

/**
* Field strErrorBD
 */
	public String strErrorBD = null;
	
	public RecepcionRespuestas RR = new RecepcionRespuestas();
	
/**
 * Constructor for Procesador
 * @param pParam LecturaParametros
 */	
	ProcesaRenotificaciones (LecturaParametros pParam) {
		super("ProcesaRenotificaciones");
		this.setPriority(Thread.MIN_PRIORITY);
		mParam = pParam;
	}			

/**
 * Method run
 * @see java.lang.Runnable#run()
 */		
	public void run() {
		try {
			if (!conectaBaseDatos()) return;
			log.info("-->> Comienza el procesamiento de Renotificaciones, procesarán máximo [" + mParam.numMaximoRenotifi + "]");				
			procesaRenotificaciones();
			conexionActual.close();
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}
			log.error("Error en procesar Renotificaciones pendientes : --->>> [" + e.getMessage() + "] <<<---");
			log.error("trace",e);
			return;
		}
	}
	
/**
 * Method procesaRenotificaciones
 * Método que lee las Renotificaciones y las asigna a algún Procesador
 */
	private void procesaRenotificaciones() {
		ResultSet rs = null;
		try {
			Procesador procesador = new Procesador(conexionActual);
			int secuencia;
			int procesadas    = 0;
			String strComando = "";
			int os            = 0;
			boolean entregado = false;

			rs = BD.getRenotificaciones(conexionActual,mParam.numMaximoRenotifi,3); 

			if (rs == null) {
				log.info("-->> No existen Renotificaciones por Procesar");
				return;
			}
			do {
				strComando             = rs.getString("Mensaje");
				os                     = rs.getInt("OS");
				long codProc 		   = 1001001;
				secuencia              = procesador.nuevoMid();
				TypeNotificacion notif = new TypeNotificacion();
				notif.codProc          = codProc;
				notif.mensaje          = strComando;
				notif.numSecuencia     = secuencia; 
				notif.idRenotif        = os;
				notif.tipoMensaje	   = TypeNotificacion.MENSAJE_RENOTIFICACION;
				procesador.datos.addElement(notif);
				procesador.procesaLineal();
				procesadas ++;
			} while(rs.next());
			log.info("-->> Termina el procesamiento de Renotificaciones, total procesadas: " + procesadas);
			return;
		} catch(Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}
			log.error("Error en procesar Renotificaciones : --->>> [" + e.getMessage() + "] <<<---");
			log.error("trace",e);
			return;
		} finally {
			cierraCursor(rs,BD.prepareStmt);
		}
	}
	
/**
* Method conectaBaseDatos
* Metodo para Abrir una sesión de Oracle exclusiva para el cliente
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
	  
/**
 * Method cierraCursor
 * Cierre de la conexión con la Base de datos
 * @param rs ResultSet
 * @param stmt PreparedStatement
 * @throws SQLException
 */
	private void cierraCursor(ResultSet rs, PreparedStatement stmt) {
		if( rs != null ) {
			try {
				rs.close();
			} catch(Exception e ){}
		} 
		if( stmt != null ) {
			try { 
				stmt.close();
			} catch(Exception e){}
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
