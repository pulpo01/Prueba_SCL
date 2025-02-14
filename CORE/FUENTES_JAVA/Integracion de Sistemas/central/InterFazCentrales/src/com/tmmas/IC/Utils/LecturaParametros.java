package com.tmmas.IC.Utils;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Properties;
import java.util.StringTokenizer;

import org.apache.log4j.Logger;

/**
 *
 * @author Juan Ramos
 * @version $Revision$
 */
public class LecturaParametros {
//--->>> DEFINICIÓN DE LOS PARÁMETROS ESPERADOS DENTRO DE EL SISTEMA
	
//---- Configuración	
/**
 * Field log
 */
private static Logger log = Logger.getLogger(LecturaParametros.class.getName());	
//--->>> Conexión
/**
* Field numPuertoServidor
*/
	public int    numPuertoServidor; 		// NUM_PUERTO_SERVIDOR
/**
 * Field nomKeyStore
 */
	public String nomKeyStore; 		   		// NOM_KEYSTORE
/**
 * Field numMaximoClientes
 */
	public int    numMaximoClientes; 		// NRO_MAXIMO_CLIENTES
/**
 * Field nomArchivoAcreditados
 */
	public String nomArchivoAcreditados;	// AUTH_FILE

/**
 * Field tipoSocket
 */
	public int    tipoSocket;              // TIPO_SOCKET
	
//--->>> Procesamiento Masivo de Movimientos
/**
 * Field numReintentosCaidas
 */
	public int numReintentosCaidas;			// NUM_REINTENTOS_CAIDAS
/**
 * Field tiempoRefrescaParam
 */
	public String comandoProcMasivo;		// COMANDO_PROC_MASIVO
/**
 * Field archCfgLogComandoPend
 */
	public String archCfgLogComandoPend;		// NOM_CFG_LOG_COMANDO_PEND	
/**
 * Field archCfgLogComandoRein
 */
	public String archCfgLogComandoRein;		// NOM_CFG_LOG_COMANDO_REIN
	
	
/**
 * Field numMaxParalCodMasivo
 */
	public int numMaxParalCodMasivo;		// NUM_MAX_PARALELO_XCOD_MASIVO
/**
 * Field numMaxParalGeneral
 */
	public int numMaxParalGeneral;			// NUM_MAX_PARALELO_GENERAL

/**
 * Fiel numMaximoEjecPendientes;
 */
	public int numMaximoEjecPendientes;		// NUM_MAXIMO_EJEC_PENDIENTES

/**
 * Fiel numMaximoEjecPendientes;
 */
	public int numMaximoEjecReintentables;	// NUM_MAXIMO_EJEC_REINTENTABLES

//--->>> Procesamiento de Respuestas 
/**
 * Field tiempoRefrescaParam
 */
	public int tiempoRefrescaParam;			// TIEMPO_REFRESCA_PARAM
	
/**
 * Field tiempoEnvioRenotif
 */
	public int tiempoEnvioRenotif;			// TIEMPO_REENVIO_RENOTIF
	
/**
 * Field numMaximoRenotifi
 */
	public int numMaximoRenotifi;			// NUM_MAXIMO_RENOTIF_TAREA
	
/**
 * Field numPromedioNotificaciones
 */
	public int numPromedioNotificaciones;	// PROMEDIO_NOTIFICACIONES
	
/**
 * Field numMinimoProcesadores
 */
	public int numMinimoProcesadores;		// NUM_MINIMO_PROCESADORES
	
/**
 * Field numMaximoProcesadores
 */
	public int numMaximoProcesadores;		// NUM_MAXIMO_PROCESADORES

/**
 * Field maximoMemProceso
 */
	public float maximoMemProceso;			// PORC_MAXIMO_MEMORIA_PROCESO

/**
 * Field maximoCpuProceso
 */
	public float maximoCpuProceso;			// PORC_MAXIMO_CPU_PROCESO

/**
 * Field maximoMemEquipoResp
 */
	public float maximoMemEquipoResp;			// PORC_MAXIMO_MEMORIA_EQUIPO_RESP
	
/**
 * Field maximoCpuEquipoResp
 */
	public float maximoCpuEquipoResp;			// PORC_MAXIMO_CPU_EQUIPO_RESP
/**
 * Field maximoMemEquipoEnvio
 */
	public float maximoMemEquipoEnvio;			// PORC_MAXIMO_MEMORIA_EQUIPO_ENVIO
	
/**
 * Field maximoCpuEquipoEnvio
 */
	public float maximoCpuEquipoEnvio;			// PORC_MAXIMO_CPU_EQUIPO_RESP_ENVIO
	
/**
 * Field maximoProcesadoresOciosos
 */
	public int maximoProcesadoresOciosos;		// PORC_MAXIMO_PROC_OCIOSOS
	
//--->>> Base de Datos	
/**
* Field instanciaDb
*/

