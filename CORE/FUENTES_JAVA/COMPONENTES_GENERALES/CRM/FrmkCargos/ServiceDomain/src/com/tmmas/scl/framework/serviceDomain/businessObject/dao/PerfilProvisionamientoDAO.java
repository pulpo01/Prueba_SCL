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
 * 03-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.Connection;
import java.sql.SQLException;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.PerfilProvisionamientoDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.PerfilProvisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class PerfilProvisionamientoDAO extends ConnectionDAO implements PerfilProvisionamientoDAOIT
{
	private final Logger logger = Logger.getLogger(PerfilProvisionamientoDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLinformar() 
	{
		StringBuffer call = new StringBuffer();		
		call.append(" DECLARE ");
		call.append("   EO_PROVISION IC_PROVISION_QT; ");
		call.append("   SN_ERROR NUMBER; ");
		call.append("   SV_MENSAJE VARCHAR2(200); ");
		call.append("   SN_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   IC_PROVISION_PG.IC_INSERTA_PR(?,?,?,?); ");
		call.append(" END; ");		
		return call.toString();		
	}			

	public RetornoDTO informar(PerfilProvisionamientoDTO perfilProvListDTO) throws ServiceException 
	{
		logger.debug("informar ... DAO ():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLinformar();
		try {			
						
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt =  (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("IC_PROVISION_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, perfilProvListDTO.toStruct_IC_PROVISION_QT());
			
			// SE LLENAN PARAMETROS SEGUN PL
			cstmt.setObject(1, oracleObject);
			
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
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
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			
			retorno.setCodigo(String.valueOf(codError));
			retorno.setDescripcion(msgError);
			retorno.setResultado(true);
			//fin----------------------------------------------------------------------
		
		} catch (ServiceException e) {
			logger.debug("ServiceException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new ServiceException("Ocurrió un error general al eliminar fin ciclo",e);
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
		logger.debug("informar DAO ():end");
		return retorno;		
	}

	

}
