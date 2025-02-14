package com.tmmas.scl.wsseguridad.validacion;

import java.util.StringTokenizer;

/*
 * Class: Validacion
 * Descripción: Validaciones para los datos de entrada de los Web Services
 * Fecha: 27/08/2010
 * Developer: Gabriel Moraga L. 
 */

public class Validacion {
	
	
	public Boolean datosNotNull(Object dato){
		
		if(null != dato){
			return true;
		}
		
		return false;
	}
	
	public Boolean validaNumero(Object numero){
		
		if(null != numero){
			
			try{
				Long.valueOf(numero.toString());
			}catch (NumberFormatException e) {
				return false;
			}catch (Exception e) {
				return false;
			}
			
			return true;
		}
		
		return false;
	}

	public Boolean validaFormatoFecha(String fecha){
		
		DateUtils dateUtils = new DateUtils();
		
		if( dateUtils.isValidDateStr(fecha) ){
			return true;
		}
		
		return false;
	}
	
	public Boolean valForFecCompl(String fecha){
		
		DateUtils dateUtils = new DateUtils();
   
		String anio = "";
		String mes = "";
		String dia = "";
		
		try{
			
			//Se separa las fechas
			StringTokenizer token =  new StringTokenizer(fecha,"/");

			//Se asigna las fechas
			while (token.hasMoreTokens()) {
				dia = token.nextToken();
				mes = token.nextToken();
				anio = token.nextToken();
			}
			
			
			anio = anio.substring(0,3);
		
		}catch (Exception e){
			//System.out.println("IllegalArgumentException: "+e);
			//e.printStackTrace();
			return false;
		}
		
		StringBuffer strBuff = new StringBuffer();
		
		strBuff.append(dia);
		strBuff.append("/");
		strBuff.append(mes);
		strBuff.append("/");
		strBuff.append(anio);
		
		if( dateUtils.isValidDateStr(strBuff.toString())){
			return true;
		}
		
		return false;
	}
	
	public Boolean validaFechaIniFin(String fechaInicio, String fechaFin ){
		
		DateUtils dateUtils = new DateUtils();
		
		if( dateUtils.validaFechaInicioAndFin(fechaInicio, fechaFin) ){
			return true;
		}
		
		return false;
	}
	
	public Boolean valFecIniFinCompl(String fechaInicio, String fechaFin ){
		
		DateUtils dateUtils = new DateUtils();
		
		if( dateUtils.valFecIniAndFinCompl(fechaInicio, fechaFin) ){
			return true;
		}
		
		return false;
	}
	
}
