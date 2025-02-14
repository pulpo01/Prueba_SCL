package com.tmmas.cl.scl.integracionsicsa.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;

public class SerieDAO extends IntegracionSICSADAO {
	/*
	 * -------------------------------------------------------------------------
	 * INICIO BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */
	/**
	 * Metodo que registra series vendidas por CELTICS
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void registrarSerieVendidaTercero(SerieDTO[] entrada,
			int numOperacion) throws IntegracionSICSAException {

		loggerDebug("registrarSerieVendidaTercero: inicio");

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		StringBuffer call = new StringBuffer();
		try {
			call.append(" BEGIN ");
			// Empiezo a Recorrer todas las series informadas
			for (int i = 0; i < entrada.length; i++) {
				call = generaInsertSeries(call, entrada[i], Integer
						.toString(numOperacion));
			}
			call.append("END;");

			conn = obtenerConexion();
			cstmt = conn.prepareCall(call.toString());
			loggerDebug("SQL[" + call + "]");
			loggerDebug("Execute Antes");
			cstmt.execute();
			loggerDebug("Execute Despues");

		} catch (Exception e) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0005", 0);
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
		loggerDebug("registrarSerieVendidaTercero: fin");
	}
	
	
	/**
	 * Metodo que devuelve las series vendidas por CELTICS
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public void devolverSeries(SerieDTO[] entrada) throws IntegracionSICSAException {

		loggerDebug("devolverSeries: inicio");

		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		StringBuffer call = new StringBuffer();
		try {
			call.append(" BEGIN ");
			// Empiezo a Recorrer todas las series informadas
			for (int i = 0; i < entrada.length; i++) {
				call = generaDevolSeries(call, entrada[i]);
			}
			
			call.append("END;");

			conn = obtenerConexion();
			cstmt = conn.prepareCall(call.toString());
			loggerDebug("SQL[" + call + "]");
			loggerDebug("Execute Antes");
			cstmt.execute();
			loggerDebug("Execute Despues");

		} catch (Exception e) {
				loggerError("ERROR:");
				loggerError(e);
				loggerError("Codigo de Error[" + codError + "]");
				loggerError("Mensaje de Error[" + msgError + "]");
				loggerError("Numero de Evento[" + numEvento + "]");
				throw new IntegracionSICSAException("ERR.0015", 0);
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
		loggerDebug("devolverSeries: fin");
	}

	/*
	 * -------------------------------------------------------------------------
	 * FIN BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */

	/**
	 * Genera Bloque Anonimo con los inserts
	 * 
	 * @author Jorge González
	 * */
	private StringBuffer generaInsertSeries(StringBuffer cadena, SerieDTO serie,
			String numOperacion) {
		cadena
				.append("INSERT INTO NP_SER_VENTAS_OL_TO (NUM_OPERACION,LIN_PROCESO,NUM_SERIE) "
						+ "VALUES ("
						+ numOperacion
						+ ", "
						+ serie.getLinPedido()
						+ ",'"
						+ serie.getNumSerie()
						+ "');");
		return cadena;
	}

	//Genera bolque anonimo con la devoliución de serie
	private StringBuffer generaDevolSeries(StringBuffer cadena, SerieDTO serie) {
		cadena
				.append("UPDATE NP_VENTAS_OL_TO a SET  a.TOTAL_VENTA = a.TOTAL_VENTA-1 WHERE"
						+" a.NUM_OPERACION IN (SELECT b.NUM_OPERACION FROM NP_SER_VENTAS_OL_TO b WHERE b.NUM_SERIE ='"
						+serie.getNumSerie()
						+"');"
						+" UPDATE NP_DET_VENTAS_OL_TO a SET a.CAN_ARTICULO = a.CAN_ARTICULO - 1 WHERE"
						+" TO_CHAR(a.NUM_OPERACION||a.LIN_PROCESO) IN (SELECT TO_CHAR(b.NUM_OPERACION||b.LIN_PROCESO)"
						+" FROM NP_SER_VENTAS_OL_TO b WHERE b.NUM_SERIE ='"
						+serie.getNumSerie()
						+"');"
						+" DELETE NP_SER_VENTAS_OL_TO WHERE NUM_SERIE ='"
						+serie.getNumSerie()
						+"';");
		return cadena;
	}

}
