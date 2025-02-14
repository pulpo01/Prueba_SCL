package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.util;

public class Utilitarios {
	
	public static boolean isNumber(String inValue ){
		boolean retValue=false;
		try{
			Float.valueOf(inValue);
			retValue=true;
			
		}catch (NumberFormatException e){
			//Error e.printStackTrace();
		}
		return retValue;
	}

}
