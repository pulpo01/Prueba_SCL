package com.tmmas.cl.scl.integracionsicsa.ws;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaPedidoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.helper.IntegracionSICSAServiceLocator;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.sender.Sender;

@WebService
public class ConsultaEstadoPedidoWS {

	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;
	Sender sender;

	/**
	 * Consultar el estado de un pedido
	 */
	@WebMethod
	public SalidaConsultaPedidoDTO consultarEstadoPedido(String numPedido) {
		logger.debug("consultarEstadoPedido ", nombreClase);
		SalidaConsultaPedidoDTO outDTO = null;
		integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
		try {
			
			//Valido que los objetos principales de entrada no sean nulos
			if (null == numPedido) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"numPedido Nulo");
			}
			if ("".equals(numPedido.trim())) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"numPedido Vacio");
			}
			
			try {
                Integer.parseInt(numPedido);
            } catch (Exception nfe) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo debe ser numérico : numPedido");
            }
			
			integracionSICSALocal = integracionSICSAServiceLocator
					.getIntegracionSICSALocal();
			
			outDTO = integracionSICSALocal.obtieneEstadoPedido(numPedido);
			
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
		logger.debug("consultarEstadoPedido ", nombreClase);
		return outDTO;
	}
}