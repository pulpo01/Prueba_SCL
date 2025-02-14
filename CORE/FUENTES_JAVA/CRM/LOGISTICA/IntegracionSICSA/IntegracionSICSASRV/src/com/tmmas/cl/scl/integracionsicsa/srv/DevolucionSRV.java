package com.tmmas.cl.scl.integracionsicsa.srv;

import java.util.HashMap;

import com.tmmas.cl.scl.integracionsicsa.bo.DevolucionBO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaDevolucionUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;

public class DevolucionSRV extends IntegracionSICSASRV {
	private DevolucionBO devolucionBO = new DevolucionBO();
	
	/**
	 * Hugo Olivares
	 * @param codUsuario
	 * @param codPedido
	 * @param fecDesde
	 * @param fecHasta
	 * @return
	 * @throws IntegracionSICSAException
	 */
	public ConsultaDevolucionUsuarioDTO[] consultarDevolucionUsuario(String codUsuario, String codDevolucion, String fecDesde, String fecHasta)throws IntegracionSICSAException{
		loggerDebug("consultarDevolucionUsuario: Inicio");
		ConsultaDevolucionUsuarioDTO[] respuesta = devolucionBO.consultarDevolucionUsuario(codUsuario,codDevolucion,fecDesde,fecHasta);
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
        
        HashMap respuesta = devolucionBO.consultarDetalleDevolucionUsuario(codDevolucion, detalles);
        
        loggerDebug("consultarDetalleDevolucionUsuario: fin");
        
        return respuesta;
        
	}

	
}
