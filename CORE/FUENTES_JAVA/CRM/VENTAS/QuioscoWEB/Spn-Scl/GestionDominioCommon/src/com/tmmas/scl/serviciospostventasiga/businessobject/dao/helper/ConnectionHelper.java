package com.tmmas.scl.serviciospostventasiga.businessobject.dao.helper;

import java.io.Serializable;

public class ConnectionHelper implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static ConnectionHelper instance = null;

	public static synchronized ConnectionHelper getInstance() {
		if (instance == null) {
			instance = new ConnectionHelper();
		}
		return instance;
	}

	/**
	 * Genera cadena de conexión a procedimiento de base de datos Oracle
	 * @param String nombrePackage
	 * @param String nombreProcedimiento
	 * @param int cantParametros
	 * @return String
	 */
	public String getPackageBD(String nombrePackage, String nombreProcedimiento, int cantParametros){
		StringBuffer call = new StringBuffer();
		String cadena = "";
		int cantidad;

		if (nombrePackage!=null){
			cadena = nombrePackage + ".";
		}
		cadena = cadena + nombreProcedimiento + "(";
		for(cantidad=1;cantidad<=cantParametros;cantidad++){
			cadena = cadena + "?";
			if(cantidad!=cantParametros)
			{
				cadena = cadena + ",";
			}
		}
		cadena = cadena + "); ";
		call.append("DECLARE ");
		call.append("BEGIN ");
		call.append(cadena);
		call.append("END; ");
		return call.toString();

	}


	/**
	 * Genera cadena de conexión a procedimiento de base de datos Oracle
	 * @param String nombrePackage
	 * @param int cantParametros
	 * @return String
	 */
	public String getFunctionBD(String nombrePackage,int cantParametros)
	{
		StringBuffer sb = new StringBuffer("{call "+nombrePackage+ "(");
		for (int n = 1; n <= cantParametros; n++) {
			sb.append("?");
			if (n < cantParametros) sb.append(",");
		}
		return sb.append(")}").toString();

	}



}
