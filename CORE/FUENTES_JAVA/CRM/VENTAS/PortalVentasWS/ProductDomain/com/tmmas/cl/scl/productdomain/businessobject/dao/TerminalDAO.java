package com.tmmas.cl.scl.productdomain.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.DescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosDescuentoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ParametrosValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.dto.ResultadoValidacionLogisticaDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoTerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.SimcardDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.TerminalDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class TerminalDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(TerminalDAO.class);
		Global global = Global.getInstance();
		
		private Connection getConection() 
		throws ProductDomainException {
			Connection conn = null;
			try {
				conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			} catch (Exception e1) {
				conn = null;
				cat.error(" No se pudo obtener una conexión ", e1);
				throw new ProductDomainException("No se pudo obtener una conexión", e1);
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

		public ResultadoValidacionLogisticaDTO getLargoSerieTerminal(ParametrosValidacionLogisticaDTO entrada) 
			throws ProductDomainException
		{
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			conn = getConection();
			CallableStatement cstmt = null; 
			try {
				cat.debug("Inicio:getLargoSerieTerminal");

				String call = getSQLDatosTerminal("VE_intermediario_PG","VE_obtiene_valor_parametro_PR",7);

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

				msgError = cstmt.getString(6);
				cat.debug("msgError[" + msgError + "]");
			
				resultado.setLargoSerie(cstmt.getInt(4));
			
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar largo de la serie terminal",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
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

		public TerminalDTO getTerminal(TerminalDTO entrada) 
			throws ProductDomainException
		{
			cat.debug("Inicio:getTerminal()");
			TerminalDTO resultado = new TerminalDTO();
			resultado.setNumeroSerie(entrada.getNumeroSerie());
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_serie_PR",18);
				
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
				cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);

				cat.debug("Inicio:getTerminal:execute");
				cstmt.execute();
				cat.debug("Fin:getTerminal:execute");
				
				codError = cstmt.getInt(16);
				msgError = cstmt.getString(17);
				numEvento = cstmt.getInt(18);
				cat.debug("msgError[" + msgError + "]");
				if (codError==0)
				{
					resultado.setCodigoBodega(String.valueOf(cstmt.getInt(2)));
					resultado.setEstado(String.valueOf(cstmt.getInt(3)));
					resultado.setIndicadorProgramado(String.valueOf(cstmt.getInt(4)));
					resultado.setNumeroCelular(String.valueOf(cstmt.getLong(5)));
					resultado.setCodigoUso(cstmt.getInt(6));
					resultado.setTipoStock(String.valueOf(cstmt.getInt(7)));
					resultado.setCodigoCentral(String.valueOf(cstmt.getInt(8)));
					resultado.setCodigoArticulo(String.valueOf(cstmt.getInt(9)));
					resultado.setCapCode(String.valueOf(cstmt.getInt(10)));
					resultado.setTipoArticulo(String.valueOf(cstmt.getInt(11)));
					resultado.setDescripcionArticulo(cstmt.getString(12));
					resultado.setCodigoSubAlm(cstmt.getString(13));
					resultado.setIndicadorValorar(cstmt.getString(14));
					resultado.setIndProcEq(entrada.getProcedenciaInterna());
					cat.debug("Codigo de Bodega[" + resultado.getCodigoBodega() + "]");
				}
				else
					resultado.setIndProcEq(entrada.getProcedenciaExterna());
				
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
			throws ProductDomainException
		{
			cat.debug("Inicio:existeSerieTerminal()");
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("VE_validacion_linea_PG","VE_existeseriebodega_PR",5);
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
				cat.debug("msgError[" + msgError + "]");
				resultado.setResultadoBase(cstmt.getInt(2));
								
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
			throws ProductDomainException
		{
			cat.debug("Inicio:getPrecioCargoTerminal_PrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			ResultSet rs = null;
			try {
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_PrecCargoTerminal_PreLis_PR",11);

				cat.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
				cat.debug("entrada.getCodigoArticulo(): " + entrada.getCodigoArticulo());
				cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
				cat.debug("entrada.getTipoStock(): " + entrada.getTipoStock());
				cstmt.setInt(3,entrada.getCodigoUso());
				cat.debug("entrada.getCodigoUso(): " + entrada.getCodigoUso());
				cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
				cat.debug("entrada.getEstado(): " + entrada.getEstado());
				cstmt.setInt(5,Integer.parseInt(entrada.getIndiceRecambio()));
				cat.debug("entrada.getIndiceRecambio(): " + entrada.getIndiceRecambio());
				cstmt.setString(6,entrada.getCodigoCategoria());
				cat.debug("entrada.getCodigoCategoria(): " + entrada.getCodigoCategoria());
				cstmt.setString(7,entrada.getCodigoCalificacion());
				cat.debug("entrada.getCodigoCalificacion(): " + entrada.getCodigoCalificacion());
				cstmt.registerOutParameter(8,OracleTypes.CURSOR);
				
				cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(10, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getPrecioCargoTerminal_PrecioLista:execute");				
				cstmt.execute();				
				cat.debug("Fin:getPrecioCargoTerminal_PrecioLista:execute");

				codError = cstmt.getInt(9);
				msgError = cstmt.getString(10);
				numEvento = cstmt.getInt(11);
				cat.debug("msgError[" + msgError + "]");
				
				cat.debug("INICIO getPrecioCargoTerminal_PrecioLista TerminalDAO codError : " + codError );
				cat.debug("INICIO getPrecioCargoTerminal_PrecioLista TerminalDAO msgError : " + msgError );
				cat.debug("INICIO getPrecioCargoTerminal_PrecioLista TerminalDAO numEvento : " + numEvento );
				
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)");
					throw new ProductDomainException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					cat.debug("Recuperando el precio de cargo del Terminal (Precio Lista)");
					ArrayList lista = new ArrayList();
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
					resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), PrecioCargoDTO.class);
					
				}
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (ProductDomainException e) {
				throw(e);
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductDomainException(
				"Ocurrió un error al recuperar el precio de cargo del Terminal (Precio Lista)");
			}finally {
			 	if (cat.isDebugEnabled()) 
					cat.debug("Cerrando conexiones...");
				try {
					if (rs!=null)
						rs.close();
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
			throws ProductDomainException
		{		
			cat.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista()");
			PrecioCargoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			ResultSet rs = null;
			try {
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_PreCarTerminal_NoPreLis_PR",18);
				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);
				cstmt.setInt(1,Integer.parseInt(entrada.getCodigoArticulo()));
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getCodigoArticulo() : " 
						+ entrada.getCodigoArticulo() );
				cstmt.setInt(2,Integer.parseInt(entrada.getTipoStock()));
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getTipoStock() : " + entrada.getTipoStock());
				cstmt.setInt(3,entrada.getCodigoUso());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getCodigoUso() : " + entrada.getCodigoUso());
				cstmt.setInt(4,Integer.parseInt(entrada.getEstado()));
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getEstado() : " + entrada.getEstado());
				cstmt.setInt(5,Integer.parseInt(entrada.getModalidadVenta()));
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getModalidadVenta() : " + entrada.getModalidadVenta());
				cstmt.setString(6,entrada.getTipoContrato());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getTipoContrato() : " + entrada.getTipoContrato());
				cstmt.setString(7,entrada.getPlanTarifario());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getPlanTarifario() : " + entrada.getPlanTarifario());
				cstmt.setInt(8,Integer.parseInt(entrada.getIndiceRecambio()));
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getIndiceRecambio() : " + entrada.getIndiceRecambio() );
				cstmt.setString(9,entrada.getCodigoCategoria());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getCodigoCategoria() : " + entrada.getCodigoCategoria());
				cstmt.setString(10,entrada.getCodigoUsoPrepago());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getCodigoUsoPrepago() : " + entrada.getCodigoUsoPrepago());
				cstmt.setString(11,entrada.getIndicadorEquipo());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getIndicadorEquipo() : " + entrada.getIndicadorEquipo());
				cstmt.setString(12,entrada.getCodigoCalificacion());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getCodigoCalificacion() : " + entrada.getCodigoCalificacion());
				cstmt.setInt(13,entrada.getIndRenovacion());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO entrada.getIndRenovacion() : " + entrada.getIndRenovacion());
				cstmt.setInt(14,entrada.getIndRenovacion());
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO Ind PriSeg) : "+entrada.getIndRenovacion());
				
				cstmt.registerOutParameter(15,OracleTypes.CURSOR);
				cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(17, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
				
				cat.debug("Inicio:getPrecioCargoTerminal_NoPrecioLista:execute");				
				cstmt.execute();				
				cat.debug("Fin:getPrecioCargoTerminal_NoPrecioLista:execute");

				codError = cstmt.getInt(16);
				msgError = cstmt.getString(17);
				numEvento = cstmt.getInt(18);
				
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO codError : " + codError );
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO msgError : " + msgError );
				cat.debug("INICIO getPrecioCargoTerminal_NoPrecioLista terminalDAO numEvento : " + numEvento );
				
				cat.debug("msgError[" + msgError + "]");
				
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)");
					throw new ProductDomainException(
							"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)", String
									.valueOf(codError), numEvento, msgError);
				}else{
					cat.debug("Recuperando el precio de cargo de la Terminal (No Precio Lista)");
					ArrayList lista = new ArrayList();
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
					resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), PrecioCargoDTO.class);
					
				}
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (ProductDomainException e) {
				throw(e);
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductDomainException(
				"Ocurrió un error al recuperar el precio de cargo del Terminal (No Precio Lista)");
			}finally {
			 	if (cat.isDebugEnabled()) 
					cat.debug("Cerrando conexiones...");
				try {
					if (rs!=null)
						rs.close();
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
		 * @throws ProductDomainException
		 */
		public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) 
			throws ProductDomainException
		{
			cat.debug("Inicio:getDescuentoCargoArticulo()");		
			DescuentoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			ResultSet rs = null;
			try {
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
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
				
				cat.debug("Ingreso a getDescuentoCargoArticulo DAO codError : " + codError);
				cat.debug("Ingreso a getDescuentoCargoArticulo DAO msgError : " + msgError);
				cat.debug("Ingreso a getDescuentoCargoArticulo DAO numEvento : " + numEvento);

				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar los descuentos del cargo basico");
					throw new ProductDomainException(
							"Ocurrió un error al recuperar los descuentos del cargo basico", String
									.valueOf(codError), numEvento, msgError);
					
				}else{
					cat.debug("Recuperando descuentos");
					ArrayList lista = new ArrayList();
					rs = (ResultSet) cstmt.getObject(11);
					while (rs.next()) {
						DescuentoDTO descuentoDTO = new DescuentoDTO();
						descuentoDTO.setTipoAplicacion(rs.getString(1));
						descuentoDTO.setCodMoneda(rs.getString(2));
						descuentoDTO.setMonto(rs.getFloat(3));
						descuentoDTO.setCodigoConcepto(rs.getString(4));
						lista.add(descuentoDTO);
						cat.debug("[getDescuentoCodigoConcpeto]: " + rs.getString(4));
						cat.debug("[getDescuentoDescripcionConcepto] : " + rs.getString(2));
						cat.debug("[getDescuentoMonto]: " + rs.getFloat(3));
						
					}					
					resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
					cat.debug("Fin recuperacion de descuentos del cargo basico");
				}
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo basico",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductDomainException(
						"Ocurrió un error al recuperar los descuentos del cargo basico",e);
			} finally {
			 	if (cat.isDebugEnabled()) 
					cat.debug("Cerrando conexiones...");
				try {
					if (rs!=null)
						rs.close();
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
		 * @throws ProductDomainException
		 */
		public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) 
			throws ProductDomainException
		{
			cat.debug("Inicio:getDescuentoCargoConcepto()");
			DescuentoDTO[] resultado = null;
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			ResultSet rs = null;
			try {
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",19);
				cat.debug("sql[" + call + "]");
				
				cstmt = conn.prepareCall(call);
				
				cstmt.setString(1,entrada.getCodigoOperacion());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getCodigoOperacion() : " + entrada.getCodigoOperacion());
				cstmt.setString(2,entrada.getCodigoAntiguedad());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO  entrada.getCodigoAntiguedad()  : " + entrada.getCodigoAntiguedad());
				cstmt.setString(3,entrada.getTipoContrato());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getTipoContrato() : " + entrada.getTipoContrato());
				cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getNumeroMesesNuevo() : " + entrada.getNumeroMesesNuevo());
				cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getIndiceVentaExterna() : " + entrada.getIndiceVentaExterna());
				cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getCodigoVendedor() : " + entrada.getCodigoVendedor());
				cstmt.setString(7,entrada.getCodigoCausaVenta());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getCodigoCausaDescuento() : " + entrada.getCodigoCausaVenta() );
				cstmt.setString(8,entrada.getCodigoCategoria());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getCodigoCategoria() : " + entrada.getCodigoCategoria());
				cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getCodigoModalidadVenta() : " + entrada.getCodigoModalidadVenta());
				cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getTipoPlanTarifario() : "  +entrada.getTipoPlanTarifario());
				cstmt.setInt(11,Integer.parseInt(entrada.getConcepto()));
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getConcepto() : " + entrada.getConcepto());
				cstmt.setString(12,entrada.getClaseDescuento());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getClaseDescuento() : " + entrada.getClaseDescuento());
				cstmt.setString(13,entrada.getCodigoCalificaion());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getCodigoCalificaion() : " + entrada.getCodigoCalificaion());
				cstmt.setInt(14,entrada.getIndRenovacion());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO entrada.getIndRenovacion() : " + entrada.getIndRenovacion());
				cstmt.setInt(15,entrada.getIndRenovacion());
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO ind PriSeg : "+entrada.getIndRenovacion());
				
				cstmt.registerOutParameter(16,OracleTypes.CURSOR);
				//-- control error
				cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO Antes exec");
				cstmt.execute();
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO Despues exec");
				
				codError = cstmt.getInt(17);
				msgError = cstmt.getString(18);
				numEvento = cstmt.getInt(19);
				
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO codError : " + codError);
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO msgError : " + msgError);
				cat.debug("Ingreso a getDescuentoCargoConcepto DAO numEvento : " + numEvento);
				

				if (codError != 0) {
					/*cat.error("Ocurrió un error al recuperar los descuentos del cargo");
					throw new ProductDomainException(
							"Ocurrió un error al recuperar los descuentos del cargo", String
									.valueOf(codError), numEvento, msgError);*/
					
				}else{
					cat.debug("Recuperando descuentos");
					ArrayList lista = new ArrayList();
					rs = (ResultSet) cstmt.getObject(16);
					while (rs.next()) {						
						DescuentoDTO descuentoDTO = new DescuentoDTO();
						descuentoDTO.setTipoAplicacion(rs.getString(1));						
						descuentoDTO.setCodMoneda(rs.getString(2));						
						descuentoDTO.setMonto(rs.getFloat(3));						
						descuentoDTO.setCodigoConcepto(rs.getString(4));												
						lista.add(descuentoDTO);
					}					
					resultado =(DescuentoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
						lista.toArray(), DescuentoDTO.class);
					cat.debug("Fin recuperacion de descuentos del cargo");
				}
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductDomainException(
						"Ocurrió un error al recuperar los descuentos del cargo",e);
			} finally {
			 	if (cat.isDebugEnabled()) 
					cat.debug("Cerrando conexiones...");
				try {
					if (rs!=null)
						rs.close();
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
		 * @throws ProductDomainException
		 */
		public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) 
			throws ProductDomainException
		{
			cat.debug("Inicio:getCodigoDescuentoManual()");
			DescuentoDTO resultado = new DescuentoDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
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

				if (codError == 0) 
					resultado.setCodigoConcepto(String.valueOf(cstmt.getInt(3)));
				
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar el código de descuento manual",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
				throw new ProductDomainException(
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
			throws ProductDomainException
		{
			cat.debug("Inicio:verificaRechazoSerie()");
			ResultadoValidacionLogisticaDTO resultado = new ResultadoValidacionLogisticaDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("VE_validacion_linea_PG","VE_verifica_rechazo_serie_PR",5);
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
				int res = cstmt.getInt(2);
				resultado.setResultadoBase(res);	
			} 
			catch (Exception e) {
				cat.error("Ocurrió un error al consultar si la serie fue rechazada",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
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
		 * @throws ProductDomainException
		 */
		public TerminalDTO actualizaStockTerminal(TerminalDTO terminal)
			throws ProductDomainException
		{			
		
			TerminalDTO resultado = new TerminalDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				cat.debug("Inicio:actualizaStockTerminal");
				
				String call = getSQLDatosTerminal("VE_intermediario_PG","VE_actualiza_stock_PR",14);

				cat.debug("sql[" + call + "]");

				cstmt = conn.prepareCall(call);

				cstmt.setString(1,terminal.getTipoMovimiento());
				cstmt.setString(2,terminal.getTipoStock());
				cstmt.setString(3,terminal.getCodigoBodega());
				cstmt.setString(4,terminal.getCodigoArticulo());
				cstmt.setString(5,String.valueOf(terminal.getCodigoUso()));
				cstmt.setString(6,terminal.getEstado());
				cstmt.setString(7,terminal.getNumeroVenta());
				cstmt.setString(8,terminal.getNumeroSerie());
				cstmt.setString(9,terminal.getIndicadorTelefono());
				
				cat.debug("TERMINAL simcard.getTipoMovimiento() : " + terminal.getTipoMovimiento());
				cat.debug("TERMINAL simcard.getTipoStock() : " + terminal.getTipoStock());
				cat.debug("TERMINAL simcard.getCodigoBodega() : " + terminal.getCodigoBodega());
				cat.debug("TERMINAL simcard.getCodigoArticulo() : " + terminal.getCodigoArticulo());
				cat.debug("TERMINAL simcard.getCodigoUso() : " + terminal.getCodigoUso());
				cat.debug("TERMINAL simcard.getEstado() : " + terminal.getEstado());
				cat.debug("TERMINAL simcard.getNumeroVenta() : " + terminal.getNumeroVenta());
				cat.debug("TERMINAL simcard.getNumeroSerie() : " + terminal.getNumeroSerie());
				cat.debug("TERMINAL simcard.getIndicadorTelefono() : " + terminal.getIndicadorTelefono());

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

				cat.debug("Ingreso a actualizaStockTerminal DAO codError : " + codError);
				cat.debug("Ingreso a actualizaStockTerminal DAO msgError : " + msgError);
				cat.debug("Ingreso a actualizaStockTerminal DAO numEvento : " + numEvento);
				
				resultado.setNumeroMovimiento(cstmt.getString(10));
				resultado.setIndSerConTel(cstmt.getString(11));
				resultado.setCodigoError(codError);
				
			} catch (Exception e) {
				cat.error("Ocurrió un error al actualizar stock terminal",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
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
		 * @throws ProductDomainException
		 */
		public TerminalDTO getEstadoAnterior(TerminalDTO entrada) 
			throws ProductDomainException
		{
			cat.debug("Inicio:getEstadoAnterior()");
			TerminalDTO resultado = new TerminalDTO();
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null; 
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("VE_servicios_venta_PG","VE_consulta_estant_serie_PR",5);
				
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

				resultado.setEstadoAnterior(String.valueOf(cstmt.getInt(2)));
				
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			} catch (Exception e) {
				cat.error("Ocurrió un error al recuperar estado anterior de la serie del terminal",e);
				if (cat.isDebugEnabled()) {
					cat.debug("Codigo de Error[" + codError + "]");
					cat.debug("Mensaje de Error[" + msgError + "]");
					cat.debug("Numero de Evento[" + numEvento + "]");
				}
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
		 * @author mwn40031
		 * @param numSerie
		 * @return
		 * @throws ProductDomainException
		 */
		public Boolean validaSerieLN(String numSerie) throws ProductDomainException {
			/*
			 * PROCEDURE VE_VALIDA_SERIELN_PR (EN_NUM_SERIE IN GA_ABOCEL.NUM_SERIE%TYPE, SN_cod_retorno OUT NOCOPY
			 * ge_errores_pg.CodError, SV_mens_retorno OUT NOCOPY ge_errores_pg.MsgError, SN_num_evento OUT NOCOPY
			 * ge_errores_pg.Evento)
			 */

			cat.info("Inicio");
			final String nombrePackage = "VE_SERVICIOS_SOLICITUD_PG";
			final String nombrePL = "VE_VALIDA_SERIELN_PR";

			cat.debug("numSerie: " + numSerie);

			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = getConection();

			CallableStatement cstmt = null;

			int i = 1;
			int numParametros = 4;
			try {
				String call = getSQLDatosTerminal(nombrePackage, nombrePL, numParametros);
				cat.debug("SQL [" + call + "]");
				cstmt = conn.prepareCall(call);
				cstmt.setString(i++, numSerie);

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
					throw new ProductDomainException("Ocurrió un error al obtener datos", String.valueOf(codError),
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
				if (e instanceof ProductDomainException) {
					throw (ProductDomainException) e;
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
			cat.info("Fin");
			return Boolean.TRUE;
		}		
		//INICIO INC 187717 26/09/2012
		/**
		 * Obtiene numero de la movimiento, utilizado para desreservar la serie 
		 * @param entrada
		 * @return resultado
		 * @throws ProductDomainException
		 */
		public TerminalDTO getNumMovimmiento(TerminalDTO simcard) throws ProductDomainException {
			cat.debug("Inicio:getNumMovimmiento()");
			int codError = 0;
			String msgError = null;
			int numEvento = 0;
			Connection conn = null;
			CallableStatement cstmt = null;
			conn = getConection();
			try {
				String call = getSQLDatosTerminal("VE_intermediario_PG", "VE_obtiene_numero_movi_PR", 5);

				cat.debug("sql[" + call + "]");
				cstmt = conn.prepareCall(call);

				cstmt.setString(1, simcard.getNumeroSerie());
				cat.debug("simcard.getNumeroSerie() " + simcard.getNumeroSerie());
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

				cat.debug("Inicio:getNumMovimmiento:execute");
				cstmt.execute();
				cat.debug("Fin:getNumMovimmiento:execute");
				codError = cstmt.getInt(3);
				msgError = cstmt.getString(4);
				numEvento = cstmt.getInt(5);
				if (codError != 0) {
					cat.error("Ocurrió un error al buscar el numero de movimiento para la serie : "+simcard.getNumeroSerie());
					//throw new CustomerDomainException("Ocurrió un error al buscar el numero de movimiento para la serie :", String
					//		.valueOf(codError), numEvento, msgError);

				}
				else
					simcard.setNumeroMovimiento(String.valueOf(cstmt.getInt(2)));
				if (cat.isDebugEnabled()) {
					cat.debug(" Finalizo ejecución");
					cat.debug(" Recuperando salidas");
				}
			}
			catch (Exception e) {
				cat.error("Ocurrió un error al buscar el numero de movimiento para la seried", e);
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
			cat.debug("Fin:getNumMovimmiento()");
			return simcard;
		}//fin getNumMovimmiento
		//FIN INC 187717 26/09/2012
		
}//fin TerminalDAO

