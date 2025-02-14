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
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesAgendadasDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesProcesoDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoOrdenesServicioDTO;
import com.tmmas.scl.wsportal.common.dto.OOSSAgendadaDTO;
import com.tmmas.scl.wsportal.common.dto.OOSSEjecutadaDTO;
import com.tmmas.scl.wsportal.common.dto.OOSSProcesoDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.common.helper.Util;

public class OrdenServicioDAO extends BaseDAO
{
	private static final String NOMBRE_CLASE = OrdenServicioDAO.class.getName();

	static final String K_COD_OOSS_CON_DETALLE_CUENTA = NOMBRE_CLASE + "." + "COD_OOSS_CON_DETALLE_CUENTA";

	static final String K_COD_OOSS_CON_DETALLE_CLIENTE = NOMBRE_CLASE + "." + "COD_OOSS_CON_DETALLE_CLIENTE";

	static final String K_COD_OOSS_CON_DETALLE_ABONADO = NOMBRE_CLASE + "." + "COD_OOSS_CON_DETALLE_ABONADO";

	static final String K_TEXTO_PARA_DETALLE = "texto.detalle.os";

	static final String TEXTO_PARA_DETALLE = config.getString(K_TEXTO_PARA_DETALLE);

	static final String[] COD_OOSS_CON_DETALLE_CUENTA = config.getStringArray(K_COD_OOSS_CON_DETALLE_CUENTA);

	static final String[] COD_OOSS_CON_DETALLE_CLIENTE = config.getStringArray(K_COD_OOSS_CON_DETALLE_CLIENTE);

	static final String[] COD_OOSS_CON_DETALLE_ABONADO = config.getStringArray(K_COD_OOSS_CON_DETALLE_ABONADO);

	private static Logger logger = Logger.getLogger(OrdenServicioDAO.class);

	static boolean enArrayOOSSCuenta(String s)
	{
		return Util.enArray(COD_OOSS_CON_DETALLE_CUENTA, s);
	}

	static boolean enArrayOOSSCliente(String s)
	{
		return Util.enArray(COD_OOSS_CON_DETALLE_CLIENTE, s);
	}

	static boolean enArrayOOSSAbonado(String s)
	{
		return Util.enArray(COD_OOSS_CON_DETALLE_ABONADO, s);
	}

	public OrdenServicioDAO()
	{

	}

	/**
	 * Consulta las ordenes de servicio asociadas al codigo de cuenta
	 * @param codCuenta
	 * @return {@link ListadoOrdenesServicioDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXCodCuenta(Long codCuenta) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();

		final String nombrePL = "PV_CONS_GRILLA_OS_X_CUENTA_PR";

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
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

			ArrayList ordenes = new ArrayList();
			
			/*
			 * Modificacion
			 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
			 * Requisito: RSis_004
			 * Caso de uso: CU-012 Desplegar Comentario para OOSS Ejecutadas de Cuentas
			 * Developer: Gabriel Moraga L.
			 * Fecha: 12/07/2010
			 * 
			 */
			
