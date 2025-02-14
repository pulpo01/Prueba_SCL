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
import java.util.Arrays;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.ClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DetalleClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DeudaClienteDTO;
import com.tmmas.scl.wsportal.common.dto.DocCtaCteClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoClientesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoDocCtaCteClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoUmtsAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.UmtsAbonadoDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.common.helper.Util;

public class ClienteDAO extends BaseDAO
{
	private static final String NOMBRE_CLASE = ClienteDAO.class.getName();

	private static Logger logger = Logger.getLogger(ClienteDAO.class);

	static final String K_TEXTO_PARA_DETALLE = "texto.detalle.factura";

	static final String TEXTO_PARA_DETALLE = config.getString(K_TEXTO_PARA_DETALLE);

	static final String K_COD_TIP_DOCUM_CON_DETALLE = NOMBRE_CLASE + "." + "COD_TIP_DOCUM_CON_DETALLE";

	static final String[] COD_TIP_DOCUM_CON_DETALLE = config.getStringArray(K_COD_TIP_DOCUM_CON_DETALLE);

	static boolean enArrayCodTipDocum(String s)
	{
		return Util.enArray(COD_TIP_DOCUM_CON_DETALLE, s);
	}

	public ClienteDAO()
	{

	}

	/**
	 * Consulta los clientes asociados a una cuenta
	 * 
	 * @param codCuenta
	 * @return {@link ListadoClientesDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoClientesDTO clientesXCuenta(Long codCuenta) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoClientesDTO resultado = new ListadoClientesDTO();
		ClienteDTO[] clientesDTO = null;
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String sql = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_CLIE_X_CUEN_PR", 5);
			cstmt = conn.prepareCall(sql);

			logger.debug("SQL: " + sql);
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

			ArrayList clientes = new ArrayList();
			while (rs.next())
			{
				ClienteDTO cliente = new ClienteDTO();
				cliente.setCodCliente(new Long(rs.getLong(1)));
				cliente.setNomCliente(rs.getString(2));
				cliente.setTipPersona(rs.getString(3));
				cliente.setFecAlta(rs.getString(4));
				cliente.setCodCuenta(rs.getString(5));
				
				//Son para el ordenamiento de la tabla
				cliente.setFecAltaOrd(rs.getString(6));
				
				clientes.add(cliente);
			}
			clientesDTO = (ClienteDTO[]) clientes.toArray(new ClienteDTO[clientes.size()]);
			resultado.setArrayClientes(clientesDTO);

			if (clientesDTO == null || (clientesDTO != null && clientesDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0005"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0005"));
			}

		}
		catch (Exception e)
		{
			PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
					COD_ERROR, DES_ERROR, e);
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
	 * Consulta los clientes asociados al nombre de cliente
	 * 
	 * @param nombre
	 * @return {@link ListadoClientesDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoClientesDTO clientesXNombre(String nombre) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoClientesDTO resultado = new ListadoClientesDTO();
		ClienteDTO[] clientesDTO = null;

		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String sql = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_CLIE_X_NOM_PR", 5);
			cstmt = conn.prepareCall(sql);

			logger.debug("SQL: " + sql);
			cstmt.setString(1, nombre);
			logger.debug("nombre: " + nombre);
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

			ArrayList clientes = new ArrayList();

			while (rs.next())
			{
				ClienteDTO cliente = new ClienteDTO();
				cliente.setCodCliente(new Long(rs.getLong(1)));
				cliente.setNomCliente(rs.getString(2));
				cliente.setTipPersona(rs.getString(3));
				cliente.setFecAlta(rs.getString(4));
				cliente.setCodCuenta(rs.getString(5));
				
				//Son para el ordenamiento de la tabla
				cliente.setFecAltaOrd(rs.getString(6));
				
				clientes.add(cliente);
			}

			clientesDTO = (ClienteDTO[]) clientes.toArray(new ClienteDTO[clientes.size()]);
			resultado.setArrayClientes(clientesDTO);

			if (clientesDTO == null || (clientesDTO != null && clientesDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0006"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0006"));
			}

		}
		catch (Exception e)
		{
			PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(
					COD_ERROR, DES_ERROR, e);
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
	 * Consulta los clientes asociados al codigo de cliente
	 * 
	 * @param codCliente
	 * @return {@link ListadoClientesDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoClientesDTO clientesXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoClientesDTO resultado = new ListadoClientesDTO();
		ClienteDTO[] clientesDTO = null;

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String sql = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_GRILLA_CLIE_X_COD_PR", 5);
			cstmt = conn.prepareCall(sql);

			logger.debug("SQL[" + sql + "]");
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

			ArrayList clientes = new ArrayList();
			while (rs.next())
			{
				ClienteDTO cliente = new ClienteDTO();
				cliente.setCodCliente(new Long(rs.getLong(1)));
				cliente.setNomCliente(rs.getString(2));
				cliente.setTipPersona(rs.getString(3));
				cliente.setFecAlta(rs.getString(4));
				cliente.setCodCuenta(rs.getString(5));
				
				//Es para el ordenamiento de la tabla
				cliente.setFecAltaOrd(rs.getString(6));
				
				clientes.add(cliente);
			}
			clientesDTO = (ClienteDTO[]) clientes.toArray(new ClienteDTO[clientes.size()]);
			resultado.setArrayClientes(clientesDTO);

			if (clientesDTO == null || (clientesDTO != null && clientesDTO.length == 0))
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0007"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0007"));
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
	 * Consulta el detalle de un cliente
	 * 
	 * @param codCliente
	 * @return {@link DetalleClienteDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public DetalleClienteDTO getDetalleCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DetalleClienteDTO resultado = new DetalleClienteDTO();

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_CLIENTE_DETALLE_PR", 5);
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
			
			/*
			 * Modificacion
			 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
			 * Requisito: RSis_007
			 * Caso de uso: CU-013 Modificar Información General de Cliente
			 * Developer: Jorge González N.
			 * Fecha: 13/07/2010
			 * 
			 */
			
