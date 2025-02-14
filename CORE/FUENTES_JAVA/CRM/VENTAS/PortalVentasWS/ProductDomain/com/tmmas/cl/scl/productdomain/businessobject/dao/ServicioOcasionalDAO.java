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
import com.tmmas.cl.scl.crmcommon.commonapp.dto.PrecioCargoDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ParametrosCargoServOcacionalesDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class ServicioOcasionalDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(ServicioSuplementarioDAO.class);
	Global global = Global.getInstance();
	
	private Connection getConection() 
	throws ProductDomainException
	{
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

	private String getSQLDatosServOcac(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosServOcac

	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesDTO entrada) 
		throws ProductDomainException
	{
		cat.debug("Inicio:getCargoServOcac()");
		PrecioCargoDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement  cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosServOcac("VE_servicios_venta_PG","VE_precio_cargo_servocac_PR",13);
			cat.debug("sql[" + call + "]");
			cstmt = conn.prepareCall(call);
			
			cat.debug("SERVOCAC:DAO:CodigoProducto      : " + entrada.getCodigoProducto());
			cat.debug("SERVOCAC:DAO:CodigoArticulo      : " + entrada.getCodigoArticulo());
			cat.debug("SERVOCAC:DAO:CodigoPlanTarifario : " + entrada.getCodigoPlanTarifario());
			cat.debug("SERVOCAC:DAO:CodigoUso           : " + entrada.getCodigoUso());
			cat.debug("SERVOCAC:DAO:ModalidadVenta      : " + entrada.getModalidadVenta());
			cat.debug("SERVOCAC:DAO:NumeroMeses         : " + entrada.getNumeroMeses());
			cat.debug("SERVOCAC:DAO:TipoStock           : " + entrada.getTipoStock());
			cat.debug("SERVOCAC:DAO:IndicadorComodato   : " + entrada.getIndicadorComodato());
			cat.debug("SERVOCAC:DAO:CodigoActuacion     : " + entrada.getCodigoActuacion());
			
			//-- PARAMETROS DE ENTRADA
			cstmt.setString(1,entrada.getCodigoProducto());
			cstmt.setString(2,entrada.getCodigoArticulo());
			cstmt.setString(3,entrada.getCodigoPlanTarifario());
			cstmt.setString(4,String.valueOf(entrada.getCodigoUso()));
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
			
			cat.debug("Inicio:getCargoServOcac:Execute");
			cstmt.execute();
			cat.debug("Fin:getCargoServOcac:Execute");
			
			codError = cstmt.getInt(11);
			msgError = cstmt.getString(12);
			numEvento = cstmt.getInt(13);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar cargo servicio ocacional");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar cargo servicio ocacional", String
								.valueOf(codError), numEvento, msgError);
				
			}else{
				cat.debug("Recuperando cargo servicio suplementario");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(10);
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
					cat.debug("ENCONTRO PRECIO" + precioDTO.getCodigoConcepto());
				}				
				resultado =(PrecioCargoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PrecioCargoDTO.class);
				
				cat.debug("Fin recuperacion cargo servicio ocacional");
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			cat.error("Ocurrió un error al recuperar cargo servicio ocacional",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new ProductDomainException(
					"Ocurrió un error al recuperar cargo servicio ocacional",e);
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
		
		cat.debug("Fin:getCargoServOcac()");

		return resultado;
	}//fin getCargoServOcac

	/**
	 * Busca todos los Descuentos tipo Articulo asociados al Servicio 
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
		CallableStatement  cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		try {
			String call = getSQLDatosServOcac("VE_servicios_venta_PG","VE_obtiene_descuento_art_PR",14);
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

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo basico");
				throw new CustomerDomainException(
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
	 * Busca todos los Descuentos tipo concepto asociados al Servicio 
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
		CallableStatement  cstmt =null;
		conn = getConection();
		ResultSet rs =  null;
		try {
			String call = getSQLDatosServOcac("VE_servicios_venta_PG","VE_obtiene_descuento_con_PR",19);
			cat.debug("sql[" + call + "]");
			
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
			cstmt.setInt(10,Integer.parseInt(entrada.getTipoPlanTarifario()));
			cstmt.setInt(11,Integer.parseInt(entrada.getConcepto()));
			cstmt.setString(12,entrada.getClaseDescuento());
			cstmt.setString(13,entrada.getCodigoCalificaion());
			cstmt.setInt(14,entrada.getIndRenovacion());
			cstmt.setInt(15,entrada.getIndRenovacion()); //ind priseg

			cstmt.registerOutParameter(16,OracleTypes.CURSOR);
			//-- control error
			cstmt.registerOutParameter(17, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(18, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(19, java.sql.Types.NUMERIC);
			
			cstmt.execute();
			
			codError = cstmt.getInt(17);
			msgError = cstmt.getString(18);
			numEvento = cstmt.getInt(19);

			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar los descuentos del cargo");
				throw new CustomerDomainException(
						"Ocurrió un error al recuperar los descuentos del cargo", String
								.valueOf(codError), numEvento, msgError);
				
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
		CallableStatement  cstmt =null;
		conn = getConection();
		try {
			String call = getSQLDatosServOcac("VE_servicios_venta_PG","VE_consulta_cod_desc_manual_PR",6);
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
	
}//fin ServiciosOcacionalesDAO
