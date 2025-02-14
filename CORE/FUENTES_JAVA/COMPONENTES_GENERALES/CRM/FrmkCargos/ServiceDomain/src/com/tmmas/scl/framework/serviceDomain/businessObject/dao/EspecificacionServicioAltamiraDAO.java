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
 * 04-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.dao;

import java.sql.CallableStatement;
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
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionServicioAltamiraDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioAltamiraDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioAltamiraListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.FreqAltamiraListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionServicioAltamiraDAO extends ConnectionDAO implements EspecificacionServicioAltamiraDAOIT
{
	private final Logger logger = Logger.getLogger(EspecificacionServicioAltamiraDAO.class);
	private final Global global = Global.getInstance();
	
	private String getSQLcrear() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	private String getSQLnotificar() {
		StringBuffer call = new StringBuffer();
		//AGREGAR INVOCACION A PL
		return call.toString();		
	}
	
	private String getSQLobtenerEspecServicioAltamira() {
		StringBuffer call = new StringBuffer();
		call.append(" DECLARE "); 
		call.append("   EO_PLANES_AA SE_PLANES_ALTAMIRA_TD_LST_QT; ");
		call.append("   SO_PLANES_AA_CUR SE_ALTAMIRA_PG.refCursor; ");
		call.append("   SN_COD_RETORNO NUMBER; ");
		call.append("   SV_MENS_RETORNO VARCHAR2(200); ");
		call.append("   SN_NUM_EVENTO NUMBER; ");
		call.append(" BEGIN ");
		call.append("   SE_ALTAMIRA_PG.SE_SERVICIO_S_PR(?,?,?,?,?); ");    
		call.append(" END; ");				
		return call.toString();		
	}
	
	public RetornoDTO crear(FreqAltamiraListDTO listFrecAlt) throws ServiceSpecEntitiesException 
	{
		logger.debug("crear():start");
		
		System.out.println("BO 2 "+logger.toString());
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLcrear();
		
		
		try {
			
			logger.debug("listFrecAlt.getFreqAltamiraList().toString()[" + listFrecAlt.getFreqAltamiraList().toString() + "]");
			
			System.out.println("BO 3"+global.getJndiForDataSource());
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			System.out.println("BO 4");
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
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			
			System.out.println("EspecificacionServicioAltamiraDAO DAO [OK]");
			retorno.setCodigo("1");
			retorno.setDescripcion("LLEGO OK");
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al eliminar fin ciclo",e);
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
		logger.debug("crear():end");
		return retorno;		
	}

	public RetornoDTO notificar(VentaDTO venta) throws ServiceSpecEntitiesException 
	{
		logger.debug("notificar():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		RetornoDTO retorno = null;		
		Connection conn = null;
		CallableStatement cstmt = null;
		
		String call = getSQLnotificar();
		try {
			
			logger.debug("venta.getIdVenta()[" + venta.getIdVenta() + "]");
			
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
			System.out.println("EspecificacionServicioAltamiraDAO DAO [OK]");
			retorno.setCodigo("1");
			retorno.setDescripcion("LLEGO OK");
			
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
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new RetornoDTO();
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al eliminar fin ciclo", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al eliminar fin ciclo",e);
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
		logger.debug("notificar():end");
		return retorno;		
	}
	public EspecServicioAltamiraListDTO obtenerEspecServicioAltamira(EspecServicioClienteListDTO espSerCliList) throws ServiceSpecEntitiesException {

		logger.debug("obtenerEspecServicioAltamira():start");
		
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		EspecServicioAltamiraListDTO retorno = null;		
		Connection conn = null;
		OracleCallableStatement cstmt = null;	
		
		String call = getSQLobtenerEspecServicioAltamira();
		try {
			
			logger.debug("espSerCliList[" + espSerCliList + "]");
			
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
			
			cstmt = (OracleCallableStatement) conn.prepareCall(call);
			StructDescriptor sd = StructDescriptor.createDescriptor("SE_PLANES_ALTAMIRA_TD_QT", conn);
			
			ArrayDescriptor ad=null;
			ARRAY aux =null;
			
			STRUCT[] arreglo=espSerCliList.getOracleArray_SE_PLANES_ALTAMIRA_TD_LST_QT(sd, conn);			
			ad = ArrayDescriptor.createDescriptor("SE_PLANES_ALTAMIRA_TD_LST_QT", conn);
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
				logger.error(" Ocurrió un error al crear la lista de numeros");
				throw new ServiceSpecEntitiesException(String.valueOf(codError),numEvento, msgError);
			}
			
			//obtener info del cliente y completar respuesta
			logger.debug("Recuperando data...");
			//ini--------------RESCATAR RETORNO-------
			retorno = new EspecServicioAltamiraListDTO();
			ArrayList retornoPL = new ArrayList();
			EspecServicioAltamiraDTO[] especPromAltamiraListFull;			
			EspecServicioAltamiraDTO dto=null;
			
			ResultSet rs = (ResultSet) cstmt.getObject(2);
			
			while(rs.next())
			{
				
				dto=new EspecServicioAltamiraDTO();				
				dto.setIdPlanAltamira(rs.getString("COD_PLAN_ALTAMIRA")!=null?rs.getString("COD_PLAN_ALTAMIRA"):"");
				dto.setDesPlanAltamira(rs.getString("DES_PLAN_ALTAMIRA")!=null?rs.getString("DES_PLAN_ALTAMIRA"):"");
				dto.setTipoPlataforma(rs.getString("TIPO_PLATAFORMA")!=null?rs.getString("TIPO_PLATAFORMA"):"");				
				dto.setFecInicioVigencia(rs.getDate("FEC_INICIO_VIGENCIA")!=null?rs.getDate("FEC_INICIO_VIGENCIA"):new Date());
				dto.setFecTerminoVigencia(rs.getDate("FEC_TERMINO_VIGENCIA")!=null?rs.getDate("FEC_TERMINO_VIGENCIA"):new Date());								
				dto.setTipoPlanAltamira(rs.getString("TIPO_PLAN_ALTAMIRA")!=null?rs.getString("TIPO_PLAN_ALTAMIRA"):"");				
				dto.setCodListaAltamira(rs.getString("COD_LISTA_ALTAMIRA")!=null?rs.getString("COD_LISTA_ALTAMIRA"):"");
				dto.setCantidadBonificada(rs.getString("CAN_BONIFICAR")!=null?rs.getString("CAN_BONIFICAR"):"");
				dto.setTipoUnidadBonificacion(rs.getString("TIPO_UNIDAD_BONIFICAR")!=null?rs.getString("TIPO_UNIDAD_BONIFICAR"):"");
				retornoPL.add(dto);
			}			
			
			especPromAltamiraListFull = (EspecServicioAltamiraDTO[]) ArrayUtl.copiaArregloTipoEspecifico(retornoPL.toArray(), EspecServicioAltamiraDTO.class);
			retorno.setEspServAltList(especPromAltamiraListFull);
			//fin----------------------------------------------------------------------
		
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			throw e;
			
		}
		catch (Exception e) {
			logger.error("Ocurrió un error general al obtener Espec Servicio Altamira", e);
			throw new ServiceSpecEntitiesException("Ocurrió un error general al obtener Espec Servicio Altamira",e);
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
		logger.debug("obtenerEspecServicioAltamira():end");
		return retorno;
	}
	
}
