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
 * 18/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.PaqueteOfertadoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public class PaqueteOfertadoDAO extends ConnectionDAO implements PaqueteOfertadoDAOIT 
{
	private final Logger logger = Logger.getLogger(PaqueteOfertadoDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLobtenerProductosOfertablesPorPaquete() {
		StringBuffer call = new StringBuffer();
		call.append("DECLARE");
		call.append("	EO_PROD_PADRE PF_PAQUETE_OFERTADO_TO_QT;");
		call.append("	SO_LISTA_PRODUCTOS PF_PAQUETE_OFERTADO_PG.refCursor;");
		call.append("	SN_COD_RETORNO NUMBER;");
		call.append("	SV_MENS_RETORNO VARCHAR2(200);");
		call.append("	SN_NUM_EVENTO NUMBER;");
		call.append("	BEGIN");		
		call.append("		PF_PAQUETE_OFERTADO_PG.PF_PAQUETE_S_PR(?,?,?,?,?);");									
		call.append("	END;");
		return call.toString();		
	}
	

	public ProductoOfertadoListDTO obtenerProductosOfertablesPorPaquete(PaqueteDTO paquete) throws ProductOfferingException {
		logger.debug("obtenerProductosOfertablesPorPaquete():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ProductoOfertadoListDTO listaProductosRetorno = null;
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerProductosOfertablesPorPaquete();
		try {		
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);			
			StructDescriptor sd = StructDescriptor.createDescriptor("PF_PAQUETE_OFERTADO_TO_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, paquete.toStruct_PF_PAQUETE_OFERTADO_TO_QT());
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
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
				logger.error(" Ocurrió un error al obtener obtener Productos Ofertables Por Paquete");
				throw new ProductOfferingException(String.valueOf(codError),numEvento, msgError);
			}
			
			logger.debug("Recuperando data...");
			//ini-----------OBTENER CURSORES DE SERVICIOS A ACTIVAR Y DESACTIVAR-------
			
			listaProductosRetorno = new ProductoOfertadoListDTO();
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			ArrayList listProdOfertados=new ArrayList();
			ProductoOfertadoDTO productoDTO=null;
			
			while(rs.next())
			{									
				productoDTO=new ProductoOfertadoDTO();				
				productoDTO.setCantidadDesplegado(rs.getString("num_veces_hijo")!=null?rs.getInt("num_veces_hijo"):0);
				productoDTO.setIdProductoOfertado(rs.getString("cod_prod_hijo")!=null?rs.getString("cod_prod_hijo"):"");								
				listProdOfertados.add(productoDTO);				
			}			
			ProductoOfertadoDTO[] prodList=(ProductoOfertadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listProdOfertados.toArray(), ProductoOfertadoDTO.class);
			listaProductosRetorno.setProductoList(prodList);
			
			//fin-------------------------------------------------------------------
		
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Productos Ofertables Por Paquete", e);
			throw new ProductOfferingException("Ocurrió un error general al obtener Productos Ofertables Por Paquete",e);
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
		logger.debug("obtenerProductosOfertablesPorPaquete():end");
		return listaProductosRetorno;
	}

}
