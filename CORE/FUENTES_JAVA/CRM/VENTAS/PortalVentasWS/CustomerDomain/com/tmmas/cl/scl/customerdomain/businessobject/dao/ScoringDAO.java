package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto.AltaLineaWebDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.BusquedaSolScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.EstadoScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.LineaSolicitudScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ProductoOfertadoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ReporteScoringDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ResultadoScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.ScoreClienteDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.SolScoringVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.TipoComportamientoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DatosGeneralesScoringDTO;

public class ScoringDAO extends ConnectionDAO {
	protected Global global = Global.getInstance();

	private final Logger logger = Logger.getLogger(ScoringDAO.class);

	protected Connection getConection() throws CustomerDomainException {
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		}
		catch (Exception e1) {
			conn = null;
			logger.error("No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}

	protected String getSQL(String packageName, String procedureName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName.toUpperCase() + "." + procedureName.toUpperCase() + "(\n");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",\n");
		}
		return sb.append(")}").toString();
	}

	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public long insertarSolicitudScoring(ScoreClienteDTO dto) throws CustomerDomainException {
		logger.info("insertarSolicitudScoring, inicio");
		final String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		final String nombrePLSQL = "VE_inserta_solScoring_PR".toUpperCase();
		final int cantidadParametros = 34;
		String mensajeError = "Ocurrió un error al insertar la solicitud de Scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		long numSolicitudScoring = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug(dto.toString());
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(i++, dto.getAplicaTarjeta()); // APLICA_TARJETA
			cstmt.setString(i++, dto.getPrimer_nombre());
			cstmt.setString(i++, dto.getSegundo_nombre());
			cstmt.setString(i++, dto.getPrimer_apellido());
			cstmt.setString(i++, dto.getSegundo_apellido());
			cstmt.setString(i++, dto.getCodTipoDocumento());
			cstmt.setObject(i++, dto.getDocumento());
			cstmt.setObject(i++, dto.getNit());
			cstmt.setDate(i++, new java.sql.Date(dto.getFecha_nacimiento().getTime()));
			cstmt.setObject(i++, null); // EV_CAPACIDAD_PAGO
			cstmt.setObject(i++, dto.getAntiguedad_laboral());
			cstmt.setObject(i++, null); // TIPO_PRODUCTO
			cstmt.setString(i++, dto.getNomUsuarioOra());
			cstmt.setLong(i++, dto.getCodCliente());
			cstmt.setObject(i++, dto.getCodTipoTarjeta()); // EV_COD_TIPO_TARJETA
			cstmt.setString(i++, dto.getCodNacionalidad());
			cstmt.setObject(i++, dto.getCodNivelAcademico());
			cstmt.setString(i++, dto.getCodEstadoCivil());
			cstmt.setString(i++, dto.getCodTipoEmpresa());
			cstmt.setObject(i++, dto.getDesTipoTarjeta()); // EV_DES_TIPO_TARJETA
			cstmt.setString(i++, dto.getDesNacionalidad());
			cstmt.setObject(i++, dto.getDesNivelAcademico());
			cstmt.setString(i++, dto.getDesEstadoCivil());
			cstmt.setString(i++, dto.getDesTipoEmpresa());
			cstmt.setString(i++, dto.getDesTipoDocumento());
			cstmt.setObject(i++, dto.getNumTarjeta());
			cstmt.setObject(i++, dto.getCodBancoTarjeta());
			cstmt.setObject(i++, dto.getMesVencimientoTarjeta());
			cstmt.setObject(i++, dto.getAnioVencimientoTarjeta());
			cstmt.setObject(i++, dto.getCodTipoTarjetaSCL());
			
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			numSolicitudScoring = cstmt.getLong(cantidadParametros - 3);
			logger.debug("numSolicitudScoring: " + numSolicitudScoring);
			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("insertarSolicitudScoring, fin");
		return numSolicitudScoring;
	}

	public ScoreClienteDTO[] getSolicitudesScoring(BusquedaSolScoringDTO entrada) 
		throws CustomerDomainException 
	{
		logger.info("getSolicitudesScoring:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ScoreClienteDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		String nombrePLSQL = "VE_obtiene_SolicitudScoring_PR".toUpperCase();
		int cantidadParametros = 11;
		String mensajeError = "Ocurrió un error al consultar las solicitudes de scoring";
		logger.info("Coneccion obtenida OK");
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.info("sql[" + sql + "]");
			cstmt = conn.prepareCall(sql);

			cstmt.setLong(1, entrada.getCodigoVendedor().longValue());
			cstmt.setLong(2, entrada.getNroSolicitud().longValue());
			cstmt.setString(3, entrada.getCodOficina());
			cstmt.setString(4, entrada.getFechaDesde());
			cstmt.setString(5, entrada.getFechaHasta());
			cstmt.setLong(6, entrada.getCodCliente().longValue());
			cstmt.setString(7, entrada.getCodEstadoSolicitud());

			cstmt.registerOutParameter(8, OracleTypes.CURSOR);

			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			logger.info("Execute Antes");
			cstmt.execute();
			logger.info("Execute Despues");
			codError = cstmt.getInt(9);
			logger.info("codError[" + codError + "]");
			msgError = cstmt.getString(10);
			logger.info("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(11);
			logger.info("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.info(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);

			}
			else {
				logger.info("Llenado solicitudes");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(8);
				while (rs.next()) {

					ScoreClienteDTO solicitud = new ScoreClienteDTO();
					solicitud.setNumSolScoring(rs.getLong(1));
					solicitud.setFecha_creacion(rs.getTimestamp(2));
					solicitud.setPrimer_nombre(rs.getString(3));
					solicitud.setSegundo_nombre(rs.getString(4));
					solicitud.setPrimer_apellido(rs.getString(5));
					solicitud.setSegundo_apellido(rs.getString(6));
					solicitud.getDatosGeneralesScoringDTO().setNombreVendedor(rs.getString(7));
					solicitud.getDatosGeneralesScoringDTO().setCodOficina(rs.getString(8));
					solicitud.getDatosGeneralesScoringDTO().setCodVendedor(rs.getLong(9));
					solicitud.setCodCliente(rs.getLong(10));
					solicitud.setNit(rs.getString(11));
					solicitud.getDatosGeneralesScoringDTO().setCodModVenta(new Integer(rs.getInt(12)));
					solicitud.getDatosGeneralesScoringDTO().setCodTipContrato(rs.getString(13));
					solicitud.getDatosGeneralesScoringDTO().setCodCuota(rs.getString(15));
					solicitud.getDatosGeneralesScoringDTO().setCodVendedorDealer(new Long(rs.getLong(16)));
					solicitud.getDatosGeneralesScoringDTO().setCodTipComis(rs.getString(17));
					solicitud.getEstadoActualDTO().setCodEstado(rs.getString(18));
					solicitud.getEstadoActualDTO().setDesEstado(rs.getString(19));
					lista.add(solicitud);
				}
				resultado = (ScoreClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						ScoreClienteDTO.class);
				logger.info("Fin Llenado solicitudes");
			}
			if (logger.isDebugEnabled()) {
				logger.info(" Finalizo ejecución");
				logger.info(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.info(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.info("Cerrando conexiones...");
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
				logger.info("SQLException", e);
			}
		}
		logger.debug("encontrados [" + resultado.length + "]");
		logger.info("getSolicitudesScoring():end");
		return resultado;
	}

	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void grabarDatosGeneralesScoring(DatosGeneralesScoringDTO dto) throws CustomerDomainException {
		logger.info("grabarDatosGeneralesScoring, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_insert_datGenerScoring_PR";
		int cantidadParametros = 16;
		String mensajeError = "Ocurrió un error al insertar la datos generales de Scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug(dto.toString());
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setLong(i++, dto.getNumSolScoring());
			cstmt.setObject(i++, dto.getCodOficina());
			cstmt.setObject(i++, dto.getCodTipComis());
			cstmt.setObject(i++, dto.getCodModVenta());
			cstmt.setObject(i++, dto.getCodTipContrato());
			cstmt.setObject(i++, dto.getCodCuota());
			cstmt.setLong(i++, dto.getCodVendedor());
			cstmt.setObject(i++, dto.getCodVendedorDealer());
			cstmt.setObject(i++, dto.getCodAgente());
			cstmt.setObject(i++, dto.getCodPeriodo());
			cstmt.setObject(i++, dto.getMontoPreautorizado());
			cstmt.setObject(i++, dto.getFacturaTercero());
			cstmt.setObject(i++, dto.getIndVtaExterna());
			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("grabarDatosGeneralesScoring, fin");
	}

	/**
	 * @author JIB
	 * @param numSolScoring
	 * @throws CustomerDomainException
	 */
	public ScoreClienteDTO getSolicitudScoring(Long numSolScoring) throws CustomerDomainException {
		logger.info("getSolicitudScoring, inicio");
		final String nombrePackage = "VE_SOL_SCORING_PG";
		final String nombrePLSQL = "VE_obtiene_SolicitudScoring_PR".toUpperCase();
		final int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al obtener los datos generales de Scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ScoreClienteDTO dto = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(i++, numSolScoring);

			cstmt.registerOutParameter(cantidadParametros - 3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			else {
				rs = (ResultSet) cstmt.getObject(cantidadParametros - 3);
				while (rs.next()) {
					i = 1;
					dto = new ScoreClienteDTO();
					dto.setNumSolScoring(rs.getLong(i++));
					dto.setAplicaTarjeta(rs.getString(i++));
					dto.setCodTipoTarjeta(rs.getString(i++));
					dto.setFecha_creacion(rs.getTimestamp(i++));
					dto.setPrimer_nombre(rs.getString(i++));
					dto.setSegundo_nombre(rs.getString(i++));
					dto.setPrimer_apellido(rs.getString(i++));
					dto.setSegundo_apellido(rs.getString(i++));
					dto.setCodTipoDocumento(rs.getString(i++));
					dto.setDocumento(rs.getString(i++));
					dto.setNit(rs.getString(i++));
					dto.setFecha_nacimiento(rs.getDate(i++));
					dto.setCapacidad_pago(rs.getString(i++));
					dto.setCodNacionalidad(rs.getString(i++));
					dto.setCodNivelAcademico(rs.getString(i++));
					dto.setCodEstadoCivil(rs.getString(i++));
					dto.setCodTipoEmpresa(rs.getString(i++));
					dto.setAntiguedad_laboral(rs.getString(i++));
					dto.setTip_producto(rs.getString(i++));
					dto.setNomUsuarioOra(rs.getString(i++));
					dto.setCodCliente(rs.getLong(i++));
					dto.setDesEstadoCivil((String) rs.getObject(i++));
					dto.setDesNacionalidad((String) rs.getObject(i++));
					dto.setDesTipoEmpresa((String) rs.getObject(i++));
					dto.setDesNivelAcademico((String) rs.getObject(i++));
					dto.setDesTipoTarjeta((String) rs.getObject(i++));
					dto.setDesTipoDocumento((String) rs.getObject(i++));
					dto.setNumTarjeta((String) rs.getObject(i++));
					dto.setCodBancoTarjeta((String) rs.getObject(i++));
					dto.setMesVencimientoTarjeta(new Integer(rs.getInt(i++)).toString());
					dto.setAnioVencimientoTarjeta(new Integer(rs.getInt(i++)).toString());
					dto.setCodTipoTarjetaSCL(rs.getString(i++));
					DatosGeneralesScoringDTO dgDto = dto.getDatosGeneralesScoringDTO();
					dgDto.setCodOficina((String) rs.getObject(i++));
					dgDto.setCodTipComis((String) rs.getObject(i++));
					dgDto.setCodModVenta(new Integer(rs.getInt(i++)));
					dgDto.setCodTipContrato((String) rs.getObject(i++));
					dgDto.setCodCuota((String) rs.getObject(i++));
					dgDto.setCodVendedor(rs.getLong(i++));
					dgDto.setCodVendedorDealer(new Long(rs.getInt(i++)));
					dgDto.setCodAgente(new Long(rs.getInt(i++)));
					dgDto.setCodPeriodo(new Long(rs.getInt(i++)));
					EstadoScoringDTO esDto = dto.getEstadoActualDTO();
					esDto.setCodEstado(rs.getString(i++));
					esDto.setCodVendedor(rs.getLong(i++));
					esDto.setDesEstado(rs.getString(i++));
					dgDto.setIndVtaExterna(String.valueOf(rs.getInt(i++)));
					esDto.setNumSolScoring(dto.getNumSolScoring());
					dgDto.setNumSolScoring(dto.getNumSolScoring());
					logger.debug(dto.toString());
				}
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("getSolicitudScoring, fin");
		return dto;
	}

	public void insertaEstadoScoring(EstadoScoringDTO entrada) 
		throws CustomerDomainException 
	{
		logger.info("insertaEstadoScoring, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_inserta_estadoScoring_PR";
		int cantidadParametros = 6;
		String mensajeError = "Ocurrió un error al insertar el estado Scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug(entrada.toString());
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setLong(1, entrada.getNumSolScoring());
			logger.info("entrada.getNumSolScoring():" + entrada.getNumSolScoring());
			cstmt.setString(2, entrada.getCodEstado());
			logger.info("entrada.getCodEstado():" + entrada.getCodEstado());
			cstmt.setLong(3, entrada.getCodVendedor());
			logger.info("entrada.getCodVendedor():" + entrada.getCodVendedor());

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("insertaEstadoScoring, fin");
	}

	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void actualizaScoreCliente(ScoreClienteDTO dto) throws CustomerDomainException {
		logger.info("actualizaScoreCliente, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_update_SolScoring_PR";
		int cantidadParametros = 6;
		String mensajeError = "Ocurrió un error al actualizar la solicitud de Scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug(dto.toString());
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);

			cstmt.setLong(i++, dto.getNumSolScoring());
			cstmt.setString(i++, dto.getCapacidad_pago());
			cstmt.setString(i++, dto.getTip_producto());

			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (CustomerDomainException e) {
			throw e;
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("actualizaScoreCliente, fin");
	}

	public LineaSolicitudScoringDTO[] getlineasSolScoring(Long entrada) 
		throws CustomerDomainException 
	{
		logger.info("getlineasSolScoring:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		LineaSolicitudScoringDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		String nombrePLSQL = "VE_obtiene_lineasSolScoring_PR".toUpperCase();
		int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al consultar las lineas asociadas a la solicitud de scoring";
		logger.info("Coneccion obtenida OK");
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.info("sql[" + sql + "]");
			cstmt = conn.prepareCall(sql);

			cstmt.setLong(1, entrada.longValue());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.info("Execute Antes");
			cstmt.execute();
			logger.info("Execute Despues");
			codError = cstmt.getInt(3);
			logger.info("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.info("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.info("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.info(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);

			}
			else {
				logger.info("Llenado solicitudes");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {

					LineaSolicitudScoringDTO linea = new LineaSolicitudScoringDTO();
					linea.setNumLineaScoring(rs.getLong(1));
					linea.setCodCentral(rs.getLong(2));
					linea.setCodPrestacion(rs.getString(3));
					linea.setCodGrpPrestacion(rs.getString(4));
					linea.setCodPlantarif(rs.getString(5));
					linea.setCodUso(rs.getShort(6));
					linea.setDesPrestacion(rs.getString(7));
					linea.setDesPlanTarifario(rs.getString(8));					
					lista.add(linea);
				}
				resultado = (LineaSolicitudScoringDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						LineaSolicitudScoringDTO.class);
				logger.info("Fin Llenado lineas");
			}
			if (logger.isDebugEnabled()) {
				logger.info(" Finalizo ejecución");
				logger.info(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.info(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.info("Cerrando conexiones...");
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
				logger.info("SQLException", e);
			}
		}
		logger.debug("encontrados [" + resultado.length + "]");
		logger.info("getlineasSolScoring():end");
		return resultado;
	}

	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public long insertarLineaScoring(LineaSolicitudScoringDTO dto) throws CustomerDomainException {
		logger.info("insertarLineaScoring, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_inserta_lineaScoring_PR".toUpperCase();
		int cantidadParametros = 30;
		String mensajeError = "Ocurrió un error al grabar línea solicitud scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		long numLineaScoring = 0;
		logger.debug(dto.toString());
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);

			cstmt.setLong(i++, dto.getCodArticuloEquipo());
			cstmt.setString(i++, dto.getCodCelda());
			cstmt.setLong(i++, dto.getCodCentral());
			cstmt.setString(i++, dto.getCodDepartamento());
			cstmt.setObject(i++, dto.getCodMonedaCargoBasico());
			cstmt.setObject(i++, dto.getCodMonedaSeguro());

			cstmt.setString(i++, dto.getCodMunicipio());
			cstmt.setString(i++, dto.getCodPlanServ());
			cstmt.setObject(i++, dto.getCodPlantarif());
			cstmt.setString(i++, dto.getCodPrestacion());
			cstmt.setObject(i++, dto.getCodSeguro());
			cstmt.setInt(i++, dto.getCodUso());

			cstmt.setString(i++, dto.getCodZona());
			cstmt.setDouble(i++, dto.getImporteCargoBasico().doubleValue());
			cstmt.setDouble(i++, dto.getImporteArticulo().doubleValue());
			cstmt.setDouble(i++, dto.getImporteSeguro().doubleValue());
			cstmt.setLong(i++, dto.getNumSolScoring());
			cstmt.setString(i++, dto.getCodTecnologia());
			cstmt.setString(i++, dto.getCodSubAlm());
			cstmt.setString(i++, dto.getCodCausaDescuento());
			cstmt.setString(i++, dto.getCodCampanaVigente());
			cstmt.setString(i++, dto.getCodLimiteConsumo());
			cstmt.setObject(i++, dto.getIndRenovacion());
			cstmt.setObject(i++, dto.getCodTipoTerminal());
			cstmt.setString(i++, dto.getCodCalificacion());
			cstmt.setDouble(i++, dto.getMontoLimiteConsumo().doubleValue());

			cstmt.registerOutParameter(cantidadParametros - 3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			numLineaScoring = cstmt.getLong(cantidadParametros - 3);
			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (CustomerDomainException e) {
			throw e;
		}
		catch (Exception e) {
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("insertarLineaScoring, fin");
		return numLineaScoring;
	}

	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void insertarResultadoScoreCliente(ResultadoScoreClienteDTO dto) throws CustomerDomainException {
		String nombreMetodo = "insertarResultadoScoreCliente";
		logger.info(nombreMetodo + ", " + "inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_inserta_salidaScoring_PR".toUpperCase();
		int cantidadParametros = 8;
		String mensajeError = "Ocurrió un error en " + nombreMetodo;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug(dto.toString());
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setLong(i++, dto.getNumSolScoring());
			cstmt.setString(i++, dto.getMensaje());
			cstmt.setString(i++, dto.getReferencia());
			cstmt.setString(i++, dto.getClasificacion());
			cstmt.setObject(i++, dto.getPunteo());
			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info(nombreMetodo + ", " + "fin");
	}

	public LineaSolicitudScoringDTO getDetalleLineaScoring(Long numLineaScoring) 
		throws CustomerDomainException 
	{
		logger.info("getDetalleLineaScoring:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		LineaSolicitudScoringDTO resultado = new LineaSolicitudScoringDTO();
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		ResultSet rs2 = null;
		String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		String nombrePLSQL = "VE_obtiene_lineaScoring_PR".toUpperCase();
		int cantidadParametros = 6;
		String mensajeError = "Ocurrió un error obtener detalle de la linea scoring";
		logger.info("Coneccion obtenida OK");
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.info("sql[" + sql + "]");
			cstmt = conn.prepareCall(sql);

			cstmt.setLong(1, numLineaScoring.longValue());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);

			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			logger.info("Execute Antes");
			cstmt.execute();
			logger.info("Execute Despues");
			codError = cstmt.getInt(4);
			logger.info("codError[" + codError + "]");
			msgError = cstmt.getString(5);
			logger.info("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(6);
			logger.info("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.info(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);

			}
			else {
				logger.info("Llenado linea scoring");
				rs = (ResultSet) cstmt.getObject(2);
				if (rs.next()) {
					resultado.setCodDepartamento(rs.getString(2));
					resultado.setCodMunicipio(rs.getString(3));
					resultado.setCodZona(rs.getString(4));
					resultado.setCodCelda(rs.getString(5));
					resultado.setCodCentral(rs.getLong(6));
					resultado.setCodPrestacion(rs.getString(7));
					resultado.setCodPlantarif(rs.getString(8));
					resultado.setCodUso(rs.getInt(9));
					resultado.setCodPlanServ(rs.getString(10));
					resultado.setCodArticuloEquipo(rs.getLong(11));
					resultado.setCodSeguro(rs.getString(12));
					resultado.setCodTecnologia(rs.getString(13));
					resultado.setCodSubAlm(rs.getString(14));
					resultado.setCodGrpPrestacion(rs.getString(15));
					resultado.setCodTipoTerminal(rs.getString(16));
					resultado.setCodLimiteConsumo(rs.getString(17));
					resultado.setMontoLimiteConsumo(new Double(rs.getDouble(18)));
				}
				
				rs2 = (ResultSet) cstmt.getObject(3);
				ArrayList lista = new ArrayList();
				while (rs2.next()) {
					lista.add(rs2.getString(2));			
				}
				resultado.setArrayListServSup(lista);
				logger.info("Fin Llenado linea scoring");
			}
			if (logger.isDebugEnabled()) {
				logger.info(" Finalizo ejecución");
				logger.info(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.info(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.info("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (rs2 != null)
					rs2.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.info("SQLException", e);
			}
		}
		logger.info("getDetalleLineaScoring():end");
		return resultado;
	}

	public void updLineaScoringReplicada(Long numLineaScoring, Long numAbonado) 
		throws CustomerDomainException 
	{
		logger.info("updLineaScoringReplicada:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		String nombrePLSQL = "VE_updLineaScoring_PR".toUpperCase();
		int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error cambiar estado de la linea scoring a replicada";
		logger.info("Coneccion obtenida OK");
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.info("sql[" + sql + "]");
			cstmt = conn.prepareCall(sql);

			cstmt.setLong(1, numLineaScoring.longValue());
			cstmt.setLong(2, numAbonado.longValue());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.info("Execute Antes");
			cstmt.execute();
			logger.info("Execute Despues");
			codError = cstmt.getInt(3);
			logger.info("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.info("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.info("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.info(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);

			}
			if (logger.isDebugEnabled()) {
				logger.info(" Finalizo ejecución");
				logger.info(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.info(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.info("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.info("SQLException", e);
			}
		}
		logger.info("updLineaScoringReplicada():end");
	}

	public void insertaSolScoringVenta(SolScoringVentaDTO entrada) 
		throws CustomerDomainException 
	{
		logger.info("insertaSolScoringVenta:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		String nombrePLSQL = "VE_inserta_solScoringVta_PR".toUpperCase();
		int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al insertar la venta asociada  ala solicitud  de scoring";
		logger.info("Coneccion obtenida OK");
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.info("sql[" + sql + "]");
			cstmt = conn.prepareCall(sql);

			cstmt.setLong(1, entrada.getNumSolScoring());
			cstmt.setLong(2, entrada.getNumVenta());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.info("Execute Antes");
			cstmt.execute();
			logger.info("Execute Despues");
			codError = cstmt.getInt(3);
			logger.info("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.info("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.info("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.info(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);

			}
			if (logger.isDebugEnabled()) {
				logger.info(" Finalizo ejecución");
				logger.info(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.info(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.info("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.info("SQLException", e);
			}
		}
		logger.info("insertaSolScoringVenta():end");
	}

	public Double calcularCapacidadPago(Long numSolScoring) 
		throws CustomerDomainException 
	{
		logger.info("calcularCapacidadPago:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Double resultado = new Double(0);
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		String nombrePLSQL = "VE_calcula_capacidadpago_PR".toUpperCase();
		int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al calcular la capacidad de pago";
		logger.info("Conexion obtenida OK");
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.info("sql[" + sql + "]");
			cstmt = conn.prepareCall(sql);

			cstmt.setLong(1, numSolScoring.longValue());
			cstmt.registerOutParameter(2, OracleTypes.NUMERIC);

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			logger.info("Execute Antes");
			cstmt.execute();
			logger.info("Execute Despues");
			codError = cstmt.getInt(3);
			logger.info("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.info("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.info("numEvento[" + numEvento + "]");
			if (codError != 0) {
				logger.info(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);

			}
			else {
				logger.info("Llenado linea scoring");
				resultado = new Double(cstmt.getDouble(2));
			}
			if (logger.isDebugEnabled()) {
				logger.info(" Finalizo ejecución");
				logger.info(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.info(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.info("Codigo de Error[" + codError + "]");
				logger.info("Mensaje de Error[" + msgError + "]");
				logger.info("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException(mensajeError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.info("Cerrando conexiones...");
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
				logger.info("SQLException", e);
			}
		}
		logger.debug("resultado [" + resultado + "]");
		logger.info("calcularCapacidadPago():end");
		return resultado;
	}

	/**
	 * @author JIB
	 * @param numSolicitud
	 * @throws CustomerDomainException
	 */
	public EstadoDTO[] obtenerEstadosDestino(String codPrograma, String codEstadoOrigen, String nomTabla)
			throws CustomerDomainException {
		logger.info("obtieneEstadosDestino, inicio");
		logger.debug("codPrograma [" + codPrograma + "]");
		logger.debug("codEstadoOrigen [" + codEstadoOrigen + "]");
		logger.debug("nomTabla [" + nomTabla + "]");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_OBTIENE_ESTADOSDESTINO_PR";
		int cantidadParametros = 7;
		String mensajeError = "Ocurrió un error al obtener los datos destino";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		EstadoDTO[] r = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(i++, codPrograma);
			cstmt.setObject(i++, codEstadoOrigen);
			cstmt.setObject(i++, nomTabla);

			cstmt.registerOutParameter(cantidadParametros - 3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(cantidadParametros - 3);
			while (rs.next()) {
				i = 1;
				EstadoDTO dto = new EstadoDTO();
				dto.setCodEstado(rs.getString(i++));
				dto.setDesEstado(rs.getString(i++));
				logger.debug(dto.toString());
				lista.add(dto);
			}
			r = (EstadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), EstadoDTO.class);
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null) {
					rs.close();
				}
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("obtieneEstadosDestino, fin");
		return r;
	}

	/**
	 * @author JIB
	 * @param dto
	 * @throws CustomerDomainException
	 */
	public void insertarServSupScoring(ListadoSSOutDTO dto, long numSolScoring, long numLineaScoring)
			throws CustomerDomainException {
		logger.info("insertarServicioSumplementario, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		String nombrePLSQL = "VE_inserta_ServSup_PR".toUpperCase();
		int cantidadParametros = 10;
		String mensajeError = "Ocurrió un error al insertar Servicios Suplementarios";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		logger.debug(dto.toString());
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setLong(i++, numSolScoring);
			cstmt.setLong(i++, numLineaScoring);
			cstmt.setString(i++, dto.getCodigoServicio());
			final String tarifaMensual = dto.getTarifaMensual();
			double tm = tarifaMensual == null || tarifaMensual.equals("") ? 0 : new Double(tarifaMensual).doubleValue();
			cstmt.setDouble(i++, tm);
			cstmt.setString(i++, dto.getMonedaMensual());
			
			final String tarifaConexion = dto.getTarifaConexion();
			double tc = tarifaConexion == null || tarifaConexion.equals("") ? 0 : new Double(tarifaConexion).doubleValue();
			cstmt.setDouble(i++, tc);
			cstmt.setString(i++, dto.getMonedaConexion());

			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("insertarServicioSumplementario, fin");
	}
	
	
	public Long obtenerNroventaSolScoring(Long numSolScoring)
		throws CustomerDomainException 
	{
		logger.info("obtieneEstadosDestino, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_OBTIENE_NUMVENTA_PR";
		int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al obtener número de venta asociado a la solicitud de scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		Long resultado = null;
		CallableStatement cstmt = null;		
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);		
		
			cstmt.setLong(1, numSolScoring.longValue());
			
			cstmt.registerOutParameter(2, OracleTypes.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");
		
			logger.info("Execute Despues");
			codError = cstmt.getInt(3);
			logger.info("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.info("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.info("numEvento[" + numEvento + "]");
		
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}else {
			    resultado = new Long(cstmt.getLong(2));
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("obtieneEstadosDestino, fin");
		return resultado;
	}
	
	public Long obtenerNroSolScoring(Long numVenta)
		throws CustomerDomainException 
	{
		logger.info("obtieneEstadosDestino, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_OBTIENE_NUMSCORING_PR";
		int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al obtener número de scoring asociado a la venta";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		Long resultado = null;
		CallableStatement cstmt = null;		
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);		
		
			cstmt.setLong(1, numVenta.longValue());
			
			cstmt.registerOutParameter(2, OracleTypes.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");
		
			logger.info("Execute Despues");
			codError = cstmt.getInt(3);
			logger.info("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.info("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.info("numEvento[" + numEvento + "]");
		
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}else {
			    resultado = new Long(cstmt.getLong(2));
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("obtieneEstadosDestino, fin");
		return resultado;
	}

	/**
	 * @author pv
	 * @param numSolScoring
	 * @throws CustomerDomainException
	 */
	public ReporteScoringDTO getReporteSolicitudScoring(Long numSolScoring) throws CustomerDomainException {
		logger.info("getReporteSolicitudScoring, inicio");
		logger.debug("numSolScoring [" + numSolScoring + "]");
		final String nombrePackage = "VE_SOL_SCORING_PG";
		final String nombrePLSQL = "VE_obtiene_RepSolScoring_PR";
		final int cantidadParametros = 9;
		String mensajeError = "Ocurrió un error al obtener reporte de Scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ReporteScoringDTO retorno = new ReporteScoringDTO();
		ScoreClienteDTO dto = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		ResultSet rs2 = null;
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(i++, numSolScoring);
			
			cstmt.registerOutParameter(cantidadParametros - 7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 4, OracleTypes.CURSOR);
			cstmt.registerOutParameter(cantidadParametros - 3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(cantidadParametros - 2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(cantidadParametros - 1, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantidadParametros - 0, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError  = cstmt.getInt(cantidadParametros - 2);
			msgError  = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);
			int cantidadLineas = 0;
			int cantidadPlanes = 0;
			String desPlanes = "";
			int cantidadServSup= 0;
			int cantidadRegScoring = 0;
			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			else {
				cantidadLineas  = cstmt.getInt(cantidadParametros - 7);
				cantidadPlanes  = cstmt.getInt(cantidadParametros - 6);
				cantidadServSup = cstmt.getInt(cantidadParametros - 5);
				rs = (ResultSet) cstmt.getObject(cantidadParametros - 4);
				rs2 = (ResultSet) cstmt.getObject(cantidadParametros - 3);
				while (rs.next()) {
					i = 1;
					dto = new ScoreClienteDTO();
					dto.setNumSolScoring(rs.getLong(i++));
					dto.setAplicaTarjeta(rs.getString(i++));
					dto.setCodTipoTarjeta(rs.getString(i++));
					dto.setFecha_creacion(rs.getTimestamp(i++));
					dto.setPrimer_nombre(rs.getString(i++));
					dto.setSegundo_nombre(rs.getString(i++));
					dto.setPrimer_apellido(rs.getString(i++));
					dto.setSegundo_apellido(rs.getString(i++));
					dto.setCodTipoDocumento(rs.getString(i++));
					dto.setDocumento(rs.getString(i++));
					dto.setNit(rs.getString(i++));
					dto.setFecha_nacimiento(rs.getDate(i++));
					dto.setCapacidad_pago(rs.getString(i++));
					dto.setCodNacionalidad(rs.getString(i++));
					dto.setCodNivelAcademico(rs.getString(i++));
					dto.setCodEstadoCivil(rs.getString(i++));
					dto.setCodTipoEmpresa(rs.getString(i++));
					dto.setAntiguedad_laboral(rs.getString(i++));
					dto.setTip_producto(rs.getString(i++));
					dto.setNomUsuarioOra(rs.getString(i++));
					dto.setCodCliente(rs.getLong(i++));
					dto.setDesEstadoCivil((String) rs.getObject(i++));
					dto.setDesNacionalidad((String) rs.getObject(i++));
					dto.setDesTipoEmpresa((String) rs.getObject(i++));
					dto.setDesNivelAcademico((String) rs.getObject(i++));
					dto.setDesTipoTarjeta((String) rs.getObject(i++));
					dto.setDesTipoDocumento((String) rs.getObject(i++));
					DatosGeneralesScoringDTO dgDto = dto.getDatosGeneralesScoringDTO();
					dgDto.setCodOficina((String) rs.getObject(i++));
					dgDto.setCodTipComis((String) rs.getObject(i++));
					dgDto.setCodModVenta(new Integer(rs.getInt(i++)));
					dgDto.setCodTipContrato((String) rs.getObject(i++));
					dgDto.setCodCuota((String) rs.getObject(i++));
					dgDto.setCodVendedor(rs.getLong(i++));
					dgDto.setCodVendedorDealer(new Long(rs.getInt(i++)));
					dgDto.setCodAgente(new Long(rs.getInt(i++)));
					dgDto.setCodPeriodo(new Long(rs.getInt(i++)));
					EstadoScoringDTO esDto = dto.getEstadoActualDTO();
					esDto.setCodEstado(rs.getString(i++));
					esDto.setCodVendedor(rs.getLong(i++));
					esDto.setDesEstado(rs.getString(i++));
					dgDto.setIndVtaExterna(String.valueOf(rs.getInt(i++)));
					esDto.setNumSolScoring(dto.getNumSolScoring());
					dgDto.setNumSolScoring(dto.getNumSolScoring());
					dgDto.setNombreVendedor(rs.getString(i++));
					retorno.setScoreClienteDTO(dto);
					retorno.setClasificacionCliente(rs.getString(i++));
					retorno.setCantidadLineas(cantidadLineas);
					retorno.setCantidadPlanes(cantidadPlanes);
					retorno.setCantidadServSup(cantidadServSup);
					cantidadRegScoring++;
					logger.debug(dto.toString());
				}				
				while (rs2.next()) {					
					desPlanes = desPlanes + rs2.getString(1) + " | ";			
					logger.debug("desPlanes" + desPlanes);
				}
				retorno.setDesPlanes(desPlanes.substring(0,desPlanes.length()-3));
			}
			logger.error("cantidadRegScoring[" + cantidadRegScoring+ "]");
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (rs2 != null)
					rs2.close();
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("getReporteSolicitudScoring, fin");
		return retorno;
	}

	/**
	 * @author pv
	 * @param numSolicitud
	 * @throws CustomerDomainException
	 */
	public EstadoScoringDTO[] getEstadosSolicitudScoring(Long numSolicitud) throws CustomerDomainException {
		logger.info("getEstadosSolicitudScoring, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_obtiene_EstSolScoring_PR";
		int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al obtener los estados de Scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		EstadoScoringDTO[] estadosScoring = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(1, numSolicitud);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			ArrayList lista = new ArrayList();
			
			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			else {
				
				rs = (ResultSet) cstmt.getObject(cantidadParametros - 3);
				while (rs.next()) {
					i = 1;
					EstadoScoringDTO esDto = new EstadoScoringDTO();
					esDto.setNumSolScoring(numSolicitud.longValue());
					esDto.setCodEstado(rs.getString(1));
					esDto.setDesEstado(rs.getString(2));
					esDto.setFechaInicio(rs.getTimestamp(3));
					esDto.setFechaTermino(rs.getDate(4));
					esDto.setCodVendedor(rs.getLong(5));
					lista.add(esDto);
				
					logger.debug(esDto.toString());
				}
				estadosScoring = (EstadoScoringDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), EstadoScoringDTO.class);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		
		logger.info("getEstadosSolicitudScoring, fin");
		return estadosScoring;
	}
	
	/**
	 * @author JIB
	 * @param numSolicitud
	 * @throws CustomerDomainException
	 */
	public EstadoScoringDTO[] obtenerEstadosSolicitudScoringXNumTarjeta(String codTipTarjetaSCL, String numTarjeta) throws CustomerDomainException {
		logger.info("getEstadoSolicitudScoringXNumTarjeta, inicio");
		logger.debug("codTipoTarjeta [" + codTipTarjetaSCL + "]");
		logger.debug("numTarjeta [" + numTarjeta + "]");
		final String nombrePackage = "VE_SOL_SCORING_PG";
		final String nombrePLSQL = "VE_obt_estScoring_X_tarjeta_PR";
		final int cantidadParametros = 6;
		String mensajeError = "Ocurrió un error al obtener estado solicitud scoring por N° tarjeta ";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		EstadoScoringDTO[] r = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			int i = 1;
			final String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(i++, codTipTarjetaSCL);
			cstmt.setObject(i++, numTarjeta);
			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			
			rs = (ResultSet) cstmt.getObject(cantidadParametros - 3);
			ArrayList lista = new ArrayList();
			while (rs.next()) {
				i = 1;
				EstadoScoringDTO dto = new EstadoScoringDTO();
				dto.setNumSolScoring(rs.getLong(i++));
				dto.setCodEstado(rs.getString(i++));
				dto.setDesEstado(rs.getString(i++));
				dto.setFechaInicio(rs.getDate(i++));
				dto.setFechaTermino(rs.getDate(i++));
				dto.setCodVendedor(rs.getLong(i++));
				dto.setNomVendedor(rs.getString(i++));
				logger.debug(dto.toString());
				lista.add(dto);
			}			
			r = (EstadoScoringDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), EstadoScoringDTO.class);
			
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			logger.error("codError [" + codError + "]");
			logger.error("msgError [" + msgError + "]");
			logger.error("numEvento [" + numEvento + "]");
			if (e instanceof CustomerDomainException) {
				throw (CustomerDomainException) e;
			}
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
 			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("r.length [" + r.length + "]");
		logger.info("getEstadoSolicitudScoringXNumTarjeta, fin");
		return r;
	}
	
	/**
	 * @author JIB
	 * @param numSolScoring
	 * @throws CustomerDomainException
	 */
	public ResultadoScoreClienteDTO getResultadoScoring(Long numSolScoring) throws CustomerDomainException {
		logger.info("getResultadoScoring, inicio");
		final String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		final String nombrePLSQL = "VE_get_ResultadoScoring_PR".toUpperCase();
		final int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al obtener resultado Scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ResultadoScoreClienteDTO dto = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			cstmt.setObject(i++, numSolScoring);

			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}

			rs = (ResultSet) cstmt.getObject(cantidadParametros - 3);
			while (rs.next()) {
				i = 1;
				dto = new ResultadoScoreClienteDTO();
				dto.setClasificacion(rs.getString(i++));
				dto.setMensaje(rs.getString(i++));
				dto.setNumSolScoring(rs.getLong(i++));
				dto.setPunteo(rs.getString(i++));
				dto.setReferencia(rs.getString(i++));
				logger.debug(dto.toString());
			}

		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			logger.error("codError [" + codError + "]");
			logger.error("msgError [" + msgError + "]");
			logger.error("numEvento [" + numEvento + "]");
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("getResultadoScoring, fin");
		return dto;
	}
	
	public TipoComportamientoDTO[] obtenerTiposComportamiento() 
		throws CustomerDomainException 
	{
		logger.info("obtenerTiposComportamiento, inicio");
		String nombrePackage = "PV_SERVICIOS_POSVENTA_PG";
		String nombrePLSQL = "PV_listaTiposComportamiento_PR";
		int cantidadParametros = 4;
		String mensajeError = "Ocurrió un error al obtener los tipos de comportamiento ";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		TipoComportamientoDTO[] resultado = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);			
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError  = cstmt.getInt(2);
			msgError  = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			ArrayList lista = new ArrayList();
			
			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			else {
				
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					i = 1;
					TipoComportamientoDTO tipoComportamiento = new TipoComportamientoDTO();					
					tipoComportamiento.setValor(rs.getString(1));
					tipoComportamiento.setDescripcionValor(rs.getString(2));					
					lista.add(tipoComportamiento);
				}
				resultado = (TipoComportamientoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), TipoComportamientoDTO.class);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		
		logger.info("obtenerTiposComportamiento, fin");
		return resultado;
	}

	/**
	 * @author JIB
	 * @param codPlanTarif
	 * @param codCanal
	 * @param nivel
	 * @param codPrestacion
	 * @param codigosTipoComportamiento
	 * @return
	 * @throws CustomerDomainException
	 */
	public ProductoOfertadoDTO[] obtenerProductosOfertadosXFiltros(final String codPlanTarif, 
			final String codCanal, final String nivel, final String codPrestacion, final String[] codigosTipoComportamiento)
			throws CustomerDomainException {
		logger.info("obtenerProductosOfertadosXFiltros, inicio");
		String nombrePackage = "PF_PRODUCTO_OFERTADO_PG";
		String nombrePLSQL = "PF_PRODUCTO_FILTRADO_S_PR";
		int cantidadParametros = 9;
		String mensajeError = "Ocurrió un error en obtenerProductosOfertadosXFiltros";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ProductoOfertadoDTO[] r = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		String tiposComportamientoEnCSV = "";
		for (int i = 0; i < codigosTipoComportamiento.length; i++) {
			tiposComportamientoEnCSV += codigosTipoComportamiento[i] + ",";
		}
		tiposComportamientoEnCSV = tiposComportamientoEnCSV.substring(0, tiposComportamientoEnCSV.length() - 1);
		logger.debug("tiposComportamientoEnCSV [" + tiposComportamientoEnCSV + "]");
		
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			
			cstmt.setObject(i++, codPlanTarif);
			cstmt.setObject(i++, codCanal);
			cstmt.setObject(i++, nivel);
			cstmt.setObject(i++, codPrestacion);
			cstmt.setObject(i++, tiposComportamientoEnCSV);

			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(cantidadParametros - 3);
			while (rs.next()) {
				i = 1;
				ProductoOfertadoDTO dto = new ProductoOfertadoDTO();
				dto.setCodProductoOfertado(rs.getLong(i++));
				dto.setIdProdOfertado(rs.getString(i++));
				dto.setCodCategoria(rs.getString(i++));
				dto.setDesProdOfertado(rs.getString(i++));
				dto.setTipoComportamiento(rs.getString(i++));
				dto.setMaxContrataciones(new Integer(rs.getInt(i++)));
				dto.setTipoRelacionPA(rs.getString(i++));/*INC-155400 JMO/05-11-2010*/
				//Inicio P-CSR-11002 JLGN 26-10-2011
				if(rs.getString(i++).equals("001")){
					dto.setDesMoneda("¢");
				}else{
					dto.setDesMoneda("$");
				}
				//dto.setDesMoneda(rs.getString(i++)); // P-CSR-11002 JLGN 26-10-2011
				//Fin P-CSR-11002 JLGN 26-10-2011
				dto.setMontoImporte(String.valueOf(rs.getLong(i++))); // P-CSR-11002 JLGN 01-07-2011
				logger.debug("TipoRelacionPA: "+dto.getTipoRelacionPA());
				logger.debug(dto.toString());
				lista.add(dto);
			}
			r = (ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ProductoOfertadoDTO.class);
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null) {
					rs.close();
				}
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("obtenerProductosOfertadosXFiltros, fin");
		return r;
	}
	
	/**
	 * @author Jacqueline Mendez Ortega 16-11-2010 INC-155400
	 * @param codPlanTarif
	 * @param codCanal
	 * @param nivel
	 * @param codPrestacion
	 * @return ProductoOfertadoDTO[]
	 * @throws CustomerDomainException
	 * 
	 * Obtiene los planes opcionales obligatorios configurados para el Plan Tarifario
	 */
	public ProductoOfertadoDTO[] obtenerProductosObligatoriosPT (final String codPlanTarif, 
																 final String codCanal, 
																 final String nivel, 
																 final String codPrestacion)
		   throws CustomerDomainException {
		
		logger.info("obtenerProductosObligatoriosPT, inicio");
		String nombrePackage = "PF_PRODUCTO_OFERTADO_PG";
		String nombrePLSQL = "PF_PA_OBLIGATORIO_PT_PR";
		int cantidadParametros = 8;
		String mensajeError = "Ocurrió un error en obtenerProductosObligatoriosPT";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		ProductoOfertadoDTO[] r = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			
			cstmt.setObject(i++, codPlanTarif);
			cstmt.setObject(i++, codCanal);
			cstmt.setObject(i++, nivel);
			cstmt.setObject(i++, codPrestacion);

			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(cantidadParametros - 2);
			msgError = cstmt.getString(cantidadParametros - 1);
			numEvento = cstmt.getInt(cantidadParametros - 0);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			ArrayList lista = new ArrayList();
			rs = (ResultSet) cstmt.getObject(cantidadParametros - 3);
			while (rs.next()) {
				i = 1;
				ProductoOfertadoDTO dto = new ProductoOfertadoDTO();
				dto.setCodProductoOfertado(rs.getLong(i++));
				dto.setCantidad(rs.getLong(i++));
				logger.debug(dto.toString());
				lista.add(dto);
			}
			r = (ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), ProductoOfertadoDTO.class);
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (rs != null) {
					rs.close();
				}
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("obtenerProductosObligatoriosPT, fin");
		return r;
	}	
	
	public void insertarPAScoring(ProductoOfertadoDTO dto, long numSolScoring, long numLineaScoring)
			throws CustomerDomainException 
	{
		logger.info("insertarPAScoring, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG".toUpperCase();
		String nombrePLSQL = "VE_inserta_PA_PR".toUpperCase();
		int cantidadParametros = 8;
		String mensajeError = "Ocurrió un error al insertar los planes adicionales asociados a scoring";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			int i = 1;
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			logger.debug("numSolScoring [" + numSolScoring + "]");
			cstmt.setLong(1, numSolScoring);
			logger.debug("numLineaScoring [" + numLineaScoring + "]");
			cstmt.setLong(2, numLineaScoring);
			logger.debug("dto.getCodProductoOfertado() [" + dto.getCodProductoOfertado() + "]");
			cstmt.setLong(3, dto.getCodProductoOfertado());
			logger.debug("dto.getCantidad() [" + dto.getCantidad() + "]");
			cstmt.setLong(4, dto.getCantidad());
			logger.debug("dto.getCodCliente() [" + dto.getCodCliente() + "]");
			cstmt.setLong(5, dto.getCodCliente());
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.info("insertarPAScoring, fin");
	}
	
	public String consultaExistenPlanes(Long numSolScoring) 
	throws CustomerDomainException 
	{
		logger.info("consultaExistenPlanes, inicio");
		String nombrePackage = "VE_SOL_SCORING_PG";
		String nombrePLSQL = "VE_consulta_PA_PR";
		int cantidadParametros = 5;
		String mensajeError = "Ocurrió un error al consultas planes adicionales scoring ";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		String resultado = "FALSE";
		CallableStatement cstmt = null;
		
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			logger.debug("numSolScoring [" + numSolScoring.longValue() +  "]");
			cstmt = conn.prepareCall(sql);		
			cstmt.setLong(1, numSolScoring.longValue());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
	
			logger.debug("cstmt.execute, antes");
			cstmt.execute();
			logger.debug("cstmt.execute, después");
	
			codError  = cstmt.getInt(3);
			msgError  = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
	
			if (codError != 0) {
				logger.error(mensajeError);
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
			else {
				resultado = cstmt.getString(2);
			}
			logger.debug("resultado [" + resultado +  "]");
		}
		catch (Exception e) {
			logger.error(mensajeError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		
		logger.info("consultaExistenPlanes, fin");
		return resultado;
	}
	
	//Inicio P-CSR-11002 JLGN 21-04-2011
	public boolean insertaPANormal(AltaLineaWebDTO alta, Long numAbonado, long numMovimiento) throws CustomerDomainException 
	{
		logger.info("insertaPANormal, inicio");
		String nombrePackage = "VE_PLANES_ADICIONALES_PG";
		String nombrePLSQL = "VE_PA_VENTA_NORMAL_PR";
		int cantidadParametros = 9;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		boolean resultado = false;
		CallableStatement cstmt = null;
		
		try {
			String sql = getSQL(nombrePackage, nombrePLSQL, cantidadParametros);
			logger.debug("SQL [" + sql + "]");
			cstmt = conn.prepareCall(sql);
			
			for(int i = 0; i < alta.getArrayPA().length;i++){
				cstmt.setLong(1, alta.getArrayPA()[i].getCodCliente());
				logger.debug("codCliente: "+alta.getArrayPA()[i].getCodCliente());
				cstmt.setLong(2, numAbonado.longValue());
				logger.debug("numAbonado: "+numAbonado.longValue());
				cstmt.setLong(3, alta.getArrayPA()[i].getCodProductoOfertado());
				logger.debug("PA ProductoOfertado: "+ alta.getArrayPA()[i].getCodProductoOfertado());
				
				/*if (alta.getCodUsoLinea() == 3){ //Prepago
					cstmt.setString(4, "AM");		
					logger.debug("codUsoLinea AM: "+alta.getCodUsoLinea());
				}else if (alta.getCodUsoLinea() == 2){ //Pospago
					cstmt.setString(4, "VO");
					logger.debug("codUsoLinea VO: "+alta.getCodUsoLinea());
				}else{//Hibrido
					cstmt.setString(4, "HH");
					logger.debug("codUsoLinea HH: "+alta.getCodUsoLinea());
				}*/
				
				cstmt.setLong(4, alta.getArrayPA()[i].getCantidad());
				logger.debug("cantidad: "+alta.getArrayPA()[i].getCantidad());
				cstmt.setString(5, String.valueOf(alta.getNumeroVenta()));
				logger.debug("numVenta: "+alta.getNumeroVenta());
				cstmt.setLong(6, numMovimiento);
				logger.debug("numVenta: "+alta.getNumeroVenta());
				
				cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
				
				logger.debug("cstmt.execute, antes");
				cstmt.execute();
				logger.debug("cstmt.execute, después");
				
				codError  = cstmt.getInt(7);
				msgError  = cstmt.getString(8);
				numEvento = cstmt.getInt(9);
				
				if (codError != 0) {
					logger.error(msgError);
					throw new CustomerDomainException(msgError, String.valueOf(codError), numEvento, msgError);
				}
				else {
					resultado = true;
				}
				logger.debug("resultado [" + resultado +  "]");				
			}	
			
		}
		catch (Exception e) {
			logger.error(msgError, e);
			if (logger.isDebugEnabled()) {
				logger.error("codError [" + codError + "]");
				logger.error("msgError [" + msgError + "]");
				logger.error("numEvento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				
				if (cstmt != null) {
					cstmt.close();
				}
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		
		logger.info("consultaExistenPlanes, fin");
		return resultado;
	}
	//Fin P-CSR-11002 JLGN 21-04-2011

	
}