			if (rs.next())
			{
				resultado.setCodCliente(new Long(rs.getLong(1)));
				resultado.setNomCliente(rs.getString(2));
				resultado.setDesTipIndet(rs.getString(3));
				resultado.setNumIdent(rs.getString(4));
				resultado.setTipPersona(rs.getString(5));
				resultado.setDesCategoria(rs.getString(6));
				resultado.setCodCiclo(new Long(rs.getLong(7)));
				resultado.setCodCatribut(rs.getString(8));
				resultado.setFecAlta(rs.getString(9));
				resultado.setFecAceptVenta(rs.getString(10));
				resultado.setFecBaja(rs.getString(11));
				resultado.setTelCliente1(new Long(rs.getLong(12)));
				resultado.setEmail(rs.getString(13));
				resultado.setCodCatImpositiva(rs.getInt(14));
				resultado.setDesCatImpositiva(rs.getString(15));
				resultado.setEsDealer(rs.getInt(16));
				resultado.setIngresoSalarial(rs.getLong(17));
				resultado.setIndDebito(rs.getString(18));
				resultado.setNumTarjeta(rs.getString(19));
				resultado.setFecVenciTarj(rs.getString(20));
			}
			else
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0008"));
				resultado.setDesError(config.getString("DES.ERR_SAC.0008"));
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
	 * Consulta la deuda de un cliente
	 * 
	 * @param codCliente
	 * @return long
	 * @throws {@link PortalSACException}
	 */
	public DeudaClienteDTO getDeudaCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DeudaClienteDTO resultado = new DeudaClienteDTO();

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_DEUDA_CLIENTE_PR", 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			logger.debug("codCliente : " + codCliente);

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
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

			cstmt.executeQuery();

			if (true)
			{
				float r = cstmt.getFloat(2);
				resultado.setDeudaTotal(r);
			}
			else
			{
				resultado.setCodError(config.getString("COD.ERR_SAC.0004"));
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
		return resultado;
	}

	public ListadoDocCtaCteClienteDTO getDocsCtaCteCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		ArrayList array = new ArrayList();
		logger.info(MENSAJE_INICIO_LOG);

		ListadoDocCtaCteClienteDTO aa = null;
		ListadoDocCtaCteClienteDTO pp = null;
		ListadoDocCtaCteClienteDTO ff = null;

