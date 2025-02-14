package com.tmmas.IC.RecepcionRespuestas;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.tmmas.IC.Utils.LecturaParametros;
/**
 *
 * @author Juan Ramos
 * @version $Revision$
 */

public class Procesador extends Thread { 
//--->>> Variables Globales de la Clase
/**
 * Field PROCESADOR_RUN
 */
	public static final int PROCESADOR_RUN=0;
/**
 * Field PROCESADOR_WAIT
 */
	public static final int PROCESADOR_WAIT=1;
	
	private final int NUM_MAX_INTENTOS_ERROR = 3;
/**
 * Field estado
 */	
	public int    estado;
/**
 * Field id
 */	
	public String id;
/**
 * Field index
 */	
	public int    index;
/**
 * Field datos
 */	
	public Vector datos = new Vector();
			
//--->>> Variables Privadas de la Clase
/**
 * Field datos
 */	
	private static Logger log = Logger.getLogger(Procesador.class.getName());
/**
 * Field mTabProcesadores
 */
	private Vector mTabProcesadores;
/**
 * Field conexionActual
 */
	private Connection conexionActual;
/**
 * Field BD
 */
	private ServicioBD BD = new ServicioBD();
/**
 * Field notif
 */
	private TypeNotificacion notif = new TypeNotificacion();
/**
 * Field INSERTA_RENOTIFICACION
 */	
	private final int INSERTA_RENOTIFICACION   = 1;
/**
 * Field ACTUALIZA_RENOTIFICACION
 */
	private final int ACTUALIZA_RENOTIFICACION = 2;
/**
 * Field ELIMINA_RENOTIFICACION
 */
	private final int ELIMINA_RENOTIFICACION  = 3;
/**
 * Field mid
 */	
	private int    mid;
/**
 * Field mParam
 */		  
	private LecturaParametros mParam;	

/**
 * Field strErrorBD
 */
	public String strErrorBD = ""; 
	
	public RecepcionRespuestas RR = new RecepcionRespuestas();

/**
* Constructor for Procesador
* @param pGrupo ThreadGroup
* @param pId Vector
* @param pTabProcesadores Vector
* @param pConexionActual Connection
* @param pBD ServicioBD
* @param pParam LecturaParametros
*/
	public Procesador(ThreadGroup pGrupo, String pId, Vector pTabProcesadores, Connection pConexionActual, 
	                  ServicioBD pBD, LecturaParametros pParam) {
		super(pGrupo,pId);		
		id = pId;
		BD = pBD;
		mParam = pParam;
		conexionActual   = pConexionActual;
		mTabProcesadores = pTabProcesadores;
	}

/**
 * Constructor for Monitor
 * @param pConexionActual Connection
 */
	public Procesador(Connection pConexionActual) {
		conexionActual   = pConexionActual;
	}	
//------------------------------------------------------------------------------------------//
//  Función Principal									    								//	
//------------------------------------------------------------------------------------------//
/**
 * Method run
 * @see java.lang.Runnable#run()
 */
	public void run() {
		ProcesaRespuesta procRespuesta = new ProcesaRespuesta();
		try {
			String strBuffer = "";
			int intentos=1;
			if (!procRespuesta.conectaBaseDatos(mParam.nomHostDB,  mParam.numPuertoDb,mParam.instanciaDb,
										   mParam.usuarioDb, mParam.usuariopDb)) {
				log.error("Imposible conectar con la Base e datos");
				return;
			}
			while(true) {
				
//--->>> Revisa si el monitor está corriendo, sino lo ejecuta
				if (!RecepcionRespuestas.monitor.isAlive()) {
					RecepcionRespuestas.creaMonitor();
				}
//--->>> Procesamiento normal  
				int salida = buscaMasInformacion();
				if (salida == -1) return; //--->>> La tarea fue interrumpida por el monitor
				if (salida == -2) return; //--->>> Se presentó un error inesperado

				estado = Procesador.PROCESADOR_RUN;
//				log.debug("Procesador notificado para trabajar ID : --->>> [" + id + "] <<<--- Mensaje ["+ notif.mensaje + "]");

				if (!procesaInformacion(procRespuesta,intentos)) {
					if (intentos <= NUM_MAX_INTENTOS_ERROR) {
						intentos ++;
						continue;
					}
				} else { 
					intentos = 0;
				} 
			}
		/*}catch (Exception e) {
			strErrorBD = e.getMessage();
			 if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			 }*/
		}catch (InterruptedException e2) {
			strErrorBD = e2.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			 }
			log.debug("El procesador ha sido Terminado en SLEEP ID : --->>> [" + id + "] <<<---");
			mTabProcesadores.remove(index);
			return;
		}catch (Exception e1) {
			strErrorBD = e1.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			 }
			log.error("Error en metodo run del Procesador : --->>> [" + e1.getMessage() + "] <<<---");
			log.error("StacktTrace",e1);
		}finally {
			try {
				procRespuesta.cierraConexionBaseDatos();
			}catch(Exception e){
			}
		}
		
	}
	
