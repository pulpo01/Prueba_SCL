package com.tmmas.IC.GeneraMovMasivos;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

import org.apache.log4j.Logger;

/**
 * Clase para el manejo de la Base de datos en el servicio RecepcionRespuestas
 * @author Juan Ramos
 * @version $Revision$
 */
class ServicioBD {
/**
 * Field strErrorBD
 */
	public String strErrorBD = "";

   	public GeneraMovMasivos GMM = new GeneraMovMasivos();

   	
	
/**
 * Field ESTADO_ACTIVO
 */
	public static final String ESTADO_ACTIVO    	= "A";
/**
 * Field ESTADO_TERMINADO
 */
	public static final String ESTADO_TERMINADO 	= "T";
/**
 * Field ESTADO_FINALIZADO
 */
	public static final String ESTADO_FINALIZADO	= "F";	
/**
 * Field ESTADO_ERROR
 */
	public static final String ESTADO_ERROR     	= "E";
	
/**
 * Field ESTADO_REINTENTADO
 */
	public static final String ESTADO_REINTENTADO 	= "R";
	
/**
 * Field ESTADO_PENDIENTE
 */
	public static final int ESTADO_PENDIENTE    = 1;
/**
 * Field ESTADO_REINTENTABLE
 */
	public static final int ESTADO_REINTENTABLE = 2;
/**
 * Field log
 */
	private static Logger log = Logger.getLogger(ServicioBD.class.getName());
/**
 * Field prepareStmt
 */
	public PreparedStatement prepareStmt;	
/**
 * Field CLASS_VERSION
 */	
	private static final double CLASS_VERSION = 3.1;  // Incidencia 70907
	
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
	
	public Connection conectaBaseDatos(String strHost, int numPuerto, String strInstancia, String strUsuario,String strPassword)
	throws SQLException	{
	  try {
		String strConexion  = "jdbc:oracle:thin:@"; // String de Conexión 
		  
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		String urlconect = new String(strConexion + strHost + ":" + numPuerto + ":" + strInstancia); 
		Connection conn = DriverManager.getConnection (urlconect, strUsuario, strPassword);
		log.debug("Conectado a la base de datos. Class version: " + CLASS_VERSION);
		return(conn);
	  } catch (Exception e) {
	  	strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(null);
			}		
		log.error("Error al conectar con Oracle: --->>> [" + e.getMessage() + "] <<<---");
		return(null);	  	
	  }
	}

/**
 * Method creaStatementConsulta
 * Creación de un Objeto Statement para realizar las consultas masivas desde el Monitor
 * @param conexionActual Connection
 * @return Statement
 * @throws SQLException
 */
	public Statement creaStatementConsulta(Connection conexionActual)
	throws SQLException	{
		try {
			Statement stmt = conexionActual.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			return(stmt);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(null);
			}		
			log.error("Error al generar Statement: --->>> [" + e.getMessage() + "] <<<---");
			return(null);	  	
		}
	}

/**
 * Method getNowBD
 * Extrae la Fecha y Hora actual de la Base de Datos 
 * @param stmt Statement
 * @return Date
 * @throws SQLException
 */
	public Date getNowBD(Connection conexionActual) 
	throws SQLException	{
		Statement stmt = null;
		ResultSet rsF  = null;
		try {
			Date now;
			strErrorBD = "";
			String strSql;
	
			strSql  = "SELECT SYSDATE FROM DUAL";
//--->>> Termina la transacción
  			stmt = conexionActual.createStatement();
  			rsF = stmt.executeQuery(strSql);
			if (!rsF.next()) { 
				cierraCursor(rsF, stmt);
				return(null);
			}
			now = new Date(rsF.getTimestamp("SYSDATE").getTime());
			cierraCursor(rsF, stmt);
			return( now);
		} catch (IllegalArgumentException e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(null);
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Lectura Fecha Base de Datos");
			log.error("StackTrace:",e);;
			return(null);
		} finally {
			cierraCursor(rsF, stmt);
		}
	}
	

