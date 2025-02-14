package com.tmmas.cl.scl.integracionsicsa.ws;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.helper.IntegracionSICSAServiceLocator;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.sender.Sender;

@WebService
public class LimpiarPedidoWS {

	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;
	Sender sender;

	/**
	 * Limpiar Un Pedido que se encuentra asignado a despachador
	 */
	@WebMethod
	public SalidaIntegracionSICSADTO limpiarPedido(String codPedido) {
		logger.debug("limpiarPedido ", nombreClase);
		SalidaIntegracionSICSADTO outDTO = null;
		integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
		try {
			
			//Valido que los objetos principales de entrada no sean nulos
			if (null == codPedido) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"codPedido Nulo");
			}
			if ("".equals(codPedido.trim())) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"codPedido Vacio");
			}
			
			try {
                Integer.parseInt(codPedido);
            } catch (Exception nfe) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo debe ser numérico : codPedido");
            }
			
			integracionSICSALocal = integracionSICSAServiceLocator
					.getIntegracionSICSALocal();
			
			integracionSICSALocal.limpiarPedido(codPedido);
			
			outDTO = new SalidaConsultaPedidoDTO();
			outDTO.setStrDesError("Se han limpiado las series del pedido y está listo para ser reprocesado.");
			
		} catch (IntegracionSICSAException e) {
			logger.error(e, nombreClase);
			outDTO = new SalidaConsultaPedidoDTO();
			outDTO.setStrCodError(e.getCodigo());
			outDTO.setStrDesError(e.getDescripcionEvento());
			outDTO.setIEvento(e.getCodigoEvento());
		} catch (Exception e) {
			logger.error(e, nombreClase);
			outDTO = new SalidaConsultaPedidoDTO();
			outDTO.setStrCodError("ERR.0001");
			outDTO.setStrDesError(global.getValor("ERR.0001"));
			outDTO.setIEvento(0);
		}
		logger.debug("limpiarPedido: fin ", nombreClase);
		return outDTO;
	}
}