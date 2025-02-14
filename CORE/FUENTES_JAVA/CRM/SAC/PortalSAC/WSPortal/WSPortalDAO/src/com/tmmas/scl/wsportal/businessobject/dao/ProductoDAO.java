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
import com.tmmas.scl.wsportal.common.dto.CambioPlanTarifDTO;
import com.tmmas.scl.wsportal.common.dto.DetallePlanTarifarioDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoCambiosPlanTarifDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoNumerosFrecuentesDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoProductosDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoServSuplementariosDTO;
import com.tmmas.scl.wsportal.common.dto.NumeroFrecuenteDTO;
import com.tmmas.scl.wsportal.common.dto.ProductoDTO;
import com.tmmas.scl.wsportal.common.dto.ServSuplementarioDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class ProductoDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(ProductoDAO.class);

	protected static final String CLAVE_TEXTO_PARA_DETALLE = "texto.detalle.producto";

	protected static final String TEXTO_PARA_DETALLE = config.getString(CLAVE_TEXTO_PARA_DETALLE);

	public ProductoDAO()
	{

	}

	public ListadoCambiosPlanTarifDTO cambiosPlanCliente(Long numOS) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCambiosPlanTarifDTO r = null;
		final String nombrePL = "pv_cons_cbplan_clte_pr";
		try
		{
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			logger.debug("numOS: " + numOS.longValue());
			cstmt.setLong(1, numOS.longValue());
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
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				CambioPlanTarifDTO dto = new CambioPlanTarifDTO();
				dto.setDesPlanTarifOrigen(rs.getString(1));
				logger.debug("dto.getDesPlanTarifOrigen: " + dto.getDesPlanTarifOrigen());
				dto.setDesPlanTarifDestino(rs.getString(2));
				logger.debug("dto.getDesPlanTarifDestino: " + dto.getDesPlanTarifDestino());
				dto.setFechaDesde(rs.getString(3));
				logger.debug("dto.getFechaDesde: " + dto.getFechaDesde());
				dto.setUsuario(rs.getString(4));
				logger.debug("dto.getUsuario: " + dto.getUsuario());
				dto.setComentario(rs.getString(5));
				logger.debug("dto.getComentario: " + dto.getComentario());
				a.add(dto);
			}
			r = new ListadoCambiosPlanTarifDTO();
			CambioPlanTarifDTO[] toArray = (CambioPlanTarifDTO[]) a.toArray(new CambioPlanTarifDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0035"));
				r.setDesError(config.getString("DES.ERR_SAC.0035"));
			}
			else
			{
				logger.debug("Encontrados: " + toArray.length);
				r.setArrayCambiosPlanTarif(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPospago(Long numOS) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCambiosPlanTarifDTO r = null;
		final String nombrePL = "pv_cons_cbplan_abo_pos_pr";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numOS.longValue());
			logger.debug("numOS: " + numOS);
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
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				CambioPlanTarifDTO dto = new CambioPlanTarifDTO();
				dto.setDesPlanTarifOrigen(rs.getString(1));
				logger.debug("dto.getDesPlanTarifOrigen: " + dto.getDesPlanTarifOrigen());
				dto.setDesPlanTarifDestino(rs.getString(2));
				logger.debug("dto.getDesPlanTarifDestino: " + dto.getDesPlanTarifDestino());
				dto.setFechaDesde(rs.getString(3));
				logger.debug("dto.getFechaDesde: " + dto.getFechaDesde());
				dto.setUsuario(rs.getString(4));
				logger.debug("dto.getUsuario: " + dto.getUsuario());
				dto.setComentario(rs.getString(5));
				logger.debug("dto.getComentario: " + dto.getComentario());
				a.add(dto);
			}
			r = new ListadoCambiosPlanTarifDTO();
			CambioPlanTarifDTO[] toArray = (CambioPlanTarifDTO[]) a.toArray(new CambioPlanTarifDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0034"));
				r.setDesError(config.getString("DES.ERR_SAC.0034"));
			}
			else
			{
				logger.debug("Encontrados: " + toArray.length);
				r.setArrayCambiosPlanTarif(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoCambiosPlanTarifDTO cambiosPlanAbonadoPrepago(Long numOS) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoCambiosPlanTarifDTO r = null;
		final String nombrePL = "pv_cons_cbplan_abo_pre_pr";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numOS.longValue());
			logger.debug("numOS: " + numOS);
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
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				CambioPlanTarifDTO dto = new CambioPlanTarifDTO();
				dto.setDesPlanTarifOrigen(rs.getString(1));
				logger.debug("dto.getDesPlanTarifOrigen: " + dto.getDesPlanTarifOrigen());
				dto.setDesPlanTarifDestino(rs.getString(2));
				logger.debug("dto.getDesPlanTarifDestino: " + dto.getDesPlanTarifDestino());
				dto.setFechaDesde(rs.getString(3));
				logger.debug("dto.getFechaDesde: " + dto.getFechaDesde());
				dto.setUsuario(rs.getString(4));
				logger.debug("dto.getUsuario: " + dto.getUsuario());
				dto.setComentario(rs.getString(5));
				logger.debug("dto.getComentario: " + dto.getComentario());
				a.add(dto);
			}
			r = new ListadoCambiosPlanTarifDTO();
			CambioPlanTarifDTO[] toArray = (CambioPlanTarifDTO[]) a.toArray(new CambioPlanTarifDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0050"));
				r.setDesError(config.getString("DES.ERR_SAC.0050"));
			}
			else
			{
				logger.debug("Encontrados: " + toArray.length);
				r.setArrayCambiosPlanTarif(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	/**
	 * Detalle plan tarifario.
	 * 
	 * @param codPlanTarifario the cod plan tarifario
	 * 
	 * @return the detalle plan tarifario dto
	 * 
	 * @throws PortalSACException the proyecto exception
	 */
	public DetallePlanTarifarioDTO detallePlanTarifario(String codPlanTarifario) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		DetallePlanTarifarioDTO r = new DetallePlanTarifarioDTO();
		final String nombrePL = "pv_cons_detalle_plan_pr";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setString(1, codPlanTarifario);
			logger.debug("codCliente: " + codPlanTarifario);
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

			if (rs.next())
			{
				r.setCodPlanTarifario(rs.getString(1));
				r.setDesPlanTarifario(rs.getString(2));
				r.setCodCargoBasico(rs.getString(3));
				r.setCodLimiteConsumo(rs.getString(4));
				r.setImpLimiteConsumo(new Double(rs.getDouble(5)));
			}
			else
			{
				r.setCodError(config.getString("COD.ERR_SAC.0036"));
				r.setDesError(config.getString("DES.ERR_SAC.0036"));
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoNumerosFrecuentesDTO numerosFrecuentesXPlan(Long numAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoNumerosFrecuentesDTO r = null;
		final String nombrePL = "PV_CONS_NUMFREC_PLAN_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numAbonado.longValue());
			logger.debug("numAbonado: " + numAbonado);
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
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				NumeroFrecuenteDTO dto = new NumeroFrecuenteDTO();
				dto.setTipNumFrecuente(rs.getString(1));
				dto.setNumTelefEspecial(rs.getString(2));
				a.add(dto);
			}
			r = new ListadoNumerosFrecuentesDTO();
			NumeroFrecuenteDTO[] toArray = (NumeroFrecuenteDTO[]) a.toArray(new NumeroFrecuenteDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0043"));
				r.setDesError(config.getString("DES.ERR_SAC.0043"));
			}
			else
			{
				r.setArrayNumerosFrecuentes(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoProductosDTO productosXNumAbonado(Long numAbonado) throws PortalSACException
	{
		ListadoProductosDTO r = new ListadoProductosDTO();
		ArrayList array = new ArrayList();
		logger.info(MENSAJE_INICIO_LOG);

		ListadoProductosDTO pp = null;
		ListadoProductosDTO ss = null;

		pp = this.planesXNumAbonado(numAbonado);
		ss = this.ssXNumAbonado(numAbonado);

		if (pp.getArrayProductos() != null)
		{
			logger.debug("Cant. Planes [" + pp.getArrayProductos().length + "]");
			array.addAll(Arrays.asList(pp.getArrayProductos()));
		}
		else
		{
			logger.debug("getCodError [" + pp.getCodError() + "]");
			logger.debug("getDesError [" + pp.getDesError() + "]");
		}

		if (ss.getArrayProductos() != null)
		{
			logger.debug("Cant. Servicios Sumplementarios [" + ss.getArrayProductos().length + "]");
			array.addAll(Arrays.asList(ss.getArrayProductos()));
		}
		else
		{
			logger.debug("getCodError [" + ss.getCodError() + "]");
			logger.debug("getDesError [" + ss.getDesError() + "]");
		}

		logger.debug("Total Documentos [" + array.size() + "]");

		if (array == null || (array != null && array.size() == 0))
		{
			r.setCodError(config.getString("COD.ERR_SAC.0040"));
			r.setDesError(config.getString("DES.ERR_SAC.0040"));
		}
		else
		{
			ProductoDTO[] arrayProductos = new ProductoDTO[array.size()];
			for (int i = 0; i < array.size(); i++)
			{
				arrayProductos[i] = (ProductoDTO) array.get(i);
			}
			r.setArrayProductos(arrayProductos);
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoProductosDTO productosXCodCliente(Long codCliente) throws PortalSACException
	{
		ListadoProductosDTO r = new ListadoProductosDTO();
		ArrayList array = new ArrayList();
		logger.info(MENSAJE_INICIO_LOG);

		ListadoProductosDTO pp = null;
		ListadoProductosDTO ss = null;

		pp = this.planesXCodCliente(codCliente);
		ss = this.ssXCodCliente(codCliente);

		if (pp.getArrayProductos() != null)
		{
			logger.debug("Cant. Planes [" + pp.getArrayProductos().length + "]");
			array.addAll(Arrays.asList(pp.getArrayProductos()));
		}
		else
		{
			logger.debug("getCodError [" + pp.getCodError() + "]");
			logger.debug("getDesError [" + pp.getDesError() + "]");
		}

		if (ss.getArrayProductos() != null)
		{
			logger.debug("Cant. Servicios Sumplementarios [" + ss.getArrayProductos().length + "]");
			array.addAll(Arrays.asList(ss.getArrayProductos()));
		}
		else
		{
			logger.debug("getCodError [" + ss.getCodError() + "]");
			logger.debug("getDesError [" + ss.getDesError() + "]");
		}

		logger.debug("Total Documentos [" + array.size() + "]");

		if (array == null || (array != null && array.size() == 0))
		{
			r.setCodError(config.getString("COD.ERR_SAC.0039"));
			r.setDesError(config.getString("DES.ERR_SAC.0039"));
		}
		else
		{
			ProductoDTO[] arrayProductos = new ProductoDTO[array.size()];
			for (int i = 0; i < array.size(); i++)
			{
				arrayProductos[i] = (ProductoDTO) array.get(i);
			}
			r.setArrayProductos(arrayProductos);
		}

		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoProductosDTO planesXCodCliente(Long codCliente) throws PortalSACException
	{

		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoProductosDTO r = null;

		final String nombrePL = "PV_CONS_PLANES_X_CLIENTE_PR";

		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL [" + call + "]");
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
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				ProductoDTO dto = new ProductoDTO();
				dto.setCodProducto(rs.getString(1));
				dto.setDesProducto(rs.getString(2));
				dto.setImporteCargoBasico(rs.getString(3));
				dto.setCodConcepto(rs.getString(4));
				dto.setTextoDetalle(TEXTO_PARA_DETALLE);
				a.add(dto);
			}
			r = new ListadoProductosDTO();
			ProductoDTO[] toArray = (ProductoDTO[]) a.toArray(new ProductoDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0032"));
				r.setDesError(config.getString("DES.ERR_SAC.0032"));
			}
			else
			{
				r.setArrayProductos(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoProductosDTO planesXNumAbonado(Long numAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoProductosDTO r = null;
		final String nombrePL = "pv_cons_plan_abo_pr";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numAbonado.longValue());
			logger.debug("numAbonado: " + numAbonado);
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
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				ProductoDTO dto = new ProductoDTO();
				dto.setCodProducto(rs.getString(1));
				dto.setDesProducto(rs.getString(2));
				dto.setImporteCargoBasico(rs.getString(3));
				dto.setCodConcepto(rs.getString(4));
				dto.setTextoDetalle(TEXTO_PARA_DETALLE);
				a.add(dto);
			}
			r = new ListadoProductosDTO();
			ProductoDTO[] toArray = (ProductoDTO[]) a.toArray(new ProductoDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0030"));
				r.setDesError(config.getString("DES.ERR_SAC.0030"));
			}
			else
			{
				r.setArrayProductos(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoProductosDTO ssXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoProductosDTO r = null;
		final String nombrePL = "PV_CONS_SS_X_CLIENTE_PR";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
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
			ArrayList a = new ArrayList();

			/*
			 * Modificacion
			 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
			 * Requisito: RSis_001
			 * Caso de uso: CU-001 Modificar Listado Productos por Abonado/Clientes
			 * Developer: Jorge González N.
			 * Fecha: 13/07/2010
			 * 
			 */
			
			while (rs.next())
			{
				ProductoDTO dto = new ProductoDTO();

				dto.setCodProducto(rs.getString(1));
				dto.setDesProducto(rs.getString(2));
				dto.setImporteCargoBasico(rs.getString(3));
				dto.setCodConcepto(rs.getString(4));
				dto.setEstadoAltBaj(rs.getString(5)); //Estado alta o baja
				dto.setFechAltaBD(rs.getString(6)); //fecha de alta BD
				dto.setFecBajaBD(rs.getString(7)); //fecha de baja BD
				dto.setFechAltaCentral(rs.getString(8)); //fecha de alta Central
				dto.setFecBajaCentral(rs.getString(9)); //fecha de baja Central
				
				a.add(dto);
			}
			r = new ListadoProductosDTO();
			ProductoDTO[] toArray = (ProductoDTO[]) a.toArray(new ProductoDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0033"));
				r.setDesError(config.getString("DES.ERR_SAC.0033"));
			}
			else
			{
				r.setArrayProductos(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoServSuplementariosDTO ssXDefectoXCodCliente(Long codCliente) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoServSuplementariosDTO r = null;
		final String plName = "pv_cons_ss_defplan_x_cli_pr";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, plName, 5);
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
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				ServSuplementarioDTO dto = new ServSuplementarioDTO();
				dto.setCodServicio(rs.getString(1));
				dto.setDesServicio(rs.getString(2));
				dto.setAplica(rs.getString(3));
				a.add(dto);
			}
			r = new ListadoServSuplementariosDTO();
			ServSuplementarioDTO[] toArray = (ServSuplementarioDTO[]) a.toArray(new ServSuplementarioDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0049"));
				r.setDesError(config.getString("DES.ERR_SAC.0049"));
			}
			else
			{
				r.setArraySS(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoServSuplementariosDTO ssXDefectoXNumAbonado(Long numAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoServSuplementariosDTO r = null;
		final String plName = "pv_cons_ss_defplan_x_abo_pr";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, plName, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numAbonado.longValue());
			logger.debug("numAbonado: " + numAbonado);
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
			ArrayList a = new ArrayList();

			while (rs.next())
			{
				ServSuplementarioDTO dto = new ServSuplementarioDTO();
				dto.setCodServicio(rs.getString(1));
				dto.setDesServicio(rs.getString(2));
				dto.setAplica("");
				a.add(dto);
			}
			r = new ListadoServSuplementariosDTO();
			ServSuplementarioDTO[] toArray = (ServSuplementarioDTO[]) a.toArray(new ServSuplementarioDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0044"));
				r.setDesError(config.getString("DES.ERR_SAC.0044"));
			}
			else
			{
				r.setArraySS(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}

	public ListadoProductosDTO ssXNumAbonado(Long numAbonado) throws PortalSACException
	{
		Connection conn = null;
		CallableStatement cstmt = null;
		ResultSet rs = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ListadoProductosDTO r = null;
		final String plName = "pv_cons_ss_abo_pr";
		try
		{
			logger.debug(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, plName, 5);
			cstmt = conn.prepareCall(call);
			logger.debug("SQL[" + call + "]");
			cstmt.setLong(1, numAbonado.longValue());
			logger.debug("numAbonado: " + numAbonado);
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
			ArrayList a = new ArrayList();

			/*
			 * Modificacion
			 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
			 * Requisito: RSis_001
			 * Caso de uso: CU-001 Modificar Listado Productos por Abonado/Clientes
			 * Developer: Gabriel Moraga L.
			 * Fecha: 12/07/2010
			 * 
			 */
			
			while (rs.next())
			{
				ProductoDTO dto = new ProductoDTO();

				dto.setCodProducto(rs.getString(1));
				dto.setDesProducto(rs.getString(2));
				dto.setImporteCargoBasico(rs.getString(3));
				dto.setCodConcepto(rs.getString(4));
				dto.setEstadoAltBaj(rs.getString(5)); //Estado alta o baja
				dto.setFechAltaBD(rs.getString(6)); //fecha de alta BD
				dto.setFecBajaBD(rs.getString(7)); //fecha de baja BD
				dto.setFechAltaCentral(rs.getString(8)); //fecha de alta Central
				dto.setFecBajaCentral(rs.getString(9)); //fecha de baja Central
				a.add(dto);
			}
			r = new ListadoProductosDTO();
			ProductoDTO[] toArray = (ProductoDTO[]) a.toArray(new ProductoDTO[a.size()]);
			if (toArray == null || (toArray != null && toArray.length == 0))
			{
				r.setCodError(config.getString("COD.ERR_SAC.0031"));
				r.setDesError(config.getString("DES.ERR_SAC.0031"));
			}
			else
			{
				r.setArrayProductos(toArray);
			}
		}
		catch (java.lang.Exception e)
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
		logger.debug(MENSAJE_FIN_LOG);
		return r;
	}
}