package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.TipoDocDigitalizadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

/**
 * @author JIB
 *
 */
public class DocDigitalizadoDAO extends ConnectionDAO {

	final Global global = Global.getInstance();

	final Logger logger = Logger.getLogger(this.getClass());

	protected Connection getConection() throws CustomerDomainException {
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		}
		catch (Exception e1) {
			conn = null;
			logger.error("No se pudo obtener una conexión", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}

	protected String getSQL(String packageName, String procedureName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();
	}

	public void eliminarDocDigitalizado(long numCorrelativo) throws CustomerDomainException {
		final String nombreMetodo = "eliminarDocDigitalizado";
		logger.info(nombreMetodo + ", Inicio");
		logger.debug("numCorrelativo [" + numCorrelativo + "]");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "GA_REPOSITORIO_PG";
		final String nombrePL = "VE_Del_DocDigitalizados_PR";
		final String mensajeError = "Ocurrió un error al eliminar documento";
		final int cantidadParametros = 4;
		try {
			final String sql = getSQL(nombrePackage, nombrePL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			int i = 1;
			logger.debug("numCorrelativo: " + numCorrelativo);
			cstmt.setLong(i++, numCorrelativo);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			logger.debug("cstmt.execute(): Antes");
			cstmt.execute();
			logger.debug("cstmt.execute(): Despues");
			codError = cstmt.getInt(i - 3);
			msgError = cstmt.getString(i - 2);
			numEvento = cstmt.getInt(i - 1);
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.debug("Codigo de Error [" + codError + "]");
			logger.debug("Mensaje de Error [" + msgError + "]");
			logger.debug("Numero de Evento [" + numEvento + "]");
		}
		finally {
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
	}

	public Long insertarDocDigitalizado(DocDigitalizadoDTO dto) throws CustomerDomainException {
		final String nombreMetodo = "insertarDocDigitalizado";
		logger.info(nombreMetodo + ", inicio");
		Long r = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "GA_REPOSITORIO_PG";
		final String nombrePL = "VE_Ins_DocDigitalizados_PR";
		final String mensajeError = "Ocurrió un error al insertar documento";
		final int cantidadParametros = 11;
		logger.debug(dto.toString());
		try {
			final String sql = getSQL(nombrePackage, nombrePL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			int i = 1;
			cstmt.setLong(i++, dto.getNumVenta());
			cstmt.setLong(i++, dto.getCodTipoDocDigitalizado());
			cstmt.setString(i++, dto.getObservacion());
			cstmt.setString(i++, dto.getNombreUsuarioOra());
			cstmt.setString(i++, dto.getValorContentType());
			cstmt.setString(i++, dto.getNombreArchivo());
			cstmt.setBytes(i++, dto.getBinArchivo());
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute(): Antes");
			cstmt.execute();
			logger.debug("cstmt.execute(): Despues");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			r = new Long(cstmt.getLong(cantidadParametros - 3));
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.debug("Codigo de Error [" + codError + "]");
			logger.debug("Mensaje de Error [" + msgError + "]");
			logger.debug("Numero de Evento [" + numEvento + "]");
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

	public TipoDocDigitalizadoDTO[] obtenerTiposDocDigitalizado() throws CustomerDomainException {
		final String nombreMetodo = "obtenerTiposDocDigitalizado";
		logger.info(nombreMetodo + ", inicio");
		TipoDocDigitalizadoDTO[] r = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		final String nombrePackage = "GA_REPOSITORIO_PG";
		final String nombrePL = "VE_getList_TiposDocumentos_PR";
		final int cantidadParametros = 4;
		final String mensajeError = "Ocurrió un error al recuperar tipos de documentos digitalizados";
		try {
			final String sql = getSQL(nombrePackage, nombrePL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			int i = 1;
			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute(): Antes");
			cstmt.execute();
			logger.debug("cstmt.execute(): Despues");

			codError = cstmt.getInt(i - 3);
			msgError = cstmt.getString(i - 2);
			numEvento = cstmt.getInt(i - 1);
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			logger.debug("cstmt.execute(): Recuperando data");
			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(i - cantidadParametros);
			while (rs.next()) {
				i = 1;
				TipoDocDigitalizadoDTO dto = new TipoDocDigitalizadoDTO();
				dto.setCodTipoDocDigitalizado(rs.getString(i++));
				dto.setDesTipoDocDigitalizado(rs.getString(i++));
				lista.add(dto);
			}
			r = (TipoDocDigitalizadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
					TipoDocDigitalizadoDTO.class);
			logger.debug("Finalizo ejecución");
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
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
		logger.info(nombreMetodo + ", Fin");
		return r;
	}

	public DocDigitalizadoDTO obtenerDocDigitalizado(long numCorrelativo) throws CustomerDomainException {
		final String nombreMetodo = "obtenerDocDigitalizado";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("numCorrelativo [" + numCorrelativo + "]");
		DocDigitalizadoDTO r = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		final String nombrePackage = "GA_REPOSITORIO_PG";
		final String nombrePL = "VE_getList_DocDigitalizados_PR";
		final int cantidadParametros = 7;
		final String mensajeError = "Ocurrió un error al recuperar documentos";
		try {
			final String sql = getSQL(nombrePackage, nombrePL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			int i = 1;
			cstmt.setObject(i++, null);
			logger.debug("numCorrelativo: " + numCorrelativo);
			cstmt.setLong(i++, numCorrelativo);
			cstmt.setObject(i++, null);
			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			logger.debug("cstmt.execute(): Antes");
			cstmt.execute();
			logger.debug("cstmt.execute(): Despues");
			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			rs = (ResultSet) cstmt.getObject(cantidadParametros - 3);
			while (rs.next()) {
				i = 1;
				DocDigitalizadoDTO dto = new DocDigitalizadoDTO();
				dto.setNumCorrelativo(rs.getLong(i++));
				dto.setObservacion(rs.getString(i++));
				dto.setValorContentType(rs.getString(i++));
				dto.setNombreArchivo(rs.getString(i++));
				dto.setFechaCreacion(global.obtenerFormatoCortoFecha().format(rs.getDate(i++)));
				dto.setCodTipoDocDigitalizado(rs.getLong(i++));
				dto.setDesTipoDocDigitalizado(rs.getString(i++));
				dto.setNumVenta(rs.getInt(i++));

				// Incidencia 149265. No se ven los documentos asociados a las ventas.
				Blob blob = rs.getBlob(i++);
				if (blob != null) {
					byte[] bytes = blob.getBytes(1, (int) blob.length());
					dto.setBinArchivo(bytes);
				}
				r = dto;
			}
			logger.debug("Finalizo ejecución");
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
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
		logger.info(nombreMetodo + ", fin");
		return r;
	}

	public DocDigitalizadoDTO[] obtenerDocDigitalizados(long numVenta) throws CustomerDomainException {
		final String nombreMetodo = "obtenerDocDigitalizados";
		logger.info(nombreMetodo + ", inicio");
		logger.debug("numVenta [" + numVenta + "]");
		DocDigitalizadoDTO[] r = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		final String nombrePackage = "GA_REPOSITORIO_PG";
		final String nombrePL = "VE_getList_DocDigitalizados_PR";
		final int cantidadParametros = 7;
		final String mensajeError = "Ocurrió un error al recuperar documentos digitalizados";
		try {
			final String sql = getSQL(nombrePackage, nombrePL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			int i = 1;
			cstmt.setLong(i++, numVenta);
			cstmt.setObject(i++, null);
			cstmt.setObject(i++, null);
			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute(): Antes");
			cstmt.execute();
			logger.debug("cstmt.execute(): Despues");

			codError = cstmt.getInt(i - 3);
			msgError = cstmt.getString(i - 2);
			numEvento = cstmt.getInt(i - 1);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			logger.debug("cstmt.execute(): Recuperando data");
			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(i - 4);
			while (rs.next()) {
				i = 1;
				DocDigitalizadoDTO dto = new DocDigitalizadoDTO();
				dto.setNumCorrelativo(rs.getLong(i++));
				dto.setObservacion(rs.getString(i++));
				dto.setValorContentType(rs.getString(i++));
				dto.setNombreArchivo(rs.getString(i++));
				dto.setFechaCreacion(global.obtenerFormatoCortoFecha().format(rs.getDate(i++)));
				dto.setCodTipoDocDigitalizado(rs.getLong(i++));
				dto.setDesTipoDocDigitalizado(rs.getString(i++));
				dto.setNumVenta(rs.getInt(i++));
				lista.add(dto);
			}
			r = (DocDigitalizadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DocDigitalizadoDTO.class);
			logger.debug("Finalizó ejecución");
		}
		catch (Exception e) {
			logger.error(StackTraceUtl.getStackTrace(e));
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
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
		logger.info(nombreMetodo + ", fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param dto
	 * @return
	 * @throws CustomerDomainException
	 */
	public void actualizarDocDigitalizado(DocDigitalizadoDTO dto) throws CustomerDomainException {
		final String nombreMetodo = "actualizarDocDigitalizado";
		logger.info(nombreMetodo + ", inicio");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		final String nombrePackage = "GA_REPOSITORIO_PG";
		final String nombrePLSQL = "VE_UPDATE_DOCDIGITALIZADO_PR";
		final int cantidadParametros = 9;
		final String mensajeError = "Ocurrió un error al actualizar documento";
		try {
			int i = 1;
			final String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setLong(i++, dto.getNumCorrelativo());
			cstmt.setString(i++, dto.getNombreUsuarioOra());
			cstmt.setString(i++, dto.getNombreArchivo());
			cstmt.setString(i++, dto.getObservacion());
			cstmt.setString(i++, dto.getValorContentType());
			cstmt.setBytes(i++, dto.getBinArchivo());
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute(): Antes");
			cstmt.execute();
			logger.debug("cstmt.execute(): Después");

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
	}

}