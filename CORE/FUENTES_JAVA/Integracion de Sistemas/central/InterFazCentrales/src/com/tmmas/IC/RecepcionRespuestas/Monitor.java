/**
 * Method revisaMinimoProcesadores
 * Metodo Privado para revisar que exista la cantidad minima de Procesadores 
 * @param conexionActual Connection
 * @param numOS long
 * @return boolean
 * @throws SQLException
 */
package com.tmmas.IC.RecepcionRespuestas;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.tmmas.IC.Utils.LecturaParametros;
import com.tmmas.SCH.Interfaz.JavaSched;

/**
 * Clase para el control de Tareas Procesadores que trabajarán las notificaciones
 * que lleguen hacia el Receptor 
 * @author Juan Ramos
 * @version $Revision$
 */

public class Monitor extends Thread { 
//--->>> Variables Globales de la Clase
/**
 * Field ejecutandoPendientes
 */		  
	public static boolean ejecutandoPendientes = false;	
/**
 * Field totalProcesadores
 */		  
	public static int totalProcesadores=0;

//--->>> Variables Privadas de la Clase
/**
 * Field log
 */		  
	private static Logger log = Logger.getLogger(Monitor.class.getName());
/**
 * Field minimoProcesadores
 */		  
	private int minimoProcesadores=0;
/**
 * Field mParam
 */		  
	private LecturaParametros mParam;
/**
 * Field mTabProcesadores
 */		  
	private Vector 		mTabProcesadores;
/**
 * Field mGrupo
 */		  
	private ThreadGroup mGrupo;
/**
 * Field grupoProcesadores
 */		  
	private ThreadGroup grupoProcesadores = new ThreadGroup("Procesadores");
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
 * Field renotificando
 */		  
	private boolean 	renotificando = false;
/**
 * Field informaNoFactible
 */		  
	private boolean 	informaNoFactible = true;

	private boolean		platUnix = false;
/**
* Field strErrorBD
 */
	public String strErrorBD = "";	
	
	public RecepcionRespuestas RR = new RecepcionRespuestas();
/**
 * Constructor for Monitor
 * @param pGrupo ThreadGroup
 * @param pParam LecturaParametros
 * @param LecturaParametros pParam
 * @param pTabProcesadores Vector
 */
	public Monitor(ThreadGroup pGrupo, LecturaParametros pParam, Vector pTabProcesadores) {
		super(pGrupo,"Monitor");		
		mParam = pParam;
		mTabProcesadores = pTabProcesadores;
		mGrupo = pGrupo;
		minimoProcesadores = mParam.numMinimoProcesadores;
		String plataforma = System.getProperties().getProperty("os.name").toLowerCase();
		if (plataforma.indexOf("indows") < 0) { 
			platUnix = true;
		}		
	}
/**
 * Method run
 * @see java.lang.Runnable#run()
 */
	public void run() {
		long ultimaLecturaParam		= ((System.currentTimeMillis() / 1000) / 60);
		long ultimaRenotificacion	= ((System.currentTimeMillis() / 1000) / 60);
		boolean primeraVez= true;
		if (mGrupo.activeCount() > 1) {
			log.debug("Ya existe una instancia de Monitor en Ejecución, no se genera esta");	
			return;
		} 
		try {

//--->>> Validación de la Conexión a la BD 
			if (!conectaBaseDatos()) return;
			Thread recupera;
			Thread renotifica = new Thread("RENOTIF");
			recupera = new RecuperaCaidas();
			recupera.setPriority(Thread.MIN_PRIORITY);
			recupera.start(); 
			while(true) {
//--->>> Si se ha cumplido el tiempo de refresco, lee nuevamente los parametros				
				if ( (((System.currentTimeMillis() / 1000) / 60) - ultimaLecturaParam) >= mParam.tiempoRefrescaParam ) {
					log.debug("Se ha cumplido el tiempo de Refresco, se vuelven a leer los parámetros");
					ultimaLecturaParam = ((System.currentTimeMillis() / 1000) / 60);
					RecepcionRespuestas.leeParametros(); 
				}
//--->>> Si se ha cumplido el tiempo para procesar las renotificaciones, realiza la tarea.											
				if ( (((System.currentTimeMillis() / 1000) / 60) - ultimaRenotificacion) >= mParam.tiempoEnvioRenotif ) {
					if (!renotifica.isAlive()) {
						renotifica = new ProcesaRenotificaciones(mParam);
						ultimaRenotificacion = ((System.currentTimeMillis() / 1000) / 60);
						renotifica.start(); 
					}
			  	}

//--->>> Revisa número mínimo de Procesadores.
				revisaMinimoProcesadores();
  				
//--->>> Despierta los procesadores con trabajo pendiente.  				
				revisaDatosAProcesar();
				espera();
			}
		} catch (Exception e) {//(IOException e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
			}			
			log.error("Error en metodo run del Monitor : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StackTrace:",e);
		}
	}

