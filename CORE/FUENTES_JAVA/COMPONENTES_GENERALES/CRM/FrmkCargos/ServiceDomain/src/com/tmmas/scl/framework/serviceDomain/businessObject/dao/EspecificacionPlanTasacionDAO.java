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
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionPlanTasacionDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecPlanTasacionDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionPlanTasacionDAO extends ConnectionDAO implements EspecificacionPlanTasacionDAOIT
{
	private final Logger logger = Logger.getLogger(EspecificacionPlanTasacionDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLobtenerEspecPlanTasacion()
	{	
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	private String getSQLobtenerPlanesTasacion()
	{	
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append(" BEGIN ");
		call.append("   SE_TOL_PLANES_PG.SE_PLANES_TASACION_PR( ?, ?, ?, ?);");
		call.append(" END;");		
		return call.toString();		
	}

	public EspecPlanTasacionListDTO obtenerEspecPlanTasacion(EspecServicioClienteListDTO espServCltList) throws ServiceSpecEntitiesException 
	{
		logger.debug("obtenerEspecPlanTasacion():start");		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EspecPlanTasacionListDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerEspecPlanTasacion();		
		
		try {
			
			logger.debug("espServCltList.getEspServCliList().toString()[" + espServCltList.getEspServCliList().toString() + "]");
			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = conn.prepareCall(call);
			
			// SE LLENAN PARAMETROS SEGUN PL
			//cstmt.setArray(1, listaNumeros.getNumerosDTO());
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			//cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			//cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			//cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);			
		
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
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new EspecPlanTasacionListDTO();
			
			System.out.println("EspecificacionServicioAltamiraDAO DAO [OK]");
			
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Especificacion Plan Tasacion", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener Especificacion Plan Tasacion",e);
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
		logger.debug("obtenerEspecPlanTasacion():end");
		return retorno;				
	}
	
	public EspecPlanTasacionListDTO obtenerPlanesTasacion( ) throws ServiceSpecEntitiesException 
	{
		logger.debug("obtenerPlanesTasacion():start");		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EspecPlanTasacionListDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLobtenerPlanesTasacion();		
		
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSourceTol());			
			cstmt = conn.prepareCall(call);
			
			// SE LLENAN PARAMETROS SEGUN PL
			//ini------------------CONTINUAR CARGA DE PARAMETROS-------------------
			
			cstmt.registerOutParameter(1, oracle.jdbc.driver.OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

			logger.debug("execute:antes");
			
			cstmt.execute();	
			
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
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			ArrayList retornoPL=new ArrayList();
			retorno = new EspecPlanTasacionListDTO();
			EspecPlanTasacionDTO dto=null;
			EspecPlanTasacionDTO[] dtoList=null;
			ResultSet rs=(ResultSet)cstmt.getObject(1);
			
			while(rs.next())
			{
				dto=new EspecPlanTasacionDTO();
				
				dto.setIdPlanTasacion(rs.getString("COD_PLAN")!=null?rs.getString("COD_PLAN"):"");
				dto.setDescripcion(rs.getString("DESC_PLAN")!=null?rs.getString("DESC_PLAN"):"");
				dto.setTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString("TIPO_COMPORTAMIENTO"):"");
				dto.setTipoPlataforma(rs.getString("TIPO_PLATAFORMA")!=null?rs.getString("TIPO_PLATAFORMA"):"");	
				dto.setNombre(rs.getString("DESC_COMP")!=null?rs.getString("DESC_COMP"):"");
				retornoPL.add(dto);				
			}
			dtoList=(EspecPlanTasacionDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), EspecPlanTasacionDTO.class);
			retorno.setEspecPlanTasList(dtoList);
			
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Especificacion Plan Tasacion", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener Especificacion Plan Tasacion",e);
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
		logger.debug("obtenerPlanesTasacion():end");
		return retorno;				
	}

}
