package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.KitDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoKitDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.KitDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class KitDAO extends ConnectionDAO implements KitDAOIT{
	private final Logger logger = Logger.getLogger(SimcardDAO.class);

	Global global = Global.getInstance();



	private String getSQLDatosKit(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
		for (int n = 1; n <= paramCount; n++) {
			sb.append("?");
			if (n < paramCount) sb.append(",");
		}
		return sb.append(")}").toString();
	}//fin getSQLDatosSimcard

	/*public ResultadoValidacionLogisticaDTO getLargoSerieSimcard(ParametrosValidacionLogisticaDTO entrada) 
	throws ProductException{
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;

		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getLargoSerieSimcard");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLDatosKit("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNombreParametro());
			cstmt.setString(2,entrada.getCodigoModulo());
			cstmt.setString(3,entrada.getCodigoProducto());
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

		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar largo de la serie simcard",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getLargoSerieSimcard()");
		return resultado;
	}//fin getLargoSerieSimcard*/

	public KitDTO getKit(KitDTO kit) 
	throws GeneralException{
		logger.debug("Inicio:getkit()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			String call = getSQLDatosKit("ve_cargos_pg","VE_consulta_kit_PR",7);
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			logger.debug("kit.getNumeroSerie() [" + kit.getNumeroSerie() + "]");
			cstmt.setString(1,kit.getNumeroSerie());

			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);			
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getkit:execute");
			cstmt.execute();
			logger.debug("Fin:getkit:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);
			
			logger.debug("codError[" + codError + "]");
			logger.debug("msgError[" + msgError + "]");
			logger.debug("numEvento[" + numEvento + "]");
			
			
			
			if (codError == 0){
				
				kit.setTipoStock(String.valueOf(cstmt.getInt(2)));
				logger.debug("kit.setTipoStock[" + kit.getTipoStock() + "]");
				kit.setCodigoArticulo(String.valueOf(cstmt.getInt(3)));
				logger.debug("kit.setCodigoArticulo[" + kit.getCodigoArticulo() + "]");
				kit.setIndicadorValorar(cstmt.getString(4));
				logger.debug("kit.setIndicadorValorar[" + kit.getIndicadorValorar() + "]");
				
			}else {
				logger.error("Ocurrió un error al recuperar Datos del Kit");
				throw new GeneralException(msgError, String.valueOf(codError), numEvento, msgError);
			}

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar Datos del Kit",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getkit()");
		return kit;
	}//fin getkit

	/*	public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO lineaEntrada) 
	throws ProductException{
		logger.debug("Inicio:existeSerieSimcard()");
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			String call = getSQLDatosKit("VE_validacion_linea_PG","VE_existeseriebodega_PR",5);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
			cstmt.setString(1,lineaEntrada.getNumeroSerie());
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
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar Datos de la serie Simcard",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:existeSerieSimcard()");
		return resultado;
	}//fin existeSerieSimcard*/

	public PrecioCargoDTO[] getPrecioCargoKit_PrecioLista(ParametrosCargoKitDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getPrecioCargoKit_PrecioLista()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			String call = getSQLDatosKit("ve_cargos_pg","ve_preccargokit_prelis_pr",8);
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
			logger.debug("entrada.getCodigoArticulo() ["+entrada.getCodigoArticulo()+"]");
			cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
			logger.debug("entrada.getTipoStock() ["+entrada.getTipoStock()+"]");
			cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
			logger.debug("entrada.getCodigoUso() ["+entrada.getCodigoUso()+"]");
			cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
			logger.debug("entrada.getEstado() ["+entrada.getEstado()+"]");

			cstmt.registerOutParameter(5,OracleTypes.CURSOR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getPrecioCargoKit_PrecioLista:execute");
			cstmt.execute();
			logger.debug("Fin:getPrecioCargoKit_PrecioLista:execute");

			codError = cstmt.getInt(6);
			msgError = cstmt.getString(7);
			numEvento = cstmt.getInt(8);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del Kit (Precio Lista)");
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo del Kit (Precio Lista)", String
						.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando el precio de cargo del Kit (Precio Lista)");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(5);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					precioDTO.setCodigoConcepto(rs.getString(1));
					logger.debug("precioDTO.setCodigoConcepto ["+rs.getString(1)+"]");
					precioDTO.setDescripcionConcepto(rs.getString(2));
					logger.debug("precioDTO.setDescripcionConcepto ["+rs.getString(2)+"]");
					precioDTO.setMonto(rs.getFloat(3));
					logger.debug("precioDTO.setMonto ["+rs.getString(2)+"]");
					precioDTO.setCodigoMoneda(rs.getString(4));
					logger.debug("precioDTO.setCodigoMoneda ["+rs.getString(2)+"]");
					precioDTO.setDescripcionMoneda(rs.getString(5));
					logger.debug("precioDTO.setDescripcionMoneda ["+rs.getString(2)+"]");
					precioDTO.setValorMinimo(rs.getString(6)); 
					logger.debug("precioDTO.setValorMinimo ["+rs.getString(2)+"]");
					precioDTO.setValorMaximo(rs.getString(7));
					logger.debug("precioDTO.setValorMaximo ["+rs.getString(2)+"]");
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

				logger.debug("precio cargos Kit (Precio Lista)");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			logger.debug("GeneralException Kit DAO");			
			logger.debug("e.getDescripcionEvento()[" + e.getDescripcionEvento() + "]");
			logger.debug("e.getCodigo()[" + e.getCodigo() + "]");
			throw e;	
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar el precio de cargo del Kit (Precio Lista)",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getPrecioCargoKit_PrecioLista()");
		return resultado;
	}//fin getPrecioCargoKit_PrecioLista

	public PrecioCargoDTO[] getPrecioCargoKit_NoPrecioLista(ParametrosCargoKitDTO entrada) 
	throws ProductException{
		logger.debug("Inicio:getPrecioCargoKit_NoPrecioLista()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLDatosKit("ve_cargos_pg","ve_precarkit_noprelis_pr",13);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			logger.debug("entrada.getCodigoArticulo(): " + entrada.getCodigoArticulo());
			cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
			logger.debug("entrada.getTipoStock(): " + entrada.getTipoStock());
			cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
			logger.debug("entrada.getCodigoUso(): " + entrada.getCodigoUso());
			cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
			logger.debug("entrada.getEstado(): " + entrada.getEstado());
			cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
			logger.debug("entrada.getModalidadVenta(): " + entrada.getModalidadVenta());
			cstmt.setInt(5,Integer.parseInt(entrada.getModalidadVenta()));
			logger.debug("entrada.getTipoContrato(): " + entrada.getTipoContrato());
			cstmt.setString(6,entrada.getTipoContrato());
			logger.debug("entrada.getPlanTarifario(): " + entrada.getPlanTarifario());
			cstmt.setString(7,entrada.getPlanTarifario());
			logger.debug("entrada.getCodigoUsoPrepago(): " + entrada.getCodigoUsoPrepago());
			cstmt.setString(8,entrada.getCodigoUsoPrepago());
			logger.debug("entrada.getIndicadorEquipo(): " + entrada.getIndicadorEquipo());
			cstmt.setString(9,entrada.getIndicadorEquipo());
			cstmt.registerOutParameter(10,OracleTypes.CURSOR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getPrecioCargoKit_NoPrecioLista:execute");
			cstmt.execute();
			logger.debug("Fin:getPrecioCargoKit_NoPrecioLista:execute");

			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);
			logger.debug("msgError[" + msgError + "]");

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del kit (No Precio Lista)");
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo del Kit (No Precio Lista)", String
						.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando el precio de cargo del Kit (No Precio Lista)");
				List lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(10);
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
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (ProductException e) {
			throw(e);
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar el precio de cargo del Kit (No Precio Lista)",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
			"Ocurrió un error al recuperar el precio de cargo del Kit (No Precio Lista)");
		}finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getPrecioCargoKit_NoPrecioLista()");
		return resultado;
	}//fin getPrecioCargoKit_NoPrecioLista

	/**
	 * Busca todos los Descuentos tipo Articulo asociados a la simcard  
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) throws ProductException{
		logger.debug("Inicio:getDescuentoCargoArticulo()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		int codError_pos; 
		int msgError_pos;
		int numEvento_pos;
		int cursor_pos;
		String call;

		try {
			logger.debug("_AVC_SIMC");
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

			logger.debug("_AVC_");
			logger.debug(":::::::: NUEVOS REGISTROS ::::::::::::::");
			logger.debug("[getDescuentoCargoBasicoArticulo] CodigoCausaCambio  " + entrada.getCodigoCausaCambio());				
			logger.debug("[getDescuentoCargoBasicoArticulo] Codigo categoria: (IF NULO?):" + entrada.getCodigoCategoria());
			logger.debug("[getDescuentoCargoBasicoArticulo] Modalidad venta: " + entrada.getCodigoModalidadVenta());
			logger.debug("[getDescuentoCargoBasicoArticulo] t Plan tarif: " + entrada.getTipoPlanTarifario());
			logger.debug("[getDescuentoCargoBasicoArticulo] Nombre usuario: " + entrada.getNombreUsuario());


			call = getSQLDatosKit("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);
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
			cursor_pos = 11;
			codError_pos = 12; 
			msgError_pos = 13;
			numEvento_pos = 14;


			logger.debug("Inicio:getDescuentoCargoArticulo:Execute");
			cstmt.execute();
			logger.debug("Fin:getDescuentoCargoArticulo:Execute");

			codError = cstmt.getInt(codError_pos);
			msgError = cstmt.getString(msgError_pos);
			numEvento = cstmt.getInt(numEvento_pos);

			logger.error("_AVC_ SALIDAS PL");
			logger.error("Cod_Error: "+ codError);
			logger.error("Mensaje: " + msgError);

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar los descuentos del cargo basico");
				throw new ProductException(
						"Ocurrió un error al recuperar los descuentos del cargo basico", String
						.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(cursor_pos);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
					descuentoDTO.setMonto(rs.getFloat(3));
					descuentoDTO.setCodigoConcepto(rs.getString(4));

					lista.add(descuentoDTO);
					logger.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(1));
					logger.debug("[getDescuentoDescripcionConcepto] : " + rs.getString(2));
					logger.debug("[getDescuentoMonto]: " + rs.getFloat(3));
					logger.debug("[getCodigoConcepto]: " + rs.getString(4));

				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
				logger.debug("Fin recuperacion de descuentos del cargo basico");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al recuperar los descuentos del cargo basico",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getDescuentoCargoArticulo()");

		return resultado;
	}//fin getDescuentoCargoArticulo

	private String getSQLgetDescuentoCargoConcepto(){
		StringBuffer call = new StringBuffer();
		call.append("BEGIN "+ 
				"VE_servicios_venta_PG.VE_OBTIENE_DESCUENTO_CON_PR ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ? ); "+
		" END;");
		return call.toString();
	}

	/**
	 * Busca todos los Descuentos tipo concepto asociados a la simcard 
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) throws ProductException{
		logger.debug("Inicio:getDescuentoCargoConcepto()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			String call = getSQLgetDescuentoCargoConcepto();
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoOperacion());
			logger.debug("entrada.getCodigoOperacion() ["+entrada.getCodigoOperacion()+"]");
			cstmt.setString(2,entrada.getCodigoAntiguedad());
			logger.debug("entrada.getCodigoAntiguedad() ["+entrada.getCodigoAntiguedad()+"]");
			cstmt.setString(3,entrada.getTipoContrato());
			logger.debug("entrada.getTipoContrato() ["+entrada.getTipoContrato()+"]");
			cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			logger.debug("entrada.getNumeroMesesNuevo() ["+entrada.getNumeroMesesNuevo()+"]");
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
			logger.debug("entrada.getIndiceVentaExterna() ["+entrada.getIndiceVentaExterna()+"]");
			cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
			logger.debug("entrada.getCodigoVendedor() ["+entrada.getCodigoVendedor()+"]");
			cstmt.setString(7,entrada.getCodigoCausaDescuento());
			logger.debug("entrada.getCodigoCausaDescuento() ["+entrada.getCodigoCausaDescuento()+"]");
			cstmt.setString(8,entrada.getCodigoCategoria());
			logger.debug("entrada.getCodigoCategoria() ["+entrada.getCodigoCategoria()+"]");
			cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
			logger.debug("entrada.getCodigoModalidadVenta() ["+entrada.getCodigoModalidadVenta()+"]");
			cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
			logger.debug("entrada.getTipoPlanTarifario() ["+entrada.getTipoPlanTarifario()+"]");
			cstmt.setInt(11,Integer.parseInt(entrada.getConcepto()));
			logger.debug("entrada.getConcepto() ["+entrada.getConcepto()+"]");
			cstmt.setString(12,entrada.getClaseDescuento());
			logger.debug("entrada.getClaseDescuento() ["+entrada.getClaseDescuento()+"]");

			cstmt.registerOutParameter(13,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);

			cstmt.execute();

			codError = cstmt.getInt(14);
			msgError = cstmt.getString(15);
			numEvento = cstmt.getInt(16);

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar los descuentos del cargo");
				throw new ProductException(
						"Ocurrió un error al recuperar los descuentos del cargo", String
						.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Recuperando descuentos");
				List lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(13);

				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					logger.debug("descuentoDTO.setTipoAplicacion() ["+rs.getString(1)+"]");
					descuentoDTO.setDescripcionConcepto(rs.getString(2));
					logger.debug("descuentoDTO.setDescripcionConcepto ["+rs.getString(2)+"]");
					descuentoDTO.setMonto(rs.getFloat(3));
					logger.debug("descuentoDTO.setMonto ["+rs.getFloat(3)+"]");
					descuentoDTO.setCodigoConcepto(rs.getString(4));
					logger.debug("descuentoDTO.setCodigoConcepto( ["+rs.getString(4)+"]");
					lista.add(descuentoDTO);
				}
				rs.close();
				resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
				logger.debug("Fin recuperacion de descuentos del cargo");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los descuentos del cargo",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al recuperar los descuentos del cargo",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getDescuentoCargoConcepto()");

		return resultado;
	}//fin getDescuentoCargoConcepto

	/*	/**
	 * Busca todos los Descuentos tipo concepto asociados a la simcard 
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 *
	public DescuentoDTO[] getDescuentoCargoConceptoCol(ParametrosDescuentoDTO entrada) throws ProductException{
		logger.debug("Inicio:getDescuentoCargoConcepto()");
		DescuentoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		// INI INC-79469; COL; 18-03-2009; AVC
		int codError_pos; 
		int msgError_pos;
		int numEvento_pos;
		int cursor_pos;
		String call;
		// FIN INC-79469; COL; 18-03-2009; AVC

		try {

			if (entrada.getTipoContrato().equals("84")){
				entrada.setNumeroMesesContrato(12);
			}

			if (entrada.getTipoContrato().equals("82")){
				entrada.setNumeroMesesContrato(0);
			}

			logger.debug("entrada.getCodigoOperacion(): " + entrada.getCodigoOperacion());
			logger.debug("entrada.getCodigoAntiguedad(): " + entrada.getCodigoAntiguedad());
			logger.debug("entrada.getCodigoContratoNuevo(): " + entrada.getCodigoContratoNuevo());
			logger.debug("IN_SIM_entrada.getNumeroMesesContrato(): " + entrada.getNumeroMesesContrato());
			logger.debug("entrada.getNumeroMesesNuevo(): " + entrada.getNumeroMesesNuevo());
			logger.debug("entrada.getIndiceVentaExterna(): " + entrada.getIndiceVentaExterna());
			logger.debug("entrada.getCodigoVendedor(): " + entrada.getCodigoVendedor());
			logger.debug("entrada.getCodigoCausaVenta(): " + entrada.getCodigoCausaVenta());
			logger.debug("entrada.getCodigoCategoria(): " + entrada.getCodigoCategoria());
			logger.debug("entrada.getCodigoModalidadVenta(): " + entrada.getCodigoModalidadVenta());
			logger.debug("entrada.getTipoPlanTarifario(): " + entrada.getTipoPlanTarifario());
			logger.debug("entrada.getConcepto(): " + entrada.getConcepto());
			logger.debug("entrada.getClaseDescuento(): " + entrada.getClaseDescuento());

			// INI INC-79469; COL; 18-03-2009; AVC
			logger.debug("_AVC_");
			logger.debug(":::::::: NUEVOS REGISTROS ::::::::::::::");
			logger.debug("[getDescuentoCargoConcepto] getTipoContrato(): " + entrada.getCodigoContratoNuevo()); 
			logger.debug("[getDescuentoCargoConcepto] CodigoCausaCambio  " + entrada.getCodigoCausaCambio());				
			logger.debug("[getDescuentoCargoConcepto] Codigo categoria: (IF NULO?):" + entrada.getCodigoCategoria());
			logger.debug("[getDescuentoCargoConcepto] articulo:" + entrada.getCodigoArticulo());
			logger.debug("[getDescuentoCargoConcepto] Modalidad venta: " + entrada.getCodigoModalidadVenta());
		    logger.debug("[getDescuentoCargoConcepto] t Plan tarif: " + entrada.getTipoPlanTarifario());
			logger.debug("[getDescuentoCargoConcepto] Nombre usuario: " + entrada.getNombreUsuario());

			if (entrada.getTipoPlanTarifario()!=null){
				call =  getSQLDatosKit("PV_CAMBIO_SIMCARD_SB_PG", "PV_obtiene_descuento_art_PR", 14);
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
				cstmt = conn.prepareCall(call);
				cstmt.setString(1,entrada.getCodigoOperacion());					
				cstmt.setString(2,entrada.getCodigoContratoNuevo()); // cstmt.setString(2,entrada.getTipoContrato());
				cstmt.setInt(3,entrada.getNumeroMesesContrato());
				cstmt.setString(4, entrada.getNombreUsuario());  //cstmt.setString(4,entrada.getCodigoAntiguedad());
				cstmt.setString(5,entrada.getCodigoCategoria());  //cstmt.setString(5,entrada.getCodigoPromedioFacturable());
				cstmt.setInt(6, Integer.parseInt(entrada.getCodigoModalidadVenta())); //cstmt.setString(6,entrada.getEquipoEstado());
				cstmt.setInt(7, Integer.parseInt(entrada.getTipoPlanTarifario())); //cstmt.setString(7,entrada.getTipoContrato());
				cstmt.setInt(8, Integer.parseInt(entrada.getCodigoArticulo())); //cstmt.setInt(8,Integer.parseInt(entrada.getNumeroMesesNuevo()));
				cstmt.setInt(9, Integer.parseInt(entrada.getCodigoPromedioFacturable())); //cstmt.setString(9,entrada.getCodigoArticulo());
				cstmt.setString(10,entrada.getClaseDescuento());
				cstmt.registerOutParameter(11,OracleTypes.CURSOR);
				//-- control error
				cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
				cursor_pos = 11;
				codError_pos = 12; 
				msgError_pos = 13;
				numEvento_pos = 14;
			}else{
				call = getSQLDatosKit("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",16);
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
				cstmt = conn.prepareCall(call);

				cstmt.setString(1, entrada.getCodigoOperacion());
				cstmt.setString(2, entrada.getCodigoAntiguedad());
				cstmt.setString(3, entrada.getCodigoContratoNuevo());
				cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
				cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
				cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
				cstmt.setString(7,entrada.getCodigoCausaVenta());
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
				cursor_pos = 13;
				codError_pos = 14; 
				msgError_pos = 15;
				numEvento_pos = 16;
			}		


			cstmt.execute();

			codError = cstmt.getInt(codError_pos);
			msgError = cstmt.getString(msgError_pos);
			numEvento = cstmt.getInt(numEvento_pos);

			if (codError != 0&&codError != 99) {
				logger.error("Ocurrió un error al recuperar los descuentos del cargo");
				throw new ProductException(
						"Ocurrió un error al recuperar los descuentos del cargo", String
								.valueOf(codError), numEvento, msgError);

			}else{
				logger.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(cursor_pos);
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
				logger.debug("Fin recuperacion de descuentos del cargo");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar los descuentos del cargo",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al recuperar los descuentos del cargo",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getDescuentoCargoConcepto()");

		return resultado;
	}//fin getDescuentoCargoConcepto*/

	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) 
	throws ProductException{
		logger.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = new DescuentoDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			String call = getSQLDatosKit("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
			logger.debug("sql[" + call + "]");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getCodigoConcepto());
			logger.debug(" Codigo concepto: " + entrada.getCodigoConcepto());
			cstmt.setString(2,entrada.getTipoConcepto());
			logger.debug("Tipo concepto: " + entrada.getTipoConcepto());
			cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
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
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar el código de descuento manual",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al recuperar el código de descuento manual",e);
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
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
	 * @throws ProductException
	 */
	public ResultadoValidacionLogisticaDTO getNumeroReservadoOK(ParametrosValidacionLogisticaDTO entrada) 
	throws ProductException{
		ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			logger.debug("Inicio:getNumeroReservadoOK");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLDatosKit("VE_validacion_linea_PG","VE_numeroreservadoOK_PR",7);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getNumeroCelular());
			cstmt.setString(2,entrada.getCodigoCliente());
			cstmt.setString(3,entrada.getCodigoVendedor());
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);

			logger.debug("Inicio:getNumeroReservadoOK:execute");
			cstmt.execute();
			logger.debug("Fin:getNumeroReservadoOK:execute");

			codError = cstmt.getInt(5);
			msgError = cstmt.getString(6);
			numEvento = cstmt.getInt(7);;

			resultado.setResultadoBase(cstmt.getInt(4));

		} catch (Exception e) {
			logger.error("Ocurrió un error al verificar si el numero de celular esta reservado correctamente",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
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
	 * @throws ProductException
	 */
	public KitDTO getIndicadorTelefono(KitDTO entrada) 
	throws ProductException{
		logger.debug("Inicio:getIndicadorTelefono()");
		KitDTO resultado = new KitDTO();
		resultado.setNumeroSerie(entrada.getNumeroSerie());
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			String call = getSQLDatosKit("VE_servicios_venta_PG","VE_obtiene_ind_telefono_PR",6);
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNumeroSerie());
			cstmt.setString(2,entrada.getIndicadorTelefono());// viene el indicador a descartar

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
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar indicador de telefono de la simcard",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
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
	 * @throws ProductException
	 */
	public ProcesoDTO validaAutenticacionSerie(KitDTO entrada) 
	throws ProductException{
		logger.debug("Inicio:validaAutenticacionSerie()");
		ProcesoDTO proceso = new ProcesoDTO();
		proceso.setCodigoError(0);
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			String call = getSQLDatosKit("VE_intermediario_PG","VE_valida_autentificacion_PR",6);
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,entrada.getNumeroSerie());
			logger.debug("getNumeroSerie: " + entrada.getNumeroSerie());
			cstmt.setString(2,entrada.getIndProcEq());
			logger.debug("getIndProcEq: " + entrada.getIndProcEq());
			cstmt.setString(3,entrada.getCodigoUso());
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
		} catch (Exception e) {
			logger.error("Ocurrió un error al realizar autenticación de la serie",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:validaAutenticacionSerie()");
		return proceso;
	}//fin validaAutenticacionSerie


	/*/**
	 * Obtiene imsi de la simcard, utilizado para isertar movimiento en centrales 
	 * @param entrada
	 * @return resultado
	 * @throws ProductException
	 *
	public KitDTO getImsiSimcard(KitDTO simcard) 
	throws ProductException{
		logger.debug("Inicio:getImsiSimcard()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			String call = getSQLDatosKit("VE_intermediario_PG","VE_obtiene_imsi_simcard_PR",6);
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);

			cstmt.setString(1,simcard.getNumeroSerie());
			logger.debug("simcard.getNumeroSerie() " + simcard.getNumeroSerie());
			cstmt.setString(2,simcard.getCodigoImsi());
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
				throw new ProductException(
						"Ocurrió un error al buscar el imsi de la simcard", String
								.valueOf(codError), numEvento, msgError);

			}else
				simcard.setValorImsi(cstmt.getString(3));
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al buscar el imsi de la simcard",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getImsiSimcard()");
		return simcard;
	}//fin getImsiSimcard*/

	/**
	 * Actualiza stock simcard
	 * @param simcard
	 * @return
	 * @throws ProductException
	 */
	public KitDTO actualizaStockKit(KitDTO kit)
	throws ProductException{
		KitDTO resultado = new KitDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;

		try {
			logger.debug("Inicio:actualizaStockKit");
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
			String call = getSQLDatosKit("VE_intermediario_PG","VE_actualiza_stock_PR",14);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);

			cstmt.setString(1,kit.getTipoMovimiento());
			cstmt.setString(2,kit.getTipoStock());
			cstmt.setString(3,kit.getCodigoBodega());
			cstmt.setString(4,kit.getCodigoArticulo());
			cstmt.setString(5,kit.getCodigoUso());
			cstmt.setString(6,kit.getEstado());
			cstmt.setLong(7,kit.getNumeroVenta());
			cstmt.setString(8,kit.getNumeroSerie());
			cstmt.setString(9,kit.getIndicadorTelefono());

			cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(14,java.sql.Types.NUMERIC);

			logger.debug("Inicio:actualizaStockKit:execute");
			cstmt.execute();
			logger.debug("Fin:actualizaStockKit:execute");

			codError  = cstmt.getInt(12);
			msgError  = cstmt.getString(13);
			numEvento = cstmt.getInt(14);

			resultado.setNumeroMovimiento(cstmt.getString(10));
			resultado.setIndSerConTel(cstmt.getString(11));
			resultado.setCodigoError(codError);

		} catch (Exception e) {
			logger.error("Ocurrió un error al actualizar stock Kit",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
			if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:actualizaStockKit");
		return resultado;
	}//fin actualizaStockKit


}//fin SimcardDAO



