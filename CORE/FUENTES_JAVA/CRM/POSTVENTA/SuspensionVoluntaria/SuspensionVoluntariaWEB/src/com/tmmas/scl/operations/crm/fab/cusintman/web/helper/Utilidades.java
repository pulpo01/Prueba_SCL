package com.tmmas.scl.operations.crm.fab.cusintman.web.helper;

import java.io.Serializable;
import com.tmmas.scl.operations.frmkooss.web.dto.TiposDescuentoDTO;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List; 
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ReglasSSDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PeriodoSuspencionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SuspensionAbonadoDTO;

public class Utilidades implements Serializable{

	// ----------------------------------------------------------------------------
	// Este metodo devuelve un blanco si el texto de parametro es nulo.
	// Usado en la capa de presentacion para evitarnos comparaciones.
	static public String devuelveBlanco(String texto)	{
		
		if (texto != null)
			if (!texto.equals("null")) return texto;
			else
				return "";
		
		return "";
	}	// devuelveBlanco
	
	// ----------------------------------------------------------------------------
	static public String eliminaCaracterdeCadena(char inVal,String cadena){
		String retValue;
		retValue=cadena.replace(inVal,' ');
		retValue=eliminaEspaciosCadena(retValue);
		return retValue;
	}
	
	static public String eliminaEspaciosCadena(String cadena){
		String retValue="";
		for (int x=0; x < cadena.length(); x++) {
			  if (cadena.charAt(x) != ' ')
				  retValue += cadena.charAt(x);
			}
		return retValue;
	}

	// ----------------------------------------------------------------------------
	
	// Convierte fecha dd/mm/yyyy a yyyy-mm-dd
	static public String formateaFecha(String cadena)	{
		
		try	{
			String datos[] = cadena.split("/");
			return datos[2] + "-" + datos[1] + "-" + datos[0];
		}
		catch (Exception ex){
			return "Error en conversión";
		}
		
	} // formateaFecha
	
//	---------------------------------------------------------------------------------------------------------------------------------	

	// Convierte fecha yyyy-mm-dd a dd/mm/yyyy 
	static public String formateaFecha2(String cadena)	{
		
		try	{
			String datos[] = cadena.split("-");
			return datos[2] + "/" + datos[1] + "/" + datos[0];
		}
		catch (Exception ex){
			return "Error en conversión";
		}
		
	} // formateaFecha
	
//	---------------------------------------------------------------------------------------------------------------------------------	

	// Convierte fecha dd/mm/yyyy a Date
	static public Date devuelveDate(String cadena)	{
		
		try	{
			String datos[] = cadena.split("/");
			return new Date(Integer.parseInt(datos[2])-1900, Integer.parseInt(datos[1])-1, Integer.parseInt(datos[0]));
		}
		catch (Exception ex){
			return null;
		}
		
	} // formateaFecha

//	---------------------------------------------------------------------------------------------------------------------------------
	
	static public String generaMatrizPeriodosSup(HttpServletRequest request)	{
		
		StringBuffer texto = new StringBuffer();
		
		// ---------------------------------------------------------------------------------------------
		// -- HGG 26/01/09
		// -- La nueva fecha de rehabilitacion no puede ser anterior al dia de hoy
		
		// Creo una variable con la fecha de hoy
	    Date fechaHoy =  new Date(Calendar.getInstance().getTime().getYear(), Calendar.getInstance().getTime().getMonth(),Calendar.getInstance().getTime().getDate());
	    SimpleDateFormat formato = new SimpleDateFormat("dd/MM/yyyy");

	    texto.append("\n");
	    texto.append("var fechaHoy = '" + formato.format(fechaHoy) + "';");
	    
    	// Creo el array de los tipos de descuentos manuales
    	PeriodoSuspencionAbonadoDTO[] tabla = (PeriodoSuspencionAbonadoDTO[])request.getAttribute("periodosSusp");
    	texto.append("\n");
    	texto.append("\n tablaPeriodosSusp = new Array(");

    	for (int desc=0; desc < tabla.length; desc++)	{
    		texto.append("\n ['"+ tabla[desc].getNumPeriodoSus() 
    							+ "','" + formateaFecha2(tabla[desc].getFechaInicio().toString()) 
    							+ "','" + formateaFecha2(tabla[desc].getFechaFin().toString())
    							+ "','" + tabla[desc].getDiasAcumulados()
    							+ "']");
        	// Si no es el ultimo elemento le agrego el separador para delimitar el elemento del array
        	if (desc < tabla.length-1) texto.append(",");
    	} // for

    	texto.append("\n );");
		
    	return texto.toString();
    	
	} // generaMatrizPeriodosSup

//	---------------------------------------------------------------------------------------------------------------------------------
	
}	// Utilidades
