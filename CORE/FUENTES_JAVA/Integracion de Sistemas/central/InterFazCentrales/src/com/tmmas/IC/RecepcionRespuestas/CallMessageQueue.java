package com.tmmas.IC.RecepcionRespuestas;

/**
 * @author mwn70136
 *
 * Clase para llamar a un método nativo que encola en una MessageQueue
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */

public class CallMessageQueue {
	public static synchronized native int sendMessageQueue(String notificacion, int Orden, String Queue);

/*-------------------------------------------------------------------------*/
/*  Carga de la librería dinámica                                          */
/*-------------------------------------------------------------------------*/	
	static {
		System.loadLibrary("notifqueue");
	}
}
