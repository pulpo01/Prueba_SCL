//-------------------------------------------------------------------------------------------------------------------//
// Para compilar esta clase y la librería:  
// javac JavaSched.java   
// javah -jni JavaSched
// cc -G -I/usr/local/j2sdk1.4.1_02/include -I/usr/local/j2sdk1.4.1_02/include/solaris schlibraryjava.c -o libschlibraryjava.so
// mv *.so ../lib/     
//-------------------------------------------------------------------------------------------------------------------//
package com.tmmas.SCH.Interfaz;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import org.apache.log4j.Logger;

/**
 *
 * @author mwt00178
 * @version $Revision$
 */
public class JavaSched {
	/**
	 * Field log
	 */
	Logger log = Logger.getLogger(" ");	
	/**
	 * Field ACTIVA
	 * (value is 1)
	 */
	static public final int ACTIVA    = 1;
	/**
	 * Field DESACTIVA
	 * (value is 0)
	 */
	static public final int DESACTIVA = 0;
	/**
	 * Field SCH_PLAY
	 * (value is 0)
	 */
	static public final int SCH_PLAY  = 0;
	/**
	 * Field SCH_PAUSP
	 * (value is 1)
	 */
	static public final int SCH_PAUSP = 1;
	/**
	 * Field SCH_CPU_PROCESO
	 * (value is 1)
	 */
	static public final int SCH_RETORNA_CPU = 1;
	/**
	 * Field SCH_MEMORIA_PROCESO
	 * (value is 2)
	 */
	static public final int SCH_RETORNA_MEMORIA = 2;		
	/**
	 * Field strIniConexion
	 * (value is ""jdbc:oracle:oci8:"")
	 */
	String strIniConexion = "jdbc:oracle:oci8:";
	/**
	* Field SENAL_STOP
	*/
	static public int SENAL_STOP;
	/**
	 * Field SENAL_PAUSA
	 */
	static public int SENAL_PAUSA;
	/**
	 * Field SENAL_PLAY
	 */
	static public int SENAL_PLAY;
	/**
	 * Field LOG_PAUSE_PLAY
	 */
	static public int LOG_PAUSE_PLAY; 
	/**
	 * Field KILL_TERMINA
	 */
	static public int KILL_TERMINA;
	/**
	 * Field strConexion
	 */
	String strConexion = new String("");

//---->>> Metodos Nativos
	/**
	* Method displayJavaSched
	*/
	private native void displayJavaSched();
	/**
	 * Method nativeSendSignal
	 * @param signal int
	 * @param pid int
	 */
	private native void nativeSendSignal(int signal, int pid);
	/**
	 * Method nativeGetpid
	 * @return int
	 */
	private native int  nativeGetpid() throws Exception;
	private void callback() throws Exception {
	  throw new Exception("thrown en metodo nativo");
	}
	
