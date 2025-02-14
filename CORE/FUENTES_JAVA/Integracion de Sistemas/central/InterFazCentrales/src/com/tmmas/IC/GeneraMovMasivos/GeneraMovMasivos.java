package com.tmmas.IC.GeneraMovMasivos;
import java.io.FileOutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Vector;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.IC.Utils.LecturaParametros;
import com.tmmas.IC.Utils.Utilidades;
import com.tmmas.SCH.Interfaz.JavaSched;

/**
 * @author Juan Ramos
 *
 * Clase encargada de la ejecuci�n programada de los movimientos masivos
 * @version $Revision$
 */
public class GeneraMovMasivos {
/**
 * Field numVersion
 */
	private static String numVersion = new String("2.0"); // IMPORTANTE:-->> Registrar el cambio como una nueva versi�n
		/** Versi�n 1.0 Original**/
		/** Versi�n 2.0 Inc. 70907 **/
/**
 * Field log
 */
	private static Logger log = Logger.getLogger(GeneraMovMasivos.class.getName());
/**
 * Field param
 */
	public static LecturaParametros param = new LecturaParametros();
/**
 * Field conexionActual
 */		  
	private static Connection  conexionActual;
/**
 * Field statementActual
 */		  
	private static Statement   statementActual;	
/**
 * Field BD
 */		  
	private static ServicioBD	BD = new ServicioBD();
/**
 * Field nombreInstancia
 */
	public static String rutaConfig;
/**
 * Field codMasivosEnEjecucion 
 */
	private static Vector codMasivosEnEjecucion = new Vector();
/**
 * Field grupoProcesaMasivo
 */
	private static ThreadGroup grupoProcesaMasivo = new ThreadGroup("procesaMasivo");;

