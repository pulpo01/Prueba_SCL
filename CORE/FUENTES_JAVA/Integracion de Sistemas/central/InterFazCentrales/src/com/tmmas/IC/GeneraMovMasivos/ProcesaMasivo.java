package com.tmmas.IC.GeneraMovMasivos;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.tmmas.IC.Utils.LecturaParametros;
import com.tmmas.IC.Utils.Utilidades;

/**
 * Clase para el manejo de los rangos de ejecución del procesamiento masivo de 
 * comandos icmovk
 * @author Juan Ramos
 * @version $Revision$
 */
public class ProcesaMasivo extends Thread {
/**
 * Field log
 */
	private static Logger log = Logger.getLogger(ProcesaMasivo.class.getName());
/**
 * Field param
 */
	public static LecturaParametros mParam = new LecturaParametros();
/**
 * Field conexionBD
 */		  
	private static Connection  conexionBD;
/**
 * Field BD
 */		  
	private static ServicioBD	BD = new ServicioBD();
/**
 * Field id
 */	
	private String id;
/**
 * Field procesosPendientes
 */	
	private Vector procesosPendientes = new Vector();
/**
 * Field procesosEnEjecucion
 */
	private Vector procesosEnEjecucion = new Vector();
	
	private Vector procesosEnEjecucionR = new Vector();
	
/**
 * Field procRangoMovReintentable
 */	
	private ProcesaRangoMovimiento procRangoMovReintentable;	
/**
 * Field codMasivoAsignado
 */		
	private String codMasivoAsignado = "";
/**
 * Field maximoParalelo
 */	
	private int maximoParalelo;
	
	private int maximoParaleloR;
	
/**
 * Field maxCodMasivo
 */
	private int maxCodMasivo = 0;
	
	private int maxCodMasivoR = 0;
/**
 * Field codMasivosEnEjecucion
 */	
	private Vector codMasivosEnEjecucion;
/**
 * TIEMPO_ESPERA
 */
	private static final int TIEMPO_ESPERA = 1000;
	
/**
 * Field strErrorBD
 */
   	public static String strErrorBD = "";	
   	
   	public static GeneraMovMasivos GMM = new GeneraMovMasivos();
 
 	
/**
 * Constructor for Monitor
 * @param pGrupo ThreadGroup
 * @param pIdTrhead String
 * @param pParam LecturaParametros
 */
   	
