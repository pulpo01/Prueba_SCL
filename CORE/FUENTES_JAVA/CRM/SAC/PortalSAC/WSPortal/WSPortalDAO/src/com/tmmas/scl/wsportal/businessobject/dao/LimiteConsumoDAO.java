/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.DetalleLlamadaDTO;
import com.tmmas.scl.wsportal.common.dto.LimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDetalleLlamadosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoPagosLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.dto.PagoLimiteConsumoDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class LimiteConsumoDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(LimiteConsumoDAO.class);

	public LimiteConsumoDAO()
	{

	}

	/**
	 * Consulta las facturas asociadas a un cliente
	 * @param codCliente, numAbonado
	 * @return {@link ListadoLimiteConsumoDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoLimiteConsumoDTO limiteConsumoXClienteAbonado(Long codCliente, Long numAbonado)
			throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoLimiteConsumoDTO resultado = new ListadoLimiteConsumoDTO();
		LimiteConsumoDTO[] limitesDTO = null;

		try
		{

			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_LC_X_ABON_PR", 6);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			logger.debug("codCliente : " + codCliente);
			cstmt.setLong(2, numAbonado.longValue());
			logger.debug("numAbonado : " + numAbonado);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0)
			{
				logger.error("codError[" + codError + "]");
				logger.error("msgError[" + msgError + "]");
				logger.error("numEvento[" + numEvento + "]");

				throw new PortalSACException(config.getString("COD.ERR_SAC.1000"),
						config.getString("DES.ERR_SAC.1000"), numEvento);
			}

			rs = (ResultSet) cstmt.getObject(3);

			ArrayList limites = new ArrayList();

			while (rs.next())
			{
				LimiteConsumoDTO limite = new LimiteConsumoDTO();
				limite.setCodLimCons(rs.getString(1));
				limite.setDescripcion(rs.getString(2));
				limite.setCodUmbralMin(rs.getString(3));
				limite.setDesUmbral(rs.getString(4));
				limite.setAcuConsumo(new Double(rs.getDouble(5)));
				limites.add(limite);
			}

			limitesDTO = (LimiteConsumoDTO[]) limites.toArray(new LimiteConsumoDTO[limites.size()]);
			resultado.setArrayLimitesConsumo(limitesDTO);

			if (limitesDTO == null || (limitesDTO != null && limitesDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0018"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0018"));
			}

		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.info(MENSAJE_FIN_LOG);
		return resultado;
	}

	/**
	 * Consulta las facturas asociadas a un cliente
	 * @param codCliente, numAbonado
	 * @return {@link ListadoPagosLimiteConsumoDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoPagosLimiteConsumoDTO pagoLimiteConsumoXClienteAbonado(Long codCliente, Long numAbonado)
			throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoPagosLimiteConsumoDTO resultado = new ListadoPagosLimiteConsumoDTO();
		PagoLimiteConsumoDTO[] limitesDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_PLC_X_ABON_PR", 6);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			logger.debug("codCliente : " + codCliente);
			cstmt.setLong(2, numAbonado.longValue());
			logger.debug("numAbonado : " + numAbonado);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0)
			{
				logger.error("codError[" + codError + "]");
				logger.error("msgError[" + msgError + "]");
				logger.error("numEvento[" + numEvento + "]");

				throw new PortalSACException(config.getString("COD.ERR_SAC.1000"),
						config.getString("DES.ERR_SAC.1000"), numEvento);
			}

			rs = (ResultSet) cstmt.getObject(3);

			ArrayList limites = new ArrayList();

			while (rs.next())
			{
				PagoLimiteConsumoDTO limite = new PagoLimiteConsumoDTO();
				limite.setDesPago(rs.getString(1));
				limite.setFecValor(rs.getString(2));
				limite.setNomUsuarora(rs.getString(3));
				limite.setImpPago(new Double(rs.getString(4)));
				limites.add(limite);
			}

			limitesDTO = (PagoLimiteConsumoDTO[]) limites.toArray(new PagoLimiteConsumoDTO[limites.size()]);
			resultado.setArrayPagosLimiteConsumo(limitesDTO);

			if (limitesDTO == null || (limitesDTO != null && limitesDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0019"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0019"));
			}

		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.info(MENSAJE_FIN_LOG);
		return resultado;
	}

	/**
	 * Consulta las facturas asociadas a un cliente
	 * @param codCliente, numAbonado, codCiclo, tipoLlamada
	 * @return {@link ListadoDetalleLlamadosDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoDetalleLlamadosDTO detalleLlamadas(Long codCliente, Long numAbonado, Long codCiclo, String tipoLlamada)
			throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoDetalleLlamadosDTO resultado = new ListadoDetalleLlamadosDTO();
		DetalleLlamadaDTO[] llamadasDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_DETLLAM_X_PR", 8);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL [" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			logger.debug("codCliente : " + codCliente);
			cstmt.setLong(2, numAbonado.longValue());
			logger.debug("numAbonado : " + numAbonado);
			cstmt.setLong(3, codCiclo.longValue());
			logger.debug("codCiclo : " + codCiclo);
			cstmt.setString(4, tipoLlamada);
			logger.debug("tipoLlamada : " + tipoLlamada);
			cstmt.registerOutParameter(5, OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, OracleTypes.NUMBER);
			cstmt.registerOutParameter(7, OracleTypes.VARCHAR);
			cstmt.registerOutParameter(8, OracleTypes.NUMBER);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			if (codError != 0)
			{
				logger.error("codError[" + codError + "]");
				logger.error("msgError[" + msgError + "]");
				logger.error("numEvento[" + numEvento + "]");

				throw new PortalSACException(config.getString("COD.ERR_SAC.1000"),
						config.getString("DES.ERR_SAC.1000"), numEvento);
			}

			rs = (ResultSet) cstmt.getObject(5);

			ArrayList llamadas = new ArrayList();

			while (rs.next())
			{
				DetalleLlamadaDTO llamada = new DetalleLlamadaDTO();
				llamada.setFechaLlamada(rs.getString(1));
				llamada.setCelularOrig(rs.getString(2));
				llamada.setCelularDest(rs.getString(3));
				llamada.setDuracion(new Long(rs.getLong(4)));
				llamada.setValor(new Double(rs.getDouble(5)));
				llamada.setHorario(rs.getString(6));
				llamadas.add(llamada);
			}

			llamadasDTO = (DetalleLlamadaDTO[]) llamadas.toArray(new DetalleLlamadaDTO[llamadas.size()]);
			resultado.setArrayLlamadas(llamadasDTO);

			if (llamadasDTO == null || (llamadasDTO != null && llamadasDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0020"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0020"));
			}
		}
		catch (Exception e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}
		finally
		{
			try
			{
				cerrarRecursos(conn, cstmt, rs);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.info(MENSAJE_FIN_LOG);
		return resultado;
	}

}
