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
import com.tmmas.scl.wsportal.common.dto.BeneficioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoBeneficiosDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

/**
 * La Class BeneficioDAO.
 */
public class BeneficioDAO extends BaseDAO
{

	/** El atributo logger. */
	private static Logger logger = Logger.getLogger(BeneficioDAO.class);

	/**
	 * Crea una nueva instancia de la clase BeneficioDAO.
	 */
	public BeneficioDAO()
	{

	}

	/**
	 * Beneficios x cliente abonado.
	 * 
	 * @param codCliente el parametro codCliente
	 * @param numAbonado el parametro numAbonado
	 * 
	 * @return el resultado de listado beneficios dto
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public ListadoBeneficiosDTO beneficiosXClienteAbonado(Long codCliente, Long numAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoBeneficiosDTO resultado = new ListadoBeneficiosDTO();

		final String plName = "PV_CONS_GRILLA_BP_X_ABON_PR";

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, plName, 6);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			logger.debug("codCliente: " + codCliente);
			cstmt.setLong(2, numAbonado.longValue());
			logger.debug("numAbonado: " + numAbonado);
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

			ArrayList a = new ArrayList();
			while (rs.next())
			{
				BeneficioDTO dto = new BeneficioDTO();
				dto.setCntPeriodos(new Long(rs.getLong(1)));
				dto.setFecIngreso(rs.getString(2));
				dto.setDesEstado(rs.getString(3));
				dto.setValAcumulado(new Double(rs.getDouble(4)));
				dto.setValBeneficio(new Double(rs.getString(5)));
				dto.setFecEstado(rs.getString(6));
				dto.setDesTiplan(rs.getString(7));
				dto.setCodPlan(rs.getString(8));
				dto.setDesPlan(rs.getString(9));
				
				//Son para el ordenamiento de la tabla
				dto.setFecIngresoOrd(rs.getString(10));
				dto.setFecEstadoOrd(rs.getString(11));

				logger.debug("dto.getCodPlan: " + dto.getCodPlan());
				logger.debug("dto.getDesPlan: " + dto.getDesPlan());

				a.add(dto);
			}
			BeneficioDTO[] toArray = (BeneficioDTO[]) a.toArray(new BeneficioDTO[a.size()]);
			
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0013"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0013"));
			}
			else
			{
				logger.debug("Encontrados: " + toArray.length);
				resultado.setArrayBeneficios(toArray);
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