/**
 * Método publico para procesar una respuesta en forma lineal
 * Method procesaLineal
 *  
 */	
	public boolean procesaLineal() {
		try {
			ProcesaRespuesta procRespuesta = new ProcesaRespuesta();
			procRespuesta.asignaConexionActiva(conexionActual);
			notif = (TypeNotificacion)datos.firstElement();
			return(procesaInformacion(procRespuesta,1));
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);						 
			}
			log.error("Error en Procesador (Linea): --->>> [" + e.getMessage() + "] <<<---");
			log.error("StacktTrace",e);
			return(false);
		}
	}
	
/**
 * Retorna un nuevo ID para el mensaje
 * Method nuevoMid
 *  
 */	
	public int nuevoMid() {
		mid ++;
		if (mid > 999) mid = 1;
		return(mid);	
	}
	
/**
 * Despierta el procesador cuando está en wait() a través del Monitor
 * Method despierta
 *  
 */
	public synchronized void despierta() throws Exception {
		try {
			notify();
		} catch(Exception e){
			e.printStackTrace();
		}
	}

/**
 * Busca el siguiente mensaje en su tabla de asignación
 * Method buscaMasInformacion
 *  
 */	
	private synchronized int buscaMasInformacion() throws InterruptedException {
		try {	
			String strBuffer = "";
			do {		
				if (datos.size()>0) {//--->>> Si hay mas trabajo repite el Ciclo
					notif = (TypeNotificacion)datos.firstElement();
					return(0); 
				}
//				log.debug("El Procesador no tiene mas trabajo, se queda en wait(). ID : --->>> [" + id + "] <<<---");
				estado = Procesador.PROCESADOR_WAIT;
				wait();		  //--->>> Se queda en Wait si no tiene mas trabajo.
			} while(true);
		/*} catch (Exception e) {
			strErrorBD = e.getMessage();
			 if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			 }*/
		}catch (InterruptedException e2) {
			int i;
			log.debug("El procesador ha sido Terminado ID : --->>> [" + id + "] <<<---");
			if (mTabProcesadores.contains(this)){
				i = mTabProcesadores.indexOf(this);
				mTabProcesadores.set(i,null);
				Monitor.totalProcesadores--;
				log.debug("||=====>>>>>>> Ahora quedan  [" + Monitor.totalProcesadores + "] Procesadores activos <<<<<<<=====");
			} else 
				log.error("procesador_no_registrado");			 
			return(-1); //--->>> Interrupted
		}catch (Exception e1) {
			strErrorBD = e1.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}
			log.error("Error Procesador : --->>> [" + e1.getMessage() + "] <<<---");
			log.error("StacktTrace",e1);
			return(-2);
		}
	}

/**
 * Elimina la notificación de la BD y la tabla de asignación
 * Method eliminaNotificacion
 *  
 */	
	private boolean eliminaNotificacion() throws SQLException {
		try {
			synchronized (BD) {
				boolean salida = BD.deleteNotificacion(conexionActual,notif.codProc);
				return(salida);
			}
		} catch(Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}

			log.error("Error Procesador : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StacktTrace",e);
			return(false);		
		}
	}