/**
 * Method getMovParaEjecucion
 * Extrae las ejecuciones que corresponden al instante 
 * @param stmt Statement
 * @return ResultSet 
 * @throws SQLException
 */
	public ResultSet getMovParaEjecucion(Statement stmt)
	throws SQLException {
		ResultSet rs = null;
		try {
			strErrorBD = "";
			String strSql;
			String salida = "";
			double totSegundos  = 0;
			//strSql = "SELECT * FROM Icc_Agenda_Movimientos_Td WHERE FEC_EJEC_INI <= SYSDATE";
			// Incio Incidencia 71117 
			strSql  = "SELECT * FROM Icc_Agenda_Movimientos_Td "; 
			strSql += "WHERE FEC_EJEC_INI <= SYSDATE "; 
			strSql += "and  (to_number(to_char(sysdate,'hh24mi')) between hor_ini_franja and  hor_fin_franja) "; 
			strSql += "union ";
			strSql += "select * from Icc_Agenda_Movimientos_Td ";
			strSql += "WHERE FEC_EJEC_INI <= SYSDATE and hor_ini_franja < 0 and hor_fin_franja < 0 ";
			// Fin Incidencia 71117			
			rs = stmt.executeQuery(strSql);
			if (!rs.next()) {
				rs.close();
				return(null);
			}
			return(rs);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(null);
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] En lectura de Agenda de Ejecuciones <<<---");
			log.error("StackTrace:",e);
			rs.close();
			return(null);
		}
	}	

/**
 * Method setNuevaFechaEjecucion
 * Actualiza la nueva fecha de ejecución 
 * @param conexionActual Connection
 * @param codMasivo String
 * @param strNuevaFecha String
 * @return boolean
 * @throws SQLException
 */
	public boolean setNuevaFechaEjecucion(Connection conexionActual, String codMasivo, String strNuevaFecha) 
	throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			strErrorBD = "";
			String strSql;
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql =  "UPDATE Icc_Agenda_Movimientos_Td SET ";
			strSql += " FEC_EJEC_INI = TO_DATE(?,'DD/MM/YYYY HH24:MI:SS') ";
			strSql += "WHERE Cod_Masivo = ? ";
			stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
  			stmt.setString( 1,strNuevaFecha);
			stmt.setString( 2,codMasivo);
			
			
//--->>> Termina la transacción
			int reg = stmt.executeUpdate();
			conexionActual.commit();
			cierraCursor(rs, stmt);
			return(true);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(false);
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Actualización de fecha de ejecucón: [" + strNuevaFecha + "]");
			log.error("StackTrace:",e);;
			return(false);
		}finally {
			cierraCursor(rs, stmt);
		}
	}

/**
 * Method getEjecucionesActivas
 * Retorna un ResulSet con las Ejecuciones que según la BD están activas
 * @param stmt Statement
 * @return ResulSet
 * @throws SQLException
 */
	public ResultSet getEjecucionesActivas(Statement stmt)
	throws SQLException	{
		ResultSet rs = null;
		try {
			strErrorBD = "";
			String strSql;
	
			strSql  = "SELECT * FROM Icc_Ejecucion_Movimientos_To ";
			strSql += "WHERE Estado     = 'A' ";
			strSql += "ORDER BY Fec_Asignacion";
//--->>> Termina la transacción
			rs = stmt.executeQuery(strSql);
			
			if (rs.next()) {
				return(rs);
			} else {
				strErrorBD = "NOT_FOUND";
				rs.close();
				return(null); 
			}
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(null);
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Lectura de Ejecuciones Activas");
			log.error("StackTrace:",e);;
			rs.close();
			return(null);
		}
	}

