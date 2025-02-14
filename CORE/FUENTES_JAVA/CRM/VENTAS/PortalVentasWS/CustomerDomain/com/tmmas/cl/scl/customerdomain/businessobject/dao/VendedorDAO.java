/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA. Av. Del Condor 720, Huechuraba,
 * Santiago de Chile, Chile Todos los derechos reservados. Este software es informaci&oacute;n propietaria y
 * confidencial de TM-mAs SA. Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia con los
 * t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs. Fecha ------------------- Autor
 * ------------------------- Cambios ---------- 23/01/2007 Héctor Hermosilla Versión Inicial
 */

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
import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DatosValidacionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionVentasDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.VendedorOutDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class VendedorDAO extends ConnectionDAO {
	private static Category cat = Category.getInstance(VendedorDAO.class);

	Global global = Global.getInstance();

	private Connection getConection() throws CustomerDomainException {
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		}
		catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new CustomerDomainException("No se pudo obtener una conexión", e1);
		}

		return conn;
	}

	private String getSQLDatosVendedor(String packageName, String procedureName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();

	}

	public VendedorDTO getVendedor(VendedorDTO vendedor) throws CustomerDomainException {
		cat.debug("getVendedorExterno:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosVendedor("VE_servicios_venta_PG", "VE_datosvendedor_PR", 16);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, Integer.parseInt(vendedor.getCodigoVendedor()));
			cstmt.setLong(2, new Long(vendedor.getCodigoVendedorDealer()).longValue());
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(14);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(15);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(16);
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al consultar el Vendedor");
				throw new CustomerDomainException("Ocurrió un error al consultar el vendedor",
						String.valueOf(codError), numEvento, msgError);

			}
			else {
				cat.debug("Llenado Vendedor");
				vendedor.setNombreVendedor(cstmt.getString(3));
				vendedor.setNombreDealer(cstmt.getString(4));
				vendedor.setCodigoCliente(String.valueOf(cstmt.getInt(5)));
				vendedor.setCodigoVendedorRaiz(cstmt.getLong(6));
				DireccionNegocioDTO direccion = new DireccionNegocioDTO();
				direccion.setRegion(cstmt.getString(7));
				direccion.setProvincia(cstmt.getString(8));
				direccion.setCiudad(cstmt.getString(9));
				vendedor.setDireccion(direccion);
				vendedor.setCodigoOficina(cstmt.getString(10));
				vendedor.setCodTipComisionista(cstmt.getString(11));
				vendedor.setDesTipComisionista(cstmt.getString(12));
				vendedor.setIndicadorTipoVenta(cstmt.getInt(13));
				cat.debug("Fin Llenado Vendedor");
			}
			if (vendedor.getCodigoVendedor() == null) {
				msgError = "No se pudo rescatar la Información";
				cat.error("Ocurrió un error al consultar el Vendedor");
				throw new CustomerDomainException("Ocurrió un error al consultar el vendedor",
						String.valueOf(codError), numEvento, msgError);
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
			// Recuperacion de valores de salida

		}
		catch (Exception e) {
			cat.error("Ocurrió un error al consultar el vendedor", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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

		cat.debug("getVendedorExterno():end");

		return vendedor;
	}

	public DatosValidacionDTO getVendedorNumero(ParametrosValidacionVentasDTO entradaVendedorNumero)
			throws CustomerDomainException {
		DatosValidacionDTO resultado = new DatosValidacionDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:getVendedorNumero()");

			String call = getSQLDatosVendedor("VE_validacion_linea_PG", "VE_vendedor_numero_PR", 7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, Long.parseLong(entradaVendedorNumero.getNumeroCelular()));
			cstmt.setLong(2, Long.parseLong(entradaVendedorNumero.getCodigoCliente()));
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getVendedorNumero:execute");
			cstmt.execute();
			cat.debug("Fin:getVendedorNumero:execute");

			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");

			resultado.setVendedorNumeroValido(cstmt.getInt(2));

		}
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener vendedor reserva numero", e);
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

		cat.debug("Fin:getVendedorNumero");

		return resultado;

	}

	public ResultadoValidacionVentaDTO getExisteVendedorEnBodegaSimcard(
			ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:getExisteVendedorEnBodegaSimcard");

			String call = getSQLDatosVendedor("VE_validacion_linea_PG", "VE_vendedorbodega_PR", 6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entradaValidacionVentas.getCodigoVendedor());
			cstmt.setString(2, entradaValidacionVentas.getCodigoBodega());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getExisteVendedorEnBodegaSimcard:execute");
			cstmt.execute();
			cat.debug("Fin:getExisteVendedorEnBodegaSimcard:execute");

			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");

			if (cstmt.getInt(3) == 1)
				cat.debug("VENDEDOR <<< EXISTE >>> EN BODEGA");
			else
				cat.debug("VENDEDOR <<< NO EXISTE >>> EN BODEGA");

			resultado.setResultadoBase(cstmt.getInt(3));

		}
		catch (Exception e) {
			cat.error("Ocurrió un error al buscar vendedor en bodega (simcard)", e);
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

		cat.debug("Fin:getExisteVendedorEnBodegaSimcard");

		return resultado;
	}// fin getExisteVendedorEnBodegaSimcard

	public ResultadoValidacionVentaDTO getExisteVendedorEnBodegaTerminal(
			ParametrosValidacionVentasDTO entradaValidacionVentas) throws CustomerDomainException {
		ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:getExisteVendedorEnBodegaTerminal");

			String call = getSQLDatosVendedor("VE_validacion_linea_PG", "VE_vendedorbodega_PR", 6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entradaValidacionVentas.getCodigoVendedor());
			cstmt.setString(2, entradaValidacionVentas.getCodigoBodega());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getExisteVendedorEnBodegaTerminal:execute");
			cstmt.execute();
			cat.debug("Fin:getExisteVendedorEnBodegaTerminal:execute");

			msgError = cstmt.getString(5);
			cat.debug("msgError[" + msgError + "]");

			if (cstmt.getInt(3) == 1)
				cat.debug("VENDEDOR <<< EXISTE >>> EN BODEGA");
			else
				cat.debug("VENDEDOR <<< NO EXISTE >>> EN BODEGA");

			resultado.setResultadoBase(cstmt.getInt(3));

		}
		catch (Exception e) {
			cat.error("Ocurrió un error al buscar vendedor en bodega (terminal)", e);
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

		cat.debug("Fin:getExisteVendedorEnBodegaTerminal");

		return resultado;
	}// fin getExisteVendedorEnBodegaTerminal

	public void setBloqueaDesbloqueaVendedor(VendedorDTO vendedor) throws CustomerDomainException {
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:setBloqueaDesbloqueaVendedor");

			String call = getSQLDatosVendedor("VE_intermediario_PG", "VE_bloqdesbloq_vendedor_PR", 5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, vendedor.getCodigoVendedor());
			cstmt.setString(2, vendedor.getCodigoAccionBloqueo());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:setBloqueaDesbloqueaVendedor:execute");
			cstmt.execute();
			cat.debug("Fin:setBloqueaDesbloqueaVendedor:execute");

			msgError = cstmt.getString(4);

			cat.debug("msgError[" + msgError + "]" + " Evento: " + cstmt.getInt(5));

			cat.debug(" Evento: " + cstmt.getInt(5));

			if (cstmt.getInt(3) == 0)
				cat.debug("OPERACION SOBRE EL VENDEDOR <" + vendedor.getCodigoVendedor() + "> OK ["
						+ vendedor.getCodigoAccionBloqueo() + " ]");
			else {
				cat.debug("OPERACION SOBRE EL VENDEDOR <" + vendedor.getCodigoVendedor() + "> NO OK ["
						+ vendedor.getCodigoAccionBloqueo() + " ]");
				throw new CustomerDomainException("No es posible Bloquear / Desbloquear vendedor", String
						.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al bloquear/desbloquear el vendedor", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException) {
				throw (CustomerDomainException) e;
			}
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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

		cat.debug("Fin:setBloqueaDesbloqueaVendedor");

	}// fin getExisteVendedorEnBodegaTerminal

	public ResultadoValidacionVentaDTO validaCodigoVendedor(VendedorDTO vendedordto) throws CustomerDomainException {
		boolean resultado = false;
		int codError = 0;
		String msgError = null;
		ResultadoValidacionVentaDTO resultadovalidacion = new ResultadoValidacionVentaDTO();
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			cat.debug("Inicio:validaCodigoVendedor");
			String call = getSQLDatosVendedor("VE_servicios_venta_PG", "VE_valida_codigo_vendedor_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, Integer.parseInt(vendedordto.getCodigoVendedor()));
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.execute();
			int res = cstmt.getInt(2);
			resultado = res == 1 ? true : false;
			String mensaje = res == 1 ? "Validacion exitosa" : "No se puede ejecutar, usuario no es vendedor";
			resultadovalidacion.setResultado(resultado);
			resultadovalidacion.setMensajeValidacion(mensaje);

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			cat.debug("msgError[" + msgError + "]");

			if (codError != 0 || !resultado) {
				throw new CustomerDomainException(String.valueOf(codError), numEvento,
						"Vendedor no existe o se encuentra bloqueado");
			}

		}
		catch (Exception e) {
			cat.error("Ocurrió un error en validaCodigoVendedor", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException)
				throw (CustomerDomainException) e;
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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
		cat.debug("Fin:validaCodigoVendedor");
		return resultadovalidacion;
	}// fin validaCodigoVendedor

	// Verifica si un vendedor es externo
	public VendedorDTO verificaVendedorEsExterno(VendedorDTO vendedor) throws CustomerDomainException {
		cat.debug("verificaVendedorEsExterno:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosVendedor("VE_servicios_venta_PG", "VE_es_vendedor_externo_PR", 5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setInt(1, Integer.parseInt(vendedor.getCodigoVendedor()));
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes" + vendedor.getCodigoVendedor());
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			int res = cstmt.getInt(2);
			boolean resultado = res == 1 ? true : false;
			vendedor.setVendedorInterno(!resultado);
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al consultar el vendedor", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrió un error al consultar el vendedor", e);
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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
		cat.debug("verificaVendedorEsExterno():end");
		return vendedor;
	}

	/**
	 * Obtiene rango de descuentos asignados al vendedor
	 * 
	 * @param vendedor
	 * @return vendedor
	 * @throws CustomerDomainException
	 */
	public VendedorDTO getRangoDescuento(VendedorDTO vendedor) throws CustomerDomainException {
		cat.debug("getRangoDescuento():start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			
			String call = getSQLDatosVendedor("ve_servicios_solicitud_pg", "VE_con_rango_descto_usuario_PR", 9);
			cat.debug("sql[" + call + "]");
			cat.debug("UsuarioVendedor="+vendedor.getNombreVendedor());
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, vendedor.getNombreVendedor());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cat.debug("Execute Antes");
			cstmt.execute();
			cat.debug("Execute Despues");
			codError = cstmt.getInt(7);
			cat.debug("codError[" + codError + "]");
			msgError = cstmt.getString(8);
			cat.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(9);
			cat.debug("numEvento[" + numEvento + "]");
			if (codError == 0) {
				vendedor.setPuntoDesctoInferior(cstmt.getFloat(2));
				vendedor.setPuntoDesctoSuperior(cstmt.getFloat(3));
				vendedor.setPorcentajeDesctoInferior(cstmt.getFloat(4));
				vendedor.setPorcentajeDesctoSuperior(cstmt.getFloat(5));
				vendedor.setAplicaDescuento(cstmt.getInt(6) == 1 ? true : false);
			}
			else
				vendedor.setAplicaDescuento(false);

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		}
		catch (Exception e) {
			cat.error("Ocurrió un error al consultar el rango de descuento del vendedor", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrió un error al consultar el rango de descuento del vendedor", e);
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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

		cat.debug("getRangoDescuento():end");

		return vendedor;
	}

	/**
	 * Obtiene listado de tipos de comisionistas
	 * 
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws CustomerDomainException
	 */
	public VendedorDTO[] getListTiposComisionistas() throws CustomerDomainException {
		cat.debug("Inicio:getListTiposComisionistas()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosVendedor("VE_alta_cliente_PG", "VE_getListTipComisionistas_PR", 4);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.registerOutParameter(1, OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListTiposComisionistas:execute");
			cstmt.execute();
			cat.debug("Fin:getListTiposComisionistas:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar tipos de comisionistas");
				throw new CustomerDomainException("Ocurrió un error al recuperar tipos de comisionistas", String
						.valueOf(codError), numEvento, msgError);
			}
			else {
				cat.debug("Recuperando categorias");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					VendedorDTO vendedorDTO = new VendedorDTO();
					vendedorDTO.setCodTipComisionista(rs.getString(1));
					vendedorDTO.setDesTipComisionista(rs.getString(2));
					vendedorDTO.setIndVtaExterna(rs.getInt(3));
					lista.add(vendedorDTO);
				}
				resultado = (VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), VendedorDTO.class);

			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al recuperar tipos de comisionistas", e);
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
		cat.debug("Fin:getListTiposComisionistas()");
		return resultado;
	}// fin getListTiposComisionistas

	/**
	 * Verifica si el home del vendedor corresponde al home del celular
	 * 
	 * @param vendedor
	 * @return VendedorDTO
	 * @throws CustomerDomainException
	 */
	public VendedorDTO validaHomeVendCel(VendedorDTO vendedor) throws CustomerDomainException {
		cat.debug("validaHomeVendCel:start");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosVendedor("VE_servicios_venta_PG", "VE_validaHomeVendCel_PR", 6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, vendedor.getCodigoVendedor());
			cstmt.setString(2, vendedor.getNumeroCelular());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("validaHomeVendCel:Execute Antes");
			cstmt.execute();
			cat.debug("validaHomeVendCel:Execute Despues");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			int res = cstmt.getInt(3);
			boolean resultado = res == 0 ? false : true;
			vendedor.setIndicadorHomeVendCelular(resultado);
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al verificar home del vendedor y celular", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new CustomerDomainException("Ocurrió un error al verificar home del vendedor y celular", e);
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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
		cat.debug("validaHomeVendCel():end");
		return vendedor;
	}// fin validaHomeVendCel

	/**
	 * Obtiene Datos del Vendedor
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public VendedorOutDTO lstVendedor(VendedorDTO entrada) throws CustomerDomainException {
		cat.debug("getUsuarioPospago:inicio");
		VendedorOutDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			String call = getSQLDatosVendedor("Ve_Servs_ActivacionesWeb_Pg", "VE_getVendedor_PR", 24);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getCodigoVendedor());
			cstmt.setString(2, entrada.getCodCanal());

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

			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(24, java.sql.Types.NUMERIC);

			cat.debug("lstVendedorDAO:Execute Antes");
			cstmt.execute();
			cat.debug("lstVendedorDAO:Execute Despues");

			codError = cstmt.getInt(22);
			msgError = cstmt.getString(23);
			numEvento = cstmt.getInt(24);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				throw new CustomerDomainException("Ocurrió un error al consultar el vendedor",
						String.valueOf(codError), numEvento, msgError);
			}
			else {
				resultado = new VendedorOutDTO();
				resultado.setNom_vendedor(cstmt.getString(3));
				resultado.setNom_provincia(cstmt.getString(12));
				resultado.setNom_ciudad(cstmt.getString(14));
				resultado.setDireccion(cstmt.getString(15) + " " + cstmt.getString(16));
				resultado.setObservacion(cstmt.getString(17));
				resultado.setNom_oficina(cstmt.getString(8));
				resultado.setTip_comisionista(cstmt.getString(5));
				if (entrada.getCodCanal().trim().equals("I")) {
					resultado.setNom_vendealer(cstmt.getString(18));
					resultado.setCod_vendealer(cstmt.getString(19));
				}
				resultado.setCod_vendedor(cstmt.getString(20));
				resultado.setTipo_Calle(cstmt.getString(21));

			}
			if (cat.isDebugEnabled())
				cat.debug(" Finalizo ejecución");
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener datos del vendedor", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException) {
				throw (CustomerDomainException) e;
			}
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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
		cat.debug("getUsuarioPospago():end");
		return resultado;
	}// fin getUsuarioPospago

	/**
	 * Obtiene listado de vendedores
	 * 
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws CustomerDomainException
	 */
	public VendedorDTO[] getListadoVendedores(VendedorDTO vendedorDTO) throws CustomerDomainException {
		cat.debug("Inicio:getListadoVendedores()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosVendedor("Ve_Servicios_Venta_Pg", "VE_getListVendedores_PR", 6);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, vendedorDTO.getCodigoOficina());
			cstmt.setString(2, vendedorDTO.getCodTipComisionista());
			cstmt.registerOutParameter(3, OracleTypes.CURSOR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListadoVendedores:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoVendedores:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar listado de vendedores");
				throw new CustomerDomainException("Ocurrió un error al recuperar listado de vendedores", String
						.valueOf(codError), numEvento, msgError);
			}
			else {
				cat.debug("Recuperando vendedores");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(3);
				while (rs.next()) {
					VendedorDTO vendedorDTO2 = new VendedorDTO();
					vendedorDTO2.setCodigoVendedor(rs.getString(1));
					vendedorDTO2.setNombreVendedor(rs.getString(2));
					lista.add(vendedorDTO2);
				}
				resultado = (VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), VendedorDTO.class);

			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de vendedores", e);
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
		cat.debug("Fin:getListadoVendedores()");
		return resultado;
	}// fin getListadoVendedores

	/**
	 * Obtiene listado de vendedores
	 * 
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws CustomerDomainException
	 */
	public VendedorDTO[] getListadoVendedoresDealer(VendedorDTO vendedorDTO) throws CustomerDomainException {
		cat.debug("Inicio:getListadoVendedores()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosVendedor("Ve_Servicios_Venta_Pg", "VE_getListVendDealer_PR", 5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, vendedorDTO.getCodigoVendedor());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListadoVendedores:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoVendedores:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar listado de vendedores dealers");
				throw new CustomerDomainException("Ocurrió un error al recuperar listado de vendedores dealers", String
						.valueOf(codError), numEvento, msgError);
			}
			else {
				cat.debug("Recuperando vendedores");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					VendedorDTO vendedorDTO2 = new VendedorDTO();
					vendedorDTO2.setCodigoVendedorDealer(Long.parseLong(rs.getString(1)));
					vendedorDTO2.setNombreDealer(rs.getString(2));
					lista.add(vendedorDTO2);
				}
				resultado = (VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), VendedorDTO.class);

			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de vendedores", e);
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
		cat.debug("Fin:getListadoVendedores()");
		return resultado;
	}// fin getListadoVendedores

	/**
	 * Obtiene listado de vendedores
	 * 
	 * @param N/A
	 * @return VendedorDTO[]
	 * @throws CustomerDomainException
	 */
	public VendedorDTO[] getListadoVendedoresXOficina(VendedorDTO vendedorDTO) throws CustomerDomainException {
		cat.debug("Inicio:getListadoVendedoresXOficina()");
		VendedorDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosVendedor("Ve_Servicios_Venta_Pg", "VE_getListVendedores_PR", 5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, vendedorDTO.getCodigoOficina());
			cstmt.registerOutParameter(2, OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getListadoVendedoresXOficina:execute");
			cstmt.execute();
			cat.debug("Fin:getListadoVendedoresXOficina:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar listado de vendedores");
				throw new CustomerDomainException("Ocurrió un error al recuperar listado de vendedores", String
						.valueOf(codError), numEvento, msgError);
			}
			else {
				cat.debug("Recuperando vendedores");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					VendedorDTO vendedorDTO2 = new VendedorDTO();
					vendedorDTO2.setCodigoVendedor(rs.getString(1));
					vendedorDTO2.setNombreVendedor(rs.getString(2));
					lista.add(vendedorDTO2);
				}
				rs.close();
				resultado = (VendedorDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), VendedorDTO.class);

			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al recuperar listado de vendedores", e);
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
		cat.debug("Fin:getListadoVendedoresXOficina()");
		return resultado;
	}// fin getListadoVendedoresXOficina

	/**
	 * Obtiene Datos del Vendedor
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public VendedorDTO buscarVendedor(VendedorDTO entrada) throws CustomerDomainException {
		cat.debug("buscarVendedor:inicio");
		VendedorDTO resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		CallableStatement cstmt = null;
		try {
			String call = getSQLDatosVendedor("VE_PARAMETROS_COMERCIALES_PG", "VE_Busca_Vendedor_PR", 9);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cat.debug("codigoVendedor=" + entrada.getCodigoVendedor());
			cat.debug("entrada.getCodCanal()=" + entrada.getCodCanal());
			cstmt.setString(1, entrada.getCodigoVendedor());
			cstmt.setString(2, entrada.getCodCanal());

			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);

			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);

			cat.debug("buscarVendedor:Execute Antes");
			cstmt.execute();
			cat.debug("buscarVendedor:Execute Despues");

			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			cat.debug("codError[" + codError + "]");
			cat.debug("msgError[" + msgError + "]");
			cat.debug("numEvento[" + numEvento + "]");

			if (codError != 0) {
				throw new CustomerDomainException("Ocurrió un error al consultar el vendedor",
						String.valueOf(codError), numEvento, msgError);
			}
			else {
				resultado = new VendedorDTO();
				resultado.setCodigoOficina(cstmt.getString(3));
				resultado.setCodTipComisionista(cstmt.getString(4));
				resultado.setCodigoVendedor(cstmt.getString(5));
				resultado.setCodigoVendedorDealer(cstmt.getLong(6));
				cat.debug("codigoOficina=" + resultado.getCodigoOficina());
				cat.debug("codTipComisionista=" + resultado.getCodTipComisionista());
				cat.debug("codigoVendedor=" + resultado.getCodigoVendedor());
				cat.debug("codigoVendedorDealer=" + resultado.getCodigoVendedorDealer());
			}
			if (cat.isDebugEnabled())
				cat.debug(" Finalizo ejecución");
		}
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener datos del vendedor", e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException) {
				throw (CustomerDomainException) e;
			}
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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
		cat.debug("buscarVendedor():end");
		return resultado;
	}// fin buscarVendedor

	/**
	 * @author mwn40031
	 * @param codVendedor
	 * @return
	 * @throws CustomerDomainException
	 */
	public Boolean validaVendedorLN(String codVendedor) throws CustomerDomainException {
		cat.info("validaVendedorLN, Inicio");
		cat.debug("codVendedor: " + codVendedor);
		final String nombrePackage = "VE_SERVICIOS_SOLICITUD_PG";
		final String nombrePL = "VE_VALIDA_VENDEDORLN_PR";
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = getConection();
		CallableStatement cstmt = null;
		int i = 1;
		final int numParametros = 4;
		try {
			String call = getSQLDatosVendedor(nombrePackage, nombrePL, numParametros);
			cat.debug("SQL [" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(i++, codVendedor);

			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			cat.debug("Antes de cstmt.execute()...");
			cstmt.execute();
			cat.debug("...después.");

			codError = cstmt.getInt(i - 3);
			msgError = cstmt.getString(i - 2);
			numEvento = cstmt.getInt(i - 1);

			cat.debug("codError [" + codError + "]");
			cat.debug("msgError [" + msgError + "]");
			cat.debug("numEvento [" + numEvento + "]");

			if (codError != 0) {
				throw new CustomerDomainException("Ocurrió un error al obtener datos", String.valueOf(codError),
						numEvento, msgError);
			}

		}
		catch (Exception e) {
			cat.error("Ocurrió un error al obtener datos", e);
			if (cat.isDebugEnabled()) {
				cat.debug("codError [" + codError + "]");
				cat.debug("msgError [" + msgError + "]");
				cat.debug("numEvento [" + numEvento + "]");
			}
			if (e instanceof CustomerDomainException) {
				throw (CustomerDomainException) e;
			}
		}
		finally {
			if (cat.isDebugEnabled())
				cat.debug("Cerrando conexiones...");
			try {
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
		cat.info("validaVendedorLN, Fin");
		cat.debug("retorna [" + true + "]");
		return Boolean.TRUE;
	} // fin validaVendedorLN

	/**
	 * @author JIB
	 * @param codVendedorDealer
	 * @return Boolean.TRUE si no está en Lista Negra. Otro caso CustomerDomainException
	 * @throws CustomerDomainException
	 * 
	 */
	public Boolean validaVendedorDealerLN(String codVendedorDealer) throws CustomerDomainException {
		cat.info("Inicio");
		cat.debug("codVendedorDealer: " + codVendedorDealer);
		final String nombrePackage = "VE_SERVICIOS_SOLICITUD_PG";
		final String nombrePL = "VE_VALIDA_VENDEDOREXTLN_PR";
		final int numParametros = 4;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = getConection();
		CallableStatement cstmt = null;
		int i = 1;
		final String mensajeError = "Ocurrió un error al validar lista negra";
		try {
			String call = getSQLDatosVendedor(nombrePackage, nombrePL, numParametros);
			cat.debug("SQL [" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(i++, codVendedorDealer);

			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(i++, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(i++, java.sql.Types.NUMERIC);

			cat.debug("Antes de cstmt.execute()...");
			cstmt.execute();
			cat.debug("...después.");

			codError = cstmt.getInt(i - 3);
			msgError = cstmt.getString(i - 2);
			numEvento = cstmt.getInt(i - 1);

			cat.debug("codError [" + codError + "]");
			cat.debug("msgError [" + msgError + "]");
			cat.debug("numEvento [" + numEvento + "]");
			if (codError != 0) {
				throw new CustomerDomainException(mensajeError, String.valueOf(codError), numEvento, msgError);
			}
		}
		catch (Exception e) {
			cat.debug("codError [" + codError + "]");
			cat.debug("msgError [" + msgError + "]");
			cat.debug("numEvento [" + numEvento + "]");
			if (e instanceof CustomerDomainException) {
				throw (CustomerDomainException) e;
			}
		}
		finally {

			cat.debug("Cerrando conexiones...");
			try {
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
		cat.info("Fin");
		return Boolean.TRUE;
	} // fin validaVendedorDealerLN

}// fin VendedorDAO

