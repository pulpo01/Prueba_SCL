/**
 * 
 */
package com.tmmas.scl.wsventaenlace.delegate;

import java.net.MalformedURLException;
import java.rmi.RemoteException;

import javax.servlet.ServletContext;
import javax.xml.rpc.ServiceException;

import net.sf.dozer.util.mapping.DozerBeanMapper;

import com.tmmas.scl.wsventaenlace.common.helper.LoggerHelper;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.OOSSFase2DTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.CargaAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.EjecucionAsociaRangoDTO;
import com.tmmas.scl.wsventaenlace.transport.dto.asociarango.RangoDTO;

public class BusinessDelegate {
	private static final LoggerHelper logger = LoggerHelper.getInstance();
	private static String nombreClase = BusinessDelegate.class.getName();
	private static DozerBeanMapper mapper = new DozerBeanMapper();
	private static ConsultaOrdenServicio consultaOrdenServicio = new ConsultaOrdenServicio();
	private static AsociaRango asociaRango = new AsociaRango();

	public static CargaAsociaRangoDTO cargarAsociaRangoDTO(CargaAsociaRangoDTO inCargaAsociaRangoDTO, ServletContext context) throws Exception {
		logger.debug("cargarAsociaRangoDTO: " + inCargaAsociaRangoDTO.toString(), nombreClase);

		CargaAsociaRangoDTO inWSCargaAsociaRangoDTO = new CargaAsociaRangoDTO();
		inWSCargaAsociaRangoDTO.setNumAbonado(inCargaAsociaRangoDTO.getNumAbonado());
		inWSCargaAsociaRangoDTO.setNomUsuarioSCL(inCargaAsociaRangoDTO.getNomUsuarioSCL());
		inWSCargaAsociaRangoDTO.setNomCliente(inCargaAsociaRangoDTO.getNomCliente());

		CargaAsociaRangoDTO outWSCargaAsociaRangoDTO = asociaRango.cargarAsociaRangoDTO(inWSCargaAsociaRangoDTO,context);

		CargaAsociaRangoDTO outCargaAsociaRangoDTO = new CargaAsociaRangoDTO();
		outCargaAsociaRangoDTO.setCodError(outWSCargaAsociaRangoDTO.getCodError());
		outCargaAsociaRangoDTO.setDesError(outWSCargaAsociaRangoDTO.getDesError());
		outCargaAsociaRangoDTO.setNumAbonado(outWSCargaAsociaRangoDTO.getNumAbonado());
		outCargaAsociaRangoDTO.setNumCelular(outWSCargaAsociaRangoDTO.getNumCelular());
		if (outCargaAsociaRangoDTO.getCodError() == null) {
			outCargaAsociaRangoDTO.setNumTransaccion(outWSCargaAsociaRangoDTO.getNumTransaccion());
			outCargaAsociaRangoDTO.setNomCliente(outWSCargaAsociaRangoDTO.getNomCliente());

			RangoDTO[] wsRangos = null;
			RangoDTO[] rangos = null;
			int i;

			wsRangos = outWSCargaAsociaRangoDTO.getRangosAsociados();

			if (wsRangos != null && wsRangos.length > 0) {
				rangos = new RangoDTO[wsRangos.length];

				for (i = 0; i < wsRangos.length; i++) {
					rangos[i] = new RangoDTO();
					mapper.map(wsRangos[i], rangos[i]);
				}
			}

			outCargaAsociaRangoDTO.setRangosAsociados(rangos);

			wsRangos = outWSCargaAsociaRangoDTO.getRangosDisponibles();
			rangos = new RangoDTO[wsRangos.length];
			if (wsRangos != null && wsRangos.length > 0) {
				for (i = 0; i < wsRangos.length; i++) {
					rangos[i] = new RangoDTO();
					mapper.map(wsRangos[i], rangos[i]);
				}
			}

			outCargaAsociaRangoDTO.setRangosDisponibles(rangos);
		}

		logger.debug(outCargaAsociaRangoDTO.toString(), nombreClase);

		return outCargaAsociaRangoDTO;
	}

	public static EjecucionAsociaRangoDTO ejecutarAsociaRangoDTO(EjecucionAsociaRangoDTO inEjecucionAsociaRangoDTO,ServletContext context) throws Exception {
		logger.debug(inEjecucionAsociaRangoDTO.toString(), nombreClase);
		EjecucionAsociaRangoDTO inWSEjecucionAsociaRangoDTO = new EjecucionAsociaRangoDTO();
		RangoDTO rangos[] = null;
		RangoDTO wsRangos[] = null;
		inWSEjecucionAsociaRangoDTO.setComentario(inEjecucionAsociaRangoDTO.getComentario());
		inWSEjecucionAsociaRangoDTO.setNumTransaccion(inEjecucionAsociaRangoDTO.getNumTransaccion());
		rangos = inEjecucionAsociaRangoDTO.getRangosAdicionados();

		if (rangos != null && rangos.length > 0) {
			wsRangos = new RangoDTO[rangos.length];
			for (int i = 0; i < rangos.length; i++) {
				wsRangos[i] = new RangoDTO();
				mapper.map(rangos[i], wsRangos[i]);
			}
			inWSEjecucionAsociaRangoDTO.setRangosAdicionados(wsRangos);
		}
		rangos = inEjecucionAsociaRangoDTO.getRangosEliminados();
		if (rangos != null && rangos.length > 0) {
			wsRangos = new RangoDTO[rangos.length];

			for (int i = 0; i < rangos.length; i++) {
				wsRangos[i] = new RangoDTO();
				mapper.map(rangos[i], wsRangos[i]);
			}
			inWSEjecucionAsociaRangoDTO.setRangosEliminados(wsRangos);
		}				
		EjecucionAsociaRangoDTO outWSEjecucionAsociaRangoDTO = asociaRango.ejecutarAsociaRangoDTO(inWSEjecucionAsociaRangoDTO,context);		

		logger.debug(outWSEjecucionAsociaRangoDTO.toString(), nombreClase);

		return outWSEjecucionAsociaRangoDTO;
	}

	public static void consultaOS(OOSSDTO oossdto) throws Exception {
		logger.info("consultaOS():start", nombreClase);
		logger.info("consultaOS(): numTransaccion = " + oossdto.getNumTransaccion(), nombreClase);
		
		OOSSFase2DTO inWSOOSSDTO = new OOSSFase2DTO();
		inWSOOSSDTO.setNumTransaccion(oossdto.getNumTransaccion());
		OOSSFase2DTO outWSOOSSDTO = consultaOrdenServicio.consultarOrdenServicio(inWSOOSSDTO);
		logger.info(String.valueOf(outWSOOSSDTO.getNroOOSS()), nombreClase);

		oossdto.setCodError(outWSOOSSDTO.getCodError());
		oossdto.setDesError(outWSOOSSDTO.getDesError());
		oossdto.setNroOOSS(outWSOOSSDTO.getNroOOSS());

		logger.info("consultaOS(): numTransaccion = " + oossdto.getNumTransaccion() + ", NroOOSS = " + oossdto.getNroOOSS(), nombreClase);

		logger.info("consultaOS():end", nombreClase);
	}

}
