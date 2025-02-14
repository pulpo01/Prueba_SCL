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
import com.tmmas.scl.wsportal.common.dto.CuentaCorrienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCuentasCorrientesDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class CuentaCorrienteDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(CuentaCorrienteDAO.class);

	public CuentaCorrienteDAO()
	{

	}

	/**
	 * Consulta las cuentas corrientes asociadas a un cliente
	 * @param codCliente
	 * @return {@link ListadoCuentasCorrientesDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoCuentasCorrientesDTO ccXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCuentasCorrientesDTO resultado = new ListadoCuentasCorrientesDTO();
		CuentaCorrienteDTO[] carterasDTO = null;
		final String plName = "PV_CONS_GRILLA_CC_X_CLI_PR";

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, plName, 5);
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

			ArrayList carteras = new ArrayList();
			
			/*
			 * Modificacion
			 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
			 * Requisito: RSis_008
			 * Caso de uso: CU-014 Modificar Cuenta Corriente del Cliente
			 * Developer: Gabriel Moraga L.
			 * Fecha: 12/07/2010
			 * 
			 */
			
			while (rs.next())
			{
				CuentaCorrienteDTO cartera = new CuentaCorrienteDTO();
				cartera.setCodCliente(new Long(rs.getLong(1)));
				cartera.setNumAbonado(new Long(rs.getLong(2)));
				cartera.setCodTipDocumento(new Long(rs.getLong(3)));
				cartera.setDesTipDocumento(rs.getString(4));
				cartera.setImporteDebe(new Double(rs.getDouble(5)));
				cartera.setImporteHaber(new Double(rs.getDouble(6)));
				cartera.setAcumNetoGrav(Double.valueOf(rs.getDouble(7))); //Acumulado del Neto Gravado
				carteras.add(cartera);
			}
			carterasDTO = (CuentaCorrienteDTO[]) carteras.toArray(new CuentaCorrienteDTO[carteras.size()]);
			resultado.setArrayCarteras(carterasDTO);

			if (carterasDTO == null || (carterasDTO != null && carterasDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0014"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0014"));
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