/**
 * Method revisaMinimoProcesadores
 * Metodo Privado para revisar que exista la cantidad minima de Procesadores 
 */
	private void revisaMinimoProcesadores(){
		if (minimoProcesadores < mParam.numMinimoProcesadores) {
			log.info("--->>> Se aumenta el mínimo de procesadores de " + minimoProcesadores + " a " + mParam.numMinimoProcesadores);
		} else if (minimoProcesadores > mParam.numMinimoProcesadores) {
			log.info("--->>> El mínimo de procesadores baja de " + minimoProcesadores + " a " + mParam.numMinimoProcesadores);
			log.info("--->>> Se bajarán paulatinamente ");
		}
		minimoProcesadores = mParam.numMinimoProcesadores;
		if (totalProcesadores < mParam.numMinimoProcesadores){
			do {	
				creaNuevoProcesador();				
			}while (totalProcesadores < mParam.numMinimoProcesadores);
		}
	}
/**
 * Method revisaFactibilidad
 * Metodo Privado para revisar si es factible crear un nuevo procesador 
 */
	private boolean revisaFactibilidad() {
		JavaSched jSched = new JavaSched();
//--->>> Revisa Cpu del Programa.
			if (jSched.getPidMemCpu(JavaSched.SCH_RETORNA_CPU) > mParam.maximoCpuProceso) {
				if (informaNoFactible) log.info("No es posible crear un nuevo procesador, la cpu del proceso [" +
					                            jSched.getPidMemCpu(JavaSched.SCH_RETORNA_CPU) + 
                                                "] sobrepasa el máximo permitido [" + mParam.maximoCpuProceso + "]");
				informaNoFactible = false;
				return(false);
			}
//--->>> Revisa Memoria del Programa.
			if (jSched.getPidMemCpu(JavaSched.SCH_RETORNA_MEMORIA) > mParam.maximoMemProceso) {
				if (informaNoFactible) log.info("No es posible crear un nuevo procesador, la memoria del proceso [" + 
				                                jSched.getPidMemCpu(JavaSched.SCH_RETORNA_MEMORIA) + 
                                                "] sobrepasa el máximo permitido [" + mParam.maximoMemProceso + "]");
				informaNoFactible = false;
				return(false);
			}		
//--->>> Revisa Cpu del Servidor.
			if (jSched.getHostMemCpu(JavaSched.SCH_RETORNA_CPU) > mParam.maximoCpuEquipoResp && mParam.maximoCpuEquipoResp > 0 ) {
				if (informaNoFactible) log.info("No es posible crear un nuevo procesador, la cpu del equipo [" + 
				                                jSched.getHostMemCpu(JavaSched.SCH_RETORNA_CPU) + 
                                                "] sobrepasa el máximo permitido [" + mParam.maximoCpuEquipoResp + "]");
				informaNoFactible = false;
				return(false);
			}
//--->>> Revisa Memoria del Servidor.
			if (jSched.getHostMemCpu(JavaSched.SCH_RETORNA_MEMORIA) > mParam.maximoMemEquipoResp && mParam.maximoMemEquipoResp > 0) {
				if (informaNoFactible) log.info("No es posible crear un nuevo procesador, la memoria del equipo [" + 
				                                jSched.getHostMemCpu(JavaSched.SCH_RETORNA_MEMORIA) + 
                                                "] sobrepasa el máximo permitido [" + mParam.maximoMemEquipoResp + "]");
				informaNoFactible = false;
				return(false);
			}		
		informaNoFactible = true;
		return(true);
	}

/**
 * Method creaNuevoProcesador
 * Metodo Privado para crear un nuevo procesador 
 */
	private void creaNuevoProcesador(){
		int index = mTabProcesadores.size();
		boolean nuevo=true;
		if (totalProcesadores >= mParam.numMinimoProcesadores) {
			if (platUnix) {
				if (!revisaFactibilidad()) return; 
			} 
		}

		String disponible = "";
		for(int i=0;i<mTabProcesadores.size();i++) {
			if (mTabProcesadores.elementAt(i) == null) {
				index = i;
				nuevo = false;
				break;
			}
				
		}				
		disponible = "PROC_" + (index + 1);
		Thread procesador = new Procesador(grupoProcesadores,disponible,mTabProcesadores,conexionActual,BD,mParam);
		if (nuevo) {
			mTabProcesadores.addElement(procesador);
		} else {
			mTabProcesadores.setElementAt(procesador,index);
		}
			
		Procesador p = (Procesador)procesador;
		p.estado     = Procesador.PROCESADOR_WAIT;
		p.index      = index; 
		procesador.start();
		totalProcesadores++;
		log.debug("Se crear el Procesador: " + disponible); 
	}