	public ProcesaMasivo(ThreadGroup pGrupo, String pId, LecturaParametros pParam, Vector codMasivosEnEjecucion) {
		super(pGrupo,pId);		
		id = pId;
		mParam = pParam;
		this.codMasivosEnEjecucion = codMasivosEnEjecucion;
	}

	
/**
 * Method run
 * @see java.lang.Runnable#run()
 */
	public void run() {
		try {
			int i = 0;
			boolean todasTerminadas  = true;
			String codMasivo         = "";
			TypeNodoRango nodoRango  = new TypeNodoRango();
			TypeNodoRango nodoRangoR = new TypeNodoRango();
			ThreadGroup grupoRangos  = new ThreadGroup("PROC_RANGOS");
			Thread procRangoMovimiento; 
			TypeNodoMasivo nodo      = new TypeNodoMasivo();
			nodo.codMasivo 			 = codMasivoAsignado; //--->>> Asignado antes de de ejecutar.
			
			if (!conectaBaseDatos()) {
				log.error("No es posible establecer la conexión con la base de datos!!!");
				return;
			}
		
			String maxCodMasivoTmp = mParam.extraeDatosConf("CM_" + nodo.codMasivo);
			if (Utilidades.validaNumerico(maxCodMasivoTmp)) maxCodMasivo = Integer.parseInt(maxCodMasivoTmp);

			if (maxCodMasivo != 0) {
				log.info("El codigo [" + nodo.codMasivo + "] masivo tiene el max. de paralelo personalizado: " + maxCodMasivo);
				maximoParalelo = maxCodMasivo;
			} else {
				maximoParalelo = mParam.numMaxParalCodMasivo;
			}
			/* SE AGREGA INSTRUCCIÓN */
			String maxCodMasivoTmpR = mParam.extraeDatosConf("CMR_" + nodo.codMasivo);
			if (Utilidades.validaNumerico(maxCodMasivoTmpR)) maxCodMasivoR = Integer.parseInt(maxCodMasivoTmpR);

			if (maxCodMasivoR != 0) {
				log.info("El codigo [" + nodo.codMasivo + "] masivo tiene el max. de paralelo personalizado: " + maxCodMasivoR);
				maximoParaleloR = maxCodMasivoR;
			} else {
				maximoParaleloR = mParam.numMaxParalCodMasivo;
			}			
			/*FIN*/
			
			revisaRangosActivos(grupoRangos,nodo,false);

			while (true) {
				
				if ( (nodo = getNuevoProcMasivo()) != null) {
					
					/* REVISAR ESTA PARTE */
					while ((procesosEnEjecucion.size()+procesosEnEjecucionR.size()) >= (maximoParalelo + maximoParaleloR)) { //--->>> Revisa el paralelismo
						log.info("El rango no es procesado ya que sobrepasaria el maximo de ejecuiones para el codigo masivo. Maximo: [" +  maximoParalelo + "], Ejecutados: [" +  (procesosEnEjecucion.size()+procesosEnEjecucionR.size()) + "]");
						Thread.sleep(2000);
					}
					
					codMasivo = nodo.codMasivo;
					synchronized (BD) {
						nodoRango  = new TypeNodoRango();
						nodoRango = BD.getRangoReintentado(conexionBD,nodo.codMasivo);
					}
					if (nodoRango != null) { // El operador quiere volver a ejecutar un rango
						log.info("Se ha obtenido un rango reintentado por el operador");
						if (nodoRango.tipEstados.equals("P")) { // El rango es Pendiente
							log.info("Se ejecuta un rango reintetado por el operador, ID= PEND_" + nodoRango.numRangoIni + ". Rango Final: " + nodoRango.numRangoFin);
							procRangoMovimiento = new ProcesaRangoMovimiento(grupoRangos,"P_" + nodoRango.codMasivo + "_" + nodoRango.numRangoIni, -1, conexionBD, BD, mParam, nodoRango,procesosEnEjecucion);
							procRangoMovimiento.start();
						} else { // El rango es un reintentable
							log.warn("No es posible reprocesar un rango de movimientos reintentables ya que siempre se reprocesan");
						}
					} else {
						log.debug("Se procede a buscar un nuevo rango para los pendientes");
						synchronized (BD) {
							nodoRango = BD.getNuevoRangoMovimiento(conexionBD,nodo.codMasivo,ServicioBD.ESTADO_PENDIENTE,nodo.numRangoPendientes);
						}
						if (nodoRango == null) {
							log.warn("El objeto nodoRango esta nulo. Se reintenta su búsqueda");
							Thread.sleep(1000);
							continue;
						}						
//--->>> Ejecuta una nueva instancia de procesa rango movimiento para los pendientes
						if (nodoRango.numRangoIni == -1) {
							log.info("No existen movimientos Pendientes para asignar rangos");					
						} else {
							log.info("Se ejecuta nueva tarea de procesamiento de rangos, ID= PEND_" + nodoRango.numRangoIni);
							procRangoMovimiento = new ProcesaRangoMovimiento(grupoRangos,"P_" + nodoRango.codMasivo + "_" + nodoRango.numRangoIni, -1, conexionBD, BD, mParam, nodoRango,procesosEnEjecucion);
							procesosEnEjecucion.addElement(procRangoMovimiento);
							procRangoMovimiento.start();
							log.info("Se suma al contador de procesos del codigo masivo. Queda en: " + procesosEnEjecucion.size());
						}
					
//--->>> Ejecuta la instancia de los reintentables o le agrega 1 al contador de tareas si ésta ya está corriendo
						log.debug("Se revisan los rangos de reintentables");
						synchronized (BD) {
  							nodoRangoR = BD.getNuevoRangoMovimiento(conexionBD,nodo.codMasivo,ServicioBD.ESTADO_REINTENTABLE,nodo.numRangoReintentables);
  						}
						/*if (nodoRango == null) {  <-- OJO CON ESTO*/
						if (nodoRangoR == null) {
							log.warn("El objeto nodoRango esta nulo. Se reintenta su búsqueda");
							Thread.sleep(1000);
							continue;
						}			
						if (nodoRangoR.numRangoIni == -1) {
							log.info("No existen movimientos Reintentables para asignar rangos");
						} else {
							/*if (procRangoMovReintentable != null && !procRangoMovReintentable.isAlive()) {
								procRangoMovReintentable = null;
							}*/
							
		  					if (procRangoMovReintentable == null) {
		  						nodoRangoR.tipEstados="R";
		  						log.debug("Se crea el objeto para el proceso de reintentables");
		  						procRangoMovReintentable = new ProcesaRangoMovimiento(grupoRangos,"REIN_" + nodoRangoR.codMasivo + "_" + nodoRangoR.numRangoIni, -1, conexionBD, BD, mParam, nodoRangoR,procesosEnEjecucionR); 
								/*procRangoMovReintentable.setAgregaTrabajo(nodoRangoR);*/
								procRangoMovReintentable.start();
								procesosEnEjecucionR.addElement(procRangoMovReintentable);
								log.info("Se suma al contador de procesos del codigo masivo. Queda en: " + procesosEnEjecucionR.size());
		  					} else if (procRangoMovReintentable.isAlive()) {
		  						/*log.info("El objeto para el proceso de reintentables ya existe, se le asigna mas trabajo");*/
								/*procRangoMovReintentable.setAgregaTrabajo(nodoRangoR);*/
		  						nodoRangoR.tipEstados="R";
								log.info("Se ejecuta nueva tarea de procesamiento de rangos, REIN_" + nodoRangoR.numRangoIni);
								procRangoMovReintentable = new ProcesaRangoMovimiento(grupoRangos,"REIN_" + nodoRangoR.codMasivo + "_" + nodoRangoR.numRangoIni, -1, conexionBD, BD, mParam, nodoRangoR,procesosEnEjecucionR);
								procesosEnEjecucionR.addElement(procRangoMovReintentable);
								procRangoMovReintentable.start();
								log.info("Se suma al contador de procesos del codigo masivo. Queda en: " + procesosEnEjecucionR.size());
								
								
							}
						}
					} // Fin If de reproceso
				} // Fin If Sin Masivos
				log.debug("No quedan mas ejecuciones calendarizadas para este codigo masivo, se revisa el estado de las actuales");
				
				if (procesosEnEjecucion.size() == 0 && procesosEnEjecucionR.size() == 0) {
					log.info("Se ha terminado todo el procesamiento de este codigo masivo: " + codMasivo);
					synchronized (BD) {
						BD.setFinEjecucionMovimiento(conexionBD,codMasivo);
					}						
					return;
				}
				 
				Thread.sleep(TIEMPO_ESPERA);
			} // Fin While
		}catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
			}		
			log.error("Error en metodo run del ProcesaMasivo : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StacktTrace",e);
			try {
				conexionBD.close();
			} catch (Exception e2){}
			
		} finally {
			codMasivosEnEjecucion.remove(this);
			log.info("Se resta al contador de codigos masivos. Queda en: " + codMasivosEnEjecucion.size());
		}
	}
	
