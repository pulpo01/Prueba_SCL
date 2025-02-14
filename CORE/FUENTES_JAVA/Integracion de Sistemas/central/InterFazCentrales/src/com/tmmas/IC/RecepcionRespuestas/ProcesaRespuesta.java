package com.tmmas.IC.RecepcionRespuestas;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.StringTokenizer;
import java.util.Vector;
import java.sql.Types;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

/**
 * Clase para el Procesamiento de Negocio de la Respuesta
 * @author Carlos Sellao y Juan Ramos
 * @version $Revision$
 */
	public class ProcesaRespuesta {
	/**
	 * Field ERR_BD 	 = 100
	 */
	private static final int ERR_BD 	 = 100; /* Error en Base de Datos                   */
	/**
	 * Field ERR_BD_OUT  = 110
	 */
	private static final int ERR_BD_OUT  = 110; /* Error Critico en Base de Datos           */
	/**
	 * Field ERR_MEN 	 = 101
	 */
	private static final int ERR_MEN 	 = 101; /* Error en Sintaxis de Respuesta           */
	/**
	 * Field ERR_TIMEOUT = 102
	 */	
	private static final int ERR_TIMEOUT = 102; /* Sin proceso de respuesta por Time Out    */
	/**
	 * Field ERR_PROC 	 = 103
	 */	
	private static final int ERR_PROC 	 = 103; /* Sin proceso de respuesta                 */
	/**
	 * Field ERR_MSG 	 = 104
	 */	
	private static final int ERR_MSG 	 = 104; /* Error de acceso a cola de mensajes       */
	/**
	 * Field ERR_SELMEN  = 120
	 */	
	private static final int ERR_SELMEN  = 120; /* Error de Lectura de  mensajes            */
	/**
	 * Field ERR_SELRES  = 121
	 */
	private static final int ERR_SELRES  = 121; /* Error de Lectura de Respuestas desde BD  */
	/**
	 * Field ERR_SELCOM  = 122
	 */	
	private static final int ERR_SELCOM  = 122; /* Error de Lectura de Comandos desde BD    */
	/**
	 * Field ERR_ACTCOM  = 123
	 */
	private static final int ERR_ACTCOM  = 123; /* Error de Actualización de Comandos       */
	/**
	 * Field ERR_ANACOM  = 124
	 */
	private static final int ERR_ANACOM  = 124; /* Error de Analisis de Comandos Procesados */
	/**
	 * Field ERR_GEN     = 255
	 */	
	private static final int ERR_GEN     = 255; /* Error general                            */

	/**
	 * Field log
	 */
	private static Logger log = Logger.getLogger(ProcesaRespuesta.class.getName());
	/**
	 * Field conexionLocal;
	 */
	private Connection conexionLocal;
	/**
	 * Field bEcho;
	 */	
	private boolean bEcho = false;
	/**
	 * Field strErrorBD
	 */
	public String strErrorBD = "";
	
	public RecepcionRespuestas RR = new RecepcionRespuestas();
	
	private int iTipResp = -1;
	
	public String sBonServ;
	
	int numMovimiento = 0;
	PreparedStatement stmt;
	ResultSet rs, rs2;
		
/**
 * Method conectaBaseDatos
 * Metodo para la Conexion con la Base de Datos
 * @param strHost String
 * @param numPuerto int
 * @param strInstancia String
 * @param strUsuario String
 * @param strPassword String
 * @return Connection
 * @throws SQLException
 */
	
	public boolean conectaBaseDatos(String strHost, int numPuerto, String strInstancia, String strUsuario,String strPassword)
	throws SQLException	{
	  String urlconect = "";
	  try {
		String strConexion  = "jdbc:oracle:thin:@"; // String de Conexión 
		  
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		urlconect = new String(strConexion + strHost + ":" + numPuerto + ":" + strInstancia); 
		conexionLocal = DriverManager.getConnection (urlconect, strUsuario, strPassword);
		conexionLocal.setAutoCommit(true);
		
		return(true);
	  } catch (Exception e) {
	  	strErrorBD = e.getMessage();
	  	if(RR.evaluaError(strErrorBD)){				
			log.fatal("Se ha terminado la conexión con la Base de datos");
			System.exit(-2);				
	  	}
		log.error("Error al conectar con Oracle: --->>> [" + e.getMessage() + "] <<<--- urlconect:" + urlconect + ", strUsuario:" + strUsuario + ", strPassword:" + strPassword);
		log.error("StackTrace:",e);
		return(false);	  	
	  }
	}


/**
 * Method cierraConexionBaseDatos
 * Cierre de la conexión con la Base de datos
 * @throws SQLException
 */
	public void cierraConexionBaseDatos()
	throws SQLException	{
	  try {
		conexionLocal.close();
	  } catch (Exception e) {
		log.error("Error al cerrar conexion Oracle: --->>> [" + e.getMessage() + "] <<<---");
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

/**
 * Method asignaConexionActiva
 * Asigna la dirección de un objeto conexión ya activo al objeto local 
 * @param  conexionActual Connection
 */
	public void asignaConexionActiva(Connection conexionActual) {
		try {
			conexionLocal = conexionActual;
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- Al asignar conexión Activa");
			strErrorBD = e.getMessage();
			//log.error("StackTrace:",e);
		}
	}

/**
 * Method procRespuestaDesdeNativo
 * Método de entrada de la clase para comenzar el procesamiento de la respuesta desde la librería nativa 
 * @param  szRespuesta String
 * @param  lNumOOSS int
 * @param  nomProperties String
 * @throws SQLException
 * @return int
 */
	public int procRespuestaDesdeNativo(String szRespuesta, int numMovimiento, int codComando, int numOrden, Logger pLog)
	throws SQLException {
		try {
			PropertyConfigurator.configureAndWatch("cfg/LogProcesaMov.properties");
			log = pLog;
			log.info("Comienzo del procesamiento de la respuesta desde el código nativo");
			procRespuesta(szRespuesta, numMovimiento, codComando, numOrden);

			log.info("Fin del procesamiento de la respuesta desde el código nativo. Tipo de Respuesta [" + iTipResp + "]");
			return(iTipResp);		
		} catch(Exception e) {
			log.fatal("Error en proceamiento de Respuesta llamada desde código nativo --->> " + e.getMessage());
			log.error("StackTrace:",e);
			return(ERR_PROC);
		}
	}

/**
 * Method procesaMensajes
 * Método de entrada de la clase para comenzar el procesamiento de la respuesta 
 * @param  szRespuesta String
 * @param  lNumOOSS int
 * @throws SQLException
 * @return int
 */
	public int procesaMensajes(String szRespuesta, int lNumOOSS) 
	throws SQLException {
		try {
			long   	ret=0;
			int    	iCodProc;
			int    	iIndTimeOut;
			String  szCadena;
			iTipResp = -1;
			String	szNomCon;
			int    	iGo=1;
			String 	strSql;
			szCadena = szRespuesta;
			cierraCursor(rs,stmt);
//--->> Evaluacion de Proceso que Ejecuta Orden de Servicio 		
			strSql =  "SELECT Cod_proceso, Nom_config, Ind_timeout ";
			strSql += "FROM Ict_Proceso ";
			strSql += "WHERE Num_ooss = ?";
			stmt = conexionLocal.prepareStatement(strSql);
//--->>> Envía los parámetros
			stmt.setInt( 1,lNumOOSS);
//--->>> Realiza la Consulta
			rs = stmt.executeQuery();
			if (!rs.next()) {
				log.error("No existe orden en tabla de procesos, OS= " + lNumOOSS);
				cierraCursor(rs,stmt);
				return(ERR_PROC);
			}
			iCodProc 	= rs.getInt   ("Cod_proceso");
			szNomCon 	= rs.getString("Nom_config");
			iIndTimeOut	= rs.getInt   ("Ind_timeout");
			cierraCursor(rs,stmt);		
			log.debug("Se procesará OS=" + lNumOOSS + " Datos -> [Cod.Proceso: " + iCodProc + " TimeOut: " + iIndTimeOut + " Cola Mensajes: " + szNomCon + "]");
			numMovimiento = 0;
			procRespuesta(szCadena, lNumOOSS);
//--->>> Segun el Codigo de Proceso, se determina si es Proceso ONLINE o BATCH 
			if(iCodProc == 0) {
				log.debug("El movimiento es un Proceso ONLINE, OS=" + lNumOOSS);
				if(iIndTimeOut == 0) {  // Mira el tipo de respuesta para saber el status que debe llegar a la cola		
					
					if(iTipResp == 0) {
						szCadena = "STATUS=OK";
					} else {
						szCadena = "STATUS=NAK";
					}
					log.debug("Enviando respuesta [" + szCadena + "]a cola de mensajes, OS=" + lNumOOSS);
					
					
					ret = CallMessageQueue.sendMessageQueue(szCadena,lNumOOSS,szNomCon); //--->>> Método Sincronizado
//---------->>>>> Pendiente 	ret = fnEnvRespCola(szCadena, lNumOOSS, szNomCon);
					if(ret != 0) {
						cierraCursor(rs,stmt);
						return ERR_MSG; //---->>> No puedo enviar a la cola de mensajes	
					}
				
					log.debug("Respuesta enviada a la cola de mensajes, OS=" + lNumOOSS);
					iGo=0;
				} else {
					log.debug("Sin proceso en espera por respuesta, OS=" + lNumOOSS);
					log.debug("Proceso Comando de Movimiento Pendiente, OS=" + lNumOOSS);

				   /* Actualizacion del movimiento para reejecucion. Reemplaza el estado indicado por otro proceso. */
				   /* Si el movimiento se paso a historico la actualizacion no tiene efecto. No implica error. */

					if(updateMovReejecucion(lNumOOSS,numMovimiento)) {
						log.error("Actualizacion de movimiento con problemas, OS=" + lNumOOSS);
						return ERR_BD;
					} else {
						log.debug("Reenvío OK, OS=" + lNumOOSS);
						iGo=0;
					}
				}
			} else if(iCodProc == 1) {
				log.debug("El movimiento es un Proceso BATCH, OS=" + lNumOOSS);
				iGo=0;
			}
		
			if(iGo == 0) {
				log.debug("Eliminando proceso, OS=" + lNumOOSS);
				strSql = "DELETE FROM Ict_Proceso WHERE Num_Ooss = ?";
				stmt = conexionLocal.prepareStatement(strSql);
				stmt.setInt   ( 1,lNumOOSS);
				stmt.executeUpdate();
				conexionLocal.commit();
				stmt.close();
				return iGo;
			}
			return(ERR_PROC);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Procesa Mensaje de Entrada");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(ERR_PROC);
		} finally {
			cierraCursor(rs,stmt);
		}
	}		

//---------------------------------------------------------------------------------------------------//
//									  METODOS PRIVADOS DE LA CLASE                                   //
//---------------------------------------------------------------------------------------------------//
/**
 * Method updateRespComProc
 * Actualización de la Respuesta en la tabla Icc_Comproc
 * @param  lNumOOSS int
 * @param  iTipResp int
 * @param  szResp String
 * @return boolean
 * @throws SQLException
 */
	private boolean updateRespComProc(int lNumOOSS, int iTipResp, String szResp) 
	throws SQLException {
		try {
			String strSql;
			String szRespFinal=new String(szResp.getBytes("US-ASCII"));
			char [] szPP = new char[szResp.length()];
			//szResp = "Mi Respuesta. Es una respuesta de Prueba.!!!";
			szPP = szResp.toCharArray();

			log.debug("Actualizando el estado de la respuesta OS: " + lNumOOSS + " [Tip.Respuesta=" + iTipResp + " Respuesta=" + szResp + "]");
			log.debug("Respuesta Final:[" + szRespFinal + "]");
			strSql =  "UPDATE Icc_Comproc SET "; 
			strSql += " Tip_Respuesta = ?,";
			strSql += " Des_Respuesta = ? ";
			if (iTipResp == 0) strSql += ", Fec_Ejecucion = SYSDATE ";
			strSql += "WHERE Num_OOSS = ?";
			stmt = conexionLocal.prepareStatement(strSql);
//---->>> Envía los parámetros
			stmt.setInt   ( 1,iTipResp);
			stmt.setString( 2,szRespFinal);
			stmt.setInt   ( 3,lNumOOSS);

//--->>> Termina la transacción
			stmt.executeUpdate();
			conexionLocal.commit();
			cierraCursor(rs,stmt);
			return(true);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En actualización de la Icc_Comproc");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method updateRespComProc
 * Actualización de la Respuesta en la tabla Icc_Comproc
 * @param  numMovimiento int
 * @param  codComando int
 * @param  iTipResp int
 * @param  szResp String
 * @return boolean
 * @throws SQLException
 */
	private boolean updateRespComProc(int numMovimiento, int codComando, int iTipResp, String szRespFinal, int numOrden) 
	throws SQLException {
		try {
			String strSql;
			szRespFinal = szRespFinal.replaceAll("\n","");
			log.debug("Actualizando el estado de la respuesta Mov: " + numMovimiento + ", Com: " + codComando + ", Orden:" + numOrden + " [Tip.Respuesta= " + iTipResp + " Respuesta= " + szRespFinal + "]");
			log.debug("Respuesta Final:[" + szRespFinal + "]");
	
			strSql =  "UPDATE Icc_Comproc SET "; 
			strSql += " Tip_Respuesta = ?,";
			strSql += " Des_Respuesta = ? ";
			if (iTipResp == 0) strSql += ", Fec_Ejecucion = SYSDATE ";
			strSql += "WHERE Num_Movimiento = ?";
			strSql += "AND Cod_Comando = ?";
			strSql += "AND Num_Orden = ?";
			stmt = conexionLocal.prepareStatement(strSql);
//	  ---->>> Envía los parámetros
			stmt.setInt   ( 1,iTipResp);
			stmt.setString( 2,szRespFinal);
			stmt.setInt   ( 3,numMovimiento);
			stmt.setInt   ( 4,codComando);
			stmt.setInt   ( 5,numOrden);

//	  --->>> Termina la transacción
			stmt.executeUpdate();
			conexionLocal.commit();
			cierraCursor(rs,stmt);
			return(true);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En actualización de la Icc_Comproc");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method updateMovReejecucion
 * Actualización del movimiento en la tabla Icc_Movimiento
 * @param  lNumOOSS int
 * @return boolean
 * @throws SQLException
 */	
	private boolean updateMovReejecucion(int lNumOOSS, int numMovimiento)
	throws SQLException {
		try {
			String strSql;
			strSql =  "UPDATE Icc_Movimiento SET ";
			strSql += " Cod_Estado           = 3,";
			strSql += " Fec_Ejecucion        = SYSDATE ";
			strSql += " WHERE Num_Movimiento = ? "; 
			stmt = conexionLocal.prepareStatement(strSql);
//---->>> Envía los parámetros
			stmt.setInt( 1,numMovimiento);
//--->>> Termina la transacción
			stmt.executeUpdate();
			conexionLocal.commit();
			cierraCursor(rs,stmt);
			return(true);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En actualización de la Icc_Movimiento");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method getRespuestas
 * Carga de Las respuestas en un Vector de tipo TypeRespuestas 
 * @param  com TypeComando
 * @param  respuestas Vector
 * @return int
 * @throws SQLException
 */	
	private int getRespuestas(TypeComando pCom, Vector respuestas)
	throws SQLException {
		try {	
			int i=0;
			TypeRespuestas pResp;
			String strSql = "";
			strSql =  "SELECT a.COD_LENGUAJE,";
			strSql += "       a.COD_COMANDO,";
			strSql += "       a.TIP_RESPUESTA,";
			strSql += "		  a.COD_RESPUESTA,";
			strSql += "		  b.COD_LINEA,";
			strSql += "		  b.NOM_RESPUESTA,";
			strSql += "		  b.DES_RESPUESTA ";
			strSql += "FROM ICG_RESPUESTA a, ICG_CODRESPUESTA b ";
			strSql += "WHERE a.COD_RESPUESTA = b.COD_RESPUESTA ";
			strSql += "	 AND a.COD_LENGUAJE  = ? ";
			strSql += "	 AND a.COD_COMANDO   = ? ";
			strSql += "ORDER BY B.COD_LINEA";
			stmt = conexionLocal.prepareStatement(strSql);
//---->>> Envía los parámetros
			stmt.setInt( 1,pCom.iCod_Lenguaje_Exe);
			stmt.setInt( 2,pCom.iCod_Comando);
//--->>> Realiza la Consulta
			rs = stmt.executeQuery();
			if (!rs.next()) {
				log.error("No existe el comando en el Join Icg_Respuestas e Icg_CodRespuestas " +
				          "[COD_LENGUAJE=" + pCom.iCod_Lenguaje_Exe + ", COD_COMANDO=" + pCom.iCod_Comando);
				cierraCursor(rs,stmt);
				return(0);
			}

			do {
				pResp = new TypeRespuestas();
				pResp.iCod_Lenguaje   = rs.getInt("COD_LENGUAJE");
				pResp.iCod_Comando    = rs.getInt("COD_COMANDO");
				pResp.iTip_Respuesta  = rs.getInt("TIP_RESPUESTA");
				pResp.iCod_Respuesta  = rs.getInt("COD_RESPUESTA");
				pResp.iCod_Linea      = rs.getInt("COD_LINEA");
				pResp.szNom_Respuesta = rs.getString("NOM_RESPUESTA");
				pResp.szDes_Respuesta = rs.getString("DES_RESPUESTA"); 
				respuestas.addElement(pResp);
				i++;
			} while (rs.next());
			cierraCursor(rs,stmt);
			return(i);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En llenado de Respuestas");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(0);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method getAllComando
 * Carga Todos los comandos asociados a una OS en un Vector de tipo TypeComando 
 * @param  lNum_OOSS int
 * @param  comandos TypeComando
 * @throws SQLException
 */		
	private boolean getAllComando(int lNum_OOSS, TypeComando comandos)
	throws SQLException {
		try {	
			String strSql;
			strSql  = "SELECT Num_Orden, Cod_Lenguaje, Des_Comando, Num_Movimiento, ";
			strSql += " nvl(Des_Respuesta,' ') Des_Respuesta, Cod_Comando, Cod_Central,";
			strSql += " Cod_Sistema,	Num_Ooss, Tip_Respuesta ";
			strSql += "FROM Icc_Comproc ";
			strSql += "WHERE Num_Ooss  = ?";
			stmt = conexionLocal.prepareStatement(strSql);
//---->>> Envía los parámetros
			stmt.setInt( 1,lNum_OOSS);
//--->>> Realiza la Consulta
			rs = stmt.executeQuery();
			if (!rs.next()) {
				log.error("La orden no se encuentra en la tabla Icc_Comproc, OS= " + lNum_OOSS);
				return(false);
			}
			comandos.iNum_Orden        = rs.getInt   ("Num_Orden");
			comandos.iCod_Lenguaje_Exe = rs.getInt   ("Cod_Lenguaje");
			comandos.szDes_Comando     = rs.getString("Des_Comando");
			comandos.szRespuesta       = rs.getString("Des_Respuesta");
			comandos.iCod_Comando      = rs.getInt   ("Cod_Comando");
			comandos.cen.iCod_Central  = rs.getInt   ("Cod_Central");
			comandos.iCod_Sistema_Exe  = rs.getInt   ("Cod_Sistema");
			comandos.iNum_OOSS         = rs.getInt   ("Num_Ooss");
			numMovimiento              = rs.getInt   ("Num_Movimiento");
			return(true);  
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En llenado de Comandos");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}		

	/**
	 * Method getAllComando
	 * Carga Todos los comandos asociados a una OS en un Vector de tipo TypeComando 
	 * @param  numMovimiento int
	 * @param  codComando int
	 * @param  comandos TypeComando
	 * @throws SQLException
	 */		
		private boolean getAllComando(int numMovimiento, int codComando,  TypeComando comandos, int numOrden)
		throws SQLException {
			try {	
				String strSql;
				strSql  = "SELECT Num_Orden, Cod_Lenguaje, Des_Comando, Num_Movimiento, ";
				strSql += " nvl(Des_Respuesta,' ') Des_Respuesta, Cod_Comando, Cod_Central,";
				strSql += " Cod_Sistema,	Num_Ooss, Tip_Respuesta ";
				strSql += "FROM Icc_Comproc ";
				strSql += "WHERE num_movimiento = ?";
				strSql += "AND cod_comando = ?";
				strSql += "AND num_orden = ?";
				stmt = conexionLocal.prepareStatement(strSql);
//	  ---->>> Envía los parámetros
				stmt.setInt( 1,numMovimiento);
				stmt.setInt( 2,codComando);
				stmt.setInt( 3,numOrden);
//	  --->>> Realiza la Consulta
				rs = stmt.executeQuery();
				if (!rs.next()) {
					log.error("El comando no se encuentra en la tabla Icc_Comproc, Mov= " + numMovimiento + ", Com= " + codComando);
					cierraCursor(rs,stmt);
					return(false);
				}
				comandos.iNum_Orden        = rs.getInt   ("Num_Orden");
				comandos.iCod_Lenguaje_Exe = rs.getInt   ("Cod_Lenguaje");
				comandos.szDes_Comando     = rs.getString("Des_Comando");
				comandos.szRespuesta       = rs.getString("Des_Respuesta");
				comandos.iCod_Comando      = rs.getInt   ("Cod_Comando");
				comandos.cen.iCod_Central  = rs.getInt   ("Cod_Central");
				comandos.iCod_Sistema_Exe  = rs.getInt   ("Cod_Sistema");
				comandos.iNum_OOSS         = rs.getInt   ("Num_Ooss");
				numMovimiento              = rs.getInt   ("Num_Movimiento");
				cierraCursor(rs,stmt);
				return(true);  
			} catch (Exception e) {
				strErrorBD = e.getMessage();
				if(RR.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					cierraCursor(rs,stmt);
					System.exit(-2);				
			  	}
				log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En llenado de Comandos");
				strErrorBD = e.getMessage();
				log.error("StackTrace:",e);;
				return(false);
			} finally {
				cierraCursor(rs,stmt);
			}
		}
	
/**
 * Method procRespuesta
 * @param  szRespuesta String
 * @param  lNum_OOSS int
 * @return int
 * @throws SQLException
 */				
	private int procRespuesta(String szRespuesta, int lNum_OOSS) {
		try {
			TypeComando com 	= new TypeComando();
	  		TypeComResp comResp = new TypeComResp();
	  		Vector respuestas   = new Vector();
			int iLinCont 		= 0;
			int iLinea   		= 0;
	  		int nResp;
			if (!getAllComando(lNum_OOSS,com)) {
		  		return(ERR_SELCOM);  
			}

//--->>> Busqueda de respuestas posibles para el comando 
			if((nResp = getRespuestas(com, respuestas)) == 0) {
				return ERR_BD;
			}
	  		analizaRespuesta(szRespuesta, comResp, com.szDes_Comando, respuestas, nResp);

			for (iLinCont=0; iLinCont < comResp.iTipResp.size(); iLinCont++) {
				if ( ((Integer)comResp.iTipResp.elementAt(iLinCont)).intValue() == 0) break;
			}
			if(iLinCont >= comResp.iTipResp.size()) {
		 		if(bEcho)
		   			iLinea = 1;
		 		else
		   			iLinea = 0;
	   		} else {
		 		iLinea = iLinCont;
			}		 	
			iTipResp = ((Integer)comResp.iTipResp.elementAt(iLinea)).intValue();
//--->>> Actualizando respuestas
            log.info("Tipo de Respuesta :" + iTipResp + " en Orden:" + lNum_OOSS );
            log.info("Respuesta a guardar: [" + szRespuesta + "]");
			if(!updateRespComProc(lNum_OOSS, iTipResp, szRespuesta)) { //ComResp.iTipResp[0]
				return ERR_ACTCOM;
			}
  
//--->>> Analizando Comandos Procesados
			if(!anaComProc(lNum_OOSS,numMovimiento,szRespuesta,0,0)) {
				return ERR_ANACOM;  
			}
			
			
			
			log.info("Os=[" + lNum_OOSS + "] Procesada");
			return 0;
		} catch(Exception e) {
			log.error("Error de ejecución --->>> [" + e.getMessage() + "] <<<--- En ProcRespuesta");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(ERR_PROC);			
		}
	}

/**
 * Method procRespuesta
 * @param  szRespuesta String
 * @param  numMovimiento int
 * @param  codComando int
 * @return int
 * @throws SQLException
 */				
	private int procRespuesta(String szRespuesta, int numMovimiento, int codComando, int numOrden) {
		try {
			TypeComando com 	= new TypeComando();
			TypeComResp comResp = new TypeComResp();
			Vector respuestas   = new Vector();
			int iLinCont 		= 0;
			int iLinea   		= 0;
			int nResp;
			if (!getAllComando(numMovimiento,codComando,com, numOrden)) {
				return(ERR_SELCOM);  
			}

//--->>> Busqueda de respuestas posibles para el comando 
			if((nResp = getRespuestas(com, respuestas)) == 0) {
				return ERR_BD;
			}
			analizaRespuesta(szRespuesta, comResp, com.szDes_Comando, respuestas, nResp);

			for (iLinCont=0; iLinCont < comResp.iTipResp.size(); iLinCont++) {
				if ( ((Integer)comResp.iTipResp.elementAt(iLinCont)).intValue() == 0) break;
			}
			if(iLinCont >= comResp.iTipResp.size()) {
				if(bEcho)
					iLinea = 1;
				else
					iLinea = 0;
			} else {
				iLinea = iLinCont;
			}		 	
			iTipResp = ((Integer)comResp.iTipResp.elementAt(iLinea)).intValue();

//--->>> Actualizando respuestas
			String respTmp = szRespuesta.toUpperCase();
			if ( respTmp.indexOf("IOERROR") > -1 ) szRespuesta = "Error: *** Fallo en las Comunicaciones ***";

			log.info("Tipo de Respuesta: " + iTipResp + ", en Movimiento: " + numMovimiento + ", Comando: " + codComando );
			log.info("Respuesta a guardar: [" + szRespuesta + "]");
		
			if(!updateRespComProc(numMovimiento, codComando, iTipResp, szRespuesta, numOrden)) { 
				return ERR_ACTCOM;
			}
  
//--->>> Revisa si la respuesta está en Time out, si es así actualiza el movimiento en estado 11 solo para FU
			
			if ( respTmp.indexOf("IOERROR") > -1 ) {
				log.info("El comando está con error en las comunicaciones, Movimiento/Comando = [" + numMovimiento + "/" + codComando + "]");
				if (!setEstadoErrorMovimiento(numMovimiento, 8, szRespuesta) ) return(ERR_PROC);
			} else if ( respTmp.indexOf("TIMEOUT") > -1 ) {
				log.info("El comando está en TimeOut, Movimiento/Comando = [" + numMovimiento + "/" + codComando + "]");
				if (getTipLenguaje(numMovimiento,codComando,numOrden) == 1 ) {
					log.info("El tipo de lenguaje es FU, se deja en estado 11 el movto. Movimiento/Comando = [" + numMovimiento + "/" + codComando + "]");
					if (!setEstadoErrorMovimiento(numMovimiento,11,szRespuesta) ) return(ERR_PROC);
					//--->> Marca el TimeOut en la Ict_Proceso
					String strSql = "UPDATE Ict_Proceso SET Ind_timeout = 1 WHERE Num_Ooss = ?";
					stmt = conexionLocal.prepareStatement(strSql);
					stmt.setInt   ( 1,com.iNum_OOSS);
					stmt.executeUpdate();
					conexionLocal.commit();
					com.iNum_OOSS = 0;
					cierraCursor(rs,stmt);
				} else {
					log.info("El tipo de lenguaje es normal, se deja en estado 3 el movto. Movimiento/Comando = [" + numMovimiento + "/" + codComando + "]");
					if(!anaComProc(0,numMovimiento,szRespuesta,codComando,numOrden)) {
						cierraCursor(rs,stmt);
						return ERR_ANACOM; //--->>> Analizando Todos Comandos del Movimiento
					}
				}
			} else {
				if(!anaComProc(0,numMovimiento,szRespuesta, codComando, numOrden)) return ERR_ANACOM;		//--->>> Analizando Todos Comandos del Movimiento
			}

			log.info("Movimiento/Comando = [" + numMovimiento + "/" + codComando + "] Procesado");
			
			if(com.iNum_OOSS > 0) {
				log.debug("Eliminando proceso, OS=" + com.iNum_OOSS);
				String strSql = "DELETE FROM Ict_Proceso WHERE Num_Ooss = ?";
				stmt = conexionLocal.prepareStatement(strSql);
				stmt.setInt   ( 1,com.iNum_OOSS);
				stmt.executeUpdate();
				conexionLocal.commit();
			}			
			cierraCursor(rs,stmt);
			return 0;
		} catch(Exception e) {
			log.error("Error de ejecución --->>> [" + e.getMessage() + "] <<<--- En ProcRespuesta");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(ERR_PROC);			
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method getTipLenguaje
 * Recupera el tipo de lenguaje para un comando especifico
 * @param codComando int
 * @return boolean
 * @throws SQLException
 */
	private int getTipLenguaje(int numMovimiento, int codComando, int numOrden) 
	throws SQLException {
		try {
			int    tipLenguaje = 0;
			String strSql = "";
			strSql  = "SELECT b.Tip_Lenguaje ";
			strSql += "FROM   Icc_Comproc a, Icg_Lenguaje b ";
			strSql += "WHERE  a.Num_movimiento = ? ";
			strSql += "  AND  a.Cod_Comando    = ? ";
			strSql += "  AND  a.Num_Orden      = ? ";
			strSql += "  AND  b.Cod_Lenguaje   = a.Cod_Lenguaje ";

			stmt = conexionLocal.prepareStatement(strSql);
			stmt.setInt( 1, numMovimiento);
			stmt.setInt( 2,codComando);
			stmt.setInt( 3,numOrden);
			rs = stmt.executeQuery();
			
			if (!rs.next()) {
				cierraCursor(rs,stmt);
				strErrorBD = "NOT_FOUND";
				return(-1); 
			}
			tipLenguaje = rs.getInt("Tip_Lenguaje");
			cierraCursor(rs,stmt);
			return(tipLenguaje);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En getTipLenguaje para el Movimiento/Comando: [" + numMovimiento + "/" + codComando + "]");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(-1);
		} finally {
			cierraCursor(rs,stmt);
		}
		}
	

/**
 * Method analizaRespuesta
 * Analiza el String de la respuesta, para certificar si tiene mas de un comando
 * @param  strRespuesta String
 * @param  comResp TypeComResp
 * @param  strComando String
 * @param  respuestas Vector
 * @param  nResp int
 * @throws SQLException
 */	
	private void analizaRespuesta(String strRespuesta, TypeComResp comResp, String strComando, Vector respuestas, int nResp) {
		try {
			String lineaTmp = "";
			StringTokenizer respTok = new StringTokenizer(strRespuesta,"\n");
			bEcho = false;
			for (int i=1;i<=respTok.countTokens();i++) {
				
				lineaTmp = respTok.nextToken();
				if (lineaTmp.trim().length() > 0){
					if (lineaTmp.equalsIgnoreCase("COMANDO IGNORADO")) bEcho = false;
					lineaTmp = lineaTmp.replaceAll(strComando,"<echo>");
					if (lineaTmp.indexOf("<echo>") >= 0) bEcho = true;
					comResp.pszLines.addElement(lineaTmp);
					comResp.nComResp ++;
					comResp.iCodResp.addElement(new Integer(comResp.nComResp));
				}
			}
			getAciertos(comResp,respuestas,nResp);		
		} catch (Exception e){
			log.error("Error de ejecución: --->>> [" + e.getMessage() + "] <<<--- En Analiza Respuestas");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
		}		
	}

/**
 * Method getAciertos
 * Busca las respuestas del comando en la tabla de respuestas y encuentra la correcta 
 * @param  comResp TypeComResp
 * @param  respuestas Vector
 * @param  nResp int
 */		
	private void getAciertos(TypeComResp comResp, Vector respuestas, int nResp) {
		try {
	  		String szTmp = "No stdout available";
			TypeRespuestas respTmp = new TypeRespuestas();
	  		if (comResp.nComResp == 0) {	//--->>> Si no hay Lineas se crea una ficticia
		 		comResp.iTipResp.addElement(new Integer(-1));
		 		comResp.pszLines.addElement(szTmp);
		 		comResp.iCodResp.addElement(new Integer(-1));
	  		} else {
	  			for (int i=0; i<comResp.nComResp; i++){
					comResp.iTipResp.addElement(new Integer(-1));
					comResp.iCodResp.set(i,new Integer(-1));
					for(int k=0; k<nResp; k++) {     //--->>> Por Respuesta busca en la tabla de respuestas
						respTmp = (TypeRespuestas)respuestas.elementAt(k);
						if(respTmp.iCod_Linea == i+1) {   
							if(((String)comResp.pszLines.elementAt(i)).indexOf(respTmp.szNom_Respuesta) >= 0) {
								comResp.iCodResp.set(i, new Integer(respTmp.iCod_Respuesta));
								comResp.iTipResp.set(i, new Integer(respTmp.iTip_Respuesta * -1));
								if(((Integer)comResp.iTipResp.elementAt(i)).intValue() == 0) {
									log.debug("--->> Respuesta Correcta. --->>> [" + String.valueOf(respTmp.iCod_Respuesta) + "]");
								}
								break;
							}
						}
					}
	  			}
	  		}
		} catch (Exception e){
			log.error("Error de ejecución: --->>> [" + e.getMessage() + "] <<<--- En Aciertos");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
		}		
	}

/**
* Method getMovInterfazConsulta
* 
* @param szResp String
* @param lNumTRX[] int 
* @param sTecnologia[] String
* @param iCodEstado[] int
* @return boolean
*/
	private boolean getMovInterfazConsulta(String szResp, int lNumTRX[], String []sTecnologia, int iCodEstado[], String []sTipServ, String []sTipActiv) {
		try {
			int pstring;
			int pcdato;
			String cId;
			String cEstado;
			String cstring;

			if( (pstring = szResp.indexOf("ID=")) < 0) {
			   if((pstring = szResp.indexOf("'ID'='")) < 0) {
			   		log.info("La respuesta no contiene 'ID'");
					return(false);
			   }
			   else {
				  cstring=szResp.substring(pstring+6);
				  if((pcdato = cstring.indexOf("'")) < 0) {
				  	 log.warn("La respuesta contiene 'ID', pero no está bien conformado, falta un (') ");
					 return(false);
				  }
				  cId = cstring.substring(0,pcdato);
				  lNumTRX[0] = Integer.parseInt(cId);
			   }
			}
			else {
				cstring=szResp.substring(pstring+3);
				if((pcdato = cstring.indexOf(",")) < 0) {
					log.warn("La respuesta contiene 'ID', pero no está bien conformado, falta una (,) ");
					return(false);
				}
				cId = cstring.substring(0,pcdato);
				lNumTRX[0] = Integer.parseInt(cId);
			}
			if( (pstring = szResp.indexOf("COD_ESTADO=")) < 0) {
			   if((pstring = szResp.indexOf("'COD_ESTADO'='")) < 0) {
			   	  log.warn("La respuesta no contiene 'COD_ESTADO'");
				  return(false);
			   }
			   else {
				  cstring=szResp.substring(pstring+14);
				  if((pcdato = cstring.indexOf("'")) < 0) {
				  	 log.warn("La respuesta contiene 'ID', pero no está bien conformado, falta una (,) ");
					 return(false);
				  }
				  cEstado = cstring.substring(0,pcdato);
				  iCodEstado[0] = Integer.parseInt(cEstado);
			   }
			}
			else {
				cstring=szResp.substring(pstring+11);
				if((pcdato = cstring.indexOf(",")) < 0) {
					return(false);
				}
				cEstado = cstring.substring(0,pcdato);
				iCodEstado[0] = Integer.parseInt(cEstado);
			}

			if( (pstring = szResp.indexOf("TIP_SERVICIO=")) < 0) {
			   if((pstring = szResp.indexOf("'TIP_SERVICIO'='")) < 0) {
				  log.warn("La respuesta no contiene 'TIP_SERVICIO'");
				  sTipServ[0]="";
			   }
			   else {
				  cstring=szResp.substring(pstring+16);
				  if((pcdato = cstring.indexOf("'")) < 0) {
					 sTipServ[0]="";
				  }
				  else {
					sTipServ[0] = cstring.substring(0,pcdato);
				  }
			   }
			}
			else {
				cstring=szResp.substring(pstring+13);
				if((pcdato = cstring.indexOf(",")) < 0) {
					sTipServ[0]="";
				}
				else {
					sTipServ[0] = cstring.substring(0,pcdato);
				}
			}

			if( (pstring = szResp.indexOf("TIP_ACTIVIDAD=")) < 0) {
			   if((pstring = szResp.indexOf("'TIP_ACTIVIDAD'='")) < 0) {
				  log.warn("La respuesta no contiene 'TIP_ACTIVIDAD'");
				  sTipActiv[0]="";
			   }
			   else {
				  cstring=szResp.substring(pstring+17);
				  if((pcdato = cstring.indexOf("'")) < 0) {
					 sTipActiv[0]="";
				  }
				  else {
					sTipActiv[0] = cstring.substring(0,pcdato);
				  }
			   }
			}
			else {
				cstring=szResp.substring(pstring+14);
				if((pcdato = cstring.indexOf(",")) < 0) {
					sTipActiv[0]="";
				}
				else {
					sTipActiv[0] = cstring.substring(0,pcdato);
				}
			}

			if( (pstring = szResp.indexOf("TIP_TECNOLOGIA=")) < 0) {
			   if((pstring = szResp.indexOf("'TIP_TECNOLOGIA'='")) < 0) {
				  return(false);
			   }
			   else {
				  cstring=szResp.substring(pstring+18);
				  if((pcdato = cstring.indexOf("'")) < 0) {
					 return(false);
				  }
				  sTecnologia[0] = cstring.substring(0,pcdato);
			   }
			}
			else {
				cstring=szResp.substring(pstring+15);
				if((pcdato = cstring.indexOf(";")) < 0) {
					return(false);
				}
				sTecnologia[0] = cstring.substring(0,pcdato);
				iCodEstado[0]  = Integer.parseInt(cEstado);
			}
			return(true);
		} catch (Exception e) {
			log.error("Error de ejecución : --->>> [" + e.getMessage() + "] En Mov Interfaz Consulta <<<---");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		}
	}

/**
 * Method insMovInterfazConsulta
 *  
 * @param lNumOOSS int
 * @param szResp String
 * @param numMovimiento int
 * @return boolean
 * @throws SQLException
 */
	private boolean insMovInterfazConsulta(int lNumOOSS, String szResp, int numMovimiento, int numCodaccion, int NumAbonado, int numCodcomando, int numorden) 
	throws SQLException {
		try {
			strErrorBD = "";
			String strSql;
			int Num_TRX[]    	 = new int[1]; 		//--->>> Se crea como arreglo para poder pasarlo por referencia
			String sTecnologia[] = new String[1];	//--->>> Se crea como arreglo para poder pasarlo por referencia
			int codEstado[]  	 = new int[1];		//--->>> Se crea como arreglo para poder pasarlo por referencia
			String sTipServ[]    = new String[1];   //--->>> Se crea como arreglo para poder pasarlo por referencia
			String sTipActiv[]   = new String[1];   //--->>> Se crea como arreglo para poder pasarlo por referencia
			
			if (!getMovInterfazConsulta(szResp, Num_TRX, sTecnologia,codEstado,sTipServ,sTipActiv)) {
				return(true);
			} else { 
			    
			    /*HALR Se crea funcion getBonoServ para la solucion de la incidencia 76664*/
				sBonServ = getBonoServ(numMovimiento, NumAbonado, numCodaccion, numCodcomando, numorden, lNumOOSS);
				if(sBonServ == "ERROR"){
					return(false);
				}
				log.info("Retorno del Servicio ["+ sBonServ +"]");
			}
			log.debug("Se inserta en la tabla Icc_Interfaz_Consultas_To. Num. Movto= [" + numMovimiento + "] Num.TRX: [" + Num_TRX[0] + "]  Estado: [" + codEstado[0] + "] Tecnologia: [" + sTecnologia[0] + "] TipoServicio: [" + sTipServ[0] + "] TipoActividad: [" + sTipActiv[0] + "] Cod_Servicio: ["+ sBonServ +"]");
			
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "INSERT INTO Icc_Interfaz_Consultas_To ( ";
			strSql += "Num_Movimiento, Num_Trx, Cod_Estado, Tip_Tecnologia, Cod_Modulo, Cod_Periocidad, Tip_Actividad, Cod_Servicios) ";
			strSql += "SELECT ?, ?, ?, ?, Cod_Modulo, ?, ?, ?";
			strSql += "  FROM Icc_Movimiento ";
			strSql += "WHERE Num_Movimiento = ? ";
			stmt = conexionLocal.prepareStatement(strSql);	
//---->>> Envía los parámetros
  			stmt.setInt    ( 1,numMovimiento);
			stmt.setInt    ( 2,Num_TRX[0]);
			stmt.setInt    ( 3,codEstado[0]);
			stmt.setString ( 4,sTecnologia[0]);
			stmt.setString ( 5,sTipServ[0]);
			stmt.setString ( 6,sTipActiv[0]);
			stmt.setString ( 7,sBonServ);
			stmt.setInt    ( 8,numMovimiento);
//--->>> Termina la transacción
			int reg = stmt.executeUpdate();
			conexionLocal.commit();
			cierraCursor(rs,stmt);
			return(true);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En insersión de la transacción: [" + szResp + "]");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			cierraCursor(rs,stmt);
			return(false);
		} finally {
			cierraCursor(rs,stmt);			
		}
	}

/**
 * Method anaComProc
 * 
 * @param lNumOOSS int
 * @return boolean
 * @throws SQLException
 */
	private boolean anaComProc(int lNumOOSS,int numMovimiento, String strRespuesta, int intCod_comando, int intNum_orden) 
	throws SQLException {
		try {
			strErrorBD = "";
			String strSql;
			String codModulo;
			String codSuspreha;
			String codServicios;
			String ServicioTotal;
			int NumAbonado;
			int codActuacion;
			int Codaccion;
			String codServicio;
			char codTipo;
			int NumOOSS_2 = 0;
			boolean bRespIncorr   = false;
			boolean bRespIncorrI  = false;
			boolean bRespIncorrP  = false;
			boolean bRespIncorrTO = false;
			boolean swRespuesta = false;
			boolean swRespuestaNeg = false;
			boolean ret;
			String Error;
			int CodEstado;
			int TipRespuesta;
			String DesRespuesta;
			int TipLenguaje;
			int NumOoss;
			int iContResp = 0;
			int iContRespOK = 0;
			String RespTmp;
			int reg;
			String TipSusReha;
			
			strSql  = "SELECT Cod_Modulo, nvl(Cod_Suspreha,chr(0)) Cod_Suspreha , Num_Abonado, ";
			strSql += "       nvl(Cod_Servicios,chr(0)) Cod_Servicios, Cod_Actuacion ";
			strSql += "FROM   Icc_Movimiento ";
			strSql += "WHERE  Num_Movimiento =  ? ";
		
			stmt = conexionLocal.prepareStatement(strSql);
			stmt.setInt( 1,numMovimiento);
			rs = stmt.executeQuery();
		
			if (rs.next()) {
				codModulo    = rs.getString("Cod_Modulo");
				codSuspreha  = rs.getString("Cod_Suspreha");
				NumAbonado   = rs.getInt   ("Num_Abonado");
				codServicios = rs.getString("Cod_Servicios");
				codActuacion = rs.getInt   ("Cod_Actuacion");
				cierraCursor(rs,stmt);
			} else {
				cierraCursor(rs,stmt);
				strErrorBD = "NOT_FOUND";
				log.warn("No existe un movimiento para la OS/Movimiento= " + lNumOOSS + "/" + numMovimiento);
				return(false); 
			}
			
			strSql  = "SELECT nvl(Cod_Servicio,chr(0)) Cod_Servicio, Cod_Tipo, Cod_accion ";
			strSql += "FROM  Icg_Actuacion ";
			strSql += "WHERE Cod_Actuacion = ? ";
			strSql += "  AND Cod_Producto = 1";
		
			stmt = conexionLocal.prepareStatement(strSql);
			stmt.setInt( 1,codActuacion);
			rs = stmt.executeQuery();
		
			if (rs.next()) {
				codServicio = rs.getString("Cod_Servicio");
				codTipo     = rs.getString("Cod_Tipo").charAt(0);
				Codaccion   = rs.getInt("Cod_accion");
				cierraCursor(rs,stmt);
			} else {
				strErrorBD = "NOT_FOUND";
				cierraCursor(rs,stmt);
				return(false); 
			}

			ServicioTotal = codServicios;
			strSql  = "SELECT a.Tip_Respuesta, nvl(a.Des_Respuesta,'0') Des_Respuesta, b.Tip_Lenguaje, nvl(a.Num_Ooss,0) Num_Ooss ";
			strSql += "FROM   Icc_Comproc a, Icg_Lenguaje b ";
			strSql += "WHERE  Num_Movimiento = ? ";
			strSql += "  AND  a.Cod_Lenguaje = b.Cod_Lenguaje ";
		
			stmt = conexionLocal.prepareStatement(strSql);
			stmt.setInt( 1,numMovimiento);
			rs = stmt.executeQuery();
		
			if (!rs.next()) {
				cierraCursor(rs,stmt);
				strErrorBD = "NOT_FOUND";
				return(false); 
			}
			bRespIncorr   = false;
			bRespIncorrI  = false;
			bRespIncorrP  = false;
			bRespIncorrTO = false;
			swRespuesta = false;
			swRespuestaNeg = false;
			do {
				TipRespuesta = rs.getInt   ("Tip_Respuesta");
				DesRespuesta = rs.getString("Des_Respuesta");
				TipLenguaje  = rs.getInt   ("Tip_Lenguaje");
				NumOoss      = rs.getInt   ("Num_Ooss");
				iContResp++;
				if((TipRespuesta == -1) && (DesRespuesta.length() == 1) && (TipLenguaje == 1)) {
					if (NumOOSS_2 != 0){
						cierraCursor(rs,stmt);
						return(true);
					}
					else {						
							bRespIncorrI = true;
							if (NumOoss != 0){
								bRespIncorrP = true;
							}
							
					}
				}
				/*HALR Inc 70907 se agregan nuevos filtros controlando 
				 * 1. El paso a estado 3 del movimiento cuando un comando quede con error 
				 * 2. Chequear que todos los comandos de un mov esten con tip_res = 0 para su paso a historico*/
				if((TipRespuesta == 0) && (DesRespuesta.length() > 1)){
					iContRespOK++;
				}
				if (DesRespuesta.length() == 1){
					swRespuesta = true;
				}
				if (TipRespuesta == -1){
					swRespuestaNeg = true;
				}
				if((TipRespuesta == -1) && (DesRespuesta.length() == 1) && (TipLenguaje == 0) ){ 
					bRespIncorrI = true;
				}

				if((TipRespuesta == -1) && (DesRespuesta.length() == 1) && (TipLenguaje == 0) && NumOoss != 0 ){ 
					bRespIncorrP = true;
				}				

				if((TipRespuesta == -1) && (DesRespuesta.length() > 1)){
					bRespIncorr = true;
				}

				if (TipRespuesta == -2) { bRespIncorr = true; } 
		
			} while(rs.next());
			
			cierraCursor(rs,stmt);
			
			if (iContRespOK == iContResp)
			{
				bRespIncorr    = false;
				bRespIncorrI   = false;
				bRespIncorrP   = false;
				bRespIncorrTO  = false;
				swRespuesta    = true;
				swRespuestaNeg = false;
			}
			
			if (swRespuesta == false && swRespuestaNeg == true){
				CodEstado = 3;
  			    RespTmp = "ERROR: Actuacion con Comando Incorrecto";
			}
			else if (bRespIncorrP == true ){
				   CodEstado = 2;
				   RespTmp = "Comando en Proceso";
			}
			else if(bRespIncorr == true ){
			   CodEstado = 3;
			   RespTmp = "ERROR: Actuacion con Comando Incorrecto";
			}
			else if (bRespIncorrI == true) {
			  CodEstado = 2;
			  RespTmp = "Comando en Proceso";
			}
			else {
				CodEstado = 0;
				RespTmp = "Ok";
			}
			
			log.info("Fin del revisión des_respuesta icc_comproc =>> CodEstado=[" + CodEstado + "] iContRespOK=[" + iContRespOK + "] iContResp=[" + iContResp + "] NumOoss=[" + NumOoss + "]");
			
			/*HALR Inc 70907 Se controla proceso insMovInterfazConsulta*/
			if(CodEstado==0) {
				    if(iTipResp == 0) //--->>> Respuesta Correcta Registra la transaccion 
				      { insMovInterfazConsulta(lNumOOSS, strRespuesta, numMovimiento, Codaccion, NumAbonado, intCod_comando, intNum_orden); }
				CodEstado = cambiaEstadoMovimiento(numMovimiento, lNumOOSS);
			} else {
				if (!setEstadoErrorMovimiento(numMovimiento,CodEstado,RespTmp)) {
					return(false);
				} else {
						if(iTipResp == 0)  //--->>> Respuesta Correcta Registra la transaccion
						{	insMovInterfazConsulta(lNumOOSS, strRespuesta, numMovimiento, Codaccion, NumAbonado, intCod_comando, intNum_orden); }
					    return(true);
				}
			}
			
			conexionLocal.commit();	
			
			if(CodEstado == 0) {
				log.debug("Movimiento Actualizado y pasado a Histórico, OS= " + lNumOOSS + ", N° de Movimiento: " + numMovimiento);
			}
			log.debug("Terminando Analisis de Comandos Procesados, OS= " + lNumOOSS + ", N° de Movimiento: " + numMovimiento);
			cierraCursor(rs,stmt);
			return(true);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Analisis de Comproc para orden: [" + lNumOOSS + "]");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method getBonoServ
 * Busca servicio asociado al comando de bono periodico
 * @param  lNumOOSS int
 * @param  sBonServ Vector
 * @return boolean
 */		
	private String getBonoServ(int numMovimiento, int numAbonado, int numCodaccion, int numCodcomando, int numorden, int numOOSS) throws SQLException {
			CallableStatement calStmt = null;
			String ServBaja; 
			try {
			String strSql = "";
			strSql = "{?=call IC_PKG_RESCATA_CADSERV.FN_RESCATA_CADSERVICIO(?,?,?,?,?,?)}";
			calStmt = conexionLocal.prepareCall(strSql);
			calStmt.registerOutParameter(1, Types.VARCHAR);
			calStmt.setInt(2,numAbonado);
			calStmt.setInt(3,numMovimiento);
			calStmt.setInt(4,numCodaccion);
			calStmt.setInt(5,numCodcomando);
			calStmt.setInt(6,numorden);
			calStmt.setInt(7,numOOSS);			
			calStmt.executeQuery();
			ServBaja=calStmt.getString(1);
			calStmt.close();
			return(ServBaja);
		} catch(Exception e) {
			log.warn("Error en el Trigger ejecucion ICC_RESCARTA_CADSERVICIO. " +
					 "Num_Mov  [" + numMovimiento + "]. " +
					 "Num_Abo  [" + numAbonado + "]. " +
					 "Cod_Acc  [" + numCodaccion + "]. " +
					 "Cod_Com  [" + numCodcomando + "]. " +
					 "Num_Ord  [" + numorden + "]. " +
					 "Nom_OOSS [" + numOOSS + "]. ");
			log.error("Descripcion del la falla producida ["+ e.getMessage() +"] 	");
			log.error("StackTrace:",e);
			calStmt.close();
			return("ERROR");
		}
	}	
	
	
/**
 * Method cambiaEstadoMivimiento
 * Ejecuciòn del PL ICC_UPDATE_MOVIMIENTO 
 * @param numMovimiento int
 * @return boolean
 * @throws SQLException
 */
	private int cambiaEstadoMovimiento(int numMovimiento, int lNumOOSS) 
		throws SQLException {
			CallableStatement calStmt = null;
			try {
			String strSql  = "call ICC_UPDATE_MOVIMIENTO(?)";
			calStmt = conexionLocal.prepareCall(strSql);
			calStmt.setInt( 1,numMovimiento);
			calStmt.execute();
			calStmt.close();
			return(0);
		} catch(Exception e) {
			// *HALR* INC 75111 
			log.warn("Error en el Trigger al ejecutar ICC_UPDATE_MOVIMIENTO. Num.Movto [" + numMovimiento + "]. OS=" + lNumOOSS);
			log.error("Descripcion del la falla producida ["+ e.getMessage() +"] ");
			log.error("StackTrace:",e);
			calStmt.close();
            // *HALR* INC 75111 
			return(4);
		}
	}

/**
 * Method setEstadoErrorMovimiento
 * Establece el estado erroneo del movimiento 
 * @param numMovimiento int
 * @param codEstado int
 * @param desRespuesta String
 * @return boolean
 * @throws SQLException
 */
	private boolean setEstadoErrorMovimiento(int numMovimiento, int codEstado, String desRespuesta) 
	throws SQLException {
		try {
			String strSql;
			strErrorBD = "";
			int CodEstadoAnt;
			
			/*HALR Inc 70907 Se controla que cuando el movimiento este en estado 3 no se actualice a estado 2*/
			strSql = "";
			strSql  = "SELECT Cod_Estado ";
			strSql += "FROM  Icc_Movimiento     ";
			strSql += "WHERE Num_Movimiento = ? ";
					
			stmt = conexionLocal.prepareStatement(strSql);
			stmt.setInt( 1,numMovimiento);
			rs = stmt.executeQuery();
		
			if (rs.next()) {
				CodEstadoAnt = rs.getInt("Cod_Estado");
				cierraCursor(rs,stmt);
			} else {
				strErrorBD = "NOT_FOUND";
				cierraCursor(rs,stmt);
				return(false); 
			}
			
			if (CodEstadoAnt == 3 && codEstado == 2)
			{
				return(true);
			}
			strSql = "";
			strSql = "UPDATE Icc_Movimiento SET  ";
			strSql += "Cod_Estado           = ?, ";
			strSql += "Des_Respuesta        = ?, ";
			strSql += "Fec_Ejecucion        = SYSDATE ";
			strSql += "WHERE Num_Movimiento = ? ";
			stmt = conexionLocal.prepareStatement(strSql);	
//---->>> Envía los parámetros
			stmt.setInt   ( 1,codEstado);
			stmt.setString( 2,desRespuesta);
			stmt.setInt   ( 3,numMovimiento);
				
//--->>> Termina la transacción
			stmt.executeUpdate();
			conexionLocal.commit();
			cierraCursor(rs,stmt);
			return(true);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Set Estado Movimiento en error. Movimiento: [" + numMovimiento + "]");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}
	
/**
* Method validaSuspension
* 
* @param NumAbonado int
* @param CodSuspreha String
* @param CodModulo String 
* @param ServicioTotal String
* @param TipSuspreha String
* @return boolean
*/
	private boolean validaSuspension(int NumAbonado, String CodSuspreha, String CodModulo, String ServicioTotal, String TipSuspreha ) {
		try {
			int Nivel;
			int NivelAct;
			int NumServicio;
			String S;
			String N;
			int  i;
			int  IntegerCOD  = 2;
			int  IntegerSERV = 6;
			int  IntegerNIV  = 4;
			int  iCodServicio;
			int  iCodNivel;
			String  pSer;
			NumServicio = ServicioTotal.length()/IntegerSERV;

			pSer=ServicioTotal;
			for(i=0;i<NumServicio;i++) {
				S    = pSer.substring(0,IntegerCOD);
				pSer = pSer.substring(IntegerCOD);
				N    = pSer.substring(0,IntegerNIV);
				pSer = pSer.substring(IntegerNIV);

				iCodServicio = Integer.parseInt(S);
				iCodNivel    = Integer.parseInt(N);

				if (!getNivelInPenalizacion(NumAbonado, CodModulo, iCodServicio, iCodNivel, CodSuspreha, TipSuspreha)) {
					return(false);
				}
			}
			return(true);
		} catch (Exception e) {
			log.error("Error de ejecución : --->>> [" + e.getMessage() + "] En Validación de Suspensión <<<---");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		}
	}

/**
* Method validaRehabilitacion
* 
* @param NumAbonado int
* @param CodSuspreha String
* @param CodModulo String
* @param ServicioTotal String
* @param TipSuspreha String 
* @return boolean
*/
	private boolean validaRehabilitacion(int NumAbonado, String CodSuspreha, String CodModulo, String ServicioTotal, String TipSuspreha) {
		try {
			int  IntegerSERV = 6;
			int  IntegerNIV  = 4;
			int  IntegerCOD  = 2;
			String S;
			String N;
			int  NivelRea[] = new int[1]; 	//---->>> Se crea como arreglo para poder pasarlo por referencia
			int  NumServicio;
			int  CodServicio;
			int  CodNivel;
			int  i;
			String pSer;

			NumServicio = ServicioTotal.length()/IntegerSERV;
			pSer=ServicioTotal;
			for(i=0;i<NumServicio;i++) {
				S 		= pSer.substring(0,IntegerCOD);
				pSer 	= pSer.substring(IntegerCOD);
				N 		= pSer.substring(0,IntegerNIV);
				pSer 	= pSer.substring(IntegerNIV);

				CodServicio = Integer.parseInt(S);
				CodNivel    = Integer.parseInt(N);

				if (getNivelRea(NumAbonado, CodSuspreha, CodModulo, CodServicio, CodNivel, NivelRea) != true) {
					return(false);
				}
				if(!deleteLosaServicio(NumAbonado, CodModulo, CodServicio, CodNivel, NivelRea[0], TipSuspreha)) {
					return(false);
				}
			}
			return(true);
		} catch (Exception e) {
			log.error("Error de ejecución : --->>> [" + e.getMessage() + "] En Validación de Suspensión <<<---");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		}
	}

/**
* Method getNivelRea
* 
* @param Tabla String
* @param Num_Abonado int
* @param Cod_Suspreha String 
* @param Cod_Modulo String
* @param Cod_Servicio int
* @param Cod_Nivel int
* @param Cod_Nivel_Rea[] int
* @return boolean
* @throws SQLException
*/
	private boolean getNivelRea(int Num_Abonado, String Cod_Suspreha, String Cod_Modulo, int Cod_Servicio, int Cod_Nivel, int Cod_Nivel_Rea[])
	throws SQLException {
		try {
			strErrorBD = "";
			String strSql;
			int hCod_Nivel_Rea;
			
			strSql  = "SELECT nvl(max(cod_nivel_rea),-1) cod_nivel_rea FROM Icc_Penalizacion ";
			strSql += "WHERE Num_Abonado =  ? ";
			strSql += "AND Cod_Suspreha  =  ? ";
			strSql += "AND Cod_Modulo    =  ? ";
			strSql += "AND Cod_Servicio  =  ? ";
			strSql += "AND Cod_Nivel     =  ? ";
		
			stmt = conexionLocal.prepareStatement(strSql);
			stmt.setInt   ( 1,Num_Abonado);
			stmt.setString( 2,Cod_Suspreha);
			stmt.setString( 3,Cod_Modulo);
			stmt.setInt   ( 4,Cod_Servicio);
			stmt.setInt   ( 5,Cod_Nivel);
				
			rs = stmt.executeQuery();
		
			if (rs.next()) {
				hCod_Nivel_Rea =  rs.getInt("cod_nivel_rea");
			} else {
				hCod_Nivel_Rea = 0;
				strErrorBD = "NOT_FOUND";
			}
			cierraCursor(rs,stmt);
			Cod_Nivel_Rea[0] = hCod_Nivel_Rea;
			if (hCod_Nivel_Rea == -1) return(false);
			return(true);
		} catch (Exception e) {
			log.error("Error de ejecución : --->>> [" + e.getMessage() + "] En Validación de Suspensión <<<---");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}


/**
* Method deleteLosaServicio
* 
* @param Num_Abonado int
* @param Cod_Modulo String
* @param Cod_Servicio int 
* @param Cod_Nivel int
* @param Cod_Nivel_Rea int
* @param Tip_SusReha String
* @param Tabla String
* @return boolean
* @throws SQLException
*/
	private boolean deleteLosaServicio(int Num_Abonado, String Cod_Modulo, int Cod_Servicio, int Cod_Nivel, int Cod_Nivel_Rea, String Tip_SusReha)
	throws SQLException {
		try {
			strErrorBD = "";
			String strSql;
			String Sentencia;
			
			if (Tip_SusReha == "SS") {
				strSql  = "DELETE FROM Icc_Penalizacion ";
				strSql += "WHERE Num_Abonado    =  ? ";
				strSql += "  AND Cod_Modulo     =  ? ";
				strSql += "  AND Cod_Servicio   =  ? ";
				strSql += "  AND Tip_Suspension =  ? ";
				strSql += "  AND Cod_Nivel      =  ? ";
				
				stmt = conexionLocal.prepareStatement(strSql);
				stmt.setInt   (1,Num_Abonado);
				stmt.setString(2,Cod_Modulo);
				stmt.setInt   (3,Cod_Servicio);
				stmt.setString(4,Tip_SusReha);
				stmt.setInt   (5,Cod_Nivel);
				
				int salida = stmt.executeUpdate();
				conexionLocal.commit();
				cierraCursor(rs,stmt);
				//if (salida == 0) return(false); else return(true);
			} else if (Tip_SusReha == "ST") {
				strSql  = "DELETE FROM ICC_PENALIZACION ";
				strSql += "WHERE Num_Abonado    =  ? ";
				strSql += "  AND Cod_Modulo     =  ? ";
				strSql += "  AND Cod_Servicio   =  ? ";
				strSql += "  AND Tip_Suspension =  ? ";
				strSql += "  AND Cod_Nivel      =  ? ";
				strSql += "  AND Cod_Nivel_Rea  =  ? ";
				strSql += "  AND ROWNUM < 2 ";
				
				stmt = conexionLocal.prepareStatement(strSql);
				stmt.setInt   (1,Num_Abonado);
				stmt.setString(2,Cod_Modulo);
				stmt.setInt   (3,Cod_Servicio);
				stmt.setString(4,Tip_SusReha);
				stmt.setInt   (5,Cod_Nivel);
				stmt.setInt   (6,Cod_Nivel_Rea);
				
				int salida = stmt.executeUpdate();
				conexionLocal.commit();
				cierraCursor(rs,stmt);
			}
			return(true);
		} catch (Exception e) {
				log.error("Error de ejecución : --->>> [" + e.getMessage() + "] En Validación de Suspensión <<<---");
				strErrorBD = e.getMessage();
				log.error("StackTrace:",e);;
				return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
* Method getNivelInPenalizacion
* 
* @param NumAbonado INT
* @param CodModulo String 
* @param CodServicio int
* @param CodNivel int 
* @param CodSuspreha String
* @param TipSuspreha String
* @return boolean
* @throws SQLException
*/
	private boolean getNivelInPenalizacion(int NumAbonado, String CodModulo, int CodServicio, int CodNivel, String CodSuspreha, String TipSuspreha)
	throws SQLException {
		try {
			strErrorBD = "";
			String strSql;
			int  Nivel=0;
			int  CodNivelRea=0;
			int  NumServicio;
			int  NumServ2 = 0;
			int  Count;
			int  CodNivel1;
			int  CodServicio1;
			String ClaseServicio ="";
			String S;
			String N;
			String S1;
			String N1;
			int  j;
			String pSer1;
			int  IntegerCOD = 2;
			int  IntegerSERV = 6;
			int  IntegerNIV = 4;
			
			strSql  = "SELECT nvl(min(Cod_Nivel), -1) Cod_Nivel ";
			strSql += "FROM Icc_Penalizacion ";
			strSql += "WHERE Num_Abonado  = ? ";
			strSql += "  AND Cod_Modulo   = ? ";
			strSql += "  AND Cod_Servicio = ? ";
	
			stmt = conexionLocal.prepareStatement(strSql);
			stmt.setInt   ( 1,NumAbonado);
			stmt.setString( 2,CodModulo);
			stmt.setInt   ( 3,CodServicio);
			rs = stmt.executeQuery();
	
			if (rs.next()) {
				Nivel = rs.getInt("Cod_Nivel");
			} else {
				strErrorBD = "NOT_FOUND";
				cierraCursor(rs,stmt);
				return(false); 
			}
			cierraCursor(rs,stmt);
			if (Nivel != -1) {
				CodNivelRea = Nivel;
			}
			else {
				strSql  = "SELECT nvl(Clase_Servicio,chr(0)) Clase_Servicio ";
				strSql += "FROM Ga_Abocel ";
				strSql += "WHERE Num_Abonado = ? ";
	
				stmt = conexionLocal.prepareStatement(strSql);
				stmt.setInt( 1,NumAbonado);
				rs = stmt.executeQuery();
	
				if (rs.next()) {
					ClaseServicio = rs.getString("Clase_Servicio");
				}
				cierraCursor(rs,stmt);
				if (ClaseServicio.length() > 0) {
					NumServ2 = ClaseServicio.length()/IntegerSERV;
				}
				else {
					strSql  = "SELECT nvl(Clase_Servicio,chr(0)) Clase_Servicio ";
					strSql += "FROM Ga_Aboamist ";
					strSql += "WHERE Num_Abonado = ? ";
		
					stmt = conexionLocal.prepareStatement(strSql);
					stmt.setInt( 1,NumAbonado);
					rs = stmt.executeQuery();
		
					if (rs.next()) {
						ClaseServicio = rs.getString("Clase_Servicio");
					}
					cierraCursor(rs,stmt);
					if (ClaseServicio.length() == 0) {
						cierraCursor(rs,stmt);
						return(false);
					}
					if (ClaseServicio.length() > 0) {
						NumServ2 = ClaseServicio.length()/IntegerSERV;
					}
				}
				pSer1=ClaseServicio;
				
				for (j=0;j<NumServ2;j++) {
					S1           = pSer1.substring(0,IntegerCOD);
					pSer1        = pSer1.substring(IntegerCOD);
					N1           = pSer1.substring(0,IntegerNIV);
					pSer1        = pSer1.substring(IntegerNIV);
					CodServicio1 = Integer.parseInt(S1);
					CodNivel1    = Integer.parseInt(N1);
					if (CodServicio == CodServicio1) {
						CodNivelRea = CodNivel1;
					}

				}
			}
			
			strSql  = "SELECT count(*) ";
			strSql += "FROM Icc_Penalizacion ";
			strSql += "WHERE Num_Abonado  =  ? ";
			strSql += "  AND Cod_Suspreha =  ? ";
			strSql += "  AND Cod_Modulo   =  ? ";
			strSql += "  AND Cod_Servicio =  ? ";
			strSql += "  AND Cod_Nivel    =  ? ";
	
			stmt = conexionLocal.prepareStatement(strSql);
			stmt.setInt   ( 1,NumAbonado);
			stmt.setString( 2,CodSuspreha);
			stmt.setString( 3,CodModulo);
			stmt.setInt   ( 4,CodServicio);
			stmt.setInt   ( 5,CodNivel);
			
			rs2 = stmt.executeQuery();
			Count = 0;
			if (rs2.next()) {
				Count =  rs2.getInt(1);
			}
			cierraCursor(rs2,stmt);
			if (Count > 0) {
				CodNivelRea = CodNivel;
				return(true);
			}
			
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "INSERT INTO Icc_Penalizacion (";
			strSql += "Num_Abonado, Cod_Modulo, Cod_Suspreha, Cod_Servicio, Cod_Nivel, Tip_Suspension, Cod_Nivel_Rea) ";
			strSql += "VALUES (?,?,?,?,?,?,?)";
			stmt = conexionLocal.prepareStatement(strSql);	
//---->>> Envía los parámetros
			stmt.setInt   ( 1,NumAbonado);
			stmt.setString( 2,CodModulo);
			stmt.setString( 3,CodSuspreha);
			stmt.setInt   ( 4,CodServicio);
			stmt.setInt   ( 5,CodNivel);
			stmt.setString( 6,TipSuspreha);
			stmt.setInt   ( 7,CodNivelRea);
			
//--->>> Termina la transacción
			int reg = stmt.executeUpdate();
			conexionLocal.commit();
			cierraCursor(rs,stmt);
			return(true);							
		} catch (Exception e) {
			log.error("Error de ejecución : --->>> [" + e.getMessage() + "] En Validación de Suspensión <<<---");
			strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}
//---------------------------------------------------------------------------------------------------//
//                                   DECLARACION DE ESTRUCTURAS                                      //
//---------------------------------------------------------------------------------------------------//
/**
 * Clase privada para ser utilizada como estructura donde almacenar las Centrales
 * @author Juan Ramos
 * @version $Revision$
 */		
	private class TypeCentrales {
		int		iCod_Producto;      /* Codigo de Producto                               */
		int  	iCod_Central;		/* Codigo de estado de la central                   */
		String 	szNom_Central; 		/* Nombre de la Central                             */
		String	szCod_Nemotec;		/* Codigo nemotecnico                               */
		int  	iCod_Estado;		/* Codigo de estado de la central                   */
		String  szCod_Alm;			/* Codigo de ALM                                    */
		int  	iNum_MaxIntentos;	/* Numero maximo de reintentos de un movimiento     */
		int  	iCod_Sistema;		/* Codigo de Sistema                                */
		String 	szDes_Sistema;		/* Descripcion del sistema                          */
		int  	iCod_Tipo;			/* Codigo de Tipo de Sistema                        */
		int  	iCod_Lenguaje;		/* Codigo de Lenguaje                               */
		String 	szFun_Servicio;		/* Nombre de la Funcion de Servicios                */
		int  	iCod_Indice;		/* Indice del puntero al Interfaz                   */
		int  	iNum_Sistemas;      /* Numero de sistemas en los que reintentar         */
		//void 	*stSistema;         /* Sistema de Interfaz                              */
	};
/**
 * Clase privada para ser utilizada como estructura donde almacenar los Servicios
 * @author Juan Ramos
 * @version $Revision$
 */		
	private class TypeServicios {
		int  	iNumServicios;      /* Clase de Servicio                               */
		int  	iCod_Producto;      /* Clase de Servicio                               */
		String 	szServicios;
		String 	szActServ;
	};

/**
 * Clase privada para ser utilizada como estructura donde almacenar los Parámetros
 * @author Juan Ramos
 * @version $Revision$
 */		
	private class TypeParametros {
		String szNom_Parametro;
		String szTip_Parametro;
		String szDef_Parametro;
	};

/**
 * Clase privada para ser utilizada como estructura donde almacenar los Comandos
 * @author Juan Ramos
 * @version $Revision$
 */		
	private class TypeComando {
		int    		iCod_Lenguaje_Exe;
		int    		iCod_Sistema_Exe;
		int    		iCod_Comando;
		int    		iNum_Orden;
		String 		szNom_Comando;
		String 		szDes_Sintaxis;
		String 		szDes_Comando;
		String 		szComando;
		String 		szRespuesta;
		String		szDes_Condicion;
		String		szCond_Tip_Terminal;
		String		szIndGestor;
		int			iInd_Nuevo;
		int			iInd_Ign;
		int			iNum_OOSS;
		TypeCentrales cen         = new TypeCentrales();
		TypeServicios stServicios = new TypeServicios();
		int iNumParametros;
		TypeParametros pParam;
	};

/**
 * Clase privada para ser utilizada como estructura donde almacenar los Tipos de Respuestas
 * @author Juan Ramos
 * @version $Revision$
 */	
	private class TypeRespuestas {
		int 	iCod_Lenguaje;   	/* Lenguaje                                       */
		int 	iCod_Comando;    	/* Comando                                        */
		int 	iTip_Respuesta;  	/* Tipo de Respuesta (0,1)                        */
		int 	iCod_Respuesta;  	/* Codigo de Respuesta                            */
		int    	iCod_Linea;         /* Linea o Orden de Aparicion                     */
		String 	szNom_Respuesta;    /* Nombre de la Respuesta                         */
		String 	szDes_Respuesta;    /* Descripcion de la Respuesta                    */
	};
 
/**
 * Clase privada para ser utilizada como estructura donde almacenar los Comandos de Respuestas
 * @author Juan Ramos
 * @version $Revision$
 */		
	private class TypeComResp {
		int    nComResp = 0;
		Vector pszLines = new Vector(); /* Linea para cada respuestas					  */
		Vector iCodResp = new Vector();	/* Código de respuesta para cada una de ellas	  */
		Vector iTipResp = new Vector();	/* Tipo de respuesta para cada una de ellas		  */
	}; 
	
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