/**
 * Method getNuevoRangoMovimiento
 * Retorna un objeto de tipo TypeNodoRango con el rango a ejecutar 
 * para el tipo de estado  dado por parámetro
 * @param  conexionActual Connection
 * @param  codMasivo String
 * @param  tipEstado int
 * @param  numMaximoRango int
 * @return TypeNodoRango
 * @throws SQLException
 */
	public TypeNodoRango getNuevoRangoMovimiento(Connection conexionActual,String codMasivo, int tipEstado, int numMaximoRango)
	throws SQLException	{
		ResultSet rs   = null;
		PreparedStatement prepareStmt = null;
		try {
			TypeNodoRango nodo = new TypeNodoRango();
			strErrorBD = "";
			int numRangoIni = 0;
			String strSql, strSqlEstados, tipoEstado,strSqlTipEstado;
			
			/*
			 * ESTADO_PENDIENTE = 1
			 * ESTADO_REINTENTABLE = 2
			 * */
			
			if (tipEstado == ESTADO_PENDIENTE) {
				tipoEstado="P";
				strSqlEstados = "Cod_Estado = 1 ";
				strSqlTipEstado = "Tip_Estado = 'P' ";
			}
			else{
				tipoEstado="R";
				strSqlEstados = "Cod_Estado NOT IN (1,2,6,9,11) ";
				strSqlTipEstado = "Tip_Estado = 'R' ";
			}
			
			/*if (tipEstado == ESTADO_PENDIENTE) {*/
//--->>> Rescate del último rango asignado
				strSql  = "SELECT MAX(Num_Rango_Ter) AS Num_Rango_Ini ";
				strSql += "FROM Icc_Asignacion_Rangos_To ";
				strSql += "WHERE Cod_Masivo = ? ";
				strSql += "  AND Tip_Estado = ? ";
				prepareStmt = conexionActual.prepareStatement(strSql);
				prepareStmt.setString( 1,codMasivo);
				prepareStmt.setString( 2,tipoEstado);
				rs = prepareStmt.executeQuery();
				if (rs.next()) {
					numRangoIni = rs.getInt("Num_Rango_Ini");
					cierraCursor(rs, prepareStmt);
					if (tipEstado != ESTADO_PENDIENTE) {
						strSql  = "DELETE FROM Icc_Asignacion_Rangos_To ";
						strSql += "WHERE Cod_Masivo = ?";
						strSql += "  AND Tip_Estado = 'R'";
						prepareStmt = conexionActual.prepareStatement(strSql);
						prepareStmt.setString( 1,codMasivo);
						prepareStmt.executeUpdate();
						cierraCursor(rs, prepareStmt);
						numRangoIni = 0;
					}
				} else {
					numRangoIni = 0;
					cierraCursor(rs, prepareStmt);
				} 
				nodo.tipEstados = tipoEstado;
				/*strSqlEstados = "Cod_Estado = 1 ";*/
			/*} else {
				strSql  = "DELETE FROM Icc_Asignacion_Rangos_To ";
				strSql += "WHERE Cod_Masivo = ?";
				strSql += "  AND Tip_Estado = 'R'";
				prepareStmt = conexionActual.prepareStatement(strSql);
				prepareStmt.setString( 1,codMasivo);
				prepareStmt.executeUpdate();
				numRangoIni = 0;
				nodo.tipEstados = "R";
				strSqlEstados = "Cod_Estado NOT IN (1,2,6,9,11) ";
				cierraCursor(rs, prepareStmt);
			}*/
				
//--->>> Rescate del Rango a entregar			
			strSql  = "SELECT Num_Movimiento "; 
			strSql += "FROM Icc_Movimiento a "; 
			strSql += "WHERE " + strSqlEstados; 
			strSql += "  AND a.Num_Movimiento > ? "; 
			strSql += "  AND a.Ind_Bloqueo    = 0 ";
			strSql += "  AND a.Num_Intentos < (SELECT Num_Maxintentos "; 
			strSql += "                        FROM Icg_Central ";  
			strSql += "                        WHERE Cod_Producto  =  1 ";
			strSql += "                          AND Cod_Central   =  a.Cod_Central) ";
			strSql += "  AND a.Cod_Actuacion IN (SELECT TO_NUMBER(Cod_Actuacion) "; 
			strSql += "                          FROM Icd_Masivo WHERE Cod_Masivo = ? ) ";
			strSql += "  AND NOT EXISTS (SELECT 1 FROM ICC_ASIGNACION_RANGOS_TO WHERE ? BETWEEN Num_rango_ini and Num_rango_ter and Cod_masivo =? and estado='A' and " + strSqlTipEstado + ")";     // Inc 38870
			strSql += "ORDER BY Num_Movimiento ";
			
//INI MA-200507070733			
			strSql = "SELECT Num_movimiento FROM (" + strSql + ") WHERE rownum <= ? ";
			prepareStmt = conexionActual.prepareStatement(strSql,ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_UPDATABLE);
			prepareStmt.setInt   ( 1,numRangoIni);	
			prepareStmt.setString( 2,codMasivo);
			prepareStmt.setInt   ( 3,numRangoIni);	
			prepareStmt.setString( 4,codMasivo);
			prepareStmt.setInt   ( 5,numMaximoRango);

			log.debug("Valores dados en la busqueda de rangos: Tipo= [" + nodo.tipEstados + "], Cod Masivo= [" + codMasivo + "] Rango Ini= [" + numRangoIni + "], Maximo Registros= [" + numMaximoRango + "]");
			
//			prepareStmt.setMaxRows(numMaximoRango);
//			prepareStmt.setFetchSize(numMaximoRango);
//FIN MA-200507070733			
			rs = prepareStmt.executeQuery();
			
			if (rs.next()) {
				if (numRangoIni == 0) {
					nodo.numRangoIni  = rs.getInt("Num_Movimiento");
				} else {
					nodo.numRangoIni  = numRangoIni;
				}
				rs.last(); 
				nodo.numRangoFin  = rs.getInt("Num_Movimiento");
				log.debug("Rangos encontrados Rango Inicio= " + nodo.numRangoIni + ", Rango Fin= " + nodo.numRangoFin);
			} else {
				nodo.numRangoIni = -1;
				nodo.numRangoFin = -1;
			}
				
			nodo.codMasivo   = codMasivo;
			cierraCursor(rs, prepareStmt);
			return(nodo);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(null);
			}		
			log.error("Error de ejecución Oracle En Busqueda de nuevo Rango: --->>> [" + e.getMessage() + "] <<<--- ");
			log.error("StackTrace:",e);
			cierraCursor(rs, prepareStmt);
			return(null);
		} finally {
			cierraCursor(rs, prepareStmt);
		}
	}