/**
 * Actualiza la renotificación ya sea Insertando, actualizando los intentos o eliminando
 * Method grabaRenotificacion
 *  
 */	
	private boolean acualizaRenotificacion(int os, int accion) throws SQLException {
		try {
			boolean salida = false;
			if (notif.mensaje.length() <= 1) notif.mensaje = " "; 
			synchronized (BD) {
				switch (accion) {
					case INSERTA_RENOTIFICACION: //--->>> Inserta una Renotificacion
						salida = BD.putRenotificacion(conexionActual,os,notif.mensaje);
						break;
					case ACTUALIZA_RENOTIFICACION: //--->>> incrementa su contador de intentos
						salida = BD.setRenotificacion(conexionActual,os);
						break;
					case ELIMINA_RENOTIFICACION: //--->>> Elimina la Renotificacion
						salida = BD.deleteRenotificacion(conexionActual,os);
						break;
				}
				return(salida);
			}
		} catch(Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}

			log.error("Error Procesador : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StacktTrace",e);
			return(false);		
		}
	}

/**
 * Metodo que procesa el mensaje una vez rescatado de la tabla de asignación.
 * aquí es donde se hace el llamado a la librería LibRespuesas.so
 * Method procesaInformacion
 *  
 */	
	private boolean procesaInformacion(ProcesaRespuesta procRespuesta, int intentos) {
		try {
			long salidaLib  = 0; 
			int tipMensaje = notif.tipoMensaje;
			int pos        = 0;
			String tmp     = "";
			boolean salida = false;
			int numOrdenServicio = 0;
			if (notif.mensaje.indexOf("OS=") <= 0) {
				log.error("El mensaje: [" + notif.mensaje + "] no trae la orden de servicio!!!");
				if (intentos == NUM_MAX_INTENTOS_ERROR)	marcaError(tipMensaje,numOrdenServicio); 
			}
			
			if ((pos = notif.mensaje.indexOf("OS=")) > -1) {
				tmp = notif.mensaje.substring(pos + 3);
				tmp = tmp.substring(0,tmp.indexOf(","));
				numOrdenServicio = Integer.parseInt(tmp);
			}
			salidaLib = procRespuesta.procesaMensajes(notif.mensaje,numOrdenServicio);			
			if (salidaLib == 0) {				
				if (tipMensaje != TypeNotificacion.MENSAJE_RENOTIFICACION) {					
					salida = eliminaNotificacion(); 
				} else {					
					salida = acualizaRenotificacion(notif.idRenotif,ELIMINA_RENOTIFICACION);
				}
				
				if (salida) {					
					datos.remove(datos.firstElement());
				} else {					
					log.error("No es posible eliminar la Respuesta, OS=" + numOrdenServicio);
					if (intentos == NUM_MAX_INTENTOS_ERROR)	marcaError(tipMensaje,numOrdenServicio);
				}
			} else { //--->> La libreria no pudo procesar, retorna el Número de OS.				
				marcaError(tipMensaje,numOrdenServicio);
			}
			return(true);
		} catch (Exception e) {			
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}
			log.error("Error Procesador : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StacktTrace",e);
			return(false);
		}
	}

	private void marcaError(int tipMensaje,int numOrdenServicio) {
		try {
			int accion = 1;
			if (tipMensaje == TypeNotificacion.MENSAJE_NOTIFICACION) {
				accion = INSERTA_RENOTIFICACION;
			} else {
				accion = ACTUALIZA_RENOTIFICACION;
			}

			if (!acualizaRenotificacion(numOrdenServicio,accion)) {
				return;		
			} else {
				if (tipMensaje == TypeNotificacion.MENSAJE_NOTIFICACION) eliminaNotificacion();
				datos.remove(datos.firstElement());
			}
		} catch (Exception e){
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
			}

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
