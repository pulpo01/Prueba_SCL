package com.tmmas.scl.wsventaenlace.businessobject.dao.helper;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
 

public class JUnitConexion {
	Connection conn= null;
	private GlobalProperties global =  GlobalProperties.getInstance();
	
	 /**
	 * @return java.sql.Connection
	 * @throws SQLException
	 * 09/07/2008 12:32:28
	 */
	public Connection conexionBD() throws SQLException  { 
		 DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		 conn = DriverManager.getConnection(global.getValor("GE.Cadena.JDBC.GE"), global.getValor("GE.Usuario.JDBC.GE"), global.getValor("GE.Contrasenya.JDBC.GE"));       
		 return conn;
	 }
	
	public Connection conexionBD(String url, String usuario, String password) throws SQLException  { 
		 DriverManager.registerDriver (new oracle.jdbc.driver.OracleDriver());
		 conn = DriverManager.getConnection(url, usuario, password);       
		 return conn;
	 }
	 	
}
