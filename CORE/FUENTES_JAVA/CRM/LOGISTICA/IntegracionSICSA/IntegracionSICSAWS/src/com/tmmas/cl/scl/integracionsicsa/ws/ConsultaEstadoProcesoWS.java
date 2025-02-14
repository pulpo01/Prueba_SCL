package com.tmmas.cl.scl.integracionsicsa.ws;

import javax.jws.WebMethod;
import javax.jws.WebService;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaProcesoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.helper.IntegracionSICSAServiceLocator;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.sender.Sender;

@WebService
public class ConsultaEstadoProcesoWS {

	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;
	Sender sender;

	/**
	 * Consultar el estado de un proceso
	 */
	@WebMethod
	public SalidaConsultaProcesoDTO consultarEstadoProceso(String numProceso) {
		logger.debug("consultarEstadoProceso ", nombreClase);
		SalidaConsultaProcesoDTO outDTO = null;
		integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
		try {
			
			//Valido que los objetos principales de entrada no sean nulos
			if (null == numProceso) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"numProceso Nulo");
			}
			if ("".equals(numProceso.trim())) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"numProceso Vacio");
			}
			
			try {
                Integer.parseInt(numProceso);
            } catch (Exception nfe) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo debe ser numérico : numProceso");
            }
			
			integracionSICSALocal = integracionSICSAServiceLocator
					.getIntegracionSICSALocal();
			
			outDTO = integracionSICSALocal.consultarProceso(numProceso);
			
		} catch (IntegracionSICSAException e) {
			logger.error(e, nombreClase);
			outDTO = new SalidaConsultaProcesoDTO();
			outDTO.setStrCodError(e.getCodigo());
			outDTO.setStrDesError(e.getDescripcionEvento());
			outDTO.setIEvento(e.getCodigoEvento());
		} catch (Exception e) {
			logger.error(e, nombreClase);
			outDTO = new SalidaConsultaProcesoDTO();
			outDTO.setStrCodError("ERR.0001");
			outDTO.setStrDesError(global.getValor("ERR.0001"));
			outDTO.setIEvento(0);
		}
		logger.debug("consultarEstadoProceso ", nombreClase);
		return outDTO;
	}
}
