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
import com.tmmas.scl.wsportal.common.dto.CuentaDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleCuentaDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class CuentaDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(CuentaDAO.class);

	public CuentaDAO()
	{

	}

	/**
	 * Consulta la cuenta asociada a su codigo
	 * @param codCuenta
	 * @return {@link ListadoCuentasDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoCuentasDTO cuentasXCodigo(Long codCuenta) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCuentasDTO resultado = new ListadoCuentasDTO();
		CuentaDTO[] cuentasDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_GRILLA_CUENTA_X_COD_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCuenta.longValue());
			logger.debug("codCuenta : " + codCuenta);
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

			ArrayList cuentas = new ArrayList();
			while (rs.next())
			{
				CuentaDTO cuenta = new CuentaDTO();
				cuenta.setCodCuenta(new Long(rs.getLong(1)));
				cuenta.setDesCuenta(rs.getString(2));
				cuenta.setFecAlta(rs.getString(3));
				cuenta.setTipCuenta(rs.getString(4));
				
				//Es para el ordenamiento de la tabla
				cuenta.setFecAltaOrd(rs.getString(5));
				
				cuentas.add(cuenta);
			}
			cuentasDTO = (CuentaDTO[]) cuentas.toArray(new CuentaDTO[cuentas.size()]);
			resultado.setArrayCuentas(cuentasDTO);

			if (cuentasDTO == null || (cuentasDTO != null && cuentasDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0001"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0001"));
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
	 * Consulta las cuentas asociadas a la descripcion de la cuenta
	 * @param descCuenta
	 * @return {@link ListadoCuentasDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoCuentasDTO cuentasXNombre(String descCuenta) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCuentasDTO resultado = new ListadoCuentasDTO();
		CuentaDTO[] cuentasDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_GRILLA_CUENTA_X_DES_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setString(1, descCuenta);
			logger.debug("descCuenta : " + descCuenta);
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

			ArrayList cuentas = new ArrayList();
			while (rs.next())
			{
				CuentaDTO cuenta = new CuentaDTO();
				cuenta.setCodCuenta(new Long(rs.getLong(1)));
				cuenta.setDesCuenta(rs.getString(2));
				cuenta.setFecAlta(rs.getString(3));
				cuenta.setTipCuenta(rs.getString(4));
				
				//Son para el ordenamiento de la tabla
				cuenta.setFecAltaOrd(rs.getString(5));
				
				cuentas.add(cuenta);
			}
			cuentasDTO = (CuentaDTO[]) cuentas.toArray(new CuentaDTO[cuentas.size()]);
			resultado.setArrayCuentas(cuentasDTO);

			if (cuentasDTO == null || (cuentasDTO != null && cuentasDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0002"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0002"));
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
	 * Consulta las cuentas asociadas al numero de identificacion
	 * @param numIdent
	 * @return {@link ListadoCuentasDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoCuentasDTO cuentasXNumIdent(String numIdent) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCuentasDTO resultado = new ListadoCuentasDTO();
		CuentaDTO[] cuentasDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_GRILLA_CUENTA_X_IDE_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setString(1, numIdent);
			logger.debug("numIdent : " + numIdent);
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

			ArrayList cuentas = new ArrayList();
			while (rs.next())
			{
				CuentaDTO cuenta = new CuentaDTO();
				cuenta.setCodCuenta(new Long(rs.getLong(1)));
				cuenta.setDesCuenta(rs.getString(2));
				cuenta.setFecAlta(rs.getString(3));
				cuenta.setTipCuenta(rs.getString(4));
				
				//Son para el ordenamiento de la tabla
				cuenta.setFecAltaOrd(rs.getString(5));
				
				cuentas.add(cuenta);
			}
			cuentasDTO = (CuentaDTO[]) cuentas.toArray(new CuentaDTO[cuentas.size()]);
			resultado.setArrayCuentas(cuentasDTO);

			if (cuentasDTO == null || (cuentasDTO != null && cuentasDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0003"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0003"));
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
	 * Consulta el detalle de la cuenta dado su codigo
	 * @param codCuenta
	 * @return {@link DetalleCuentaDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public DetalleCuentaDTO getDetalleCuenta(Long codCuenta) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DetalleCuentaDTO resultado = new DetalleCuentaDTO();

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_CUENTA_DETALLE_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCuenta.longValue());
			logger.debug("codCuenta : " + codCuenta);
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

			if (rs.next())
			{
				resultado.setCodCuenta(new Long(rs.getLong(1)));
				resultado.setDesCuenta(rs.getString(2));
				resultado.setNomResponsable(rs.getString(3));
				resultado.setDesTipIdent(rs.getString(4));
				resultado.setNumIdent(rs.getString(5));
				resultado.setFecAlta(rs.getString(6));
				resultado.setTipCuenta(rs.getString(7));
				resultado.setDesCategoria(rs.getString(8));
				resultado.setTelContacto(new Long(rs.getLong(9)));
				resultado.setTotClientes(new Long(rs.getLong(10)));
			}
			else
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0004"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0004"));
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
