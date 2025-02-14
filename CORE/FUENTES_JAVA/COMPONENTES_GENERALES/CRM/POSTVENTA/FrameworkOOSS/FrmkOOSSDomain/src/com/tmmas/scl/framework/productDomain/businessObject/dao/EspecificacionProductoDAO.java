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
 * 11-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.EspecificacionProductoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;



public class EspecificacionProductoDAO extends ConnectionDAO implements EspecificacionProductoDAOIT
{
	private final Logger logger = Logger.getLogger(EspecificacionProductoDAO.class);
	private Global global = Global.getInstance();
	
	private String getSQLobtenerEspecificacionProducto()
	{
		StringBuffer call = new StringBuffer();
		
		call.append("DECLARE ");
		call.append("  EO_ESPE_PRODUCTO PF_ESPEC_PRODUCTO_QT; ");
		call.append("  SO_LISTA_ESPE_PRODUCTOS PS_ESPEC_PRODUCTO_PG.refCursor; ");
		call.append("  SN_COD_RETORNO NUMBER; ");
		call.append("  SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("  SN_NUM_EVENTO NUMBER; ");
		call.append("BEGIN ");
		call.append("	PS_ESPEC_PRODUCTO_PG.PS_PRODUCTO_S_PR(?,?,?,?,?); ");    
		call.append("END; ");		

		return call.toString();		
	}
	
	private String getSQLobtenerTextoCarta(){
		StringBuffer call = new StringBuffer();
		call.append("DECLARE ");
		call.append("BEGIN ");
		call.append("  GE_CARTA_PG.GE_RECUPERA_CARTA_PR(?,?,?,?,?); ");
		call.append("END; ");
		return call.toString();
	}
	
	
	private String getSQLobtenerEspecificacionLista()
	{
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws ProductSpecificationException{
		logger.debug("obtenerTextoCarta():start");
		if(cartaGeneral==null){
			logger.debug("Objeto entrada es Nulo <<");
			return cartaGeneral;
		}
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;				
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerTextoCarta();
		
		
		try{
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor(cartaGeneral.getNombreStruct() , conn);
			
			STRUCT oracleObject= new STRUCT(sd, conn, cartaGeneral.toStruct());
			
			cstmt.setObject(1, oracleObject);
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("execute:antes");			
			cstmt.execute();				
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			cartaGeneral.setTexCarta(cstmt.getString(2));
			logger.debug("Texto Carta : " + cartaGeneral.getTexCarta());
			codError = cstmt.getInt(3);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(4);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(5);
			logger.debug("numEvento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al ");
				throw new ProductSpecificationException(String.valueOf(codError),numEvento, msgError);
			}
			
			
			
			
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Especificacion Producto", e);
			throw new ProductSpecificationException("Ocurrió un error general al obtener Especificacion Producto",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		
		logger.debug("obtenerTextoCarta():end");
		return cartaGeneral;
	}
	
	public ProductoOfertadoDTO obtenerEspecificacionProducto(ProductoOfertadoDTO prodOfertado) throws ProductSpecificationException 
	{
		logger.debug("obtenerEspecificacionProducto():start");
		
//		 EN CASO DE QUE LOS PARAMETROS DE ENTRADA VENGAN NULL SALE DEL METODO
		if(prodOfertado==null)
		{
			logger.debug("SALE <<");
			return prodOfertado;
		}
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;				
		Connection conn = null;
		OracleCallableStatement cstmt = null;		
		
		EspecProductoDTO especificacionProductoDTO=new EspecProductoDTO();
		especificacionProductoDTO.setIdEspecProducto(prodOfertado.getCodEspecProd()!=null?prodOfertado.getCodEspecProd():"");		
		especificacionProductoDTO.setIdEspecProducto(!"".equals(especificacionProductoDTO.getIdEspecProducto())?prodOfertado.getCodEspecProd():"-1");
		
		String call = getSQLobtenerEspecificacionProducto();		
		
		try {
			
			logger.debug("prodOfertadoList[" + prodOfertado + "]");
			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement) conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_ESPEC_PRODUCTO_QT", conn);
			STRUCT oracleObject= new STRUCT(sd, conn, especificacionProductoDTO.toStruct_PF_ESPEC_PRODUCTO_QT());
					
			
			cstmt.setObject(1, oracleObject);			
			cstmt.registerOutParameter(2, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
		
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
				logger.error(" Ocurrió un error al ");
				throw new ProductSpecificationException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------				
						
			EspecProductoDTO dto=null;			
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			
			if(rs.next())
			{				
				dto=new EspecProductoDTO();				
				dto.setIdEspecProducto(rs.getString("COD_ESPEC_PROD")!=null?rs.getString("COD_ESPEC_PROD"):"");
				dto.setNombre(rs.getString("ID_ESPEC_PROD")!=null?rs.getString("ID_ESPEC_PROD"):"");
				dto.setDescripcion(rs.getString("DES_ESPEC_PROD")!=null?rs.getString("DES_ESPEC_PROD"):"");
				dto.setFecIniVig(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate("FEC_INICIO_VIGENCIA"):new Date());
				dto.setFecTerVig(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate("FEC_TERMINO_VIGENCIA"):new Date());				
				dto.setIndTipoPlataforma(rs.getString("TIPO_PLATAFORMA")!=null?rs.getString("TIPO_PLATAFORMA"):"");				
				dto.setTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString("TIPO_COMPORTAMIENTO"):"");
			}		
			
			prodOfertado.setEspecificacionProducto(dto);	
			
			//fin----------------------------------------------------------------------
		
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Especificacion Producto", e);
			throw new ProductSpecificationException("Ocurrió un error general al obtener Especificacion Producto",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerEspecificacionProducto():end");
		return prodOfertado;				
	}

	public ProductoOfertadoListDTO obtenerEspecificacionLista(ProductoOfertadoListDTO prodOfertadoList) throws ProductSpecificationException {
		logger.debug("obtenerEspecificacionLista():start");		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;				
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerEspecificacionLista();		
		
		try {
			
			logger.debug("prodOfertadoList.getProductoList().toString()[" + prodOfertadoList + "]");
			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			
						
		
			logger.debug("execute:antes");
			
			//cstmt.execute();	
			
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			//codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			//msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			//numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al ");
				throw new ProductSpecificationException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
					
			
			
			
			//fin----------------------------------------------------------------------
		
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Especificacion Lista", e);
			throw new ProductSpecificationException("Ocurrió un error general al obtener Especificacion Lista",e);
		}
		finally {
			try {
				if (cstmt != null) {
					cstmt.close();
					cstmt = null;
				}
				if (conn != null) {
					if (!conn.isClosed()) {
						conn.close();
					}
					conn = null;
				}
			} catch (SQLException e) {
				cstmt = null;
				conn = null;
				logger.debug("SQLException[" + e + "]");
			}
		}
		logger.debug("obtenerEspecificacionLista():end");
		return prodOfertadoList;	
	}
		
}
