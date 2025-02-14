/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongteservice.srv;
import java.text.SimpleDateFormat;
import java.util.Date;

public class Fecha {
	public static final String FORMATO_FECHA_ESPAÑOL = "dd-MM-yyyy"; 
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
	
	
}