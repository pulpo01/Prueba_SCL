package com.tmmas.scl.wsventaenlace.helper;

import java.util.Calendar;

public class UtilesWeb {
	private static String []meses=new String[]{"Enero","Febrero","Marzo","Abril","Mayo","Junio",
			"Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"};
	public static String getFecha(){
		Calendar fecha = Calendar.getInstance();
		return fecha.get(Calendar.DATE)+" de "+meses[fecha.get(Calendar.MONTH)]+" de "+(fecha.get(Calendar.YEAR));
	}
}
