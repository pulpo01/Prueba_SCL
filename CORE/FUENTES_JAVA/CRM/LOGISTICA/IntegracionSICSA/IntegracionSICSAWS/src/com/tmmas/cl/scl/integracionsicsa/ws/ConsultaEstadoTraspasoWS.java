package com.tmmas.cl.scl.integracionsicsa.ws;

import javax.jws.*;

import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.helper.IntegracionSICSAServiceLocator;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.sender.Sender;

@WebService
public class ConsultaEstadoTraspasoWS {
	
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;
	Sender sender;

	@WebMethod
	public SalidaConsultaTraspasoDTO consultarEstadoTraspaso(String strNumTraspaso) {
		logger.debug("consultarEstadoTraspaso ", nombreClase);
		SalidaConsultaTraspasoDTO outDTO = null;
		integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
		try {
			
			//Valido que los objetos principales de entrada no sean nulos
			if (null == strNumTraspaso) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"numTraspaso Nulo");
			}
			if ("".equals(strNumTraspaso.trim())) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"numTraspaso Vacio");
			}
			
			try {
                Integer.parseInt(strNumTraspaso);
            } catch (Exception nfe) {
                throw new IntegracionSICSAException("ERROR FORMATO", 1, "El valor del campo debe ser numérico : numTraspaso");
            }
			
			integracionSICSALocal = integracionSICSAServiceLocator.getIntegracionSICSALocal();
			
			outDTO = integracionSICSALocal.obtieneEstadoTraspaso(strNumTraspaso);
			
		} catch (IntegracionSICSAException e) {
			logger.error(e, nombreClase);
			outDTO = new SalidaConsultaTraspasoDTO();
			outDTO.setStrCodError(e.getCodigo());
			outDTO.setStrDesError(e.getDescripcionEvento());
			outDTO.setIEvento(e.getCodigoEvento());
		} catch (Exception e) {
			logger.error(e, nombreClase);
			outDTO = new SalidaConsultaTraspasoDTO();
			outDTO.setStrCodError("ERR.0001");
			outDTO.setStrDesError(global.getValor("ERR.0001"));
			outDTO.setIEvento(0);
		}
		logger.debug("consultarEstadoTraspaso ", nombreClase);
		return outDTO;
	}		
}