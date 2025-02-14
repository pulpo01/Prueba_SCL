/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.CatalogoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DescuentoProductoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public class CatalogoDAO extends ConnectionDAO implements CatalogoDAOIT
{
	private final Logger logger = Logger.getLogger(PlanTarifarioDAO.class);

	private final Global global = Global.getInstance();
	
	private Connection getConection() throws ProductOfferingException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new ProductOfferingException("No se pudo obtener una conexión", e1);
		}

		return conn;
	}	
	
	private String getSQLobtenerCargosProductos()
	{
		StringBuffer call=new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_CATALOGOS PF_CATALOGO_OFER_TD_QT; ");
		call.append("   SO_LISTA_CATALOGOS PF_CATALOGO_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PF_CATALOGO_PG.PF_DETALLE_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();
	}

	
	private String getSQLobtenerProductosOfertables()
	{
		StringBuffer call=new StringBuffer();		
		call.append(" DECLARE ");
		call.append("   EO_CATALOGOS PF_CATALOGO_OFER_TD_QT; ");
		call.append("   SO_LISTA_CATALOGOS PF_CATALOGO_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PF_CATALOGO_PG.PF_CANAL_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();
	}
	
	private String getSQLobtenerDescuentosCargo()
	{
		StringBuffer call=new StringBuffer();		
		call.append(" DECLARE ");
		call.append("   EO_DESC_CONCEPT PF_DESC_CONCEPTOS_TD_QT; ");
		call.append("   SO_DESC_CONCEPT PF_DESC_CONCEPTOS_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   PF_DESC_CONCEPTOS_PG.PF_DESCUENTO_S_PR(?,?,?,?,?); ");
		call.append(" END; ");
		return call.toString();
	}

	public CargoListDTO obtenerCargosProductos(CatalogoDTO catalogoOfertado) throws ProductOfferingException 
	{		
		logger.debug("Inicio:obtenerCargosProductos()");
		CargoListDTO resultado=new CargoListDTO();
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		conn = getConection();
		try {
			String call = getSQLobtenerCargosProductos();
			logger.debug("sql[" + call + "]");		

			cstmt = (OracleCallableStatement)conn.prepareCall(call);
				
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_CATALOGO_OFER_TD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, catalogoOfertado.toStruct_PF_CATALOGO_OFER_TD_QT());
			
			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);						
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);				

			logger.debug("Inicio:obtenerCargosProductos:execute");
			cstmt.execute();
			logger.debug("Fin:obtenerCargosProductos:execute");

			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en el registro de intarcel");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			CargoDTO dto=null;
			CargoDTO[] dtoList=null;
			ArrayList oracleReturn=new ArrayList();
			ResultSet rs=(ResultSet)cstmt.getObject(2);			
			
			while(rs.next())
			{
				dto=new CargoDTO();
				dto.setCodProducto(rs.getString("cod_prod_ofertado")!=null?rs.getString("cod_prod_ofertado"):"");
				dto.setDescripcion(rs.getString("des_concepto")!=null?rs.getString("des_concepto"):"");
				dto.setIdCargo(rs.getString("cod_cargo")!=null?rs.getString("cod_cargo"):"");				
				dto.setCodConcepto(rs.getString("cod_concepto")!=null?rs.getString("cod_concepto"):"");
				dto.setImporte(rs.getString("monto_importe")!=null?rs.getString("monto_importe"):"");
				dto.setMoneda(rs.getString("cod_moneda")!=null?rs.getString("cod_moneda"):"");
				dto.setDesMoneda(rs.getString("des_moneda")!=null?rs.getString("des_moneda"):"");
				dto.setIndProrrateable(rs.getString("ind_prorrateable")!=null?rs.getString("ind_prorrateable"):"");
				dto.setTipoCargo(rs.getString("tipo_cargo")!=null?rs.getString("tipo_cargo"):"");
				oracleReturn.add(dto);
			}
			
			dtoList=(CargoDTO[])ArrayUtl.copiaArregloTipoEspecifico(oracleReturn.toArray(), CargoDTO.class);
			resultado.setCargoList(dtoList);			

			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar CargosProductos",e);
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
		logger.debug("Fin:obtenerCargosProductos()");
		return resultado;
	}

	public ProductoOfertadoListDTO obtenerProductosOfertables(AbonadoDTO abonado) throws ProductOfferingException 
	{
		logger.debug("Inicio:obtenerProductosOfertables()");
		
		ProductoOfertadoListDTO resultado=new ProductoOfertadoListDTO();
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		CatalogoDTO catalogo= abonado.getCatalogo();		
		conn = getConection();
		try 
		{
			String call = getSQLobtenerProductosOfertables();
			logger.debug("sql[" + call + "]");			
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_CATALOGO_OFER_TD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, catalogo.toStruct_PF_CATALOGO_OFER_TD_QT());

			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);						
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			//-- control error			

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error en el registro de intarcel");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//-- cargo basico
			ArrayList retornoPL=new ArrayList();
			ProductoOfertadoDTO[] listaRetorno=null;
			ProductoOfertadoDTO dto=null;
			
			
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			while(rs.next())
			{
				dto=new ProductoOfertadoDTO();
				dto.setIdProductoOfertado(rs.getString("COD_PROD_OFERTADO")!=null?rs.getString("COD_PROD_OFERTADO"):"");
				dto.setCodCategoria(rs.getString("COD_CATEGORIA")!=null?rs.getString("COD_CATEGORIA"):"");
				retornoPL.add(dto);
			}
			
			listaRetorno=(ProductoOfertadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), ProductoOfertadoDTO.class);
			resultado.setProductoList(listaRetorno);
			
			
			if (logger.isDebugEnabled()) 
			{
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener Productos Ofertables",e);
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

		logger.debug("Fin:obtenerProductosOfertables()");
		return resultado;
	}

	public DescuentoProductoListDTO obtenerDescuentosCargo(CatalogoDTO catalogo) throws ProductOfferingException 
	{
		logger.debug("Inicio:obtenerDescuentosCargo()");
		
		DescuentoProductoListDTO resultado=null;
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		OracleCallableStatement cstmt = null;		
				
		conn = getConection();
		try 
		{
			String call = getSQLobtenerDescuentosCargo();
			logger.debug("sql[" + call + "]");			
			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_DESC_CONCEPTOS_TD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, catalogo.toStruct_PF_DESC_CONCEPTOS_TD_QT());

			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2,oracle.jdbc.driver.OracleTypes.CURSOR);						
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);

			//-- control error			

			logger.debug("execute:antes");
			cstmt.execute();
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al obtener los descuentos de cargo");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//-- cargo basico
			ArrayList retornoPL=new ArrayList();
			DescuentoProductoDTO[] listaRetorno=null;
			DescuentoProductoDTO dto=null;
			resultado=new DescuentoProductoListDTO();
			
			
			ResultSet rs=(ResultSet)cstmt.getObject(2);
			
			while(rs.next())
			{
				dto=new DescuentoProductoDTO();
				dto.setCodConcepto(rs.getString("COD_CONCEPTO")!=null?rs.getString("COD_CONCEPTO"):"");
				dto.setCodConceptoDescuento(rs.getString("COD_CONCEPTO_DESCTO")!=null?rs.getString("COD_CONCEPTO_DESCTO"):"");
				dto.setCodCanal(rs.getString("COD_CANAL")!=null?rs.getString("COD_CANAL"):"");
				dto.setTipoVendedor(rs.getString("TIPO_VENDEDOR")!=null?rs.getString("TIPO_VENDEDOR"):"");
				dto.setCodVendedor(rs.getString("COD_VENDEDOR")!=null?rs.getString("COD_VENDEDOR"):"");
				dto.setFecInicioVigencia(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate("FEC_INICIO_VIGENCIA"):new Date());
				dto.setFecTerminoVigencia(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate("FEC_TERMINO_VIGENCIA"):null);
				dto.setTipDescuento(rs.getString("TIPO_DESCUENTO")!=null?rs.getString("TIPO_DESCUENTO"):"");
				dto.setValDescuento(rs.getString("VALOR_DESCUENTO")!=null?rs.getString("VALOR_DESCUENTO"):"");
				dto.setCodMoneda(rs.getString("COD_MONEDA")!=null?rs.getString("COD_MONEDA"):"");
				dto.setCodDescuento(rs.getString("COD_DESCUENTO")!=null?rs.getString("COD_DESCUENTO"):"");
				retornoPL.add(dto);				
			}			
			listaRetorno=(DescuentoProductoDTO[])ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), DescuentoProductoDTO.class);
			resultado.setDescuentoList(listaRetorno);
			
			
			if (logger.isDebugEnabled()) 
			{
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener Productos Ofertables",e);
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

		logger.debug("Fin:obtenerDescuentosCargo()");
		return resultado;
	}

}