		aa = this.getDocsAjustesCliente(codCliente, fecInicio, fecFin);
		pp = this.getDocsPagosCliente(codCliente, fecInicio, fecFin);
		ff = this.getDocsFactCliente(codCliente, fecInicio, fecFin);

		if (aa.getArrayDocumentos() != null)
		{
			logger.debug("Cant. Ajustes [" + aa.getArrayDocumentos().length + "]");
			array.addAll(Arrays.asList(aa.getArrayDocumentos()));
		}
		else
		{
			logger.debug("getCodError [" + aa.getCodError() + "]");
			logger.debug("getDesError [" + aa.getDesError() + "]");
		}

		if (pp.getArrayDocumentos() != null)
		{
			logger.debug("Cant. Pagos [" + pp.getArrayDocumentos().length + "]");
			array.addAll(Arrays.asList(pp.getArrayDocumentos()));
		}
		else
		{
			logger.debug("getCodError [" + pp.getCodError() + "]");
			logger.debug("getDesError [" + pp.getDesError() + "]");
		}

		if (ff.getArrayDocumentos() != null)
		{
			array.addAll(Arrays.asList(ff.getArrayDocumentos()));
			logger.debug("Cant. Facturas [" + ff.getArrayDocumentos().length + "]");
		}
		else
		{
			logger.debug("getCodError [" + ff.getCodError() + "]");
			logger.debug("getDesError [" + ff.getDesError() + "]");
		}

		logger.debug("Total Documentos [" + array.size() + "]");

