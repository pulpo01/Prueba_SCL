package com.tmmas.scl.wsseguridad.validacion;


import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.GregorianCalendar;
import java.util.StringTokenizer;

/*
 * Class: DateUtils
 * Descripción: Valida que una fecha en un String tenga un formato y sus datos esten validos
 * Fecha: 02/07/2010
 * Developer: Gabriel Moraga L. 
 */

public class DateUtils {

	
	/*
	 * Class: DateUtils
	 * Descripción: Valida que una fecha en un String tenga un formato y sus datos esten validos
	 * Return: boolean
	 * Fecha: 02/07/2010
	 * Developer: Gabriel Moraga L. 
	 */
	
	public  boolean isValidDateStr(String date) {

		try {

			//Formato
			SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");

			sdf.setLenient(false);
			sdf.parse(date);

			int anio = 0;
			int mes = 0;
			int dia = 0;

			//Se separa las fechas
			StringTokenizer token =  new StringTokenizer(date,"/");

			//Se asigna las fechas
			while (token.hasMoreTokens()) {
				dia = Integer.parseInt(token.nextToken());
				mes = Integer.parseInt(token.nextToken());
				anio = Integer.parseInt(token.nextToken());
			}

			GregorianCalendar calendar = new GregorianCalendar();
			//Valida si un año es bisiesto
			if (calendar.isLeapYear(anio)){
				//System.out.println("El año es bisiesto");
				return valMesDia(dia, mes, anio, 0);
			}else{
				//System.out.println("El año no es bisiesto");
				return valMesDia(dia, mes, anio, 1);
			}
			
		} catch (ParseException e) {
			//System.out.println("ParseException: "+e);
			//e.printStackTrace();
			return false;
		} catch (IllegalArgumentException e) {
			//System.out.println("IllegalArgumentException: "+e);
			//e.printStackTrace();
			return false;
		} catch (Exception e){
			//System.out.println("IllegalArgumentException: "+e);
			//e.printStackTrace();
			return false;
		}

	}

	public Boolean validaFechaInicioAndFin(String fechaInicio, String fechaFin){
		
		Boolean fechaOk = true;
		
		try {
			
			SimpleDate fechaInicioVigencia = new SimpleDate(fechaInicio,"yyyy/MM/dd");
			SimpleDate fechaFinVigencia = new SimpleDate(fechaFin,"yyyy/MM/dd");		

			Long codigoErrorFecha = fechaFinVigencia.lessThan(fechaInicioVigencia)? new Long(2) : new Long(3);
					
			if( 2 == codigoErrorFecha.longValue() ){
				//La fecha fin de vigencia debe ser igual o superior a la fecha inicio de vigencia
				fechaOk = false;	
			}else if( 3 == codigoErrorFecha.longValue()) {
				fechaOk = true;
			}
			
		} catch (Exception e) {
			fechaOk = false;										;			
			
		}

		return fechaOk;
		
	}
	
	public Boolean valFecIniAndFinCompl(String fechaInicio, String fechaFin){
		
		Boolean fechaOk = true;
		
		try {
			
			SimpleDate fechaInicioVigencia = new SimpleDate(fechaInicio,"yyyy/MM/dd hh:mm:ss");
			SimpleDate fechaFinVigencia = new SimpleDate(fechaFin,"yyyy/MM/dd hh:mm:ss");		

			Long codigoErrorFecha = fechaFinVigencia.lessThan(fechaInicioVigencia)? new Long(2) : new Long(3);
					
			if( 2 == codigoErrorFecha.longValue() ){
				//La fecha fin de vigencia debe ser igual o superior a la fecha inicio de vigencia
				fechaOk = false;	
			}else if( 3 == codigoErrorFecha.longValue()) {
				fechaOk = true;
			}
			
		} catch (Exception e) {
			fechaOk = false;										;			
			
		}

		return fechaOk;
		
	}
	
	private boolean valMesDia(int dia, int mes, int anio, int flag){

		if( 0 >= mes && 13 <= mes ){
			return false;
		}
        //      						   ENE  FEB  MAR  ABR  MAY  JUN  JUL  AGO  SEP  OCT  NOV  DIC
		String[] arrayDias =  new String[]{"31","28","31","30","31","30","31","31","30","31","30","31"};

		int diaInterno = 0;
		if( 2 == mes && 0 == flag ){
			diaInterno = 29;
		}else{
			diaInterno = Integer.parseInt(arrayDias[mes-1]);
		}
		if( 0 >= dia && diaInterno < dia ){
			return false;
		}

		return true;

	}

}


