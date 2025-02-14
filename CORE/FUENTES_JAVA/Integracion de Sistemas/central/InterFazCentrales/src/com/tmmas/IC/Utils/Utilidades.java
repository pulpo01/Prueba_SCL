package com.tmmas.IC.Utils;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
/**
 * @author mwt00178
 * @version $Revision$
 */
public class Utilidades {
	public static String getGlsDia = "";
	/**
	 * Constructor for Utilidades
	 */
	public Utilidades(){};

//------------------------------------------------------------------------------------------//
//  Metodo para rescatar la hora actual formateada                                          //
//------------------------------------------------------------------------------------------//
	/**
	 * Method ahora
	 * @return String
	 */
	public static String ahora() {
		SimpleDateFormat fFecha = new SimpleDateFormat("dd'/'MM'/'yyyy HH:mm:ss,S");
		return(fFecha.format(new java.util.Date() ));
	}

//------------------------------------------------------------------------------------------//
//Metodo para formatear un numero con ceros a la izquierda                                //
//------------------------------------------------------------------------------------------//
  /**
   * Method formatNum
   * @param numero int
   * @param formato String
   * @return String
   */
	public static String formatNum(int numero, String formato) {
		DecimalFormat myFormatter = new DecimalFormat(formato);
		String output = myFormatter.format(numero);
		return(output);
	}
	public static int diaSemana(int dia, int mes, int ano){
		try {
			int calculo;
			if (mes < 3) {
				mes += 12;
				ano --;
			}
			calculo = (dia + 13 * (mes + 1) / 5) + (5 * ano / 4 - ano / 100 + ano / 400);
			int numDia = calculo % 7;
			numDia += 1;
			if (numDia == 7) numDia = 0;
			switch (numDia) { 
			case 1:
				getGlsDia = "Sábado";				
				return(6);
			case 2:
				getGlsDia = "Domingo"; 
				return(7);
			case 3:
				getGlsDia = "Lunes";
				return(1);
			case 4:
				getGlsDia = "Martes";
				return(2);
			case 5:
				getGlsDia = "Miércoles";
				return(3);
			case 6:
				getGlsDia = "Jueves";
				return(4);
			case 0:
				getGlsDia = "Viernes";
				return(5);
			}
			return(-1);
		} catch(Exception e){
			return(-1);		
		}
	} 

/**
 * Metodo para validar si un texto es un numero
 * Method validaNumerico
 * @param numero String
 * @return boolean
 */
	public static boolean validaNumerico(String numero) {
		try {
			Integer.parseInt( new String( numero ) );
			return(true);
		} catch (NumberFormatException e3) {
			return(false);
		}
	}
	
}

//******************************************************************************************
//** Información de Versionado *************************************************************
//******************************************************************************************
//** Pieza                                               : 
//**  %ARCHIVE%
//** Identificador en PVCS                               : 
//**  %PID%
//** Producto                                            : 
//**  %PP%
//** Revisión                                            : 
//**  %PR%
//** Autor de la Revisión                                :          
//**  %AUTHOR%
//** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : 
//**  %PS%
//** Fecha de Creación de la Revisión                    : 
//**  %DATE% 
//** Worksets ******************************************************************************
//** %PIRW%
//** Historia ******************************************************************************
//** %PL%
//******************************************************************************************