/**
* Method asignaNuevoProcMasivo
* Agrega una ejecución de proceso masivo a la cola
* @param codMasivo String 
* @param numRangoPendientes int
* @param numRangoReintentables int
*/	
	public void asignaNuevoProcMasivo(String codMasivo,int numRangoPendientes,int numRangoReintentables) {
		codMasivoAsignado          = codMasivo;
		TypeNodoMasivo nodo 	   = new TypeNodoMasivo();
		nodo.codMasivo             = codMasivo;
		nodo.numRangoPendientes    = numRangoPendientes;
		nodo.numRangoReintentables = numRangoReintentables; 
		procesosPendientes.addElement(nodo);
	}
		
/**
 * Retorna el número de ejecuciones encoladas que tiene el código masivo
 * @param codMasivo
 * @return
 */
	public int getProcesosEncolados(String codMasivo) {
		return(procesosPendientes.size());
	}

/**
* Method getNuevoProcMasivo
* Rescata una ejecución de proceso masivo a la cola
* @return TypeNodoMasivo
*/	
	private TypeNodoMasivo getNuevoProcMasivo() {
		if (procesosPendientes.size() == 0) return(null);
		TypeNodoMasivo nodo = (TypeNodoMasivo)procesosPendientes.firstElement();
		procesosPendientes.remove(nodo);
		return(nodo);		
	}

