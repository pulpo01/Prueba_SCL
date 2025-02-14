package com.tmmas.scl.wsventaenlace.delegate;

import javax.servlet.ServletContext;

import com.tmmas.scl.wsventaenlace.common.exception.ServicioVentasEnlaceException;
import com.tmmas.scl.wsventaenlace.common.helper.GlobalProperties;
import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.locator.ServiceLocator;
import com.tmmas.scl.wsventaenlace.negocio.ejb.session.AsociaRangoFacadeLocal;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.AsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.CargaAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.EjecucionAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.validaciones.AsociaRangoVal;

public class AsociaRango extends POJO {
	private GlobalProperties global = GlobalProperties.getInstance();
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private static String nombreClase = AsociaRango.class.getName();
	private ServiceLocator locator;

	public AsociaRango() {
		locator = new ServiceLocator();
	}

	public CargaAsociaRangoDTO cargarAsociaRangoDTO(CargaAsociaRangoDTO cargaAsociaRangoDTO, ServletContext context) {
		logger.info("comenzando...", nombreClase);

		AsociaRangoDTO asociaRangoDTO = null;
		String codError = null;
		String desError = null;

		try {
			if (cargaAsociaRangoDTO == null){
				throw new ServicioVentasEnlaceException("ERR.0001", 1, global.getValor("ERR.0001"));
			}
				

			codError = cargaAsociaRangoDTO.getCodError();
			desError = cargaAsociaRangoDTO.getDesError();
			cargaAsociaRangoDTO.setCodError(null);
			cargaAsociaRangoDTO.setDesError(null);

			AsociaRangoVal asociaRangoVal = new AsociaRangoVal();
			logger.info("valida CargaAsociaRangoDTO...", nombreClase);
			asociaRangoVal.validarCarga(cargaAsociaRangoDTO);

			asociaRangoDTO = new AsociaRangoDTO();
			asociaRangoDTO.setCargaAsociaRangoDTO(cargaAsociaRangoDTO);
			AsociaRangoFacadeLocal facade = locator.obtenerAsociaRangoFacadeLocal();
			logger.info("Invoca servicio...", nombreClase);
			asociaRangoDTO = (AsociaRangoDTO) facade.cargaGenericaDatos(asociaRangoDTO);

			if (asociaRangoDTO != null && asociaRangoDTO.getCargaAsociaRangoDTO() != null && asociaRangoDTO.getCargaAsociaRangoDTO().getCodError() == null) {
				asociaRangoDTO.getCargaAsociaRangoDTO().setCodError(codError);
				asociaRangoDTO.getCargaAsociaRangoDTO().setDesError(desError);
				setObjetoContexto(asociaRangoDTO, context);
				asociaRangoDTO.getCargaAsociaRangoDTO().setNumTransaccion(asociaRangoDTO.getNumTransaccion());
			} else {
				asociaRangoDTO.getCargaAsociaRangoDTO().setNumTransaccion(global.getValor("GE.TRANSACCION.INVALIDA.WS"));
			}
		} catch (Exception e) {			
			logger.error(e, nombreClase);

			if (e instanceof ServicioVentasEnlaceException) {
				ServicioVentasEnlaceException e1 = (ServicioVentasEnlaceException) e;
				codError = e1.getCodigo();
				desError = e1.getDescripcionEvento();
			} else {
				codError = "ERR.0004";
				desError = global.getValor("ERR.0004");
				logger.error(global.getValor("ERR.0004"), nombreClase);
			}

			if (cargaAsociaRangoDTO == null)
				cargaAsociaRangoDTO = new CargaAsociaRangoDTO();

			if (asociaRangoDTO == null)
				asociaRangoDTO = new AsociaRangoDTO();

			cargaAsociaRangoDTO.setNumTransaccion(global.getValor("GE.TRANSACCION.INVALIDA.WS"));
			asociaRangoDTO.setCargaAsociaRangoDTO(cargaAsociaRangoDTO);

			if (desError != null && codError != null) {
				asociaRangoDTO.getCargaAsociaRangoDTO().setCodError(codError);
				asociaRangoDTO.getCargaAsociaRangoDTO().setDesError(desError);
			} else {
				asociaRangoDTO.getCargaAsociaRangoDTO().setCodError("ERR.0008");
				asociaRangoDTO.getCargaAsociaRangoDTO().setDesError(global.getValor("ERR.0008"));
			}

			logger.debug(global.getValor("ERR.0004"), nombreClase);
		}

		logger.info(cargaAsociaRangoDTO.toString(), nombreClase);
		logger.info("cargaAsociaRangoDTO():end", nombreClase);

		return cargaAsociaRangoDTO;
	}

