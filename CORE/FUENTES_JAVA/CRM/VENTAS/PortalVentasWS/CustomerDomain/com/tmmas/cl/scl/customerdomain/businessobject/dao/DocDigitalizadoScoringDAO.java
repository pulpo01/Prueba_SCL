package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import oracle.jdbc.driver.OracleTypes;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;

public class DocDigitalizadoScoringDAO extends DocDigitalizadoDAO {

	private final Logger logger = Logger.getLogger(this.getClass());

	/**
	 * @author JIB
	 * @param docDigitalizadoScoringDTO
	 * @return
	 * @throws CustomerDomainException
	 */
	public Long insertarDocDigitalizadoScoring(DocDigitalizadoScoringDTO docDigitalizadoScoringDTO)
			throws CustomerDomainException {
		final String nombreMetodo = "insertarDocDigitalizadoScoring";
		logger.info(nombreMetodo + ", inicio");
		Long r = null;
		logger.debug("docDigitalizadoScoringDTO [" + docDigitalizadoScoringDTO.toString() + "]");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "GA_REPOSITORIO_PG";
		final String nombrePLSQL = "VE_INSERTA_DOCDIG_SCORING_PR";
		final int cantidadParametros = 8;
		final String mensajeError = "Ocurrió un error al insertar documento";
		try {
			int i = 1;
			String call = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(i++, docDigitalizadoScoringDTO.getNumSolScoring());
			cstmt.setString(i++, docDigitalizadoScoringDTO.getCodScoring());
			cstmt.setString(i++, docDigitalizadoScoringDTO.getDesScoring());
			cstmt.setString(i++, docDigitalizadoScoringDTO.isRequeridoScoring() ? "1" : "0");

			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute(): Antes");
			cstmt.execute();
			logger.debug("cstmt.execute(): Después");

			r = new Long(cstmt.getLong(cantidadParametros - 3));
			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("Codigo de Error [" + codError + "]");
			logger.error("Mensaje de Error [" + msgError + "]");
			logger.error("Numero de Evento [" + numEvento + "]");
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info(nombreMetodo + ", fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param numSolScoring
	 * @return
	 * @throws CustomerDomainException
	 */
	public DocDigitalizadoScoringDTO[] obtenerDocDigitalizadosScoring(Long numCorrelativo, Long numSolScoring)
			throws CustomerDomainException {
		logger.info("obtenerDocDigitalizadosScoring, Inicio");
		logger.debug("numCorrelativo [" + numCorrelativo + "]");
		logger.debug("numSolScoring [" + numSolScoring + "]");
		DocDigitalizadoScoringDTO[] r = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		final String nombrePackage = "GA_REPOSITORIO_PG".toUpperCase();
		final String nombrePL = "VE_listar_DocDigScoring_PR".toUpperCase();
		final int cantidadParametros = 6;
		final String mensajeError = "Ocurrió un error al recuperar documentos digitalizados";
		try {
			final String sql = getSQL(nombrePackage, nombrePL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(1, numCorrelativo);
			cstmt.setObject(2, numSolScoring);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute(): Antes");
			cstmt.execute();
			logger.debug("cstmt.execute(): Despues");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}

			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(3);
			while (rs.next()) {
				int i = 1;
				DocDigitalizadoScoringDTO dto = new DocDigitalizadoScoringDTO();
				dto.setCodScoring(rs.getString(i++));
				dto.setDesScoring(rs.getString(i++));
				Date date = rs.getDate(i++);
				if (date != null) {
					dto.setFechaCreacion(global.obtenerFormatoCortoFecha().format(date));
					dto.setSubido("SI");
				}
				dto.setNombreUsuarioOra(rs.getString(i++));
				dto.setNombreArchivo(rs.getString(i++));
				dto.setNumCorrelativo(rs.getLong(i++));
				dto.setNumSolScoring(rs.getLong(i++));
				dto.setObservacion(rs.getString(i++));
				String requeridoScoring = rs.getString(i++);
				if (requeridoScoring.equals("1")) {
					dto.setRequeridoScoring(true);
					dto.setRequeridoScoringRep("SI");
				}
				else {
					dto.setRequeridoScoring(false);
					dto.setRequeridoScoringRep("NO");
				}
				dto.setValorContentType(rs.getString(i++));

				if (numCorrelativo != null) {
					// Incidencia 149265. No se ven los documentos asociados a las ventas.
					Blob blob = rs.getBlob(i++);
					if (blob != null) {
						byte[] bytes = blob.getBytes(1, (int) blob.length());
						dto.setBinArchivo(bytes);
					}
				}
				lista.add(dto);
				logger.trace(dto.toString());
			}
			r = (DocDigitalizadoScoringDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
					DocDigitalizadoScoringDTO.class);
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.error("Codigo de Error [" + codError + "]");
			logger.error("Mensaje de Error [" + msgError + "]");
			logger.error("Numero de Evento [" + numEvento + "]");
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("recuperados [" + r.length + "]");
		logger.info("obtenerDocDigitalizadosScoring, Fin");
		return r;
	}

}
