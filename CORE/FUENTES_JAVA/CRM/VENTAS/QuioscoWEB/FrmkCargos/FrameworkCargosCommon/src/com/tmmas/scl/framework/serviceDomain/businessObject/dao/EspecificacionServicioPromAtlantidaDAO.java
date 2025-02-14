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
 * 04-07-2007     			 Esteban Conejeros              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.OracleCallableStatement;
import oracle.sql.ARRAY;
import oracle.sql.ArrayDescriptor;
import oracle.sql.STRUCT;
import oracle.sql.StructDescriptor;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionServicioPromAtlantidaDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecPromAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecPromAtlantidaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionServicioPromAtlantidaDAO extends ConnectionDAO implements EspecificacionServicioPromAtlantidaDAOIT
{
	private final Logger logger = Logger.getLogger(EspecificacionServicioAltamiraDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLobtenerEspecServicioPromocion() 
	{
		StringBuffer call = new StringBuffer();		
		call.append(" DECLARE ");
		call.append("   EO_PLANES_ATL SE_PLANES_ATLANTIDA_TD_LST_QT; ");
		call.append("   SO_PLANES_ATL_CUR SE_ATLANTIDA_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN   ");
		call.append("   SE_ATLANTIDA_PG.SE_SERVICIO_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");
		return call.toString();		
	}

	public EspecPromAtlantidaListDTO obtenerEspecServicioAtlantida(EspecServicioClienteListDTO espServCltList) throws ServiceSpecEntitiesException { 
		logger.debug("obtenerEspecServicioPromocion():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EspecPromAtlantidaListDTO retorno = new EspecPromAtlantidaListDTO();		
		Connection conn = null;
		OracleCallableStatement cstmt = null;		
		
		String call = getSQLobtenerEspecServicioPromocion();
		try {
			
			logger.debug("espServCltList.getEspServCliList() [" + espServCltList.getEspServCliList() + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			cstmt = (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("SE_PLANES_ATLANTIDA_TD_QT", conn);
			
			ArrayDescriptor ad=null;
			ARRAY aux =null;
			STRUCT[] arreglo=espServCltList.getOracleArray_SE_PLANES_ATLANTIDA_TD_LST_QT(sd, conn);
			
			ad = ArrayDescriptor.createDescriptor("SE_PLANES_ATLANTIDA_TD_LST_QT", conn);
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
				logger.error(" Ocurrió un error al obtener Especificacion Servicio Promocion");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			//retorno = new EspecPromAtlantidaListDTO();
			ArrayList retornoPL = new ArrayList();
			EspecPromAtlantidaDTO[] especPromAtlantidaListFull;			
			EspecPromAtlantidaDTO dto=null;
			
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			
			while(rs.next())
			{
				dto=new EspecPromAtlantidaDTO();
				//A.COD_PLAN_ATL, A.NOM_PLAN_ATL, A.DES_PLAN_ATL, A.COD_ATLANTIDA, A.IND_TIPO_PLATAFORMA
				dto.setIdCodPlanAtl(rs.getString("COD_PLAN_ATL")!=null?rs.getString("COD_PLAN_ATL"):"");
				dto.setNombrePlanAtl(rs.getString("NOM_PLAN_ATL")!=null?rs.getString("NOM_PLAN_ATL"):"");
				dto.setDescripcionPlanAtl(rs.getString("DES_PLAN_ATL")!=null?rs.getString("DES_ESPEC_PROD"):"");
				dto.setCodAtl(rs.getString("COD_ATLANTIDA")!=null?rs.getString("COD_ATLANTIDA"):"");
				dto.setTipoPlataforma(rs.getString("IND_TIPO_PLATAFORMA")!=null?rs.getString("IND_TIPO_PLATAFORMA"):"");
				retornoPL.add(dto);
			}			
			
			especPromAtlantidaListFull = (EspecPromAtlantidaDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), EspecPromAtlantidaDTO.class);
			retorno.setEspPromAtlaList(especPromAtlantidaListFull);
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Especificacion Servicio Promocion", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener Especificacion Servicio Promocion",e);
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
		logger.debug("obtenerEspecServicioPromocion():end");
		return retorno;		
	}

}