/**
 * Method getRangosActivos
 * Retorna un ResulSet con las Ejecuciones de rangos que según la BD están activas
 * @param conexionActual Connection
 * @param stmt PreparedStatement
 * @param codMasivo String
 * @return ResulSet
 * @throws SQLException
 */
	public void getRangosActivos(Connection conexionActual, PreparedStatement stmt, String codMasivo, int tipEstado)
	throws SQLException	{
		ResultSet rs = null;
		Statement stm = null;
		try {
			strErrorBD = "";
			String strSql,tipoEstado,strSqlEstados;			
			
			/*
			 * ESTADO_PENDIENTE = 1
			 * ESTADO_REINTENTABLE = 2
			 * */
			
			if (tipEstado == ESTADO_PENDIENTE) {
				tipoEstado="P";
				strSqlEstados = "AND a.Cod_Estado = 1 ";
			}
			else{
				tipoEstado="R";
				strSqlEstados = "AND a.Cod_Estado NOT IN (1,2,6,9,11) ";
			}			
			
//---->>> Busca y retorna todas los rango en ejecución
			strSql  = "SELECT MIN(Num_Movimiento) AS Minimo ";
			strSql += "FROM Icc_Movimiento a ";
			strSql += "WHERE a.Num_Movimiento  <= (SELECT MAX(Num_Rango_Ter)  ";			
			strSql += "						   FROM Icc_Asignacion_Rangos_To ";
			strSql += "						   WHERE Cod_Masivo = ? AND Tip_Estado = ?) ";			
			strSql += strSqlEstados;
			strSql += "  AND a.Ind_Bloqueo    = 0 ";
			strSql += "  AND a.Num_Intentos   <  (SELECT Num_Maxintentos ";
			strSql += "                           FROM Icg_Central ";
			strSql += "                           WHERE Cod_Producto  =  1 AND Cod_Central = a.Cod_Central ) ";
			strSql += "  AND a.Cod_Actuacion  IN (SELECT TO_NUMBER(Cod_Actuacion) FROM Icd_Masivo WHERE Cod_Masivo = ? ) ";
			stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
			stmt.setString( 1, codMasivo );
			stmt.setString( 2, tipoEstado );
			stmt.setString( 3, codMasivo );			

			rs = stmt.executeQuery();
			if (rs.next()) {
				int minimo = rs.getInt("Minimo");
				if (minimo > 0) { 
					log.debug ("Existen movimientos menores al movimiento final (" + minimo + "), se borran los rangos inscritos del Código Masivo." );
					
					strSql  = "DELETE Icc_Asignacion_Rangos_To ";
					strSql += "WHERE Cod_Masivo  =  ?  ";
					strSql += "  AND Tip_Estado  = ? ";
					stmt.close();
					stmt = conexionActual.prepareStatement(strSql);	
					stmt.setString( 1, codMasivo );
					stmt.setString( 2, tipoEstado );
					stmt.executeUpdate();
					conexionActual.commit();
					cierraCursor(rs, stmt);
					return;
				}
			}
			cierraCursor(rs, stmt);
//|---->>> Primero Termina cualquier ejecucion que haya finalizado
			log.info("No existen movimientos menores al movimiento final, ni ejecuciones pendientes." );
			strSql  = "UPDATE Icc_Asignacion_Rangos_To SET ";
			strSql += "      Estado = 'T' ";
			strSql += "WHERE Estado = 'F' ";
			stm = conexionActual.createStatement();
			stm.executeUpdate(strSql);
			conexionActual.commit();
			cierraCursor(rs, stm); //MA-200507070733 Se agrega Cierre de Cursor
			cierraCursor(rs, stmt);
			return; 
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return;
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Lectura de Asignación Rangos");
			log.error("StackTrace:",e);
			cierraCursor(rs, stm); //MA-200507070733 Se agrega Cierre de Cursor
			cierraCursor(rs, stmt);
			return;
		}
	}