/**
  * Method revisaDatosAProcesar
  * Metodo Privado para despertar los procesadores que tengan tarea pendiente
  * @throws Exception  
  */
	private void revisaDatosAProcesar() throws Exception {
		try {
			int ociosos=0;
			int ocupados=0;
			int porcenProcesadores=0;
			boolean todosCopados = true;
			Procesador procesador;
			for (int i=0;i<mTabProcesadores.size();i++){
				if ((procesador = (Procesador)mTabProcesadores.elementAt(i)) != null){
/*					if (!procesador.isAlive()) { //--->>> El procesador se ha caído por alguna razón, se levanta
						log.error("El procesador " + procesador.getName() + " está caído. Se levanta una vez mas"); 
						procesador.start();
					}*/
					if (procesador.estado == Procesador.PROCESADOR_WAIT) {   
						if (procesador.datos.size() > 0) {
							procesador.despierta();
						}else 
						if (procesador.datos.size() == 0) { //--->>> El Procesador está ocioso
							ociosos++;
							if (ociosos > mParam.maximoProcesadoresOciosos) procesador.interrupt(); 
						}
						todosCopados = false;
					} else{
						ocupados ++;
						if (procesador.datos.size() < mParam.numPromedioNotificaciones) todosCopados = false;
					}
				}
			}
			
			if (todosCopados && totalProcesadores < mParam.numMaximoProcesadores) {//--->>> Debe Crear un nuevo procesador
				creaNuevoProcesador();
			}
		} catch(Exception e){
			log.error("StackTrace:",e);
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
 * Method espera
 */
	private void espera() {
		try {
			int intervaloCliente =  10;
			Thread.sleep(intervaloCliente); 
		} 
		catch(Exception e) { 
		}
	}

//------------------------------------------------------------------------------------------//
//  Clases Privadas para el procesamiento de Notificaciones Caídas y Renotificaciones       //
//------------------------------------------------------------------------------------------//
/**
 * Clase privada para ser ejecutada como Thread desde el Monitor y procesar las notificaciones
 * que no pudieron ser terminadas debidamente, por alguna caída.
 * @author Juan Ramos
 * @version $Revision$
 */
	class RecuperaCaidas extends Thread {

		RecuperaCaidas () {
			super("RecuperaCaidas");
		}
		
	/**
	 * Method run
	 * @see java.lang.Runnable#run()
	 */		
		public void run() {
			try {
				ejecutandoPendientes = true;	
				log.info("Comienza el procesamiento de notificaciones pendientes");				
				procesaNotificacionesCaidas();
			} catch (Exception e) {
				strErrorBD = e.getMessage();
				if(RR.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
				 }				
				log.error("Error en procesar notificaciones pendientes : --->>> [" + e.getMessage() + "] <<<---");
				log.error("trace",e);
				return;
			} finally {
				ejecutandoPendientes = false;  
			}
		}
		
	/**
	 * Method procesaNotificacionesCaidas
	 * Método que lee las notificaciones que no terminaron su procesamiento y las 
	 * asigna a algún Procesador
	 */
		private void procesaNotificacionesCaidas() {
			try {
				Procesador procesador;
				int secuencia;
				int procesadas    = 0;
				String strComando = "";
				long codProc      = 0;
				boolean entregado = false;
				ResultSet rs = null;
				synchronized (BD) {
					rs = BD.getNotificaciones(statementActual); 
				}
				if (rs == null) {
					log.info("No existen Notificaciones pendientes por caídas");
					return;
				}
				do {
					entregado  = false;
					strComando = rs.getString("Notificacion");
					codProc    = rs.getLong("Id_Proc"); 
					for(int i=0;i<mTabProcesadores.size();i++){
						if (mTabProcesadores.elementAt(i) != null) {
							procesador = (Procesador)mTabProcesadores.elementAt(i);
							if (procesador.datos.size() < mParam.numPromedioNotificaciones) {
								log.debug("El procesador "+ procesador.id + " tiene " + procesador.datos.size() + " mensajes pendientes, se le asigna nuevo: " + strComando);
								secuencia = procesador.nuevoMid();
								TypeNotificacion notif = new TypeNotificacion();
								notif.codProc          = codProc;
								notif.mensaje          = strComando;
								notif.numSecuencia     = secuencia; 
								procesador.datos.addElement(notif);
								entregado = true;
								procesadas ++;
								break;
							} else {
								log.warn("No hay procesadores diponibles, se espera 3 décimas de segundos");
								sleep(300);
							}
						}
					}
					if (!entregado) {
						log.warn("El mensaje no pudo ser entragado a algún procesador, se reintenta");
						continue;
					}
					sleep(15);
				} while(rs.next());
				rs.close();
				log.info("Termina el procesamiento de notificaciones pendientes, total enviadas: " + procesadas);
			} catch(Exception e) {
				strErrorBD = e.getMessage();
				if(RR.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
				}
				log.error("Error en procesar notificaciones pendientes : --->>> [" + e.getMessage() + "] <<<---");
				log.error("trace",e);
				return;
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
