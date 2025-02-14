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
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.TerminalDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoTerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoTerminalRestitucionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class TerminalDAO extends ConnectionDAO implements TerminalDAOIT{
	
	
	private final Logger logger = Logger.getLogger(TerminalDAO.class);
		Global global = Global.getInstance();
		
		/*private Connection getConection() throws ProductException {
			Connection conn = null;
			try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} catch (Exception e1) {
				conn = null;
				logger.error(" No se pudo obtener una conexión ", e1);
				throw new ProductException("No se pudo obtener una conexión", e1);
			}
			return conn;*/
		//}//fin getConection
		
		private String getSQLDatosTerminal(String packageName, String procedureName, int paramCount)
		{
			StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
	        for (int n = 1; n <= paramCount; n++) {
	            sb.append("?");
	            if (n < paramCount) sb.append(",");
	        }
	        return sb.append(")}").toString();
		}//fin getSQLDatosTerminal

		/*public ResultadoValidacionLogisticaDTO getLargoSerieTerminal(ParametrosValidacionLogisticaDTO entrada) 
		throws ProductException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				logger.debug("Inicio:getLargoSerieTerminal");

				String call = getSQLDatosTerminal("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);

				logger.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,entrada.getNombreParametro());
				cstmt.setString(2,entrada.getCodigoModulo());
				cstmt.setString(3,entrada.getCodigoProducto());
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:getLargoSerieTerminal:execute");
				cstmt.execute();
				logger.debug("Fin:getLargoSerieTerminal:execute");

				msgError = cstmt.getString(6);
				logger.debug("msgError[" + msgError + "]");
			
				resultado.setLargoSerie(cstmt.getInt(4));
			
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar largo de la serie terminal",e);
				if (cat.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
			} finally {
			 	if (cat.isDebugEnabled()) 
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
			logger.debug("Fin:TerminalO:getLargoSerieTerminal()");
			return resultado;
		}//fin getLargoSerieTerminal*/

		public TerminalDTO getTerminal(TerminalDTO entrada)	throws ProductException{
			logger.debug("Inicio:getTerminal()");
			TerminalDTO resultado = new TerminalDTO();
			resultado.setNumeroSerie(entrada.getNumeroSerie());
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","VE_consulta_serie_PR",18);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);

				cstmt.setString(1,entrada.getNumeroSerie());
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

				logger.debug("Inicio:getTerminal:execute");
				cstmt.execute();
				logger.debug("Fin:getTerminal:execute");
				
				codError = cstmt.getInt(16);
				msgError = cstmt.getString(17);
				numEvento = cstmt.getInt(18);
				logger.debug("msgError[" + msgError + "]");
				if (codError==0)
				{
					resultado.setCodigoBodega(String.valueOf(cstmt.getInt(2)));
					resultado.setEstado(String.valueOf(cstmt.getInt(3)));
					resultado.setIndicadorProgramado(String.valueOf(cstmt.getInt(4)));
					resultado.setNumeroCelular(String.valueOf(cstmt.getLong(5)));
					resultado.setCodigoUso(String.valueOf(cstmt.getInt(6)));
					resultado.setTipoStock(String.valueOf(cstmt.getInt(7)));
					resultado.setCodigoCentral(String.valueOf(cstmt.getInt(8)));
					resultado.setCodigoArticulo(String.valueOf(cstmt.getInt(9)));
					resultado.setCapCode(String.valueOf(cstmt.getInt(10)));
					resultado.setTipoArticulo(String.valueOf(cstmt.getInt(11)));
					resultado.setDescripcionArticulo(cstmt.getString(12));
					resultado.setCodigoSubAlm(cstmt.getString(13));
					resultado.setIndicadorValorar(cstmt.getString(14));
					resultado.setIndProcEq(entrada.getProcedenciaInterna());
					
					logger.debug("Codigo de Bodega[" + resultado.getCodigoBodega() + "]");
				}
				else
					resultado.setIndProcEq(entrada.getProcedenciaExterna());
				
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar Datos de la serie terminal",e);
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
			logger.debug("Fin:getTerminal()");
			return resultado;
		}//fin getTerminal*/
	
	/*	public ResultadoValidacionLogisticaDTO existeSerieTerminal(ParametrosValidacionLogisticaDTO lineaEntrada) 
		throws ProductException{
			logger.debug("Inicio:existeSerieTerminal()");
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("VE_validacion_linea_PG","VE_existeseriebodega_PR",5);
				logger.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cstmt.setString(1,lineaEntrada.getNumeroSerieTerminal());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:existeSerieTerminal:execute");
				cstmt.execute();
				logger.debug("Fin:existeSerieTerminal:execute");
				
				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				logger.debug("msgError[" + msgError + "]");
				resultado.setResultadoBase(cstmt.getInt(2));
								
				if (cat.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar Datos de la serie terminal",e);
				if (cat.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
			} finally {
			 	if (cat.isDebugEnabled()) 
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
			logger.debug("Fin:existeSerieTerminal()");
			return resultado;
		}//fin existeSerieTerminal*/

		public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws ProductException{
			logger.debug("Inicio:getPrecioCargoTerminal_PrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","VE_PrecCargoTerminal_PreLis_PR",10);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
				logger.debug("entrada.getCodigoArticulo(): " + entrada.getCodigoArticulo());
				cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
				logger.debug("entrada.getTipoStock(): " + entrada.getTipoStock());
				cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
				logger.debug("entrada.getCodigoUso(): " + entrada.getCodigoUso());
				cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
				logger.debug("entrada.getEstado(): " + entrada.getEstado());
				cstmt.setInt(5,Integer.parseInt(entrada.getIndiceRecambio()));
				logger.debug("entrada.getIndiceRecambio(): " + entrada.getIndiceRecambio());
				cstmt.setString(6,entrada.getCodigoCategoria());
				logger.debug("entrada.getCodigoCategoria(): " + entrada.getCodigoCategoria());
				cstmt.registerOutParameter(7,OracleTypes.CURSOR);
				cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:getPrecioCargoTerminal_PrecioLista:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_PrecioLista:execute");

				codError = cstmt.getInt(8);
				msgError = cstmt.getString(9);
				numEvento = cstmt.getInt(10);
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo del Terminal (Precio Lista)");
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
					
					logger.debug("precio cargos del Terminal (Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)",e);
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
			logger.debug("Fin:getPrecioCargoTerminal_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_PrecioLista

		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws ProductException{
			logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				logger.debug("CodigoArticulo    ["+entrada.getCodigoArticulo()+"]");
				logger.debug("TipoStock         ["+entrada.getTipoStock()+"]");
				logger.debug("CodigoUso         ["+entrada.getCodigoUso()+"]");
				logger.debug("Estado            ["+entrada.getEstado()+"]");
				logger.debug("Modalidad Venta   ["+entrada.getModalidadVenta()+"]");
				logger.debug("Tipo Contrato     ["+entrada.getTipoContrato()+"]");
				logger.debug("Plan Tarifario    ["+entrada.getPlanTarifario()+"]");
				logger.debug("Indice Recambio   ["+entrada.getIndiceRecambio()+"]");
				logger.debug("Codigo Categoria  ["+entrada.getCodigoCategoria()+"]");
				logger.debug("Codigo Uso Prepago["+entrada.getCodigoUsoPrepago()+"]");
				logger.debug("Indicador Equipo  ["+entrada.getIndicadorEquipo()+"]");				
				
				if (entrada.getParamRenova() != null && entrada.getParamRenova().equals("1")){
					logger.debug("CON RENOVACION");
					logger.debug("entrada.getParamRenova(): "+entrada.getParamRenova());
					// INI P-MIX-09003 OCB;
			        // Solo si es invocada desde la OOSS Renovación
			       	//String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","VE_PreCarTerminalrenova_NoPreLis_PR",16);
																				//PV_PrecCargTermren_NoPreLis_PR 		
			       	String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","PV_PrecCargTermren_NoPreLis_PR",16);
			       	                          
					conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
					logger.debug("sql[" + call + "]");
					cstmt = conn.prepareCall(call);
		        }else {
					logger.debug("entrada.getParamRenova(): "+entrada.getParamRenova());
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista). El Parametro de renovacion en null", String
									.valueOf(codError), numEvento, msgError);
				}				
						
				cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
				cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
				cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
				cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
				cstmt.setInt(5,Integer.parseInt(entrada.getModalidadVenta()));
				cstmt.setString(6,entrada.getTipoContrato());
				cstmt.setString(7,entrada.getPlanTarifario());
				cstmt.setInt(8,Integer.parseInt(entrada.getIndiceRecambio()));
				cstmt.setString(9,entrada.getCodigoCategoria());
				cstmt.setString(10,entrada.getCodigoUsoPrepago());
				cstmt.setString(11,entrada.getIndicadorEquipo());
				
				
				if (entrada.getParamRenova() != null){
			        	// INI P-MIX-09003 OCB;
			            // Solo si es invocada desde la OOSS Renovación
			        cstmt.setLong(12,entrada.getNumAbonado());
					logger.debug("entrada.getNumAbonado(): " + entrada.getNumAbonado());
			        	
			        cstmt.registerOutParameter(13,OracleTypes.CURSOR);
					cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(15, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			   } else {			        
					cstmt.registerOutParameter(12,OracleTypes.CURSOR);
					cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
					cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
					cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
				}	
				
				
				
				logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista:execute");

				
				if (entrada.getParamRenova() != null)
				{
					codError = cstmt.getInt(14);
					msgError = cstmt.getString(15);
					numEvento = cstmt.getInt(16);
		     	}		
				else{
					
					codError = cstmt.getInt(13);
					msgError = cstmt.getString(14);
					numEvento = cstmt.getInt(15);
				}
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Terminal (No Precio Lista)");
					ArrayList lista = new ArrayList();
					ResultSet rs = null;
					
					if (entrada.getParamRenova() != null){
						rs = (ResultSet) cstmt.getObject(13);
					}
					else
					{
						rs = (ResultSet) cstmt.getObject(12);	
					}
					
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
					
					logger.debug("precio cargos Terminal (No Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)",e);
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
			logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_NoPrecioLista

		/**
		 * Busca todos los Descuentos tipo Articulo asociados al Terminal 
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
				String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_descuento_art_PR",14);
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
						"Ocurrió un error al recuperar los descuentos del cargo basico",String
						.valueOf(codError), numEvento, msgError);
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
		}//fin getDescuentoCargoArticulo*/
		
		
		/**
		 * Busca todos los Descuentos tipo concepto asociados al Terminal 
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
				String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_descuento_con_PR",18);
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
				String loge = StackTraceUtl.getStackTrace(e);
				logger.error(e);
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
		}//fin getDescuentoCargoConcepto	*/

		
		/**
		 * Obtiene Codigo Concepto Facturable del descuento manual 
		 * @param entrada
		 * @return resultado
		 * @throws ProductException
		 */
		public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException{
			logger.debug("Inicio:getCodigoDescuentoManual()");
			DescuentoDTO resultado = new DescuentoDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","VE_consulta_cod_desc_manual_PR",6);
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,entrada.getCodigoConcepto());
				cstmt.setString(2,entrada.getTipoConcepto());
				cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
				//-- control error
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
				
				cstmt.execute();
				
				codError = cstmt.getInt(4);
				msgError = cstmt.getString(5);
				numEvento = cstmt.getInt(6);

				if (codError == 0) 
					resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
				
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
		}//fin getCodigoDescuentoManual	*/

		public ResultadoValidacionLogisticaDTO verificaRechazoSerie (ParametrosValidacionLogisticaDTO lineaEntrada) 
		throws ProductException{
			logger.debug("Inicio:verificaRechazoSerie()");
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLDatosTerminal("VE_validacion_linea_PG","VE_verifica_rechazo_serie_PR",5);
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				cstmt = conn.prepareCall(call);
				cstmt.setString(1,lineaEntrada.getNumeroSerieTerminal());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				logger.debug("Inicio:verificaRechazoSerie:execute");
				cstmt.execute();
				logger.debug("Fin:verificaRechazoSerie:execute");
				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				int res = cstmt.getInt(2);
				resultado.setResultadoBase(res);	
			} 
			catch (Exception e) {
				logger.error("Ocurrió un error al consultar si la serie fue rechazada",e);
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
			logger.debug("Fin:verificaRechazoSerie()");
			return resultado;
		}//fin existeSerieTerminal
		
		/**
		 * Actualiza stock terminal
		 * @param terminal
		 * @return
		 * @throws ProductException
		 */
	/*	public TerminalDTO actualizaStockTerminal(TerminalDTO terminal)
		throws ProductException{
			TerminalDTO resultado = new TerminalDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				logger.debug("Inicio:actualizaStockTerminal");
				
				String call = getSQLDatosTerminal("VE_intermediario_PG","VE_actualiza_stock_PR",14);

				logger.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);

				cstmt.setString(1,terminal.getTipoMovimiento());
				cstmt.setString(2,terminal.getTipoStock());
				cstmt.setString(3,terminal.getCodigoBodega());
				cstmt.setString(4,terminal.getCodigoArticulo());
				cstmt.setString(5,terminal.getCodigoUso());
				cstmt.setString(6,terminal.getEstado());
				cstmt.setString(7,terminal.getNumeroVenta());
				cstmt.setString(8,terminal.getNumeroSerie());
				cstmt.setString(9,terminal.getIndicadorTelefono());

				cstmt.registerOutParameter(10,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(11,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(12,java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(13,java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(14,java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:actualizaStockTerminal:execute");
				cstmt.execute();
				logger.debug("Fin:actualizaStockTerminal:execute");

				codError  = cstmt.getInt(12);
				msgError  = cstmt.getString(13);
				numEvento = cstmt.getInt(14);

				resultado.setNumeroMovimiento(cstmt.getString(10));
				resultado.setIndSerConTel(cstmt.getString(11));
				resultado.setCodigoError(codError);
				
			} catch (Exception e) {
				logger.error("Ocurrió un error al actualizar stock terminal",e);
				if (cat.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
			} finally {
			 	if (cat.isDebugEnabled()) 
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
			logger.debug("Fin:actualizaStockTerminal");
			return resultado;
		}//fin actualizaStockTerminal*/
		
		/**
		 * Obtiene estado anterior de la serie
		 * @param terminal
		 * @return resultado
		 * @throws ProductException
		 */
	/*	public TerminalDTO getEstadoAnterior(TerminalDTO entrada) 
		throws ProductException{
			logger.debug("Inicio:getEstadoAnterior()");
			TerminalDTO resultado = new TerminalDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","VE_consulta_estant_serie_PR",5);
				
				logger.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);

				cstmt.setString(1,entrada.getNumeroSerie());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

				logger.debug("Inicio:getEstadoAnterior:execute");
				cstmt.execute();
				logger.debug("Fin:getEstadoAnterior:execute");
				
				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);

				resultado.setEstadoAnterior(String.valueOf(cstmt.getInt(2)));
				
				if (cat.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar estado anterior de la serie del terminal",e);
				if (cat.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
			} finally {
			 	if (cat.isDebugEnabled()) 
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
			logger.debug("Fin:getEstadoAnterior()");
			return resultado;
		}//fin getEstadoAnterior*/
		
		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista_PV(ParametrosCargoTerminalDTO entrada) 
		throws ProductException{
			logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista_PV()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLDatosTerminal("PV_SERVICIOS_POSVENTA_PG","pv_precarterminal_noprelis_pr",12);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				logger.debug("Numero Abonado ["+entrada.getNumAbonado()+"]");
				logger.debug("CodigoArticulo["+entrada.getCodigoArticulo()+"]");
				logger.debug("TipoStock["+entrada.getTipoStock()+"]");
				logger.debug("CodigoUso["+entrada.getCodigoUso()+"]");
				logger.debug("Estado["+entrada.getEstado()+"]");
				logger.debug("Modalidad Venta["+entrada.getModalidadVenta()+"]");
				logger.debug("Tipo Contrato["+entrada.getTipoContrato()+"]");
				logger.debug("Plan Tarifario ["+entrada.getPlanTarifario()+"]");
				
				
				cstmt.setLong(1,entrada.getNumAbonado());
				cstmt.setInt(2,Integer.parseInt(entrada.getCodigoArticulo()));
				cstmt.setInt(3,Integer.parseInt(entrada.getTipoStock()));
				cstmt.setInt(4,Integer.parseInt(entrada.getCodigoUso()));
				cstmt.setInt(5,Integer.parseInt(entrada.getEstado()));
				cstmt.setInt(6,Integer.parseInt(entrada.getModalidadVenta()));
				cstmt.setString(7,entrada.getTipoContrato());
				cstmt.setString(8,entrada.getPlanTarifario());
				cstmt.registerOutParameter(9,OracleTypes.CURSOR);
				cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(11, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista_PV:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista_PV:execute");

				codError = cstmt.getInt(10);
				msgError = cstmt.getString(11);
				numEvento = cstmt.getInt(12);
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Terminal (No Precio Lista)");
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(9);
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
					
					logger.debug("precio cargos Terminal (No Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			}catch(ProductException e){
				throw e;
			} 
			catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)", e);
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
			logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista_PV()");
			return resultado;
		}//fin getPrecioCargoTerminal_NoPrecioLista
		
		/**
		 * para obtener el precio lista de una terminal para restitucion
		 * @param entrada
		 * @return
		 * @throws ProductException
		 */
		public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista_Rest(ParametrosCargoTerminalRestitucionDTO entrada) 
		throws ProductException{
			logger.debug("Inicio:getPrecioCargoTerminal_PrecioLista_Rest()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLDatosTerminal("PV_CARGOS_PG","PV_List_Prec_List_Rest_PR",14);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				
				logger.debug("entrada.getTipoStock(): " + entrada.getTipoStock());
				if(entrada.getTipoStock() != null ){
					cstmt.setInt(1,Integer.parseInt(entrada.getTipoStock()));
				}else{
					cstmt.setNull(1, java.sql.Types.NUMERIC);
				}
				
				logger.debug("entrada.getCodigoArticulo(): " + entrada.getCodigoArticulo());
				if(entrada.getCodigoArticulo() != null){
					cstmt.setInt(2,Integer.parseInt(entrada.getCodigoArticulo()));
				}else{
					cstmt.setNull(2, java.sql.Types.NUMERIC);
				}
				
				logger.debug("entrada.getNumeroSerie(): " + entrada.getNumeroSerie());
				cstmt.setString(3,entrada.getNumeroSerie());
				
				logger.debug("entrada.getCodigoUso(): " + entrada.getCodigoUso());
				if(entrada.getCodigoUso() != null ){
					cstmt.setInt(4,Integer.parseInt(entrada.getCodigoUso()));
				}else{
					cstmt.setNull(4, java.sql.Types.NUMERIC);
				}
				
				logger.debug("entrada.getEstado(): " + entrada.getEstado());
				if(entrada.getEstado() != null ){
					cstmt.setInt(5,Integer.parseInt(entrada.getEstado()));
				}else{
					cstmt.setNull(5, java.sql.Types.NUMERIC);
				}
				
				logger.debug("entrada.getNumAbonado(): " + entrada.getNumAbonado());
				cstmt.setLong(6,entrada.getNumAbonado());
				
				logger.debug("entrada.getCodigoAntiguedad(): " + entrada.getCodigoAntiguedad());
				if(entrada.getCodigoAntiguedad() != null){
					cstmt.setInt(7,entrada.getCodigoAntiguedad().intValue());
				}else{
					cstmt.setNull(7, java.sql.Types.NUMERIC);
				}
				
				logger.debug("entrada.getModalidadVenta(): " + entrada.getModalidadVenta());
				if(entrada.getModalidadVenta() != null){
					cstmt.setInt(8,Integer.parseInt(entrada.getModalidadVenta()));
				}else{
					cstmt.setNull(8, java.sql.Types.NUMERIC);
				}
				
				logger.debug("entrada.getNumMeses(): " + entrada.getNumMeses());
				if(entrada.getNumMeses() != null){
					cstmt.setInt(9,entrada.getNumMeses().intValue());
				}else{
					cstmt.setNull(9, java.sql.Types.NUMERIC);
				}
				
				logger.debug("entrada.getNombreUsuario(): " + entrada.getNombreUsuario());
				cstmt.setString(10, entrada.getNombreUsuario());
				
				cstmt.registerOutParameter(11,OracleTypes.CURSOR);
				cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:getPrecioCargoTerminal_PrecioLista_Rest:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_PrecioLista_Rest:execute");

				codError = cstmt.getInt(12);
				msgError = cstmt.getString(13);
				numEvento = cstmt.getInt(14);
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo del Terminal para Restitucion (Precio Lista)");
					
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(11);
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
					
					logger.debug("precio cargos del Terminal (Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			
			}catch(ProductException e){
				throw e;	
				
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Precio Lista)",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Deducible)", e);
				
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
			logger.debug("Fin:getPrecioCargoTerminal_PrecioLista_Rest()");
			return resultado;
		}//fin getPrecioCargoTerminal_PrecioLista_Rest		
		
		/**
		 * permite obtener el precio no lista con renovacion para restitucion
		 * @param entrada
		 * @return
		 * @throws ProductException
		 */
		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista_Rest(ParametrosCargoTerminalRestitucionDTO entrada) 
		throws ProductException{
			
			logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista_Rest()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				logger.debug("TipoStock         ["+entrada.getTipoStock()+"]");
				logger.debug("CodigoArticulo    ["+entrada.getCodigoArticulo()+"]");
				logger.debug("NumeroSerie       ["+entrada.getNumeroSerie()+"]");
				logger.debug("CodigoUso         ["+entrada.getCodigoUso()+"]");
				logger.debug("Estado            ["+entrada.getEstado()+"]");
				logger.debug("NumeroAboando     ["+entrada.getNumAbonado()+"]");
				logger.debug("CodigoAntiguedad  ["+entrada.getCodigoAntiguedad()+"]");
				logger.debug("Modalidad Venta   ["+entrada.getModalidadVenta()+"]");
				logger.debug("NumeroMeses       ["+entrada.getNumMeses()+"]");
				logger.debug("PromocionCelular  ["+entrada.getPromoCelular()+"]");
				logger.debug("NombreUsuario     ["+entrada.getNombreUsuario()+"]");
				logger.debug("ParamRenova     ["+entrada.getParamRenova()+"]");
				logger.debug("entrada.getParamRenova(): "+entrada.getParamRenova());
				
		       	String call = getSQLDatosTerminal("PV_CARGOS_PG","PV_PrecTerRen_NoPreLis_Rest_PR",15);
		       	                          
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				
				if(entrada.getTipoStock() != null){
					cstmt.setInt(1,Integer.parseInt(entrada.getTipoStock()));
				}else{
					cstmt.setInt(1, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getCodigoArticulo() != null){
					cstmt.setInt(2,Integer.parseInt(entrada.getCodigoArticulo()));
				}else{
					cstmt.setInt(2, java.sql.Types.NUMERIC);
				}
				
				
				cstmt.setString(3,entrada.getNumeroSerie());
				
				if(entrada.getCodigoUso() != null){
					cstmt.setInt(4,Integer.parseInt(entrada.getCodigoUso()));
				}else{
					cstmt.setInt(4, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getEstado() != null){
					cstmt.setInt(5,Integer.parseInt(entrada.getEstado()));
				}else{
					cstmt.setInt(5, java.sql.Types.NUMERIC);
				}
				
				cstmt.setLong(6,entrada.getNumAbonado());
				
				if(entrada.getCodigoAntiguedad() != null){
					cstmt.setInt(7,entrada.getCodigoAntiguedad().intValue());
				}else{
					cstmt.setInt(7, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getModalidadVenta() != null){
					cstmt.setInt(8,Integer.parseInt(entrada.getModalidadVenta()));
				}else{
					cstmt.setInt(8, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getNumMeses() != null){
					cstmt.setInt(9,entrada.getNumMeses().intValue());
				}else{
					cstmt.setInt(9, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getPromoCelular() != null){
					cstmt.setInt(10,entrada.getPromoCelular().intValue());
				}else{
					cstmt.setInt(10, java.sql.Types.NUMERIC);
				}
				
				cstmt.setString(11,entrada.getNombreUsuario());
				
				cstmt.registerOutParameter(12,OracleTypes.CURSOR);
				cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
				

				logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista_Rest:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista_Rest:execute");
	
				codError = cstmt.getInt(13);
				msgError = cstmt.getString(14);
				numEvento = cstmt.getInt(15);
				
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (No Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Terminal para Restitucion (No Precio Lista)");
					ArrayList lista = new ArrayList();
					ResultSet rs = null;
					
					rs = (ResultSet) cstmt.getObject(12);	
					
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
					
					logger.debug("precio cargos Terminal para Restitucion (No Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
				
			}catch(ProductException e){
				throw e;
			
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (No Precio Lista)",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Deducible)", e);
				
			} finally {
			 	if (logger.isDebugEnabled()) 
					logger.debug("Cerrando conexiones...");
				try {
					if (cstmt!=null)
						cstmt.close();
					if (conn != null && !conn.isClosed()) {
						conn.close();
					}
				} catch (SQLException e) {
					logger.debug("SQLException", e);
				}
			}
			logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista_Rest()");
			return resultado;
		}//fin getPrecioCargoTerminal_NoPrecioLista_Rest

		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista_Rest_PV(ParametrosCargoTerminalRestitucionDTO entrada) 
		throws ProductException{
			
			logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista_Rest_PV()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLDatosTerminal("PV_CARGOS_PG","pv_precarterm_noprelis_Rest_PR",14);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				
				logger.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				
				logger.debug("TipoStock["+entrada.getTipoStock()+"]");
				logger.debug("CodigoArticulo["+entrada.getCodigoArticulo()+"]");
				logger.debug("NumeroSerie["+entrada.getNumeroSerie()+"]");
				logger.debug("CodigoUso["+entrada.getCodigoUso()+"]");
				logger.debug("Estado["+entrada.getEstado()+"]");
				logger.debug("Numero Abonado ["+entrada.getNumAbonado()+"]");
				logger.debug("Codigo Antiguedad ["+entrada.getCodigoAntiguedad()+"]");
				logger.debug("ModalidadVenta["+entrada.getModalidadVenta()+"]");
				logger.debug("NumMeses["+entrada.getNumMeses()+"]");
				logger.debug("NombreUsuario["+entrada.getNombreUsuario()+"]");
				
				if(entrada.getTipoStock() != null){
					cstmt.setInt(1,Integer.parseInt(entrada.getTipoStock()));
				}else{
					cstmt.setNull(1, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getCodigoArticulo() != null){
					cstmt.setInt(2,Integer.parseInt(entrada.getCodigoArticulo()));
				}else{
					cstmt.setNull(2, java.sql.Types.NUMERIC);
				}
				cstmt.setString(3,entrada.getNumeroSerie());
				
				if(entrada.getCodigoUso() != null){
					cstmt.setInt(4,Integer.parseInt(entrada.getCodigoUso()));
				}else{
					cstmt.setNull(4, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getEstado() != null){
					cstmt.setInt(5,Integer.parseInt(entrada.getEstado()));
				}else{
					cstmt.setNull(5, java.sql.Types.NUMERIC);
				}
				
				cstmt.setLong(6,entrada.getNumAbonado());
				
				if(entrada.getCodigoAntiguedad() != null){
					cstmt.setInt(7,entrada.getCodigoAntiguedad().intValue());
				}else{
					cstmt.setNull(7, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getModalidadVenta() != null){
					cstmt.setInt(8,Integer.parseInt(entrada.getModalidadVenta()));
				}else{
					cstmt.setNull(8, java.sql.Types.NUMERIC);
				}
				
				if(entrada.getNumMeses() != null){
					cstmt.setInt(9,entrada.getNumMeses().intValue());
				}else{
					cstmt.setNull(9, java.sql.Types.NUMERIC);
				}
				
				cstmt.setString(10,entrada.getNombreUsuario());
				
				cstmt.registerOutParameter(11,OracleTypes.CURSOR);
				cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(13, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista_Rest_PV:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista_Rest_PV:execute");

				codError = cstmt.getInt(12);
				msgError = cstmt.getString(13);
				numEvento = cstmt.getInt(14);
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (No Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Terminal para Restitucion (No Precio Lista)");
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(11);
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
					
					logger.debug("precio cargos Terminal para Restitucion (No Precio Lista)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			}catch(ProductException e){
				throw e;
			} 
			catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (No Precio Lista)",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (No Precio Lista)", e);
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
			logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista_Rest_PV()");
			return resultado;
		}//fin getPrecioCargoTerminal_NoPrecioLista_Rest_PV	
		
		/**
		 * permite obtener el listado de cargos deducibles para un terminal
		 * @param entrada
		 * @return
		 * @throws ProductException
		 */
		public PrecioCargoDTO[] getPrecioCargoTerminal_Deducible_Rest(ParametrosCargoTerminalRestitucionDTO entrada) 
		throws ProductException{
			
			logger.debug("Inicio:getPrecioCargoTerminal_Deducible_Rest()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				String call = getSQLDatosTerminal("PV_CARGOS_PG","PV_List_cargos_Deducible_PR",8);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				
				logger.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				
				logger.debug("CodigoArticulo["+entrada.getCodigoArticulo()+"]");
				logger.debug("Numero Abonado ["+entrada.getNumAbonado()+"]");
				logger.debug("NumeroSerie["+entrada.getNumeroSerie()+"]");
				logger.debug("NombreUsuario["+entrada.getNombreUsuario()+"]");
				
				cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
				cstmt.setLong(2,entrada.getNumAbonado());
				cstmt.setString(3,entrada.getNumeroSerie());
				cstmt.setString(4,entrada.getNombreUsuario());
				
				cstmt.registerOutParameter(5,OracleTypes.CURSOR);
				cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(7, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:getPrecioCargoTerminal_Deducible_Rest:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_Deducible_Rest:execute");

				codError = cstmt.getInt(6);
				msgError = cstmt.getString(7);
				numEvento = cstmt.getInt(8);
				logger.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Deducible)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Deducible)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Terminal para Restitucion (Deducible)");
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(5);
					while (rs.next()) {
						
						PrecioCargoDTO precioDTO = new PrecioCargoDTO();
						
						precioDTO.setIndicadorAutMan(rs.getString(1));
						precioDTO.setDescripcionConcepto(rs.getString(2));
						precioDTO.setNumeroUnidades(rs.getString(3));
						precioDTO.setMonto(rs.getFloat(4));
						precioDTO.setDescripcionMoneda(rs.getString(5));
						precioDTO.setCodigoConcepto(rs.getString(6));
						precioDTO.setCodigoMoneda(rs.getString(7));
						precioDTO.setValorMinimo(rs.getString(8)); 
						precioDTO.setValorMaximo(rs.getString(9));
						
						lista.add(precioDTO);
					}
					rs.close();
					resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), PrecioCargoDTO.class);
					
					logger.debug("precio cargos Terminal para Restitucion (Deducible)");
				}
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			}catch(ProductException e){
				throw e;
			} 
			catch (Exception e) {
				logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Deducible)",e);
				if (logger.isDebugEnabled()) {
					logger.debug("Codigo de Error[" + codError + "]");
					logger.debug("Mensaje de Error[" + msgError + "]");
					logger.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductException(
						"Ocurrió un error al recuperar el precio de cargo del Terminal para Restitucion (Deducible)", e);
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
			logger.debug("Fin:getPrecioCargoTerminal_Deducible_Rest()");
			return resultado;
		}//fin getPrecioCargoTerminal_Deducible_Rest	
		
}//fin TerminalDAO

