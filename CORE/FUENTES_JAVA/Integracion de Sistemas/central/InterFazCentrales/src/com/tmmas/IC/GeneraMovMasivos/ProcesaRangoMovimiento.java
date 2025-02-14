package com.tmmas.IC.GeneraMovMasivos;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import org.apache.log4j.Logger;

import com.tmmas.IC.Utils.LecturaParametros;
/**
 * Clase para el manejo de los rangos de ejecución del procesamiento masivo de 
 * comandos icmovk
 * @author Juan Ramos
 * @version $Revision$
 */
    public class ProcesaRangoMovimiento extends Thread {
/**
 * Field log
 */
	private static Logger log = Logger.getLogger(ProcesaRangoMovimiento.class.getName());
/**
 * Field param
 */
	public static LecturaParametros mParam = new LecturaParametros();
/**
 * Field conexionBD
 */		  
	private static Connection  conexionBD;
/**
 * Field statementActual
 */		  
	private static Statement   statementActual;	
/**
 * Field BD
 */		  
	private static ServicioBD	BD = new ServicioBD();
/**
 * Field id
 */	
	public String id;
/**
 * Field procesosPendientes
 */	
	public Vector procesosPendientes = new Vector();
/**
 * Field codTarea
 */			
	private int codTarea;
/**
 * Field ejecPendientes
 */		
	private boolean ejecPendientes = true;
/**
 * Field nodo
 */		
	private TypeNodoRango nodo;
/**
 * Field procesosEnEjecucion
 */
	private Vector procesosEnEjecucion;

/**
 * Field strErrorBD
 */
   	public String strErrorBD = "";	
   	
   	public GeneraMovMasivos GMM = new GeneraMovMasivos();
	
/**
 * Constructor for ProcesaRangoMovimiento
 * @param pGrupo ThreadGroup
 * @param pId String
 * @param pCodTarea int
 * @param pConexionActual Connection
 * @param pBD ServicioBD
 * @param pParam LecturaParametros
 * @param pNodo TypeNodoRango
 */
   	
	public ProcesaRangoMovimiento(ThreadGroup pGrupo, String pId, int pCodTarea, Connection pConexionActual, 
	                              ServicioBD pBD, LecturaParametros pParam, TypeNodoRango pNodo, Vector procesosEnEjecucion) {
		super(pGrupo,pId);		
		id             = pId;
		BD             = pBD;
		mParam         = pParam;
		codTarea       = pCodTarea;
		nodo           = pNodo;
		conexionBD = pConexionActual;
		ejecPendientes = true;
		this.procesosEnEjecucion = procesosEnEjecucion;
	}

	
/**
 * Method run
 * @see java.lang.Runnable#run()
 */
	public void run() {
		ResultSet rs = null;
		try {
			int i=0;
			synchronized (BD) {
				statementActual = BD.creaStatementConsulta(conexionBD);
			}
			
			/* TODO -> Se modifica por MA-37433 <- Igor Sánchez B.*/
			/*if (ejecPendientes) {*/ //--->>> Ejecuta el icmovk sólo una vez
				synchronized (BD) {
					BD.putNuevaEjecucionRango(conexionBD,nodo);
				}
				do {
					if (ejecutaProceso(nodo)) return;
					log.warn("El rango [" + nodo.numRangoIni + "-" + nodo.numRangoFin + "] del código masivo [" + nodo.codMasivo + "] ha terminado mal, se reintenta ");
					i ++;	
				} while (i < mParam.numReintentosCaidas);
				log.error("Se han vencido los reintentos para el rango El rango [" + nodo.numRangoIni + "-" + nodo.numRangoFin + "] del código masivo [" + nodo.codMasivo + "]");
				synchronized (BD) {
					BD.setEstadoEjecucionRango(conexionBD,nodo.codMasivo,nodo.numRangoIni,ServicioBD.ESTADO_ERROR,true);
				}			
		}catch (Exception e) {
				strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					System.exit(-2);				
			}		
			log.error("Error en metodo run del ProcesaRangoMovimiento : --->>> [" + e.getMessage() + "] <<<---");
			log.error("StacktTrace",e);
		} finally {
			procesosEnEjecucion.remove(this);
			log.info("Se resta al contador de procesos del codigo masivo. Queda en: " + procesosEnEjecucion.size());
		}
	}

