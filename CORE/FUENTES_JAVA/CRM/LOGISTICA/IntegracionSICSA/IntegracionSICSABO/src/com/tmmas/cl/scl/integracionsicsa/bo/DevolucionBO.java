package com.tmmas.cl.scl.integracionsicsa.bo;

import java.util.HashMap;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaDevolucionUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.dao.DevolucionDAO;

public class DevolucionBO extends IntegracionSICSABO {
	private DevolucionDAO devolucionDAO = new DevolucionDAO();

	/**
	 * Hugo Olivares
	 * 
	 * @param codUsuario
	 * @param codPedido
	 * @param fecDesde
	 * @param fecHasta
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public ConsultaDevolucionUsuarioDTO[] consultarDevolucionUsuario(
			String codUsuario, String codDevolucion, String fecDesde,
			String fecHasta) throws IntegracionSICSAException {
		loggerDebug("consultarDevolucionUsuario: Inicio");
		ConsultaDevolucionUsuarioDTO[] respuesta = devolucionDAO.consultarDevolucionesUsuario(codUsuario, codDevolucion, fecDesde, fecHasta);
		loggerDebug("consultarDevolucionUsuario: Fin");
		return respuesta;
	}
	
	/**
	 * Hugo Olivares
	 * @param codDevolucion
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public HashMap consultarDetalleDevolucionUsuario(String codDevolucion, HashMap detalles)throws IntegracionSICSAException{
        loggerDebug("consultarDetalleDevolucionUsuario: inicio");
        
        HashMap respuesta = devolucionDAO.consultarDetalleDevolucionUsuario(codDevolucion, detalles);
        
        loggerDebug("consultarDetalleDevolucionUsuario: fin");
        
        return respuesta;
        
	}


}
