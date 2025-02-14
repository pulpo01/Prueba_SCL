package com.tmmas.scl.wsportal.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.CausaSiniestroDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCausasSiniestroDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposSiniestroDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoTiposSuspensionDTO;
import com.tmmas.scl.wsportal.common.dto.TipoSiniestroDTO;
import com.tmmas.scl.wsportal.common.dto.TipoSuspensionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class AvisoSiniestroDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(AvisoSiniestroDAO.class);
	
	public ListadoTiposSiniestroDTO consultaTiposSiniestro() throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoTiposSiniestroDTO resultado = new ListadoTiposSiniestroDTO();
		TipoSiniestroDTO[] listado = null;
		final String nombrePL = "PV_CONS_TIPO_SINIESTRO_PR";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", nombrePL, 4);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(1);

			ArrayList array = new ArrayList();
			while (rs.next())
			{
				TipoSiniestroDTO dto = new TipoSiniestroDTO();
				dto.setCodValor(rs.getString(1));
				dto.setDesValor(rs.getString(2));
				array.add(dto);
			}
			listado = (TipoSiniestroDTO[]) array.toArray(new TipoSiniestroDTO[array.size()]);
			resultado.setListado(listado);

			if (listado == null || (listado != null && listado.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0051"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0051"));
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
	
	public ListadoCausasSiniestroDTO consultaCausasSiniestro() throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCausasSiniestroDTO resultado = new ListadoCausasSiniestroDTO();
		CausaSiniestroDTO[] listado = null;
		final String nombrePL = "PV_CONS_CAUSA_SINIESTRO_PR";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", nombrePL, 4);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(1);

			ArrayList array = new ArrayList();
			while (rs.next())
			{
				CausaSiniestroDTO dto = new CausaSiniestroDTO();
				dto.setCodCausa(rs.getString(1));
				dto.setDesCausa(rs.getString(2));
				array.add(dto);
			}
			listado = (CausaSiniestroDTO[]) array.toArray(new CausaSiniestroDTO[array.size()]);
			resultado.setListado(listado);

			if (listado == null || (listado != null && listado.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0052"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0052"));
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
	
	
	public ListadoTiposSuspensionDTO consultaTiposSuspension() throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoTiposSuspensionDTO resultado = new ListadoTiposSuspensionDTO();
		TipoSuspensionDTO[] listado = null;
		final String nombrePL = "PV_CONS_TIPO_SUSPENSION_PR";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", nombrePL, 4);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(1);

			ArrayList array = new ArrayList();
			while (rs.next())
			{
				TipoSuspensionDTO dto = new TipoSuspensionDTO();
				dto.setCodValor(rs.getString(1));
				dto.setDesValor(rs.getString(2));
				array.add(dto);
			}
			listado = (TipoSuspensionDTO[]) array.toArray(new TipoSuspensionDTO[array.size()]);
			resultado.setListado(listado);

			if (listado == null || (listado != null && listado.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0053"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0053"));
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
