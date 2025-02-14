package com.tmmas.IC.GeneraMovMasivos;
import java.sql.Connection;
import java.sql.SQLException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.IC.RecepcionRespuestas.*;
import com.tmmas.IC.Utils.LecturaParametros;
import com.tmmas.IC.Utils.Utilidades;

public class ProcesaMovimientos {
/**
 * Field proc
 */
	static private ProcesaRespuesta proc = new ProcesaRespuesta();
/**
 * Field rutaConfig
 */
	static private String rutaConfig = "";
/**
 * Field param
 */
	public static LecturaParametros param = new LecturaParametros();
/**
 * Field BD
 */		  
	private static ServicioBD	BD = new ServicioBD();
/**
 * Field conexionActual
 */		  
	private static Connection  conexionActual;
/**
 * Field log
 */
	private static Logger log = Logger.getLogger(ProcesaMovimientos.class.getName());
	
/**
 * Field strErrorBD
 */
   	public static String strErrorBD = "";	
   	
   	public static GeneraMovMasivos GMM = new GeneraMovMasivos();
	
	
/**
* Method main
* @param args String[]
* @throws Exception
*/			
   	
	public static void main(String args[]) {
		try {
			int numRangoIni   = 0;
			int numRangoFin   = 0;
			String codMasivo  = "";
			String tipoEstado = "";
			String pathCfg    = "";
			boolean ejecMasiva = false;
			String mensaje = "";
			
			switch (args.length) {
				case 3:
					mensaje = "Ejecución de procesamiento de Movimientos de forma Individual";
					
					if (!Utilidades.validaNumerico(args[1])) { 
						System.out.println("El valor para el número de movimiento debe ser numérico");
						System.exit(1);
					}
					
					rutaConfig  = args[0];
					codMasivo   = "NULL";
					numRangoIni = Integer.parseInt(args[1]);
					tipoEstado  = "T";
					pathCfg     = args[2];
					break;
				case 4:
					mensaje = "Ejecución de 1000 Movimientos";

					if (!args[2].equals("OLD")) { 
						System.out.println("Debe ser indicar la glosa 'OLD'");
						System.exit(1);
					}

					rutaConfig  = args[0];
					codMasivo   = args[1];
					tipoEstado  = "T";
					pathCfg     = args[3];
					break;
				case 6:
					mensaje = "Ejecución de procesamiento de Movimientos de forma Masiva";
					if (!Utilidades.validaNumerico(args[2])) { 
						System.out.println("El valor para el número de movimiento inicial debe ser numérico");
						System.exit(1);
					}
					if (!Utilidades.validaNumerico(args[3])) { 
						System.out.println("El valor para el número de movimiento Final debe ser numérico");
						System.exit(1);
					}
					
					if (!args[4].equals("P") && !args[4].equals("R")) { 
						System.out.println("El tipo de estado debe ser [P]= pendientes o [R]= reintentable");
						System.exit(1);
					}
					rutaConfig   = args[0];
					codMasivo    = args[1];
					numRangoIni  = Integer.parseInt(args[2]);
					numRangoFin  = Integer.parseInt(args[3]);
					tipoEstado   = args[4];
				    pathCfg      = args[5];
					ejecMasiva = true;
					break;
				default: 
					System.out.println("Número de parámetros incorrectos");
					System.out.println("+--------------------------------------------------------------------------+");
					System.out.println("|                        Formato de Parámetros                             |");
					System.out.println("+--------------------------------------------------------------------------+");
					System.out.println("|Movimiento Individual:                                                    |");
					System.out.println("| <ruta_cfg> <num_movimiento> <ruta_cfg_log>                               |");
					System.out.println("+--------------------------------------------------------------------------+");
					System.out.println("|Movimientos masivos:                                                      |");
					System.out.println("| <ruta_cfg> <cod_masivo> <num_movto_ini> <num_movnto_fin> <estado P o R>  |");
					System.out.println("| <ruta_cfg_log> ");
					System.out.println("+--------------------------------------------------------------------------+");
					System.out.println("|Movimientos masivos en procedimiento antiguo:                             |");
					System.out.println("| <ruta_cfg> <cod_masivo> 'OLD' <ruta_cfg_log>                             |");
					System.out.println("+--------------------------------------------------------------------------+");
					System.exit(1);
			}
			PropertyConfigurator.configureAndWatch(pathCfg + ".properties");
			log.info(mensaje);
			leeParametros();
			if (!conectaBaseDatos()) return;
			log.debug("Comienzo procesamiento de movimiento");
			log.debug("Parametros: Usuario BD=[" + param.usuarioDb.trim() + "], Cod.Masivo=[" + codMasivo + "] , Rango Ini=[" + numRangoIni + "] , Rango Fin= [" + numRangoFin + "], Tipo Estado=[" + tipoEstado + "]");
			ProcesaMovimientos procesa = new ProcesaMovimientos();
			int iRetM = procesa.procesaIcMov(param.usuarioDb.trim(), param.usuariopDb.trim(), codMasivo, numRangoIni, numRangoFin,tipoEstado, pathCfg);
			log.debug("Fin del procesamiento. Exit Status: " + iRetM);
			if (ejecMasiva) {
				log.debug("Se actualiza el estado de la ejecución por rango");
				BD.setEstadoEjecucionRango(conexionActual,codMasivo,numRangoIni,ServicioBD.ESTADO_FINALIZADO,false);
			} 
			System.exit(iRetM);
		} catch(Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
			}		
			log.fatal("Excepcion no atrapada en el main!!!");
			log.error("StackTrace:",e);			
		} finally {
			try {
				proc.cierraConexionBaseDatos();
			}catch(Exception e2) {
			}
		}
	}
	