			while (rs.next())
			{
				OOSSEjecutadaDTO dto = new OOSSEjecutadaDTO();
				dto.setNumOOSS(new Long(rs.getLong(1)));
				dto.setDescripcion(rs.getString(2));
				dto.setNomUsuario(rs.getString(3));
				dto.setFechaEjecucion(rs.getString(4));
				dto.setStatus(rs.getString(5));
				dto.setCodigo(rs.getString(6));
				dto.setComentario(rs.getString(7)); //Comentario
				
				//Es para el ordenamiento de la tabla
				dto.setFechaEjecucionOrd(rs.getString(8));

				final boolean enArray = enArrayOOSSCuenta(dto.getCodigo());
				if (enArray)
				{
					dto.setTextoDetalle(TEXTO_PARA_DETALLE);
				}

				ordenes.add(dto);
			}
			OOSSEjecutadaDTO[] toArray = (OOSSEjecutadaDTO[]) ordenes.toArray(new OOSSEjecutadaDTO[ordenes.size()]);

			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0021"));
				r.setDesError(config.getString("DES.ERR_SAC.0021"));
			}
			else
			{
				r.setArrayOOSS(toArray);
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

	/**
	 * Consulta las ordenes de servicio asociadas al codigo de cliente
	 * @param codCliente
	 * @return {@link ListadoOrdenesServicioDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();
		final String nombrePL = "PV_CONS_GRILLA_OS_X_CLIENTE_PR";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
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
			ArrayList ordenes = new ArrayList();
			
			/*
			 * Modificacion
			 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
			 * Requisito: RSis_004
			 * Caso de uso: CU-007 Desplegar Comentario para OOSS Ejecutadas de Clientes
			 * Developer: Gabriel Moraga L.
			 * Fecha: 12/07/2010
			 * 
			 */
			
			while (rs.next())
			{
				OOSSEjecutadaDTO dto = new OOSSEjecutadaDTO();
				dto.setNumOOSS(new Long(rs.getLong(1)));
				dto.setDescripcion(rs.getString(2));
				dto.setNomUsuario(rs.getString(3));
				dto.setFechaEjecucion(rs.getString(4));
				dto.setStatus(rs.getString(5));
				dto.setCodigo(rs.getString(6));
				dto.setComentario(rs.getString(7)); //Comentario
				
				//Es para el ordenamiento de la tabla
				dto.setFechaEjecucionOrd(rs.getString(8));
				
				final boolean enArray = enArrayOOSSCliente(dto.getCodigo());
				if (enArray)
				{
					dto.setTextoDetalle(TEXTO_PARA_DETALLE);
				}
				ordenes.add(dto);
			}
			OOSSEjecutadaDTO[] toArray = (OOSSEjecutadaDTO[]) ordenes.toArray(new OOSSEjecutadaDTO[ordenes.size()]);

			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0022"));
				r.setDesError(config.getString("DES.ERR_SAC.0022"));
			}
			else
			{
				r.setArrayOOSS(toArray);
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

	/**
	 * Consulta las ordenes de servicio asociadas al numero de abonado
	 * @param NumAbonado
	 * @return {@link ListadoOrdenesServicioDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoOrdenesServicioDTO oossEjecutadasXNumAbonado(Long NumAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoOrdenesServicioDTO r = new ListadoOrdenesServicioDTO();
		final String nombrePL = "PV_CONS_GRILLA_OS_X_ABON_PR";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD("PV_CONSULTAS_PORTAL_PG", nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, NumAbonado.longValue());
			logger.debug("NumAbonado : " + NumAbonado);
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
			ArrayList ordenes = new ArrayList();
			
			/*
			 * Modificacion
			 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
			 * Requisito: RSis_004
			 * Caso de uso: CU-008 Desplegar Comentario para OOSS Ejecutadas de Abonados
			 * Developer: Gabriel Moraga L.
			 * Fecha: 12/07/2010
			 * 
			 */
			
			while (rs.next())
			{
				OOSSEjecutadaDTO dto = new OOSSEjecutadaDTO();
				dto.setNumOOSS(new Long(rs.getLong(1)));
				dto.setDescripcion(rs.getString(2));
				dto.setNomUsuario(rs.getString(3));
				dto.setFechaEjecucion(rs.getString(4));
				dto.setStatus(rs.getString(5));
				dto.setCodigo(rs.getString(6));
				dto.setComentario(rs.getString(7)); //Comentario
				
				//Es para el ordenamiento de la tabla
				dto.setFechaEjecucionOrd(rs.getString(8));
				
				final boolean enArray = enArrayOOSSAbonado(dto.getCodigo());
				if (enArray)
				{
					dto.setTextoDetalle(TEXTO_PARA_DETALLE);
				}
				ordenes.add(dto);
			}
			OOSSEjecutadaDTO[] toArray = (OOSSEjecutadaDTO[]) ordenes.toArray(new OOSSEjecutadaDTO[ordenes.size()]);

			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0023"));
				r.setDesError(config.getString("DES.ERR_SAC.0023"));
			}
			else
			{
				r.setArrayOOSS(toArray);
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

	/**
	 * Consulta las ordenes de servicio agendadas por CLIENTE/ABONADO/CUENTA
	 * @param NumAbonado
	 * @return {@link ListadoOrdenesAgendadasDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoOrdenesAgendadasDTO obtenerOoSsAgendadas(Long numDato, Integer tipoDato) throws PortalSACException
	{
		/*
		 * Modificacion
		 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
		 * Requisito: RSis_005
		 * Caso de uso: CU-009 Obtener OOSS Agendadas 
		 * Developer: Jorge González N.
		 * Fecha: 13/07/2010
		 * 
		 */
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int codResultado = 0;
		ListadoOrdenesAgendadasDTO r = new ListadoOrdenesAgendadasDTO();
		final String nombrePL = "pv_obtiene_ooss_agendadas_pr";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 6);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			
			cstmt.setLong(1, numDato);
			logger.debug("Numero Dato : " + numDato);
			cstmt.setLong(2, tipoDato);
			logger.debug("tipo Dato : " + tipoDato);
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			codResultado = cstmt.getInt(6);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("codResultado[" + codResultado + "]");
			
			if (codError != 0)
			{
				throw new PortalSACException(String.valueOf(codError), msgError, codResultado);
			}
			rs = (ResultSet) cstmt.getObject(3);
			ArrayList ordenes = new ArrayList();
		
			while (rs.next())
			{
				OOSSAgendadaDTO dto = new OOSSAgendadaDTO();
				dto.setNumOOSS(new Long(rs.getLong(1)));
				dto.setDescripcionOOSS(rs.getString(2));
				dto.setCodEstado(new Integer (rs.getInt(3)));
				dto.setFechaIngreso(rs.getString(4));
				dto.setFechaEjecucion(rs.getString(5));
				dto.setUsuario(rs.getString(6));
				dto.setComentario(rs.getString(7));
				dto.setDescripcion(rs.getString(8));
				dto.setStatus(rs.getString(9));
				dto.setDesProceso(rs.getString(10));
			
				ordenes.add(dto);
			}
			OOSSAgendadaDTO[] toArray = (OOSSAgendadaDTO[]) ordenes.toArray(new OOSSAgendadaDTO[ordenes.size()]);

			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				if (codError == 3){				
					r.setCodError(config.getString("COD.ERR_SAC.0055"));
					r.setDesError(config.getString("DES.ERR_SAC.0055"));				
				}else{
					r.setCodError(config.getString("COD.ERR_SAC.0056"));
					r.setDesError(config.getString("DES.ERR_SAC.0056"));
				}
			}
			else
			{
				r.setArrayOOSS(toArray);
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
	
	/**
	 * Consulta si existen ordenes de servicio en proceso
	 * @param nomUsuario
	 * @return {@link Boolean}
	 * @throws {@link PortalSACException}
	 */
	public Boolean consultaOoSsProceso(String nomUsuario) throws PortalSACException
	{
		/*
		 * Modificacion
		 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
		 * Requisito: RSis_009
		 * Caso de uso: CU-015 Desplegar Leyenda de Ejecución de OOSS 
		 * Developer: Jorge González N.
		 * Fecha: 13/07/2010
		 * 
		 */
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		Boolean r = Boolean.FALSE;
		final String nombrePL = "pv_cons_ooss_proceso_pr";
		
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 2);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			
			cstmt.setString(1, nomUsuario);
			logger.debug("Nombre Usuario : " + nomUsuario);			
			cstmt.registerOutParameter(2, OracleTypes.NUMBER);
			
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			
			if (cstmt.getInt(2) == 0)
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
		return r;
	}
	
	/**
	 * obtiene las ordenes de servicio que estan en proceso
	 * @param NomUsuario
	 * @return {@link ListadoOrdenesProcesoDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoOrdenesProcesoDTO obtenerOoSsProceso(String nomUsuario) throws PortalSACException
	{
		/*
		 * Modificacion
		 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
		 * Requisito: RSis_009
		 * Caso de uso: CU-016 Desplegar OOSS en ejecución 
		 * Developer: Jorge González N.
		 * Fecha: 13/07/2010
		 * 
		 */	
		
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		
		ListadoOrdenesProcesoDTO r = new ListadoOrdenesProcesoDTO();
		final String nombrePL = "pv_obtiene_ooss_proceso_pr";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 2);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			
			cstmt.setString(1, nomUsuario);
			logger.debug("Nombre Usuario : " + nomUsuario);			
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			rs = (ResultSet) cstmt.getObject(2);
			ArrayList ordenes = new ArrayList();
		
			while (rs.next())
			{
				OOSSProcesoDTO dto = new OOSSProcesoDTO();
				dto.setNumOOSS(new Long(rs.getLong(1)));
				dto.setCodOOSS(rs.getString(2));
				dto.setDescripcionOOSS(rs.getString(3));
				dto.setTipEstado(new Integer(rs.getInt(4)));
				dto.setDescripcion(rs.getString(5));
				dto.setFechaIngreso(rs.getString(6));
				dto.setStatus(rs.getString(7));
				dto.setComentario(rs.getString(8));			
			
				ordenes.add(dto);
			}
			OOSSProcesoDTO[] toArray = (OOSSProcesoDTO[]) ordenes.toArray(new OOSSProcesoDTO[ordenes.size()]);
			
			r.setArrayOOSS(toArray);	

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
