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
 * 16/01/2007     H&eacute;ctor Hermosilla      					Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeabonados.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.CampanaVigenteDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.helper.Global;


public class CampanaVigenteDAO extends ConnectionDAO{
	private static Category cat = Category.getInstance(CampanaVigenteDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			cat.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		
		return conn;
	}
	
	private String getSQLDatosCampana(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}
	
	private CampanaVigenteDTO getResultset(ResultSet rs, int i) throws GeneralException
	{
		CampanaVigenteDTO plans = new CampanaVigenteDTO();
		try
		{
			if(global.ModoEjecucion().equals("prueba1"))
			{
				plans.setCodigoCampanasVigentes("codPlans"+i);
				plans.setDescripcionCampanasVigentes("desPlans"+i);
			}
			else
			{
				plans.setCodigoCampanasVigentes(rs.getString(1));
				plans.setDescripcionCampanasVigentes(rs.getString(2));
			}
		}
		catch(SQLException e)
		{
			throw new GeneralException(global.errorgetListado() +  " [" + i + "]", e);
		}
		return plans;
	}

	public CampanaVigenteDTO[] getListadoCampanaVigente() throws GeneralException{
		cat.debug("getListadoCampanasVigentes:start");
		CampanaVigenteDTO[] resultado=null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		CallableStatement cstmt = null;
		conn = getConection();
		cat.debug("Coneccion obtenida OK");
		try {
			if(global.ModoEjecucion().equals("prueba1"))
			{
				ArrayList lista = new ArrayList();
				for(int i=0;i<=1080;i++)
				{
					cat.debug("Procesando iteración :" + i);
	
					CampanaVigenteDTO  CampanasVigentes = null;
					CampanasVigentes = getResultset(null, i);
					lista.add(CampanasVigentes);
				}
				resultado =(CampanaVigenteDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CampanaVigenteDTO.class);
			}
			else
			{
				//INI-01 (AL) String call = getSQLDatosCampana("VE_PARAMETROS_COMERCIALES_PG","VE_campanavigente_PR",4);
				String call = getSQLDatosCampana("VE_PARAMETROS_COMER_QUIOSCO_PG","VE_campanavigente_PR",4);
	
				cat.debug("sql[" + call + "]");
	
				cstmt = conn.prepareCall(call);
				cstmt.registerOutParameter(1, OracleTypes.CURSOR);
				cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
				cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
				cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);

				cat.debug("Execute Antes");
				cstmt.execute();
				cat.debug("Execute Despues");
				
				codError = cstmt.getInt(2);
				msgError = cstmt.getString(3);
				numEvento = cstmt.getInt(4);
				
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
				
				if (codError != 0) {
					cat.error("Ocurrió un error al recuperar campañas vigentes");
					throw new GeneralException(
							"Ocurrió un error al recuperar campañas vigentes", String
									.valueOf(codError), numEvento, msgError);
				}else{
				
					ResultSet rs = (ResultSet) cstmt.getObject(1);
					ArrayList lista = new ArrayList();
					while (rs.next()) {
						cat.debug("Procesando iteración :" + lista.size());
						CampanaVigenteDTO CampanasVigentes = null;
						CampanasVigentes= getResultset(rs, lista.size());
						lista.add(CampanasVigentes);
					}
					resultado =(CampanaVigenteDTO[])ArrayUtl.copiaArregloTipoEspecifico(lista.toArray(), CampanaVigenteDTO.class);
					rs.close();
					}
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error(global.errorgetListado(), e);
			throw new GeneralException(global.errorgetListado(), e);

		 } finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("getListadoCampanasVigentes():end");
		return resultado;
	}//fin getListadoCampanasVigentes

