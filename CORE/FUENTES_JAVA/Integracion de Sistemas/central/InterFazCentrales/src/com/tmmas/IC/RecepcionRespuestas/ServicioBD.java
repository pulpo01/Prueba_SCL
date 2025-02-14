
package com.tmmas.IC.RecepcionRespuestas;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
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
	
	public RecepcionRespuestas RR = new RecepcionRespuestas();
	
	/**
	 * Field log
	 */
	private static Logger log = Logger.getLogger(ServicioBD.class.getName());
	public PreparedStatement prepareStmt;	
	
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
		return(conn);
	  } catch (Exception e) {
	  	strErrorBD = e.getMessage();
	  	if(RR.evaluaError(strErrorBD)){				
			log.fatal("Se ha terminado la conexión con la Base de datos");
			System.exit(-2);				
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
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				System.exit(-2);				
		  	}
			log.error("Error al generar Statement: --->>> [" + e.getMessage() + "] <<<---");
			return(null);	  	
		}
	}

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
	
	private void cierraCursor(ResultSet rs, Statement stmt) {
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
 * Method getNotificaciones
 * Extrae las notificaciones pendientes por caídas
 * @param stmt Statement
 * @return ResultSet 
 * @throws SQLException
 */
	public ResultSet getNotificaciones(Statement stmt)
	throws SQLException {
		ResultSet rs = null;
		try {
			strErrorBD = "";
			String strSql;
			String salida = "";
			double totSegundos  = 0;
			strSql = "SELECT * FROM Icc_Notificaciones_To ";
			rs = stmt.executeQuery(strSql);
			if (!rs.next()) {
				cierraCursor(rs,stmt);
				return(null);
			}
			return(rs);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] En búsqueda de Notificación <<<---");
			//strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			cierraCursor(rs,stmt);
			return(null);
		}
	}