/**
 * Recupera algún rango que el operador quiera reintentar 
 * @param conexionActual
 * @param stmt
 * @param codMasivo
 * @return
 * @throws SQLException
 */
	public TypeNodoRango getRangoReintentado(Connection conexionActual,String codMasivo)
	throws SQLException	{
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
			String strSql;
//---->>> Busca y retorna todos los rangos reintentado por el operador
			strSql  = "SELECT * FROM Icc_Asignacion_Rangos_To ";
			strSql += "WHERE Estado     = 'R' ";
			strSql += "  AND Cod_Masivo = ? ";
			strSql += "ORDER BY Fec_Asignacion";
			stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
			stmt.setString( 1,codMasivo);
//--->>> Termina la transacción
			rs = stmt.executeQuery();
			if (rs.next()) {
				TypeNodoRango rangoReintentable = new TypeNodoRango();
				
				rangoReintentable.codMasivo   	= codMasivo;
				rangoReintentable.numRangoIni	= rs.getInt("Num_Rango_Ini");
				rangoReintentable.numRangoFin	= rs.getInt("Num_Rango_Ter");
				rangoReintentable.tipEstados 	= rs.getString("Tip_Estado");
				cierraCursor(rs, stmt);
				return(rangoReintentable);
			} else {
				cierraCursor(rs, stmt);
				strErrorBD = "NOT_FOUND";
				return(null); 
			}
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(null);
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Lectura de Asignación Rangos");
			log.error("StackTrace:",e);;
			cierraCursor(rs, stmt);
			return(null);
		}
	}

	
