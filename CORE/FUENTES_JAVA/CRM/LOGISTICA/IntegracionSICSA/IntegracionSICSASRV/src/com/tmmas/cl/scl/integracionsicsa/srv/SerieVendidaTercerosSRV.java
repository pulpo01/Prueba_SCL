package com.tmmas.cl.scl.integracionsicsa.srv;

import com.tmmas.cl.scl.integracionsicsa.bo.SerieBO;
import com.tmmas.cl.scl.integracionsicsa.bo.VentaBO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaProcesoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.VentaInDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.validaciones.IntegracionSICSAValidaciones;

public class SerieVendidaTercerosSRV extends IntegracionSICSASRV {

	private VentaBO ventaBO = new VentaBO();
	private SerieBO serieBO = new SerieBO();
	private IntegracionSICSAValidaciones validaciones;
	/*
	 * -------------------------------------------------------------------------
	 * INICIO BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */
	/**
	 * Metodo que registra las lineas y las series
	 * 
	 * @param registrarLineasSeries
	 * @return SalidaIntegracionSICSADTO
	 * @throws IntegracionSICSAException
	 */
	public void registrarLineasSeries(VentaInDTO inDTO,int numOperacion)
			throws IntegracionSICSAException {
		loggerDebug("inicio: registrarVentaCeltics");				
		validaciones = new IntegracionSICSAValidaciones();
		validaciones.validarSeries(inDTO);
		
		loggerDebug("ANTES DE REGISTRAR LINEAS VENTAS");
		ventaBO.registrarLineasVenta(inDTO.getVentaEncabezadoDTO()
				.getVentaLineaDTOs(), numOperacion);
		loggerDebug("DESPUES DE REGISTRAR LINEAS VENTAS");
		
		loggerDebug("ANTES DE REGISTRAR SERIES");
		serieBO
				.registrarSerieVendidaTercero(inDTO.getSerieDTOs(),
						numOperacion);
		loggerDebug("DESPUES DE REGISTRAR SERIES");
		loggerDebug("fin: registrarVentaCeltics");
	}
	
	
	/**
	 * Metodo que devuelve las series
	 * 
	 * @param registrarLineasSeries
	 * @return SalidaIntegracionSICSADTO
	 * @throws IntegracionSICSAException
	 */
	public void devolverSeries(VentaInDTO inDTO,int numOperacion)
			throws IntegracionSICSAException {
		loggerDebug("inicio: devolverSeries");				
		validaciones = new IntegracionSICSAValidaciones();
		validaciones.validarSeries(inDTO);
		loggerDebug("ANTES DE DEVOLVER SERIES");
		serieBO.devolverSeries(inDTO.getSerieDTOs());
		loggerDebug("DESPUES DE DEVOLVER SERIES");
		loggerDebug("fin: registrarVentaCeltics");
	}
	
	
	/**
	 * Metodo que registra la cabecera de una venta o devolución externa
	 * 
	 * @param registrarCabecera
	 * @return SalidaIntegracionSICSADTO
	 * @throws IntegracionSICSAException
	 */
	public int registrarCabecera(VentaInDTO inDTO)
			throws IntegracionSICSAException {
		int numOperacion;
		loggerDebug("inicio: registrarCabecera");
		
		loggerDebug("validar cabecera y lineas antes");
		validaciones = new IntegracionSICSAValidaciones();
		validaciones.validarCabeceraLineas(inDTO);
		loggerDebug("validar cabecera y lineas despues");
		
		//TODO Validar que num_proceso no exista sin error siempre y cuando sea una venta
		if("V".equals(inDTO.getVentaEncabezadoDTO().getIndAccion().toUpperCase())){
			validarNumProcesoOL(Integer.parseInt(inDTO.getVentaEncabezadoDTO().getNumProceso()));
		}
		
		loggerDebug("rescatar secuencia antes");
		numOperacion=getSeqOperacion();
		loggerDebug("rescatar secuencia despues");

		if("V".equals(inDTO.getVentaEncabezadoDTO().getIndAccion().toUpperCase())){
			loggerDebug("ANTES DE REGISTRAR CABECERA DE VENTA CELISTICS");
			ventaBO.registrarVentaCelistics(inDTO.getVentaEncabezadoDTO(),numOperacion);
			loggerDebug("DESPUES DE REGISTRAR CABECERA DE VENTA CELISTICS");
		}else{
			loggerDebug("ANTES DE REGISTRAR CABECERA DE DEVOLUCION CELISTICS");
			ventaBO.registrarDevolucionCelistics(inDTO.getVentaEncabezadoDTO(),numOperacion);
			loggerDebug("DESPUES DE REGISTRAR CABECERA DE DEVOLUCION CELISTICS");			
		}
		
		loggerDebug("fin: registrarCabecera");
		
		return numOperacion;
	}
	
	/**
	 * Metodo que recupera una secuencia para ocupar como numero de operacion
	 * 
	 * 
	 * @return int
	 * @throws IntegracionSICSAException
	 */
	public int getSeqOperacion()
			throws IntegracionSICSAException {
		loggerDebug("inicio: getSeqOperacion");
		int retorno=0;
		retorno= ventaBO.getSeqOperacion();
		loggerDebug("fin: getSeqOperacion");
		return retorno;
	}
	
	/**
	 * Metodo que actualiza el estado de un proceso en la cabecera
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void actualizarEstadoProceso(String estado,int numOperacion)
			throws IntegracionSICSAException {
		loggerDebug("actualizarEstadoProceso: inicio");
		ventaBO.actualizarEstadoProceso(estado, numOperacion);
		loggerDebug("actualizarEstadoProceso: fin");		
	}
	
	/**
	 * Metodo que valida si un proceso ingresado ya existe en SISCEL sin estado ERRONEO
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void validarNumProcesoOL(int numProceso)
			throws IntegracionSICSAException {

		loggerDebug("validarNumProcesoOL: inicio");
		ventaBO.validarNumProcesoOL(numProceso);
		loggerDebug("validarNumProcesoOL: fin");
	}
	
	/**
	 * Metodo que consulta los datos de un proceso
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public SalidaConsultaProcesoDTO consultarProceso(String numProceso)
			throws IntegracionSICSAException {
		SalidaConsultaProcesoDTO outDTO;
		loggerDebug("consultarProceso: inicio");
		outDTO = ventaBO.consultarProceso(numProceso);
		loggerDebug("consultarProceso: fin");
		return outDTO;
	}

	/*
	 * -------------------------------------------------------------------------
	 * FIN BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */
}