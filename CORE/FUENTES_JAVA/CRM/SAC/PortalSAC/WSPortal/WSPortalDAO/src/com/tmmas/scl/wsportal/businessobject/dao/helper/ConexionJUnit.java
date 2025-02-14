package com.tmmas.scl.wsportal.businessobject.dao.helper;

import java.sql.Connection;
import java.sql.SQLException;

public class ConexionJUnit
{
	Connection conn = null;

	public Connection conexionBD() throws SQLException
	{
		return conn;
	}

	public Connection conexionBD(String url, String usuario, String password) throws SQLException
	{
		return conn;
	}

}
