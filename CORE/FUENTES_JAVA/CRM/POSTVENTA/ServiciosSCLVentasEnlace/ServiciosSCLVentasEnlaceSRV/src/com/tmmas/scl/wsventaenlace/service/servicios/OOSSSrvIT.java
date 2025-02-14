package com.tmmas.scl.wsventaenlace.service.servicios;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;

public interface OOSSSrvIT {
	
	/**
	 * Realiza la carga de datos que serán utilizados posteriormente para la ejecución de la
	 * orden de servicio de abono limite de consumo por abonado o cliente. 
	 *
	 * @author H&eacute;ctor Hermosilla
	 * @param OOSSDTO
	 * @return OOSSDTO
	 * @exception ServicioVentasEnlaceException
	 */
	public OOSSDTO cargaGenericaDatos(OOSSDTO oOSSDTO) throws ServicioVentasEnlaceException;
	
	/**
	 * Ejecuta todos los procesos necesarios para generar el abono de limite de consumo del cliente o
	 * abonado.
	 *
	 * @author H&eacute;ctor Hermosilla
	 * @param OOSSDTO
	 * @return OOSSDTO
	 * @exception ServicioVentasEnlaceException
	 */
	public OOSSDTO ejecutarOS (OOSSDTO oOSSDTO) throws ServicioVentasEnlaceException;
	
	
}
