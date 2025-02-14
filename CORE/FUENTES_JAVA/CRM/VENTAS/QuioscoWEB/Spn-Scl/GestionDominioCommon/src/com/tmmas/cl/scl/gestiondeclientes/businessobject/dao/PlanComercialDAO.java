package com.tmmas.cl.scl.gestiondeclientes.businessobject.dao;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import oracle.jdbc.driver.OracleTypes;

import org.apache.log4j.Category;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.PlanComercialDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.SumaPrecioPlanesDTO;
import com.tmmas.cl.scl.gestiondeclietnes.businessobject.helper.Global;


public class PlanComercialDAO extends ConnectionDAO{
	
	private final Logger logger = Logger.getLogger(PlanComercialDAO.class);

	Global global = Global.getInstance();
	
	private Connection getConection() throws GeneralException
	{
		Connection conn = null;
		try {
			conn = getConnectionFromWLSInitialContext(global.getJndiForDataSource());
		} catch (Exception e1) {
			conn = null;
			logger.error(" No se pudo obtener una conexión ", e1);
			throw new GeneralException("No se pudo obtener una conexión", e1);
		}
		return conn;
	}//fin getConection
	
	private String getSQLDatosPlanComercial(String packageName, String procedureName, int paramCount)
	{
		StringBuffer sb = new StringBuffer("{call "+packageName+"."+procedureName+"(");
        for (int n = 1; n <= paramCount; n++) {
            sb.append("?");
            if (n < paramCount) sb.append(",");
        }
        return sb.append(")}").toString();
	}//fin getSQLDatosPlanComercial