/**
 * Method ejecutaProceso
 * Ejecuta via comando el programa
 * @return TypeNodoMasivo
 */	
	private boolean ejecutaProceso(TypeNodoRango nodo)
	throws SQLException {
		try {
			String archCfgLogComando = "";
			if (nodo.tipEstados.equals("P")) {
				archCfgLogComando = mParam.archCfgLogComandoPend;
			} else {
				archCfgLogComando = mParam.archCfgLogComandoRein;
			}
				
			String []parametros = new String[7];
			parametros[0] = mParam.comandoProcMasivo;
			parametros[1] = GeneraMovMasivos.rutaConfig;
			parametros[2] = nodo.codMasivo; 
			parametros[3] = String.valueOf(nodo.numRangoIni);
			parametros[4] = String.valueOf(nodo.numRangoFin);
			parametros[5] = nodo.tipEstados;
			parametros[6] = archCfgLogComando;

			String salComando = "";
			for (int i=0;i<parametros.length;i++)
				salComando += parametros[i] + " ";
			log.info("Comando Ejecutado: " + salComando);
			
			Process process = Runtime.getRuntime().exec(parametros);
			StreamGobbler limpiaES = new StreamGobbler(process.getInputStream(), "IN-" + nodo.codMasivo);
			StreamGobbler limpiaEE = new StreamGobbler(process.getErrorStream(), "ER-" + nodo.codMasivo);
			limpiaEE.start();
			limpiaES.start();
			process.waitFor();
			process = null;
			return(revisaTerminoEjecucion());
		} catch(Exception e) {
				strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(false);				
			}		
			log.error("Error en Ejecucion del proceso " + e.getMessage());
			log.error("StackTrace:",e);
			return(false);
		} finally {
			
		}
		
	}

/**
 * Method revisaTerminoEjecucion
 * Revisión del estadio de término de el programa ejecutado
 * @throws SQLException
 */
	private boolean revisaTerminoEjecucion() 
	throws SQLException {
		ResultSet rs = null;
		try {
			String codMasivo   = "";
			int    codTarea    = 0;
			int numReintentos  = 0;
			int numRangoIni    = 0;
			String estadoFinal = null;
			PreparedStatement stmt = null;
			synchronized (BD) {
				estadoFinal = BD.getEstadoEjecuRango(conexionBD,nodo.codMasivo, nodo.numRangoIni);
			}
			
			if (estadoFinal == null) {
				log.error("No ha sido posible rescatar el estado final de la ejecucion: " + nodo.codMasivo + " - " + nodo.numRangoIni);
				return(false);
			}
			log.info("El estado del termino del proceso es: " + estadoFinal);
			if (!estadoFinal.equals(ServicioBD.ESTADO_ACTIVO)) {
				synchronized (BD) {
					BD.setEstadoEjecucionRango(conexionBD,nodo.codMasivo,nodo.numRangoIni,ServicioBD.ESTADO_TERMINADO,false);
				}
				return(true);
			}
			log.error("El proceso termino mal, no marco su termino");
			return(false);
		} catch(Exception e) {
				strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(false);				
			}		
			log.error("Error en revision de Ejecuciones Activas " + e.getMessage());
			log.error("StackTrace:",e);
			return(false);
		} finally {
			if (rs != null) rs.close();
		}
	}

/**
 * Clase para limpiar los búffer de Salida estandar y Salida de Error del objeto Runtime.exec 
 * @author mwn70136
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
	class StreamGobbler extends Thread {
	    InputStream is;
	    String type;
	    
	    StreamGobbler(InputStream is, String type) {
	        this.is = is;
	        this.type = type;
	    }
	    
	    public void run() {
	        try {
	            InputStreamReader isr = new InputStreamReader(is);
	            BufferedReader br = new BufferedReader(isr);
	            String line=null;
	            while ( (line = br.readLine()) != null) {}
	            log.debug ("Fin de la limpieza [" + type + "]");
	        } catch (IOException ioe) {
	        	ioe.printStackTrace();  
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
