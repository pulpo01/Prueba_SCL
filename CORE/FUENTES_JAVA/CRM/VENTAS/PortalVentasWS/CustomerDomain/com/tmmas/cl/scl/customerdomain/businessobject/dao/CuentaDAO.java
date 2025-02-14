package com.tmmas.cl.scl.customerdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaCuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CuentaDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class CuentaDAO extends ConnectionDAO
{

	private static Category cat = Category.getInstance(CuentaDAO.class);

	Global global = Global.getInstance();

	private Connection getConection() throws CustomerDomainException
	{
		Connection conn = null;
		try
		{
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		}
		catch (Exception e1)
		{
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
		}

		return conn;
	}// fin getConection

	private String getSQLDatosCuenta(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++)
		{
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();

	}// fin getSQLDatosCuenta

	public CuentaDTO getCuenta(CuentaDTO cuentaDTO) throws CustomerDomainException
	{
		cat.debug("Inicio:getCuenta()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		CuentaDTO resultado = null;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCuenta("VE_validacion_linea_PG", "VE_existe_cuenta_PR", 7);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Integer.parseInt(cuentaDTO.getCodigoCuenta()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			codError = cstmt.getInt(5);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(6);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(7);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar la cuenta");
				throw new CustomerDomainException("Ocurrió un error al consultar la cuenta", String.valueOf(codError),
						numEvento, msgError);
			}
			else
			{
				resultado = new CuentaDTO();
				resultado.setCodigoCuenta(cuentaDTO.getCodigoCuenta());
				resultado.setExisteCuenta(cstmt.getInt(2));
				resultado.setDescripcionCuenta(cstmt.getString(3));
				resultado.setCodigoCategoria(cstmt.getString(4));
			}

			cat.debug("cuenta[" + cuentaDTO.getCodigoCuenta() + "]");
			cat.debug("descripcion[" + resultado.getDescripcionCuenta() + "]");
			cat.debug("categoria[" + resultado.getCodigoCategoria() + "]");

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar la cuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Fin:getCuenta()");

		return resultado;
	}// fin getDatosCuenta

	public CuentaDTO existeSubCuenta(CuentaDTO cuentaDTO) throws CustomerDomainException
	{
		cat.debug("Inicio:existeSubCuenta()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCuenta("VE_validacion_linea_PG", "VE_existe_subcuenta_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Integer.parseInt(cuentaDTO.getCodigoCuenta()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al verificar si existe la subcuenta");
				throw new CustomerDomainException("Ocurrió un error al verificar si existe la subcuenta", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				cuentaDTO.setExisteSubCuenta(cstmt.getInt(2));
			}

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al verificar si existe la subcuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Fin:existeSubCuenta()");

		return cuentaDTO;
	}// fin getDatosCuenta

	public CuentaDTO getSubCuenta(CuentaDTO entrada) throws CustomerDomainException
	{
		cat.debug("Inicio:getSubCuenta()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try
		{
			String call = getSQLDatosCuenta("VE_crea_linea_venta_PG", "VE_obtiene_subcuentas_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Integer.parseInt(entrada.getCodigoCuenta()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("inicio:Execute");
			cstmt.execute();
			cat.debug("Fin:Execute");

			codError = cstmt.getInt(3);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar la Subcuenta");
				throw new CustomerDomainException("Ocurrió un error al consultar la Subcuenta", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				entrada.setCodigoSubCuenta(cstmt.getString(2));
			}
			cat.debug("cuenta[" + entrada.getCodigoCuenta() + "]");
			cat.debug("subcuenta[" + entrada.getCodigoSubCuenta() + "]");

			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar la Subcuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}

		cat.debug("Fin:getSubCuenta()");

		return entrada;
	}// fin getSubCuenta

	/**
	 * Obtiene listado de clasificacion cuenta
	 * 
	 * @param N/A
	 * @return CuentaDTO[]
	 * @throws CustomerDomainException
	 */
	public CuentaDTO[] getListClasificacionCuenta() throws CustomerDomainException
	{
		cat.debug("Inicio:getListClasificacionCuenta()");
		CuentaDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		try
		{
			String call = getSQLDatosCuenta("VE_alta_cuenta_PG", "VE_getListClasifCuenta_PR", 4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListClasificacionCuenta:execute");
			cstmt.execute();
			cat.debug("Fin:getListClasificacionCuenta:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al recuperar clasificacion de cuentas");
				throw new CustomerDomainException("Ocurrió un error al recuperar clasificacion de cuentas", String
						.valueOf(codError), numEvento, msgError);
			}
			else
			{
				cat.debug("Recuperando clasificacion de cuentas");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next())
				{
					CuentaDTO cuentaDTO = new CuentaDTO();
					cuentaDTO.setCodigoClasificacion(rs.getString(1));
					cuentaDTO.setDescripcionClasificacion(rs.getString(2));
					lista.add(cuentaDTO);
				}
				resultado = (CuentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CuentaDTO.class);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al recuperar clasificacion de cuentas", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListClasificacionCuenta()");
		return resultado;
	}// fin getListClasificacionCuenta

	public CuentaDTO[] getListadoCuenta(CuentaDTO criterioBusquedaCuenta) throws CustomerDomainException
	{
		cat.debug("Inicio:getListadoCuenta()");
		CuentaDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;

		try
		{
			String call = getSQLDatosCuenta("VE_alta_cuenta_PG", "VE_getListCuentas_PR", 8);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, criterioBusquedaCuenta.getCriterioBusqueda());
			cstmt.setString(2, criterioBusquedaCuenta.getFiltroBusqueda());
			cstmt.setString(3, criterioBusquedaCuenta.getValorBusqueda());
			cstmt.setString(4, criterioBusquedaCuenta.getTipoIdentificacion());
			cstmt.registerOutParameter(5, OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cat.debug("Inicio:getListadoCuenta:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoCuenta:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al recuperar cuentas");
				throw new CustomerDomainException("Ocurrió un error al recuperar  cuentas", String.valueOf(codError),
						numEvento, msgError);
			}
			else
			{
				cat.debug("Recuperando cuentas por criterio");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(5);
				while (rs.next())
				{
					CuentaDTO cuentaDTO = new CuentaDTO();
					cuentaDTO.setTipoEntidad(rs.getString(1));
					cuentaDTO.setCodigoCuenta(String.valueOf(rs.getInt(2)));
					cuentaDTO.setCodigoTipIdentif(rs.getString(3));
					cuentaDTO.setDescripcionTipIdentif(rs.getString(4));
					cuentaDTO.setNumeroIdentificacion(rs.getString(5));
					cuentaDTO.setDescripcionCuenta(rs.getString(6));
					cuentaDTO.setTipoCuenta(rs.getString(7));
					lista.add(cuentaDTO);
				}
				resultado = (CuentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CuentaDTO.class);
			}
			if (cat.isDebugEnabled())
			{
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al recuperar cuentas", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListadoCuenta()");
		return resultado;
	}// fin getListadoCuenta

	public CuentaDTO[] getCuentas(BusquedaCuentaDTO dto) throws CustomerDomainException {
		cat.debug("Inicio");
		CuentaDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		ResultSet rs = null;
		String nombrePackage = "Ve_Servs_ActivacionesWeb_Pg";
		String nombrePL = "VE_getCuenta_PR";
		final int cantidadParametros = 11;
		cat.debug(dto.toString());
		try {
			String call = getSQLDatosCuenta(nombrePackage, nombrePL, cantidadParametros);
			cat.debug("SQL [" + call + "]");
			cstmt = conn.prepareCall(call);

			int i = 1;

			cstmt.setString(i++, dto.getCodCuenta());
			cat.debug("dto.getCodCuenta(): " + dto.getCodCuenta());
			cstmt.setString(i++, dto.getCodTipoIdentificacion());
			cat.debug("dto.getCodTipoIdentificacion(): " + dto.getCodTipoIdentificacion());
			cstmt.setString(i++, dto.getNumIdentificacion());
			cat.debug("dto.getNumIdentificacion(): " + dto.getNumIdentificacion());
			cstmt.setString(i++, dto.getCodTipoCuenta());
			cat.debug("dto.getCodTipoCuenta(): " + dto.getCodTipoCuenta());
			cstmt.setString(i++, dto.getTelefonoContacto());
			cat.debug("dto.getTelefonoContacto(): " + dto.getTelefonoContacto());
			cstmt.setString(i++, dto.getNombreCuenta());
			cat.debug("dto.getNombreCuenta(): " + dto.getNombreCuenta());
			cstmt.setString(i++, dto.getNombreResponsable());
			cat.debug("dto.getNombreResponsable(): " + dto.getNombreResponsable());

			cstmt.registerOutParameter(i++, OracleTypes.CURSOR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			cat.debug("cstmt.execute(): Antes");
			cstmt.execute();
			cat.debug("cstmt.execute(): Despues");

			codError = cstmt.getInt(i - 3);
			msgError = cstmt.getString(i - 2);
			numEvento = cstmt.getInt(i - 1);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar cuentas");
				throw new CustomerDomainException("Ocurrió un error al recuperar  cuentas", String.valueOf(codError),
						numEvento, msgError);
			}
			else {
				cat.debug("cstmt.execute(): Recuperando data");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(i - 4);
				while (rs.next()) {
					i = 1;
					CuentaDTO cuentaDTO = new CuentaDTO();
					cuentaDTO.setCodigoCuenta(rs.getString(i++));
					cuentaDTO.setCodigoTipIdentif(rs.getString(i++));
					cuentaDTO.setNumeroIdentificacion(rs.getString(i++));
					cuentaDTO.setTipoCuenta(rs.getString(i++));
					cuentaDTO.setTelefonoContacto(rs.getString(i++));
					cuentaDTO.setNombreCuenta(rs.getString(i++));
					cuentaDTO.setResponsable(rs.getString(i++));
					lista.add(cuentaDTO);
				}
				resultado = (CuentaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CuentaDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug("Finalizo ejecución");
				cat.debug("Recuperando salidas");
			}
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al recuperar cuentas", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
				if (rs != null)
					rs.close();
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListadoCuenta()");
		return resultado;
	}

	/**
	 * Inserta cuenta
	 * 
	 * @param cuenta
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insCuenta(CuentaDTO cuenta) throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insCuenta");

			String call = getSQLDatosCuenta("VE_alta_cuenta_PG", "VE_insCuenta_PR", 25);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cuenta.getCodigoCuenta());
			cat.debug("cuenta.getCodigoCuenta(): " + cuenta.getCodigoCuenta());
			cstmt.setString(2, cuenta.getDescripcionCuenta());
			cat.debug("cuenta.getDescripcionCuenta(): " + cuenta.getDescripcionCuenta());
			cstmt.setString(3, cuenta.getTipoCuenta());
			cat.debug("cuenta.getTipoCuenta()): " + cuenta.getTipoCuenta());
			cstmt.setString(4, cuenta.getResponsable());
			cat.debug("cuenta.getResponsable(): " + cuenta.getResponsable());
			cstmt.setString(5, cuenta.getCodigoTipIdentif());
			cat.debug("cuenta.getCodigoTipIdentif(): " + cuenta.getCodigoTipIdentif());
			cstmt.setString(6, cuenta.getNumeroIdentificacion());
			cat.debug("cuenta.getNumeroIdentificacion(): " + cuenta.getNumeroIdentificacion());
			cstmt.setString(7, cuenta.getCodigoDireccion());
			cat.debug("cuenta.getCodigoDireccion(): " + cuenta.getCodigoDireccion());
			cstmt.setString(8, cuenta.getIndicadorEstado());
			cat.debug("cuenta.getIndicadorEstado(): " + cuenta.getIndicadorEstado());
			cstmt.setString(9, cuenta.getTelefonoContacto());
			cat.debug("cuenta.getTelefonoContacto(): " + cuenta.getTelefonoContacto());
			cstmt.setString(10, cuenta.getIndicadorSector());
			cat.debug("cuenta.getIndicadorSector(): " + cuenta.getIndicadorSector());
			cstmt.setString(11, cuenta.getClaseCuenta());
			cat.debug("cuenta.getClaseCuenta(): " + cuenta.getClaseCuenta());
			cstmt.setString(12, cuenta.getCodigoCategTributaria());
			cat.debug("cuenta.getCodigoCategtTributaria(): " + cuenta.getCodigoCategTributaria());
			cstmt.setString(13, String.valueOf(cuenta.getCodigoCategoria()));
			cat.debug("cuenta.getCodigoCategoria(): " + cuenta.getCodigoCategoria());
			cstmt.setString(14, cuenta.getCodigoSector());
			cat.debug("cuenta.getCodigoSector(): " + cuenta.getCodigoSector());
			cstmt.setString(15, cuenta.getCodigoSubCategoria());
			cat.debug("cuenta.getCodigoSubCategoria(): " + cuenta.getCodigoSubCategoria());
			cstmt.setString(16, cuenta.getIndicadorMultUso());
			cat.debug("cuenta.getIndicadorMultUso(): " + cuenta.getIndicadorMultUso());
			cstmt.setString(17, cuenta.getClientePotencial());
			cat.debug("cuenta.getClientePotencial(): " + cuenta.getClientePotencial());
			cstmt.setString(18, cuenta.getRazonSocial());
			cat.debug("cuenta.getRazonSocial(): " + cuenta.getRazonSocial());
			cstmt.setString(19, cuenta.getFechaInVPac());
			cat.debug("cuenta.getFechaInVPac(): " + cuenta.getFechaInVPac());
			cstmt.setString(20, cuenta.getTipoComisionista());
			cat.debug("cuenta.getTipoComisionista(): " + cuenta.getTipoComisionista());
			cstmt.setString(21, cuenta.getUsuarioAsesor());
			cat.debug("cuenta.getUsuarioAsesor(): " + cuenta.getUsuarioAsesor());
			cstmt.setString(22, cuenta.getFechaNacimiento());
			cat.debug("cuenta.getFechaNacimiento(): " + cuenta.getFechaNacimiento());

			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insCuenta:execute");
			cstmt.execute();
			cat.debug("Fin:insCuenta:execute");

			codError = cstmt.getInt(23);
			cat.debug("codError :" + codError);
			msgError = cstmt.getString(24);
			cat.debug("msgError :" + msgError);
			numEvento = cstmt.getInt(25);
			cat.debug("numEvento :" + numEvento);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar cuenta");
				throw new CustomerDomainException("Ocurrió un error al insertar cuenta", String.valueOf(codError),
						numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar cuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insCuenta()");
	}// fin insCuenta

	/**
	 * Inserta SubCuenta
	 * 
	 * @param SubCuenta
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void insSubCuenta(CuentaDTO cuenta) throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:insSubCuenta");

			String call = getSQLDatosCuenta("VE_alta_cuenta_PG", "VE_insSubCuenta_PR", 7);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cuenta.getCodigoCuenta());
			cat.debug("cuenta.getCodigoCuenta(): " + cuenta.getCodigoCuenta());
			cstmt.setString(2, cuenta.getCodigoSubCuenta());
			cat.debug("cuenta.getCodigoSubCuenta(): " + cuenta.getCodigoSubCuenta());
			cstmt.setString(3, cuenta.getDescripcionSubCuenta());
			cat.debug("cuenta.getDescripcionSubCuenta(): " + cuenta.getDescripcionSubCuenta());
			cstmt.setString(4, cuenta.getCodigoDireccion());
			cat.debug("cuenta.getCodigoDireccion()): " + cuenta.getCodigoDireccion());

			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:insSubCuenta:execute");
			cstmt.execute();
			cat.debug("Fin:insSubCuenta:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al insertar subcuenta");
				throw new CustomerDomainException("Ocurrió un error al insertar subcuenta", String.valueOf(codError),
						numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar subcuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrió un error al insertar subcuenta", String.valueOf(codError),
					numEvento, msgError);

		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:insSubCuenta()");
	}// fin insSubCuenta

	/**
	 * Retorna todos los datos de la cuenta
	 * 
	 * @param cuenta
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CuentaDTO getCuentaAll(CuentaDTO cuenta) throws CustomerDomainException
	{
		CuentaDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:getCuentaAll");

			String call = getSQLDatosCuenta("VE_alta_cuenta_PG", "VE_getCuenta_PR", 26);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cuenta.getCodigoCuenta());

			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);

			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getCuentaAll:execute");
			cstmt.execute();
			cat.debug("Fin:getCuentaAll:execute");

			codError = cstmt.getInt(24);
			msgError = cstmt.getString(25);
			numEvento = cstmt.getInt(26);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al consultar la cuenta");
				throw new CustomerDomainException("Ocurrió un error al consultar la cuenta", String.valueOf(codError),
						numEvento, msgError);
			}
			else
			{
				resultado = new CuentaDTO();
				resultado.setCodigoCuenta(cuenta.getCodigoCuenta());

				resultado.setDescripcionCuenta(cstmt.getString(2));
				resultado.setTipoCuenta(cstmt.getString(3));
				resultado.setResponsable(cstmt.getString(4));
				resultado.setCodigoTipIdentif(cstmt.getString(5));
				resultado.setNumeroIdentificacion(cstmt.getString(6));
				resultado.setDireccionCuenta(cstmt.getString(7));
				resultado.setIndicadorEstado(cstmt.getString(9));
				resultado.setTelefonoContacto(cstmt.getString(10));
				resultado.setIndicadorSector(cstmt.getString(11));
				resultado.setClaseCuenta(cstmt.getString(12));
				resultado.setCodigoCategTributaria(cstmt.getString(13));
				resultado.setCodigoCategoria(cstmt.getString(14));
				resultado.setCodigoSector(cstmt.getString(15));
				resultado.setCodigoSubCategoria(cstmt.getString(16));
				resultado.setIndicadorMultUso(cstmt.getString(17));
				resultado.setClientePotencial(cstmt.getString(18));
				resultado.setRazonSocial(cstmt.getString(19));
				resultado.setFechaInVPac(cstmt.getString(20));
				resultado.setTipoComisionista(cstmt.getString(21));
				resultado.setUsuarioAsesor(cstmt.getString(22));
				resultado.setFechaNacimiento(cstmt.getString(23));
				cat.debug("cuenta[" + cuenta.getCodigoCuenta() + "]");
				cat.debug("descripcion[" + resultado.getDescripcionCuenta() + "]");
				cat.debug("categoria[" + resultado.getCodigoCategoria() + "]");
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar cuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCuentaAll()");
		return resultado;
	}// fin getCuentaAll

	/**
	 * Retorna todos los datos de la cuenta
	 * 
	 * @param cuenta
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CuentaDTO getCuentaNumIdent(CuentaDTO cuenta) throws CustomerDomainException
	{
		CuentaDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:getCuentaNumIdent");

			String call = getSQLDatosCuenta("VE_alta_cuenta_PG", "VE_getCuentaIdentif_PR", 26);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cuenta.getCodigoTipIdentif().trim());
			cstmt.setString(2, cuenta.getNumeroIdentificacion());

			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(22, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getCuentaNumIdent:execute");
			cstmt.execute();
			cat.debug("Fin:getCuentaNumIdent:execute");

			codError = cstmt.getInt(24);
			msgError = cstmt.getString(25);
			numEvento = cstmt.getInt(26);

			if (codError == 0)
			{
				resultado = new CuentaDTO();
				resultado.setCodigoCuenta(cstmt.getString(3));
				resultado.setDescripcionCuenta(cstmt.getString(4));
				resultado.setTipoCuenta(cstmt.getString(5));
				resultado.setResponsable(cstmt.getString(6));
				resultado.setCodigoDireccion(cstmt.getString(7));
				resultado.setIndicadorEstado(cstmt.getString(9));
				resultado.setTelefonoContacto(cstmt.getString(10));
				resultado.setIndicadorSector(cstmt.getString(11));
				resultado.setClaseCuenta(cstmt.getString(12));
				resultado.setCodigoCategTributaria(cstmt.getString(13));
				resultado.setCodigoCategoria(cstmt.getString(14));
				resultado.setCodigoSector(cstmt.getString(15));
				resultado.setCodigoSubCategoria(cstmt.getString(16));
				resultado.setIndicadorMultUso(cstmt.getString(17));
				resultado.setClientePotencial(cstmt.getString(18));
				resultado.setRazonSocial(cstmt.getString(19));
				resultado.setFechaInVPac(cstmt.getString(20));
				resultado.setTipoComisionista(cstmt.getString(21));
				resultado.setUsuarioAsesor(cstmt.getString(22));
				resultado.setFechaNacimiento(cstmt.getString(23));
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al consultar el numero de cuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCuentaNumIdent()");
		return resultado;
	}// fin getCuentaNumIdent

	/**
	 * Obtiene la categoria de la cuenta
	 * 
	 * @param cuenta
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CuentaDTO getCategoriaCuenta(CuentaDTO cuenta) throws CustomerDomainException
	{
		CuentaDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:getCategoriaCuenta");

			String call = getSQLDatosCuenta("VE_intermediario_PG", "VE_ObtieneCategoriaCta_PR", 11);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cuenta.getNumeroIdentificacion());
			cstmt.setString(2, cuenta.getCodigoCategTributaria());
			cstmt.setString(3, cuenta.getTipoModulo());

			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);

			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getCategoriaCuenta:execute");
			cstmt.execute();
			cat.debug("Fin:getCategoriaCuenta:execute");

			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);

			if (codError == 0)
			{
				resultado = new CuentaDTO();
				resultado.setCodigoCuenta(cuenta.getCodigoCuenta());
				resultado.setCodigoCategoria(cstmt.getString(4));
				resultado.setCodigoSubCategoria(cstmt.getString(5));
				resultado.setIndicadorMultUso(cstmt.getString(6));
				resultado.setClientePotencial(cstmt.getString(7));
				resultado.setRazonSocial(cstmt.getString(8));
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al obtener la categoria de la cuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCategoriaCuenta()");
		return resultado;
	}// fin getCuentaAll

	/**
	 * Actualiza Cuenta
	 * 
	 * @param cuenta
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void actualizaCuenta(CuentaDTO cuenta) throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:actualizaCuenta");
			String call = getSQLDatosCuenta("VE_alta_cuenta_PG", "VE_updCategCuenta_PR", 9);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, cuenta.getCodigoCuenta());
			cat.debug("cuenta.getCodigoCuenta(): " + cuenta.getCodigoCuenta());
			cstmt.setString(2, cuenta.getCodigoCategoria());
			cat.debug("cuenta.getCodigoCategoria(): " + cuenta.getCodigoCategoria());
			cstmt.setString(3, cuenta.getCodigoSubCategoria());
			cat.debug("cuenta.getCodigoSubCategoria(): " + cuenta.getCodigoSubCategoria());
			cstmt.setString(4, cuenta.getIndicadorMultUso());
			cat.debug("cuenta.getIndicadorMultUso()): " + cuenta.getIndicadorMultUso());
			cstmt.setString(5, cuenta.getClientePotencial());
			cat.debug("cuenta.getClientePotencial()): " + cuenta.getClientePotencial());
			cstmt.setString(6, cuenta.getRazonSocial());
			cat.debug("cuenta.getRazonSocial()): " + cuenta.getRazonSocial());
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cat.debug("Inicio:actualizaCuenta:execute");
			cstmt.execute();
			cat.debug("Fin:actualizaCuenta:execute");
			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			if (codError != 0)
			{
				cat.error("Ocurrió un error al actualizar la cuenta");
				throw new CustomerDomainException("Ocurrió un error al actualizar la cuenta", String.valueOf(codError),
						numEvento, msgError);
			}
		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al actualizar la cuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:actualizaCuenta()");
	}// fin actualizaCuenta

	/**
	 * Inserta SubCuenta
	 * 
	 * @param SubCuenta
	 * @return N/A
	 * @throws CustomerDomainException
	 */
	public void eliminaCuentasPotenciales(CuentaDTO cuenta) throws CustomerDomainException
	{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try
		{
			cat.debug("Inicio:eliminaCuentasPotenciales");

			String call = getSQLDatosCuenta("VE_alta_cuenta_PG", "VE_delCategCtasPotenciales_PR", 4);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, cuenta.getNumeroIdentificacion());
			cat.debug("cuenta.getNumeroIdentificacion()): " + cuenta.getNumeroIdentificacion());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:eliminaCuentasPotenciales:execute");
			cstmt.execute();
			cat.debug("Fin:eliminaCuentasPotenciales:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

		}
		catch (Exception e)
		{
			cat.error("Ocurrió un error al insertar subcuenta", e);
			if (cat.isDebugEnabled())
			{
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally
		{
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try
			{
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed())
				{
					conn.close();
				}
			}
			catch (SQLException e)
			{
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:eliminaCuentasPotenciales()");
	}// fin eliminaCuentasPotenciales

}// fin CuentaDAO
