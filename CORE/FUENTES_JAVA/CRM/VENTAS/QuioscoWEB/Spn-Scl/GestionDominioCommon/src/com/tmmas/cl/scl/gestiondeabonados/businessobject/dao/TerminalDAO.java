package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.DescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ImeiWSDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosCargoTerminalDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.TerminalSNPNDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ResultadoValidacionVentaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;


public class TerminalDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(TerminalDAO.class);
		Global global = Global.getInstance();
		
		private Connection getConection() 
		throws GeneralException {
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
		
		private String getSQLDatosTerminal(String packageName, String procedureName, int paramCount)
		{
			StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
	        for (int n = 1; n <= paramCount; n++) {
	            sb.append("?");
	            if (n < paramCount) sb.append(",");
	        }
	        return sb.append(")}").toString();
		}//fin getSQLDatosTerminal

		
		private String getSQLDatosTerminal(String procedureName, int paramCount)
		{
			StringBuffer sb = new StringBuffer("{call "+procedureName+"(");
	        for (int n = 1; n <= paramCount; n++) {
	            sb.append("?");
	            if (n < paramCount) sb.append(",");
	        }
	        return sb.append(")}").toString();
		}//fin getSQLDatosTerminal		
		
		public ResultadoValidacionLogisticaDTO getLargoSerieTerminal(ParametrosValidacionLogisticaDTO entrada) 
		throws GeneralException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:getLargoSerieTerminal");

				//INI-01 (AL) String call = getSQLDatosTerminal("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);
				String call = getSQLDatosTerminal("VE_intermediario_Quiosco_PG","VE_obtiene_valor_parametro_PR",7);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,entrada.getNombreParametro());
				cstmt.setString(2,entrada.getCodigoModulo());
				cstmt.setString(3,entrada.getCodigoProducto());
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(6, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getLargoSerieTerminal:execute");
				cstmt.execute();
				cat.debug("Fin:getLargoSerieTerminal:execute");

				codError = cstmt.getInt(5);
				msgError = cstmt.getString(6);
				numEvento = cstmt.getInt(7);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			
				if (codError != 0){
					cat.error("Ocurrió un error al recuperar largo de la serie terminal");
					throw new GeneralException(
							"Ocurrió un error al recuperar largo de la serie terminal", String
							.valueOf(codError), numEvento, msgError);
				}else 
					resultado.setLargoSerie(cstmt.getInt(4));

			} catch (GeneralException e) {
				throw (e);	
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar largo de la serie terminal",e);
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
			cat.debug("Fin:TerminalO:getLargoSerieTerminal()");
			return resultado;
		}//fin getLargoSerieTerminal

		public TerminalSNPNDTO getTerminal(TerminalSNPNDTO entrada) 
		throws GeneralException{
			cat.debug("Inicio:getTerminal()");
			TerminalSNPNDTO resultado = new TerminalSNPNDTO();
			resultado.setNumeroSerie(entrada.getNumeroSerie());
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_serieTerminal_PR",19);
				String call = getSQLDatosTerminal("VE_servicios_venta_quiosco_PG","VE_consulta_serieTerminal_PR",19);
				
				cat.debug("sql[" + call + "]");
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
				cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);

				cat.debug("Inicio:getTerminal:execute");
				cstmt.execute();
				cat.debug("Fin:getTerminal:execute");
				
				codError = cstmt.getInt(17);
				msgError = cstmt.getString(18);
				numEvento = cstmt.getInt(19);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError==0)
				{
					resultado.setCodigoBodega(String.valueOf(cstmt.getInt(2)));
					cat.debug("resultado.setCodigoBodega [" + cstmt.getInt(2) + "]");
					resultado.setEstado(String.valueOf(cstmt.getInt(3)));
					cat.debug("resultado.setEstado [" + cstmt.getInt(3) + "]");
					resultado.setIndicadorProgramado(String.valueOf(cstmt.getInt(4)));
					cat.debug("resultado.setIndicadorProgramado [" + cstmt.getInt(4) + "]");
					resultado.setNumeroCelular(String.valueOf(cstmt.getLong(5)));
					cat.debug("resultado.setNumeroCelular [" + cstmt.getLong(5) + "]");
					resultado.setCodigoUso(String.valueOf(cstmt.getInt(6)));
					cat.debug("resultado.setCodigoUso [" + cstmt.getInt(6) + "]");
					resultado.setTipoStock(String.valueOf(cstmt.getInt(7)));
					cat.debug("resultado.setTipoStock [" + cstmt.getInt(7) + "]");
					resultado.setCodigoCentral(String.valueOf(cstmt.getInt(8)));
					cat.debug("resultado.setCodigoCentral [" + cstmt.getInt(8) + "]");
					resultado.setCodigoArticulo(String.valueOf(cstmt.getInt(9)));
					cat.debug("resultado.setCodigoArticulo [" + cstmt.getInt(9) + "]");
					resultado.setCapCode(String.valueOf(cstmt.getInt(10)));
					cat.debug("resultado.setCapCode [" + cstmt.getInt(10) + "]");
					resultado.setTipoArticulo(String.valueOf(cstmt.getInt(11)));
					cat.debug("resultado.setTipoArticulo [" + cstmt.getInt(11) + "]");
					resultado.setDescripcionArticulo(cstmt.getString(12));
					cat.debug("resultado.setDescripcionArticulo [" + cstmt.getString(12) + "]");
					resultado.setCodigoSubAlm(cstmt.getString(13));
					cat.debug("resultado.setCodigoSubAlm [" + cstmt.getString(13) + "]");
					resultado.setIndicadorValorar(cstmt.getString(14));
					cat.debug("resultado.setIndicadorValorar [" + cstmt.getString(14) + "]");
					resultado.setCarga(cstmt.getString(15));
					cat.debug("resultado.setCarga [" + cstmt.getString(15) + "]");
					
					resultado.setCodigoCategoria(cstmt.getString(16));
					cat.debug("resultado.setCodigoCategoria [" + cstmt.getString(16) + "]");
					
					resultado.setIndProcEq(entrada.getProcedenciaInterna());
					cat.debug("resultado.setIndProcEq [" + entrada.getProcedenciaInterna() + "]");
					
					
				}
				else
					resultado.setIndProcEq(entrada.getProcedenciaExterna());
					cat.debug("resultado.setIndProcEq [" + entrada.getProcedenciaExterna() + "]");
				
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar Datos de la serie terminal",e);
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
			cat.debug("Fin:getTerminal()");
			return resultado;
		}//fin getTerminal
	
		public ResultadoValidacionLogisticaDTO existeSerieTerminal(ParametrosValidacionLogisticaDTO lineaEntrada) 
		throws GeneralException{
			cat.debug("Inicio:existeSerieTerminal()");
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_validacion_linea_PG","VE_existeseriebodega_PR",5);
				String call = getSQLDatosTerminal("VE_validacion_linea_quiosco_PG","VE_existeseriebodega_PR",5);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cstmt.setString(1,lineaEntrada.getNumeroSerieTerminal());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:existeSerieTerminal:execute");
				cstmt.execute();
				cat.debug("Fin:existeSerieTerminal:execute");
				
				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError != 0){
					cat.error("Ocurrió un error al recuperar Datos de la serie terminal");
					throw new GeneralException(
							"Ocurrió un error al recuperar Datos de la serie terminal", String
							.valueOf(codError), numEvento, msgError);
				}else 
					resultado.setResultadoBase(cstmt.getInt(2));

				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			}  catch (GeneralException e) {
				throw (e);	
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar Datos de la serie terminal",e);
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
			cat.debug("Fin:existeSerieTerminal()");
			return resultado;
		}//fin existeSerieTerminal

		public PrecioCargoDTO[] getPrecioCargoTerminal_PrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws GeneralException{
			cat.debug("Inicio:getPrecioCargoTerminal_PrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_PrecCargoTerminal_PreLis_PR",10);
				String call = getSQLDatosTerminal("VE_servicios_venta_quiosco_PG","VE_PrecCargoTerminal_PreLis_PR",10);

				cat.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
				cat.debug("entrada.getCodigoArticulo(): " + entrada.getCodigoArticulo());
				cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
				cat.debug("entrada.getTipoStock(): " + entrada.getTipoStock());
				cstmt.setInt(3,Integer.parseInt(entrada.getCodigoUso()));
				cat.debug("entrada.getCodigoUso(): " + entrada.getCodigoUso());
				cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
				cat.debug("entrada.getEstado(): " + entrada.getEstado());
				cstmt.setInt(5,Integer.parseInt(entrada.getIndiceRecambio()));
				cat.debug("entrada.getIndiceRecambio(): " + entrada.getIndiceRecambio());
				cstmt.setString(6,entrada.getCodigoCategoria());
				cat.debug("entrada.getCodigoCategoria(): " + entrada.getCodigoCategoria());
				cstmt.registerOutParameter(7,OracleTypes.CURSOR);
				cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(9, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getPrecioCargoTerminal_PrecioLista:execute");
				cstmt.execute();
				cat.debug("Fin:getPrecioCargoTerminal_PrecioLista:execute");

				codError = cstmt.getInt(8);
				msgError = cstmt.getString(9);
				numEvento = cstmt.getInt(10);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)");
					throw new GeneralException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					cat.debug("Recuperando el precio de cargo del Terminal (Precio Lista)");
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
					
				}
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (GeneralException e) {
				throw(e);
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
				"Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)");
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
			cat.debug("Fin:getPrecioCargoTerminal_PrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_PrecioLista

		public PrecioCargoDTO[] getPrecioCargoTerminal_NoPrecioLista(ParametrosCargoTerminalDTO entrada) 
		throws GeneralException{
			cat.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_PreCarTerminal_NoPreLis_PR",15);
				String call = getSQLDatosTerminal("VE_servicios_venta_quiosco_PG","VE_PreCarTerminal_NoPreLis_PR",15);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
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
				
				cat.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista:execute");
				cstmt.execute();
				cat.debug("Fin:getPrecioCargoTerminal_NoPrecioLista:execute");

				codError = cstmt.getInt(13);
				msgError = cstmt.getString(14);
				numEvento = cstmt.getInt(15);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)");
					throw new GeneralException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					cat.debug("Recuperando el precio de cargo de la Terminal (No Precio Lista)");
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
					
				}
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (GeneralException e) {
				throw(e);
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new GeneralException(
				"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)");
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
			cat.debug("Fin:getPrecioCargoTerminal_NoPrecioLista()");
			return resultado;
		}//fin getPrecioCargoTerminal_NoPrecioLista

		/**
		 * Busca todos los Descuentos tipo Articulo asociados al Terminal 
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
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
				String call = getSQLDatosTerminal("VE_servicios_venta_quiosco_PG","VE_obtiene_descuento_art_PR",14);
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
					ArrayList lista = new ArrayList();
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
		 * Busca todos los Descuentos tipo concepto asociados al Terminal 
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
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",16);
				String call = getSQLDatosTerminal("VE_servicios_venta_quiosco_PG","VE_obtiene_descuento_con_PR",16);
				cat.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,entrada.getCodigoOperacion());
				cat.debug("entrada.getCodigoOperacion() ["+entrada.getCodigoOperacion()+"]");
				cstmt.setString(2,entrada.getCodigoAntiguedad());
				cat.debug("entrada.getCodigoAntiguedad() ["+entrada.getCodigoAntiguedad()+"]");
				cstmt.setString(3,entrada.getTipoContrato());
				cat.debug("entrada.getTipoContrato() ["+entrada.getTipoContrato()+"]");
				cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
				cat.debug("entrada.getNumeroMesesNuevo() ["+entrada.getNumeroMesesNuevo()+"]");
				cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
				cat.debug("entrada.getIndiceVentaExterna() ["+entrada.getIndiceVentaExterna()+"]");
				cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
				cat.debug("entrada.getCodigoVendedor() ["+entrada.getCodigoVendedor()+"]");
				cstmt.setString(7,entrada.getCodigoCausaDescuento());
				cat.debug("entrada.getCodigoCausaDescuento() ["+entrada.getCodigoCausaDescuento()+"]");
				cstmt.setString(8,entrada.getCodigoCategoria());
				cat.debug("entrada.getCodigoCategoria() ["+entrada.getCodigoCategoria()+"]");
				cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
				cat.debug("entrada.getCodigoModalidadVenta() ["+entrada.getCodigoModalidadVenta()+"]");
				cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
				cat.debug("entrada.getTipoPlanTarifario() ["+entrada.getTipoPlanTarifario()+"]");
				cstmt.setInt(11,Integer.parseInt(entrada.getConcepto()));
				cat.debug("entrada.getConcepto() ["+entrada.getConcepto()+"]");
				cstmt.setString(12,entrada.getClaseDescuento());
				cat.debug("entrada.getClaseDescuento() ["+entrada.getClaseDescuento()+"]");
				
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
					ArrayList lista = new ArrayList();
					ResultSet rs = (ResultSet) cstmt.getObject(13);
					while (rs.next()) {
						DescuentoDTO descuentoDTO = new DescuentoDTO();
						descuentoDTO.setTipoAplicacion(rs.getString(1));
						cat.debug("descuentoDTO.getTipoAplicacion ["+descuentoDTO.getTipoAplicacion()+"]");
						descuentoDTO.setDescripcionConcepto(rs.getString(2));
						cat.debug("descuentoDTO.getDescripcionConcepto ["+descuentoDTO.getDescripcionConcepto()+"]");
						descuentoDTO.setMonto(rs.getFloat(3));
						cat.debug("descuentoDTO.getMonto ["+descuentoDTO.getMonto()+"]");
						descuentoDTO.setCodigoConcepto(rs.getString(4));
						cat.debug("descuentoDTO.getCodigoConcepto ["+descuentoDTO.getCodigoConcepto()+"]");
						
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
		public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws GeneralException{
			cat.debug("Inicio:getCodigoDescuentoManual()");
			DescuentoDTO resultado = new DescuentoDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
				String call = getSQLDatosTerminal("VE_servicios_venta_quiosco_PG","VE_consulta_cod_desc_manual_PR",6);
				cat.debug("sql[" + call + "]");
				
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
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");

				if (codError == 0) 
					resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
				else {
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

		public ResultadoValidacionLogisticaDTO verificaRechazoSerie (ParametrosValidacionLogisticaDTO lineaEntrada) 
		throws GeneralException{
			cat.debug("Inicio:verificaRechazoSerie()");
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_validacion_linea_PG","VE_verifica_rechazo_serie_PR",5);
				String call = getSQLDatosTerminal("VE_validacion_linea_quiosco_PG","VE_verifica_rechazo_serie_PR",5);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cstmt.setString(1,lineaEntrada.getNumeroSerieTerminal());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				cat.debug("Inicio:verificaRechazoSerie:execute");
				cstmt.execute();
				cat.debug("Fin:verificaRechazoSerie:execute");
				
				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");				
				
				if (codError != 0) {
					cat.error("Ocurrió un error al consultar si la serie fue rechazada");
					throw new GeneralException(
							"Ocurrió un error al consultar si la serie fue rechazada", String
									.valueOf(codError), numEvento, msgError);					
				}else{	
					int res = cstmt.getInt(2);
					resultado.setResultadoBase(res);
				}
			} catch (GeneralException e) {
				throw (e);	
			} catch (Exception e) {
				cat.error("Ocurrió un error al consultar si la serie fue rechazada",e);
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
			cat.debug("Fin:verificaRechazoSerie()");
			return resultado;
		}//fin existeSerieTerminal
		
		/**
		 * Actualiza stock terminal
		 * @param terminal
		 * @return
		 * @throws GeneralException
		 */
		public TerminalSNPNDTO actualizaStockTerminal(TerminalSNPNDTO terminal)
		throws GeneralException{
			TerminalSNPNDTO resultado = new TerminalSNPNDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				cat.debug("Inicio:actualizaStockTerminal");
				
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_intermediario_PG","VE_actualiza_stock_PR",14);
				String call = getSQLDatosTerminal("VE_intermediario_Quiosco_PG","VE_actualiza_stock_PR",14);

				cat.debug("sql[" + call + "]");

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
				
				cat.debug("Inicio:actualizaStockTerminal:execute");
				cstmt.execute();
				cat.debug("Fin:actualizaStockTerminal:execute");

				codError  = cstmt.getInt(12);
				msgError  = cstmt.getString(13);
				numEvento = cstmt.getInt(14);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");

				if (codError != 0) {
					cat.error("Ocurrió un error al actualizar stock terminal");
					throw new GeneralException(
							"Ocurrió un error al actualizar stock terminal", String
									.valueOf(codError), numEvento, msgError);					
				}else{				
					resultado.setNumeroMovimiento(cstmt.getString(10));
					resultado.setIndSerConTel(cstmt.getString(11));
					resultado.setCodigoError(codError);
				}
			} catch (GeneralException e) {
				throw (e);	
			} catch (Exception e) {
				cat.error("Ocurrió un error al actualizar stock terminal",e);
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
			cat.debug("Fin:actualizaStockTerminal");
			return resultado;
		}//fin actualizaStockTerminal
		
		/**
		 * Obtiene estado anterior de la serie
		 * @param terminal
		 * @return resultado
		 * @throws GeneralException
		 */
		public TerminalSNPNDTO getEstadoAnterior(TerminalSNPNDTO entrada) 
		throws GeneralException{
			cat.debug("Inicio:getEstadoAnterior()");
			TerminalSNPNDTO resultado = new TerminalSNPNDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				//INI-01 (AL) String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_estant_serie_PR",5);
				String call = getSQLDatosTerminal("VE_servicios_venta_quiosco_PG","VE_consulta_estant_serie_PR",5);
				
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);

				cstmt.setString(1,entrada.getNumeroSerie());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

				cat.debug("Inicio:getEstadoAnterior:execute");
				cstmt.execute();
				cat.debug("Fin:getEstadoAnterior:execute");
				
				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar estado anterior de la serie del terminal");
					throw new GeneralException(
							"Ocurrió un error al recuperar estado anterior de la serie del terminal", String
									.valueOf(codError), numEvento, msgError);					
				}else
					resultado.setEstadoAnterior(String.valueOf(cstmt.getInt(2)));
				
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (GeneralException e) {
				throw (e);	
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar estado anterior de la serie del terminal",e);
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
			cat.debug("Fin:getEstadoAnterior()");
			return resultado;
		}//fin getEstadoAnterior
		
		/**
		 * Valida formato del numero serie terminal
		 * @author Héctor Hermosilla
		 * @param TerminalSNPNDTO
		 * @return resultado
		 * @throws GeneralException
		 */
		
		public ResultadoValidacionLogisticaDTO validaFormatoTerminalGSM(TerminalSNPNDTO TerminalSNPNDTO) 
		throws GeneralException{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:validaFormatoTerminalGSM");

				//INI-01 (AL) String call = getSQLDatosTerminal("VE_intermediario_PG","VE_validaformatoGSM_PR",4);
				String call = getSQLDatosTerminal("VE_intermediario_Quiosco_PG","VE_validaformatoGSM_PR",4);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,TerminalSNPNDTO.getNumeroSerie());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:validaFormatoTerminalGSM:execute");
				cstmt.execute();
				cat.debug("Fin:validaFormatoTerminalGSM:execute");
				
				codError = cstmt.getInt(2);
				msgError = cstmt.getString(3);
				numEvento = cstmt.getInt(4);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError !=0)
					resultado.setResultado(false);
				else
					resultado.setResultado(true);
						
			} catch (Exception e) {
				cat.error("Ocurrió un error al validar el formato de la serie",e);
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
			cat.debug("Fin:validaFormatoTerminalGSM()");
			return resultado;
		}//fin validaFormatoTerminalGSM
		
		
		/**
		 * Valida las veces que puede estar asociada el terminal a uno o mas abonados
		 * @author Héctor Hermosilla
		 * @param TerminalSNPNDTO
		 * @return resultado
		 * @throws GeneralException
		 */
		
		public ResultadoValidacionVentaDTO validaRepeticionTerminal(TerminalSNPNDTO TerminalSNPNDTO) 
		throws GeneralException{
			ResultadoValidacionVentaDTO resultado = new ResultadoValidacionVentaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:validaRepeticionTerminal");

				//INI-01 (AL) String call = getSQLDatosTerminal("VE_intermediario_PG","VE_validarepeticionGSM_PR",4);
				String call = getSQLDatosTerminal("VE_intermediario_Quiosco_PG","VE_validarepeticionGSM_PR",4);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,TerminalSNPNDTO.getNumeroSerie());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:validaRepeticionTerminal:execute");
				cstmt.execute();
				cat.debug("Fin:validaRepeticionTerminal:execute");
				
				codError = cstmt.getInt(2);
				msgError = cstmt.getString(3);
				numEvento = cstmt.getInt(4);

				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError !=0)
					resultado.setResultado(false);
				else
					resultado.setResultado(true);
						
			} catch (Exception e) {
				cat.error("Ocurrió un error al validar la repetición de la serie",e);
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
			cat.debug("Fin:validaFormatoTerminalGSM()");
			return resultado;
		}//fin validaRepeticionTerminal
		
		public RetornoDTO  validaImeiGSM(ImeiWSDTO imeiWS) 
		throws GeneralException{
			RetornoDTO resultado = new RetornoDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:validaImeiGSM");

				String call = getSQLDatosTerminal("VE_PORTABILIDAD_PG","ve_val_imei_pr",4);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,imeiWS.getSerie());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:validaImeiGSM:execute");
				cstmt.execute();
				cat.debug("Fin:validaImeiGSM:execute");
				
				codError = cstmt.getInt(2);
				msgError = cstmt.getString(3);
				numEvento = cstmt.getInt(4);
				
				cat.debug("codError [" + codError + "]");
				cat.debug("msgError [" + msgError + "]");
				cat.debug("numEvento[" + numEvento + "]");
				
				if (codError !=0){					
					
					resultado.setCodError(String.valueOf(codError));
					cat.debug("resultado.getCodError [" + resultado.getCodError() + "]");
					//resultado.setResultadoTransaccion("1");
					//cat.debug("resultado.getResultadoTransaccion [" + resultado.getResultadoTransaccion() + "]");
				}else{
					resultado.setCodError("0");
					cat.debug("resultado.getCodError [" + resultado.getCodError() + "]");					
					//resultado.setResultadoTransaccion("0");
					//cat.debug("resultado.getResultadoTransaccion [" + resultado.getResultadoTransaccion() + "]");
				}
						
			} catch (Exception e) {
				cat.error("Ocurrió un error al validar la repetición de la serie",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				resultado.setCodError("1");
				//resultado.setResultadoTransaccion("1");
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
			cat.debug("Fin:validaFormatoTerminalGSM()");
			return resultado;
		}//fin validaRepeticionTerminal		
		
		
		public String validaRangoTerminal(TerminalSNPNDTO TerminalSNPNDTO) 
		throws GeneralException{			
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null;
			String tipPortado = "O";
			try {
				cat.debug("Inicio:validaRangoTerminal");

				String call = getSQLDatosTerminal("VE_PORTABILIDAD_PG","ve_val_rago_operadora_scl_pr",5);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,TerminalSNPNDTO.getNumeroCelular());
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:validaRangoTerminal:execute");
				cstmt.execute();
				cat.debug("Fin:validaRangoTerminal:execute");
				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError != 0) {
					cat.error("Ocurrió un error al validar Rango Terminal");
					throw new GeneralException(
							"Ocurrió un error al validar Rango Terminal", String
									.valueOf(codError), numEvento, msgError);
				}else{
					tipPortado = cstmt.getString(2);
				}
				
			} catch (GeneralException e) {
				throw e;
			
			} catch (Exception e) {
				cat.error("Ocurrió un error al validar Rango Terminal",e);
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
			cat.debug("Fin:validaFormatoTerminalGSM()");
			return tipPortado;
		}//fin validaRepeticionTerminal		
		
		
		
		public String getSerieHexa(TerminalSNPNDTO TerminalSNPNDTO) 
		throws GeneralException{			
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null;
			String seriehex = new String();
			try {
				cat.debug("Inicio:validaRangoTerminal");

				String call = getSQLDatosTerminal("P_TRANSFORMA_HEXA",2);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,TerminalSNPNDTO.getNumeroSerie());
				cat.debug("TerminalSNPNDTO.getNumeroSerie() ["+TerminalSNPNDTO.getNumeroSerie()+"]");
				cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
				
				cat.debug("Inicio:validaRangoTerminal:execute");
				cstmt.execute();
				cat.debug("Fin:validaRangoTerminal:execute");

				seriehex = cstmt.getString(2);
				
				cat.debug("seriehex ["+seriehex+"]");
				
				if (seriehex == null){
					seriehex = "0";
				}


			} catch (Exception e) {
				cat.error("Ocurrió un error al validar Rango Terminal",e);
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
			cat.debug("Fin:validaFormatoTerminalGSM()");
			return seriehex;
		}//fin validaRepeticionTerminal		

	
		public void setNumeracionTerminalPortada(TerminalSNPNDTO terminal) 
		throws GeneralException{
			cat.debug("Inicio:getSimcardAutomatico()");
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("VE_PORTABILIDAD_PG","VE_NUMERASERIE_PORTABILIDAD_PR",8);

				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cstmt.setString(1,terminal.getNumeroSerie());
				cstmt.setString(2,terminal.getNumeroCelular());
				cstmt.setString(3,terminal.getCodigoCentral());
				cstmt.setString(4,terminal.getCodigoSubAlm());	
				cstmt.setString(5,terminal.getIndProcEq());
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
		}		
}//fin TerminalDAO

