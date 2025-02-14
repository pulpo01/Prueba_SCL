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

import org.apache.log4j.Logger;

import com.tmmas.scl.wsportal.businessobject.dao.base.BaseDAO;
import com.tmmas.scl.wsportal.common.dto.MuestraURLDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

public class ComunDAO extends BaseDAO
{
	private static Logger logger = Logger.getLogger(ProductoDAO.class);

	protected static final String CLAVE_TEXTO_PARA_DETALLE = "texto.detalle.producto";

	protected static final String TEXTO_PARA_DETALLE = config.getString(CLAVE_TEXTO_PARA_DETALLE);

	public ComunDAO(){
		

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

	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-005 Agregar Comentario de OOSS Reversión de Cargos
	 * Requisito: RSis_003 
	 * Caso de uso: CU-006 Agregar Comentario de OOSS Ajuste por Excepción
	 * Developer: Gabriel Moraga L.
	 * Fecha: 04/08/2010
	 * Metodo: insertComentario
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta un comentario en la tabla CI_ORSERV
	 * throws: PortalSACException
	 * 
	 */
	
	public ResulTransaccionDTO insertComentario(String comentario, Long numOoss ) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "pv_inserta_comentario_pr";
		ResulTransaccionDTO resulTransaccionDTO = null;

		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("comentario: " + comentario);
				logger.debug("numOoss: " + numOoss.longValue());
			}
			
			//Datos de entrada
			cstmt.setString(1, comentario);
			cstmt.setLong(2, numOoss.longValue());
		
			//Datos de salida	 
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			//Set de los datos del abonado
			resulTransaccionDTO = new ResulTransaccionDTO();
			resulTransaccionDTO.setCodRetorno(cstmt.getLong(3));
			resulTransaccionDTO.setMenRetorno(cstmt.getString(4));
			resulTransaccionDTO.setNumEvento(cstmt.getLong(5));

		}catch (java.lang.Exception e){
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
		return resulTransaccionDTO;
	}
	
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_003 
	 * Caso de uso: CU-004 Agregar Comentario de OOSS Aviso de Siniestro
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/08/2010
	 * Metodo: insertComentarioPvIorserv
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta un comentario en la tabla PV_IORSERV
	 * throws: PortalSACException
	 * 
	 */
	
	public ResulTransaccionDTO insertComentarioPvIorserv(String comentario, Long numOoss ) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		final String nombrePL = "pv_insert_pv_iorserv_pr";
		ResulTransaccionDTO resulTransaccionDTO = null;

		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("comentario: " + comentario);
				logger.debug("numOoss: " + numOoss.longValue());
			}
			
			//Datos de entrada
			cstmt.setString(1, comentario);
			cstmt.setLong(2, numOoss.longValue());
		
			//Datos de salida	 
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //Numero de evento
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			//Set de los datos del abonado
			resulTransaccionDTO = new ResulTransaccionDTO();
			resulTransaccionDTO.setCodRetorno(cstmt.getLong(3));
			resulTransaccionDTO.setMenRetorno(cstmt.getString(4));
			resulTransaccionDTO.setNumEvento(cstmt.getLong(5));

		}catch (java.lang.Exception e){
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
		return resulTransaccionDTO;
	}
	
	/*
	 * Proyecto: P-CSR-11003 Mejoras al Portal SAC y Evolución Gestor Posventa P-CSR-11003
	 * Requisito: RSis_003 
	 * Developer: Rafael Aguero Vega.
	 * Fecha: 21/03/2011
	 * Metodo: solicitaUrlDominioPuerto
	 * Return: MuestraURLDTO
	 * Descripcion: ingresa el Codigo de orden de servicio y Solicitar URL con Dominio y Puerto
	 * throws: PortalSACException
	 * 
	 */
	
	public MuestraURLDTO solicitaUrlDominioPuerto(String strCodOrdenServ) throws PortalSACException{
		
		Connection conn = null;
		CallableStatement cstmt = null;
		final String nombrePL = "pv_obtiene_dominio_pr";
		MuestraURLDTO urldto = null;


		int codError = 0;
		int numEvento = 0;
		
		String msgError = null;
		
		try{
			
			logger.info(MENSAJE_INICIO_LOG);
			conn = obtenerConnection();
			
			String call = daoHelper.getPackageBD(NOMBRE_PACKAGE_BD_CONSULTAS, nombrePL, 5);
			cstmt = conn.prepareCall(call);
			
			if(logger.isDebugEnabled()){
				logger.debug("SQL[" + call + "]");
				logger.debug("Muestra de URL : " + strCodOrdenServ);
			}
			
			//Datos de entrada
			cstmt.setString(1, strCodOrdenServ);
		
			//Datos de salida	 
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR); //URL 
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC); //Codigo retorno
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR); //Mensaje retorno
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC); //Numero de evento

			if(logger.isDebugEnabled()){
				logger.debug("Execute Antes");
			}
			
			cstmt.execute();
			
			if(logger.isDebugEnabled()){
				logger.debug("Execute Despues");
			}
			
			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			if(logger.isDebugEnabled()){
				logger.debug("codError[" + codError + "]");
				logger.debug("msgError[" + msgError + "]");
				logger.debug("numEvento[" + numEvento + "]");
			}
			if (0 != codError){
				throw new PortalSACException(String.valueOf(codError), msgError, numEvento);
			}

			//Set de los datos del abonado
			urldto = new MuestraURLDTO();
			urldto.setStrUrlDomPuer(cstmt.getString(2));
			urldto.setCodRetorno(cstmt.getLong(3));
			urldto.setMenRetorno(cstmt.getString(4));
			urldto.setNumEvento(cstmt.getLong(5));

		}catch (java.lang.Exception e){
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
		return urldto;
	}
	
}