    /**
	 * Obtiene plan comercial
	 * @param parametroEntrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public PlanComercialDTO getPlanComercial(PlanComercialDTO parametroEntrada) 
	throws GeneralException{
		PlanComercialDTO resultado=new PlanComercialDTO();
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getPlanComercial");
			
			//INI-01 (AL) String call = getSQLDatosPlanComercial("VE_alta_cliente_PG","VE_getPlanComercial_PR",6);
			String call = getSQLDatosPlanComercial("VE_alta_cliente_Quiosco_PG","VE_getPlanComercial_PR",6);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setString(1,parametroEntrada.getCodigoCalifCliente());
			cstmt.registerOutParameter(2, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(3, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getPlanComercial:execute");
			cstmt.execute();
			logger.debug("Fin:getPlanComercial:execute");

			codError  = cstmt.getInt(4);
			msgError  = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al obtener plan comercial");
				throw new GeneralException(
				"Ocurrió un error al obtener plan comercial", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				resultado.setCodigoPlanComercial(cstmt.getInt(2));
				resultado.setDescripcionPlanComercial(cstmt.getString(3));
			}
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener plan comercial",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new GeneralException(
						"Ocurrió un error al obtener plan comercial", String
						.valueOf(codError), numEvento, msgError);				
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getPlanComercial");
		return resultado;
	}//fin getPlanComercial

	/**
	 * Obtiene listado de planes comerciales segun calificacion del cliente
	 * @param N/A
	 * @return clienteDTO[]
	 * @throws CustomerDomainException
	 */
	public PlanComercialDTO[] getListPlanComercialCalCte(PlanComercialDTO entrada) 
	throws GeneralException{
		logger.debug("Inicio:getListPlanComercialCalCte()");
		PlanComercialDTO[] resultado = null;
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt =null;
		try {
			//INI-01 (AL) String call = getSQLDatosPlanComercial("VE_alta_cliente_PG","VE_getListPlanComCalCte_PR",5);
			String call = getSQLDatosPlanComercial("VE_alta_cliente_Quiosco_PG","VE_getListPlanComCalCte_PR",5);

			logger.debug("sql[" + call + "]");
			
			cstmt = conn.prepareCall(call);
			
			cstmt.setString(1,entrada.getCodigoCalifCliente());
			cstmt.registerOutParameter(2,OracleTypes.CURSOR);
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(5, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getListPlanComercialCalCte:execute");
			cstmt.execute();
			logger.debug("Fin:getListPlanComercialCalCte:execute");

			codError = cstmt.getInt(3);
			msgError = cstmt.getString(4);
			numEvento = cstmt.getInt(5);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0) {
				logger.error("Ocurrió un error al recuperar listado de planes comerciales segun calificacion del cliente");
				throw new GeneralException(
						"Ocurrió un error al recuperar listado de planes comerciales segun calificacion del cliente", String
								.valueOf(codError), numEvento, msgError);
			}else{
				logger.debug("Recuperando listado de planes comerciales segun calificacion del cliente");
				ArrayList lista = new ArrayList();
				ResultSet rs = (ResultSet) cstmt.getObject(2);
				while (rs.next()) {
					PlanComercialDTO planComercialDTO = new PlanComercialDTO();
					planComercialDTO.setCodigoPlanComercial(rs.getInt(1));
					planComercialDTO.setDescripcionPlanComercial(rs.getString(2));
					lista.add(planComercialDTO);
				}
				rs.close();
				resultado =(PlanComercialDTO[]) ArrayUtl.copiaArregloTipoEspecifico(
					lista.toArray(), PlanComercialDTO.class);
				
			}
			if (logger.isDebugEnabled()) {
				logger.debug(" Finalizo ejecución");
				logger.debug(" Recuperando salidas");
			}
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al recuperar listado de planes comerciales segun calificacion del cliente",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new GeneralException(
						"Ocurrió un error al obtener plan comercial", String
						.valueOf(codError), numEvento, msgError);				
			}
		} finally {
		 	if (logger.isDebugEnabled()) 
				logger.debug("Cerrando conexiones...");
			try {
				if (cstmt!=null)
					cstmt.close();
				if (!conn.isClosed()) {
					conn.close();
				}
			} catch (SQLException e) {
				logger.debug("SQLException", e);
			}
		}
		logger.debug("Fin:getListPlanComercialCalCte()");
		return resultado;
	}//fin getListPlanComercialCalCte
	
	public SumaPrecioPlanesDTO getSumaPrecioPlanesXAntiguedad(SumaPrecioPlanesDTO sumaPrecioPlanesDTO) 
	throws GeneralException{
		int codError = 0;
		String msgError = null;
		int numEvento = 0;
		Connection conn = null;
		conn = getConection();
		CallableStatement cstmt = null; 
		try {
			logger.debug("Inicio:getSumaPrecioPlanesXAntiguedad");
			

			String call = getSQLDatosPlanComercial("GE_CONS_CATALOGO_PORTAB_PG","ge_suma_planes_x_antiguedad_pr",6);

			logger.debug("sql[" + call + "]");

			cstmt = conn.prepareCall(call);
			cstmt.setInt(1,Integer.parseInt(sumaPrecioPlanesDTO.getCodCliente()));
			cstmt.setInt(2,sumaPrecioPlanesDTO.getMeses());
			cstmt.registerOutParameter(3, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(4, java.sql.Types.NUMERIC);
			cstmt.registerOutParameter(5, java.sql.Types.VARCHAR);
			cstmt.registerOutParameter(6, java.sql.Types.NUMERIC);
			
			logger.debug("Inicio:getSumaPrecioPlanesXAntiguedad:execute");
			cstmt.execute();
			logger.debug("Fin:getSumaPrecioPlanesXAntiguedad:execute");

			codError  = cstmt.getInt(4);
			msgError  = cstmt.getString(5);
			numEvento = cstmt.getInt(6);
			
			logger.debug("Codigo de Error[" + codError + "]");
			logger.debug("Mensaje de Error[" + msgError + "]");
			logger.debug("Numero de Evento[" + numEvento + "]");
			
			if (codError != 0){
				logger.error("Ocurrió un error al consultar la suma de los planes contratados");
				throw new GeneralException(
				"Ocurrió un error al consultar la suma de los planes contratados", String
				.valueOf(codError), numEvento, msgError);
			}
			else{
				sumaPrecioPlanesDTO.setSumaPlanes(cstmt.getInt(3));
			}
		
		} catch (GeneralException e) {
			throw e;
		} catch (Exception e) {
			logger.error("Ocurrió un error al obtener plan comercial",e);
			if (logger.isDebugEnabled()) {
				logger.debug("Codigo de Error[" + codError + "]");
				logger.debug("Mensaje de Error[" + msgError + "]");
				logger.debug("Numero de Evento[" + numEvento + "]");
				throw new GeneralException(
						"Ocurrió un error al consultar la suma de los planes contratados", String
						.valueOf(codError), numEvento, msgError);				
			}
		} finally {
				logger.debug("Cerrando conexiones...");
	    try {
	    	cstmt.close();
			if (!conn.isClosed()) {
				conn.close();
			}
		  } catch (SQLException e) {
				logger.debug("SQLException", e);
		  }
		}
		logger.debug("Fin:getSumaPrecioPlanesXAntiguedad");
		return sumaPrecioPlanesDTO;
	}
}//fin PlanComercialDAO
