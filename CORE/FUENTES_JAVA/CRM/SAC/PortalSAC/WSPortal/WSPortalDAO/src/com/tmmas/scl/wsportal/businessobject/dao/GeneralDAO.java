/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.AtencionClienteDTO;
import com.tmmas.scl.wsportal.common.dto.GedParametrosDTO;
import com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.ResgistroAtencionDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class GeneralDAO extends BaseDAO
{
	private final Logger logger = Logger.getLogger(this.getClass());

	public GeneralDAO(){
		

	}
	
	/**
	 * Cerrar recursos.
	 * @overwrite
	 * @param conn the conn
	 * @param cstmt the cstmt
	 * @param rs TODO
	 * @throws SQLException the SQL exception
	 *
	 */
	protected void cerrarRecursos(Connection conn, CallableStatement cstmt, ResultSet rs) throws SQLException{
	
		if(null != conn){
			rs.close();
		}
		if(null != cstmt){
			cstmt.close();
		}
		if(null != conn){
			conn.close();
		}
		
	}

	private String getSQLObtenerValorGedParametros(){

		StringBuffer st = new StringBuffer();
		
		st.append(" DECLARE ");
//		st.append(" result ged_parametros.val_parametro%type; ");		
		st.append(" BEGIN ");
		st.append(" ? := GE_FN_DEVVALPARAM (?, ?, ?); ");
//		st.append(" ? := result; ");
		st.append(" END; ");
		
		return st.toString();
	    
	}
	
	/*
	 * Proyecto: P-CSR-11002
	 * Descripcion: Obtiene valor de la tabla GED_PARAMETROS 
	 * throws: PortalSACException
	 * 
	 */
	public String obtenerValorGedParametros(GedParametrosDTO parametrosDTO) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String result = null;
		String msgError = null;

		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = getSQLObtenerValorGedParametros();
			cstmt = conn.prepareCall(call);
			
			logger.debug("SQL[" + call + "]");
			logger.debug("codModulo: " + parametrosDTO.getCodModulo());
			logger.debug("codProducto: " + parametrosDTO.getCodProducto());
			logger.debug("nomParametro: " + parametrosDTO.getNomParametro());
			
			System.out.println("SQL[" + call + "]");
			System.out.println("codModulo: " + parametrosDTO.getCodModulo());
			System.out.println("codProducto: " + parametrosDTO.getCodProducto());
			System.out.println("nomParametro: " + parametrosDTO.getNomParametro());
			
			cstmt.registerOutParameter(1, java.sql.Types.VARCHAR); //Valor de retorno
			
			//Datos de entrada
			cstmt.setString(2, parametrosDTO.getCodModulo());
			cstmt.setString(3, parametrosDTO.getCodProducto().toString());
			cstmt.setString(4, parametrosDTO.getNomParametro());
		
			//Datos de salida 
			
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			result = cstmt.getString(1);
			
			if(logger.isDebugEnabled()){
				logger.debug("result[" + result + "]");
			}
			if ("ERROR".equals(result)){
				throw new PortalSACException(String.valueOf(config.getString("COD.ERR_SAC.0069")), 
						config.getString("DES.ERR_SAC.0069"));
			}

		}catch (java.lang.Exception e){
			e.printStackTrace();
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			throw pe;
		}finally{
			try{
				cerrarRecursos(conn, cstmt);
			}catch (Exception e){
				logger.error("Exception [" + e.getMessage() + "]", e);
			}
		}
		logger.debug(MENSAJE_FIN_LOG);
		return result;
	}
	
}