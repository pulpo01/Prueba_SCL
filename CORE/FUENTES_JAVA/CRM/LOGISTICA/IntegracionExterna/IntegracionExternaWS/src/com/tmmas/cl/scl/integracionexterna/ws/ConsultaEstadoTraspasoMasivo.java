package com.tmmas.cl.scl.integracionexterna.ws;

import javax.jws.*;

import com.tmmas.cl.scl.integracionexterna.common.dto.ws.SalidaConsultaTraspasoDTO;
import com.tmmas.cl.scl.integracionexterna.common.exception.IntegracionExternaException;
import com.tmmas.cl.scl.integracionexterna.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionexterna.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionexterna.helper.IntegracionExternaServiceLocator;
import com.tmmas.cl.scl.integracionexterna.negocio.session.IntegracionExternaLocal;

@WebService
public class ConsultaEstadoTraspasoMasivo {
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	private IntegracionExternaServiceLocator externaServiceLocator;
	private IntegracionExternaLocal externaLocal;

	@WebMethod
	public SalidaConsultaTraspasoDTO consultaEstadoTraspasoMasivo(String numSecuencia) {
		logger.debug("consultaEstadoTraspasoMasivo ", nombreClase);
		SalidaConsultaTraspasoDTO outDTO = null;
		externaServiceLocator = new IntegracionExternaServiceLocator();
		try {
			
			//Valido que los objetos principales de entrada no sean nulos
			if (null == numSecuencia) {
				throw new IntegracionExternaException("ERROR FORMATO", 1, "numSecuencia Nulo");
			}
			if ("".equals(numSecuencia.trim())) {
				throw new IntegracionExternaException("ERROR FORMATO", 1, "numSecuencia Vacio");
			}
			
			try {
                Integer.parseInt(numSecuencia);
            } catch (Exception nfe) {
                throw new IntegracionExternaException("ERROR FORMATO", 1, "El valor del campo debe ser numérico : numSecuencia");
            }			
            externaLocal = externaServiceLocator.getIntegracionExternaLocal();
			
			outDTO = externaLocal.consultaEstadoTraspOP(numSecuencia);
			
		} catch (IntegracionExternaException e) {
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
		logger.debug("consultaEstadoTraspasoMasivo ", nombreClase);
		return outDTO;
	}
}