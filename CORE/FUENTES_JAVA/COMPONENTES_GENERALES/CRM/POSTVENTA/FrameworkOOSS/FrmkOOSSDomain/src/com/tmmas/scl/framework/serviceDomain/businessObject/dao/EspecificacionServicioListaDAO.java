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

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionServicioListaDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionServicioListaDAO extends ConnectionDAO implements EspecificacionServicioListaDAOIT
{
	private final Logger logger = Logger.getLogger(EspecificacionPlanTasacionDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLobtenerReglasValidacion()
	{	
		StringBuffer call = new StringBuffer();		
		call.append(" DECLARE ");
		call.append("   EO_DET_PERFIL SE_DETALLE_PERFIL_TD_QT; ");
		call.append("   SO_DET_PERFIL_CUR SE_DETALLE_PERFIL_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   SE_DETALLE_PERFIL_PG.SE_PERFIL_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();		
	}
	
	private String getSQLobtenerEspecServicioLista()
	{	
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE ");
		call.append("   EO_PERFIL_LISTA SE_PERFIL_LISTA_TD_LST_QT; ");
		call.append("   SO_PERFIL_LISTA_CUR SE_PERFIL_LISTA_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   SE_PERFIL_LISTA_PG.SE_SERVICIO_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();		
	}
	

	public ReglasListaNumerosListDTO obtenerReglasValidacion(EspecServicioListaDTO especServicioLista) throws ServiceSpecEntitiesException 
	{
		logger.debug("obtenerReglasValidacion():start");		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		ReglasListaNumerosListDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;
		
		String call = getSQLobtenerReglasValidacion();
		
		if(false)
		{
			logger.debug("Parametros de entrada no llenados correctamente");		
			return null;
		}
		
		try {			
			logger.debug("pespecServicioLista[" + especServicioLista + "]");
						
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);			
			
			StructDescriptor sd = StructDescriptor.createDescriptor("SE_DETALLE_PERFIL_TD_QT", conn);			
			STRUCT oracleObject = new STRUCT(sd, conn, especServicioLista.getStruct_SE_DETALLE_PERFIL_TD_QT());
			
			// SE LLENAN PARAMETROS SEGUN PL
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
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			ArrayList retornoPL = new ArrayList();
			ReglasListaNumerosDTO dto=null; 
			ReglasListaNumerosDTO[] retornoPlList=null;		
			ResultSet rs=(ResultSet)cstmt.getObject(2);			
			 
			
			while(rs.next())
			{					
				dto=new ReglasListaNumerosDTO();
			    dto.setCodPerfilLista(rs.getString("COD_PERFIL_LISTA")!=null?rs.getString("COD_PERFIL_LISTA"):"");
			    dto.setCodCategoriaDestino(rs.getString("COD_CATEGORIA_DESTINO")!=null?rs.getString("COD_CATEGORIA_DESTINO"):"");
			    dto.setCantidadMaxima(rs.getString("NUM_MAXIMO")!=null?rs.getString("NUM_MAXIMO"):"");
				retornoPL.add(dto);
			}
			retornoPlList=(ReglasListaNumerosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), ReglasListaNumerosDTO.class);
			retorno=new ReglasListaNumerosListDTO();
			retorno.setReglaLisNumList(retornoPlList);
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Reglas Validacion", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener Reglas Validacion",e);
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
		logger.debug("obtenerReglasValidacion():end");
		return retorno;	
	}

	public EspecServicioListaListDTO obtenerEspecServicioLista(EspecServicioClienteListDTO especServClieList) throws ServiceSpecEntitiesException 
	{
		logger.debug("obtenerEspecServicioLista():start");		
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EspecServicioListaListDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;		
		
		String call = this.getSQLobtenerEspecServicioLista();
		
		if(especServClieList==null)
		{
			logger.debug("Parametros de entrada no llenados correctamente");		
			return null;
		}
		
		try {
			
			logger.debug("especServClieList[" + especServClieList + "]");
			
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());			
			cstmt = (OracleCallableStatement)conn.prepareCall(call);
			
			StructDescriptor sd = StructDescriptor.createDescriptor("SE_PERFIL_LISTA_TD_QT", conn);
			
			ArrayDescriptor ad=null;
			ARRAY aux =null;
			
			STRUCT[] arreglo=especServClieList.getOracleArray_SE_PERFIL_LISTA_TD_LST_QT(sd, conn);
			
			
			ad = ArrayDescriptor.createDescriptor("SE_PERFIL_LISTA_TD_LST_QT", conn);
			aux = new ARRAY(ad, conn, arreglo);
			
			// SE LLENAN PARAMETROS SEGUN PL
			cstmt.setARRAY(1, aux);			
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
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			ArrayList retornoPL = new ArrayList();
			EspecServicioListaDTO dto=null; 
			EspecServicioListaDTO[] retornoPlList=null;		
			ResultSet rs=(ResultSet)cstmt.getObject(2);			
			retorno = new EspecServicioListaListDTO();
			
			while(rs.next())
			{				
				dto=new EspecServicioListaDTO();
				dto.setIdPerfilList(rs.getString("COD_PERFIL_LISTA")!=null?rs.getString("COD_PERFIL_LISTA"):"");
				dto.setNomPerfil(rs.getString("ID_PERFIL_LISTA")!=null?rs.getString("ID_PERFIL_LISTA"):"");
				dto.setDesPerfil(rs.getString("DES_PERFIL_LISTA")!=null?rs.getString("DES_PERFIL_LISTA"):"");				
				dto.setIndTipoPlataforma(rs.getString("TIPO_PLATAFORMA")!=null?rs.getString("TIPO_PLATAFORMA"):"");
				dto.setFecIniVig(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate("FEC_INICIO_VIGENCIA"):new Date());
				dto.setFecTerVig(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate("FEC_TERMINO_VIGENCIA"):new Date());
				dto.setNumMaximoLista(rs.getString("NUM_MAXIMO_LISTA")!=null?rs.getString("NUM_MAXIMO_LISTA"):"");
				dto.setIndTipoComportamiento(rs.getString("TIPO_COMPORTAMIENTO")!=null?rs.getString("TIPO_COMPORTAMIENTO"):"");
				dto.setIndAutoAfinidad(rs.getString("FLG_AUTO_AFIN")!=null?rs.getString("FLG_AUTO_AFIN"):"");
				retornoPL.add(dto);
			}
			
			retornoPlList=(EspecServicioListaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), EspecServicioListaDTO.class);
			retorno.setEspecServicioListaList(retornoPlList);			
			
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Reglas Validacion", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener Reglas Validacion",e);
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
		logger.debug("obtenerEspecServicioLista():end");
		return retorno;	
	}

}