		if (array == null || (array != null && array.size() == 0))
		{
			r.setCodError(config.getString("COD.ERR_SAC.0037"));
			r.setDesError(config.getString("DES.ERR_SAC.0037"));
		}
		else
		{
			DocCtaCteClienteDTO[] docs = new DocCtaCteClienteDTO[array.size()];
			for (int i = 0; i < array.size(); i++)
			{
				docs[i] = (DocCtaCteClienteDTO) array.get(i);
			}
			r.setArrayDocumentos(docs);
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	/**
	 * Consulta las facturas de un cliente y los devuelve en las atributos
	 * comunes a todos los documentos del cliente
	 * 
	 * @param codCliente
	 * @return {@link DocCtaCteClienteDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoDocCtaCteClienteDTO getDocsFactCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();
		final String nombrePL = "PV_CONS_DOC_FACT_X_CLI_PR";

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 8);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			logger.debug("codCliente : " + codCliente);
			logger.debug("fecInicio : " + fecInicio);
			logger.debug("fecFin : " + fecFin);
			cstmt.setLong(1, codCliente.longValue());
			cstmt.setString(2, fecInicio);
			cstmt.setString(3, fecFin);
			cstmt.setString(4, "dd/mm/YYYY");
			cstmt.registerOutParameter(5, OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");
			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			rs = (ResultSet) cstmt.getObject(5);
			ArrayList documentos = new ArrayList();
			while (rs.next())
			{
				DocCtaCteClienteDTO dto = new DocCtaCteClienteDTO();
				dto.setCodCliente(codCliente);
				dto.setNumFolio(new Long(rs.getLong(1)));
				dto.setCodTipDocum(rs.getString(2));
				dto.setDesTipDocum(rs.getString(3));
				dto.setDesObserva(rs.getString(4));
				dto.setFecEmision(rs.getString(5));
				dto.setFecVencimiento(rs.getString(6));
				dto.setTotalIVA(new Float(rs.getString(7)));
				dto.setImporteDebe(new Float(rs.getString(8)));
				dto.setIndOrdenTotal(new Long(rs.getString(9)));
				
				
				//Son para el ordenamiento de la tabla
				dto.setFecEmisionOrd(rs.getString(10));
				dto.setFecVencimientoOrd(rs.getString(11));
				dto.setAcumNetoGrav(Float.valueOf(rs.getFloat(12))); //Es agregado para obtener el Acumulado del Neto Gravado

																     /* En el AD para este requerimiento se pido modificar el procedimiento PV_CONS_GRILLA_CC_X_CLI_PR
																      * procedimiento que es llamado del método ccXCodCliente, el cual no estaba 
																      * relacionado con el requerimiento. Para corregir el tema se agrego el dato necesario
																      * al procedimeinto PV_CONS_DOC_FACT_X_CLI_PR que es llamdo en el método getDocsFactCliente.
																      */
				
				if (enArrayCodTipDocum(dto.getCodTipDocum()))
				{
					dto.setTextoDetalle(TEXTO_PARA_DETALLE);
				}

				documentos.add(dto);
			}
			DocCtaCteClienteDTO[] array = (DocCtaCteClienteDTO[]) documentos.toArray(new DocCtaCteClienteDTO[documentos.size()]);
			if (array == null || (array != null && array.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0017"));
				r.setDesError(config.getString("DES.ERR_SAC.0017"));
			}
			else
			{
				r.setArrayDocumentos(array);
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
	 * Consulta los pagos de un cliente y los devuelve en las atributos comunes
	 * a todos los documentos del cliente
	 * 
	 * @param codCliente
	 * @return {@link DocCtaCteClienteDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoDocCtaCteClienteDTO getDocsPagosCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoDocCtaCteClienteDTO r = new ListadoDocCtaCteClienteDTO();

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_DOC_PAGOS_X_CLI_PR", 8);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			logger.debug("codCliente : " + codCliente);
			logger.debug("fecInicio : " + fecInicio);
			logger.debug("fecFin : " + fecFin);

			cstmt.setLong(1, codCliente.longValue());
			cstmt.setString(2, fecInicio);
			cstmt.setString(3, fecFin);
			cstmt.setString(4, "dd/mm/YYYY");

			cstmt.registerOutParameter(5, OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			rs = (ResultSet) cstmt.getObject(5);

			ArrayList documentos = new ArrayList();
			while (rs.next())
			{
				DocCtaCteClienteDTO doc = new DocCtaCteClienteDTO();
				doc.setCodCliente(codCliente);
				doc.setNumFolio(new Long(rs.getLong(1)));
				doc.setCodTipDocum(rs.getString(2));
				doc.setDesTipDocum(rs.getString(3));
				doc.setDesObserva(rs.getString(4));
				doc.setFecEmision(rs.getString(5));
				doc.setFecVencimiento(rs.getString(6));
				doc.setTotalIVA(new Float(rs.getString(7)));
				doc.setImporteDebe(new Float(rs.getString(8)));
				
				//Son para el ordenamiento de la tabla
				doc.setFecEmisionOrd(rs.getString(9));
				doc.setFecVencimientoOrd(rs.getString(10));

				doc.setAcumNetoGrav(Float.valueOf(0)); //Se agrega parametro para tener consistencia con lo que rescata el metodo getDocsFactCliente
				
												       /* En el AD para este requerimiento se pido modificar el procedimiento PV_CONS_GRILLA_CC_X_CLI_PR
													    * procedimiento que es llamado del método ccXCodCliente, el cual no estaba 
													    * relacionado con el requerimiento. Para corregir el tema se agrego el dato necesario
													   	* al procedimeinto PV_CONS_DOC_FACT_X_CLI_PR que es llamdo en el método getDocsFactCliente.
													    */
						
				documentos.add(doc);
			}

			DocCtaCteClienteDTO[] listaDocCtaCteClienteDTO = null;
			listaDocCtaCteClienteDTO = (DocCtaCteClienteDTO[]) documentos.toArray(new DocCtaCteClienteDTO[documentos.size()]);
			r.setArrayDocumentos(listaDocCtaCteClienteDTO);

			if (listaDocCtaCteClienteDTO == null
					|| (listaDocCtaCteClienteDTO != null && listaDocCtaCteClienteDTO.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0024"));
				r.setDesError(config.getString("DES.ERR_SAC.0024"));
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
	 * Consulta los pagos de un cliente y los devuelve en las atributos comunes
	 * a todos los documentos del cliente
	 * 
	 * @param codCliente
	 * @return {@link DocCtaCteClienteDTO}[]
	 * @throws {@link PortalSACException}
	 */
	public ListadoDocCtaCteClienteDTO getDocsAjustesCliente(Long codCliente, String fecInicio, String fecFin)
			throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoDocCtaCteClienteDTO resultado = new ListadoDocCtaCteClienteDTO();

		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();

			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, "PV_CONS_DOC_AJUSTES_X_CLI_PR", 8);
			cstmt = conn.prepareCall(call);

			logger.debug("SQL[" + call + "]");
			logger.debug("codCliente : " + codCliente);
			logger.debug("fecInicio : " + fecInicio);
			logger.debug("fecFin : " + fecFin);

			cstmt.setLong(1, codCliente.longValue());
			cstmt.setString(2, fecInicio);
			cstmt.setString(3, fecFin);
			cstmt.setString(4, "dd/mm/YYYY");

			cstmt.registerOutParameter(5, OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Execute Antes");
			cstmt.execute();
			logger.debug("Execute Despues");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");

			rs = (ResultSet) cstmt.getObject(5);

			ArrayList documentos = new ArrayList();
			while (rs.next())
			{
				DocCtaCteClienteDTO doc = new DocCtaCteClienteDTO();
				doc.setCodCliente(codCliente);
				doc.setNumFolio(new Long(rs.getLong(1)));
				doc.setCodTipDocum(rs.getString(2));
				doc.setDesTipDocum(rs.getString(3));
				doc.setDesObserva(rs.getString(4));
				doc.setFecEmision(rs.getString(5));
				doc.setFecVencimiento(rs.getString(6));
				doc.setTotalIVA(new Float(rs.getString(7)));
				doc.setImporteDebe(new Float(rs.getString(8)));

				//Son para el ordenamiento de la tabla
				doc.setFecEmisionOrd(rs.getString(9));
				doc.setFecVencimientoOrd(rs.getString(10));
				
				doc.setAcumNetoGrav(Float.valueOf(0)); //Se agrega parametro para tener consistencia con lo que rescata el metodo getDocsFactCliente
													   
													   /* En el AD para este requerimiento se pido modificar el procedimiento PV_CONS_GRILLA_CC_X_CLI_PR
													    * procedimiento que es llamado del método ccXCodCliente, el cual no estaba 
													    * relacionado con el requerimiento. Para corregir el tema se agrego el dato necesario
													   	* al procedimeinto PV_CONS_DOC_FACT_X_CLI_PR que es llamdo en el método getDocsFactCliente.
													    */
				documentos.add(doc);
			}

			DocCtaCteClienteDTO[] listaDocCtaCteClienteDTO = null;
			listaDocCtaCteClienteDTO = (DocCtaCteClienteDTO[]) documentos.toArray(new DocCtaCteClienteDTO[documentos.size()]);
			resultado.setArrayDocumentos(listaDocCtaCteClienteDTO);

			if (listaDocCtaCteClienteDTO == null
					|| (listaDocCtaCteClienteDTO != null && listaDocCtaCteClienteDTO.length == 0))
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

	public ListadoUmtsAbonadosDTO umtsAbonadosXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoUmtsAbonadosDTO resultado = new ListadoUmtsAbonadosDTO();
		UmtsAbonadoDTO[] array = null;
		String procedureName = "PV_CONS_CANT_ABON_CLIENTE_PR";
		logger.debug("umtsAbonadosXCodCliente():inicio");
		try
		{
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, procedureName, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, codCliente.longValue());
			logger.debug("codCliente: " + codCliente);
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
				UmtsAbonadoDTO dto = new UmtsAbonadoDTO();
				dto.setCodTipoPlan(rs.getString(1));
				dto.setDesTipoPlan(rs.getString(2));
				dto.setCodTecnologia(rs.getString(3));
				dto.setDesTecnologia(rs.getString(4));
				dto.setCodSituacion(rs.getString(5));
				dto.setDesSituacion(rs.getString(6));
				dto.setTotal(rs.getInt(7));
				abonados.add(dto);
				array = (UmtsAbonadoDTO[]) abonados.toArray(new UmtsAbonadoDTO[abonados.size()]);
				resultado.setArrayUmtsAbonados(array);
				if (array == null || (array != null && array.length == 0))
				{
					resultado.setCodError(config.getString("COD.ERR_SAC.0009"));
					resultado.setDesError(config.getString("DES.ERR_SAC.0009"));
				}
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