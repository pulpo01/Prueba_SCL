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
import com.tmmas.scl.wsportal.common.dto.AjusteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAjustesDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class AjusteDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(AjusteDAO.class);

	public AjusteDAO()
	{

	}

	/**
	 * Consulta los ajustes asociados a un cliente
	 * @param codCliente, codTipDocum
	 * @return {@link ListadoAjustesDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoAjustesDTO ajustesXCodCliente(Long codCliente, Long codTipDocum) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoAjustesDTO resultado = new ListadoAjustesDTO();
		AjusteDTO[] ajustesDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_AJUSTE_X_CLI_PR", 6);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			cstmt.setLong(2, codTipDocum.longValue());
			logger.debug("codCliente : " + codCliente);
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

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			rs = (ResultSet) cstmt.getObject(3);

			ArrayList ajustes = new ArrayList();
			while (rs.next())
			{
				AjusteDTO ajuste = new AjusteDTO();
				ajuste.setNumSecuencia(new Long(rs.getLong(1)));
				ajuste.setFecEfectividad(rs.getString(2));
				ajuste.setCodTipDocum(new Long(rs.getLong(3)));
				ajuste.setDesTipDocum(rs.getString(4));
				ajuste.setImporteDebe(new Double(rs.getDouble(5)));
				ajustes.add(ajuste);
			}
			ajustesDTO = (AjusteDTO[]) ajustes.toArray(new AjusteDTO[ajustes.size()]);
			resultado.setArrayAjustes(ajustesDTO);

			if (ajustesDTO == null || (ajustesDTO != null && ajustesDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0012"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0012"));
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