	public String instanciaDb;				// INSTANCIA_DB
/**
 * Field usuarioDb
 */
	public String usuarioDb;				// USUARIO_DB
/**
 * Field usuariopDb
 */
	public String usuariopDb;				// USUARIOP_DB
/**
 * Field nomHostDB
 */
	public String nomHostDB;				// HOST_BD
/**
 * Field numPuertoDb
 */
	public int    numPuertoDb;				// PUERTO_BD
/**
 * Field defaultProps
 */
	private Properties defaultProps = new Properties();
/**
 * Field in
 */
	private FileInputStream in;

/**
 * Constructor for FrontEndParam
 * Constructor Uno, sólo incializa las variables
 */
	public LecturaParametros() {
		numPuertoServidor 		= 0;
		nomKeyStore 			= "";
		numMaximoClientes 		= 0;
		instanciaDb				= "";
		usuarioDb				= "";
		usuariopDb				= "";
		nomHostDB				= "";
		numPuertoDb				= 0;
		nomArchivoAcreditados 	= "";
		tipoSocket				= 0;
		tiempoRefrescaParam		= 0;		
		tiempoEnvioRenotif		= 0;	
		numMaximoRenotifi		= 0;	
		numPromedioNotificaciones = 0;
		numMinimoProcesadores 	= 0;
		numMaximoProcesadores 	= 0;
		maximoMemProceso    	= 0;			
		maximoCpuProceso    	= 0;			
		maximoMemEquipoResp    	= 0;			
		maximoCpuEquipoResp    	= 0;	
		maximoMemEquipoEnvio   	= 0;			
		maximoCpuEquipoEnvio   	= 0;			
		maximoProcesadoresOciosos = 0;
		numReintentosCaidas		= 0;
		numMaximoEjecPendientes = 0;
		numMaximoEjecReintentables=0;
		comandoProcMasivo		= "";
		archCfgLogComandoPend	= "";
		archCfgLogComandoRein	= "";
		numMaxParalCodMasivo 	= 0;
		numMaxParalGeneral		= 0;		
	}
/**
 * Constructor for FrontEndParam
 * Constructor Dos, recibe el nombre del archivo y lo lee
 * @param ruta String
 * @param archivo String
 */
	LecturaParametros(String rutaArchivoCfg) {
		leer(rutaArchivoCfg);	
	}
	
/**
 * Method leer
 * Busqueda dentro del archivo
 * @param ruta String
 * @param archivo String
 * @return int
 */
public int leer(String rutaArchivoCfg) {
		try {
			in = new FileInputStream(rutaArchivoCfg);
			defaultProps.load(in);
			numPuertoServidor 			= Integer.parseInt(extraeDatosConf("NUM_PUERTO_SERVIDOR"));
			nomKeyStore 	    		=                  extraeDatosConf("NOM_KEYSTORE");
			numMaximoClientes 			= Integer.parseInt(extraeDatosConf("NRO_MAXIMO_CLIENTES"));
			instanciaDb 				=                  extraeDatosConf("INSTANCIA_DB");
			usuarioDb 					=                  extraeDatosConf("USUARIO_DB");
			usuariopDb 					=                  extraeDatosConf("USUARIOP_DB");
			nomHostDB 					=                  extraeDatosConf("HOST_BD");
			numPuertoDb					= Integer.parseInt(extraeDatosConf("PUERTO_BD"));
			nomArchivoAcreditados 		=                  extraeDatosConf("AUTH_FILE");
			tipoSocket					= Integer.parseInt(extraeDatosConf("TIPO_SOCKET"));
			tiempoRefrescaParam			= Integer.parseInt(extraeDatosConf("TIEMPO_REFRESCA_PARAM"));  
			tiempoEnvioRenotif			= Integer.parseInt(extraeDatosConf("TIEMPO_REENVIO_RENOTIF")); 
			numMaximoRenotifi			= Integer.parseInt(extraeDatosConf("NUM_MAXIMO_RENOTIF_TAREA")); 
			numPromedioNotificaciones	= Integer.parseInt(extraeDatosConf("PROMEDIO_NOTIFICACIONES")); 
			numMinimoProcesadores	    = Integer.parseInt(extraeDatosConf("NUM_MINIMO_PROCESADORES")); 
			numMaximoProcesadores      	= Integer.parseInt(extraeDatosConf("NUM_MAXIMO_PROCESADORES")); 
			maximoMemProceso			= Float.parseFloat(extraeDatosConf("PORC_MAXIMO_MEMORIA_PROCESO")); 	
			maximoCpuProceso			= Float.parseFloat(extraeDatosConf("PORC_MAXIMO_CPU_PROCESO")); 
			maximoMemEquipoResp		  	= Float.parseFloat(extraeDatosConf("PORC_MAXIMO_MEMORIA_EQUIPO_RESP"));  
			maximoCpuEquipoResp			= Float.parseFloat(extraeDatosConf("PORC_MAXIMO_CPU_EQUIPO_RESP")); 
			maximoProcesadoresOciosos	= Integer.parseInt(extraeDatosConf("PORC_MAXIMO_PROC_OCIOSOS"));
			numReintentosCaidas			= Integer.parseInt(extraeDatosConf("NUM_REINTENTOS_CAIDAS"));
			comandoProcMasivo	 		=                  extraeDatosConf("COMANDO_PROC_MASIVO");
			archCfgLogComandoPend		=                  extraeDatosConf("NOM_CFG_LOG_COMANDO_PEND");
			archCfgLogComandoRein		=                  extraeDatosConf("NOM_CFG_LOG_COMANDO_REIN");
			numMaxParalCodMasivo 		= Integer.parseInt(extraeDatosConf("NUM_MAX_PARALELO_XCOD_MASIVO")); 
			numMaxParalGeneral			= Integer.parseInt(extraeDatosConf("NUM_MAX_PARALELO_GENERAL")); 
			maximoMemEquipoEnvio	  	= Float.parseFloat(extraeDatosConf("PORC_MAXIMO_MEMORIA_EQUIPO_ENVIO"));  
			maximoCpuEquipoEnvio		= Float.parseFloat(extraeDatosConf("PORC_MAXIMO_CPU_EQUIPO_ENVIO"));
			numMaximoEjecPendientes		= Integer.parseInt(extraeDatosConf("NUM_MAXIMO_EJEC_PENDIENTES"));
			numMaximoEjecReintentables	= Integer.parseInt(extraeDatosConf("NUM_MAXIMO_EJEC_REINTENTABLES"));

			if (maximoProcesadoresOciosos < numMinimoProcesadores) {
				log.warn("El número de procesadores ociosos [" + maximoProcesadoresOciosos + "] es menor al mínimo [" + numMinimoProcesadores + "] , se le asigna este último valor");
				maximoProcesadoresOciosos = numMinimoProcesadores;
			}
			
			if (numMaximoProcesadores < numMinimoProcesadores) {
				log.warn("El número de Máximo [" + numMaximoProcesadores + "] de procesadores es menor al mínimo [" + numMinimoProcesadores + "] , se le asigna este último valor");
				maximoProcesadoresOciosos = numMinimoProcesadores;
			}
			
			if (numPromedioNotificaciones ==0) {
				log.warn("El promedio de notificaciones por servidor está en cero, se le asigna [1]");
				numPromedioNotificaciones = 1;
			}

			if (maximoMemProceso     == 0) log.warn("El Máximo de memoria del proceso está en Cero. El criterio se deja sin efecto");
			if (maximoCpuProceso     == 0) log.warn("El Máximo de CPU del proceso está en Cero. El criterio se deja sin efecto");
			if (maximoMemEquipoResp  == 0) log.warn("El Máximo de memoria para el equipo (Respuesta) está en Cero. El criterio se deja sin efecto");
			if (maximoCpuEquipoResp  == 0) log.warn("El Máximo de CPU para el equipo (Respuesta) está en Cero. El criterio se deja sin efecto");
			if (numMaximoRenotifi    == 0) log.warn("El número Máximo de renotificaciones a procesar está en cero, por lo que nunca serán procesadas");
 			if (tiempoEnvioRenotif   == 0) log.warn("El tiempo de intervalo para procesar renotificaciones está en cero, por lo que nunca serán procesadas");
			if (tiempoRefrescaParam  == 0) log.warn("El tiempo de intervalo para refrescar los parámetros está en cero, por lo que no se volverán a refrescar");
			if (maximoMemEquipoEnvio == 0) log.warn("El Máximo de memoria para el equipo (Envío) está en Cero. El criterio se deja sin efecto");
			if (maximoCpuEquipoEnvio == 0) log.warn("El Máximo de CPU para el equipo (Envío) está en Cero. El criterio se deja sin efecto");
			
			in.close();
			return(0);
		}
		catch (IOException ioe) {
			log.error(ioe.getMessage());
			return(-1);
		}
	}
	
/**
 * Method extraeDatosConf
 * Extrae la informacion del campo
 * @param parBusc String
 * @return String
 */
	public String extraeDatosConf(String parBusc) {
		try {
			int factor = -1;
			String valor = new String("");
			valor = defaultProps.getProperty(parBusc);
			if (valor==null) throw new Exception("Parámetro no encontrado"); 
			if (valor.indexOf("#") >= 0) { //--->>> Ignora comentarios, si los tiene
				if (valor.indexOf("#") == 0) factor = 0;
				valor = valor.substring(0,valor.indexOf("#") + factor);
				valor = valor.trim();
			}
			
			if (valor.length() == 0 ) {  //--->>> Valida Contenido
				log.error(" ->> El parámetro " + parBusc + " no tiene datos");
				return("0");
			}

			return(valor);
		} catch (Exception e) {
			log.warn("El parámetro : "+parBusc+" no se encuentra configurado --->>> [" + e.getMessage() + "] <<<---");
			return("0");			
		}
	}
	
/**
 * Method isIpAcreditada
 * Metodo para buscar las ip válidas Incluído el puerto
 * @param numIpPuerto String
 * @return boolean
 */
	public boolean isIpAcreditada(String numIpPuerto) {
		try {
			String ipAux      = new String("");
			String puertoAux  = new String("");
			String soloIp     = new String(numIpPuerto.trim().substring(1,numIpPuerto.indexOf(":")));
			String soloPuerto = new String(numIpPuerto.trim().substring(numIpPuerto.indexOf(":")+1));
			String valor      = new String("");
			Properties defProps = new Properties();
			FileInputStream Acreditados = new FileInputStream(nomArchivoAcreditados);
			defProps.load(Acreditados);
			valor = defProps.getProperty("FROMIP");
			
			ArrayList cname = new ArrayList();
			
			//Name cname = new CompositeName(valor);
			
			if (valor.length() == 0) {
				log.error(" ->> No se ha especificado ninguna IP en el archivo: " + nomArchivoAcreditados);
				return(false); 
			}
			
			if (valor.substring(0,3).equalsIgnoreCase("ALL") )  return(true);  	//--->>> Pregunta si todas pueden
			if (valor.substring(0,4).equalsIgnoreCase("NONE") ) return(false); 	//--->>> Pregunta si ninguna puede
			if (valor.indexOf(numIpPuerto.substring(1)) > 0 )   return(true);  	//--->>> Pregunta por el par IP/Puerto

			StringTokenizer st = new StringTokenizer(valor,",");
		
			while(st.hasMoreTokens()){
				cname.add(st.nextToken());	
			}
			String cadena;

			for (int i = 0; i < cname.size(); i ++) {
				cadena = cname.get(i).toString() ;
				if (cadena.indexOf(":") == -1 ) {
					ipAux     = cadena.trim();
					if (ipAux.equals(soloIp) ) return(true);                   	//--->>> Pregunta sólo por la IP.
					if (ipAux.indexOf("*") != -1 ) {							//--->>> Validación para Rangos de IP
						StringTokenizer stIpAux = new StringTokenizer(ipAux,".");
						StringTokenizer stSoloIp = new StringTokenizer(soloIp,".");
						if (stIpAux.countTokens() != 4 || stSoloIp.countTokens() != 4) {
							log.error(" El formato de la Ip enmascarada es incorrecto");
						} else {
							int segmentosCoincidentes = 0;
							for (int j = 1; j<=stIpAux.countTokens();j++) {
								if (stIpAux.nextToken().equals(stSoloIp.nextToken()) ||stIpAux.nextToken().equals("*"))
									segmentosCoincidentes++;	
							}
							if (segmentosCoincidentes == 4) return(true);
						}
					}
				}
				else {
					ipAux = cadena.substring(0,cadena.indexOf(":")).trim();
					puertoAux = cadena.substring(cadena.indexOf(":")+1).trim();
					if (ipAux.equals(soloIp) && puertoAux.equals(soloPuerto)) return(true); //--->>> Pregunta por el par.
					if (ipAux.indexOf("*") != -1 ) {							//--->>> Validación para Rangos de IP
						StringTokenizer stIpAux = new StringTokenizer(ipAux,".");
						StringTokenizer stSoloIp = new StringTokenizer(soloIp,".");
						if (stIpAux.countTokens() != 4 || stSoloIp.countTokens() != 4) {
							log.error(" El formato de la Ip enmascarada es incorrecto");
						} else {
							int segmentosCoincidentes = 0;
							for (int j = 1; j<=stIpAux.countTokens();j++) {
								if (stIpAux.nextToken().equals(stSoloIp.nextToken()) ||stIpAux.nextToken().equals("*"))
									segmentosCoincidentes++;	
							}
							if (segmentosCoincidentes == 4 && puertoAux.equals(soloPuerto)) return(true);
						}
					}
				}
			}
			return(false);
		} catch (Exception e) {
			log.error(" Error en lectura de IP's Acreditados : --->>> [" + e.getMessage() + "] <<<---");
			return(false);			
		}
	}

}	

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


