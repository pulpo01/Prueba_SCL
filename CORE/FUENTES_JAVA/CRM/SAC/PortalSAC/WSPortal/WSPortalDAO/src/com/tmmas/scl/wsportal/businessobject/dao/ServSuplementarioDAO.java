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
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplxOOSSDTO;
import com.tmmas.scl.wsportal.common.dto.ServSuplXOOSSDTO;
import com.tmmas.scl.wsportal.common.dto.ServSuplementarioDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class ServSuplementarioDAO extends BaseDAO
{

	private static Logger logger = Logger.getLogger(ServSuplementarioDAO.class);

	public ServSuplementarioDAO()
	{

	}

	/**
	 * Consulta el detalle de los equipos
	 * @param numAbonado
	 * @return {@link ListadoServSuplementariosDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoServSuplementariosDTO servSumplemetariosXAbonado(Long numAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoServSuplementariosDTO resultado = new ListadoServSuplementariosDTO();
		ServSuplementarioDTO[] serviciosDTO = null;
		final String nombrePL = "PV_CONS_GRILLA_SS_X_ABON_PR";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numAbonado.longValue());
			logger.debug("numAbonado : " + numAbonado);
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

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(2);

			ArrayList array = new ArrayList();
			while (rs.next())
			{
				ServSuplementarioDTO dto = new ServSuplementarioDTO();
				dto.setCodServicio(rs.getString(1));
				dto.setDesServicio(rs.getString(2));
				dto.setFecAltaBD(rs.getString(3));
				dto.setFecAltaCEN(rs.getString(4));
				dto.setDesConcepto(rs.getString(5));
				dto.setImpTarifa(new Double(rs.getDouble(6)));
				array.add(dto);
			}
			serviciosDTO = (ServSuplementarioDTO[]) array.toArray(new ServSuplementarioDTO[array.size()]);
			resultado.setArraySS(serviciosDTO);

			if (serviciosDTO == null || (serviciosDTO != null && serviciosDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0026"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0026"));
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
	 * Consulta SS por num de OOSS
	 * @param numAbonado
	 * @return {@link ListadoServSuplxOOSSDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoServSuplxOOSSDTO servSuplXOOSS(Long numOOSS) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoServSuplxOOSSDTO resultado = new ListadoServSuplxOOSSDTO();
		ServSuplXOOSSDTO[] serviciosDTO = null;
		final String nombrePL = "PV_OBTIENE_SS_POR_OOSS_PR";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numOOSS.longValue());
			logger.debug("numOOSS : " + numOOSS);
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

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			
			resultado.setCodError(String.valueOf(codError));
			resultado.setDesError(msgError);
			
			/*
			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			*/
			
			rs = (ResultSet) cstmt.getObject(2);

			ArrayList array = new ArrayList();
			while (rs.next())
			{
				ServSuplXOOSSDTO dto = new ServSuplXOOSSDTO();
				dto.setCodServSupl(rs.getString(1));
				dto.setDesServSupl(rs.getString(2));
				dto.setAccion(rs.getString(3));				
				array.add(dto);
			}
			serviciosDTO = (ServSuplXOOSSDTO[]) array.toArray(new ServSuplXOOSSDTO[array.size()]);
			resultado.setArrayServSupl(serviciosDTO);
			
			
			/*
			if (serviciosDTO == null || (serviciosDTO != null && serviciosDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0026"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0026"));
			}
			*/
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