	/**
	 * Method nativeEjecutaPausa
	 * @param senalPausa int
	 */
	private native void nativeEjecutaPausa(int senalPausa);
	/**
	 * Method nativeSetSignal
	 */
	private native void nativeSetSignal();
	/**
	 * Method nativeSetSignal
	 * @param pid int
	 * @param opcion int
	 * @return String
	 */
	private native static String nativePidMemCpu(int pid, int opcion);
	/**
	 * Method nativeHostMemCpu
	 * @param opcion int
	 * @return String
	 */
	private native String nativeHostMemCpu(int opcion);

/**
 * Constructor predeterminado
 * Constructor for JavaSched
 */
	public JavaSched() {
		SENAL_STOP  	= DESACTIVA;
		SENAL_PAUSA 	= DESACTIVA;
		SENAL_PLAY  	= DESACTIVA;
		LOG_PAUSE_PLAY 	= DESACTIVA;
		KILL_TERMINA	= ACTIVA;	
	}		

/**
 * Constructor para el seteo automatico de las señales
 * Constructor for JavaSched
 * @param seteo boolean
 */
	public JavaSched(boolean seteo) {
		SENAL_STOP  	= DESACTIVA;
		SENAL_PAUSA 	= DESACTIVA;
		SENAL_PLAY  	= DESACTIVA;
		LOG_PAUSE_PLAY 	= DESACTIVA;
		KILL_TERMINA	= ACTIVA;
		if (seteo) nativeSetSignal();
	}
	    
/**
 * Metodo para el envio de señales
 * Method sendSignal
 * @param signal int
 * @param pid int
 */
	public void sendSignal(int signal, int pid) {
		nativeSendSignal(signal, pid);
	}
	
/**
 * Metodo para la recuperacion del pid
 * Method getPid
 * @return int
 */
	public int getPid() {
		try {
			return nativeGetpid();
		} catch(Exception e) {
			return(0);
		}
	}
	
/**
 * Metodo para setear las señales
 * Method setSignal
 */
	public void setSignal() {
		nativeSetSignal();
	}

/**
 * Metodo para quedar en pausa real hasta que llegue otra señal
 * Method ejecutaPausa
 */
	public void ejecutaPausa() {
		nativeEjecutaPausa(SENAL_PAUSA);
	}

/**
 * Metodo para saber el estado de la CPU y/o La Memoria que está
 * utilizando el proceso en este momento
 * Method ejecutaPausa
 * @param opcion int : SCH_MEMORIA_PROCESO o SCH_CPU_PROCESO 
 * @return float 
 */
	public float getPidMemCpu(int opcion) {
		float salida = 0;		
		salida = Float.parseFloat(nativePidMemCpu(getPid(),opcion));
		if (salida == -1) {
			log.error("No se ha podido recuperar la información del proceso!! opcion: [" + opcion +"]");
		}
		return(salida);
	}

/**
 * pidEstaEnEjecucion
 * Metodo para saber si un PID está en ejecución o no
 * @param int 
 * @return boolean 
 */
	public static boolean pidEstaEnEjecucion(int pid) {
		if( Integer.parseInt(nativePidMemCpu(pid,SCH_RETORNA_CPU)) == -1)
			return(false);
		else
			return(true);
	}

/**
 * Metodo para saber el estado de la CPU y/o La Memoria que está
 * utilizando el proceso en este momento
 * Method ejecutaPausa
 * @param opcion int : SCH_MEMORIA_PROCESO o SCH_CPU_PROCESO 
 * @return float 
 */
	public float getHostMemCpu(int opcion) {
		float salida = 0;		
		salida = Float.parseFloat(nativeHostMemCpu(opcion));
		if (salida == -1) {
			log.error("No se ha podido recuperar la información del proceso!! opcion: [" + opcion +"]");
		}
		return(salida);
	}

/**
 * Crea Archivo de Inicio de Proceso para Scheduler en caso de caida
 * BD scheduler
 * Method creaFile
 * @param pcod_serv String
 * @param pcod_proc String
 * @param pcod_subpro String
 * @param pcod_con String
 * @param pcod_tcon String
 * @param pcod_apli String
 * @param pnum_pid String
 */
	public void creaFile(String pcod_serv, String pcod_proc, String pcod_subpro, 
					 String pcod_con,  String pcod_tcon, String pcod_apli, String pnum_pid) {
		//nativeCreaFile(pcod_serv,pcod_proc,pcod_subpro,pcod_con,pcod_tcon,pcod_apli,pnum_pid);
	}

/**
 * Graba en Tablas Scheduler Inicio ejecucion
 * Method marcaInicio
 * @param pcod_serv String
 * @param pcod_proc String
 * @param pcod_subpro String
 * @param pcod_con String
 * @param pcod_tcon String
 * @param pcod_apli int
 * @param pnum_pid int
 * @throws SQLException
 */
	public void marcaInicio(String pcod_serv, String pcod_proc, String pcod_subpro, 
						String pcod_con,  String pcod_tcon, int pcod_apli, int pnum_pid) 
	throws SQLException {
		try {
			String strSql = new String("");
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			String urlconect = new String(strConexion);
//---->>> Conexion con la Base de Datos
			Connection conn = DriverManager.getConnection (urlconect);
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "{call PRO_MARCA_INI_ENLINEA (?,?,?,?,?,?,?) }";  
			CallableStatement stmt = conn.prepareCall(strSql) ;	    		
//---->>> Envía los parámetros
			stmt.setString( 1,pcod_serv);
			stmt.setString( 2,pcod_proc);
			stmt.setString( 3,pcod_subpro);
			stmt.setString( 4,pcod_con);
			stmt.setString( 5,pcod_tcon);
			stmt.setInt   ( 6,pcod_apli);
			stmt.setInt   ( 7,pnum_pid);
//--->>> Termina la transacción
			stmt.executeUpdate() ;
			stmt.close ();
			conn.close (); 
			log.info("--->>> Scheduler notificado del inicio del programa ");
		}
		catch (Exception e) {
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<---");
		}
	}
			                	    
/**
 * Graba en Tablas Scheduler Termino ejecucion
 * Method marcaFin
 * @param pcod_serv String
 * @param pcod_proc String
 * @param pcod_subpro String
 * @param pcod_con String
 * @param pcod_tcon String
 * @param pcod_apli int
 * @param pnum_pid int
 * @throws SQLException
 */
	public void marcaFin(String pcod_serv, String pcod_proc, String pcod_subpro, 
					 String pcod_con,  String pcod_tcon, int pcod_apli, int pnum_pid) 
	throws SQLException {
		try {
			String strSql = new String("");
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			String urlconect = new String(strConexion);
//---->>> Conexion con la Base de Datos
			Connection conn = DriverManager.getConnection (urlconect);
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "{call PRO_MARCA_TERMINO (?,?,?,?,?,?,?) }";  
			CallableStatement stmt = conn.prepareCall(strSql) ;	    		
//---->>> Envía los parámetros
			stmt.setString( 1,pcod_serv);
			stmt.setString( 2,pcod_proc);
			stmt.setString( 3,pcod_subpro);
			stmt.setString( 4,pcod_con);
			stmt.setString( 5,pcod_tcon);
			stmt.setInt   ( 6,pcod_apli);
			stmt.setInt   ( 7,pnum_pid);
//--->>> Termina la transacción
			stmt.executeUpdate() ;
			stmt.close ();
			conn.close (); 
			log.info("--->>> Scheduler notificado del Termino del programa ");
		}
		catch (Exception e) {
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<---");
		}
	}

/**
 * Graba en Tablas Scheduler los datos de una tarea para señales
 * Method marcaIniTarea
 * @param pcod_serv String
 * @param pcod_proc String
 * @param pcod_subpro String
 * @param pcod_con String
 * @param pcod_tcon String
 * @param pcod_apli int
 * @param pnum_pid int
 * @param pcod_tarea String
 * @param pcod_numjob String
 * @throws SQLException
 */
	public void marcaIniTarea(String pcod_serv, String pcod_proc, String pcod_subpro, 
						  String pcod_con,  String pcod_tcon, int pcod_apli, int pnum_pid, 
						  String pcod_tarea,String pcod_numjob) 
	throws SQLException {
		try {
			String strSql = new String("");
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			String urlconect = new String(strConexion);
//---->>> Conexion con la Base de Datos
			Connection conn = DriverManager.getConnection (urlconect);
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "{call PRO_MARCA_INI_BATCH (?,?,?,?,?,?,?,?,?) }";  
			CallableStatement stmt = conn.prepareCall(strSql) ;	    		
//---->>> Envía los parámetros
			stmt.setString( 1,pcod_serv);
			stmt.setString( 2,pcod_proc);
			stmt.setString( 3,pcod_subpro);
			stmt.setString( 4,pcod_con);
			stmt.setString( 5,pcod_tcon);
			stmt.setString( 6,pcod_numjob);
			stmt.setInt   ( 7,pnum_pid);
			stmt.setString( 8,pcod_tarea);
			stmt.setInt   ( 9,pcod_apli);
			
//--->>> Termina la transacción
			stmt.executeUpdate() ;
			stmt.close ();
			conn.close (); 
			log.info("--->>> Scheduler notificado del inicio de la tarea ");
		}
		catch (Exception e) {
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<---");
		}
	}
/**
 * Graba en Tabla sch_profile Estado actual proceso
 * Method marcaEstado
 * @param pcod_serv String
 * @param pnum_pid int
 * @param pcod_estado_act int
 * @param pcod_estado_new int
 * @return int
 * @throws SQLException
 */
	public int marcaEstado(String pcod_serv, int pnum_pid, int pcod_estado_act, int pcod_estado_new) 
	throws SQLException {
		try {
			String codEstadoAct; 
			String codEstadoNew;
			if ((pcod_estado_act != SCH_PLAY) && (pcod_estado_act != SCH_PAUSP)) {
				log.error("El estado actual es erróneo, sólo entregar valores [SCH_PLAY] o [SCH_PAUSP]");
				return(-1);
			}
			else {
				if (pcod_estado_act == SCH_PLAY) codEstadoAct = new String("PLAY"); else codEstadoAct = new String("PAUSP");
			}
			if ((pcod_estado_new != SCH_PLAY) && (pcod_estado_new != SCH_PAUSP)) {
				log.error("El estado nuevo es erróneo, sólo entregar valores [SCH_PLAY] o [SCH_PAUSP]\n");
				return(-1);
			}		
			else {
				if (pcod_estado_new == SCH_PLAY) codEstadoNew = new String("PLAY"); else codEstadoNew = new String("PAUSP");
			}
//---->>> Termino de la validación  			
			String strSql = new String("");
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			String urlconect = new String(strConexion);
//---->>> Conexion con la Base de Datos
			Connection conn = DriverManager.getConnection (urlconect);
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "{call PRO_MARCA_PROFILE (?,?,?,?) }";  
			CallableStatement stmt = conn.prepareCall(strSql) ;	    		
//---->>> Envía los parámetros
			stmt.setString( 1,pcod_serv);
			stmt.setInt   ( 2,pnum_pid);
			stmt.setString( 3,codEstadoAct);
			stmt.setString( 4,codEstadoNew);
			
//--->>> Termina la transacción
			stmt.executeUpdate() ;
			stmt.close ();
			conn.close (); 
			log.info("--->>> Scheduler notificado del inicio de la tarea ");
			return(0);
		}
		catch (Exception e) {
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<---");
			return(-1);
		}
	}
	
/**
 * Conexion Instancia de SCH 
 * Method conexion
 * @param strInstancia String
 * @param strUsuario String
 * @param strPassword String
 * @param pcod_serv String
 * @param pcod_proc String
 * @param pcod_subpro String
 * @param pcod_con String
 * @param pcod_tcon String
 * @param pcod_apli int
 * @param pnum_pid int
 * @throws SQLException
 */
	public void conexion(String strInstancia, String strUsuario, String strPassword, String pcod_serv, 
								String pcod_proc, String pcod_subpro, String pcod_con,
								String pcod_tcon, int pcod_apli, int pnum_pid) 
	throws SQLException
	{
		try {
			strConexion = strIniConexion + strUsuario + "/" + strPassword + "@" + strInstancia;
			DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
			String urlconect = new String(strConexion);
//---->>> Conexion con la Base de Datos
			Connection conn = DriverManager.getConnection (urlconect);
//--->>> Termina la transacción
			conn.close (); 
			log.info("--->>> Inicio de la conexión con Scheduler ");
		}
		catch (Exception e) {
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<---");
		}
	}

/*-------------------------------------------------------------------------*/
/*  Carga de la librería dinámica                                          */
/*-------------------------------------------------------------------------*/	
	static {
		System.loadLibrary("schlibraryjava");
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
