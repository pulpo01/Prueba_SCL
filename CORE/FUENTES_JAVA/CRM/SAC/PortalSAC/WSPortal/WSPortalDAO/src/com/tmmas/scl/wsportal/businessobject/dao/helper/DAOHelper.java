package com.tmmas.scl.wsportal.businessobject.dao.helper;

import java.io.Serializable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class DAOHelper implements Serializable
{
	private static final long serialVersionUID = -676299474043374169L;

	private static DAOHelper instance = null;

	public static synchronized DAOHelper getInstance()
	{
		if (instance == null)
		{
			instance = new DAOHelper();
		}
		return instance;
	}

	/**
	 * Genera cadena de conexión a procedimiento de base de datos Oracle
	 * @param String packageName
	 * @param String procedureName
	 * @param int paramCount
	 * @return String
	 */

	public String getPackageBD(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++)
		{
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();
	}

	/**
	 * Genera cadena de conexión a procedimiento de base de datos Oracle
	 * @param String packageName
	 * @param String procedureName
	 * @param int paramCount
	 * @return String
	 */

	public String getFunctionBD(String packageName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call " + packageName + "(");
		for (int n = 1; n <= paramCount; n++)
		{
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();

	}

	/**
	 * 
	 * @param texto
	 * @return
	 */

	public boolean validaEnteros(String texto)
	{
		try
		{
			Long.parseLong(texto);

		}
		catch (NumberFormatException e)
		{
			return false;
		}
		return true;
	}

	/**
	 * 
	 * @param texto
	 * @return
	 */

	public boolean validaEnterosconExpresionRegular(String texto)
	{
		Pattern p = Pattern.compile("[0-9]+");
		Matcher m = p.matcher(texto);
		boolean resultado = m.find();
		return resultado;

	}

}