	public boolean evaluaError;
	
/**
* Method main
* @param args String[]
* @throws Exception
*/			 	
	public static void main(String [] args) {
		try {
			String nomShell   = "icprocmasivo";
			PropertyConfigurator.configureAndWatch("cfg/LogGenMasivo.properties");
			if (args.length == 0){
				log.fatal("Debe especificar la ruta completa del archivo de configuraci�n");
				System.exit(-1);
			}
			rutaConfig = args[0];
			if (args.length >= 2) nomShell = args[1];
			leeParametros();
			if (!conectaBaseDatos()) return;
			log.info("+------------------------------------------------------------------------------------+");
			log.info(" Inicio Servicio de Manejo de Movimientos Masivos");
			log.info(" N� de Versi�n: " + numVersion);
			log.info(" Plataforma de Trabajo: " + System.getProperties().getProperty("os.name") + " versi�n " + System.getProperties().getProperty("os.version"));
			log.info(" ------------------------->>> Configuracion <<<---------------------");
			log.info("  Se ejecutar�n m�ximo " + param.numMaxParalCodMasivo + " procesos por c�digo masivo");
			log.info("  Se ejecutar�n m�ximo " + param.numMaxParalGeneral + " procesos en general");
			log.info("  Maximo de Cpu utilizada en el equipo para ejecutar: " + param.maximoCpuEquipoEnvio);
			log.info("  Maximo de Memoria utilizada en el equipo para ejecutar: " + param.maximoMemEquipoEnvio);
			log.info("  Se reintentar�n las ca�das como m�ximo " + param.numReintentosCaidas + " veces");
			log.info("  Proceso Masivo de ejecuci�n: " + param.comandoProcMasivo);
			log.info("+------------------------------------------------------------------------------------+\n\n\n");
			
			
			String plataforma = System.getProperties().getProperty("os.name").toLowerCase();
			if (plataforma.indexOf("indows") < 0) {
				JavaSched jSched = new JavaSched();
//--->>> Seteo Inicial de Se�ales 
				log.info("El PID del proceso es: " + jSched.getPid());
				log.info("El servidor se encuentra con una carga de: ");
				log.info("   * " + jSched.getHostMemCpu(JavaSched.SCH_RETORNA_CPU) + "% de promedio en CPU Utilizada");
				log.info("   * " + jSched.getHostMemCpu(JavaSched.SCH_RETORNA_MEMORIA) + "% de Memoria Utilizada");
				
				
				String archivoSalida = "tmp/" + nomShell + ".PID";
				try {
					FileOutputStream fSalida = new FileOutputStream(archivoSalida);
					fSalida.write(String.valueOf(jSched.getPid()).getBytes());
					fSalida.close();				
				} catch(Exception e) {
					log.error("No se pudo registrar el PID del proceso en archivo [" + archivoSalida + "]");
					log.error("StackTrace:",e);;
				}				
			}
			//--->>> Revisa las ejecuciones pendientes por ca�das.
			revisaEjecucionesActivas();
			
			while (true) { //JavaSched.SENAL_STOP != JavaSched.ACTIVA
				revisaEjecucionesPendientes();
				esperar();
			}			
			//log.info("---->>>> Termina la ejecuci�n del Servicio <<<<-----");		
		} catch (Exception e) {
			log.fatal("Excepcion en el main!!!");
			log.error("StackTrace:",e);
			try {
				conexionActual.close();
			} catch (Exception e2){}			
		}
	}

/**
 * Espera un tiempo y lee los parametros 
 */	
	private static void esperar() {
		try {
			Thread.sleep(1000);
			leeParametros();
		} catch(Exception e) {
			log.error("Error en la espera",e);
		}
	}
/**
 * Method revisaEjecucionesActivas
 * Revisi�n de las tareas activas seg�n la base de datos v/s la ejecuci�n por hilo
 * @throws SQLException
 */
	private static int revisaEjecucionesActivas() 
	throws SQLException {
		ResultSet rs = null;
		int activas = 0;
		try {
			int numRangoPendientes;
			int numRangoReintentables;
			String codMasivo = "";
			
			rs = BD.getEjecucionesActivas(statementActual);

			if (rs == null) {
				log.info("No quedaron tareas activas desde la ultima ejecucion");
				return(0);
			} 
			boolean ejecutado = false;
			do {
				codMasivo 				= rs.getString("Cod_Masivo");
				numRangoPendientes 		= rs.getInt   ("Num_Rango_Pendientes");
				numRangoReintentables 	= rs.getInt   ("Num_Rango_Reintentables");
				
				Thread procMasivo = null;
				for (int i = 0; i < codMasivosEnEjecucion.size(); i++) {
					procMasivo = (Thread)codMasivosEnEjecucion.elementAt(i);
					if ( procMasivo.getName().equals("PM_" + codMasivo) ) {
						if (!procMasivo.isAlive()) {
							log.warn("La tarea [" + procMasivo.getName() + "] existia pero estaba inactiva. Se vuelve a leventar ");
							procMasivo.start();
							ejecutado = true;
							break;
						} else {
							ejecutado = true;
							break;
						}
					}
				}

				if (!ejecutado){
					log.info("La tarea [" + codMasivo + "] es informada en BD como activa. Se levanta un hilo para atenderla");
					ejecutaProcMasivo(codMasivo,numRangoPendientes,numRangoReintentables);
				}
				activas ++;
			} while (rs.next());
			rs.close();
			return(activas);
		} catch (ArrayStoreException ae) { 
			return(activas);
		} catch(Exception e) {
			log.error("Error en revisi�n de Ejecuciones Activas " + e.getMessage());
			log.error("StackTrace:",e);
			return(activas);
		}
	}
	
/**
 * Method ejecutaProcMasivo
 * Ejecuta un hilo de la tarea procesaMasivo
 * @param codMasivo String
 * @param numRangoPendiente int
 * @param numRangoReintentables int
 */
	private static void ejecutaProcMasivo(String codMasivo, int numRangoPendiente, int numRangoReintentables) {
		try {
			ProcesaMasivo procMasivo = new ProcesaMasivo(grupoProcesaMasivo, "PM_" + codMasivo, param,codMasivosEnEjecucion);
			codMasivosEnEjecucion.addElement(procMasivo);
			procMasivo.asignaNuevoProcMasivo(codMasivo,numRangoPendiente,numRangoReintentables);
			BD.putNuevaEjecucionMovimiento(conexionActual,codMasivo,"PM_" + codMasivo,numRangoPendiente,numRangoReintentables);
			procMasivo.start();
			log.info("Se inicia una nueva ejecuci�n de ProcesaMasivo, ID= " + "PM_" + codMasivo);
			log.info("Se suma al contador de c�digos masivos. Queda en: " + codMasivosEnEjecucion.size());
		} catch (Exception e) {
			log.error("Error al iniciar un procesamiento masivo: " + e.getMessage());
			log.error("StackTrace:",e);
		}
	}
	
	
/**
 * Method revisaEjecucionesPendientes
 * Revisi�n de los procesos que deben ser ejecutados en un instante del tiempo
 * @throws SQLException
 */
	private static void revisaEjecucionesPendientes() 
	throws SQLException {
		ResultSet rs = null;
		try {
			String codMasivo = "";
			boolean ejecutado = false;
			rs = BD.getMovParaEjecucion(statementActual);
			if (rs == null) return;
			String codIntervalo = "";
			String fecEjecIni   = "";
			int    numIntervalo = 0;
			String diaSemana    = "";
			int horIniFranja    = 0;
			int horFinFranja    = 0;
			int numRangoPendientes    = 0;
			int numRangoReintentables = 0;
			
			do {
				if (!esPosibleEjecutarParalelo()) {
					Thread.sleep(1000); //-->>> Si no es posible ejecutar, espera un segundo y vuelve a preguntar
					leeParametros();
					continue;
				}
				
				codMasivo 				= rs.getString("Cod_Masivo");
				fecEjecIni 				= rs.getString("Fec_Ejec_Ini");
				codIntervalo 			= rs.getString("Cod_Intervalo");
				numIntervalo 			= rs.getInt   ("Num_Intervalo");
				diaSemana 				= rs.getString("Dia_Semana");
				horIniFranja 			= rs.getInt   ("Hor_Ini_Franja");
				horFinFranja 			= rs.getInt   ("Hor_Fin_Franja");
				numRangoPendientes 		= rs.getInt   ("Num_Rango_Pendientes");
				numRangoReintentables 	= rs.getInt   ("Num_Rango_Reintentables");
				log.info("Se debe ejecutar el codigo_masivo: [" + codMasivo + "], se busca en las tareas activas (Tareas: " + grupoProcesaMasivo.activeCount() + ", Contabilizadas: " + codMasivosEnEjecucion.size() + ")");
				ejecutado = false;
				
								
				for (int i=0; i < codMasivosEnEjecucion.size();i++) {
					ProcesaMasivo pm = (ProcesaMasivo)codMasivosEnEjecucion.elementAt(i);
					if (pm != null) {
						if ( pm.getName().equals("PM_" + codMasivo) ) {
							if (pm.getProcesosEncolados(codMasivo) <= param.numMaximoEjecPendientes) {
								pm.asignaNuevoProcMasivo(codMasivo,numRangoPendientes,numRangoReintentables);
								log.debug("Ya existe una tarea para el proceso masivo [" + pm.getName() + "]. Se le asigna nuevo trabajo. Queda en " +  pm.getProcesosEncolados(codMasivo) + " procesos encolados");
							} else {
								log.info("No es posible asignar la ejecuci�n al c�digo masivo ya que sobrepasar�a el m�ximo del buffer permitido: " + param.numMaximoEjecPendientes );
							}
							ejecutado = true;
							break;
						} 
					} else {
						log.warn("El c�digo masivo: PM_" + codMasivo + " no est� registrado correctamente en memoria");
						break;
					}
					
				}

				if (!ejecutado){
					ejecutaProcMasivo(codMasivo,numRangoPendientes,numRangoReintentables);
				}
				
				String fecProxEjecucion = VerProximaEjec(codIntervalo,numIntervalo,diaSemana,horIniFranja,horFinFranja);
				log.info("Se actualiza la fecha de ejecuci�n a: [" + fecProxEjecucion + "], movimiento masivo: [" + codMasivo + "]");
				BD.setNuevaFechaEjecucion(conexionActual,codMasivo,fecProxEjecucion);
			} while (rs.next());
			rs.close();
		} catch (Exception e) {
			log.error("Error en revisi�n de Ejecuciones Pendientes " + e.getMessage());
			log.error("StackTrace:",e);
		}
	}

/**
 * Method revisaEjecucionesPendientes
 * Revisi�n de los procesos que deben ser ejecutados en un instante del tiempo
 * @param codIntervalo String
 * @param numIntervalo int
 * @param diaSemana String
 * @param horInifranja int
 * @param horFinfranja int
 * @return String
 * @throws SQLException
 */
	private static String VerProximaEjec(String codIntervalo, int numIntervalo, String diaSemana, int horInifranja, int horFinfranja)
	throws SQLException {
			int a = 0;
			int ini_hora; 
			int ini_min;  
			int fnow; 
			int fini; 
			int fter; 
			int ter_hora; 
			int ter_min;  
			int totMinutos = 0;
			int totSegundos = 0;
			SimpleDateFormat fFecha = new SimpleDateFormat("dd'/'MM'/'yyyy HH:mm:ss");
			String strfecha= "";
			Date now = new Date();
			Calendar calendar = new GregorianCalendar();
			//--->>> 1 X cantidad
			totSegundos = 1 * numIntervalo;
			if (codIntervalo.equals("MIN")) totSegundos = 1 * 60 *                totSegundos;
			if (codIntervalo.equals("HOR")) totSegundos = 1 * 60 * 60 *           totSegundos;
			if (codIntervalo.equals("DIA")) totSegundos = 1 * 60 * 60 * 24 *      totSegundos;
			if (codIntervalo.equals("SEM")) totSegundos = 1 * 60 * 60 * 24 * 7 *  totSegundos;
			if (codIntervalo.equals("MES")) totSegundos = 1 * 60 * 60 * 24 * 30 * totSegundos;
			
			if ( (now = BD.getNowBD(conexionActual)) == null ) return(null);
			calendar.setTime(now);
			calendar.add(Calendar.SECOND, totSegundos);
			int ndia = Utilidades.diaSemana(calendar.get(Calendar.DAY_OF_MONTH),calendar.get(Calendar.MONTH) + 1,calendar.get(Calendar.YEAR));
			String ejecuta = diaSemana.substring(ndia - 1,ndia);
			
			int now_hora, now_min, now_sec; 

			while (true) {
				a = 0;
				while (!ejecuta.equals("S")) {
					a++;
					calendar.add(Calendar.SECOND, 86400);
					ndia = Utilidades.diaSemana(calendar.get(Calendar.DAY_OF_MONTH),calendar.get(Calendar.MONTH) + 1,calendar.get(Calendar.YEAR));
					ejecuta = diaSemana.substring(ndia - 1,ndia);
				}

				if ( horInifranja != -1  && horFinfranja != -1 ) {
					if (a == 0)	{
						now_hora    = calendar.get(Calendar.HOUR_OF_DAY);
						now_min		= calendar.get(Calendar.MINUTE);  
						now_sec		= calendar.get(Calendar.SECOND); 
					} else {
						now_hora    = Integer.parseInt(Utilidades.formatNum(horInifranja,"0000").substring(0,2)); 
						now_min     = Integer.parseInt(Utilidades.formatNum(horInifranja,"0000").substring(2));  
						now_sec		= 0;
						calendar.set(Calendar.HOUR_OF_DAY,now_hora);
						calendar.set(Calendar.MINUTE,now_min);
					}

					ini_hora    = Integer.parseInt(Utilidades.formatNum(horInifranja,"0000").substring(0,2)); 
					ini_min     = Integer.parseInt(Utilidades.formatNum(horInifranja,"0000").substring(2));  
					ter_hora    = Integer.parseInt(Utilidades.formatNum(horFinfranja,"0000").substring(0,2)); 
					ter_min     = Integer.parseInt(Utilidades.formatNum(horFinfranja,"0000").substring(2));  

					fnow 		= now_hora * 3600 + (now_min * 60); 
					fini 		= ini_hora * 3600 + (ini_min * 60); 
					fter 		= ter_hora * 3600 + (ter_min * 60); 

					if (fini < fter) {
						if (fnow < fini) {
							calendar.set(Calendar.HOUR_OF_DAY,ini_hora);
							calendar.set(Calendar.MINUTE,ini_min);
						} else if (fnow > fter) {
							ejecuta = "N";
							continue;
						}
					} else {
						if ((fnow < fter) && (fnow > fini)) {
							calendar.set(Calendar.HOUR_OF_DAY,ter_hora);
							calendar.set(Calendar.MINUTE,ter_min);
						}
					}
					strfecha = fFecha.format(calendar.getTime());
					break;
				}
				else {
					strfecha = fFecha.format(calendar.getTime());
					break;				
				}
			} 
			return(strfecha);
		}

/**
 * Revisa si las condiciones de paralelismo hacen posible la ejecuci�n de otro c�digo masivo
 * @return
 * @throws Exception
 */
	