/**
 * Method revisaRangosActivos
 * Revisión de las tareas activas según la base de datos v/s la ejecución por hilo
 * @param grupoRangos ThreadGroup
 * @param nodo TypeNodoMasivo
 * @return int
 * @throws SQLException
 */
	private void revisaRangosActivos(ThreadGroup grupoRangos, TypeNodoMasivo nodo, boolean soloLee) 
	throws SQLException {
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			log.info("Se revisa la existencia de movimientos al rango final");
			synchronized (BD) {
				BD.getRangosActivos(conexionBD,stmt,nodo.codMasivo,1);
				
				cierraCursor(rs,stmt);
				
				BD.getRangosActivos(conexionBD,stmt,nodo.codMasivo,2);
				
				cierraCursor(rs,stmt);
			}			
			log.debug("Fin de revisión de movimientos menores al rango final");
			return;			
		} catch(Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
			}		
			log.error("Error en revisión de Ejecuciones Activas " + e.getMessage());
			log.error("StackTrace:",e);
			return;
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method cierraCursor
 * Cierra un ResulSet y un PreparedStatement
 * @param rs ResultSet
 * @param stmt PreparedStatement
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

/**
 * Method conectaBaseDatos
 * Metodo para Abrir una sesión de Oracle exclusiva para el cliente
 * @return boolean
 * @throws SQLException
 */
	private static boolean conectaBaseDatos()
	throws SQLException {
		  try {
//	--->>> Conexión con la Base de Datos
		  if (conexionBD == null || conexionBD.isClosed()) {
		  	synchronized (BD) {
		  		conexionBD = BD.conectaBaseDatos(mParam.nomHostDB,  mParam.numPuertoDb, mParam.instanciaDb,
		  						 mParam.usuarioDb, mParam.usuariopDb);
		  	}
		  }
		  if (conexionBD == null) {
			  log.error("No se ha podido establecer la conexión con la Base de Datos ");
			  return(false);		
		  }
		  log.debug("Conectado con la base de datos" );
		  return(true);
	  } catch (SQLException e) {
	  	  strErrorBD = e.getMessage();	  	  
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(false);				
			}		
		  log.error("No se ha podido establecer la conexión con la Base de Datos " + e.getMessage());
		  log.error("StackTrace:",e);
		  return(false);
	  }		
  }
	
/**
 * Clase privada para ser utilizada como estructura donde almacenar las Ejecuciones de procesos Masivos
 * @author Juan Ramos
 * @version $Revision$
 */
	private class TypeNodoMasivo {
		String codMasivo          = "";
		int numRangoPendientes    = 0;
		int numRangoReintentables = 0;
		String estado             = "P";
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
