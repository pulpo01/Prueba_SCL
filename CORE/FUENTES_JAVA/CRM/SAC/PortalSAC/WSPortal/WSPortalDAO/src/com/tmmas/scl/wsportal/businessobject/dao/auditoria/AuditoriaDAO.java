/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.businessobject.dao.auditoria;

import java.sql.CallableStatement;
import java.sql.Connection;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class AuditoriaDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(AuditoriaDAO.class);

	public AuditoriaDAO()
	{

	}

	public void auditar(String codEvento, String nomUsuarioSCL, Long numCelular, Long numAbonado, Long codCliente,
			Long codCuenta) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		final String nombrePL = "pv_graba_traza_usr_pr";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 9);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");

			/** Parámetros PL/SQL
			 *EV_COD_EVENTO VARCHAR2(200);
			 * EV_NOM_USUARIO VARCHAR2(200);
			 * EN_NUM_CELULAR NUMBER;
			 * EN_NUM_ABONADO NUMBER;		
			 * EN_COD_CLIENTE NUMBER;
			 * EN_COD_CUENTA NUMBER;
			 * SN_COD_RETORNO NUMBER;
			 * SV_MENS_RETORNO VARCHAR2(200);
			 * SN_NUM_EVENTO NUMBER;
			 */
			cstmt.setString(1, codEvento);
			logger.debug("codEvento: " + codEvento);
			cstmt.setString(2, nomUsuarioSCL);
			logger.debug("nomUsuarioSCL: " + nomUsuarioSCL);

			if (numCelular != null)
			{
				cstmt.setLong(3, numCelular.longValue());
				logger.debug("numCelular: " + numCelular);
			}
			else
			{
				cstmt.setObject(3, null);
				logger.debug("numCelular: " + numCelular);
			}

			if (numAbonado != null)
			{
				cstmt.setLong(4, numAbonado.longValue());
				logger.debug("numAbonado: " + numAbonado);
			}
			else
			{
				cstmt.setObject(4, null);
				logger.debug("numAbonado: " + numAbonado);
			}
			if (codCliente != null)
			{
				cstmt.setLong(5, codCliente.longValue());
				logger.debug("codCliente: " + codCliente);
			}
			else
			{
				cstmt.setObject(5, null);
				logger.debug("codCliente: " + codCliente);
			}
			if (codCuenta != null)
			{
				cstmt.setLong(6, codCuenta.longValue());
				logger.debug("codCuenta: " + codCuenta);
			}
			else
			{
				cstmt.setObject(6, null);
				logger.debug("codCuenta: " + codCuenta);
			}

			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				throw new PortalSACException(config.getString("COD.ERR_SAC.0038"), config.getString("DES.ERR_SAC.0038"), numEvento);
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
				cerrarRecursos(conn, cstmt);
			}
			catch (Exception e)
			{
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.info(MENSAJE_FIN_LOG);
	}
}
