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
 * 19/07/2007             Raúl Lozano      			     Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SimcardDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoSimcardRestitucionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class SimcardDAO extends ConnectionDAO implements SimcardDAOIT{
	private final Logger logger = Logger.getLogger(SimcardDAO.class);
	
		Global global = Global.getInstance();

		
				
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
				String call = getSQLDatosSimcard("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);

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
		}//fin getLargoSerieSimcard
		
		public SimcardDTO getSimcard(SimcardDTO simcard) 
		throws ProductException{
			logger.debug("Inicio:getSimcard()");
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {
				String call = getSQLDatosSimcard("PV_SERVICIOS_POSVENTA_PG","VE_consulta_serie_PR",18);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
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
				cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

				logger.debug("Inicio:getSimcard:execute");
				cstmt.execute();
				logger.debug("Fin:getSimcard:execute");

				codError = cstmt.getInt(16);
				msgError = cstmt.getString(17);
				numEvento = cstmt.getInt(18);
				logger.debug("msgError[" + msgError + "]");
				if (codError == 0){
					simcard.setCodigoBodega(String.valueOf(cstmt.getInt(2)));
					simcard.setEstado(String.valueOf(cstmt.getInt(3)));
					simcard.setIndicadorProgramado(String.valueOf(cstmt.getInt(4)));
					simcard.setNumeroCelular(String.valueOf(cstmt.getLong(5)));
					simcard.setCodigoUso(String.valueOf(cstmt.getInt(6)));
					simcard.setTipoStock(String.valueOf(cstmt.getInt(7)));
					simcard.setCodigoCentral(String.valueOf(cstmt.getInt(8)));
					simcard.setCodigoArticulo(String.valueOf(cstmt.getInt(9)));
					simcard.setCapCode(String.valueOf(cstmt.getInt(10)));
					simcard.setTipoArticulo(String.valueOf(cstmt.getInt(11)));
					simcard.setDescripcionArticulo(cstmt.getString(12));
					simcard.setCodigoSubAlm(cstmt.getString(13));
					simcard.setIndicadorValorar(cstmt.getString(14));
				}
				
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar Datos de la serie simcard",e);
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
			logger.debug("Fin:getSimcard()");
			return simcard;
		}//fin getSimcard

		public ResultadoValidacionLogisticaDTO existeSerieSimcard(ParametrosValidacionLogisticaDTO lineaEntrada) 
		throws ProductException{
			logger.debug("Inicio:existeSerieSimcard()");
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {
				String call = getSQLDatosSimcard("VE_validacion_linea_PG","VE_existeseriebodega_PR",5);
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
		}//fin existeSerieSimcard
		
		public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista(ParametrosCargoSimcardDTO entrada) 
		throws ProductException{
			logger.debug("Inicio:getPrecioCargoSimcard_PrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {
				String call = getSQLDatosSimcard("PV_SERVICIOS_POSVENTA_PG","VE_PrecCargoSimcard_PreLis_PR",10);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				
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
				
				logger.debug("Inicio:getPrecioCargoSimcard_PrecioLista:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoSimcard_PrecioLista:execute");

				codError = cstmt.getInt(8);
				msgError = cstmt.getString(9);
				numEvento = cstmt.getInt(10);
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Simcard (Precio Lista)");
					ArrayList lista = new ArrayList();
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
					
					logger.debug("precio cargos Simcard (Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (Precio Lista)",e);
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
			logger.debug("Fin:getPrecioCargoSimcard_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoSimcard_PrecioLista

		public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista(ParametrosCargoSimcardDTO entrada) 
		throws ProductException{
			logger.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {															 
				String call = getSQLDatosSimcard("PV_SERVICIOS_POSVENTA_PG","PV_PreCarSimcard_NoPreLis_PR",17);
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				cstmt = conn.prepareCall(call);
				logger.debug("Numero Abonado  ["+ entrada.getNumAbonado()+"]");
				logger.debug("Codigo Articulo ["+entrada.getCodigoArticulo()+"]");
				logger.debug("Tipo Stock      ["+entrada.getTipoStock()+"]");
				logger.debug("Codigo Uso      ["+entrada.getCodigoUso()+"]");
				logger.debug("Estado          ["+entrada.getEstado()+"]");
				logger.debug("Modalidad Venta ["+entrada.getModalidadVenta()+"]");
				logger.debug("Tipo Contrato   ["+entrada.getTipoContrato()+"]");
				logger.debug("Plan Tarifario  ["+entrada.getPlanTarifario()+"]");
				logger.debug("Indice Recambio ["+entrada.getIndiceRecambio()+"]");
				logger.debug("Codigo Categoria["+entrada.getCodigoCategoria()+"]");
				logger.debug("Uso Prepago     ["+entrada.getCodigoUsoPrepago()+"]");
				logger.debug("Indicador Equipo["+entrada.getIndicadorEquipo()+"]");
				logger.debug("param renova ["+entrada.getParamRenova()+"]");
				/**/
				//if(entrada.getCodigoCategoria() == null){entrada.setCodigoCategoria("ZZZ");
					//logger.debug("Prueba Codigo Categoria["+entrada.getCodigoCategoria()+"]");}
				/**/
				
						
				cstmt.setLong(1,entrada.getNumAbonado());
				cstmt.setInt(2,Integer.parseInt(entrada.getCodigoArticulo()));
				cstmt.setInt(3,Integer.parseInt(entrada.getTipoStock()));
				cstmt.setInt(4,Integer.parseInt(entrada.getCodigoUso()));
				cstmt.setInt(5,Integer.parseInt(entrada.getEstado()));
				cstmt.setInt(6,Integer.parseInt(entrada.getModalidadVenta()));
				cstmt.setString(7,entrada.getTipoContrato());
				cstmt.setString(8,entrada.getPlanTarifario());
				cstmt.setString(9,entrada.getIndiceRecambio());
				cstmt.setString(10,entrada.getCodigoCategoria());
				cstmt.setString(11,entrada.getCodigoUsoPrepago());
				cstmt.setString(12,entrada.getIndicadorEquipo());
				cstmt.setInt(13,Integer.parseInt(entrada.getParamRenova()));
				cstmt.registerOutParameter(14,OracleTypes.CURSOR);
				cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(16, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
				
				
				logger.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoSimcard_NoPrecioLista:execute");

				codError = cstmt.getInt(15);
				msgError = cstmt.getString(16);
				numEvento = cstmt.getInt(17);
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Simcard (No Precio Lista)");
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(14);
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
					
					logger.debug("precio cargos Simcard (No Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard (No Precio Lista)",e);
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
			logger.debug("Fin:getPrecioCargoSimcard_NoPrecioLista()");
			return resultado;
		}//fin getPrecioCargoSimcard_NoPrecioLista
		
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
			
			try {
				String call = getSQLDatosSimcard("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_descuento_art_PR",14);
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
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
				
				logger.debug("Inicio:getDescuentoCargoArticulo:Execute");
				cstmt.execute();
				logger.debug("Fin:getDescuentoCargoArticulo:Execute");
				
				codError = cstmt.getInt(12);
				msgError = cstmt.getString(13);
				numEvento = cstmt.getInt(14);

				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar los descuentos del cargo basico");
					throw new ProductException(
							"Ocurrió un error al recuperar los descuentos del cargo basico", String
									.valueOf(codError), numEvento, msgError);
					
				}else{
					logger.debug("Recuperando descuentos");
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(11);
					while (rs.next()) {
						DescuentoDTO descuentoDTO = new DescuentoDTO();
						descuentoDTO.setTipoAplicacion(rs.getString(1));
						descuentoDTO.setDescripcionConcepto(rs.getString(2));
						descuentoDTO.setMonto(rs.getFloat(3));
						descuentoDTO.setCodigoConcepto(rs.getString(4));
						
						lista.add(descuentoDTO);
						logger.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(4));
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
				String call = getSQLDatosSimcard("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_descuento_con_PR",18);
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
				cstmt = conn.prepareCall(call);
				
				logger.debug("[ParametrosDescuentoDTO] cod operacion: " +entrada.getCodigoOperacion());
				logger.debug("[ParametrosDescuentoDTO] cod antiguedad: " +entrada.getCodigoAntiguedad());
				logger.debug("[ParametrosDescuentoDTO] cod contrato nuevo: " +entrada.getCodigoContratoNuevo());
				logger.debug("[ParametrosDescuentoDTO] cod tipo contrato nuevo: " +entrada.getTipoContrato());
				logger.debug("[ParametrosDescuentoDTO] numero meses nuevo: " +Integer.parseInt(entrada.getNumeroMesesNuevo()));
				logger.debug("[ParametrosDescuentoDTO] ind venta externa: " +Integer.parseInt(entrada.getIndiceVentaExterna()));
				logger.debug("[ParametrosDescuentoDTO] cod vendedor: " +Long.parseLong(entrada.getCodigoVendedor()));
				logger.debug("[ParametrosDescuentoDTO] cod causa venta: " +entrada.getCodigoCausaVenta());
				logger.debug("[ParametrosDescuentoDTO] cod categoria: " +entrada.getCodigoCategoria());
				logger.debug("[ParametrosDescuentoDTO] cod modalidad venta: " +Integer.parseInt(entrada.getCodigoModalidadVenta()));
				logger.debug("[ParametrosDescuentoDTO] tip plan tarifario: " +Integer.parseInt(entrada.getTipoPlanTarifario()));
				logger.debug("[ParametrosDescuentoDTO] concepto: " + entrada.getConcepto());
				logger.debug("[ParametrosDescuentoDTO] cod concepto: " + entrada.getCodigoConcepto());				
				logger.debug("[ParametrosDescuentoDTO] clase descuento: " +entrada.getClaseDescuento());
				logger.debug("[ParametrosDescuentoDTO] param renova: " +entrada.getParamRenova());	
				logger.debug("[ParametrosDescuentoDTO] num abonado: " +entrada.getNumAbonado());
				
				cstmt.setString(1,entrada.getCodigoOperacion());
				cstmt.setString(2,entrada.getCodigoAntiguedad());
				cstmt.setString(3,entrada.getTipoContrato());
				cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
				cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
				cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
				cstmt.setString(7,entrada.getCodigoCausaVenta());
				cstmt.setString(8,entrada.getCodigoCategoria());
				cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
				cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
				cstmt.setInt(11,Integer.parseInt(entrada.getCodigoConcepto()));
				cstmt.setString(12,entrada.getClaseDescuento());
				cstmt.setInt(13,Integer.parseInt(entrada.getParamRenova()));
				cstmt.setLong(14,entrada.getNumAbonado());
				cstmt.registerOutParameter(15,OracleTypes.CURSOR);
				//-- control error
				cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
				
				cstmt.execute();
				
				codError = cstmt.getInt(16);
				msgError = cstmt.getString(17);
				numEvento = cstmt.getInt(18);
				logger.error("[codError]"+codError);
				logger.error("[msgError]"+msgError);
				logger.error("[numEvento]"+numEvento);

				if (codError != 0&&codError != 99) {
					logger.error("Ocurrió un error al recuperar los descuentos del cargo");
					throw new ProductException(
							"Ocurrió un error al recuperar los descuentos del cargo", String
									.valueOf(codError), numEvento, msgError);
					
				}else{ 
					logger.debug("Recuperando descuentos");
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(15);
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
					logger.debug("Fin recuperacion de descuentos del cargo [total descuentos]" + resultado.length);
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
				String call = getSQLDatosSimcard("PV_SERVICIOS_POSVENTA_PG","VE_consulta_cod_desc_manual_PR",6);
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
				String call = getSQLDatosSimcard("VE_validacion_linea_PG","VE_numeroreservadoOK_PR",7);

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
		public SimcardDTO getIndicadorTelefono(SimcardDTO entrada) 
		throws ProductException{
			logger.debug("Inicio:getIndicadorTelefono()");
			SimcardDTO resultado = new SimcardDTO();
			resultado.setNumeroSerie(entrada.getNumeroSerie());
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {
				String call = getSQLDatosSimcard("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_ind_telefono_PR",6);
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
		public ProcesoDTO validaAutenticacionSerie(SimcardDTO entrada) 
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
				String call = getSQLDatosSimcard("VE_intermediario_PG","VE_valida_autentificacion_PR",6);
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
		
		
		/**
		 * Obtiene imsi de la simcard, utilizado para isertar movimiento en centrales 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public SimcardDTO getImsiSimcard(SimcardDTO simcard) 
		throws ProductException{
			logger.debug("Inicio:getImsiSimcard()");
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {
				String call = getSQLDatosSimcard("VE_intermediario_PG","VE_obtiene_imsi_simcard_PR",6);
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
		}//fin getImsiSimcard
		
		/**
		 * Actualiza stock simcard
		 * @param simcard
		 * @return
		 * @throws ProductException
		 */
		public SimcardDTO actualizaStockSimcard(SimcardDTO simcard)
		throws ProductException{
			SimcardDTO resultado = new SimcardDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {
				logger.debug("Inicio:actualizaStockSimcard");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());	
				String call = getSQLDatosSimcard("VE_intermediario_PG","VE_actualiza_stock_PR",14);

				logger.debug("sql[" + call + "]");

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
				
				logger.debug("Inicio:actualizaStockSimcard:execute");
				cstmt.execute();
				logger.debug("Fin:actualizaStockSimcard:execute");

				codError  = cstmt.getInt(12);
				msgError  = cstmt.getString(13);
				numEvento = cstmt.getInt(14);

				resultado.setNumeroMovimiento(cstmt.getString(10));
				resultado.setIndSerConTel(cstmt.getString(11));
				resultado.setCodigoError(codError);
				
			} catch (Exception e) {
				logger.error("Ocurrió un error al actualizar stock simcard",e);
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
			logger.debug("Fin:actualizaStockSimcard");
			return resultado;
		}//fin actualizaStockSimcard
		
		/**
		 * permite obtener el precio lista de una simcard para restitucion 
		 * CSR11003
		 * @param entrada
		 * @return
		 * @throws ProductException
		 */
		public PrecioCargoDTO[] getPrecioCargoSimcard_PrecioLista_Rest(ParametrosCargoSimcardRestitucionDTO entrada) 
		throws ProductException{
			
			logger.debug("Inicio:getPrecioCargoSimcard_PrecioLista_Rest()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {
				String call = getSQLDatosSimcard("PV_CARGOS_PG","VE_PrecCargoSim_PreLis_Rest_PR",10);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				
				logger.debug("Numero Abonado  ["+ entrada.getNumAbonado()+"]");
				logger.debug("Tipo Stock      ["+entrada.getTipoStock()+"]");
				logger.debug("Codigo Uso      ["+entrada.getCodigoUso()+"]");
				logger.debug("Estado          ["+entrada.getEstado()+"]");
				logger.debug("Codigo Articulo ["+entrada.getCodigoArticulo()+"]");
				logger.debug("Modalidad Venta ["+entrada.getModalidadVenta()+"]");
				
				cstmt.setLong(1,entrada.getNumAbonado());
				cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
				cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
				cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
				cstmt.setInt(5,Integer.parseInt(entrada.getCodigoArticulo()));
				cstmt.setString(6,entrada.getModalidadVenta());
				
				cstmt.registerOutParameter(7,OracleTypes.CURSOR);
				cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:getPrecioCargoSimcard_PrecioLista_Rest:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoSimcard_PrecioLista_Rest:execute");

				codError = cstmt.getInt(8);
				msgError = cstmt.getString(9);
				numEvento = cstmt.getInt(10);
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard para Restitucion (Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo de la Simcard para Restitucion (Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Simcard para Restitucion (Precio Lista)");
					ArrayList lista = new ArrayList();
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
					
					logger.debug("precio cargos Simcard para restitucion (Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			}catch(ProductException e){
				throw e;
			
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard para Restitucion (Precio Lista)",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo de la Simcard para Restitucion (Precio Lista)", e);
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
			logger.debug("Fin:getPrecioCargoSimcard_PrecioLista_Rest()");
			return resultado;
		}

		/**
		 * permite obtener el precio no lista de un Simcard para restitucion
		 * CSR11003
		 * @param entrada
		 * @return
		 * @throws ProductException
		 */
		public PrecioCargoDTO[] getPrecioCargoSimcard_NoPrecioLista_Rest(ParametrosCargoSimcardRestitucionDTO entrada) 
		throws ProductException{
			
			logger.debug("Inicio:getPrecioCargoSimcard_NoPrecioLista_Rest()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			
			try {															 
				String call = getSQLDatosSimcard("PV_CARGOS_PG","PV_PreCarSim_NoPreLis_Rest_PR",10);
				logger.debug("sql[" + call + "]");
				
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				cstmt = conn.prepareCall(call);
				
				logger.debug("Numero Abonado  ["+ entrada.getNumAbonado()+"]");
				logger.debug("Tipo Stock      ["+entrada.getTipoStock()+"]");
				logger.debug("Codigo Uso      ["+entrada.getCodigoUso()+"]");
				logger.debug("Estado          ["+entrada.getEstado()+"]");
				logger.debug("Codigo Articulo ["+entrada.getCodigoArticulo()+"]");
				logger.debug("Modalidad Venta ["+entrada.getModalidadVenta()+"]");
				
						
				cstmt.setLong(1,entrada.getNumAbonado());
				cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
				cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
				cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
				cstmt.setInt(5,Integer.parseInt(entrada.getCodigoArticulo()));
				cstmt.setInt(6,Integer.parseInt(entrada.getModalidadVenta()));
				
				cstmt.registerOutParameter(7,OracleTypes.CURSOR);
				cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
				
				
				logger.debug("Inicio:PV_PreCarSim_NoPreLis_Rest_PR:execute");
				cstmt.execute();
				logger.debug("Fin:PV_PreCarSim_NoPreLis_Rest_PR:execute");

				codError = cstmt.getInt(8);
				msgError = cstmt.getString(9);
				numEvento = cstmt.getInt(10);
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard para Restitucion (No Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo de la Simcard para Restitucion (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Simcard para Restitucion (No Precio Lista)");
					ArrayList lista = new ArrayList();
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
					
					logger.debug("precio cargos Simcard para Restitucion (No Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			}catch(ProductException e){
				throw e;
				
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo de la Simcard para Restitucion (No Precio Lista)",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo de la Simcard para Restitucion (No Precio Lista)", e);
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
			logger.debug("Fin:PV_PreCarSim_NoPreLis_Rest_PR()");
			return resultado;
		}		

}//fin SimcardDAO

	