/**
 * Method procesaRespuesta
 * Metodo para el procesamiento de las respuestas enviadas desde P+S u otras plataformas
 * @param strRespuesta String
 * @param numOSS int
 * @return boolean
 * @throws SQLException
 */
	public int procesaRespuesta(String strRespuesta, int numMovimiento, int codComando, int numOrden) 
	throws SQLException {
		log.info("Inicio Proceso Respuestas: strRespuesta=" + strRespuesta + " - Comando=" + codComando);
		
		int salida = proc.procRespuestaDesdeNativo(strRespuesta, numMovimiento, codComando, numOrden, log);
		
		log.info("Salida del procesamiento de la respuesta [" + salida + "]. Se le retorna al código nativo");
		return(salida);		
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
//--->>> Conexión con la Base de Datos
		  conexionActual = BD.conectaBaseDatos(param.nomHostDB,  param.numPuertoDb,param.instanciaDb,
											   param.usuarioDb, param.usuariopDb);
		  if (conexionActual == null) {
			  log.error("No se ha podido establecer la conexión con la Base de Datos ");
			  return(false);		
		  }
		  proc.asignaConexionActiva(conexionActual);
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
 * Metodo que lee los parámetros principales
 * Method leeParametros
 * @return int
 */
	public static int leeParametros() {
		try {
			int salida = 0;	
			salida = param.leer(rutaConfig);
			return(salida);
		} catch	 (Exception e) {
				strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(1);				
			}		
			log.error("Error en la lectura de parametros: --->>> [" + e.getMessage()+ e.getCause()  + "] <<<---");
			log.error("StackTrace:",e);
			return(1);
		}
	}

/*-------------------------------------------------------------------------*/
/*  Carga de la librería dinámica                                          */
/*-------------------------------------------------------------------------*/	
/**
 * Metodo que realiza el procesamiento de movimientos
 * Method procesaIcMov
 * @param usuarioBD String 
 * @param passwordBD String 
 * @param numRangoIni int
 * @param numRangoFin int 
 * @param tipoEstado String
 * @return int
 */	
	public native int procesaIcMov(String usuarioBD, String passwordBD, String codMasivo, int numRangoIni, int numRangoFin, String tipoEstado, String pathCfg);

	static {
		System.loadLibrary("central");
	}
}