	private static boolean esPosibleEjecutarParalelo() 
	throws Exception {
		String plataforma = System.getProperties().getProperty("os.name").toLowerCase();
		if (plataforma.indexOf("indows") < 0) {
//--->>> Revisa Cpu del Servidor.
			JavaSched jSched = new JavaSched();
			if (jSched.getHostMemCpu(JavaSched.SCH_RETORNA_CPU) > param.maximoCpuEquipoEnvio && param.maximoCpuEquipoEnvio > 0) {
				log.info("La cpu del equipo se encuentra en [" + 
				         jSched.getHostMemCpu(JavaSched.SCH_RETORNA_CPU) + 
                         "] y sobrepasa el m�ximo permitido [" + param.maximoCpuEquipoEnvio + "], no se continua ejecutando");
				esperar();
				return(false);
			}
//--->>> Revisa Memoria del Servidor.
			if (jSched.getHostMemCpu(JavaSched.SCH_RETORNA_MEMORIA) > param.maximoMemEquipoEnvio && param.maximoMemEquipoEnvio > 0) {
				log.info("La memoria del equipo se encuentra en [" +  
				          jSched.getHostMemCpu(JavaSched.SCH_RETORNA_MEMORIA) + 
				          "] y sobrepasa el m�ximo permitido [" + param.maximoMemEquipoEnvio + "], no se continua ejecutando");
				esperar();
				return(false);
			}		
		}
		//if ( revisaEjecucionesActivas() < param.numMaxParalGeneral) {
		if ( codMasivosEnEjecucion.size() >= param.numMaxParalGeneral) {
			log.info("Se ha llegado al m�ximo de procesos paralelos: Maximo: [" + param.numMaxParalGeneral + "], En Ejecuci�n: [" + codMasivosEnEjecucion.size() + "]. Se debe esperar para ejecutar nuevamente");
			return(false);
		}
		return(true);
	}
	
/**
 * Method conectaBaseDatos
 * Metodo para Abrir una sesi�n de Oracle exclusiva para el cliente
 * @return boolean
 * @throws SQLException
 */
	private static boolean conectaBaseDatos()
	throws SQLException {
		  try {
//--->>> Conexi�n con la Base de Datos
			
		  conexionActual = BD.conectaBaseDatos(param.nomHostDB,  param.numPuertoDb,param.instanciaDb,
											   param.usuarioDb, param.usuariopDb);
		  statementActual = BD.creaStatementConsulta(conexionActual);
		  if (conexionActual == null) {
			  log.error("No se ha podido establecer la conexi�n con la Base de Datos ");
			  return(false);		
		  }
		  log.debug("Conectado con la base de datos" );
		  return(true);
	  } catch (SQLException e) {
		  log.error("No se ha podido establecer la conexi�n con la Base de Datos " + e.getMessage());
		  log.error("StackTrace:",e);
		  return(false);
	  }		
  }

/**
 * Metodo que lee los par�metros principales
 * Method leeParametros
 * @return int
 */
	public static int leeParametros() {
		try {
			int salida = 0;	
			salida = param.leer(rutaConfig);
			return(salida);
		} catch	 (Exception e) {
			log.error("Error en la lectura de parametros: --->>> [" + e.getMessage()+ e.getCause()  + "] <<<---");
			log.error("StackTrace:",e);
			return(1);
	 	}
	}


