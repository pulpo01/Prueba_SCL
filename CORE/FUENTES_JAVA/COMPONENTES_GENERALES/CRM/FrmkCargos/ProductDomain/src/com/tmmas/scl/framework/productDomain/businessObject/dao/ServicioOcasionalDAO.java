
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
 * 19/07/2007			   Raúl Lozano				       Versión Inicial         
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
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.ServicioOcasionalDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesPVDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class ServicioOcasionalDAO extends ConnectionDAO implements ServicioOcasionalDAOIT{
	
	private final Logger logger = Logger.getLogger(ServicioOcasionalDAO.class);
	
	private final Global global = Global.getInstance();
	
	

	private String getSQLDatosServOcac(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosServOcac

	private String getSQLExistCodConceptoArt() {
		StringBuffer call = new StringBuffer();
		
		call.append(" DECLARE ");
		call.append("  SO_ARTICULO PV_TIPOS_PG.TIP_AL_ARTICULOS;");

		call.append(" BEGIN ");
		call.append("    SO_ARTICULO(1).cod_conceptoart := ?;");
		call.append("    PV_CARGOS_PG.PV_OBTIENE_CODCONCEPTOART_PR ( SO_ARTICULO, ?, ?, ? );");
		call.append("    ?:=SO_ARTICULO(1).cod_proveedor; ");
		call.append("    ?:=SO_ARTICULO(1).cod_producto; ");
		call.append("    ?:=SO_ARTICULO(1).ind_agru; ");
		call.append("    ?:=SO_ARTICULO(1).ind_obs; "); 
		call.append("    ?:=SO_ARTICULO(1).ind_oracle; ");
		call.append("    ?:=SO_ARTICULO(1).ind_seriado; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_fabricante; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_unidad; "); 
		call.append("    ?:=SO_ARTICULO(1).mes_caducidad; "); 
		call.append("    ?:=SO_ARTICULO(1).mes_fabricante; "); 
		call.append("    ?:=SO_ARTICULO(1).mes_garantia; "); 
		call.append("    ?:=SO_ARTICULO(1).mes_afijo; "); 
		call.append("    ?:=SO_ARTICULO(1).tip_articulo; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_conceptoart; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_conceptoartalq; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_conceptodto; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_conceptodtoalq; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_articulo; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_grpconcepto; "); 
		call.append("    ?:=SO_ARTICULO(1).ind_equiacc; "); 
		call.append("    ?:=SO_ARTICULO(1).ind_proc; "); 
		call.append("    ?:=SO_ARTICULO(1).tip_terminal; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_modelo; "); 
		call.append("    ?:=SO_ARTICULO(1).cod_barras; "); 
		call.append("    ?:=SO_ARTICULO(1).ref_fabricante; "); 
		call.append("    ?:=SO_ARTICULO(1).des_articulo; ");
		call.append(" END;");
		return call.toString();		
	}	
	
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesDTO entrada) 
	throws ProductException{
		logger.debug("Inicio:getCargoServOcac()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement  cstmt =null;
		//conn = getConection();
		try {
			String call = getSQLDatosServOcac("PV_SERVICIOS_POSVENTA_PG","VE_precio_cargo_servocac_PR",13);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			logger.debug("SERVOCAC:DAO:CodigoProducto      : " + entrada.getCodigoProducto());
			logger.debug("SERVOCAC:DAO:CodigoArticulo      : " + entrada.getCodigoArticulo());
			logger.debug("SERVOCAC:DAO:CodigoPlanTarifario : " + entrada.getCodigoPlanTarifario());
			logger.debug("SERVOCAC:DAO:CodigoUso           : " + entrada.getCodigoUso());
			logger.debug("SERVOCAC:DAO:ModalidadVenta      : " + entrada.getModalidadVenta());
			logger.debug("SERVOCAC:DAO:NumeroMeses         : " + entrada.getNumeroMeses());
			logger.debug("SERVOCAC:DAO:TipoStock           : " + entrada.getTipoStock());
			logger.debug("SERVOCAC:DAO:IndicadorComodato   : " + entrada.getIndicadorComodato());
			logger.debug("SERVOCAC:DAO:CodigoActuacion     : " + entrada.getCodigoActuacion());
			
			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getCodigoProducto());
			cstmt.setString(2,entrada.getCodigoArticulo());
			cstmt.setString(3,entrada.getCodigoPlanTarifario());
			cstmt.setString(4,entrada.getCodigoUso());
			cstmt.setString(5,entrada.getModalidadVenta());
			cstmt.setString(6,entrada.getNumeroMeses());
			cstmt.setString(7,entrada.getTipoStock());
			cstmt.setString(8,entrada.getIndicadorComodato());
			cstmt.setString(9,entrada.getCodigoActuacion());

			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(10,OracleTypes.CURSOR);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getCargoServOcac:Execute");
			cstmt.execute();
			logger.debug("Fin:getCargoServOcac:Execute");
			
			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar cargo servicio ocacional");
				throw new ProductException(
						"Ocurrió un error al recuperar cargo servicio ocacional", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				logger.debug("Recuperando cargo servicio suplementario");
				ArrayList lista = new ArrayList();
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
					precioDTO.setIndicadorAutMan(rs.getString(8));
					precioDTO.setNumeroUnidades(rs.getString(9));
					precioDTO.setIndicadorEquipo(rs.getString(10));
					precioDTO.setIndicadorPaquete(rs.getString(11));
					precioDTO.setMesGarantia(rs.getString(12));
					precioDTO.setIndicadorAccesorio(rs.getString(13));
					precioDTO.setIndiceVenta(rs.getString(14));
					
					lista.add(precioDTO);
					logger.debug("ENCONTRO PRECIO" + precioDTO.getCodigoConcepto());
				}
				rs.close();
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PrecioCargoDTO.class);
				
				logger.debug("Fin recuperacion cargo servicio ocacional");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar cargo servicio ocacional",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al recuperar cargo servicio ocacional",e);
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
		
		logger.debug("Fin:getCargoServOcac()");

		return resultado;
	}//fin getCargoServOcac
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesPVDTO entrada) 
	throws ProductException{
		logger.debug("Inicio:getCargoServOcac()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement  cstmt =null;
		ResultSet rs=null;
		
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			//conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			String call = getSQLDatosServOcac("PV_cargos_PG","VE_List_cargos_Ocasionales_PR",9);
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			logger.debug("Codigo Producto      : " + entrada.getCodProducto());
			logger.debug("Codigo de Actuacion de Abonado : " + entrada.getCodActuacion());
			logger.debug("Codigo tipo servicio : " + entrada.getCodTipoServicio());
			logger.debug("Codigo concepto      : " + entrada.getCodConcepto());
			logger.debug("Codigo plan servicio : " + entrada.getCodPlanServicio());
			
			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getCodProducto());
			cstmt.setString(2,entrada.getCodActuacion());
			cstmt.setString(3,entrada.getCodTipoServicio());
			cstmt.setString(4,entrada.getCodConcepto());
			cstmt.setString(5,entrada.getCodPlanServicio());

			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(6,OracleTypes.CURSOR);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getCargoServOcac:Execute");
			cstmt.execute();
			logger.debug("Fin:getCargoServOcac:Execute");
			
			codError = cstmt.getInt(7);
			msgError = cstmt.getString(8);
			numEvento = cstmt.getInt(9);

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar cargo servicio ocacional");
				throw new ProductException(
						"Ocurrió un error al recuperar cargo servicio ocacional", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				logger.debug("Recuperando cargo servicio suplementario");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(6);
				while (rs.next()) {
					PrecioCargoDTO precioDTO = new PrecioCargoDTO();
					
					precioDTO.setIndicadorAutMan(rs.getString(1));
					precioDTO.setDescripcionConcepto(rs.getString(2));
					precioDTO.setMonto(rs.getFloat(3));
					precioDTO.setDescripcionMoneda(rs.getString(4));
					precioDTO.setCodigoConcepto(rs.getString(5));
					precioDTO.setCodigoMoneda(rs.getString(6));
					
					
					/*
					precioDTO.setValorMinimo(rs.getString(6));
					precioDTO.setValorMaximo(rs.getString(7));
					precioDTO.setNumeroUnidades(rs.getString(9));
					precioDTO.setIndicadorEquipo(rs.getString(10));
					precioDTO.setIndicadorPaquete(rs.getString(11));
					precioDTO.setMesGarantia(rs.getString(12));
					precioDTO.setIndicadorAccesorio(rs.getString(13));
					precioDTO.setIndiceVenta(rs.getString(14));*/
					//c.ind_autman, c.des_servicio,b.imp_tarifa, d.des_moneda, a.cod_concepto, b.cod_moneda
					//     1				2			3				4			5				6     
					lista.add(precioDTO);
					logger.debug("ENCONTRO PRECIO " + precioDTO.getCodigoConcepto());
				}
				rs.close();
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PrecioCargoDTO.class);
				
				logger.debug("Fin recuperacion cargo servicio ocacional");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar cargo servicio ocacional",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al recuperar cargo servicio ocacional",e);
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (rs!=null){
					rs.close();
				}
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		
		logger.debug("Fin:getCargoServOcac()");

		return resultado;
	}//fin getCargoServOcac
	/**
	 * Busca todos los Descuentos tipo Articulo asociados al Servicio 
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
		CallableStatement  cstmt =null;
		//conn = getConection();
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLDatosServOcac("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_descuento_art_PR",14);
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
				//TODO: RLOZANO : ANALIZAR EL CASO PARA LSO DESCUENTOS POR ARTICULO
				/*throw new ProductException(
						"Ocurrió un error al recuperar los descuentos del cargo basico", String
								.valueOf(codError), numEvento, msgError);*/
				
			}else{
				logger.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(11);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setCodigoMoneda(rs.getString(2));
					//descuentoDTO.setDescripcionConcepto(rs.getString(2));
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
	 * Busca todos los Descuentos tipo concepto asociados al Servicio 
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
		CallableStatement  cstmt =null;
		//conn = getConection();
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLDatosServOcac("PV_SERVICIOS_POSVENTA_PG","VE_obtiene_descuento_con_PR",16);
			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoOperacion());
			cstmt.setString(2,entrada.getCodigoAntiguedad());
			cstmt.setString(3,entrada.getCodigoContratoNuevo());
			cstmt.setInt(4,Integer.parseInt(entrada.getNumeroMesesNuevo()));
			cstmt.setInt(5,Integer.parseInt(entrada.getIndiceVentaExterna()));
			cstmt.setLong(6,Long.parseLong(entrada.getCodigoVendedor()));
			cstmt.setString(7,entrada.getCodigoCausaVenta());
			cstmt.setString(8,entrada.getCodigoCategoria());
			cstmt.setInt(9,Integer.parseInt(entrada.getCodigoModalidadVenta()));
			cstmt.setInt(10,Integer.parseInt(entrada.getCodigoTipoPlanTarifario()));
			cstmt.setInt(11,Integer.parseInt(entrada.getCodigoConcepto()));
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

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar los descuentos del cargo");
				//TODO: ANALIZAR EL CASO PARA LOS DECUENTOS POR CONCEPTO
				/*throw new ProductException(
						"Ocurrió un error al recuperar los descuentos del cargo", String
								.valueOf(codError), numEvento, msgError);*/
				
			}else{
				logger.debug("Recuperando descuentos");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(13);
				while (rs.next()) {
					DescuentoDTO descuentoDTO = new DescuentoDTO();
					descuentoDTO.setTipoAplicacion(rs.getString(1));
					descuentoDTO.setCodigoMoneda(rs.getString(2));
					//descuentoDTO.setDescripcionConcepto();
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
	}//fin getDescuentoCargoConcepto	

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
		CallableStatement  cstmt =null;
		//conn = getConection();
		try {
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLDatosServOcac("PV_SERVICIOS_POSVENTA_PG","VE_consulta_cod_desc_manual_PR",6);
			logger.debug("sql[" + call + "]");
			
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
	}//fin getCodigoDescuentoManual
	
	
	public boolean existeCodConcepArticulo(ArticuloDTO entrada) throws ProductException{
		logger.debug("Inicio:existeCodConcepArticulo()");
		boolean retValue = false;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement  cstmt =null;
		//conn = getConection();
		try {
			
			conn = getConnectionFromWLSInitialContext(global.getCPUJndiForDataSource());
			String call = getSQLExistCodConceptoArt();
			logger.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			logger.debug("Codigo Concepto Artículo    : " + entrada.getCod_conceptoart());
			
			//-- PARAMETROS DE ENTRADA
			cstmt.setInt(1,entrada.getCod_conceptoart());
			//-- PARAMETROS DE SALIDA
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(7, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(8, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(9, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(10, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(11, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(12, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(13, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(14, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(15, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(16, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(20, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(21, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(22, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(23, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(24, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(25, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(26, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(27, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(28, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(29, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(30, java.sql.Types.VARCHAR);
			
			logger.debug("Inicio:getCargoServOcac:Execute");
			cstmt.execute();
			logger.debug("Fin:getCargoServOcac:Execute");
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);

			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar código concepto articulo");
				throw new ProductException(
						"Ocurrió un error al recuperar código concepto articulo", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				logger.debug("Recuperando código concepto articulo");
				String codConcepto= cstmt.getString(17);
				retValue=codConcepto==null?false:true;
				logger.debug("Fin recuperacion código concepto articulo");
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar código concepto articulo",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductException(
					"Ocurrió un error al recuperar código concepto articulo",e);
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
		
		logger.debug("Fin:existeCodConcepArticulo()");

		return retValue;
	}//fin existeCodConcepArticulo
	
}//fin ServiciosOcacionalesDAO
