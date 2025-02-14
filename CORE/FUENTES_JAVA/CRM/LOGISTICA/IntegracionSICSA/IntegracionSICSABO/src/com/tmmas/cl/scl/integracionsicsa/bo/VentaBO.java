package com.tmmas.cl.scl.integracionsicsa.bo;

import com.tmmas.cl.scl.integracionsicsa.common.dto.VentaEncabezadoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.VentaLineaDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaProcesoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.dao.VentaDAO;

public class VentaBO extends IntegracionSICSABO {

	private VentaDAO ventaDAO = new VentaDAO();

	/*
	 * -------------------------------------------------------------------------
	 * INICIO BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */
	/**
	 * Metodo que registra una venta informada por CELSTIC
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void registrarVentaCelistics(VentaEncabezadoDTO entrada, int numOperacion)
			throws IntegracionSICSAException {
		loggerDebug("registrarVentaCelistics: inicio");
		ventaDAO.registrarVentaCelistics(entrada, numOperacion);
		loggerDebug("registrarVentaCelistics");
	}
	
	/**
	 * Metodo que registra una devolución informada por CELSTIC
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void registrarDevolucionCelistics(VentaEncabezadoDTO entrada, int numOperacion)
			throws IntegracionSICSAException {
		loggerDebug("registrarDevolucionCelistics: inicio");
		ventaDAO.registrarDevolucionCelistics(entrada, numOperacion);
		loggerDebug("registrarDevolucionCelistics");
	}

	/**
	 * Metodo que registra una Linea Vendida
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void registrarLineasVenta(VentaLineaDTO[] entrada, int numOperacion)
			throws IntegracionSICSAException {

		loggerDebug("registrarLineasVenta: inicio");
		ventaDAO.registrarLineasVenta(entrada, numOperacion);
		loggerDebug("registrarLineasVenta");
	}
	
	/**
	 * Metodo que recupera la secuencia para ocupar como numOperacion
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public int getSeqOperacion()
			throws IntegracionSICSAException {

		loggerDebug("getSeqOperacion: inicio");
		int retorno;
		retorno = ventaDAO.getSeqOperacion();
		loggerDebug("getSeqOperacion: fin");
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
		ventaDAO.actualizarEstadoProceso(estado, numOperacion);
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
		ventaDAO.validarNumProcesoOL(numProceso);
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
		outDTO = ventaDAO.consultarProceso(numProceso);
		loggerDebug("consultarProceso: fin");
		return outDTO;
	}

	/*
	 * -------------------------------------------------------------------------
	 * FIN BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */

}
