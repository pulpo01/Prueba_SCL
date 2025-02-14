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
 * 17/10/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SCLEspecificacionProductoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public class SCLEspecificacionProductoDAO extends ConnectionDAO implements SCLEspecificacionProductoDAOIT
{
	
	private final Logger logger = Logger.getLogger(EspecificacionProductoDAO.class);
	private Global global = Global.getInstance();
		
	
	
	private String getSQLobtenerCuotasProducto()
	{
		StringBuffer call = new StringBuffer();
		
		call.append("DECLARE ");
		call.append("BEGIN ");
		call.append("	PV_CARGOS_PG.PV_OBTIENE_CUOTAS_PR(?,?,?,?); ");    
		call.append("END; ");

		return call.toString();		
	}	

	public CuotasProductoDTO[] obtenerCuotasProducto() throws ProductSpecificationException 
	{
		logger.debug("obtenerCuotasProducto():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;				
		Connection conn = null;
		OracleCallableStatement cstmt = null;		
		
		
		String call = getSQLobtenerCuotasProducto();		
		CuotasProductoDTO[] CuotasProducto = null;
		
		try {
					
			conn = getConnectionFromWLSInitialContext(global.getJndiForSCLDataSource());			
			cstmt = (OracleCallableStatement) conn.prepareCall(call);
										
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
		
			logger.debug("execute:antes");			
			cstmt.execute();				
			logger.debug("execute:despues");
			
			logger.debug("Recuperando salidas");
			codError = cstmt.getInt(2);
			logger.debug("codError[" + codError + "]");
			msgError = cstmt.getString(3);
			logger.debug("msgError[" + msgError + "]");
			numEvento = cstmt.getInt(4);
			logger.debug("numEvento[" + numEvento + "]");
			//fin----------------------------------------------------------------------
			
			if (codError != 0) {
				logger.error(" Ocurrió un error al ");
				throw new ProductSpecificationException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------				
			
 
			ArrayList List=new ArrayList();			
			CuotasProductoDTO dto = null;
			ResultSet rs = (ResultSet) cstmt.getObject(1);
			
			while(rs.next())
			{
				dto=new CuotasProductoDTO();	
				
				dto.setCod_cuota(rs.getString("cod_cuota")!=null?rs.getString("cod_cuota"):"");
				dto.setDes_cuota(rs.getString("des_cuota")!=null?rs.getString("des_cuota"):"");
				dto.setNum_cuotas(rs.getInt("num_cuotas"));
				dto.setDefual_cuota(rs.getInt("defual"));
				List.add(dto);
			}		
			CuotasProducto=(CuotasProductoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(List.toArray(), CuotasProductoDTO.class);
			
			//fin----------------------------------------------------------------------
		
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Cuotas de Producto", e);
			throw new ProductSpecificationException("Ocurrió un error general al obtener Cuotas Producto",e);
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
		
		logger.debug("obtenerCuotasProducto():end");
		return CuotasProducto;				
	}
}
