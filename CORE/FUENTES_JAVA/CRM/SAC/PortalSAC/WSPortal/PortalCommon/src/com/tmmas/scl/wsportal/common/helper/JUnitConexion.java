package com.tmmas.scl.wsportal.common.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/07/2008 12:29:33     Santiago Ventura Infante      			Versión Inicial 
 * 
 *
 * 
 * ServiciosSCLFranquiciasFase2Common
 * @author Santiago Ventura
 * @version 1.0
 **/
public class JUnitConexion
{
	Connection conn = null;

	private GlobalProperties global = GlobalProperties.getInstance();

	/**
	 * @return java.sql.Connection
	 * @throws SQLException
	 * 09/07/2008 12:32:28
	 */
	public Connection conexionBD() throws SQLException
	{
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		conn = DriverManager.getConnection(global.getValor("GE.Cadena.JDBC.GE"), global.getValor("GE.Usuario.JDBC.GE"),
				global.getValor("GE.Contrasenya.JDBC.GE"));
		return conn;
	}

	public Connection conexionBD(String url, String usuario, String password) throws SQLException
	{
		DriverManager.registerDriver(new oracle.jdbc.driver.OracleDriver());
		conn = DriverManager.getConnection(url, usuario, password);
		return conn;
	}

}