	/**
	 * Obtiene campañas vigentes postpago
	 * @param N/A
	 * @return CampanaVigenteDTO[]
	 * @throws GeneralException
	 */
	public CampanaVigenteDTO[] getListCampVigentesPostpago() 
	throws GeneralException{
		cat.debug("Inicio:getListCampVigentesPostpago()");
		CampanaVigenteDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			String call = getSQLDatosCampana("BP_servicios_benefpromo_PG","BP_getListCampVigPostpago_PR",4);

			cat.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.registerOutParameter(1,OracleTypes.CURSOR);
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.execute();
			
			codError = cstmt.getInt(2);
			msgError = cstmt.getString(3);
			numEvento = cstmt.getInt(4);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al recuperar campañas vigentes postpago");
				throw new GeneralException(
						"Ocurrió un error al recuperar campañas vigentes postpago", String
								.valueOf(codError), numEvento, msgError);
			}else{
				cat.debug("Recuperando campañas vigentes postpago");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(1);
				while (rs.next()) {
					CampanaVigenteDTO campanaDTO = new CampanaVigenteDTO();
					campanaDTO.setCodigoCampanasVigentes(rs.getString(1));
					campanaDTO.setDescripcionCampanasVigentes(rs.getString(2));
					campanaDTO.setAplicaA(rs.getString(3));
					
					lista.add(campanaDTO);
				}
				resultado =(CampanaVigenteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), CampanaVigenteDTO.class);
				rs.close();
			}
			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		}catch (Exception e) {
			cat.error("Ocurrió un error al recuperar campañas vigentes postpago",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		 } finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:getListCampVigentesPostpago()");
		return resultado;
	}//fin getListCampVigentesPostpago	

	/**
	 * Registra campaña vigente para el cliente
	 * @param entrada
	 * @return N/A
	 * @throws GeneralException
	 */
	public void registraCampanaVigente(CampanaVigenteDTO entrada) 
	throws GeneralException{
		cat.debug("Inicio:registraCampanaVigente");
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null;
		cat.debug("Coneccion obtenida OK");
		try {
			String call = getSQLDatosCampana("BP_servicios_benefpromo_PG","BP_registra_campana_PR",6);
			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cat.debug("entrada.getCodigoCampanasVigentes()" + entrada.getCodigoCampanasVigentes());
			cstmt.setString(1,entrada.getCodigoCampanasVigentes());
			cat.debug("entrada.getCodigoCliente()" + entrada.getCodigoCliente());
			cstmt.setLong(2,entrada.getCodigoCliente());
			cat.debug("entrada.getNumeroAbonado()" + entrada.getNumeroAbonado());
			cstmt.setLong(3,entrada.getNumeroAbonado());
			
			cstmt.registerOutParameter(4,java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5,java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6,java.sql.Types.NUMERIC);
			
			cat.debug("Iniico:registraCampanaVigente:Execute");
			cstmt.execute();
			cat.debug("Fin:registraCampanaVigente:Execute");

			codError = cstmt.getInt(4);
			msgError = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");

			if (codError != 0) {
				cat.error("Ocurrió un error al registrar campaña vigente para el cliente");
				throw new GeneralException(
						"Ocurrió un error al registrar campaña vigente para el cliente", String
								.valueOf(codError), numEvento, msgError);
			}

			if (cat.isDebugEnabled()) {
				cat.debug(" Finalizo ejecución");
				cat.debug(" Recuperando salidas");
			}
		}catch (GeneralException e) {
			throw e;
		}catch (Exception e) {
			cat.error("Ocurrió un error al registrar campaña vigente para el cliente",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
		} finally {
		 	if (cat.isDebugEnabled()) 
				cat.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				cat.debug("SQLException", e);
			}
		}
		cat.debug("Fin:registraCampanaVigente()");
	}//fin registraCampanaVigente

	/**
	 * Obtiene datos campaña
	 * @param entrada
	 * @return resultado
	 * @throws GeneralException
	 */
	public CampanaVigenteDTO getCampanaVigente(CampanaVigenteDTO entrada) 
	throws GeneralException{
		CampanaVigenteDTO resultado = new CampanaVigenteDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			cat.debug("Inicio:getCampanaVigente");
			
			String call = getSQLDatosCampana("BP_servicios_benefpromo_PG","VE_getCampana_PR",5);

			cat.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,entrada.getCodigoCampanasVigentes());
			cstmt.registerOutParameter(2, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			cat.debug("Inicio:getCampanaVigente:execute");
			cstmt.execute();
			cat.debug("Fin:getCampanaVigente:execute");

			msgError = cstmt.getString(4);
			codError=cstmt.getInt(3);
			numEvento=cstmt.getInt(5);
			
			cat.debug("Codigo de Error[" + codError + "]");
			cat.debug("Mensaje de Error[" + msgError + "]");
			cat.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				cat.error("Ocurrió un error al obtener tipo entidad de la campaña");
				throw new GeneralException(
						"Ocurrió un error al obtener tipo entidad de la campaña", String
								.valueOf(codError), numEvento, msgError);
			}
			else
				resultado.setAplicaA(cstmt.getString(2));
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			cat.error("Ocurrió un error al obtener tipo entidad de la campaña",e);
			if (cat.isDebugEnabled()) {
				cat.debug("Codigo de Error[" + codError + "]");
				cat.debug("Mensaje de Error[" + msgError + "]");
				cat.debug("Numero de Evento[" + numEvento + "]");
			}
			throw new GeneralException(
					"Ocurrió un error al obtener tipo entidad de la campaña",e);
		} finally {
				cat.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				cat.debug("SQLException", e);
		  }
		}
		cat.debug("Fin:getCampanaVigente");
		return resultado;
	}//fin getCampanaVigente
	
}//fin class CampanaVigenteDAO


