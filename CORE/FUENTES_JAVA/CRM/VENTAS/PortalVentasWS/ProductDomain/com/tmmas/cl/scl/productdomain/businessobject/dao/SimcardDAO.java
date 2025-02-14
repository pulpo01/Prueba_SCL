/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 23/02/2007     Roberto P&eacute;rez Varas      			Versión Inicial
 */
package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ProcesoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.EquipoKitDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoSimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SerieDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class SimcardDAO extends ConnectionDAO {

	protected Logger logger = Logger.getLogger(getClass());

	Global global = Global.getInstance();

	private Connection getConection() throws ProductDomainException {
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		}
		catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProductDomainException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection

	private String getSQLDatosSimcard(String packageName, String procedureName, int paramCount) {
		StringBuffer sb = new StringBuffer("{call " + packageName + "." + procedureName + "(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount)
				sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosSimcard

	public ResultadoValidacionLogisticaDTO getLargoSerieSimcard(ParametrosValidacionLogisticaDTO entrada)
			throws ProductDomainException {
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		try {
			logger.debug("Inicio:getLargoSerieSimcard");

			String call = getSQLDatosSimcard("VE_intermediario_PG", "VE_obtiene_valor_parametro_PR", 7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getNombreParametro());
			cstmt.setString(2, entrada.getCodigoModulo());
			cstmt.setString(3, entrada.getCodigoProducto());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getLargoSerieSimcard:execute");
			cstmt.execute();
			logger.debug("Fin:getLargoSerieSimcard:execute");

			msgError = cstmt.getString(6);
			logger.debug("msgError[" + msgError + "]");

			resultado.setLargoSerie(cstmt.getInt(4));

			logger.debug("<<<LargoSerie   : " + resultado.getLargoSerie() + ">>>");

		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar largo de la serie simcard", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getLargoSerieSimcard()");
		return resultado;
	}//fin getLargoSerieSimcard

	public SimcardDTO getSimcard(SimcardDTO simcard) throws ProductDomainException {
		logger.debug("Inicio:getSimcard()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		SimcardDTO simcardDTO = null;
		try {
			String call = getSQLDatosSimcard("VE_servicios_venta_PG", "VE_consulta_serie_PR", 18);

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, simcard.getNumeroSerie());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);

			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getSimcard:execute");
			cstmt.execute();
			logger.debug("Fin:getSimcard:execute");

			codError = cstmt.getInt(16);
			msgError = cstmt.getString(17);
			numEvento = cstmt.getInt(18);

			logger.debug("Ingreso a getSimcard DAO codError : " + codError);
			logger.debug("Ingreso a getSimcard DAO msgError : " + msgError);
			logger.debug("Ingreso a getSimcard DAO numEvento : " + numEvento);

			logger.debug("msgError[" + msgError + "]");
			if (codError == 0) {
				simcardDTO = new SimcardDTO();
				simcardDTO.setNumeroSerie(simcard.getNumeroSerie());
				simcardDTO.setCodigoBodega(String.valueOf(cstmt.getInt(2)));
				simcardDTO.setEstado(String.valueOf(cstmt.getInt(3)));
				simcardDTO.setIndicadorProgramado(String.valueOf(cstmt.getInt(4)));
				simcardDTO.setNumeroCelular(String.valueOf(cstmt.getLong(5)));
				simcardDTO.setCodigoUso(cstmt.getInt(6));
				simcardDTO.setTipoStock(String.valueOf(cstmt.getInt(7)));
				simcardDTO.setCodigoCentral(String.valueOf(cstmt.getInt(8)));
				simcardDTO.setCodigoArticulo(String.valueOf(cstmt.getInt(9)));
				simcardDTO.setCapCode(String.valueOf(cstmt.getInt(10)));
				simcardDTO.setTipoArticulo(String.valueOf(cstmt.getInt(11)));
				simcardDTO.setDescripcionArticulo(cstmt.getString(12));
				simcardDTO.setCodigoSubAlm(cstmt.getString(13));
				simcardDTO.setIndicadorValorar(cstmt.getString(14));
				simcardDTO.setCarga(cstmt.getString(15));
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar Datos de la serie simcard", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getSimcard()");
		return simcardDTO;
	}//fin getSimcard

	public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO lineaEntrada)
			throws ProductDomainException {
		logger.debug("Inicio:existeSerieSimcard()");
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosSimcard("VE_validacion_linea_PG", "VE_existeseriebodega_PR", 5);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, lineaEntrada.getNumeroSerie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:existeSerieSimcard:execute");
			cstmt.execute();
			logger.debug("Fin:existeSerieSimcard:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			logger.debug("msgError[" + msgError + "]");
			resultado.setResultadoBase(cstmt.getInt(2));

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar Datos de la serie Simcard", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:existeSerieSimcard()");
		return resultado;
	}//fin existeSerieSimcard

	public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista(ParametrosCargoSimcardDTO entrada)
			throws ProductDomainException {
		logger.debug("Inicio:getPrecioCargoSimcard_PrecioLista()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosSimcard("VE_servicios_venta_PG", "VE_PrecCargoSimcard_PreLis_PR", 11);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setInt(1, Integer.parseInt(entrada.getCodigoArticulo()));
			cstmt.setInt(2, Integer.parseInt(entrada.getTipoStock()));
			cstmt.setInt(3, entrada.getCodigoUso());
			cstmt.setInt(4, Integer.parseInt(entrada.getEstado()));
			cstmt.setInt(5, Integer.parseInt(entrada.getIndiceRecambio()));
			cstmt.setString(6, entrada.getCodigoCategoria());
			cstmt.setString(7, entrada.getCodigoCalificacion());

			cstmt.registerOutParameter(8, OracleTypes.CURSOR);

			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getPrecioCargoSimcard_PrecioLista:execute");
			cstmt.execute();
			logger.debug("Fin:getPrecioCargoSimcard_PrecioLista:execute");

			codError = cstmt.getInt(9);
			msgError = cstmt.getString(10);
			numEvento = cstmt.getInt(11);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)");
				throw new ProductDomainException(
						"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)", String
								.valueOf(codError), numEvento, msgError);
			}
			else {
				logger.debug("Recuperando el precio de cargo de la Simcard (Precio Lista)");
				List lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(8);

				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					precioDTO.setCodigoConcepto(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setMonto(rs.getFloat(3));
					precioDTO.setCodigoMoneda(rs.getString(4));
					precioDTO.setDescripcionMoneda(rs.getString(5));
					precioDTO.setValorMinimo(rs.getString(6));
					precioDTO.setValorMaximo(rs.getString(7));
					//-- VALORES CONSTANTES
					precioDTO.setIndicadorAutMan(rs.getString(8));
					precioDTO.setNumeroUnidades(rs.getString(9));
					precioDTO.setIndicadorEquipo(rs.getString(10));
					precioDTO.setIndicadorPaquete(rs.getString(11));
					precioDTO.setMesGarantia(rs.getString(12));
					precioDTO.setIndicadorAccesorio(rs.getString(13));
					precioDTO.setCodigoArticulo(rs.getString(14));
					precioDTO.setCodigoStock(rs.getString(15));
					precioDTO.setCodigoEstado(rs.getString(16));
					lista.add(precioDTO);
				}
				resultado = (PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						PrecioCargoDTO.class);

				logger.debug("precio cargos Simcard (Precio Lista)");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (ProductDomainException e) {
			throw (e);
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)");
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
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
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getPrecioCargoSimcard_PrecioLista()");
		return resultado;
	}//fin getPrecioCargoSimcard_PrecioLista

	public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista(ParametrosCargoSimcardDTO entrada)
			throws ProductDomainException {
		logger.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosSimcard("VE_servicios_venta_PG", "VE_PreCarSimcard_NoPreLis_PR", 18);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			logger.debug("entrada.getCodigoArticulo(): " + entrada.getCodigoArticulo());
			cstmt.setInt(1, Integer.parseInt(entrada.getCodigoArticulo()));
			logger.debug("entrada.getTipoStock(): " + entrada.getTipoStock());
			cstmt.setInt(2, Integer.parseInt(entrada.getTipoStock()));
			logger.debug("entrada.getCodigoUso(): " + entrada.getCodigoUso());
			cstmt.setInt(3, entrada.getCodigoUso());
			logger.debug("entrada.getEstado(): " + entrada.getEstado());
			cstmt.setInt(4, Integer.parseInt(entrada.getEstado()));
			logger.debug("entrada.getModalidadVenta(): " + entrada.getModalidadVenta());
			cstmt.setInt(5, Integer.parseInt(entrada.getModalidadVenta()));
			logger.debug("entrada.getTipoContrato(): " + entrada.getTipoContrato());
			cstmt.setString(6, entrada.getTipoContrato());
			logger.debug("entrada.getPlanTarifario(): " + entrada.getPlanTarifario());
			cstmt.setString(7, entrada.getPlanTarifario());
			logger.debug("entrada.getIndiceRecambio(): " + entrada.getIndiceRecambio());
			cstmt.setString(8, entrada.getIndiceRecambio());
			logger.debug("entrada.getCodigoCategoria(): " + entrada.getCodigoCategoria());
			cstmt.setString(9, entrada.getCodigoCategoria());
			logger.debug("entrada.getCodigoUsoPrepago(): " + entrada.getCodigoUsoPrepago());
			cstmt.setString(10, entrada.getCodigoUsoPrepago());
			logger.debug("entrada.getIndicadorEquipo(): " + entrada.getIndicadorEquipo());
			cstmt.setString(11, entrada.getIndicadorEquipo());

			logger.debug("entrada.getCodigoCalificacion(): " + entrada.getCodigoCalificacion());
			cstmt.setString(12, entrada.getCodigoCalificacion());

			logger.debug("entrada.getIndRenovacion(): " + entrada.getIndRenovacion());
			cstmt.setInt(13, entrada.getIndRenovacion());

			logger.debug("Ind PriSeg: " + entrada.getIndRenovacion());
			cstmt.setInt(14, entrada.getIndRenovacion());

			cstmt.registerOutParameter(15, OracleTypes.CURSOR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista:execute");
			cstmt.execute();
			logger.debug("Fin:getPrecioCargoSimcard_NoPrecioLista:execute");

			codError = cstmt.getInt(16);
			msgError = cstmt.getString(17);
			numEvento = cstmt.getInt(18);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)");
				throw new ProductDomainException(
						"Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)", String
								.valueOf(codError), numEvento, msgError);
			}
			else {
				logger.debug("Recuperando el precio de cargo de la Simcard (No Precio Lista)");
				List lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(15);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					precioDTO.setCodigoConcepto(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setMonto(rs.getFloat(3));
					precioDTO.setCodigoMoneda(rs.getString(4));
					precioDTO.setDescripcionMoneda(rs.getString(5));
					precioDTO.setValorMinimo(rs.getString(6));
					precioDTO.setValorMaximo(rs.getString(7));
					//-- VALORES CONSTANTES
					precioDTO.setIndicadorAutMan(rs.getString(8));
					precioDTO.setNumeroUnidades(rs.getString(9));
					precioDTO.setIndicadorEquipo(rs.getString(10));
					precioDTO.setIndicadorPaquete(rs.getString(11));
					precioDTO.setMesGarantia(rs.getString(12));
					precioDTO.setIndicadorAccesorio(rs.getString(13));
					precioDTO.setCodigoArticulo(rs.getString(14));
					precioDTO.setCodigoStock(rs.getString(15));
					precioDTO.setCodigoEstado(rs.getString(16));

					lista.add(precioDTO);
				}
				resultado = (PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(),
						PrecioCargoDTO.class);
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (ProductDomainException e) {
			throw (e);
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)");
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
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
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getPrecioCargoSimcard_NoPrecioLista()");
		return resultado;
	}//fin getPrecioCargoSimcard_NoPrecioLista

	/**
	 * Busca todos los Descuentos tipo Articulo asociados a la simcard  
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) throws ProductDomainException {
		logger.debug("Inicio:getDescuentoCargoArticulo()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosSimcard("VE_servicios_venta_PG", "VE_obtiene_descuento_art_PR", 14);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			logger.debug("[getDescuentoCargoBasicoArticulo] cod operacion: " + entrada.getCodigoOperacion());
			logger.debug("[getDescuentoCargoBasicoArticulo] tipocontrato: " + entrada.getTipoContrato());
			logger.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesContrato());
			logger.debug("[getDescuentoCargoBasicoArticulo] codigo antiguedad: " + entrada.getCodigoAntiguedad());
			logger.debug("[getDescuentoCargoBasicoArticulo] cod promedio: " + entrada.getCodigoPromedioFacturable());
			logger.debug("[getDescuentoCargoBasicoArticulo] estado: " + entrada.getEquipoEstado());
			logger.debug("[getDescuentoCargoBasicoArticulo] contrato: " + entrada.getTipoContrato());
			logger.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesNuevo());
			logger.debug("[getDescuentoCargoBasicoArticulo] cod articulo: " + entrada.getCodigoArticulo());
			logger.debug("[getDescuentoCargoBasicoArticulo] clase desc: " + entrada.getClaseDescuento());
			cstmt.setString(1, entrada.getCodigoOperacion());
			cstmt.setString(2, entrada.getTipoContrato());
			cstmt.setInt(3, entrada.getNumeroMesesContrato());
			cstmt.setString(4, entrada.getCodigoAntiguedad());
			cstmt.setString(5, entrada.getCodigoPromedioFacturable());
			cstmt.setString(6, entrada.getEquipoEstado());
			cstmt.setString(7, entrada.getTipoContrato());
			cstmt.setInt(8, Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setString(9, entrada.getCodigoArticulo());
			cstmt.setString(10, entrada.getClaseDescuento());
			cstmt.registerOutParameter(11, OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getDescuentoCargoArticulo:Execute");
			cstmt.execute();
			logger.debug("Fin:getDescuentoCargoArticulo:Execute");

			codError = cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);

			logger.debug("INICIO getDescuentoCargoArticulo SIMCARDAO codError : " + codError);
			logger.debug("INICIO getDescuentoCargoArticulo SIMCARDAO msgError : " + msgError);
			logger.debug("INICIO getDescuentoCargoArticulo SIMCARDAO numEvento : " + numEvento);

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar los descuentos del cargo basico");
				throw new CustomerDomainException("Ocurrió un error al recuperar los descuentos del cargo basico",
						String.valueOf(codError), numEvento, msgError);

			}
			else {
				logger.debug("Recuperando descuentos");
				List lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(11);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setCodMoneda(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));

					lista.add(descuentoDTO);
					logger.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(4));
					logger.debug("[getDescuentoDescripcionConcepto] : " + rs.getString(2));
					logger.debug("[getDescuentoMonto]: " + rs.getFloat(3));
					logger.debug("[getCodigoConcepto]: " + rs.getString(4));

				}
				resultado = (DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DescuentoDTO.class);
				logger.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los descuentos del cargo basico", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException("Ocurrió un error al recuperar los descuentos del cargo basico", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
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
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getDescuentoCargoArticulo()");

		return resultado;
	}//fin getDescuentoCargoArticulo

	/**
	 * Busca todos los Descuentos tipo concepto asociados a la simcard 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) throws ProductDomainException {

		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosSimcard("VE_servicios_venta_PG", "VE_obtiene_descuento_con_PR", 19);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 1");

			cstmt.setString(1, entrada.getCodigoOperacion());
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 2 entrada.getCodigoOperacion() : "
					+ entrada.getCodigoOperacion());
			cstmt.setString(2, entrada.getCodigoAntiguedad());
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 2 entrada.getCodigoAntiguedad() : "
					+ entrada.getCodigoAntiguedad());
			cstmt.setString(3, entrada.getTipoContrato());
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 2 entrada.getCodigoContratoNuevo() : "
					+ entrada.getTipoContrato());
			cstmt.setInt(4, Integer.parseInt(entrada.getNumeroMesesNuevo()));
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 3 entrada.getNumeroMesesNuevo() : "
					+ entrada.getNumeroMesesNuevo());
			cstmt.setInt(5, Integer.parseInt(entrada.getIndiceVentaExterna()));
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 4 entrada.getIndiceVentaExterna() : "
					+ entrada.getIndiceVentaExterna());
			cstmt.setLong(6, Long.parseLong(entrada.getCodigoVendedor()));
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 5 entrada.getCodigoVendedor() : "
					+ entrada.getCodigoVendedor());
			cstmt.setString(7, entrada.getCodigoCausaVenta());
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 6 entrada.getCodigoCausaVenta() : "
					+ entrada.getCodigoCausaVenta());
			cstmt.setString(8, entrada.getCodigoCategoria());
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 7 entrada.getCodigoCategoria() : "
					+ entrada.getCodigoCategoria());
			cstmt.setInt(9, Integer.parseInt(entrada.getCodigoModalidadVenta()));
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 8 entrada.getTipoPlanTarifario() : "
					+ entrada.getTipoPlanTarifario());
			cstmt.setInt(10, Integer.parseInt(entrada.getTipoPlanTarifario()));
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 9 : entrada.getConcepto() "
					+ entrada.getConcepto());
			cstmt.setInt(11, Integer.parseInt(entrada.getConcepto()));
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 10 : entrada.getClaseConcepto() "
					+ entrada.getClaseDescuento());
			cstmt.setString(12, entrada.getClaseDescuento());
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO 10 : entrada.getCodigoCalificaion() "
					+ entrada.getCodigoCalificaion());
			cstmt.setString(13, entrada.getCodigoCalificaion());
			logger.debug("getIndRenovacion()" + entrada.getIndRenovacion());
			cstmt.setInt(14, entrada.getIndRenovacion());
			logger.debug("Ind PriSeg:" + entrada.getIndRenovacion());
			cstmt.setInt(15, entrada.getIndRenovacion());

			cstmt.registerOutParameter(16, OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);

			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO Antes exec");
			cstmt.execute();
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO Despues exec");

			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO codError : " + codError);
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO msgError : " + msgError);
			logger.debug("INICIO getDescuentoCargoConcepto SIMCARDDAO numEvento : " + numEvento);

			if (codError != 0) {
				logger.debug("INICIO codError != 0 : " + numEvento);
				logger.error("Ocurrió un error al recuperar los descuentos del cargo");
				/*throw new CustomerDomainException(
				 "Ocurrió un error al recuperar los descuentos del cargo", String
				 .valueOf(codError), numEvento, msgError);*/

			}
			else {
				logger.debug("Recuperando descuentos");
				List lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(16);

				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setCodMoneda(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));
					lista.add(descuentoDTO);
				}
				resultado = (DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), DescuentoDTO.class);
				logger.debug("Fin recuperacion de descuentos del cargo");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los descuentos del cargo", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException("Ocurrió un error al recuperar los descuentos del cargo", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
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
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getDescuentoCargoConcepto()");

		return resultado;
	}//fin getDescuentoCargoConcepto

	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductDomainException {
		logger.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = new DescuentoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosSimcard("VE_servicios_venta_PG", "VE_consulta_cod_desc_manual_PR", 6);
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getCodigoConcepto());
			logger.debug(" Codigo concepto: " + entrada.getCodigoConcepto());
			cstmt.setString(2, entrada.getTipoConcepto());
			logger.debug("Tipo concepto: " + entrada.getTipoConcepto());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			//-- control error
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (codError == 0) {
				resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
				logger.debug("Codigo Concepto Descuento: " + resultado.getCodigoConcepto());
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar el código de descuento manual", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException("Ocurrió un error al recuperar el código de descuento manual", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getCodigoDescuentoManual()");

		return resultado;
	}//fin getCodigoDescuentoManual	

	/**
	 * Consulta si el numero de celular esta reservado correctamente
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public ResultadoValidacionLogisticaDTO getNumeroReservadoOK(ParametrosValidacionLogisticaDTO entrada)
			throws ProductDomainException {
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			logger.debug("Inicio:getNumeroReservadoOK");

			String call = getSQLDatosSimcard("VE_validacion_linea_PG", "VE_numeroreservadoOK_PR", 7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entrada.getNumeroCelular());
			cstmt.setString(2, entrada.getCodigoCliente());
			cstmt.setString(3, entrada.getCodigoVendedor());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getNumeroReservadoOK:execute");
			cstmt.execute();
			logger.debug("Fin:getNumeroReservadoOK:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			;

			resultado.setResultadoBase(cstmt.getInt(4));

		}
		catch (Exception e) {
			logger.error("Ocurrió un error al verificar si el numero de celular esta reservado correctamente", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getNumeroReservadoOK");

		return resultado;
	}//fin getNumeroReservadoOK

	/**
	 * Obtiene el indicador de telefono 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public SimcardDTO getIndicadorTelefono(SimcardDTO entrada) throws ProductDomainException {
		logger.debug("Inicio:getIndicadorTelefono()");
		SimcardDTO resultado = new SimcardDTO();
		resultado.setNumeroSerie(entrada.getNumeroSerie());
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosSimcard("VE_servicios_venta_PG", "VE_obtiene_ind_telefono_PR", 6);

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getNumeroSerie());
			cstmt.setString(2, entrada.getIndicadorTelefono());// viene el indicador a descartar

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getIndicadorTelefono:execute");
			cstmt.execute();
			logger.debug("Fin:getIndicadorTelefono:execute");
			if (codError == 0)
				resultado.setIndicadorTelefono(String.valueOf(cstmt.getInt(3))); // se carga el indicador encontrado

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar indicador de telefono de la simcard", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getIndicadorTelefono()");
		return resultado;
	}//fin getIndicadorTelefono

	/**
	 * Valida autenticación de la serie 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public ProcesoDTO validaAutenticacionSerie(SimcardDTO entrada) throws ProductDomainException {
		logger.debug("Inicio:validaAutenticacionSerie()");
		ProcesoDTO proceso = new ProcesoDTO();
		proceso.setCodigoError(0);
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosSimcard("VE_intermediario_PG", "VE_valida_autentificacion_PR", 6);

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, entrada.getNumeroSerie());
			logger.debug("getNumeroSerie: " + entrada.getNumeroSerie());
			cstmt.setString(2, entrada.getIndProcEq());
			logger.debug("getIndProcEq: " + entrada.getIndProcEq());
			cstmt.setString(3, String.valueOf(entrada.getCodigoUso()));
			logger.debug("getCodigoUso: " + entrada.getCodigoUso());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:validaAutenticacionSerie:execute");
			cstmt.execute();
			logger.debug("Fin:validaAutenticacionSerie:execute");
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			proceso.setCodigoError(codError);
			logger.debug("codError: " + codError);
			logger.debug("msgError: " + msgError);
			proceso.setEvento(numEvento);
			proceso.setMensajeError(msgError);
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al realizar autenticación de la serie", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:validaAutenticacionSerie()");
		return proceso;
	}//fin validaAutenticacionSerie

	/**
	 * Obtiene imsi de la simcard, utilizado para isertar movimiento en centrales 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public SimcardDTO getImsiSimcard(SimcardDTO simcard) throws ProductDomainException {
		logger.debug("Inicio:getImsiSimcard()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosSimcard("VE_intermediario_PG", "VE_obtiene_imsi_simcard_PR", 6);

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, simcard.getNumeroSerie());
			logger.debug("simcard.getNumeroSerie() " + simcard.getNumeroSerie());
			cstmt.setString(2, simcard.getCodigoImsi());
			logger.debug("simcard.getCodigoImsi() " + simcard.getCodigoImsi());
			logger.debug("Inicio:getImsiSimcard:execute");
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getImsiSimcard:execute");
			cstmt.execute();
			logger.debug("Fin:getImsiSimcard:execute");
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			if (codError != 0) {
				logger.error("Ocurrió un error al buscar el imsi de la simcard");
				throw new CustomerDomainException("Ocurrió un error al buscar el imsi de la simcard", String
						.valueOf(codError), numEvento, msgError);

			}
			else
				simcard.setValorImsi(cstmt.getString(3));
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al buscar el imsi de la simcard", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getImsiSimcard()");
		return simcard;
	}//fin getImsiSimcard

	/**
	 * Actualiza stock simcard
	 * @param simcard
	 * @return
	 * @throws ProductDomainException
	 */
	public SimcardDTO actualizaStockSimcard(SimcardDTO simcard) throws ProductDomainException {
		logger.debug("Ingreso a actualizaStockSimcard DAO");
		SimcardDTO resultado = new SimcardDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			logger.debug("Inicio:actualizaStockSimcard");

			String call = getSQLDatosSimcard("VE_intermediario_PG", "VE_actualiza_stock_PR", 14);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1, simcard.getTipoMovimiento());
			cstmt.setString(2, simcard.getTipoStock());
			cstmt.setString(3, simcard.getCodigoBodega());
			cstmt.setString(4, simcard.getCodigoArticulo());
			cstmt.setString(5, String.valueOf(simcard.getCodigoUso()));
			cstmt.setString(6, simcard.getEstado());
			cstmt.setString(7, simcard.getNumeroVenta());
			cstmt.setString(8, simcard.getNumeroSerie());
			cstmt.setString(9, simcard.getIndicadorTelefono());

			logger.debug("SIMCARD simcard.getTipoMovimiento() : " + simcard.getTipoMovimiento());
			logger.debug("SIMCARD simcard.getTipoStock() : " + simcard.getTipoStock());
			logger.debug("SIMCARD simcard.getCodigoBodega() : " + simcard.getCodigoBodega());
			logger.debug("SIMCARD simcard.getCodigoArticulo() : " + simcard.getCodigoArticulo());
			logger.debug("SIMCARD simcard.getCodigoUso() : " + simcard.getCodigoUso());
			logger.debug("SIMCARD simcard.getEstado() : " + simcard.getEstado());
			logger.debug("SIMCARD simcard.getNumeroVenta() : " + simcard.getNumeroVenta());
			logger.debug("SIMCARD simcard.getNumeroSerie() : " + simcard.getNumeroSerie());
			logger.debug("SIMCARD simcard.getIndicadorTelefono() : " + simcard.getIndicadorTelefono());

			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			logger.debug("Inicio:actualizaStockSimcard:execute");
			logger.debug("Ingreso a actualizaStockSimcard DAO Antes execute ");
			cstmt.execute();
			logger.debug("Ingreso a actualizaStockSimcard DAO Despues execute");
			logger.debug("Fin:actualizaStockSimcard:execute");

			codError = cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);

			logger.debug("Ingreso a actualizaStockSimcard DAO codError : " + codError);
			logger.debug("Ingreso a actualizaStockSimcard DAO msgError : " + msgError);
			logger.debug("Ingreso a actualizaStockSimcard DAO numEvento : " + numEvento);

			resultado.setNumeroMovimiento(cstmt.getString(10));
			resultado.setIndSerConTel(cstmt.getString(11));
			resultado.setCodigoError(codError);

		}
		catch (Exception e) {
			logger.error("Ocurrió un error al actualizar stock simcard", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:actualizaStockSimcard");
		return resultado;
	}//fin actualizaStockSimcard

	public SerieDTO[] buscarSerie(SerieDTO entrada) throws ProductDomainException {
		logger.info("buscarSerie, inicio");
		SerieDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		final String nombrePackage = "VE_parametros_comerciales_PG";
		final String nombrePL = "VE_Busca_Serie_PR";
		final int cantParametros = 15;
		try {
			final String call = getSQLDatosSimcard(nombrePackage, nombrePL, cantParametros);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			logger.debug("buscarSerie.DAO:inicio");
			cstmt.setString(1, entrada.getNumTelefono());
			logger.debug("entrada.getNumTelefono(): " + entrada.getNumTelefono());
			cstmt.setString(2, entrada.getNumSerie());
			logger.debug("entrada.getNumSerie(): " + entrada.getNumSerie());
			cstmt.setInt(3, entrada.getCodCanal());
			logger.debug("entrada.getCodCanal(): " + entrada.getCodCanal());
			cstmt.setInt(4, entrada.getCodModVenta());
			logger.debug("entrada.getCodModVenta(): " + entrada.getCodModVenta());
			cstmt.setLong(5, entrada.getCodVendedor());
			logger.debug("entrada.getCodVendedor(): " + entrada.getCodVendedor());
			cstmt.setString(6, entrada.getTipArticulo());
			logger.debug("entrada.getTipArticulo(): " + entrada.getTipArticulo());
			cstmt.setString(7, entrada.getCodTecnologia());
			logger.debug("entrada.getCodTecnologia(): " + entrada.getCodTecnologia());
			cstmt.setString(8, entrada.getTipTerminal());
			logger.debug("entrada.getTipTerminal(): " + entrada.getTipTerminal());
			cstmt.setLong(9, entrada.getCodUso());
			logger.debug("entrada.getCodUso(): " + entrada.getCodUso());
			cstmt.setLong(10, entrada.getCodCentral());
			logger.debug("entrada.getCodCentral(): " + entrada.getCodCentral());
			cstmt.setString(11, entrada.getCodHlr());
			logger.debug("entrada.getCodHlr(): " + entrada.getCodHlr());

			cstmt.registerOutParameter(12, OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantParametros, java.sql.Types.NUMERIC);

			logger.debug("buscarSerie:Antes exec");
			cstmt.execute();
			logger.debug("buscarSerie:Despues exec");

			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento = cstmt.getInt(cantParametros);

			logger.debug("buscarSerie:codError : " + codError);
			logger.debug("buscarSerie:msgError : " + msgError);
			logger.debug("buscarSerie:numEvento : " + numEvento);

			if (codError != 0) {
				logger.error("Ocurrió un error al buscar la serie");
				throw new ProductDomainException(String.valueOf(codError), numEvento, msgError);

			}
			else {
				logger.debug("Recuperando serie");
				List lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(12);

				while (rs.next()) {
					SerieDTO serieDTO = new SerieDTO();
					serieDTO.setNumSerie(rs.getString(1));
					serieDTO.setNumTelefono(rs.getString(5));
					serieDTO.setFechaEntrada(rs.getString(6));
					serieDTO.setTipoStock(rs.getString(7));
					/** 
					 * Incidencia 148144
					 * @author JIB
					 * Operadora solicita mostrar des_uso en la búsqueda de series */
					serieDTO.setDesUso(rs.getString(8));
					//cat.debug(serieDTO.getDesUso());
					
					logger.debug("TipoStock: "+ serieDTO.getTipoStock());
					logger.debug("NumSerie: "+ serieDTO.getNumSerie());
					logger.debug("NumTelefono: "+ serieDTO.getNumTelefono());
					logger.debug("FechaEntrada: "+ serieDTO.getFechaEntrada());
					logger.debug("DesUso: "+ serieDTO.getDesUso());
					
					lista.add(serieDTO);
				}
				resultado = (SerieDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SerieDTO.class);
				logger.debug("Fin recuperando serie");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar la serie", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(msgError, e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
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
				logger.debug("SQLException", e);
			}
		}
		logger.info("Fin:buscarSerie()");
		return resultado;
	}//fin buscarSerie

	public SerieDTO[] listarSerie(SerieDTO entrada) throws ProductDomainException {
		logger.info("listarSerie, inicio");
		SerieDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		ResultSet rs = null;
		final String nombrePackage = "VE_parametros_comerciales_PG";
		final String nombrePL = "VE_getList_Series_PR";
		final int cantParametros = 13;
		try {
			final String call = getSQLDatosSimcard(nombrePackage, nombrePL, cantParametros);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setLong(1, entrada.getCodBodega());
			logger.debug("entrada.getCodBodega(): " + entrada.getCodBodega());
			cstmt.setLong(2, entrada.getCodArticulo());
			logger.debug("entrada.getCodArticulo(): " + entrada.getCodArticulo());
			cstmt.setString(3, entrada.getCodHlr());
			logger.debug("entrada.getCodHlr(): " + entrada.getCodHlr());
			cstmt.setInt(4, entrada.getCodModVenta());
			logger.debug("entrada.getCodModVenta(): " + entrada.getCodModVenta());
			cstmt.setLong(5, entrada.getCodCanal());
			logger.debug("entrada.getCodCanal(): " + entrada.getCodCanal());
			cstmt.setLong(6, entrada.getCodVendedor());
			logger.debug("entrada.getCodVendedor(): " + entrada.getCodVendedor());
			cstmt.setLong(7, entrada.getCodCentral());
			logger.debug("entrada.getCodCentral(): " + entrada.getCodCentral());
			cstmt.setLong(8, entrada.getCodUso());
			logger.debug("entrada.getCodUso(): " + entrada.getCodUso());
			cstmt.setString(9, entrada.getTipArticulo());
			logger.debug("entrada.getCodTipArticulo(): " + entrada.getTipArticulo());

			cstmt.registerOutParameter(10, OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(cantParametros, java.sql.Types.NUMERIC);

			logger.debug("listarSerie:Antes exec");
			cstmt.execute();
			logger.debug("listarSerie:Despues exec");

			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(cantParametros);

			logger.debug("listarSerie:codError : " + codError);
			logger.debug("listarSerie:msgError : " + msgError);
			logger.debug("listarSerie:numEvento : " + numEvento);

			if (codError != 0) {
				logger.error("Ocurrió un error al listar la serie");
				throw new CustomerDomainException("Ocurrió un error al listar la serie", String.valueOf(codError),
						numEvento, msgError);

			}
			else {
				logger.debug("Recuperando serie");
				List lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(10);
				//P-CSR-11002 JLGN 14-06-2011
				boolean flagVacio = true; 

				while (rs.next()) {
					SerieDTO serieDTO = new SerieDTO();
					serieDTO.setTipoStock(rs.getString(1));
					serieDTO.setNumSerie(rs.getString(2));
					serieDTO.setNumTelefono(rs.getString(4));
					serieDTO.setFechaEntrada(rs.getString(9));
					/** 
					 * Incidencia 148144
					 * @author JIB
					 * Operadora solicita mostrar des_uso en la búsqueda de series */
					serieDTO.setDesUso(rs.getString(10));
					
					logger.debug("TipoStock: "+ serieDTO.getTipoStock());
					logger.debug("NumSerie: "+ serieDTO.getNumSerie());
					logger.debug("NumTelefono: "+ serieDTO.getNumTelefono());
					logger.debug("FechaEntrada: "+ serieDTO.getFechaEntrada());
					logger.debug("DesUso: "+ serieDTO.getDesUso());
					
					lista.add(serieDTO);
					flagVacio = false;
				}
				resultado = (SerieDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), SerieDTO.class);
				logger.debug("Fin recuperando serie");
				//P-CSR-11002 JLGN 14-06-2011 Valida Si cursor viene vacio
				/*if(flagVacio){
					//cursor Viene Vacio
					logger.error("Cursor viene vacio");
					throw new CustomerDomainException("No existen Articulos en la Bodega Seleccionada", String.valueOf(-1),-1, "No existen Articulos en la Bodega Seleccionada");
				}*/
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.debug("entro por aca");
			logger.error("Ocurrió un error al listar la serie", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			logger.debug("codError: "+e.getLocalizedMessage());
			logger.debug("desError: "+e.getMessage());
			logger.debug("causaError: "+e.getCause());
			
			throw new ProductDomainException("Ocurrió un error al listar la serie", e);
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
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
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:listarSerie()");
		return resultado;
	}//fin listarSerie

	public EquipoKitDTO getSerieEquipoKit(EquipoKitDTO entrada) throws ProductDomainException {
		logger.debug("Inicio:getSerieEquipoKit()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		EquipoKitDTO resultado = null;
		try {
			String call = getSQLDatosSimcard("VE_PARAMETROS_COMERCIALES_PG", "VE_obtiene_serieEquipoKit_PR", 21);

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1, entrada.getNumKit());
			cstmt.setString(2, entrada.getCodTecnologia());

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);

			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);

			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(21, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getSerieEquipoKit:execute");
			cstmt.execute();
			logger.debug("Fin:getSerieEquipoKit:execute");

			codError = cstmt.getInt(19);
			msgError = cstmt.getString(20);
			numEvento = cstmt.getInt(21);

			logger.debug("Ingreso a getSerieEquipoKit DAO codError : " + codError);
			logger.debug("Ingreso a getSerieEquipoKit DAO msgError : " + msgError);
			logger.debug("Ingreso a getSerieEquipoKit DAO numEvento : " + numEvento);

			logger.debug("msgError[" + msgError + "]");
			if (codError == 0) {

				resultado = new EquipoKitDTO();
				//Datos Simcard
				resultado.setCodArticuloSimcard(cstmt.getLong(3));
				resultado.setNumSerieSimcard(cstmt.getString(4));
				resultado.setCodBodegaSimcard(cstmt.getLong(5));
				resultado.setTipoStockSimcard(cstmt.getLong(6));
				resultado.setIndTelefonoSimcard(cstmt.getInt(7));
				resultado.setNumTelefonoSimcard(cstmt.getLong(8));
				resultado.setNumSerieMecSimcard(cstmt.getString(9));
				resultado.setTipTerminalSimcard(cstmt.getString(10));

				//Datos Equipo
				resultado.setCodArticuloEquipo(cstmt.getLong(11));
				resultado.setNumSerieEquipo(cstmt.getString(12));
				resultado.setCodBodegaEquipo(cstmt.getLong(13));
				resultado.setTipoStockEquipo(cstmt.getLong(14));
				resultado.setIndTelefonoEquipo(cstmt.getInt(15));
				resultado.setNumTelefonoEquipo(cstmt.getLong(16));
				resultado.setNumSerieMecEquipo(cstmt.getString(17));
				resultado.setTipTerminalEquipo(cstmt.getString(18));

			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los datos del equipo kit", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getSerieEquipoKit()");
		return resultado;
	}//fin getSerieEquipoKit
	
	//INICIO INC 187717 26/09/2012
	/**
	 * Obtiene numero de la movimiento, utilizado para desreservar la serie 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public SimcardDTO getNumMovimmiento(SimcardDTO simcard) throws ProductDomainException {
		logger.debug("Inicio:getNumMovimmiento()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLDatosSimcard("VE_intermediario_PG", "VE_obtiene_numero_movi_PR", 5);

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1, simcard.getNumeroSerie());
			logger.debug("simcard.getNumeroSerie() " + simcard.getNumeroSerie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getNumMovimmiento:execute");
			cstmt.execute();
			logger.debug("Fin:getNumMovimmiento:execute");
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			if (codError != 0) {
				logger.error("Ocurrió un error al buscar el numero de movimiento para la serie : "+simcard.getNumeroSerie());
				//throw new CustomerDomainException("Ocurrió un error al buscar el numero de movimiento para la serie :", String
				//		.valueOf(codError), numEvento, msgError);

			}
			else
				simcard.setNumeroMovimiento(String.valueOf(cstmt.getInt(2)));
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al buscar el numero de movimiento para la seried", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getNumMovimmiento()");
		return simcard;
	}//fin getNumMovimmiento
	//FIN INC 187717 26/09/2012
//	INICIO INC 192326 11/02/2013
	/**
	 * Obtiene numero de la movimiento, utilizado para desreservar la serie 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public SimcardDTO getKitAboPrepago(long abonado)  throws ProductDomainException {
		logger.debug("Inicio:getKitAboPrepago()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		SimcardDTO resultado = new SimcardDTO();
		try {
			String call = getSQLDatosSimcard("Ve_Servicios_Venta_Pg", "VE_consulta_kit_PR", 11);

			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setLong(1, abonado);
			logger.debug("Abonado: " + abonado);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getNumMovimmiento:execute");
			cstmt.execute();
			logger.debug("Fin:getNumMovimmiento:execute");
			
			codError = cstmt.getInt(9);
			logger.debug("codError: " + codError);
			msgError = cstmt.getString(10);
			logger.debug("msgError: " + msgError);
			numEvento = cstmt.getInt(11);
			logger.debug("numEvento: " + numEvento);
			if (codError != 0) {
				logger.error("Ocurrió un error al buscar el kit para el abonado : "+abonado);
				//throw new CustomerDomainException("Ocurrió un error al buscar el numero de movimiento para la serie :", String
				//		.valueOf(codError), numEvento, msgError);

			}
			else
				resultado.setTipoStock(String.valueOf(cstmt.getInt(2)));
				logger.debug("Tip Stock: " + String.valueOf(cstmt.getInt(2)));
				resultado.setCodigoBodega(String.valueOf(cstmt.getInt(3)));
				logger.debug("Bodega: " + String.valueOf(cstmt.getInt(3)));
				resultado.setCodigoArticulo(String.valueOf(cstmt.getInt(4)));
				logger.debug("Articulo: " + String.valueOf(cstmt.getInt(4)));
				resultado.setCodigoUso(cstmt.getInt(5));
				logger.debug("Uso: " + cstmt.getInt(5));
				resultado.setEstado(String.valueOf(cstmt.getInt(6)));
				logger.debug("Estado: " + String.valueOf(cstmt.getInt(6)));
				resultado.setNumeroSerie(String.valueOf(cstmt.getString(7)));
				logger.debug("Serie: " + String.valueOf(cstmt.getString(7)));
				resultado.setIndicadorTelefono(String.valueOf(cstmt.getInt(8)));
				logger.debug("IND TELEFONO: " + String.valueOf(cstmt.getInt(8)));
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}
		catch (Exception e) {
			logger.error("Ocurrió un error al buscar el kit para el abonado", e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		}
		finally {
			if (logger.isDebugEnabled())
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt != null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			}
			catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getKitAboPrepago()");
		return resultado;
	}//fin getNumMovimmiento
	//FIN  INC 192326 11/02/2013
}//fin SimcardDAO

