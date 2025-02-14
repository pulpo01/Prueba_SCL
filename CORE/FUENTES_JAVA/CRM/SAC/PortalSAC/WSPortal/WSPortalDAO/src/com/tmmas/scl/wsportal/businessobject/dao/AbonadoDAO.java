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
import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleAbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class AbonadoDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(AbonadoDAO.class);

	public AbonadoDAO()
	{

	}

	/**
	 * Consulta los abonados dado un codigo de cliente
	 * @param codCliente
	 * @return {@link ListadoAbonadosDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoAbonadosDTO abonadosXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoAbonadosDTO resultado = new ListadoAbonadosDTO();
		AbonadoDTO[] abonadosDTO = null;
		try
		{
			logger.info(MENSAJE_INICIO_LOG);

			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_ABO_X_CLI_PR", 5);
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

			ArrayList abonados = new ArrayList();

			while (rs.next())
			{
				AbonadoDTO abonado = new AbonadoDTO();
				abonado.setNumAbonado(new Long(rs.getLong(1)));
				abonado.setNumCelular(new Long(rs.getString(2)));
				abonado.setDesSituacion(rs.getString(3));
				abonado.setFecAlta(rs.getString(4));
				abonado.setFecBaja(rs.getString(5));
				abonado.setNumVenta(new Long(rs.getLong(6)));
				abonado.setCodUso(rs.getString(7));
				abonado.setNomUsuario(rs.getString(8));
				abonado.setCodCliente(new Long(rs.getLong(9)));
				abonado.setCodCuenta(new Long(rs.getLong(10)));
				
				//Son para el ordenamiento de la tabla
				abonado.setFecAltaOrd(rs.getString(11));
				abonado.setFecBajaOrd(rs.getString(12));
				
				
				abonados.add(abonado);
			}

			abonadosDTO = (AbonadoDTO[]) abonados.toArray(new AbonadoDTO[abonados.size()]);
			resultado.setArrayAbonados(abonadosDTO);

			if (abonadosDTO == null || (abonadosDTO != null && abonadosDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0009"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0009"));
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
	 * Consulta los abonados dado un numero de celular
	 * @param numCelular
	 * @return {@link ListadoAbonadosDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoAbonadosDTO abonadosXCelular(Long numCelular) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoAbonadosDTO resultado = new ListadoAbonadosDTO();
		AbonadoDTO[] abonadosDTO = null;
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_GRILLA_ABO_X_CEL_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numCelular.longValue());
			logger.debug("numCelular : " + numCelular);
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

			ArrayList abonados = new ArrayList();
			while (rs.next())
			{
				AbonadoDTO abonado = new AbonadoDTO();
				abonado.setNumAbonado(new Long(rs.getLong(1)));
				abonado.setNumCelular(new Long(rs.getString(2)));
				abonado.setDesSituacion(rs.getString(3));
				abonado.setFecAlta(rs.getString(4));
				abonado.setFecBaja(rs.getString(5));
				abonado.setNumVenta(new Long(rs.getLong(6)));
				abonado.setCodUso(rs.getString(7));
				abonado.setNomUsuario(rs.getString(8));
				abonado.setCodCliente(new Long(rs.getLong(9)));
				abonado.setCodCuenta(new Long(rs.getLong(10)));
				
				//Son para el ordenamiento de la tabla
				abonado.setFecAltaOrd(rs.getString(11));
				abonado.setFecBajaOrd(rs.getString(12));
				
				abonados.add(abonado);
			}
			abonadosDTO = (AbonadoDTO[]) abonados.toArray(new AbonadoDTO[abonados.size()]);
			resultado.setArrayAbonados(abonadosDTO);

			if (abonadosDTO == null || (abonadosDTO != null && abonadosDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0010"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0010"));
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
	 * Obtiene el detalle de un abonado
	 * @param numAbonado
	 * @return {@link DetalleAbonadoDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public DetalleAbonadoDTO getDetalleAbonado(Long numAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DetalleAbonadoDTO resultado = new DetalleAbonadoDTO();
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_ABONADO_DETALLE_PR", 5);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numAbonado.longValue());
			logger.debug("codCliente : " + numAbonado);
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
				resultado.setNumAbonado(new Long(rs.getLong(1)));
				resultado.setNumCelular(new Long(rs.getString(2)));
				resultado.setCodUsuario(new Long(rs.getLong(3)));
				resultado.setNomUsuario(rs.getString(4));
				resultado.setCodSituacion(rs.getString(5));
				resultado.setDesSituacion(rs.getString(6));
				resultado.setCodTipContrato(rs.getString(7));
				resultado.setDesTipContrato(rs.getString(8));
				resultado.setTipoPlan(rs.getString(9));
				resultado.setCodPlanTarif(rs.getString(10));
				resultado.setDesPlanTarif(rs.getString(11));
				resultado.setFecAlta(rs.getString(12));
				resultado.setFecBaja(rs.getString(13));
				resultado.setFecActCen(rs.getString(14));
				resultado.setFecAceptVenta(rs.getString(15));
				resultado.setFecFinContrato(rs.getString(16));
				resultado.setNumVenta(new Long(rs.getLong(17)));
				resultado.setCodUso(rs.getString(18));
			}
			else
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0011"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0011"));
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
