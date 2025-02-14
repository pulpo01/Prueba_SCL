package com.tmmas.scl.wsventaenlace.common.utils;

import java.text.SimpleDateFormat;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;

public class Validaciones
{
	private static final LoggerHelper logger = LoggerHelper.getInstance();
	private static String nombreClase = Validaciones.class.getName();
	
	public static final int VAL_OK = 1;
	public static final int VAL_ERROR_NULO = 2;
	public static final int VAL_ERROR_LARGO = 3;
	public static final int VAL_ERROR_FORMATO = 4;
	
	public static int esStringValido(String target, boolean nullable, int minLength, int maxLength)
	{
		logger.info("target = [" + target + "], nullable = " + nullable + ", minLength = " + minLength + ", maxLength = " + maxLength, nombreClase);
		
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
			if (target == null || target.trim().length()==0)
				return VAL_ERROR_NULO;
		}
		
		//No es nulo, se validan los largos.
		int length = target.length();
		
		if (length < minLength || length > maxLength)
			return VAL_ERROR_LARGO;		
			
		return VAL_OK;
	}
	
	public static int esEnteroValido(String target, boolean nullable, int minLength, int maxLength)
	{
		int error;
		
		if ((error = esStringValido(target, nullable, minLength, maxLength)) != VAL_OK)
			return error;
		
		try
		{
			new Long(target);
		}
		catch(Throwable t)
		{
			return VAL_ERROR_FORMATO;
		}
		
		return VAL_OK;
	}	

	public static int esDecimalValido(String target, boolean nullable, int minLength, int maxLength)
	{
		int error;
		
		if ((error = esStringValido(target, nullable, minLength, maxLength)) != VAL_OK)
			return error;
		
		try
		{
			new Double(target);
		}
		catch(Throwable t)
		{
			return VAL_ERROR_FORMATO;
		}
		
		return VAL_OK;
	}
	
	public static int esFechaValida(String target, boolean nullable, String format)
	{
		int error = esStringValido(target, nullable, format.length(), format.length());
		
		if (error != VAL_OK)
			return error;
		
		if (nullable && (target == null || target.length() == 0))
			return VAL_OK;
		
		try
		{
			SimpleDateFormat sdf = new SimpleDateFormat(format);
			
			sdf.parse(target);
		}
		catch(Throwable t)
		{
			return VAL_ERROR_FORMATO;
		}
		
		return VAL_OK;
	}
	
	public static void check(int error, String nombreCampo) throws ServicioVentasEnlaceException
	{
		GlobalProperties global = GlobalProperties.getInstance();
		
		switch(error)
		{
			case Validaciones.VAL_ERROR_NULO:
				throw new ServicioVentasEnlaceException("ERR.0014", 1, global.getValor("ERR.0014") + ": " + nombreCampo);

			case Validaciones.VAL_ERROR_LARGO:
				throw new ServicioVentasEnlaceException("ERR.0007", 1, global.getValor("ERR.0007") + ": " + nombreCampo);

			case Validaciones.VAL_ERROR_FORMATO:
				throw new ServicioVentasEnlaceException("ERR.0015", 1, global.getValor("ERR.0015") + ": " + nombreCampo);
		}
	}	
	
	public static void main(String args[])
	{
		System.out.println(Validaciones.esFechaValida("", true, "dd/MM/yyyy"));
		System.out.println(Validaciones.esFechaValida("12/12/2005", true, "dd/MM/yyyy"));
		System.out.println(Validaciones.esFechaValida("12/XX/2005", true, "dd/MM/yyyy"));
		System.out.println(Validaciones.esFechaValida("12/12/205", true, "dd/MM/yyyy"));
	}
}
