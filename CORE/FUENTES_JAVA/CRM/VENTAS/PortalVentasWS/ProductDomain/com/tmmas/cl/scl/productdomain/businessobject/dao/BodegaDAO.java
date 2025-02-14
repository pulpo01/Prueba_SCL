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
 * 14/05/2007     Héctor Hermosilla      					Versión Inicial
 */
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
import com.tmmas.cl.scl.crmcommon.commonapp.exception.ProductDomainException;
import com.tmmas.cl.scl.productdomain.businessobject.dto.ArticuloOutDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BodegaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.helper.Global;

public class BodegaDAO extends ConnectionDAO{
	
	private static Category cat = Category.getInstance(BodegaDAO.class);
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
	
	private String getSQLDatos(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatos
	
	
	public BodegaDTO[] getBodegas(BodegaDTO entrada) 
		throws ProductDomainException
	{
	    cat.debug("Inicio:getBodegas()");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		BodegaDTO[] resultado = null;
		Connection conn = null;
		CallableStatement cstmt =null;
		conn = getConection();
		ResultSet rs = null;
		cat.debug("Conexion obtenida OK");
		try {
		   String call = getSQLDatos("VE_PARAMETROS_COMERCIALES_PG", "VE_Obtiene_Bodegas_PR",5);
		   cat.debug("sql[" + call + "]");
		   
		   cstmt = conn.prepareCall(call);
		   
		   cstmt.setLong(1,entrada.getCodVendedor());		   
		   cstmt.registerOutParameter(2,OracleTypes.CURSOR);
		   cstmt.registerOutParameter(3,java.sql.Types.NUMERIC);
		   cstmt.registerOutParameter(4,java.sql.Types.VARCHAR);
		   cstmt.registerOutParameter(5,java.sql.Types.NUMERIC);
		   
		   cat.debug("getBodegas:Execute Antes");
		   cstmt.execute();		   
		   cat.debug("getBodegas:Execute Despues");
		   
		   codError = cstmt.getInt(3);
		   msgError = cstmt.getString(4);
		   numEvento = cstmt.getInt(5);
		 
		   cat.debug("codError[" + codError + "]");
		   cat.debug("msgError[" + msgError + "]");
		   cat.debug("numEvento[" + numEvento + "]");
		   
		   if (codError!=0) 
		   {
			    cat.error("Ocurrió un error al recuperar listado de bodegas ");
			    throw new ProductDomainException("Ocurrió un error al recuperar listado de bodegas", 
			    		String.valueOf(codError), numEvento, msgError);
		    
			}else{
				cat.debug("Recuperando listado de bodegas");
				ArrayList lista = new ArrayList();
				rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					BodegaDTO bodega = new BodegaDTO();
					bodega.setCodBodega(rs.getLong(1));
					bodega.setDescBodega(rs.getString(2));					
					lista.add(bodega);
				}				
				resultado =(BodegaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), BodegaDTO.class);
		  
				cat.debug("Fin recuperacion de listado de bodegas");
			}
		   
		   if (cat.isDebugEnabled())
		    cat.debug(" Finalizo ejecución");
		  } 
		  catch (Exception e) {
			   cat.error("Ocurrió un error al obtener listado de bodegas",e);
			   if (cat.isDebugEnabled()) {
			    cat.debug("Codigo de Error[" + codError + "]");
			    cat.debug("Mensaje de Error[" + msgError + "]");
			    cat.debug("Numero de Evento[" + numEvento + "]");
			   }
			   if (e instanceof ProductDomainException){
				  throw (ProductDomainException) e;
			   }
		  } 
		  finally {
		    if (cat.isDebugEnabled()) 
		    cat.debug("Cerrando conexiones...");
			   try {
				   if (rs != null) {
						rs.close();
				   }
				   if (cstmt != null) {
						cstmt.close();
				   }
				   if (!conn.isClosed()) {
				     conn.close();
				   }
			   } catch (SQLException e) {
			    cat.debug("SQLException", e);
			   }
		  }
		  cat.debug("getBodegas():end");
		return resultado;
	}//fin getBodegas
	
}//fin class bodegas