	/**
	 * Metodo que evalua errores de excepciones
	 * Method evaluaError
	 * @return boolean
	 */
	
	public boolean evaluaError(String mensaje) 
	{ 	
		if (mensaje!=null && mensaje!="" ){			
			if (mensaje.indexOf("Closed Connection") >= 0 )
			{			
				return (true);
			}
			else
			{
					if (mensaje.indexOf("ORA-02396") >= 0 )
					{					
						return (true);
					}				
					else
					{
						if (mensaje.indexOf("ORA-01092") >= 0 )
					     {					
						    return (true);
				 	     }				
                         else{    
						     /*Para seguir agregando m�s errores se debe hacer desde aqui*/					
						}
					}				
			}
		}	
		return(false);	
	}
}
//******************************************************************************************
//** Informaci�n de Versionado *************************************************************
//******************************************************************************************
//** Pieza                                               : 
//**  %ARCHIVE%
//** Identificador en PVCS                               : 
//**  %PID%
//** Producto                                            : 
//**  %PP%
//** Revisi�n                                            : 
//**  %PR%
//** Autor de la Revisi�n                                :          
//**  %AUTHOR%
//** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : 
//**  %PS%
//** Fecha de Creaci�n de la Revisi�n                    : 
//**  %DATE% 
//** Worksets ******************************************************************************
//** %PIRW%
//** Historia ******************************************************************************
//** %PL%
//******************************************************************************************
