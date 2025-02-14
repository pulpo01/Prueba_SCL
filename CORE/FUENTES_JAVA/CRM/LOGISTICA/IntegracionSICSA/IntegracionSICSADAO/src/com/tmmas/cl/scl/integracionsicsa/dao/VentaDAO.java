package com.tmmas.cl.scl.integracionsicsa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import com.tmmas.cl.scl.integracionsicsa.common.dto.VentaEncabezadoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.VentaLineaDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ws.SalidaConsultaProcesoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;

public class VentaDAO extends IntegracionSICSADAO {
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
	public void registrarVentaCelistics(VentaEncabezadoDTO entrada,
			int numOperacion) throws IntegracionSICSAException {

		loggerDebug("registrarVentaCelistics: inicio");

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_ins_encabezado_venta_pr", 10);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setInt(1, Integer.parseInt(entrada.getNumProceso()));
			loggerDebug("entrada.getNumProceso(): " + entrada.getNumProceso());

			cstmt.setInt(2, numOperacion);
			loggerDebug("numOperacion: " + numOperacion);

			cstmt.setInt(3, Integer.parseInt(entrada.getCodCliente()));
			loggerDebug("entrada.getCodCliente(): " + entrada.getCodCliente());

			cstmt.setString(4, entrada.getNomCliente());
			loggerDebug("entrada.getNomCliente(): " + entrada.getNomCliente());

			cstmt.setInt(5, Integer.parseInt(entrada.getTotalSeries()));
			loggerDebug("entrada.getTotalSeries(): " + entrada.getTotalSeries());

			cstmt.setString(6, entrada.getIndAccion());
			loggerDebug("entrada.getIndAccion(): " + entrada.getIndAccion());

			cstmt.setString(7, entrada.getFechaProceso());
			loggerDebug("entrada.getFechaProceso(): "
					+ entrada.getFechaProceso());

			cstmt.registerOutParameter(8, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(8), cstmt.getString(9), cstmt
					.getInt(10));

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("registrarVentaCelistics: fin");
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

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_ins_linea_venta_pr", 9);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setInt(1, numOperacion); // Siempre es el mismo por eso queda
											// afuera del for
			for (int i = 0; i < entrada.length; i++) {
				cstmt.setInt(2, Integer.parseInt(entrada[i].getLinProceso()));
				cstmt.setInt(3, Integer.parseInt(entrada[i].getCodArticulo()));
				cstmt.setString(4, entrada[i].getDesArticulo());
				cstmt.setInt(5, Integer.parseInt(entrada[i].getCanArticulo()));
				cstmt.setDouble(6, Double.parseDouble(entrada[i]
						.getPrecioVenta()));
				cstmt.registerOutParameter(7, java.sql.Types.INTEGER);
				cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(9, java.sql.Types.INTEGER);
				loggerDebug("Execute Antes");
				cstmt.execute();
				loggerDebug("Execute Despues");
				evaluaResultado(cstmt.getInt(7), cstmt.getString(8), cstmt
						.getInt(9));
			}

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("registrarLineasVenta: fin");
	}

	/**
	 * Metodo que recupera la secuencia para ocupar como numOperacion
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public int getSeqOperacion() throws IntegracionSICSAException {

		loggerDebug("getSeqOperacion: inicio");

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		int retorno = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_get_seq_proceso_pr", 4);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");

			cstmt.registerOutParameter(1, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt
					.getInt(4));

			retorno = cstmt.getInt(1);

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("getSeqOperacion: fin");
		return retorno;
	}

	/**
	 * Metodo que actualiza el estado de un proceso en la cabecera
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void actualizarEstadoProceso(String estado, int numOperacion)
			throws IntegracionSICSAException {

		loggerDebug("actualizarEstadoProceso: inicio");

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_act_estado_proceso_pr", 5);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setInt(1, numOperacion);
			loggerDebug("numOperacion: " + numOperacion);

			cstmt.setString(2, estado);
			loggerDebug("estado(): " + estado);

			cstmt.registerOutParameter(3, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(3), cstmt.getString(4), cstmt
					.getInt(5));

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("actualizarEstadoProceso: fin");
	}

	/**
	 * Metodo que valida si un proceso ingresado ya existe en SISCEL sin estado
	 * ERRONEO
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void validarNumProcesoOL(int numProceso)
			throws IntegracionSICSAException {

		loggerDebug("validarNumProcesoOL: inicio");

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_val_num_proceso_pr", 4);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setInt(1, numProceso);
			loggerDebug("numProceso: " + numProceso);

			cstmt.registerOutParameter(2, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(2), cstmt.getString(3), cstmt
					.getInt(4));

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("validarNumProcesoOL: fin");
	}

	/*
	 * -------------------------------------------------------------------------
	 * FIN BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */

	/**
	 * Metodo que registra una devolución informada por CELSTIC
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void registrarDevolucionCelistics(VentaEncabezadoDTO entrada,
			int numOperacion) throws IntegracionSICSAException {

		loggerDebug("registrarDevolucionCelistics: inicio");

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_ins_encabezado_devol_pr", 6);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setInt(1, Integer.parseInt(entrada.getNumProceso()));
			loggerDebug("entrada.getNumProceso(): " + entrada.getNumProceso());

			cstmt.setInt(2, numOperacion);
			loggerDebug("numOperacion: " + numOperacion);

			cstmt.setString(3, entrada.getIndAccion());
			loggerDebug("entrada.getIndAccion(): " + entrada.getIndAccion());

			cstmt.registerOutParameter(4, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(4), cstmt.getString(5), cstmt
					.getInt(6));

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("registrarDevolucionCelistics: fin");
	}

	/**
	 * Metodo que consulta los datos de un proceso
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public SalidaConsultaProcesoDTO consultarProceso(String numProceso)
			throws IntegracionSICSAException {

		loggerDebug("consultarProceso: inicio");
		SalidaConsultaProcesoDTO outDTO = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;

		try {

			conn = obtenerConexion();
			String call = getSQL("al_integracion_sicsa_pg",
					"al_cons_est_proceso_pr", 9);
			cstmt = conn.prepareCall(call);
			loggerDebug("SQL[" + call + "]");
			// PARAMETROS DE ENTRADA
			cstmt.setInt(1, Integer.parseInt(numProceso));
			loggerDebug("numProceso: " + numProceso);

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.INTEGER);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.INTEGER);

			loggerDebug(" Iniciando Ejecución");
			loggerDebug("Execute Antes");

			cstmt.execute();

			loggerDebug("Execute Despues");
			loggerDebug(" Finalizo ejecución");

			evaluaResultado(cstmt.getInt(7), cstmt.getString(8), cstmt
					.getInt(9));

			outDTO = new SalidaConsultaProcesoDTO();
			outDTO.setCodCliente(cstmt.getString(2));
			outDTO.setNomCliente(cstmt.getString(3));
			outDTO.setTotalSeries(cstmt.getString(4));
			outDTO.setFecOperacion(cstmt.getString(5));
			outDTO.setEstado(cstmt.getString(6));

		} catch (Exception e) {
			if (!(e instanceof IntegracionSICSAException)) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0000", 0);
			} else {
				throw (IntegracionSICSAException) e;
			}
		} finally {

			loggerDebug("Cerrando conexiones...");

			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (conn != null && !conn.isClosed()) {
					conn.close();
				}

			} catch (SQLException e) {
				loggerError("ERROR: ");
				loggerError("SQLException[" + e + "]");
			}

		}
		loggerDebug("consultarProceso: fin");
		return outDTO;
	}

}