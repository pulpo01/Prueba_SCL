package com.tmmas.gte.integraciongte.ejb.helper;



import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

public class Fecha {
	
	 public static final String FORMATO_FECHA_INGLES = "yyyyMMdd"; 
	 public static final String FORMATO_FECHA_ESPAÑOL = "dd-MM-yyyy"; 
	 
	 public boolean esFecha(String valor)
	    {
	        boolean flag1;
	        try
	        {
	            SimpleDateFormat sdf = new SimpleDateFormat(Fecha.FORMATO_FECHA_ESPAÑOL);
	            sdf.setLenient(false);
	            sdf.parse(valor);
	            boolean flag = true;
	            return flag;
	        }
	        catch(Exception e)
	        {
	            flag1 = false;
	        }
	        return flag1;
	    }
	 public  boolean fechaAnterior(String valor, String comparacion)
	    {
	        boolean flag;
	        try
	        {
	            GregorianCalendar calValor = new GregorianCalendar();
	            calValor.setTime((new SimpleDateFormat("dd-MM-yyyy")).parse(valor));
	            GregorianCalendar calComparacion = new GregorianCalendar();
	            calComparacion.setTime((new SimpleDateFormat("dd-MM-yyyy")).parse(comparacion));
	            if(calValor.before(calComparacion))
	            {
	                boolean flag1 = true;
	                return flag1;
	            } else
	            {
	                boolean flag2 = false;
	                return flag2;
	            }
	        }
	        catch(Exception e)
	        {
	            flag = false;
	        }
	        return flag;
	    }
     public  boolean fechaPosterior(String valor, String comparacion){
	   boolean flag;
	        try
	        {
	            GregorianCalendar calValor = new GregorianCalendar();
	            calValor.setTime((new SimpleDateFormat("dd-MM-yyyy")).parse(valor));
	            GregorianCalendar calComparacion = new GregorianCalendar();
	            calComparacion.setTime((new SimpleDateFormat("dd-MM-yyyy")).parse(comparacion));
	            if(calValor.after(calComparacion))
	            {
	                boolean flag1 = true;
	                return flag1;
	            } else
	            {
	                boolean flag2 = false;
	                return flag2;
	            }
	        }
	        catch(Exception e)
	        {
	            flag = false;
	        }
	        return flag;
	    }
	 public boolean validaFecha(String formato,String fecha){
            try {
                 SimpleDateFormat formatoFecha = new SimpleDateFormat(formato);
                 formatoFecha.setLenient(false);
                 Date dt2 = formatoFecha.parse(fecha);
                 System.out.println(dt2.toString());
                 return true; 
               }
            catch (ParseException e) {
                 System.out.println(e.getMessage());
                 return false;
            }
            catch (IllegalArgumentException e) {
                 System.out.println("Fecha incorrecta");
                 return false;
           }
    }
	 public Date fechaStringTOfechaDate(String formato,String fecha){
		   Date fechaAux = null; 
		   try {
            	 SimpleDateFormat formatoDelTexto = new SimpleDateFormat(formato);
             	 fechaAux = formatoDelTexto.parse(fecha);
             	 System.out.println(fecha.toString());   
                 return fechaAux; 
               }
            catch (ParseException e) {
                 System.out.println(e.getMessage());
                 return null;
            }
            catch (IllegalArgumentException e) {
                 System.out.println("Fecha incorrecta");
                 return null;
           }
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
     public static void main(String[] args) throws Exception{ 
		Fecha fecha = new Fecha(); 
		Date prueba = fecha.fechaStringTOfechaDate(Fecha.FORMATO_FECHA_INGLES, "2009-05-04");
		if(prueba != null){
			System.out.println(prueba.toString());
			System.out.println(prueba.getTime());
			String fechaString = fecha.fechaStringTOfechaString(Fecha.FORMATO_FECHA_INGLES, "04-08-2009");
			System.out.println("2 :" + fechaString);
			
		}else{
			System.out.println("se cayo");
		}
	}
}
