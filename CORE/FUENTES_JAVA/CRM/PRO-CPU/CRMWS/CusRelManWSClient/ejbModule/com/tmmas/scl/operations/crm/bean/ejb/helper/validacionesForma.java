package com.tmmas.scl.operations.crm.bean.ejb.helper;

public class validacionesForma {
	
	public static boolean isNumberInt(String cadena)
	{
		boolean retValue;
		try{
			retValue=true;
			cadena=cadena==null||"".equals(cadena)?"E":cadena;
			Character character;
			for (int i=0;i<cadena.length();i++)
			{
				character= new Character(cadena.charAt(i));
				if (!character.isDigit(character.charValue()))
				{
					retValue=false;
					break;
				}
			}
		}
		catch(Exception e){
			retValue=false;
			e.printStackTrace();
			
		}
		
		return retValue;
	}

}