/**
 * Method getEstadoEjecuRango
 * Retorna es estado en que se encuentra una ejecución de mvimientos masivos a través de Rangos
 * @param conexionActual Connection
 * @param codMasivo String
 * @param numRangoIni int
 * @return String
 * @throws SQLException
 */
	public String getEstadoEjecuRango(Connection conexionActual, String codMasivo, int numRangoIni)
	throws SQLException	{
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
			String strSql;

			strSql  = "SELECT Estado FROM Icc_Asignacion_Rangos_To ";
			strSql += "WHERE Cod_Masivo    = ? ";
			strSql += "  AND Num_Rango_Ini = ? ";
			stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
			stmt.setString( 1,codMasivo);
			stmt.setInt   ( 2,numRangoIni);
//--->>> Termina la transacción
			rs = stmt.executeQuery();
			if (rs.next()) {
				String estado = rs.getString("Estado");
				cierraCursor(rs, stmt);
				return(estado);
			} else {
				cierraCursor(rs, stmt);
				return("E"); 
			}
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return("E");
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Lectura de Asignación Rangos");
			log.error("StackTrace:",e);;
			return("E");
		} finally {
			cierraCursor(rs, stmt);
		}
	}

/**
 * Method putNuevaEjecucionRango
 * Registra el inicio de una ejeución de movimientos masivos a traves de Rangos
 * @param conexionActual Connection
 * @param nodo TypeNodoRango
 * @return boolean
 * @throws SQLException
 */
	public boolean putNuevaEjecucionRango(Connection conexionActual, TypeNodoRango nodo) 
   	throws SQLException {
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
		   	String strSql;
//---->>> Transacciones con la BD, Llama al formato del procedure
		   	strSql =  "INSERT INTO Icc_Asignacion_Rangos_To ";
		   	strSql += "(Cod_masivo, Num_Rango_Ini, Num_Rango_Ter, Cod_Tarea, Tip_Estado, Fec_Asignacion, Estado, Num_Reintentos) ";
			strSql += "VALUES (?,?,?,'0',?,SYSDATE,'A',0)";
		   	stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
		   	stmt.setString( 1,nodo.codMasivo);
			stmt.setInt   ( 2,nodo.numRangoIni);
			stmt.setInt   ( 3,nodo.numRangoFin);
			stmt.setString( 4,nodo.tipEstados);

//--->>> Termina la transacción
		   	int reg = stmt.executeUpdate();
		   	conexionActual.commit();
		   	cierraCursor(rs, stmt);
		   	return(true);			
	   	} catch (Exception e) {
	   		strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(false);
			}		
	   		if (e.getMessage().indexOf("ORA-00001") >= 0) {
	   			log.warn("El rango ya estaba asignado: Cod.Masivo= " + nodo.codMasivo + ", Rango Inicio= " + nodo.numRangoIni + ", Rango Fin= " + nodo.numRangoFin );
	   			cierraCursor(rs, stmt);
	   			return(true);
	   		}
		   	log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- en Creación Estado Asignacion Rangos");
		   	log.error("StackTrace:",e);;
		   	cierraCursor(rs, stmt);
		   	return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
   	}

