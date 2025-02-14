package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionLogisticaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionLogisticaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.TerminalDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoTerminalDTO;
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
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_serieTerminal_PR",19);
				String call = getSQLDatosTerminal("VE_servicios_venta_quiosco_PG","VE_consulta_serieTerminal_PR",19);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);

				cstmt.setString(1,entrada.getNumeroSerie());
				logger.debug("entrada.getNumeroSerie() ["+entrada.getNumeroSerie()+"]");
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
				cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);

				logger.debug("Inicio:getTerminal:execute");
				cstmt.execute();
				logger.debug("Fin:getTerminal:execute");
				
				codError = cstmt.getInt(17);
				msgError = cstmt.getString(18);
				numEvento = cstmt.getInt(19);
				
				
				logger.debug("codError ["+codError+"]");
				logger.debug("msgError ["+msgError+"]");
				logger.debug("numEvento ["+numEvento+"]");

				
				if (codError==0)
				{
					resultado.setCodigoBodega(String.valueOf(cstmt.getInt(2)));
					logger.debug("resultado.setCodigoBodega [" + cstmt.getInt(2) + "]");
					resultado.setEstado(String.valueOf(cstmt.getInt(3)));
					logger.debug("resultado.setEstado [" + cstmt.getInt(3) + "]");
					resultado.setIndicadorProgramado(String.valueOf(cstmt.getInt(4)));
					logger.debug("resultado.setIndicadorProgramado [" + cstmt.getInt(4) + "]");
					resultado.setNumeroCelular(String.valueOf(cstmt.getLong(5)));
					logger.debug("resultado.setNumeroCelular [" + cstmt.getLong(5) + "]");
					resultado.setCodigoUso(String.valueOf(cstmt.getInt(6)));
					logger.debug("resultado.setCodigoUso [" + cstmt.getInt(6) + "]");
					resultado.setTipoStock(String.valueOf(cstmt.getInt(7)));
					logger.debug("resultado.setTipoStock [" + cstmt.getInt(7) + "]");
					resultado.setCodigoCentral(String.valueOf(cstmt.getInt(8)));
					logger.debug("resultado.setCodigoCentral [" + cstmt.getInt(8) + "]");
					resultado.setCodigoArticulo(String.valueOf(cstmt.getInt(9)));
					logger.debug("resultado.setCodigoArticulo [" + cstmt.getInt(9) + "]");
					resultado.setCapCode(String.valueOf(cstmt.getInt(10)));
					logger.debug("resultado.setCapCode [" + cstmt.getInt(10) + "]");
					resultado.setTipoArticulo(String.valueOf(cstmt.getInt(11)));
					logger.debug("resultado.setTipoArticulo [" + cstmt.getInt(11) + "]");
					resultado.setDescripcionArticulo(cstmt.getString(12));
					logger.debug("resultado.setDescripcionArticulo [" + cstmt.getString(12) + "]");
					resultado.setCodigoSubAlm(cstmt.getString(13));
					logger.debug("resultado.setCodigoSubAlm [" + cstmt.getString(13) + "]");
					resultado.setIndicadorValorar(cstmt.getString(14));
					logger.debug("resultado.setIndicadorValorar [" + cstmt.getString(14) + "]");
					resultado.setIndProcEq(entrada.getProcedenciaInterna());
					logger.debug("resultado.setIndProcEq [" + entrada.getProcedenciaInterna() + "]");
					
					logger.debug("Codigo de Bodega[" + resultado.getCodigoBodega() + "]");
				}
				else{
					resultado.setIndProcEq(entrada.getProcedenciaExterna());
					logger.debug("resultado.setIndProcEq [" + entrada.getProcedenciaExterna() + "]");
				}
				
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
	


		public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws GeneralException{
			logger.debug("Inicio:getPrecioCargoTerminal_PrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			
			try {
				//CSR-11002
//				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_PrecCargoTerminal_PreLis_PR",10);
				String call = getSQLDatosTerminal("VE_servicios_venta_Quiosco_PG","VE_PrecCargoTerminal_PreLis_PR",10);
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
				
				logger.debug("codError ["+codError+"]");
				logger.debug("msgError ["+msgError+"]");
				logger.debug("numEvento ["+numEvento+"]");

				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)");
					throw new GeneralException(
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
			} catch (GeneralException e) {
				throw e;
			
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
				//CSR-11002
//				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_PreCarTerminal_NoPreLis_PR",15);
				String call = getSQLDatosTerminal("VE_servicios_venta_Quiosco_PG","VE_PreCarTerminal_NoPreLis_PR",15);
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				logger.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				logger.debug("CodigoArticulo["+entrada.getCodigoArticulo()+"]");
				logger.debug("TipoStock["+entrada.getTipoStock()+"]");
				logger.debug("CodigoUso["+entrada.getCodigoUso()+"]");
				logger.debug("Estado["+entrada.getEstado()+"]");
				logger.debug("Modalidad Venta["+entrada.getModalidadVenta()+"]");
				logger.debug("Tipo Contrato["+entrada.getTipoContrato()+"]");
				logger.debug("Plan Tarifario ["+entrada.getPlanTarifario()+"]");
				logger.debug("Indice Recambio ["+entrada.getIndiceRecambio()+"]");
				logger.debug("Codigo Categoria ["+entrada.getCodigoCategoria()+"]");
				logger.debug("Codigo Uso Prepago ["+entrada.getCodigoUsoPrepago()+"]");
				logger.debug("Indicador Equipo["+entrada.getIndicadorEquipo()+"]");
				
						
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
				cstmt.registerOutParameter(12,OracleTypes.CURSOR);
				cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(14, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
				
				logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista:execute");

				codError = cstmt.getInt(13);
				msgError = cstmt.getString(14);
				numEvento = cstmt.getInt(15);
				
				
				logger.debug("codError ["+codError+"]");
				logger.debug("msgError ["+msgError+"]");
				logger.debug("numEvento ["+numEvento+"]");

				
				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)");
					throw new ProductException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					logger.debug("Recuperando el precio de cargo de la Terminal (No Precio Lista)");
					ArrayList lista = new ArrayList();
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
		public DescuentoDTO[] getDescuentoCargoArticuloCol(ParametrosDescuentoDTO entrada) throws ProductException{
			logger.debug("Inicio:getDescuentoCargoArticulo()");
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
				// INI INC-79469; COL; 30-03-2009; AVC 
				if (entrada.getTipoContrato().equals("84")){
					entrada.setNumeroMesesContrato(12);
				}
				
				if (entrada.getTipoContrato().equals("82")){
					entrada.setNumeroMesesContrato(0);
				}
				// FIN INC-79469; COL; 30-03-2009; AVC 

				logger.debug("[getDescuentoCargoBasicoArticulo] cod operacion: " + entrada.getCodigoOperacion());
				logger.debug("[getDescuentoCargoBasicoArticulo] tipocontrato>>: " + entrada.getTipoContrato()); 
				logger.debug("entrada.getCodigoContratoNuevo() cont nuevo >>: " + entrada.getCodigoContratoNuevo());
				logger.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesContrato()); 
				logger.debug("[getDescuentoCargoBasicoArticulo] codigo antiguedad: " + entrada.getCodigoAntiguedad());
				logger.debug("[getDescuentoCargoBasicoArticulo] cod promedio: " + entrada.getCodigoPromedioFacturable());
				logger.debug("[getDescuentoCargoBasicoArticulo] estado: " + entrada.getEquipoEstado());
				logger.debug("[getDescuentoCargoBasicoArticulo] contrato: " + entrada.getTipoContrato());
				logger.debug("[getDescuentoCargoBasicoArticulo] numero meses: " + entrada.getNumeroMesesNuevo());
				logger.debug("[getDescuentoCargoBasicoArticulo] cod articulo: " + entrada.getCodigoArticulo());
				logger.debug("[getDescuentoCargoBasicoArticulo] clase desc: " + entrada.getClaseDescuento());
				//INI INC-79469; COL; 13-03-2009; AVC
				logger.debug("_AVC_");
				logger.debug(":::::::: NUEVOS REGISTROS ::::::::::::::");
				logger.debug("[getDescuentoCargoBasicoArticulo] CodigoCausaCambio  " + entrada.getCodigoCausaCambio());				
				logger.debug("[getDescuentoCargoBasicoArticulo] Codigo categoria: (IF NULO?):" + entrada.getCodigoCategoria());
				logger.debug("[getDescuentoCargoBasicoArticulo] Modalidad venta: " + entrada.getCodigoModalidadVenta());
			    logger.debug("[getDescuentoCargoBasicoArticulo] t Plan tarif: " + entrada.getTipoPlanTarifario());
				logger.debug("[getDescuentoCargoBasicoArticulo] Nombre usuario: " + entrada.getNombreUsuario());

				
	            //FIN INC-79469; COL; 13-03-2009; AVC    					
					call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
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
				logger.debug("codError ["+codError+"]");
				logger.debug("msgError ["+msgError+"]");
				logger.debug("numEvento ["+numEvento+"]");



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
				//CSR-11002
//				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
				String call = getSQLDatosTerminal("VE_servicios_venta_Quiosco_PG","VE_obtiene_descuento_art_PR",14);
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

				logger.debug("codError ["+codError+"]");
				logger.debug("msgError ["+msgError+"]");
				logger.debug("numEvento ["+numEvento+"]");

				
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
				//CSR-11002
//				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",16);
				String call = getSQLDatosTerminal("VE_servicios_venta_Quiosco_PG","VE_obtiene_descuento_con_PR",16);
				logger.debug("sql[" + call + "]");
				conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,entrada.getCodigoOperacion());
				logger.debug("entrada.getCodigoOperacion() ["+entrada.getCodigoOperacion()+"]");
				cstmt.setString(2,entrada.getCodigoAntiguedad());
				logger.debug("entrada.getCodigoAntiguedad() ["+entrada.getCodigoAntiguedad()+"]");
				cstmt.setString(3,entrada.getTipoContrato());
				logger.debug("entrada.getCodigoContratoNuevo() ["+entrada.getTipoContrato() +"]");
				cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
				logger.debug("entrada.getNumeroMesesNuevo() ["+entrada.getNumeroMesesNuevo()+"]");
				cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
				logger.debug("entrada.getIndiceVentaExterna() ["+entrada.getIndiceVentaExterna()+"]");
				cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
				logger.debug("entrada.getCodigoVendedor() ["+entrada.getCodigoVendedor()+"]");
				cstmt.setString(7,entrada.getCodigoCausaDescuento());
				logger.debug("entrada.getCodigoCausaVenta() ["+entrada.getCodigoCausaDescuento()+"]");
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
				
				logger.debug("codError ["+codError+"]");
				logger.debug("msgError ["+msgError+"]");
				logger.debug("numEvento ["+numEvento+"]");

				if (codError != 0) {
					logger.error("Ocurrió un error al recuperar los descuentos del cargo");
					throw new ProductException(
							"Ocurrió un error al recuperar los descuentos del cargo", String
									.valueOf(codError), numEvento, msgError);
					
				}else{
					logger.debug("Recuperando descuentos");
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(13);
					while (rs.next()) {
						DescuentoDTO descuentoDTO = new DescuentoDTO();
						descuentoDTO.setTipoAplicacion(rs.getString(1));
						logger.debug("setTipoAplicacion ["+rs.getString(1)+"]");
						descuentoDTO.setDescripcionConcepto(rs.getString(2));
						logger.debug("setDescripcionConcepto ["+rs.getString(2)+"]");
						descuentoDTO.setMonto(rs.getFloat(3));
						logger.debug("getFloat ["+rs.getString(3)+"]");
						descuentoDTO.setCodigoConcepto(rs.getString(4));
						logger.debug("setCodigoConcepto ["+rs.getString(4)+"]");
						
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
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
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
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_estant_serie_PR",5);
				
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
				
				if (logger.isDebugEnabled()) {
					logger.debug(" Finalizo ejecución");
					logger.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				logger.error("Ocurrió un error al recuperar estado anterior de la serie del terminal",e);
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
				String call = getSQLDatosTerminal("ve_servicios_venta_pg","pv_precarterminal_noprelis_pr",12);
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
				
				logger.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista:execute");
				cstmt.execute();
				logger.debug("Fin:getPrecioCargoTerminal_NoPrecioLista:execute");

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
		
}//fin TerminalDAO

