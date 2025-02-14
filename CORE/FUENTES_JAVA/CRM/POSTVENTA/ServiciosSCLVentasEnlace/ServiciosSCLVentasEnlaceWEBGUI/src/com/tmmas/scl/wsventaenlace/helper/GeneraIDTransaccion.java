/**
 * 
 */
package com.tmmas.scl.wsventaenlace.helper;

import java.io.Serializable;
import java.util.Calendar;

/**
 * @author mwn90351
 *
 */
public class GeneraIDTransaccion implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	

	/**
	 * 
	 */
	public GeneraIDTransaccion() {
		// TODO Auto-generated constructor stub
		
	}


	/**
	 * Genera el id de transaccion asociado al objeto que se quiere almacenar temporalmente
	 * @return long the iDTransaccion
	 */
	public static synchronized long getIDTransaccion() {
		Calendar cal = Calendar.getInstance();
		long iDTransaccion = cal.getTimeInMillis();
		return iDTransaccion;
	}


}
