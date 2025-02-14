package com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.helper;

import java.io.Serializable;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;

public class Util implements Serializable{
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 771536908290798134L;

	static public String formatearNumeroMoneda(String numero, String numDecimal){
		numero=numero.replace(',','.');
		numero=numero==null||"".equals(numero)?"0.0":numero;
		//int contador=0;
		String pattern = "###,###,##0.";
		for (int j=0;j<Integer.parseInt(numDecimal);j++){
			pattern=pattern.concat("0");
		}
		    
	        
	        DecimalFormatSymbols dsf = new DecimalFormatSymbols();
	        dsf.setDecimalSeparator('.');
	        dsf.setGroupingSeparator(',');

	        
	        DecimalFormat weirdFormatter = new DecimalFormat(pattern, dsf);
	        weirdFormatter.setGroupingSize(3);
	        
	        numero = weirdFormatter.format(Float.parseFloat(numero));
	        

	        
	        return numero;
	        
	        
	        
	
	}

}
