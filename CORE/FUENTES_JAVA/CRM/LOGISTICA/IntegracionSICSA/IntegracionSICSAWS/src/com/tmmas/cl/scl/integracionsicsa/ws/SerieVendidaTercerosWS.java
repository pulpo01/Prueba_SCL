package com.tmmas.cl.scl.integracionsicsa.ws;

import javax.jws.WebMethod;
import javax.jws.WebService;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaIntegracionSICSADTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.VentaInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.GlobalProperties;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.helper.IntegracionSICSAServiceLocator;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.sender.Sender;

@WebService
public class SerieVendidaTercerosWS {

	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private GlobalProperties global = GlobalProperties.getInstance();
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;
	Sender sender;

	/**
	 * Obtener Datos Cliente
	 */
	@WebMethod
	public SalidaIntegracionSICSADTO registrarSeriesVendidas(VentaInDTO inDTO) {
		logger.debug("registrarSeriesVendidas:inicio ", nombreClase);
		SalidaIntegracionSICSADTO outDTO = null;
		integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
		try {
			
			//Valido que los objetos principales de entrada no sean nulos
			if (null == inDTO) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"No ha enviado nada");
			}
			if (null == inDTO.getVentaEncabezadoDTO()) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"Cabecera Nula");
			}
			if (null != inDTO.getVentaEncabezadoDTO().getIndAccion()&& "V".equals(inDTO.getVentaEncabezadoDTO().getIndAccion()
							.toUpperCase())
					&& (null == inDTO.getVentaEncabezadoDTO()
							.getVentaLineaDTOs()||0==inDTO.getVentaEncabezadoDTO().getVentaLineaDTOs().length)) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"No se informan detalles de articulos");
			}
			if (null == inDTO.getSerieDTOs()||0==inDTO.getSerieDTOs().length) {
				throw new IntegracionSICSAException("ERROR FORMATO", 1,
						"No se informan series");
			}
			
			integracionSICSALocal = integracionSICSAServiceLocator
					.getIntegracionSICSALocal();
			int numOperacion = integracionSICSALocal.registrarCabecera(inDTO);
			logger.debug("numOperacion: " + numOperacion, nombreClase);
			sender = new Sender();
			
			Integer numServicio = null;
			
			if("V".equals(inDTO.getVentaEncabezadoDTO().getIndAccion().toUpperCase())){
				numServicio = new Integer(global.getValor("GE.registrarSeriesVendidas"));
			}else{
				numServicio = new Integer(global.getValor("GE.devolverSeries"));
			}
			
			sender.send(inDTO, Integer.toString(numOperacion),numServicio);
			
			outDTO = new SalidaIntegracionSICSADTO();
			outDTO
					.setStrDesError("Su solicitud ha quedado encolada exitosamente");
		} catch (IntegracionSICSAException e) {
			logger.error(e, nombreClase);
			outDTO = new SalidaIntegracionSICSADTO();
			outDTO.setStrCodError(e.getCodigo());
			outDTO.setStrDesError(e.getDescripcionEvento());
			outDTO.setIEvento(e.getCodigoEvento());
		} catch (Exception e) {
			logger.error(e, nombreClase);
			outDTO = new SalidaIntegracionSICSADTO();
			outDTO.setStrCodError("ERR.0001");
			outDTO.setStrDesError(global.getValor("ERR.0001"));
			outDTO.setIEvento(0);
		}
		logger.debug("registrarSeriesVendidas:fin ", nombreClase);
		return outDTO;
	}
}
