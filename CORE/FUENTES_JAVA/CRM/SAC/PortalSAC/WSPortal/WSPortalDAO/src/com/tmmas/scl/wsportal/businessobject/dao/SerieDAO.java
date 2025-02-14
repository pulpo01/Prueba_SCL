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

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.EquipoSimcardDetalleDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class SerieDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(SerieDAO.class);

	public SerieDAO()
	{

	}

	/**
	 * Consulta el detalle de los equipos
	 * 
	 * @param numAbonado
	 * @return {@link EquipoSimcardDetalleDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public EquipoSimcardDetalleDTO detalleEquipoSimcardXNumAbonado(Long numAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EquipoSimcardDetalleDTO r = new EquipoSimcardDetalleDTO();
		final String plName = "PV_CONS_EQUISIM_DETALLE_PR";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, plName, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.setLong(1, numAbonado.longValue());
			logger.debug("numAbonado: " + numAbonado);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			logger.debug("codError [" + codError + "]");
			logger.debug("msgError [" + msgError + "]");
			logger.debug("numEvento [" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(2);
			if (rs.next())
			{
				r.setNumSerieEquipo(rs.getString(1));
				r.setCodModeloEquipo(rs.getString(2));
				r.setCodArticuloEquipo(new Long(rs.getLong(3)));
				r.setDesArticuloEquipo(rs.getString(4));
				r.setIndProcEquipo(rs.getString(5));
				r.setFechaAltaEquipo(rs.getString(6));
				r.setIndEquipoPrestado(rs.getString(7));
				r.setNumSerieSimcard(rs.getString(8));
				r.setNumImei(rs.getString(9));
				r.setCodModeloSimcard(rs.getString(10));
				r.setCodArticuloSimcard(new Long(rs.getLong(11)));
				r.setDesArticuloSimcard(rs.getString(12));
				r.setIndProcSimcard(rs.getString(13));
				r.setFechaAltaSimcard(rs.getString(14));
				r.setCodGama(new Long(rs.getLong(15)));
				r.setDesGama(rs.getString(16));
				r.setDesTecnologia(rs.getString(17));
			}
			else
			{
				r.setCodError(config.getString("COD.ERR_SAC.0025"));
				r.setDesError(config.getString("DES.ERR_SAC.0025"));
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
		return r;
	}
}
