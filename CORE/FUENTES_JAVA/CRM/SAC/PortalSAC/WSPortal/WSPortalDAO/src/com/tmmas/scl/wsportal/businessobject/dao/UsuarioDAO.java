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
import com.tmmas.scl.wsportal.common.dto.ConsultaDTO;
import com.tmmas.scl.wsportal.common.dto.GrupoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoConsultasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoGruposDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO;
import com.tmmas.scl.wsportal.common.dto.MenuDTO;
import com.tmmas.scl.wsportal.common.dto.OOSSXAbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.OOSSXClienteDTO;
import com.tmmas.scl.wsportal.common.dto.OOSSXCuentaDTO;
import com.tmmas.scl.wsportal.common.dto.OOSSXUsuarioDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class UsuarioDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(UsuarioDAO.class);

	public UsuarioDAO()
	{
	}


	/**
	 * Consulta los procesos asociados a un grupo
	 * @param nomUsuario
	 * @return {@link ListadoConsultasDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoConsultasDTO consultasXCodGrupo(String codGrupo, String codPrograma, String numVersion)
			throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoConsultasDTO r = new ListadoConsultasDTO();
		ConsultaDTO[] dtos = null;
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "pv_cons_perfil_segur_pr", 7);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.setString(1, codGrupo);
			logger.debug("codGrupo: " + codGrupo);
			cstmt.setString(2, codPrograma);
			logger.debug("codPrograma: " + codPrograma);
			cstmt.setString(3, numVersion);
			logger.debug("numVersion: " + numVersion);
			cstmt.registerOutParameter(4, OracleTypes.CURSOR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			logger.debug("codError [" + codError + "]");
			logger.debug("msgError [" + msgError + "]");
			logger.debug("numEvento [" + numEvento + "]");
			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}
			rs = (ResultSet) cstmt.getObject(4);
			ArrayList array = new ArrayList();
			while (rs.next())
			{
				ConsultaDTO dto = new ConsultaDTO();
				dto.setCodProceso(rs.getString(1));
				dto.setDesProceso(rs.getString(2));
				array.add(dto);
			}
			dtos = (ConsultaDTO[]) array.toArray(new ConsultaDTO[array.size()]);
			r.setArrayProcesos(dtos);
			if (dtos == null || (dtos != null && dtos.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0041"));
				r.setDesError(config.getString("DES.ERR_SAC.0041"));
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

	public Boolean esPrimerLogin(String nomUsuario) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		Boolean r = Boolean.FALSE;
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_REALM, "PV_REC_IND_LOGIN", 2);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.setString(1, nomUsuario);
			logger.debug("usuario: " + nomUsuario);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			if (cstmt.getInt(2) == 1)
			{
				r = Boolean.TRUE;
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
		logger.info("Retorna [" + r + "]");
		return r;
	}

	/**
	 * Consulta los grupos asociados a un usuario
	 * @param nomUsuario
	 * @return {@link ListadoGruposDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoGruposDTO gruposXNomUsuario(String nomUsuario) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoGruposDTO resultado = new ListadoGruposDTO();
		GrupoDTO[] dtos = null;
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "pv_cons_seg_grupo_pr", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
			cstmt.setString(1, nomUsuario);
			logger.debug("nomUsuario: " + nomUsuario);
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
			ArrayList array = new ArrayList();
			while (rs.next())
			{
				GrupoDTO dto = new GrupoDTO();
				dto.setCodGrupo(rs.getString(1));
				dto.setDesGrupo(rs.getString(2));
				array.add(dto);
			}
			dtos = (GrupoDTO[]) array.toArray(new GrupoDTO[array.size()]);
			resultado.setArrayGrupos(dtos);
			if (dtos == null || (dtos != null && dtos.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0042"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0042"));
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
	 * Consulta el detalle de los equipos
	 * @param numAbonado
	 * @return {@link ListadoServSuplementariosDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public MenuDTO cargaValidaOSUsuario(String nombreUsuario) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		MenuDTO resultado = new MenuDTO();
		OOSSXUsuarioDTO[] ossUsuario = null;
		OOSSXAbonadoDTO[] ossAbonado = null;
		OOSSXClienteDTO[] ossCliente = null;
		OOSSXCuentaDTO[] ossCuenta = null;
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", "PV_CONS_OOSS_X_USUARIO_PR", 7);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			cstmt.setString(1, nombreUsuario);
			logger.debug("validacionUsuario.getNombreUsuario() : " + nombreUsuario);
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			if (codError != 0)
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0027"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0027"));
			}
			else
			{

				resultado.setNombreOperador(cstmt.getString(3));
				resultado.setOficina(cstmt.getString(4));

				rs = (ResultSet) cstmt.getObject(2);

				ArrayList listadoOsUsuario = new ArrayList();
				ArrayList listadoOsCliente = new ArrayList();
				ArrayList listadoOsAbonado = new ArrayList();
				ArrayList listadoOsCuenta = new ArrayList();
				while (rs.next())
				{

					if (rs.getString(2).trim().equals("ABONADO"))
					{
						OOSSXAbonadoDTO osAbonado = new OOSSXAbonadoDTO();
						osAbonado.setCodOOSS(rs.getString(1));
						osAbonado.setDesValor(rs.getString(2));
						osAbonado.setDescripcion(rs.getString(3));
						listadoOsAbonado.add(osAbonado);
					}
					else if (rs.getString(2).trim().equals("CUENTA"))
					{
						OOSSXCuentaDTO osCuenta = new OOSSXCuentaDTO();
						osCuenta.setCodOOSS(rs.getString(1));
						osCuenta.setDesValor(rs.getString(2));
						osCuenta.setDescripcion(rs.getString(3));
						listadoOsCuenta.add(osCuenta);
					}
					else if (rs.getString(2).trim().equals("CLIENTE"))
					{
						OOSSXClienteDTO osCliente = new OOSSXClienteDTO();
						osCliente.setCodOOSS(rs.getString(1));
						osCliente.setDesValor(rs.getString(2));
						osCliente.setDescripcion(rs.getString(3));
						listadoOsCliente.add(osCliente);

					}
					else if (rs.getString(2).trim().equals("USUARIO"))
					{
						OOSSXUsuarioDTO osUsuario = new OOSSXUsuarioDTO();
						osUsuario.setCodOOSS(rs.getString(1));
						osUsuario.setDesValor(rs.getString(2));
						osUsuario.setDescripcion(rs.getString(3));
						listadoOsUsuario.add(osUsuario);
					}
				}
				ossUsuario = (OOSSXUsuarioDTO[]) listadoOsUsuario.toArray(new OOSSXUsuarioDTO[listadoOsUsuario.size()]);
				ossCliente = (OOSSXClienteDTO[]) listadoOsCliente.toArray(new OOSSXClienteDTO[listadoOsCliente.size()]);
				ossAbonado = (OOSSXAbonadoDTO[]) listadoOsAbonado.toArray(new OOSSXAbonadoDTO[listadoOsAbonado.size()]);
				ossCuenta = (OOSSXCuentaDTO[]) listadoOsCuenta.toArray(new OOSSXCuentaDTO[listadoOsCuenta.size()]);

				resultado.setArrayOOSSXUsuario(ossUsuario);
				resultado.setArrayOOSSXCliente(ossCliente);
				resultado.setArrayOOSSXCuenta(ossCuenta);
				resultado.setArrayOOSSXAbonado(ossAbonado);
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
