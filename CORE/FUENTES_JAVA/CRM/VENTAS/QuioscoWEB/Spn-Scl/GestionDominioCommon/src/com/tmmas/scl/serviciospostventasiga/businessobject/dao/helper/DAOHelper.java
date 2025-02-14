package com.tmmas.scl.serviciospostventasiga.businessobject.dao.helper;

import java.io.Serializable;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.tmmas.cl.framework.exception.GeneralException;


public class DAOHelper implements Serializable{
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
	
	/**
	 * Evalua el error devuelto por la BD y si existe algún error retorna una excepción. 
	 * @param String codErrorAplicacion
	 * @param int codError
	 * @param String desError
	 * @return boolean retorno
	 * @throws ServiciosWebOOSSException
	 */
	
	public boolean evaluaResultado(String codErrorAplicacion,int codError, String mensajeDB, int evento, String desError) 
	throws GeneralException{
		boolean retorno = true;
		if (codError!=0){
			System.out.println("Error desde base de datos CODIGO ["+codError+"], MENSAJE ["+mensajeDB+"], EVENTO ["+evento+"]");
			throw new GeneralException(codErrorAplicacion,codError,desError);
		}
		return retorno;
	}	
	/**
	 * Evalua el error devuelto por la BD y si existe algun error retorna una excepcion
	 * @param codErrorAplicacion
	 * @param codError
	 * @param mensajeDB
	 * @param evento
	 * @param desError
	 * @return
	 * @throws ServiciosWebOOSSException
	 */
	public boolean evaluaResultado(String codErrorAplicacion,String codError, String mensajeDB, int evento, String desError) 
	throws GeneralException{
		boolean retorno = true;
		if (codError.equals(" ") && mensajeDB.equals(" ")){
			//System.out.println("Error desde base de datos CODIGO ["+codError+"], MENSAJE ["+mensajeDB+"], EVENTO ["+evento+"]");
			//throw new ServiciosWebOOSSException(codErrorAplicacion,codError,desError);
		}
		else{
			if(evento == 1){
				throw new GeneralException(codErrorAplicacion,512,desError);
			}else if(evento == 2){
				throw new GeneralException(codErrorAplicacion,511,desError);
			}else{
				throw new GeneralException(codErrorAplicacion,932,desError);
			}
		}
		return retorno;
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
		//System.out.println("INVOCACION A ["+packageName+","+procedureName+"]");
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
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
	
	
	public String getFunctionBD(String packageName,int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+ "(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	
	}
	
	/**
	 * 
	 * @param texto
	 * @return
	 */
	
	public boolean validaEnteros(String texto) {
		try {
            Long.parseLong(texto);
        
        } catch (NumberFormatException e) {
            return false;
        }
        return true;
	}	
	
	/**
	 * 
	 * @param texto
	 * @return
	 */
	
	public boolean validaEnterosconExpresionRegular(String texto) {
		Pattern p = Pattern.compile("[0-9]+");
	    Matcher m = p.matcher(texto);
	    boolean resultado = m.find();
	    return resultado;
	}
}