/**
 * Method putNotificacion
 * Inserta la notificación recepcionada y asignada a algún Procesador 
 * @param conexionActual Connection
 * @param codProc long
 * @param strNotificacion String
 * @return boolean
 * @throws SQLException
 */
	public boolean putNotificacion(Connection conexionActual, long codProc, String strNotificacion) 
	throws SQLException {
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			strErrorBD = "";
			String strSql;
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "INSERT INTO Icc_Notificaciones_To (";
			strSql += "Id_Proc, Notificacion, Est_Notif, Fec_Notif) ";
			strSql += "VALUES (?,?,0,SYSDATE)";
			stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
			stmt.setLong  ( 1,codProc);
			stmt.setString( 2,strNotificacion);
//--->>> Termina la transacción
			int reg = stmt.executeUpdate();
			conexionActual.commit();
			return(true);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En insersión de la notificación: [" + strNotificacion + "]");
			//strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
 * Method deleteNotificacion
 * Elimina una notificación ya procesada
 * @param conexonActual Connection
 * @param codProc long
 * @return boolean
 * @throws SQLException
 */
public boolean deleteNotificacion(Connection conexionActual, long codProc)
	throws SQLException	{
		PreparedStatement stmt = null;
		ResultSet rs = null;
		try {
			strErrorBD = "";
			String strSql;
			strSql = "DELETE FROM Icc_Notificaciones_To WHERE Id_Proc = ? ";
			stmt = conexionActual.prepareStatement(strSql);
			stmt.setLong(1,codProc);
			int salida = stmt.executeUpdate();
			conexionActual.commit();
			cierraCursor(rs,stmt);
			return(true);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");				
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] En Borrado de la notificación [" + codProc + "]<<<---");
			//strErrorBD = e.getMessage();
			log.error("StackTrace:",e);;
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}		 

/**
 * Method getRenotificaciones
 * Retorna un ResulSet con las Renotificaciones a procesar
 * @param conexionActual Connection
 * @param numFilas int
 * @param numIntentos int
 * @return ResulSet
 * @throws SQLException
 */
	public ResultSet getRenotificaciones(Connection conexionActual, int numFilas, int numIntentos)
	throws SQLException	{
		ResultSet rs = null;
		try {
			strErrorBD = "";
			String strSql;
	
			strSql  = "SELECT * FROM Icc_Renotificaciones_To ";
			strSql += "WHERE contador <  ? ";
			strSql += "  AND ROWNUM   <= ? ";	
			
			prepareStmt = conexionActual.prepareStatement(strSql);
			prepareStmt.setInt( 1,numIntentos);
			prepareStmt.setInt( 2,numFilas);
			rs = prepareStmt.executeQuery();
			
			if (rs.next()) {
				return(rs);
			} else {
				strErrorBD = "NOT_FOUND";
				cierraCursor(rs,prepareStmt);
				return(null); 
			}
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,prepareStmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En Lectura de Renotificaciones");
			//strErrorBD = e.getMessage();
			log.error("StackTrace:",e);
			cierraCursor(rs,prepareStmt);
			return(null);
		}
	}
	
 /**
 * Method putNotificacion
 * Inserta una renotificación  
 * @param conexionActual Connection
 * @param numOS long
 * @param strNotificacion String
 * @return boolean
 * @throws SQLException
 */
	public boolean putRenotificacion(Connection conexionActual, int numOS, String strNotificacion) 
	throws SQLException {
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
			String strSql;

/*			strSql  = "SELECT * FROM Icc_Renotificaciones_To ";
			strSql += "WHERE Os =  ? ";
			stmt = conexionActual.prepareStatement(strSql);
			stmt.setInt( 1,numOS);
			rs = stmt.executeQuery();
			if (rs.next()) {
				cierraCursor(rs,stmt);
				return(true);
			}*/ 
//---->>> Transacciones con la BD, Llama al formato del procedure
			strSql = "INSERT INTO Icc_Renotificaciones_To (";
			strSql += "Os, Mensaje, Estado, Contador) ";
			strSql += "VALUES (?,?,0,0)";
			stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
			stmt.setLong  ( 1,numOS);
			stmt.setString( 2,strNotificacion);
			
//--->>> Termina la transacción
			int reg = stmt.executeUpdate();
			conexionActual.commit();
			cierraCursor(rs,stmt);
			return(true);			
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			if (e.getMessage().indexOf("ORA-00001") > -1 ) return(true);
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- En insersión de la Renotificación: [" + numOS + "][" + strNotificacion + "]");
			//strErrorBD = e.getMessage();
			log.error("StackTrace:",e);
			return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
	}

/**
* Method setRenotificacion
* Actualiza una renotificación como no procesada. Incremeta el contador de 
* Intentos.  
* @param conexionActual Connection
* @param numOS long
* @return boolean
* @throws SQLException
*/
	public boolean setRenotificacion(Connection conexionActual, long numOS) 
   	throws SQLException {
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
		   	String strSql;
//---->>> Transacciones con la BD, Llama al formato del procedure
		   	strSql = "UPDATE Icc_Renotificaciones_To SET ";
		   	strSql += "Estado   = 1, Contador = Contador + 1 ";
		   	strSql += "WHERE OS = ?";
		   	stmt = conexionActual.prepareStatement(strSql);	
//---->>> Envía los parámetros
		   	stmt.setLong  ( 1,numOS);

//--->>> Termina la transacción
		   	int reg = stmt.executeUpdate();
		   	conexionActual.commit();
			cierraCursor(rs,stmt);	
		   	return(true);			
	   	} catch (Exception e) {
	   		strErrorBD = e.getMessage();
	   		if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
		   	log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] <<<--- la Actualización de la Renotificación: [" + numOS + "]");
		   	//strErrorBD = e.getMessage();
		   	log.error("StackTrace:",e);;
		   	return(false);
		} finally {
			cierraCursor(rs,stmt);
		}
   	}

/**
 * Method deleteRenotificacion
 * Elimina una Renotificación ya procesada
 * @param conexonActual Connection
 * @param numOS long
 * @return boolean
 * @throws SQLException
 */
	public boolean deleteRenotificacion(Connection conexionActual, long numOS)
	throws SQLException	{
		ResultSet rs = null;
		PreparedStatement stmt = null;
		try {
			strErrorBD = "";
			String strSql;
			strSql = "DELETE FROM Icc_Renotificaciones_To WHERE OS = ? ";
			stmt = conexionActual.prepareStatement(strSql);
			stmt.setLong(1,numOS);
			int salida = stmt.executeUpdate();
			conexionActual.commit();
			if (salida == 0) return(false); else return(true);
		} catch (Exception e) {
			strErrorBD = e.getMessage();
			if(RR.evaluaError(strErrorBD)){				
				log.fatal("Se ha terminado la conexión con la Base de datos");
				cierraCursor(rs,stmt);
				System.exit(-2);				
		  	}
			log.error("Error de ejecución Oracle: --->>> [" + e.getMessage() + "] En Borrado de la Renotificación [" + numOS + "]<<<---");
			//strErrorBD = e.getMessage();
			log.error("StackTrace:",e);
			return(false);
		} finally {
			cierraCursor(rs,prepareStmt);
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


