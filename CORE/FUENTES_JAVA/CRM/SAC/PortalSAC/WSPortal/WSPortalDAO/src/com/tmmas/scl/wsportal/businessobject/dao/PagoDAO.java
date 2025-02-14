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
import com.tmmas.scl.wsportal.common.dto.ListadoPagosDTO;
import com.tmmas.scl.wsportal.common.dto.PagoDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class PagoDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(PagoDAO.class);

	public PagoDAO()
	{

	}

	/**
	 * Consulta los pagos asociados a un cliente
	 * @param codCliente
	 * @return {@link ListadoPagosDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoPagosDTO pagosXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoPagosDTO resultado = new ListadoPagosDTO();
		PagoDTO[] pagosDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_PAGOS_X_CLI_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			logger.debug("codCliente : " + codCliente);
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

			ArrayList pagos = new ArrayList();
			while (rs.next())
			{
				PagoDTO pago = new PagoDTO();
				pago.setNumSecuencia(new Long(rs.getLong(1)));
				pago.setFecEfectividad(rs.getString(2));
				pago.setCodTipDocum(new Long(rs.getLong(3)));
				pago.setDesTipDocum(rs.getString(4));
				pago.setImpPago(new Double(rs.getDouble(5)));
				pagos.add(pago);
			}
			pagosDTO = (PagoDTO[]) pagos.toArray(new PagoDTO[pagos.size()]);
			resultado.setArrayPagos(pagosDTO);

			if (pagosDTO == null || (pagosDTO != null && pagosDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0024"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0024"));
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
