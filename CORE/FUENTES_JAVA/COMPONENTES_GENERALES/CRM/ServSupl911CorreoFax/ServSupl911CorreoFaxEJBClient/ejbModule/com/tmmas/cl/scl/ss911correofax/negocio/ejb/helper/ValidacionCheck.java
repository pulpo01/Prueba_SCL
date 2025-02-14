package com.tmmas.cl.scl.ss911correofax.negocio.ejb.helper;

import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class ValidacionCheck {
	
	
	public static void main (String[] args){
		
/*		System.out.println("es entero:::"+isNumberInt("3"));
		System.out.println("es entero:::"+isNumberInt("wedsdsdsd.@"));*/
		
		Calendar cal=Calendar.getInstance(Locale.getDefault());
		
		
		SimpleDateFormat sdf=new SimpleDateFormat("1976-02-09",Locale.getDefault());
		Pattern apattern=null;
		CharSequence cS="@juloee";
		Matcher match = apattern.matcher(cS );

		System.out.println(":::"+cal.getTime());
		/*DateFormatSymbols dfs= new DateFormatSymbols();
		for (int i=0;i<dfs.getAmPmStrings().length;i++)
		{
			System.out.println("::"+dfs.getAmPmStrings()[i]);
		}*/
		
		
	}
	
	public static boolean isNumberInt(String inValue)
	{
		boolean retValue = true;
		try
		{
			for (int i=0;i<inValue.length();i++)
			{
				if (!Character.isDigit(inValue.charAt(i)))
				{
					retValue=false;
					break;
				}
			}
		}
		catch(Exception e){
			retValue=false;
		}
		return retValue;
	}
	public static boolean isNumberDecimal(String inValue)
	{
		boolean retValue = false;
		
		
		int posDecimalSeparator=0;
		int contDecimalSeparador=0;
		DecimalFormat df = (DecimalFormat)NumberFormat.getInstance();
		DecimalFormatSymbols dfs=df.getDecimalFormatSymbols();
		
		try
		{
			posDecimalSeparator=inValue.indexOf(String.valueOf(dfs.getDecimalSeparator()));
			posDecimalSeparator=posDecimalSeparator==(inValue.length()-1)?0:posDecimalSeparator;
			if (posDecimalSeparator>0){
				
				for (int i=0;i<inValue.length();i++)
				{
					if (!Character.isDigit(inValue.charAt(i)))
					{
						if (dfs.getDecimalSeparator()!=inValue.charAt(i))
						{
							posDecimalSeparator=0;
							break;
						}
						contDecimalSeparador++;
					}
				}
			}
			retValue=(contDecimalSeparador==1)?true:false;
		}
		catch(Exception e)
		{
			retValue=false;
		}
		return retValue;
	}
	
	public static boolean isFechaValida(String pattern,String fecha)
	{
		boolean retValue=true;
		String[] DATE_PATTERNS={"dd-MM-yyyy","dd/MM/yyyy"};
		try{
			
			
		}
		catch(Exception e){
			
		}
		return retValue;
	}

}
