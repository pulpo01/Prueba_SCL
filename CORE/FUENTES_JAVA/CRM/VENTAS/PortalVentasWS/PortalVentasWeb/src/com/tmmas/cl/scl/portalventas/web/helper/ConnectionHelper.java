package com.tmmas.cl.scl.portalventas.web.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

import org.apache.log4j.Logger;

public class ConnectionHelper {

	private static Global global = Global.getInstance();

	private static final Logger logger = Logger.getLogger(ConnectionHelper.class);

	public static boolean validaConexionUsuario(String usuarioBD, String clave) {
		Connection con = null;
		boolean conexionValida = false;

		Properties props = new Properties();
		props.put("user", usuarioBD);
		props.put("password", clave);
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver").newInstance();
		}
		catch (ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		catch (IllegalAccessException ex) {
			ex.printStackTrace();
		}
		catch (InstantiationException ex) {
			ex.printStackTrace();
		}
		StringBuffer url = new StringBuffer();
		url.append("jdbc:oracle:thin:@");
		url.append(global.getValorExterno("bd.host"));
		url.append(":");
		url.append(global.getValorExterno("bd.port"));
		url.append(":");
		url.append(global.getValorExterno("bd.name"));

		try {
			logger.debug("usuario,url=" + usuarioBD + "," + url.toString());
			con = DriverManager.getConnection(url.toString(), props);
			if (con != null)
				conexionValida = true;
		}
		catch (Exception e) {
			logger.debug("Error al obtener una conexión");
		}
		return conexionValida;
	}
}