	public EjecucionAsociaRangoDTO ejecutarAsociaRangoDTO(EjecucionAsociaRangoDTO ejecucionAsociaRangoDTO, ServletContext context) {
		logger.info("comenzando...", nombreClase);

		AsociaRangoDTO asociaRangoDTO = null;
		String codError = null;
		String desError = null;

		try {
			if (ejecucionAsociaRangoDTO == null)
				throw new ServicioVentasEnlaceException("ERR.0001", 1, global.getValor("ERR.0001"));

			AsociaRangoVal asociaRangoVal = new AsociaRangoVal();
			asociaRangoVal.validarEjecucion(ejecucionAsociaRangoDTO);

			logger.debug(ejecucionAsociaRangoDTO.toString(), nombreClase);

			codError = ejecucionAsociaRangoDTO.getCodError();
			desError = ejecucionAsociaRangoDTO.getDesError();
			ejecucionAsociaRangoDTO.setCodError(null);
			ejecucionAsociaRangoDTO.setDesError(null);

			// Se obtiene el objeto AsociaRangoDTO del contexto
			asociaRangoDTO = (AsociaRangoDTO) getObjetoContexto(ejecucionAsociaRangoDTO.getNumTransaccion(),context);
			asociaRangoDTO.setEjecucionAsociaRangoDTO(ejecucionAsociaRangoDTO);

			// Se coloca el objeto AsociaRangoDTO en la cola a través del objeto sender
			asociaRangoDTO.setServicio(Integer.parseInt(global.getValor("GE.asociaRango")));
			sendMessage(asociaRangoDTO);

			// Se asigna el mensaje para la operación de ejecución asincrona
			asociaRangoDTO.getEjecucionAsociaRangoDTO().setDesError(global.getValor("GE.mensaje.operacion.ejecucion.asicrono.WEB"));

			logger.debug(ejecucionAsociaRangoDTO.toString(), nombreClase);
		} catch (Exception e) {
			logger.error(e, nombreClase);

			if (e instanceof ServicioVentasEnlaceException) {
				ServicioVentasEnlaceException e1 = (ServicioVentasEnlaceException) e;
				codError = e1.getCodigo();
				desError = e1.getDescripcionEvento();
			} else {
				codError = "ERR.0004";
				desError = global.getValor("ERR.0004");
				logger.error(global.getValor("ERR.0004"), nombreClase);
			}

			if (ejecucionAsociaRangoDTO == null)
				ejecucionAsociaRangoDTO = new EjecucionAsociaRangoDTO();

			ejecucionAsociaRangoDTO.setNumTransaccion(global.getValor("GE.TRANSACCION.INVALIDA.WS"));

			if (desError != null && codError != null) {
				ejecucionAsociaRangoDTO.setCodError(codError);
				ejecucionAsociaRangoDTO.setDesError(desError);
			} else {
				ejecucionAsociaRangoDTO.setCodError("ERR.0008");
				ejecucionAsociaRangoDTO.setDesError(global.getValor("ERR.0008"));
			}

			logger.debug(global.getValor("ERR.0004"), nombreClase);
		}

		logger.info("terminado.", nombreClase);

		return ejecucionAsociaRangoDTO;
	}
}
