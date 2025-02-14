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
package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CargosSimcarPrepagoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosCargoSimcardDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ProcesoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.SimcardSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;


public class SimcardDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(SimcardDAO.class);
	Global global = Global.getInstance();

	private Connection getConection() 
	throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection

	private String getSQLDatosSimcard(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosSimcard

	public ResultadoValidacionLogisticaDTO getLargoSerieSimcard(ParametrosValidacionLogisticaDTO entrada) 
	throws GeneralException{
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getLargoSerieSimcard");

			//INI-01 (AL) String call = getSQLDatosSimcard("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);
			String call = getSQLDatosSimcard("VE_intermediario_Quiosco_PG","VE_obtiene_valor_parametro_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNombreParametro());
			cstmt.setString(2,entrada.getCodigoModulo());
			cstmt.setString(3,entrada.getCodigoProducto());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getLargoSerieSimcard:execute");
			cstmt.execute();
			cat.debug("Fin:getLargoSerieSimcard:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar el largo de serie");
				throw new GeneralException(
						"Ocurrió un error al recuperar el largo de serie", String
						.valueOf(codError), numEvento, msgError);
			}

			resultado.setLargoSerie(cstmt.getInt(4));

			cat.debug("<<<LargoSerie   : " + resultado.getLargoSerie() + ">>>");
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar largo de la serie simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getLargoSerieSimcard()");
		return resultado;
	}//fin getLargoSerieSimcard

	public SimcardSNPNDTO getSimcard(SimcardSNPNDTO simcard) 
	throws GeneralException{
		cat.debug("Inicio:getSimcard()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		SimcardSNPNDTO SimcardSNPNDTO = null;
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_servicios_venta_PG","VE_consulta_serie_PR",19);
			String call = getSQLDatosSimcard("VE_servicios_venta_quiosco_PG","VE_consulta_serie_PR",19);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,simcard.getNumeroSerie());

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
			cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSimcard:execute");
			cstmt.execute();
			cat.debug("Fin:getSimcard:execute");

			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");


			if (codError == 0){
				SimcardSNPNDTO = new SimcardSNPNDTO();
				SimcardSNPNDTO.setNumeroSerie(simcard.getNumeroSerie());
				cat.error("SimcardSNPNDTO.setNumeroSerie ["+simcard.getNumeroSerie()+"]");
				SimcardSNPNDTO.setCodigoBodega(String.valueOf(cstmt.getInt(2)));
				cat.error("SimcardSNPNDTO.setCodigoBodega ["+cstmt.getInt(2)+"]");
				SimcardSNPNDTO.setEstado(String.valueOf(cstmt.getInt(3)));
				cat.error("SimcardSNPNDTO.setEstado ["+cstmt.getInt(3)+"]");
				SimcardSNPNDTO.setIndicadorProgramado(String.valueOf(cstmt.getInt(4)));
				cat.error("SimcardSNPNDTO.setIndicadorProgramado ["+cstmt.getInt(4)+"]");
				SimcardSNPNDTO.setNumeroCelular(String.valueOf(cstmt.getLong(5)));
				cat.error("SimcardSNPNDTO.setNumeroCelular ["+cstmt.getLong(5)+"]");
				SimcardSNPNDTO.setCodigoUso(String.valueOf(cstmt.getInt(6)));
				cat.error("SimcardSNPNDTO.setCodigoUso ["+cstmt.getInt(6)+"]");
				SimcardSNPNDTO.setTipoStock(String.valueOf(cstmt.getInt(7)));
				cat.error("SimcardSNPNDTO.setTipoStock ["+cstmt.getInt(7)+"]");
				SimcardSNPNDTO.setCodigoCentral(String.valueOf(cstmt.getInt(8)));
				cat.error("SimcardSNPNDTO.setCodigoCentral ["+cstmt.getInt(8)+"]");
				SimcardSNPNDTO.setCodigoArticulo(String.valueOf(cstmt.getInt(9)));
				cat.error("SimcardSNPNDTO.setCodigoArticulo ["+cstmt.getInt(9)+"]");
				SimcardSNPNDTO.setCapCode(String.valueOf(cstmt.getInt(10)));
				cat.error("SimcardSNPNDTO.setCapCode ["+cstmt.getInt(10)+"]");
				SimcardSNPNDTO.setTipoArticulo(String.valueOf(cstmt.getInt(11)));
				cat.error("SimcardSNPNDTO.setTipoArticulo ["+cstmt.getInt(11)+"]");
				SimcardSNPNDTO.setDescripcionArticulo(cstmt.getString(12));
				cat.error("SimcardSNPNDTO.setDescripcionArticulo ["+cstmt.getString(12)+"]");
				SimcardSNPNDTO.setCodigoSubAlm(cstmt.getString(13));
				cat.error("SimcardSNPNDTO.setCodigoSubAlm ["+cstmt.getString(13)+"]");
				SimcardSNPNDTO.setIndicadorValorar(cstmt.getString(14));
				cat.error("SimcardSNPNDTO.setIndicadorValorar ["+cstmt.getString(14)+"]");
				SimcardSNPNDTO.setCarga(cstmt.getString(15));
				cat.error("SimcardSNPNDTO.setCarga ["+cstmt.getString(15)+"]");
				SimcardSNPNDTO.setCodHLR(cstmt.getString(16));
				cat.error("SimcardSNPNDTO.setCodHLR ["+cstmt.getString(16)+"]");
			}else{
				cat.error("Ocurrió un error al recuperar informacion de simcard");
				throw new GeneralException(
						"Ocurrió un error al recuperar informacion de simcard", String
						.valueOf(codError), numEvento, msgError);
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		}catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Datos de la serie simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getSimcard()");
		return SimcardSNPNDTO;
	}//fin getSimcard

	public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO lineaEntrada) 
	throws GeneralException{
		cat.debug("Inicio:existeSerieSimcard()");
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_validacion_linea_PG","VE_existeseriebodega_PR",5);
			String call = getSQLDatosSimcard("VE_validacion_linea_quiosco_PG","VE_existeseriebodega_PR",5);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,lineaEntrada.getNumeroSerie());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			cat.debug("Inicio:existeSerieSimcard:execute");
			cstmt.execute();
			cat.debug("Fin:existeSerieSimcard:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");


			if (codError != 0) {
				cat.error("Ocurrió un error en existeseriebodega");
				throw new GeneralException(
						"Ocurrió un error en existeseriebodega", String
						.valueOf(codError), numEvento, msgError);
			}

			resultado.setResultadoBase(cstmt.getInt(2));

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar Datos de la serie Simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:existeSerieSimcard()");
		return resultado;
	}//fin existeSerieSimcard

	public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista(ParametrosCargoSimcardDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getPrecioCargoSimcard_PrecioLista()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_servicios_venta_PG","VE_PrecCargoSimcard_PreLis_PR",10);
			String call = getSQLDatosSimcard("VE_servicios_venta_quiosco_PG","VE_PrecCargoSimcard_PreLis_PR",10);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
			cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
			cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
			cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceRecambio()));
			cstmt.setString(6,entrada.getCodigoCategoria());

			cstmt.registerOutParameter(7,OracleTypes.CURSOR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getPrecioCargoSimcard_PrecioLista:execute");
			cstmt.execute();
			cat.debug("Fin:getPrecioCargoSimcard_PrecioLista:execute");

			codError = cstmt.getInt(8);
			msgError = cstmt.getString(9);
			numEvento = cstmt.getInt(10);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)");
				throw new GeneralException(
						"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando el precio de cargo de la Simcard (Precio Lista)");
				List lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(7);

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
				rs.close();
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), PrecioCargoDTO.class);

				cat.debug("precio cargos Simcard (Precio Lista)");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
			"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getPrecioCargoSimcard_PrecioLista()");
		return resultado;
	}//fin getPrecioCargoSimcard_PrecioLista

	public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista(ParametrosCargoSimcardDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_servicios_venta_PG","VE_PreCarSimcard_NoPreLis_PR",15);
			String call = getSQLDatosSimcard("VE_servicios_venta_quiosco_PG","VE_PreCarSimcard_NoPreLis_PR",15);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cat.debug("entrada.getCodigoArticulo(): " + entrada.getCodigoArticulo());
			cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
			cat.debug("entrada.getTipoStock(): " + entrada.getTipoStock());
			cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
			cat.debug("entrada.getCodigoUso(): " + entrada.getCodigoUso());
			cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
			cat.debug("entrada.getEstado(): " + entrada.getEstado());
			cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
			cat.debug("entrada.getModalidadVenta(): " + entrada.getModalidadVenta());
			cstmt.setInt(5,Integer.parseInt(entrada.getModalidadVenta()));
			cat.debug("entrada.getTipoContrato(): " + entrada.getTipoContrato());
			cstmt.setString(6,entrada.getTipoContrato());
			cat.debug("entrada.getPlanTarifario(): " + entrada.getPlanTarifario());
			cstmt.setString(7,entrada.getPlanTarifario());
			cat.debug("entrada.getIndiceRecambio(): " + entrada.getIndiceRecambio());
			cstmt.setString(8,entrada.getIndiceRecambio());
			cat.debug("entrada.getCodigoCategoria(): " + entrada.getCodigoCategoria());
			cstmt.setString(9,entrada.getCodigoCategoria());
			cat.debug("entrada.getCodigoUsoPrepago(): " + entrada.getCodigoUsoPrepago());
			cstmt.setString(10,entrada.getCodigoUsoPrepago());
			cat.debug("entrada.getIndicadorEquipo(): " + entrada.getIndicadorEquipo());
			cstmt.setString(11,entrada.getIndicadorEquipo());
			cstmt.registerOutParameter(12,OracleTypes.CURSOR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista:execute");
			cstmt.execute();
			cat.debug("Fin:getPrecioCargoSimcard_NoPrecioLista:execute");

			codError = cstmt.getInt(13);
			msgError = cstmt.getString(14);
			numEvento = cstmt.getInt(15);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)");
				throw new GeneralException(
						"Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)", String
						.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando el precio de cargo de la Simcard (No Precio Lista)");
				List lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(12);
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
				rs.close();
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), PrecioCargoDTO.class);
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw(e);
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
			"Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)",e);
		}finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getPrecioCargoSimcard_NoPrecioLista()");
		return resultado;
	}//fin getPrecioCargoSimcard_NoPrecioLista

	/**
	 * Busca todos los Descuentos tipo Articulo asociados a la simcard  
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getDescuentoCargoArticulo()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
			String call = getSQLDatosSimcard("VE_servicios_venta_quiosco_PG","VE_obtiene_descuento_art_PR",14);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("[getDescuentoCargoBasicoArticulo] cod operacion: " + entrada.getCodigoOperacion());
			cat.debug("[getDescuentoCargoBasicoArticulo] tipocontrato: " + entrada.getTipoContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] codigo antiguedad: " + entrada.getCodigoAntiguedad());
			cat.debug("[getDescuentoCargoBasicoArticulo] cod promedio: " + entrada.getCodigoPromedioFacturable());
			cat.debug("[getDescuentoCargoBasicoArticulo] estado: " + entrada.getEquipoEstado());
			cat.debug("[getDescuentoCargoBasicoArticulo] contrato: " + entrada.getTipoContrato());
			cat.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesNuevo());
			cat.debug("[getDescuentoCargoBasicoArticulo] cod articulo: " + entrada.getCodigoArticulo());
			cat.debug("[getDescuentoCargoBasicoArticulo] clase desc: " + entrada.getClaseDescuento());
			cstmt.setString(1,entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getTipoContrato());
			cstmt.setInt(3,entrada.getNumeroMesesContrato());
			cstmt.setString(4,entrada.getCodigoAntiguedad());
			cstmt.setString(5,entrada.getCodigoPromedioFacturable());
			cstmt.setString(6,entrada.getEquipoEstado());
			cstmt.setString(7,entrada.getTipoContrato());
			cstmt.setInt(8,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setString(9,entrada.getCodigoArticulo());
			cstmt.setString(10,entrada.getClaseDescuento());
			cstmt.registerOutParameter(11,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getDescuentoCargoArticulo:Execute");
			cstmt.execute();
			cat.debug("Fin:getDescuentoCargoArticulo:Execute");

			codError = cstmt.getInt(12);
			msgError = cstmt.getString(13);
			numEvento = cstmt.getInt(14);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo basico");
				throw new GeneralException(
						"Ocurrió un error al recuperar los descuentos del cargo basico", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando descuentos");
				List lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(11);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));

					lista.add(descuentoDTO);
					cat.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(4));
					cat.debug("[getDescuentoDescripcionConcepto] : " + rs.getString(2));
					cat.debug("[getDescuentoMonto]: " + rs.getFloat(3));
					cat.debug("[getCodigoConcepto]: " + rs.getString(4));

				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
				cat.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar los descuentos del cargo basico",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getDescuentoCargoArticulo()");

		return resultado;
	}//fin getDescuentoCargoArticulo


	/**
	 * Busca todos los Descuentos tipo concepto asociados a la simcard 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) throws GeneralException{
		cat.debug("Inicio:getDescuentoCargoConcepto()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",16);
			String call = getSQLDatosSimcard("VE_servicios_venta_quiosco_PG","VE_obtiene_descuento_con_PR",16);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getCodigoAntiguedad());
			cstmt.setString(3,entrada.getTipoContrato());
			cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
			cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
			cstmt.setString(7,entrada.getCodigoCausaDescuento());
			cstmt.setString(8,entrada.getCodigoCategoria());
			cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
			cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
			cstmt.setInt(11,Integer.parseInt(entrada.getConcepto()));
			cstmt.setString(12,entrada.getClaseDescuento());
			cstmt.registerOutParameter(13,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getInt(14);
			msgError = cstmt.getString(15);
			numEvento = cstmt.getInt(16);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo");
				throw new GeneralException(
						"Ocurrió un error al recuperar los descuentos del cargo", String
						.valueOf(codError), numEvento, msgError);

			}else{
				cat.debug("Recuperando descuentos");
				List lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(13);

				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));
					lista.add(descuentoDTO);
				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
				cat.debug("Fin recuperacion de descuentos del cargo");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar los descuentos del cargo",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar los descuentos del cargo",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getDescuentoCargoConcepto()");

		return resultado;
	}//fin getDescuentoCargoConcepto

	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = new DescuentoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
			String call = getSQLDatosSimcard("VE_servicios_venta_quiosco_PG","VE_consulta_cod_desc_manual_PR",6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoConcepto());
			cat.debug(" Codigo concepto: " + entrada.getCodigoConcepto());
			cstmt.setString(2,entrada.getTipoConcepto());
			cat.debug("Tipo concepto: " + entrada.getTipoConcepto());
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
			//-- control error
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError == 0) {
				resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
				cat.debug("Codigo Concepto Descuento: " + resultado.getCodigoConcepto());
			}else{
				cat.error("Ocurrió un error al recuperar el código de descuento manual");
				throw new GeneralException(
						"Ocurrió un error al recuperar el código de descuento manual", String
						.valueOf(codError), numEvento, msgError);
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}

		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar el código de descuento manual",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al recuperar el código de descuento manual",e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCodigoDescuentoManual()");

		return resultado;
	}//fin getCodigoDescuentoManual	

	/**
	 * Consulta si el numero de celular esta reservado correctamente
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ResultadoValidacionLogisticaDTO getNumeroReservadoOK(ParametrosValidacionLogisticaDTO entrada) 
	throws GeneralException{
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			cat.debug("Inicio:getNumeroReservadoOK");

			//INI-01 (AL) String call = getSQLDatosSimcard("VE_validacion_linea_PG","VE_numeroreservadoOK_PR",7);
			String call = getSQLDatosSimcard("VE_validacion_linea_quiosco_PG","VE_numeroreservadoOK_PR",7);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getNumeroCelular());
			cstmt.setString(2,entrada.getCodigoCliente());
			cstmt.setString(3,entrada.getCodigoVendedor());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getNumeroReservadoOK:execute");
			cstmt.execute();
			cat.debug("Fin:getNumeroReservadoOK:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al verificar si el numero de celular esta reservado correctamente");
				resultado.setResultadoBase(1);
			}else
				resultado.setResultadoBase(cstmt.getInt(4));

		
		} catch (Exception e) {
			cat.error("Ocurrió un error al verificar si el numero de celular esta reservado correctamente",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getNumeroReservadoOK");

		return resultado;
	}//fin getNumeroReservadoOK

	/**
	 * Obtiene el indicador de telefono 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public SimcardSNPNDTO getIndicadorTelefono(SimcardSNPNDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:getIndicadorTelefono()");
		SimcardSNPNDTO resultado = new SimcardSNPNDTO();
		resultado.setNumeroSerie(entrada.getNumeroSerie());
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_servicios_venta_PG","VE_obtiene_ind_telefono_PR",6);
			String call = getSQLDatosSimcard("VE_servicios_venta_quiosco_PG","VE_obtiene_ind_telefono_PR",6);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNumeroSerie());
			cstmt.setString(2,entrada.getIndicadorTelefono());// viene el indicador a descartar

			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getIndicadorTelefono:execute");
			cstmt.execute();
			cat.debug("Fin:getIndicadorTelefono:execute");
			if (codError == 0)
				resultado.setIndicadorTelefono(String.valueOf(cstmt.getInt(3))); // se carga el indicador encontrado
			else{
				cat.error("Ocurrió un error al verificar si el numero de celular esta reservado correctamente");
				throw new GeneralException(
						"Ocurrió un error al verificar si el numero de celular esta reservado correctamente", String
						.valueOf(codError), numEvento, msgError);
			}
			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al verificar si el numero de celular esta reservado correctamente",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getIndicadorTelefono()");
		return resultado;
	}//fin getIndicadorTelefono


	/**
	 * Valida autenticación de la serie 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public ProcesoDTO validaAutenticacionSerie(SimcardSNPNDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:validaAutenticacionSerie()");
		ProcesoDTO proceso = new ProcesoDTO();
		proceso.setCodigoError(0);
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_intermediario_PG","VE_valida_autentificacion_PR",6);
			String call = getSQLDatosSimcard("VE_intermediario_Quiosco_PG","VE_valida_autentificacion_PR",6);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNumeroSerie());
			cat.debug("getNumeroSerie: " + entrada.getNumeroSerie());
			cstmt.setString(2,entrada.getIndProcEq());
			cat.debug("getIndProcEq: " + entrada.getIndProcEq());
			cstmt.setString(3,entrada.getCodigoUso());
			cat.debug("getCodigoUso: " + entrada.getCodigoUso());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:validaAutenticacionSerie:execute");
			cstmt.execute();
			cat.debug("Fin:validaAutenticacionSerie:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError !=0){
				cat.debug("Ocurrió un error al valida Autenticacion Serie");
				throw new GeneralException(
						"Ocurrió un error al valida Autenticacion Serie", String
						.valueOf(codError), numEvento, msgError);
			}				

			proceso.setCodigoError(codError);
			cat.debug("codError: " + codError);
			cat.debug("msgError: " + msgError);
			proceso.setEvento(numEvento);
			proceso.setMensajeError(msgError);
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al realizar autenticación de la serie",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");								
			}
			throw new GeneralException(
					"Ocurrió un error al realizar autenticación de la serie", String
					.valueOf(codError), numEvento, msgError);	
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:validaAutenticacionSerie()");
		return proceso;
	}//fin validaAutenticacionSerie


	/**
	 * Obtiene imsi de la simcard, utilizado para isertar movimiento en centrales 
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public SimcardSNPNDTO getImsiSimcard(SimcardSNPNDTO simcard) 
	throws GeneralException{
		cat.debug("Inicio:getImsiSimcard()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			//INI-01 (AL) String call = getSQLDatosSimcard("VE_intermediario_PG","VE_obtiene_imsi_simcard_PR",6);
			String call = getSQLDatosSimcard("VE_intermediario_Quiosco_PG","VE_obtiene_imsi_simcard_PR",6);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,simcard.getNumeroSerie());
			cat.debug("simcard.getNumeroSerie() " + simcard.getNumeroSerie());
			cstmt.setString(2,simcard.getCodigoImsi());
			cat.debug("simcard.getCodigoImsi() " + simcard.getCodigoImsi());
			cat.debug("Inicio:getImsiSimcard:execute");
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getImsiSimcard:execute");
			cstmt.execute();
			cat.debug("Fin:getImsiSimcard:execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");


			if (codError != 0) {
				cat.error("Ocurrió un error al buscar el imsi de la simcard");
				throw new GeneralException(
						"Ocurrió un error al buscar el imsi de la simcard", String
						.valueOf(codError), numEvento, msgError);

			}else
				simcard.setValorImsi(cstmt.getString(3));
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al buscar el imsi de la simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getImsiSimcard()");
		return simcard;
	}//fin getImsiSimcard

	/**
	 * Actualiza stock simcard
	 * @param simcard
	 * @return
	 * @throws GeneralException
	 */
	public SimcardSNPNDTO actualizaStockSimcard(SimcardSNPNDTO simcard)
	throws GeneralException{
		SimcardSNPNDTO resultado = new SimcardSNPNDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		try {
			cat.debug("Inicio:actualizaStockSimcard");

			//INI-01 (AL) String call = getSQLDatosSimcard("VE_intermediario_PG","VE_actualiza_stock_PR",14);
			String call = getSQLDatosSimcard("VE_intermediario_Quiosco_PG","VE_actualiza_stock_PR",14);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,simcard.getTipoMovimiento());
			cstmt.setString(2,simcard.getTipoStock());
			cstmt.setString(3,simcard.getCodigoBodega());
			cstmt.setString(4,simcard.getCodigoArticulo());
			cstmt.setString(5,simcard.getCodigoUso());
			cstmt.setString(6,simcard.getEstado());
			cstmt.setString(7,simcard.getNumeroVenta());
			cstmt.setString(8,simcard.getNumeroSerie());
			cstmt.setString(9,simcard.getIndicadorTelefono());

			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.NUMERIC);

			for (int j = 0; j < 4; j++)
			{

				cat.debug("Inicio:actualizaStockSimcard:execute");
				cstmt.execute();
				cat.debug("Fin:actualizaStockSimcard:execute");

				codError  = cstmt.getInt(12);
				msgError  = cstmt.getString(13);
				numEvento = cstmt.getInt(14);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");


				if (codError != 1){
					break;
				}
				Thread.sleep(2000);      //DELAY 2 segundos   			          
			}

			if (codError != 0) {
				cat.debug("Ocurrió un error al actualiza Stock Simcard ");
				throw new GeneralException(
						"Ocurrió un error al buscar el imsi de la simcard", String
						.valueOf(codError), numEvento, msgError);

			}				

			resultado.setNumeroMovimiento(cstmt.getString(10));
			resultado.setIndSerConTel(cstmt.getString(11));
			resultado.setCodigoError(codError);

		} catch (GeneralException e) {
			throw (e);		
		} catch (Exception e) {
			cat.error("Ocurrió un error al actualizar stock simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:actualizaStockSimcard");
		return resultado;
	}//fin actualizaStockSimcard


	public SimcardSNPNDTO getSimcardAutomatico(SimcardSNPNDTO simcard) 
	throws GeneralException{
		cat.debug("Inicio:getSimcardAutomatico()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		SimcardSNPNDTO SimcardSNPNDTO = null;
		try {
			String call = getSQLDatosSimcard("VE_PORTABILIDAD_PG","ve_rec_icc_automatica_pr",8);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,simcard.getCodigoBodega());
			cstmt.setString(2,simcard.getTipoStock());
			cstmt.setString(3,simcard.getCodigoArticulo());
			cstmt.setString(4,simcard.getCodigoUso());
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSimcard:execute");
			cstmt.execute();
			cat.debug("Fin:getSimcard:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");


			if (codError == 0){
				SimcardSNPNDTO = new SimcardSNPNDTO();
				SimcardSNPNDTO.setNumeroSerie(cstmt.getString(5));
			}else{
				cat.error("Ocurrió un error al recuperar  simcard");
				throw new GeneralException(
						"Ocurrió un error al recuperar  simcard", String
						.valueOf(codError), numEvento, msgError);
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar  simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getSimcardAutomatico()");
		return SimcardSNPNDTO;
	}//fin getSimcard		

	
	public CargosSimcarPrepagoDTO[] getCargosSimcardPrepago() 
	throws GeneralException{
		cat.debug("Inicio:getSimcardAutomatico()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		CargosSimcarPrepagoDTO[] CargosSimcarPrepago = null ;
		CargosSimcarPrepagoDTO  CargoSimcarPrepago = null;
		try {
			String call = getSQLDatosSimcard("VE_PORTABILIDAD_PG","ve_rec_cargos_sim_pre_pr",4);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getCargosSimcardPrepago:execute");
			cstmt.execute();
			cat.debug("Fin:getCargosSimcardPrepago:execute");

			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
						
			if (codError != 0){
				cat.error("Ocurrió un error al recuperar los cargos para simcard prepago");
				throw new GeneralException(
						"Ocurrió un error al recuperar los cargos para simcard prepago", String
						.valueOf(codError), numEvento, msgError);
			}
			List lista = new ArrayList();
			ResultSet rs = (ResultSet) cstmt.getObject(1);

			while (rs.next()) {
				CargoSimcarPrepago = new CargosSimcarPrepagoDTO();
				
				CargoSimcarPrepago.setImpTarifa(new Float(rs.getFloat(1)).floatValue());
				CargoSimcarPrepago.setCodConcepto(rs.getString(2));
				CargoSimcarPrepago.setCodMoneda(rs.getString(3));				
				lista.add(CargoSimcarPrepago);
			}
			rs.close();			
			CargosSimcarPrepago =(CargosSimcarPrepagoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CargosSimcarPrepagoDTO.class);
			
			if (cat.isDebugEnabled()) {
				cat.debug("Finalizo ejecución");
				cat.debug("Recuperando salidas");
			}
			
		}catch (GeneralException e) {
			throw (e);	
		}catch (Exception e) {
			cat.error("Ocurrió un error al recuerpar los cargos para simcard prepago",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getCargosSimcardPrepago()");
		return CargosSimcarPrepago;
	}//fin getSimcard		
	
	
	public void setNumeracionSimPortada(SimcardSNPNDTO simcard) 
	throws GeneralException{
		cat.debug("Inicio:getSimcardAutomatico()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		SimcardSNPNDTO SimcardSNPNDTO = null;
		try {
			String call = getSQLDatosSimcard("VE_PORTABILIDAD_PG","VE_NUMERASERIE_PORTABILIDAD_PR",8);

			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,simcard.getNumeroSerie());
			cstmt.setString(2,simcard.getNumeroCelular());
			cstmt.setString(3,simcard.getCodigoCentral());
			cstmt.setString(4,simcard.getCodigoSubAlm());	
			cstmt.setString(5,simcard.getIndProcEq());
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			cat.debug("Inicio:getSimcard:execute");
			cstmt.execute();
			cat.debug("Fin:getSimcard:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);

			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");


			if (codError != 0){
				cat.error("Ocurrió un error al recuperar  simcard");
				throw new GeneralException(
						"Ocurrió un error al recuperar  simcard", String
						.valueOf(codError), numEvento, msgError);
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw (e);	
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar  simcard",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(e);
		} finally {
			if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getSimcardAutomatico()");
	}//fin getSimcard		
	
}//fin SimcardDAO



