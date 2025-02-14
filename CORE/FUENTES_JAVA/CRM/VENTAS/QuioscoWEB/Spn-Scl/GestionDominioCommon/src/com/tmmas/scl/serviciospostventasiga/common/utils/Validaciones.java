package com.tmmas.scl.serviciospostventasiga.common.utils;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.serviciospostventasiga.common.helper.Global;

import junit.framework.Assert;



public class Validaciones
{

	private static Global global = Global.getInstance();
	
	public static final int VAL_OK = 1;
	public static final int VAL_ERROR_NULO = 2;
	public static final int VAL_ERROR_LARGO = 3;
	public static final int VAL_ERROR_FORMATO = 4;
	
	public static int esStringValido(String target, boolean nullable, int maxLength)
	{

		
		if (nullable)
		{
			//Es anulable
			if (target == null)
				return VAL_OK;
			
			if (target.length() == 0)
				return VAL_OK;
		}
		else
		{
			//No es anulable
			if (target.equals(""))
				return VAL_ERROR_NULO;
		}
		
		
		
		//No es nulo, se validan los largos.
		int length = target.length();
		
		if (length > maxLength)
			return VAL_ERROR_LARGO;
		
		
		
		return VAL_OK;
	}
	
	public static int esLongValido(Long target, boolean nullable, int maxLength)
	{
//		logger.debug("esLongValido: target = [" + target + "], nullable = " + nullable + ", minLength = " + minLength + ", maxLength = " + maxLength, nombreClase);
		
		if (nullable)
		{
			//Es anulable
			if (target == null)
				return VAL_OK;
			
			if (target.toString().length() == 0)
				return VAL_OK;
		}
		else
		{
			//No es anulable
			if (target == null)
				return VAL_ERROR_NULO;
		}
		

		
		//No es nulo, se validan los largos.
//		cadena = target.toString();
//		int length = cadena.length();

		if (target.toString().length() > maxLength)
			return VAL_ERROR_LARGO;		
		
		
		
		try {
			Long tmp = new Long(target.longValue());
		} catch (NumberFormatException nfe){
			 return VAL_ERROR_FORMATO;
		
		}
		
			
		return VAL_OK;
	}
	
	public static int esEnteroValido(Integer target, boolean nullable, int maxLength)
	{
//		logger.debug("esEnteroValido: target = [" + target + "], nullable = " + nullable + ", minLength = " + minLength + ", maxLength = " + maxLength, nombreClase);
		
//		int error;
//		
//		if ((error = esStringValido(target, nullable, maxLength)) != VAL_OK)
//			return error;
		

		try {
		if (target.intValue() > maxLength)
			return VAL_ERROR_LARGO;	
		} catch (Throwable t){
			return VAL_ERROR_NULO;
		}
		
		try
		{
			new Integer(target.intValue());
		}
		catch(Throwable t)
		{
			return VAL_ERROR_FORMATO;
		}
		
		return VAL_OK;
	}	
//
//	public static int esDecimalValido(String target, boolean nullable, int minLength, int maxLength)
//	{
////		logger.debug("esDecimalValido: target = [" + target + "], nullable = " + nullable + ", minLength = " + minLength + ", maxLength = " + maxLength, nombreClase);
//		
//		int error;
//		
//		if ((error = esStringValido(target, nullable, maxLength)) != VAL_OK)
//			return error;
//		
//		try
//		{
//			new Double(target);
//		}
//		catch(Throwable t)
//		{
//			return VAL_ERROR_FORMATO;
//		}
//		
//		return VAL_OK;
//	}
//	
//	public static int esFechaValida(String target, boolean nullable, String format)
//	{
////		logger.debug("esFechaValida: target = [" + target + "], nullable = " + nullable + ", format = [" + format + "]", nombreClase);
//		
//		if (nullable)
//		{
//			//Es anulable
//			//TODO: 02SEP2009 PF-PV-027 RQ Se soluciona problema de NullPointer de la variable target agregando el "else"
//			if (target == null)
//				return VAL_OK;
//			if (target.length() == 0)
//				return VAL_OK;
//		}
//		else
//		{
//			//No es anulable
//			if (target == null)
//				return VAL_ERROR_NULO;
//		}
//		
//		try
//		{
//			SimpleDateFormat sdf = new SimpleDateFormat(format);
//			//TODO: 02SEP2009 RQ/AZ Se valida de forma estricta
//			sdf.setLenient(false);
//			sdf.parse(target);
//		}
//		catch(Throwable t)
//		{
//			return VAL_ERROR_FORMATO;
//		}
//		
//		return VAL_OK;
//	}
	
	public static void check(int error, String nombreCampo) throws GeneralException
	{
//		logger.debug("check: nombreCampo = [" + nombreCampo + "]...", nombreClase);
		
		switch(error)
		{
			case Validaciones.VAL_ERROR_NULO:
				throw new GeneralException("ERR.0985", 10, global.getValor("ERR.0985") + ": " + nombreCampo);

			case Validaciones.VAL_ERROR_LARGO:
				throw new GeneralException("ERR.0986", 11, global.getValor("ERR.0986") + ": " + nombreCampo);

			case Validaciones.VAL_ERROR_FORMATO:
				throw new GeneralException("ERR.0987", 12, global.getValor("ERR.0987") + ": " + nombreCampo);
		}
	}
	
	/**
	 * Valida que el código de error (o codigos de error separados por coma) de la excepción sea diferente al código entregado para fallar.
	 * 
	 * @param e
	 * @param codigos
	 */
	public static void checkErrorJUnit(GeneralException e, String codigos)
	{
		if (codigos.indexOf(",") == -1)
		{
			Assert.assertTrue("Código de error obtenido [" + e.getCodigo() + "] debió ser [" + codigos + "]", e.getCodigo().equals(codigos));
		
			System.err.println("Código de error obtenido [" + e.getCodigo() + "] es correcto");
		}

		String arreglo[] = codigos.split(",");
		boolean notEqual = true;
		
		for(int i = 0; i < arreglo.length && notEqual; i++)
			notEqual = notEqual && !e.getCodigo().equals(arreglo[i].trim());
		
		if (notEqual)
			Assert.assertTrue("Código de error obtenido [" + e.getCodigo() + "] debió alguno de estos [" + codigos + "]", false);
		else
			System.err.println("Código de error obtenido [" + e.getCodigo() + "] es correcto");
	}	
}
