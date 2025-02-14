package com.tmmas.gte.integraciongteservice.helper;

import java.text.SimpleDateFormat;
import java.util.Date;

public class Util {
	/*
	 * Autor: Daniel Jara O.
	 * Modificado por JDMQ
	 * */
	public static final String FORMATO_FECHA_INGLES = "yyyyMMdd";
	public static final String FORMATO_FECHA_ESPAÑOL = "dd-MM-yyyy";
	public static final String FORMATO_FECHA_HORA_GUION_PUNTO = "dd-MM-yyyy HH:mm:ss";	
	
	public double parteDecimal(double valor, int parteEntera , int cantDecimales){
		double ParteTotalDecimal = 0;
		try {
        	 // Entrega la parte total decimal de un campo.
			ParteTotalDecimal = (valor-parteEntera);
			ParteTotalDecimal = Math.round(ParteTotalDecimal*Math.pow(10,cantDecimales))/Math.pow(10,cantDecimales);
		} catch (Exception e) {
			ParteTotalDecimal = 0;
		}
		return ParteTotalDecimal;
	}
	public String fechaDateTOfechaString(String formato,Date fecha){
	        try {
	    		SimpleDateFormat format = new SimpleDateFormat(formato);
	    		return format.format(fecha);
	           }
	        catch (Exception e) {
	             System.out.println(e.getMessage());
	             System.out.println("Fecha incorrecta");
	             return null;
	       }
		}
	 public String fechaStringTOfechaString(String formato, String fecha){
			SimpleDateFormat format = new SimpleDateFormat(formato);
			Date date = null;
			
			if(fecha.length() == 10){
				int dia = Integer.parseInt(fecha.substring(0,2));
				int mes = Integer.parseInt(fecha.substring(3,5))-1;
				int anyo = Integer.parseInt(fecha.substring(6,10))-1900;
				date = new Date(anyo, mes, dia);
			}
			String fechaSalida =format.format(date); 
			return fechaSalida;
		}
}
