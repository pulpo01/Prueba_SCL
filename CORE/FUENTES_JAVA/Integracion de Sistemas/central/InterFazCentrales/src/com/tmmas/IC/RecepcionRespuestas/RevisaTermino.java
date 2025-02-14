package com.tmmas.IC.RecepcionRespuestas;

import org.apache.log4j.Logger;

import com.tmmas.IC.Utils.ClassServerSocket;
import com.tmmas.SCH.Interfaz.JavaSched;

/**
 *
 * @author mwt00178
 * @version $Revision$
 */
public class RevisaTermino extends Thread { 
	/**
	 * Field mSocket
	 */
	private ClassServerSocket mSocket = null;	
	/**
	 * Field mJSched
	 */
	private JavaSched mJSched;

	private static Logger log = Logger.getLogger(RevisaTermino.class.getName());
	
	/**
	 * Constructor for RevisaTermino
	 * @param pSocket ClassServerSocket
	 * @param pJSched JavaSched
	 */
	
	public RevisaTermino(ClassServerSocket pSocket, JavaSched pJSched) {
		super("RevisaTermino");		
		mSocket = pSocket;
		mJSched = pJSched;
	}
//------------------------------------------------------------------------------------------//
//  Funci�n Princiapal									    								//	
//------------------------------------------------------------------------------------------//
	/**
 * Method run
 * @see java.lang.Runnable#run()
 */
public void run() {
		try {
			while (true) {
				if (JavaSched.SENAL_STOP == JavaSched.ACTIVA) {
					mSocket.close();
					return;
				}
				espera();
			}
		} catch (Exception e) {//(IOException e) {
			    log.error("Error en Socket Seguro : --->>> [" + e.getMessage() + "][" + e.hashCode() + "] <<<---");
		}
	}
//------------------------------------------------------------------------------------------//
//  Funci�n de Tiempo									    								//	
//------------------------------------------------------------------------------------------//
	/**
 * Method espera
 */
static void espera() {
		try {
			int intervaloCliente = 1000;
			Thread.sleep(intervaloCliente); 
		} 
		catch(Exception e) { 
		}
	}

}

//******************************************************************************************
//** Informaci�n de Versionado *************************************************************
//******************************************************************************************
//** Pieza                                               : 
//**  %ARCHIVE%
//** Identificador en PVCS                               : 
//**  %PID%
//** Producto                                            : 
//**  %PP%
//** Revisi�n                                            : 
//**  %PR%
//** Autor de la Revisi�n                                :          
//**  %AUTHOR%
//** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : 
//**  %PS%
//** Fecha de Creaci�n de la Revisi�n                    : 
//**  %DATE% 
//** Worksets ******************************************************************************
//** %PIRW%
//** Historia ******************************************************************************
//** %PL%
//******************************************************************************************
