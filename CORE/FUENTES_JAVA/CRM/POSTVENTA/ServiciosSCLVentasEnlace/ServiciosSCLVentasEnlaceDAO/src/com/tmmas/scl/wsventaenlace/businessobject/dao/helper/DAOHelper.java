package com.tmmas.scl.wsventaenlace.businessobject.dao.helper;

import java.io.Serializable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;

public class DAOHelper implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private static DAOHelper instance = null;

	public static synchronized DAOHelper getInstance() {
		if (instance == null) {
			instance = new DAOHelper();
		}
		return instance;
	}

	public boolean evaluaResultado(String codErrorAplicacion, int codError, String desError) throws ServicioVentasEnlaceException {
		boolean retorno = false;
		if (codError != 0) {
			throw new ServicioVentasEnlaceException(codErrorAplicacion, codError, desError);
		} else
			retorno = true;

		return retorno;
	}

	public String getPackageBD(String packageName, String procedureName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();

	}

	public String getFunctionBD(String packageName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName + "(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();

	}

	public boolean validaEnteros(String texto) {
		try {
			Long.parseLong(texto);

		} catch (NumberFormatException e) {
			return false;
		}
		return true;
	}

	public boolean validaEnterosconExpresionRegular(String texto) {
		Pattern p = Pattern.compile("[0-9]+");
		Matcher m = p.matcher(texto);
		boolean resultado = m.find();
		return resultado;

	}

}