/**
 * Method putNuevaEjecucionMovimiento
 * Registra la ejecución de un movimientos masivo
 * @param conexionActual Connection
 * @param codMasivo String
 * @param codTarea String
 * @param numRangoPendientes int
 * @param numRangoReintentables int
 * @return boolean
 * @throws SQLException
 */
	public boolean putNuevaEjecucionMovimiento(Connection conexionActual, String codMasivo, String codTarea, 
	                                           int numRangoPendientes, int numRangoReintentables) 
	throws SQLException {
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
			String strSql;
//---->>> Transacciones con la BD, Llama al formato del procedure
  			strSql  = "UPDATE Icc_Ejecucion_Movimientos_To SET ";
  			strSql += " Fec_Asignacion = SYSDATE, ";
			strSql += " Estado         = '" + ESTADO_ACTIVO + "'";
  			strSql += "WHERE Cod_Masivo = ? ";  
			stmt = conexionActual.prepareStatement(strSql);
			stmt.setString( 1,codMasivo);
			int reg = stmt.executeUpdate();
			cierraCursor(rs, stmt);
			if (reg == 0) {
				log.debug("El procesamiento masivo [" + codMasivo + "] no estaba resgitrado. Es Insertado");
				strSql =  "INSERT INTO Icc_Ejecucion_Movimientos_To ";
				strSql += "(Cod_masivo, Cod_Tarea, Fec_Asignacion, Estado, Num_Rango_Pendientes, Num_Rango_Reintentables) ";
				strSql += "VALUES (?,?,SYSDATE,'A',?,?)";
				stmt = conexionActual.prepareStatement(strSql);	
				stmt.setString( 1,codMasivo);
				stmt.setString( 2,codTarea);
				stmt.setInt   ( 3,numRangoPendientes);
				stmt.setInt   ( 4,numRangoReintentables);
				reg = stmt.executeUpdate();
			}else {
				log.debug("El procesamiento masivo [" + codMasivo + "] ya estaba resgitrado. Es Actualizado");
			}
			conexionActual.commit();
			cierraCursor(rs, stmt);
			return(true);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(false);
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- en Creación Estado Asignacion Rangos");
			log.error("StackTrace:",e);
			cierraCursor(rs, stmt);
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method setFinEjecucionMovimiento
 * Registra el fin de la ejecución de un movimientos masivo
 * @param conexionActual Connection
 * @param codMasivo String
 * @param codTarea String
 * @return boolean
 * @throws SQLException
 */
	public boolean setFinEjecucionMovimiento(Connection conexionActual, String codMasivo) 
	throws SQLException {
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
			String strSql;
//	  ---->>> Transacciones con la BD, Llama al formato del procedure
			strSql  = "UPDATE Icc_Ejecucion_Movimientos_To SET ";
			strSql += " Estado          = '" + ESTADO_TERMINADO + "'";
			strSql += "WHERE Cod_Masivo =  ? ";
			stmt = conexionActual.prepareStatement(strSql);
			stmt.setString( 1,codMasivo);
			int reg = stmt.executeUpdate();
			conexionActual.commit();
			cierraCursor(rs, stmt);
			return(true);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(false);
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- en Creación Estado Asignacion Rangos");
			log.error("StackTrace:",e);
			cierraCursor(rs, stmt);
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method setEstadoEjecucionRango
 * Actualiza el estado de una ejecución de Rangos 
 * @param conexionActual Connection
 * @param codMasivo String
 * @param numRangoIni int
 * @param incrementaIntento boolean
 * @return boolean
 * @throws SQLException
 */
	public boolean setEstadoEjecucionRango(Connection conexionActual, String codMasivo, int numRangoIni, String estado, boolean incrementaIntento) 
	throws SQLException {
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
			String strSql;
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "UPDATE Icc_Asignacion_Rangos_To SET ";
			strSql += "Estado   = ? ";
			if (incrementaIntento) strSql += ",Num_Reintentos = Num_Reintentos + 1 ";
			strSql += "WHERE Cod_Masivo   = ?";
			strSql += "  AND Num_Rango_Ini = ?";
			stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
			stmt.setString( 1,estado);
			stmt.setString( 2,codMasivo);
			stmt.setInt   ( 3,numRangoIni);

//--->>> Termina la transacción
			int reg = stmt.executeUpdate();
			conexionActual.commit();
			cierraCursor(rs, stmt);
			return(true);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(GMM.evaluaError(strErrorBD)){				
					log.fatal("Se ha terminado la conexión con la Base de datos");
					return(false);
			}		
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- en Actualización Estado Asignacion Rangos");
			log.error("StackTrace:",e);
			cierraCursor(rs, stmt);
			return(false);
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
			} catch(Exception e ){log.error("Error al cerrar ResulSet: ", e);}
		} 
		if( stmt != null ) {
			try { 
				stmt.close();
			} catch(Exception e){log.error("Error al cerrar PreparedStatement: ", e);}
		}		
	}	
	
/**
 * Method cierraCursor
 * Cierra un ResulSet y un Statement
 * @param rs ResultSet
 * @param stmt Statement
 */
	private void cierraCursor(ResultSet rs, Statement stmt) {
		if( rs != null ) {
			try {
				rs.close();
			} catch(Exception e ){log.error("Error al cerrar ResulSet: ", e);}
		} 
		if( stmt != null ) {
			try {
				stmt.close();
			} catch(Exception e){log.error("Error al cerrar Statement: ", e);}
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


